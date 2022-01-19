Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2054449369A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352615AbiASIwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352611AbiASIwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:52:31 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9F6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:52:31 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so4328131wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YD4iLLUZyr8CeCj03I9UusKK7X+cQDyntXdR+j7XGJ8=;
        b=2bdD5fFDtv75HUstXnBK3i64pouZCKluoajegLjNS/RIy9+boLJLed8cYtKiE8oYls
         HZruaKZaiufFsHJjdrm23sDT0nX5lyuGPcuy96TROO0ii/86sQtHXWzcZlDP0mTwdisS
         9xwiPZNzd/WEZeAGkq4oG/ePhkEZ68ZcruTJFHfYBf3Kk4ybzqDiAb156U7CoDdzEtH6
         pllnlCwHANKu2EBhe16UTmuvPDvwbBDlWOAuOi16ZJrRqFY6yYEpuKFZcdyUsQC+xoJi
         UN9sbex47tUQ3XewCCsSzpNFtgLA1Xh/LUjkBqtKTJeV0vnwzjCgxoptlmyAjA2ij05V
         Chvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YD4iLLUZyr8CeCj03I9UusKK7X+cQDyntXdR+j7XGJ8=;
        b=OsfipIYEQ3zXxderVqC/KHgE1UkA7kxrkES7BCy5OaaWIR2P7iF1IB+JbNi6MZ50gW
         lFjhnK3OEm6JEgc3p+fQG6enxS2YxC9apZHpJt2G/zs4CB4Kmilv4PZbwk7HmEFtCC0m
         nmil4NDYI2g8/4BdglbfjtSJwGIJmqt65arT+jv51SQk/yDyksQrBKG3dYuIOEBG4q2t
         2d6QMXQPkhLrSZZFUfxnS+qbnUFLuwOoZW7JMkYs9o4+sPHJKmUgGgJXhhyDwGrV5TOZ
         zXpae3FclA0wWMYWzVZG0wiRcu+qIsRDzi9E9wlZs6Mb353QmbYcCLJP03gSVxq3eUtr
         AX2A==
X-Gm-Message-State: AOAM532vJ7ESRvkSpgvbCq3N9dwxjOhsoz4HEtb+zWUNyNx9VRU9gi78
        hx0E6yxOa0I12W4ce7+4MleREw==
X-Google-Smtp-Source: ABdhPJy1oCNGTILfQq9bNc6hI+HQu+PIjFcQi9caeNfzovHe1JtvE6p9he2B/1S2/It6iJE9m3XwRA==
X-Received: by 2002:a5d:5709:: with SMTP id a9mr27851692wrv.707.1642582349895;
        Wed, 19 Jan 2022 00:52:29 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:d394:97d0:bc02:3846? ([2001:861:44c0:66c0:d394:97d0:bc02:3846])
        by smtp.gmail.com with ESMTPSA id u12sm14189172wrm.106.2022.01.19.00.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 00:52:28 -0800 (PST)
Subject: Re: [PATCH v2 3/4] irqchip/meson-gpio: add select trigger type
 callback
To:     Qianggui Song <qianggui.song@amlogic.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20220119070809.15563-1-qianggui.song@amlogic.com>
 <20220119070809.15563-4-qianggui.song@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <fb7db50f-866a-233b-1c9b-093cd50473c8@baylibre.com>
Date:   Wed, 19 Jan 2022 09:52:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220119070809.15563-4-qianggui.song@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/01/2022 08:08, Qianggui Song wrote:
> Due to some chips may use different registers and offset, provide
> a set trigger type call back.
> 
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
> ---
>  drivers/irqchip/irq-meson-gpio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
> index eefe15e1b3a6..b511f9532adc 100644
> --- a/drivers/irqchip/irq-meson-gpio.c
> +++ b/drivers/irqchip/irq-meson-gpio.c
> @@ -55,6 +55,8 @@ struct irq_ctl_ops {
>  	void (*gpio_irq_sel_pin)(struct meson_gpio_irq_controller *ctl,
>  				 unsigned int channel, unsigned long hwirq);
>  	void (*gpio_irq_init)(struct meson_gpio_irq_controller *ctl);
> +	void (*gpio_irq_sel_type)(struct meson_gpio_irq_controller *ctl,
> +				  unsigned int idx, u32 val);
>  };
>  
>  struct meson_gpio_irq_params {
> @@ -278,6 +280,12 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
>  	 */
>  	type &= IRQ_TYPE_SENSE_MASK;
>  
> +	/* Some controllers may have different calculation method*/
> +	if (params->ops.gpio_irq_sel_type) {
> +		params->ops.gpio_irq_sel_type(ctl, idx, type);
> +		return 0;
> +	}
> +
>  	/*
>  	 * New controller support EDGE_BOTH trigger. This setting takes
>  	 * precedence over the other edge/polarity settings
> 

The comment on v1 hasn't been addresses here, it was asked to move the old controllers
sel_type to a callback and introduce an S4 callback instead of doing this.

Neil
