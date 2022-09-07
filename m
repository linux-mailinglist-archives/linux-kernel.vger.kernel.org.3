Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE515B0680
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIGO1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIGO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:27:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD9173301;
        Wed,  7 Sep 2022 07:26:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFD2CB81CED;
        Wed,  7 Sep 2022 14:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1BBC433B5;
        Wed,  7 Sep 2022 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662560723;
        bh=yeuu+YHoAaM56AfzE5PPgWroRTD2ZSJ/Qth+YAHZXGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPmOYajAhegwV3psYKwg+vq4onOeLdGDlkuyS17OzlQgjeVPLlZlGqw50FQ9dYQ57
         hXk7h1nBc+axwYn5E1pqm4ftvnfR5ccTs6zieobqhYV2fKYPlJDrdSv4CbRaQWuuJo
         tKay+5AG+4Vyz7JrNDDdtlRQcdam6AxE6hEm8yjY=
Date:   Wed, 7 Sep 2022 16:25:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: misc: usb3503: call clk_disable_unprepare in the
 error handling
Message-ID: <Yxip0d2bBOi/CB4P@kroah.com>
References: <20220903071543.2844698-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903071543.2844698-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 03:15:40PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Smatch reports the following warning:
> 
> vers/usb/misc/usb3503.c:267 usb3503_probe() warn: 'hub->clk'
> from clk_prepare_enable() not released on lines: 240,246,252
> 
> Fix this by adding a flag to indicate if hub->clk is prepared or not and
> invoke clk_disable_unprepare in the error handling.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/usb/misc/usb3503.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
> index 330f494cd158..add47dd964b2 100644
> --- a/drivers/usb/misc/usb3503.c
> +++ b/drivers/usb/misc/usb3503.c
> @@ -160,6 +160,7 @@ static int usb3503_probe(struct usb3503 *hub)
>  	struct usb3503_platform_data *pdata = dev_get_platdata(dev);
>  	struct device_node *np = dev->of_node;
>  	int err;
> +	int is_clk_enable = 0;

bool?

>  	u32 mode = USB3503_MODE_HUB;
>  	const u32 *property;
>  	enum gpiod_flags flags;
> @@ -217,6 +218,8 @@ static int usb3503_probe(struct usb3503 *hub)
>  			return err;
>  		}
>  
> +		// set a flag for successful clk_prepare_enable

Comment isn't needed.

> +		is_clk_enable = 1;
>  		property = of_get_property(np, "disabled-ports", &len);
>  		if (property && (len / sizeof(u32)) > 0) {
>  			int i;
> @@ -236,20 +239,29 @@ static int usb3503_probe(struct usb3503 *hub)
>  	else
>  		flags = GPIOD_OUT_HIGH;
>  	hub->intn = devm_gpiod_get_optional(dev, "intn", flags);
> -	if (IS_ERR(hub->intn))
> +	if (IS_ERR(hub->intn)) {
> +		if (is_clk_enable)
> +			clk_disable_unprepare(hub->clk);
>  		return PTR_ERR(hub->intn);

This is getting messy, any way to make a common error handler at the
bottom of the function instead?  That's the common kernel coding style
for this type of thing.

thanks,

greg k-h
