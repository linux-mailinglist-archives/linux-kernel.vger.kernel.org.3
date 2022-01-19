Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5881349369E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352632AbiASIxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352622AbiASIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:53:04 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C29C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:53:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id w26so3913676wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=20v1qW8h1O5ten4wL7c3Va4icHS7gN2AsYBTibsl1ZQ=;
        b=GJ74SPI7hyP6NxRHhfOMYuYsl24Lngx/RB89jxq2D9HtNxZmAULhKzydShOrRI22Jj
         0FXNwp8WxB0wa+85U3NpcoRmiz6hkfcHS6ogaGb9JWRz/i4IHB+BiT57Avqxla3GQ9D4
         lqItNs5U6MBgzfGp4Jll2ET/48YG/P/56kKsVEFF55eJ1HlC0NT4jhFb+EmcEQOwKIvD
         JUcOo3hrvZYh+Tzzn9x38JW8ALKqBFDIdv71WJSwzp8+AkGBQMidR9nDX4wQ42fZ3qBH
         edEWEPc2NkBGI62UgHi/BR++88ej7t2yc6Gdh6u8gYlQG+ATEfy722k/1W1eMrbceOkl
         pe7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=20v1qW8h1O5ten4wL7c3Va4icHS7gN2AsYBTibsl1ZQ=;
        b=fX8g6aGp/09fBcdOV3KttdczDyv5zkL3xEXjUz2R/+JnEMkBguDp0+uSkr9e36eAks
         wrX4xRy+vIbjAs54BeXmLIxkcdsqqvct6zitlUKzP4FzRByeS2M+EqUx7ENzdmE78x35
         tiyqUk6dye6lzf1I5sCQN0C2+61MNx69CZkZoFX6+6Or5S2KO5YC0v71KZ+9YGDiUzQR
         W4ku3oT3NZj9O9DHHk/NlG4J7UkPF3EpJDU+yQPAyjJNw6mYFdsn44VdtTIn32ljGkE2
         odQt38wZ4BsYhsLVgaNmwWZXke60SUqdlpia9lOHvsISKvoIGELkHfhRJ2LxXSQIATYH
         NPcg==
X-Gm-Message-State: AOAM5339Dkfx5VTkQCvdDWC+gzkqFH5NjO7ifKmxlmcQoUEoxv79xXdo
        cE33z7EICj1Gkk8Z3HwuISuAxA==
X-Google-Smtp-Source: ABdhPJxOLdJpvEytnYNXzk/+DefhvASC+EPLAZjxrPyNtVfZ70hnOUvUjKXS1V3OzzkoKL+SyCyDiA==
X-Received: by 2002:a1c:f413:: with SMTP id z19mr2376154wma.111.1642582382358;
        Wed, 19 Jan 2022 00:53:02 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:d394:97d0:bc02:3846? ([2001:861:44c0:66c0:d394:97d0:bc02:3846])
        by smtp.gmail.com with ESMTPSA id h11sm4569696wmb.12.2022.01.19.00.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 00:53:01 -0800 (PST)
Subject: Re: [PATCH v2 2/4] irqchip/meson-gpio: support more than 8 channels
 gpio irq line
To:     Qianggui Song <qianggui.song@amlogic.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20220119070809.15563-1-qianggui.song@amlogic.com>
 <20220119070809.15563-3-qianggui.song@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <4c6b7f6b-b9a2-c08d-7ac4-f5132808b1c5@baylibre.com>
Date:   Wed, 19 Jan 2022 09:53:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220119070809.15563-3-qianggui.song@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2022 08:08, Qianggui Song wrote:
> Current meson gpio irqchip driver only support 8 channels for gpio irq
> line, later chips may have more then 8 channels, so need to modify code
> to support more.
> 
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
> ---
>  drivers/irqchip/irq-meson-gpio.c | 33 +++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
> index d90ff0b92480..eefe15e1b3a6 100644
> --- a/drivers/irqchip/irq-meson-gpio.c
> +++ b/drivers/irqchip/irq-meson-gpio.c
> @@ -16,7 +16,6 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  
> -#define NUM_CHANNEL 8
>  #define MAX_INPUT_MUX 256
>  
>  #define REG_EDGE_POL	0x00
> @@ -60,6 +59,7 @@ struct irq_ctl_ops {
>  
>  struct meson_gpio_irq_params {
>  	unsigned int nr_hwirq;
> +	unsigned int nr_channels;
>  	bool support_edge_both;
>  	unsigned int edge_both_offset;
>  	unsigned int edge_single_offset;
> @@ -81,6 +81,7 @@ struct meson_gpio_irq_params {
>  	.edge_single_offset = 0,				\
>  	.pol_low_offset = 16,					\
>  	.pin_sel_mask = 0xff,					\
> +	.nr_channels = 8,					\
>  
>  #define INIT_MESON_A1_COMMON_DATA(irqs)				\
>  	INIT_MESON_COMMON(irqs, meson_a1_gpio_irq_init,		\
> @@ -90,6 +91,7 @@ struct meson_gpio_irq_params {
>  	.edge_single_offset = 8,				\
>  	.pol_low_offset = 0,					\
>  	.pin_sel_mask = 0x7f,					\
> +	.nr_channels = 8,					\
>  
>  static const struct meson_gpio_irq_params meson8_params = {
>  	INIT_MESON8_COMMON_DATA(134)
> @@ -136,8 +138,8 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
>  struct meson_gpio_irq_controller {
>  	const struct meson_gpio_irq_params *params;
>  	void __iomem *base;
> -	u32 channel_irqs[NUM_CHANNEL];
> -	DECLARE_BITMAP(channel_map, NUM_CHANNEL);
> +	u32 *channel_irqs;
> +	unsigned long *channel_map;
>  	spinlock_t lock;
>  };
>  
> @@ -207,8 +209,8 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
>  	spin_lock_irqsave(&ctl->lock, flags);
>  
>  	/* Find a free channel */
> -	idx = find_first_zero_bit(ctl->channel_map, NUM_CHANNEL);
> -	if (idx >= NUM_CHANNEL) {
> +	idx = find_first_zero_bit(ctl->channel_map, ctl->params->nr_channels);
> +	if (idx >= ctl->params->nr_channels) {
>  		spin_unlock_irqrestore(&ctl->lock, flags);
>  		pr_err("No channel available\n");
>  		return -ENOSPC;
> @@ -447,13 +449,26 @@ static int meson_gpio_irq_parse_dt(struct device_node *node, struct meson_gpio_i
>  
>  	ctl->params = match->data;
>  
> +	ctl->channel_irqs = kcalloc(ctl->params->nr_channels, sizeof(*ctl->channel_irqs),
> +				    GFP_KERNEL);
> +	if (!ctl->channel_irqs)
> +		return -ENOMEM;
> +
> +	ctl->channel_map = bitmap_zalloc(ctl->params->nr_channels, GFP_KERNEL);
> +	if (!ctl->channel_map) {
> +		kfree(ctl->channel_irqs);
> +		return -ENOMEM;
> +	}
> +
>  	ret = of_property_read_variable_u32_array(node,
>  						  "amlogic,channel-interrupts",
>  						  ctl->channel_irqs,
> -						  NUM_CHANNEL,
> -						  NUM_CHANNEL);
> +						  ctl->params->nr_channels,
> +						  ctl->params->nr_channels);
>  	if (ret < 0) {
> -		pr_err("can't get %d channel interrupts\n", NUM_CHANNEL);
> +		pr_err("can't get %d channel interrupts\n", ctl->params->nr_channels);
> +		kfree(ctl->channel_map);
> +		kfree(ctl->channel_irqs);
>  		return ret;
>  	}
>  
> @@ -507,7 +522,7 @@ static int meson_gpio_irq_of_init(struct device_node *node, struct device_node *
>  	}
>  
>  	pr_info("%d to %d gpio interrupt mux initialized\n",
> -		ctl->params->nr_hwirq, NUM_CHANNEL);
> +		ctl->params->nr_hwirq, ctl->params->nr_channels);
>  
>  	return 0;
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
