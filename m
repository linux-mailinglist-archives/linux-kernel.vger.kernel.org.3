Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1C55AC2F9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 08:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiIDGUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 02:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiIDGUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 02:20:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A95327CCF;
        Sat,  3 Sep 2022 23:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32EAFB80C0A;
        Sun,  4 Sep 2022 06:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2B5C433D6;
        Sun,  4 Sep 2022 06:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662272412;
        bh=RE8YCa7OO1bHEGDf3RNzYclTV7vEm+CT+3ycRThtJMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mDEctBveSUQtpguSZXKO4r7sABUOINuxfcCPeNG0nduSxARwMJgrON5vf4wMVqyuv
         pGM3MggMqLbxkj/UB/2BO7NklL+pMRfbJzZiZ0UAieQYjgOCPGYjx+6bK4NTdBTTn/
         nKeLvxCW274XUUSDkgoPaaLF/PTnKE2/W9Lq/L4I=
Date:   Sun, 4 Sep 2022 08:20:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org
Subject: Re: [PATCH v3] drivers/tty/serial: check the return value of
 uart_port_check()
Message-ID: <YxRDmX76WsjxuGzC@kroah.com>
References: <20220904004524.2281227-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904004524.2281227-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 05:45:24PM -0700, Li Zhong wrote:
> uart_port_check() will return NULL pointer when state->uart_port is
> NULL. Check the return value before dereference it to avoid
> null-pointer-dereference error because the locking does not guarantee
> the return value is not NULL. Here we do not need unlock in the error
> handling because the mutex_unlock() is called in callers.
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
> 
> v3: Add the reason why we need to check the NULL value in the commit
> message.  The bug is detected by static analysis.

Great, then please follow the rules in
Documentation/process/researcher-guidelines.rst and identify the tools
you are using as well as everything else listed there.

thanks,

greg k-h
