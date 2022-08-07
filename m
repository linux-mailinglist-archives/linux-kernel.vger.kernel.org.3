Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3658B9F3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 08:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiHGG6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiHGG6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 02:58:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF619FE6;
        Sat,  6 Aug 2022 23:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 13A03CE0A4D;
        Sun,  7 Aug 2022 06:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F015C433D6;
        Sun,  7 Aug 2022 06:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659855483;
        bh=XdPD/hTZLSeGJ/2XPd6cihsbI9pncKW8h0z0JEzGYNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeWQp+fwgRPLG5XVLIbdeP548dY5u+e0Fetj3U78s11+MEx1EjxHDM3UPx2PaaWzG
         NI7/YE1LFKtgvDQOEVIurT4bM+ZK7XydIB8MKFO7UROGzxTFTxI791dqyHdbg3rxUT
         4Kk3GXSS84zuLHWztvKUqzJgxKldyWB8xSV8i2/o=
Date:   Sun, 7 Aug 2022 08:57:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
Subject: Re: Question: dev_err_probe() vs Printk Index
Message-ID: <Yu9id1O98e6or1qm@kroah.com>
References: <3eacc364-90b7-7a5d-c936-1ed993428ef6@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eacc364-90b7-7a5d-c936-1ed993428ef6@wanadoo.fr>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 10:53:16AM +0200, Christophe JAILLET wrote:
> Hi,
> 
> When a driver is using dev_err(), part of it is inlined and it:
>    - takes advantage of dev_fmt()  [1]
>    - implements Printk Index       [2]
> 
> Printk Index works with some __builtin_constant_p() magic in it.
> In case of a use in a probe, 99.99% of the time the log level and the format
> will be constant and the logic for Printk Index will be put in place.
> 
> 
> In case dev_err_probe(), the format will be an argument passed to the
> function and will not be constant, so nothing will be generated in the
> 'printk'_index section.
> 
> 
> In case dev_err_probe(), a potential dev_fmt() defined in the drivers' file
> can't be taken into consideration.
> (trusting my grep, we never use in files that define dev_fmt() in the .c
> file. I've not checked if it is true via #include "<something.h>")
> 
> 
> Even if I've read [3], I don't fully understand the real need of this Printk
> Index mechanism (at least for my own needs :))
> 
> 
> My questions are:
>    - is my analysis right?
>    - is the lack of these 2 functionalities (dev_fmt and Printk Index)
> expected, when dev_err_probe() is used?
>    - if not, is it a issue?
>    - should it be at least documented?

The printk index stuff is odd, and always seemed like a "check box"
option that some people wanted for a niche enterprise market.  It's up
to them to keep that working well if they really need it, driver authors
should not worry about this.

thanks,

greg k-h
