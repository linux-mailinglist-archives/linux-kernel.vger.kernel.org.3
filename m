Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8177852772A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiEOK4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiEOKzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:55:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78013E0F7
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:55:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33179B80C9D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 10:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B50C385B8;
        Sun, 15 May 2022 10:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652612150;
        bh=eMzgbuvzHahLRRnZiAI5LEHuxl1LzYgVFGtZA2pB6tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvYbqowRbwZoV4bF7hG1pAbBnSdM08U6VcUIEYA9GhPplOBrU55E+ph4FeU1cClds
         8fH9eHRZ43hkBRgRLr2SIVkkwXy4Csj1hUUkTg+mpq0AMG78j0E71JuJHjypQrXeJs
         wfD28+g9vm0soGoo7nwFnHscVlxlnZ5rUetw4EzY=
Date:   Sun, 15 May 2022 12:55:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?WWHFn2FyIEFyYWJhY8Sx?= <yasar11732@gmail.com>
Cc:     paulo.miguel.almeida.rodenas@gmail.com, dan.carpenter@oracle.com,
        alexandre.belloni@bootlin.com, realwakka@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: pi433: Don't use ioctl for per-client
 configuration
Message-ID: <YoDcMmcnbPjk4uuV@kroah.com>
References: <20220515104711.94567-1-yasar11732@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220515104711.94567-1-yasar11732@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 01:47:11PM +0300, Yaşar Arabacı wrote:
> Currently this driver uses ioctl for reading/writing per-device and
> per-client configuration. Per-client configuration can be handled by
> usespace and sent to driver with each write() call. Doing so does not
> introduce extra overhead because we copy tx config to fifo for each
> transmit anyway. This way, we don't have to introduce new ioctl's.

Wait, you just changed the user api of the write/read call to the
driver?  That's dangerous, especially:

> This has not been tested as I don't have access to hardware.

That's not good.  You need to figure out what userspace tool(s) use this
api and ensure that you did not just break them for no good reason.

thanks,

greg k-h
