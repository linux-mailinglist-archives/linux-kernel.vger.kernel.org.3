Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DD554B372
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbiFNOiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbiFNOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2F2219C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0925A617B4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F83C341C5;
        Tue, 14 Jun 2022 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655217479;
        bh=O2hbvfNL0U6Gmj0eop3EmGulD+25t5gAdtIX+9CBfQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFnZLvAlOH/yTshr/sU1racHeo+FJeOgTGdUeJHAXuDdDBirIOe7KNfsgE54UM7sK
         UL6jLQFZkepRwDKZz80O+jKU8EaELoF8aNIYq5XvgUMvgJ/R+5NGk9kpOyO9wMQNLT
         Gl6MJavgc6rY5sYVd3mVpBm7s0X4GjAq5L9fX0ZU=
Date:   Tue, 14 Jun 2022 16:37:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhi Song <zhi.song@bytedance.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] node: put_device after failing to device_register
Message-ID: <YqidROu44rHFaI6w@kroah.com>
References: <20220614143007.1730171-1-zhi.song@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614143007.1730171-1-zhi.song@bytedance.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:30:07PM +0800, Zhi Song wrote:
> device_register() is used to register a device with the system.
> 
> We cannot directly free dev after calling this function,
> even if it returns an error.

the device is not being freed, why say this?

And you do have a full 72 columns to use :)

> 
> We should use put_device() to give up the reference
> initialized in this function instead.

There is no "instead" happening here.  The patch looks correct, but this
changelog text does not.  Please fix up.

thanks,

greg k-h
