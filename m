Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C66568A6B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiGFOAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiGFOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:00:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81141A3B1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:00:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w24so15338901pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XGOAzLfiIBaUE5hKEF3LhixwuP+tVymp1O1VXS0KHeE=;
        b=P+t87zBrFa4h4Z7Nm8/KvhJEOvcDyhcGTVBrwWwcgFzyMBIohPPj5asiDfLoC+JqU9
         C+jyckc6TPV9NRylDkSRg8UW+/W5iwCKbsjK4L8+Lvbh5Hfxpvnic4kuvis6NiV7Fgv5
         AZ84QbkDcIL94O0J7/pLTKGifGXyZPipR/5q0/27h/dRmx2JkCpoasw4EtKUdlc3O2FP
         iiboZoSOepv3fFg8jnZl2hYYkavvAtd51zGvGX30azrMUe1MMBCc+yhB6hikaAkqonft
         B41ZpPQDLzHh0UFa2VLSIZ0A2kPPeIZmjW7gRzD1ANjPllmvuwPCXxbO+TKnNPRKiTtV
         TmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XGOAzLfiIBaUE5hKEF3LhixwuP+tVymp1O1VXS0KHeE=;
        b=AVVmEOaKANPGvZA1smJr9RTnHOwxYGz/eBYX8CIaNKDI4UxMFppT9PEkicJxOUWbcB
         3AzNXxrxNfraiaSnrVyT91EXNoXO+xoV3t9PqchVi3wBD7TLH/zwXyWo6zlloKD6+Uys
         AgPX4q0WzI6XUpItxtxpA2//qTB3VjVtc9EHSUw25E7puS1Wob3+TQTBuPFYtxi/M7Va
         +TeSQjP7y98+a8w82zMXKHN/svXQBjKHAyOQx2DXAHMSqb3m139lNLza5vbPiLHBjtYX
         xpDi3n8X9sMmLn+8CZNirb8+KNNykhKJj99aWj/PifjaaO6CQmi4h3TfawJ39Oq+AkNW
         IinQ==
X-Gm-Message-State: AJIora+bTYQGUkosfs3CzDwuUnHh8Oh4IGDh1QYhwr9eOml03javeYBC
        7MFwWvjmReigdCm55nbIH6G4
X-Google-Smtp-Source: AGRyM1twtwmsrNvpt6gTv7kScz14KKqm/0ECGH4tOu5mMFIiKv1InaWYOEEdgQakWXhgBCw6tYmP2g==
X-Received: by 2002:a17:902:dac1:b0:16a:3ebe:c722 with SMTP id q1-20020a170902dac100b0016a3ebec722mr45645641plx.169.1657116037038;
        Wed, 06 Jul 2022 07:00:37 -0700 (PDT)
Received: from thinkpad ([117.202.190.202])
        by smtp.gmail.com with ESMTPSA id t16-20020aa79390000000b0052521fd273fsm24826252pfe.218.2022.07.06.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:00:36 -0700 (PDT)
Date:   Wed, 6 Jul 2022 19:30:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: make the irqchip immutable
Message-ID: <20220706140031.GB2327@thinkpad>
References: <20220624195112.894916-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624195112.894916-1-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 09:51:12PM +0200, Robert Marko wrote:
> Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
> immutable") added a warning to indicate if the gpiolib is altering the
> internals of irqchips.
> 
> Following this change the following warning is now observed for the SPMI
> PMIC pinctrl driver:
> gpio gpiochip1: (200f000.spmi:pmic@0:gpio@c000): not an immutable chip, please consider fixing it!
> 
> Fix this by making the irqchip in the SPMI PMIC pinctrl driver immutable.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I've also tested this patch on Lenovo X13s, so

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index c3255b0bece4..406ee0933d0b 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -171,7 +171,6 @@ struct pmic_gpio_state {
>  	struct regmap	*map;
>  	struct pinctrl_dev *ctrl;
>  	struct gpio_chip chip;
> -	struct irq_chip irq;
>  	u8 usid;
>  	u8 pid_base;
>  };
> @@ -988,6 +987,17 @@ static void *pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
>  	return fwspec;
>  }
>  
> +static const struct irq_chip spmi_gpio_irq_chip = {
> +	.name		= "spmi-gpio",
> +	.irq_ack	= irq_chip_ack_parent,
> +	.irq_mask	= irq_chip_mask_parent,
> +	.irq_unmask	= irq_chip_unmask_parent,
> +	.irq_set_type	= irq_chip_set_type_parent,
> +	.irq_set_wake	= irq_chip_set_wake_parent,
> +	.flags		= IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND,
> +	GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
>  static int pmic_gpio_probe(struct platform_device *pdev)
>  {
>  	struct irq_domain *parent_domain;
> @@ -1081,16 +1091,8 @@ static int pmic_gpio_probe(struct platform_device *pdev)
>  	if (!parent_domain)
>  		return -ENXIO;
>  
> -	state->irq.name = "spmi-gpio",
> -	state->irq.irq_ack = irq_chip_ack_parent,
> -	state->irq.irq_mask = irq_chip_mask_parent,
> -	state->irq.irq_unmask = irq_chip_unmask_parent,
> -	state->irq.irq_set_type = irq_chip_set_type_parent,
> -	state->irq.irq_set_wake = irq_chip_set_wake_parent,
> -	state->irq.flags = IRQCHIP_MASK_ON_SUSPEND,
> -
>  	girq = &state->chip.irq;
> -	girq->chip = &state->irq;
> +	gpio_irq_chip_set_chip(girq, &spmi_gpio_irq_chip);
>  	girq->default_type = IRQ_TYPE_NONE;
>  	girq->handler = handle_level_irq;
>  	girq->fwnode = of_node_to_fwnode(state->dev->of_node);
> -- 
> 2.36.1
> 

-- 
மணிவண்ணன் சதாசிவம்
