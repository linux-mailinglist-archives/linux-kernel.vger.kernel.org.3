Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172CD542E80
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbiFHK4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiFHK4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:56:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DA866CA3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:56:46 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nytMi-0002sA-Fu; Wed, 08 Jun 2022 12:56:44 +0200
Message-ID: <2d79719b8670a3693b210af5ab45716dba23999a.camel@pengutronix.de>
Subject: Re: [PATCH] irqchip/irq-imx-irqsteer: Get/put PM runtime in
 ->irq_unmask()/irq_mask()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Liu Ying <victor.liu@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Date:   Wed, 08 Jun 2022 12:56:41 +0200
In-Reply-To: <20220608105057.2607812-1-victor.liu@nxp.com>
References: <20220608105057.2607812-1-victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 08.06.2022 um 18:50 +0800 schrieb Liu Ying:
> Now that runtime PM support was added in this driver, we have
> to enable power before accessing irqchip registers.  And, after
> the access is done, we should disable power.  This patch calls
> pm_runtime_get_sync() in ->irq_unmask() and pm_runtime_put() in
> ->irq_mask() to make sure power is managed for the register access.
> 
Can you tell me in which case this is necessary? IIRC the IRQ core
already keeps the chip runtime resumed as soon as a IRQ is requested,
so why would it be in runtime suspend at mask/unmask?

Regards,
Lucas

> Fixes: 4730d2233311 ("irqchip/imx-irqsteer: Add runtime PM support")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/irqchip/irq-imx-irqsteer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
> index 96230a04ec23..a5eabe71e8ab 100644
> --- a/drivers/irqchip/irq-imx-irqsteer.c
> +++ b/drivers/irqchip/irq-imx-irqsteer.c
> @@ -45,11 +45,14 @@ static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
>  
>  static void imx_irqsteer_irq_unmask(struct irq_data *d)
>  {
> +	struct device *dev = d->domain->dev;
>  	struct irqsteer_data *data = d->chip_data;
>  	int idx = imx_irqsteer_get_reg_index(data, d->hwirq);
>  	unsigned long flags;
>  	u32 val;
>  
> +	pm_runtime_get_sync(dev);
> +
>  	raw_spin_lock_irqsave(&data->lock, flags);
>  	val = readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
>  	val |= BIT(d->hwirq % 32);
> @@ -59,6 +62,7 @@ static void imx_irqsteer_irq_unmask(struct irq_data *d)
>  
>  static void imx_irqsteer_irq_mask(struct irq_data *d)
>  {
> +	struct device *dev = d->domain->dev;
>  	struct irqsteer_data *data = d->chip_data;
>  	int idx = imx_irqsteer_get_reg_index(data, d->hwirq);
>  	unsigned long flags;
> @@ -69,6 +73,8 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
>  	val &= ~BIT(d->hwirq % 32);
>  	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
>  	raw_spin_unlock_irqrestore(&data->lock, flags);
> +
> +	pm_runtime_put(dev);
>  }
>  
>  static const struct irq_chip imx_irqsteer_irq_chip = {


