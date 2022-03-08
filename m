Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6C4D1D4C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348354AbiCHQfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiCHQfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:35:42 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA32D33890;
        Tue,  8 Mar 2022 08:34:45 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 113126000A;
        Tue,  8 Mar 2022 16:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646757284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3KTl4ElrR6egwo8ztDejgkW8tDsDkxXuiRNEpanN/gA=;
        b=O5vjCz54y9GLGSF4vOQLbB76EABhIISyBYYsBWBJJ9fShW2T7kj8yh57KRCAhR3TamwSdM
        YeQb3eGodOQytSOeF+jFIDm4lKL4R4PM9khZzZKLI0WRoc5EH96mFOA85ClRh6IJADDW6H
        LLqpjbfVHYKZ37OLM3RYQb3N6tS7i27v9YbI2yzEQzLgsiyjmwFesOmVUhasLGaXu5ILCf
        C0oKFq87Jyr2t4rSrZv3Mt/N5denEdpPgO0whug0JnTYsnk8XKrFNgCXo/5O/Afu5SplvN
        SJW/Kc2opjB6OAtj2Yrv9OwcMzoXWIK8fnzSIhLBgE+AHfLoDjitpjEVHSm4vA==
Date:   Tue, 8 Mar 2022 17:34:42 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: snvs: Handle error for clk_enable
Message-ID: <YieFovazuZ7tgeyj@piout.net>
References: <20220304072018.557237-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304072018.557237-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 15:20:18+0800, Jiasheng Jiang wrote:
> As the potential failure of the clk_enable(),
> it should be better to check it and return error
> if fails.
> 
> Fixes: edb190cb1734 ("rtc: snvs: make sure clock is enabled for interrupt handle")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/rtc/rtc-snvs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> index bd929b0e7d7d..f273f7d873f8 100644
> --- a/drivers/rtc/rtc-snvs.c
> +++ b/drivers/rtc/rtc-snvs.c
> @@ -269,8 +269,11 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
>  	struct snvs_rtc_data *data = dev_get_drvdata(dev);
>  	u32 lpsr;
>  	u32 events = 0;
> +	int ret;
>  
> -	clk_enable(data->clk);
> +	ret = clk_enable(data->clk);
> +	if (ret)
> +		return IRQ_NONE;

I don't think you thought about the implication here, if this happens,
then the interrupt will be considered spurious which is definitively not
something we want.

>  
>  	regmap_read(data->regmap, data->offset + SNVS_LPSR, &lpsr);
>  
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
