Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EA65A62E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiH3MIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiH3MIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:08:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDA07287A;
        Tue, 30 Aug 2022 05:08:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 914CE615E3;
        Tue, 30 Aug 2022 12:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59D2C433D7;
        Tue, 30 Aug 2022 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661861292;
        bh=g+Rcgnc0QLXxlIYFqQsXOP7y0PqEh+YGmtuxt1ofKrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ide9WIzUNRPXWPaADcR4hQWi1M0acECjAB79S88A+RWUeqvlwPJ9Kj5tCE5ceSH0z
         Zf9WKXejIfR0ntW3bFh0q82zSRmGRXoTR2/u6JwRJ89l8F34PeraZJjlbFf6Ff3Dde
         0QdTg+IMyskrCl1NPcIpHtN1/j0UIflXDlPm9Grt9VW40I1YhHa27E6aNtTa3W80Dy
         39We5KPZr9EI8vb67gzAyQLV85GvPURsE3SQAWlXwWhSbAqZuF66cwCsV8JA3Ayahe
         oothBUuUdDEF4XnxBiFpaGfkiu76D1je3VFwW6Bg/CW/WjuJfsvbYVzgfEZ8rg4fk+
         6x32QitcRGWfA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oT02M-0003tp-7F; Tue, 30 Aug 2022 14:08:10 +0200
Date:   Tue, 30 Aug 2022 14:08:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, johan+linaro@kernel.org, steev@kali.org
Subject: Re: [PATCH v3] pinctrl: qcom: spmi-gpio: Make irqchip immutable
Message-ID: <Yw39qmuS3T+DLcfB@hovoldconsulting.com>
References: <20220830092232.168561-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830092232.168561-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 02:52:32PM +0530, Manivannan Sadhasivam wrote:
> The irqchip implementation used inside the gpiochips are not supposed to
> be changed during runtime. So let's make the one inside the spmi-gpio
> gpiochip immutable.
> 
> This fixes the below warning during boot:
> gpio gpiochip0: (c440000.spmi:pmic@0:gpio@c000): not an immutable chip, please consider fixing it!
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v3:
> 
> * Added Ack from Marc
> * Removed the text that was mimicking the documentation
> 
> Changes in v2:
> 
> * Added new callbacks for irq_{mask/unmask} for masking/unmasking the parent
>   IRQ that was missing in v1. (Thanks to Marc)
> * Modified the commit message accordingly.
> 
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 38 +++++++++++++++++-------
>  1 file changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index ccaf40a9c0e6..d40e3b2d38cc 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c

> @@ -985,6 +984,33 @@ static int pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
>  	return 0;
>  }
>  
> +static void pmic_gpio_irq_mask(struct irq_data *data)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
> +
> +	irq_chip_mask_parent(data);
> +	gpiochip_disable_irq(gc, data->hwirq);
> +}
> +
> +static void pmic_gpio_irq_unmask(struct irq_data *data)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
> +
> +	irq_chip_unmask_parent(data);
> +	gpiochip_enable_irq(gc, data->hwirq);

Could you set the IRQ-enabled flag before unmasking the parent here for
symmetry (and as most other implementations do)?

> +}

Other than that, looks good:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
