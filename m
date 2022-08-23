Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA45259EF58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiHWWlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiHWWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:41:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67017EFF8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:41:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so16160906pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=DYCdkAi1SoSPZ5bwykHHpvMzGzs8GFkmq9nufDZ3TQw=;
        b=IDHaNzljG4bY/gyBT2gxIWDKk7Lr8Nu17hNPv7fDj1uScAibRhTnsBoxgqE1Q+cqVy
         xafCa+jQTXHS1kYMZbhc1bVkmOVsLM3vDRKZv7CgVeEQSqt5JqWt8M+PE9TS+uM25kt4
         tN6a8bAirlFyCCAoKqTTS4sM5+kXBx+qtd6kyjBXDNyLIYA+Qh3dg/jgG4Cb8+s4qyXY
         9mmQL3HSZMdgz5Smfn5b7Znr5/N/Uor6GiGPpnyN38IWeZgeLveVNCkfQnZCoCjRhkF2
         PnAXMmOKI/Yu0Wsya2UHeLLu73gS9SIl6Jn4aiq8O6bTBK6jcAWoXRKYsMIy2d5z7Lrh
         0VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DYCdkAi1SoSPZ5bwykHHpvMzGzs8GFkmq9nufDZ3TQw=;
        b=EMbzmsZPaGkeACUXfLOK186aAKvHXnWhtgE+J8UBRcHmWWIWEcwCUr+TDjSln3ftjL
         NpNmqaYh5P316kCntYYnLRSdneM88OSzR3ymmG/n770Z8DJ4kCwCzOffjxRCCUMtBjj1
         eihD6i/31lgMQndWVHzsx0EnZD941hrYZwJHX+JvXcRqBrcKMAjIvXTbmUPg9qjVUPAQ
         ZgVeLzik8EssZWE1SQynHc29VG1DnLiu68hbbgzn1MqP8tXzRDS4LzgBSmy22rOGFClS
         TkSheMm+6YHm0tDxoyIC03JGZ+z2UhB5x5EYhWIH+tNF/yOVp6eW9I591t9UnX4vQ+zR
         4rZA==
X-Gm-Message-State: ACgBeo10nCrgGz0pA+uf6mGURMx+T/RFtE6iqj0APP4x1tZi1C5C2PLc
        0IIk7wEgtRf0NIDoovSYJRk=
X-Google-Smtp-Source: AA6agR4yZGfAfryTLG1e/1Uu1Nbxl+vprZzmETGtCKuXal3vB3b5BUbZE1BnGcpVcbIgemZ8hrGl8Q==
X-Received: by 2002:a17:902:f604:b0:172:ffa5:2ed9 with SMTP id n4-20020a170902f60400b00172ffa52ed9mr4967214plg.7.1661294481260;
        Tue, 23 Aug 2022 15:41:21 -0700 (PDT)
Received: from [172.30.1.52] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id y65-20020a626444000000b005371689d70fsm1386920pfb.120.2022.08.23.15.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 15:41:20 -0700 (PDT)
Message-ID: <e9545ce7-292f-88cc-7a27-6d79d30ef306@gmail.com>
Date:   Wed, 24 Aug 2022 07:41:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] extcon: usbc-tusb320: Expose the charger type
Content-Language: en-US
To:     Surendranath Parimi <surendranath.parimi@axis.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org
References: <20220815090427.3205-1-surendranath.parimi@axis.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220815090427.3205-1-surendranath.parimi@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Surendranath,

I applied the other patches[1] supporting usb type-c.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git/log/?h=extcon-next

And then tried to apply this patch. But the merger conflict occurs.
Please rework your patch based on latest extcon-next branch.

Thanks,
Chanwoo Choi

On 22. 8. 15. 18:04, Surendranath Parimi wrote:
> In the UFP mode of operation, knowing the charger type helps to draw the
> appropriate amount of current from the charger. The charger type can be
> know by reading the current_mode_detect bits of register 0x08.
> 
> Add support to expose the charger type.
> 
> Signed-off-by: Surendranath Parimi <surendranath.parimi@axis.com>
> ---
>  drivers/extcon/extcon-usbc-tusb320.c | 37 ++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> index 6ba3d89b106d..43f07efa3472 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -14,6 +14,10 @@
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  
> +#define TUSB320_REG8				0x8
> +#define TUSB320_REG8_CURRENT_MODE_DETECT_SHIFT	0x4
> +#define TUSB320_REG8_CURRENT_MODE_DETECT_MASK	0x3
> +
>  #define TUSB320_REG9				0x9
>  #define TUSB320_REG9_ATTACHED_STATE_SHIFT	6
>  #define TUSB320_REG9_ATTACHED_STATE_MASK	0x3
> @@ -42,6 +46,13 @@ enum tusb320_mode {
>  	TUSB320_MODE_DRP,
>  };
>  
> +enum tusb320_current_mode_detect {
> +	TUSB320_CURRENT_MODE_DETECT_DEFAULT,
> +	TUSB320_CURRENT_MODE_DETECT_MEDIUM,
> +	TUSB320_CURRENT_MODE_DETECT_ACCESSORY,
> +	TUSB320_CURRENT_MODE_DETECT_HIGH,
> +};
> +
>  struct tusb320_priv;
>  
>  struct tusb320_ops {
> @@ -67,6 +78,9 @@ static const char * const tusb_attached_states[] = {
>  static const unsigned int tusb320_extcon_cable[] = {
>  	EXTCON_USB,
>  	EXTCON_USB_HOST,
> +	EXTCON_CHG_USB_FAST,
> +	EXTCON_CHG_USB_SLOW,
> +	EXTCON_CHG_USB_PD,
>  	EXTCON_NONE,
>  };
>  
> @@ -187,8 +201,8 @@ static struct tusb320_ops tusb320l_ops = {
>  static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>  {
>  	struct tusb320_priv *priv = dev_id;
> -	int state, polarity;
> -	unsigned reg;
> +	int state, polarity, current_mode;
> +	unsigned int reg, reg8;
>  
>  	if (regmap_read(priv->regmap, TUSB320_REG9, &reg)) {
>  		dev_err(priv->dev, "error during i2c read!\n");
> @@ -205,10 +219,26 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>  	dev_dbg(priv->dev, "attached state: %s, polarity: %d\n",
>  		tusb_attached_states[state], polarity);
>  
> +	if (regmap_read(priv->regmap, TUSB320_REG8, &reg8)) {
> +		dev_err(priv->dev, "error during i2c read!\n");
> +		return IRQ_NONE;
> +	}
> +
> +	current_mode = (reg8 >> TUSB320_REG8_CURRENT_MODE_DETECT_SHIFT) &
> +			TUSB320_REG8_CURRENT_MODE_DETECT_MASK;
> +
> +	dev_dbg(priv->dev, "current_mode:%d\n", current_mode);
> +
>  	extcon_set_state(priv->edev, EXTCON_USB,
>  			 state == TUSB320_ATTACHED_STATE_UFP);
>  	extcon_set_state(priv->edev, EXTCON_USB_HOST,
>  			 state == TUSB320_ATTACHED_STATE_DFP);
> +	extcon_set_state(priv->edev, EXTCON_CHG_USB_SLOW,
> +			 current_mode == TUSB320_CURRENT_MODE_DETECT_ACCESSORY);
> +	extcon_set_state(priv->edev, EXTCON_CHG_USB_FAST,
> +			 current_mode == TUSB320_CURRENT_MODE_DETECT_MEDIUM);
> +	extcon_set_state(priv->edev, EXTCON_CHG_USB_PD,
> +			 current_mode == TUSB320_CURRENT_MODE_DETECT_HIGH);
>  	extcon_set_property(priv->edev, EXTCON_USB,
>  			    EXTCON_PROP_USB_TYPEC_POLARITY,
>  			    (union extcon_property_value)polarity);
> @@ -217,6 +247,9 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>  			    (union extcon_property_value)polarity);
>  	extcon_sync(priv->edev, EXTCON_USB);
>  	extcon_sync(priv->edev, EXTCON_USB_HOST);
> +	extcon_sync(priv->edev, EXTCON_CHG_USB_PD);
> +	extcon_sync(priv->edev, EXTCON_CHG_USB_FAST);
> +	extcon_sync(priv->edev, EXTCON_CHG_USB_SLOW);
>  
>  	priv->state = state;
>  
