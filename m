Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCBE4B53B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355361AbiBNOsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:48:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiBNOsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:48:41 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9144BFFD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:48:32 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 05AA41C0012;
        Mon, 14 Feb 2022 14:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644850108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PGDplxRGAMDfPdM5M9k+XloHcPThbWZzI8F7SByLk7s=;
        b=kKMzgCMVFAAzUo2AQLJFNHPV8wZ9DlEIxSqS2cA6OXU52d4lCZqnP4/aAkP76aupvBpxPH
        B3baTP8uWO9yT/GfID+n+BC2DxaVqJiMByFjFDKM/uFuToyio/kSU5nY8nc4mUbGaeXBV+
        pyxeGMxOTGqFw+USlRkHm/CZLzGjdkhvpNBYGCtKHLtCZOQRzUJVDwWmM8ULbRwNmCA00u
        mPw8UjMx/6f27sbyVnJqmwEYiA1Io4LWAU44hJSuJUzheSOVBTWmlCCXGK6WolSVuJXXWY
        ZsEniWBeAXzORIImXW67+mthym9N/KBlrND6x2nR/kGvSusb0yWOfXASYSnRJQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        kernel-team@android.com
Subject: Re: [PATCH 05/10] irqchip/mvebu-pic: Switch to dynamic chip name
 output
In-Reply-To: <20220209162607.1118325-6-maz@kernel.org>
References: <20220209162607.1118325-1-maz@kernel.org>
 <20220209162607.1118325-6-maz@kernel.org>
Date:   Mon, 14 Feb 2022 15:48:24 +0100
Message-ID: <87zgmtjyh3.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc;

> Instead of overriding the name field, track the corresponding device
> and use the relevant callback to output its name.
>
> This allows us to make the irq_chip structure const.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

> ---
>  drivers/irqchip/irq-mvebu-pic.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
> index 870f9866b8da..ef3d3646ccc2 100644
> --- a/drivers/irqchip/irq-mvebu-pic.c
> +++ b/drivers/irqchip/irq-mvebu-pic.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/seq_file.h>
>  
>  #define PIC_CAUSE	       0x0
>  #define PIC_MASK	       0x4
> @@ -29,7 +30,7 @@ struct mvebu_pic {
>  	void __iomem *base;
>  	u32 parent_irq;
>  	struct irq_domain *domain;
> -	struct irq_chip irq_chip;
> +	struct platform_device *pdev;
>  };
>  
>  static void mvebu_pic_reset(struct mvebu_pic *pic)
> @@ -66,6 +67,20 @@ static void mvebu_pic_unmask_irq(struct irq_data *d)
>  	writel(reg, pic->base + PIC_MASK);
>  }
>  
> +static void mvebu_pic_print_chip(struct irq_data *d, struct seq_file *p)
> +{
> +	struct mvebu_pic *pic = irq_data_get_irq_chip_data(d);
> +
> +	seq_printf(p, dev_name(&pic->pdev->dev));
> +}
> +
> +static const struct irq_chip mvebu_pic_chip = {
> +	.irq_mask	= mvebu_pic_mask_irq,
> +	.irq_unmask	= mvebu_pic_unmask_irq,
> +	.irq_eoi	= mvebu_pic_eoi_irq,
> +	.irq_print_chip	= mvebu_pic_print_chip,
> +};
> +
>  static int mvebu_pic_irq_map(struct irq_domain *domain, unsigned int virq,
>  			     irq_hw_number_t hwirq)
>  {
> @@ -73,8 +88,7 @@ static int mvebu_pic_irq_map(struct irq_domain *domain, unsigned int virq,
>  
>  	irq_set_percpu_devid(virq);
>  	irq_set_chip_data(virq, pic);
> -	irq_set_chip_and_handler(virq, &pic->irq_chip,
> -				 handle_percpu_devid_irq);
> +	irq_set_chip_and_handler(virq, &mvebu_pic_chip, handle_percpu_devid_irq);
>  	irq_set_status_flags(virq, IRQ_LEVEL);
>  	irq_set_probe(virq);
>  
> @@ -120,22 +134,16 @@ static int mvebu_pic_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node = pdev->dev.of_node;
>  	struct mvebu_pic *pic;
> -	struct irq_chip *irq_chip;
>  
>  	pic = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pic), GFP_KERNEL);
>  	if (!pic)
>  		return -ENOMEM;
>  
> +	pic->pdev = pdev;
>  	pic->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pic->base))
>  		return PTR_ERR(pic->base);
>  
> -	irq_chip = &pic->irq_chip;
> -	irq_chip->name = dev_name(&pdev->dev);
> -	irq_chip->irq_mask = mvebu_pic_mask_irq;
> -	irq_chip->irq_unmask = mvebu_pic_unmask_irq;
> -	irq_chip->irq_eoi = mvebu_pic_eoi_irq;
> -
>  	pic->parent_irq = irq_of_parse_and_map(node, 0);
>  	if (pic->parent_irq <= 0) {
>  		dev_err(&pdev->dev, "Failed to parse parent interrupt\n");
> -- 
> 2.30.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
