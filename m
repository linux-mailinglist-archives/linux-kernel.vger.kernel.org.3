Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92FD4C9F7F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiCBIlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiCBIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:41:19 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43664B8B4F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:40:36 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 139so1059966pge.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k6QEkkNQBGwZDrWnPICP6QCW7b01/Bf270UXCVxlf78=;
        b=w1pwqloJOqkASyaFP+jbOcYGwlt2rPaZ7b8MkNHGbOTEskghExl2h6qSKqhWN4age7
         Z4hDgvbfjbyh/sAmvBfV2o3B/HMSEwdhSZYeSgXPnypuEWHGiqBMtgsdkbmL6u9k8nfN
         YcbPUXAlB3hzzH60VcMGju5YaJbAhTTC/g5uz3TUq+mAKCmB6Kppt+S/nJmTZ50jBGpE
         b4W0h5AtOziLzRZYoAWxB2qjjKZieeuG0/Jt5jXYwas1FhDrvkc2r4EZyqq2aj/KLNoQ
         2+P6cltWHcRicUoc0F+T3/StxEDlhbEGIpkxavPFZvcr2vH2QpwRmiDFVJuM0EP8dfPW
         RHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k6QEkkNQBGwZDrWnPICP6QCW7b01/Bf270UXCVxlf78=;
        b=FV/hMWuYgXVxJl/zSN6UyCakQ2Ekq7/mSxa+Wtmcj2lhsYk728oHy29H7+1rdMmzdf
         wCucCdQRANV0WwPO23EW6ggy95EU7/4Q2XzIotyKRXnU2+bDCExkiaAfVBFyuU938quA
         CpUtIAhTLFOngZVaYdkdpKWg3lDsPvdG3a6zUWDVcBqNPgGGE5SmamsJjrYm9eZHP1u3
         mlgK0TpvN/wlXGVn8F2C/lkEi6G0252OjIXCaj8AiuFl4JbRrvdBFXcN/EGmj9GpwiqB
         y1mtC8UyVob+JzSZveZVoCxX2QcsUa9s82zrj5QieLVHwevoQj52F0z3kaLlVPe7xIrn
         i1Uw==
X-Gm-Message-State: AOAM531XrOL3WPD+uURaIipb2ZFpCB9pY2tjqg3B7tEYZkHWyeozlln9
        VEfiRSPbPm40TKVPXLO21e3K1A==
X-Google-Smtp-Source: ABdhPJwKKl5HN0hYwnyHZK74pA1+t25EsMLtwdtj/OHs45MybBCKclyoLMi0BbxCYROvOwW9Kl0pLw==
X-Received: by 2002:a05:6a00:24c4:b0:4f6:5b15:b39a with SMTP id d4-20020a056a0024c400b004f65b15b39amr564052pfv.82.1646210435644;
        Wed, 02 Mar 2022 00:40:35 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id s4-20020a056a00194400b004f0fbeb6006sm20117161pfk.88.2022.03.02.00.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:40:34 -0800 (PST)
Date:   Wed, 2 Mar 2022 16:40:28 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] irqchip: Add Qualcomm MPM controller driver
Message-ID: <20220302084028.GL269879@dragon>
References: <20220301062414.2987591-1-shawn.guo@linaro.org>
 <20220301062414.2987591-3-shawn.guo@linaro.org>
 <87ee3m2aed.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee3m2aed.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, Mar 01, 2022 at 11:13:30AM +0000, Marc Zyngier wrote:
> Hi Shawn,
> 
> On Tue, 01 Mar 2022 06:24:14 +0000,
> Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > Qualcomm SoCs based on the RPM architecture have a MSM Power Manager (MPM)
> > in always-on domain. In addition to managing resources during sleep, the
> > hardware also has an interrupt controller that monitors the interrupts
> > when the system is asleep, wakes up the APSS when one of these interrupts
> > occur and replays it to GIC after it becomes operational.
> > 
> > It adds an irqchip driver for this interrupt controller, and here are
> > some notes about it.
> > 
> > - For given SoC, a fixed number of MPM pins are supported, e.g. 96 pins
> >   on QCM2290.  Each of these MPM pins can be either a MPM_GIC pin or
> >   a MPM_GPIO pin. The mapping between MPM_GIC pin and GIC interrupt
> >   is defined by SoC, as well as the mapping between MPM_GPIO pin and
> >   GPIO number.  The former mapping is retrieved from device tree, while
> >   the latter is defined in TLMM pinctrl driver.
> > 
> > - qcom_mpm_enter_sleep() is called from power domain (PD) .power_off
> >   hook to notify RPM that APSS is about to power collapse.  This
> >   requires MPM PD be the parent PD of CPU cluster.
> 
> Glad that you fixed that one. I guess that for RPM, this is too late
> and that we're stuck with the existing stuff?

I guess you are talking about rpmh_rsc_cpu_pm_callback() in rpmh-rsc
driver?  If so, yes, if we want to maintain the DTB compatibility, the
existing code needs to be there anyway, since power domain approach
requires a dt-bindings change.

> 
> > 
> > - When SoC gets awake from sleep mode, the driver will receive an
> >   interrupt from RPM, so that it can replay interrupt for particular
> >   polarity.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/irqchip/Kconfig        |   8 +
> >  drivers/irqchip/Makefile       |   1 +
> >  drivers/irqchip/irq-qcom-mpm.c | 448 +++++++++++++++++++++++++++++++++
> >  3 files changed, 457 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-qcom-mpm.c
> > 
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 7038957f4a77..680d2fcf2686 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -430,6 +430,14 @@ config QCOM_PDC
> >  	  Power Domain Controller driver to manage and configure wakeup
> >  	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
> >  
> > +config QCOM_MPM
> > +	tristate "QCOM MPM"
> > +	depends on ARCH_QCOM
> > +	select IRQ_DOMAIN_HIERARCHY
> > +	help
> > +	  MSM Power Manager driver to manage and configure wakeup
> > +	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
> > +
> >  config CSKY_MPINTC
> >  	bool
> >  	depends on CSKY
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index c1f611cbfbf8..1f8990f812f1 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -94,6 +94,7 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
> >  obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
> >  obj-$(CONFIG_NDS32)			+= irq-ativic32.o
> >  obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
> > +obj-$(CONFIG_QCOM_MPM)			+= irq-qcom-mpm.o
> >  obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
> >  obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
> >  obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
> > diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
> > new file mode 100644
> > index 000000000000..f4409c169a3a
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-qcom-mpm.c
> > @@ -0,0 +1,448 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2021, Linaro Limited
> > + * Copyright (c) 2010-2020, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/arm-gic-v3.h>
> 
> Please drop this. Nobody apart from the GIC drivers themselves, KVM
> (which implements a GIC), and the arch code (which deals with
> interrupt priorities) should ever include it.

Indeed!  It's not needed here.

> 
> > +#include <linux/irqdomain.h>
> > +#include <linux/mailbox_client.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/slab.h>
> > +#include <linux/soc/qcom/irq.h>
> > +#include <linux/spinlock.h>
> > +
> > +/*
> > + * This is the driver for Qualcomm MPM (MSM Power Manager) interrupt controller,
> > + * which is commonly found on Qualcomm SoCs built on the RPM architecture.
> > + * Sitting in always-on domain, MPM monitors the wakeup interrupts when SoC is
> > + * asleep, and wakes up the AP when one of those interrupts occurs.  This driver
> > + * doesn't directly access physical MPM registers though.  Instead, the access
> > + * is bridged via a piece of internal memory (SRAM) that is accessible to both
> > + * AP and RPM.  This piece of memory is called 'vMPM' in the driver.
> > + *
> > + * When SoC is awake, the vMPM is owned by AP and the register setup by this
> > + * driver all happens on vMPM.  When AP is about to get power collapsed, the
> > + * driver sends a mailbox notification to RPM, which will take over the vMPM
> > + * ownership and dump vMPM into physical MPM registers.  On wakeup, AP is woken
> > + * up by a MPM pin/interrupt, and RPM will copy STATUS registers into vMPM.
> > + * Then AP start owning vMPM again.
> > + *
> > + * vMPM register map:
> > + *
> > + *    31                              0
> > + *    +--------------------------------+
> > + *    |            TIMER0              | 0x00
> > + *    +--------------------------------+
> > + *    |            TIMER1              | 0x04
> > + *    +--------------------------------+
> > + *    |            ENABLE0             | 0x08
> > + *    +--------------------------------+
> > + *    |              ...               | ...
> > + *    +--------------------------------+
> > + *    |            ENABLEn             |
> > + *    +--------------------------------+
> > + *    |          FALLING_EDGE0         |
> > + *    +--------------------------------+
> > + *    |              ...               |
> > + *    +--------------------------------+
> > + *    |            STATUSn             |
> > + *    +--------------------------------+
> > + *
> > + *    n = DIV_ROUND_UP(pin_cnt, 32)
> > + *
> > + */
> > +
> > +#define MPM_REG_ENABLE		0
> > +#define MPM_REG_FALLING_EDGE	1
> > +#define MPM_REG_RISING_EDGE	2
> > +#define MPM_REG_POLARITY	3
> > +#define MPM_REG_STATUS		4
> > +
> > +/* MPM pin map to GIC hwirq */
> > +struct mpm_gic_map {
> > +	int pin;
> > +	irq_hw_number_t hwirq;
> > +};
> > +
> > +struct qcom_mpm_priv {
> > +	void __iomem *base;
> > +	raw_spinlock_t lock;
> > +	struct mbox_client mbox_client;
> > +	struct mbox_chan *mbox_chan;
> > +	struct mpm_gic_map *maps;
> > +	unsigned int map_cnt;
> > +	unsigned int reg_stride;
> > +	struct irq_domain *domain;
> > +	struct generic_pm_domain genpd;
> > +};
> > +
> > +static u32 qcom_mpm_read(struct qcom_mpm_priv *priv, unsigned int reg,
> > +			 unsigned int index)
> > +{
> > +	unsigned int offset = (reg * priv->reg_stride + index + 2) * 4;
> > +
> > +	return readl_relaxed(priv->base + offset);
> > +}
> > +
> > +static void qcom_mpm_write(struct qcom_mpm_priv *priv, unsigned int reg,
> > +			   unsigned int index, u32 val)
> > +{
> > +	unsigned int offset = (reg * priv->reg_stride + index + 2) * 4;
> > +
> > +	writel_relaxed(val, priv->base + offset);
> > +
> > +	/* Ensure the write is completed */
> > +	wmb();
> > +}
> > +
> > +static void qcom_mpm_enable_irq(struct irq_data *d, bool en)
> > +{
> > +	struct qcom_mpm_priv *priv = d->chip_data;
> > +	int pin = d->hwirq;
> > +	unsigned int index = pin / 32;
> > +	unsigned int shift = pin % 32;
> > +	unsigned long flags;
> > +	u32 val;
> > +
> > +	raw_spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	val = qcom_mpm_read(priv, MPM_REG_ENABLE, index);
> > +	if (en)
> > +		val |= BIT(shift);
> > +	else
> > +		val &= ~BIT(shift);
> > +	qcom_mpm_write(priv, MPM_REG_ENABLE, index, val);
> > +
> > +	raw_spin_unlock_irqrestore(&priv->lock, flags);
> 
> __assign_bit() is what you want:

OK, thanks!

> 
> @@ -112,16 +111,12 @@ static void qcom_mpm_enable_irq(struct irq_data *d, bool en)
>  	int pin = d->hwirq;
>  	unsigned int index = pin / 32;
>  	unsigned int shift = pin % 32;
> -	unsigned long flags;
> -	u32 val;
> +	unsigned long flags, val;
>  
>  	raw_spin_lock_irqsave(&priv->lock, flags);
>  
>  	val = qcom_mpm_read(priv, MPM_REG_ENABLE, index);
> -	if (en)
> -		val |= BIT(shift);
> -	else
> -		val &= ~BIT(shift);
> +	__assign_bit(shift, &val, en);
>  	qcom_mpm_write(priv, MPM_REG_ENABLE, index, val);
>  
>  	raw_spin_unlock_irqrestore(&priv->lock, flags);
> 
> > +}
> > +
> > +static void qcom_mpm_mask(struct irq_data *d)
> > +{
> > +	qcom_mpm_enable_irq(d, false);
> > +
> > +	if (d->parent_data)
> > +		irq_chip_mask_parent(d);
> > +}
> > +
> > +static void qcom_mpm_unmask(struct irq_data *d)
> > +{
> > +	qcom_mpm_enable_irq(d, true);
> > +
> > +	if (d->parent_data)
> > +		irq_chip_unmask_parent(d);
> > +}
> > +
> > +static void mpm_set_type(struct qcom_mpm_priv *priv, bool set, unsigned int reg,
> > +			 unsigned int index, unsigned int shift)
> > +{
> > +	unsigned long flags;
> > +	u32 val;
> > +
> > +	raw_spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	val = qcom_mpm_read(priv, reg, index);
> > +	if (set)
> > +		val |= BIT(shift);
> > +	else
> > +		val &= ~BIT(shift);
> > +	qcom_mpm_write(priv, reg, index, val);
> > +
> > +	raw_spin_unlock_irqrestore(&priv->lock, flags);
> 
> Same thing:
> 
> @@ -146,16 +141,12 @@ static void qcom_mpm_unmask(struct irq_data *d)
>  static void mpm_set_type(struct qcom_mpm_priv *priv, bool set, unsigned int reg,
>  			 unsigned int index, unsigned int shift)
>  {
> -	unsigned long flags;
> -	u32 val;
> +	unsigned long flags, val;
>  
>  	raw_spin_lock_irqsave(&priv->lock, flags);
>  
>  	val = qcom_mpm_read(priv, reg, index);
> -	if (set)
> -		val |= BIT(shift);
> -	else
> -		val &= ~BIT(shift);
> +	__assign_bit(shift, &val, set);
>  	qcom_mpm_write(priv, reg, index, val);
>  
>  	raw_spin_unlock_irqrestore(&priv->lock, flags);
> 
> > +}
> > +
> > +static int qcom_mpm_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +	struct qcom_mpm_priv *priv = d->chip_data;
> > +	int pin = d->hwirq;
> > +	unsigned int index = pin / 32;
> > +	unsigned int shift = pin % 32;
> > +
> > +	switch (type & IRQ_TYPE_SENSE_MASK) {
> > +	case IRQ_TYPE_EDGE_RISING:
> > +		mpm_set_type(priv, !!(type & IRQ_TYPE_EDGE_RISING),
> > +			     MPM_REG_RISING_EDGE, index, shift);
> > +		break;
> > +	case IRQ_TYPE_EDGE_FALLING:
> > +		mpm_set_type(priv, !!(type & IRQ_TYPE_EDGE_FALLING),
> > +			     MPM_REG_FALLING_EDGE, index, shift);
> > +		break;
> > +	case IRQ_TYPE_LEVEL_HIGH:
> > +		mpm_set_type(priv, !!(type & IRQ_TYPE_LEVEL_HIGH),
> > +			     MPM_REG_POLARITY, index, shift);
> > +		break;
> > +	}
> 
> All these '!!(type & BLAH)' are totally superfluous, as they all expand
> to 'true' by construction.

Yes, you are right!

> And this leads to a few questions:
> 
> - Shouldn't a rising interrupt clear the falling detection?
> - Shouldn't a level-low clear the polarity?
> - How do you handle IRQ_TYPE_EDGE_BOTH?
> - How is MPM_REG_POLARITY evaluated for edge interrupts (resp the EDGE
>   registers for level interrupts), as you never seem to be configuring
>   a type here?

Honestly, qcom_mpm_set_type() was mostly taken from downstream without
too much thinking.  I trusted it as a "good" reference as I have no
document to verify the code.  These questions are great and resulted the
code changes are pretty sensible to me.

> - What initialises the MPM trigger types at boot time?

I dumped the vMPM region and it's all zeros.  My understanding is if
vMPM needs any sort of initialization, it should be done by RPM firmware
before APSS gets booting.

> 
> I came up with this, but that's probably not enough (boot time init is
> definitely missing):

Thanks much!

> 
> @@ -170,16 +161,22 @@ static int qcom_mpm_set_type(struct irq_data *d, unsigned int type)
>  
>  	switch (type & IRQ_TYPE_SENSE_MASK) {
>  	case IRQ_TYPE_EDGE_RISING:
> -		mpm_set_type(priv, !!(type & IRQ_TYPE_EDGE_RISING),
> -			     MPM_REG_RISING_EDGE, index, shift);
> +		mpm_set_type(priv, true, MPM_REG_RISING_EDGE, index, shift);
> +		mpm_set_type(priv, false, MPM_REG_FALLING_EDGE, index, shift);
>  		break;
>  	case IRQ_TYPE_EDGE_FALLING:
> -		mpm_set_type(priv, !!(type & IRQ_TYPE_EDGE_FALLING),
> -			     MPM_REG_FALLING_EDGE, index, shift);
> +		mpm_set_type(priv, false, MPM_REG_RISING_EDGE, index, shift);
> +		mpm_set_type(priv, true, MPM_REG_FALLING_EDGE, index, shift);
> +		break;
> +	case IRQ_TYPE_EDGE_BOTH:
> +		mpm_set_type(priv, true, MPM_REG_RISING_EDGE, index, shift);
> +		mpm_set_type(priv, true, MPM_REG_FALLING_EDGE, index, shift);
>  		break;
>  	case IRQ_TYPE_LEVEL_HIGH:
> -		mpm_set_type(priv, !!(type & IRQ_TYPE_LEVEL_HIGH),
> -			     MPM_REG_POLARITY, index, shift);
> +		mpm_set_type(priv, true, MPM_REG_POLARITY, index, shift);
> +		break;
> +	case IRQ_TYPE_LEVEL_LOW:
> +		mpm_set_type(priv, false, MPM_REG_POLARITY, index, shift);
>  		break;
>  	}
> 
> > +
> > +	if (!d->parent_data)
> > +		return 0;
> > +
> > +	if (type & IRQ_TYPE_EDGE_BOTH)
> > +		type = IRQ_TYPE_EDGE_RISING;
> > +
> > +	if (type & IRQ_TYPE_LEVEL_MASK)
> > +		type = IRQ_TYPE_LEVEL_HIGH;
> > +
> > +	return irq_chip_set_type_parent(d, type);
> > +}
> > +
> > +static struct irq_chip qcom_mpm_chip = {
> > +	.name			= "mpm",
> > +	.irq_eoi		= irq_chip_eoi_parent,
> > +	.irq_mask		= qcom_mpm_mask,
> > +	.irq_unmask		= qcom_mpm_unmask,
> > +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> > +	.irq_set_type		= qcom_mpm_set_type,
> > +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> > +	.flags			= IRQCHIP_MASK_ON_SUSPEND |
> > +				  IRQCHIP_SKIP_SET_WAKE,
> > +};
> > +
> > +static struct mpm_gic_map *get_mpm_gic_map(struct qcom_mpm_priv *priv, int pin)
> > +{
> > +	struct mpm_gic_map *maps = priv->maps;
> > +	int i;
> > +
> > +	for (i = 0; i < priv->map_cnt; i++) {
> > +		if (maps[i].pin == pin)
> > +			return &maps[i];
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static int qcom_mpm_alloc(struct irq_domain *domain, unsigned int virq,
> > +			  unsigned int nr_irqs, void *data)
> > +{
> > +	struct qcom_mpm_priv *priv = domain->host_data;
> > +	struct irq_fwspec *fwspec = data;
> > +	struct irq_fwspec parent_fwspec;
> > +	struct mpm_gic_map *map;
> > +	irq_hw_number_t hwirq;
> > +	unsigned int type;
> > +	int  ret;
> > +
> > +	ret = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
> > +					    &qcom_mpm_chip, priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	map = get_mpm_gic_map(priv, hwirq);
> > +	if (map == NULL)
> > +		return irq_domain_disconnect_hierarchy(domain->parent, virq);
> > +
> > +	if (type & IRQ_TYPE_EDGE_BOTH)
> > +		type = IRQ_TYPE_EDGE_RISING;
> > +
> > +	if (type & IRQ_TYPE_LEVEL_MASK)
> > +		type = IRQ_TYPE_LEVEL_HIGH;
> > +
> > +	parent_fwspec.fwnode = domain->parent->fwnode;
> > +	parent_fwspec.param_count = 3;
> > +	parent_fwspec.param[0] = 0;
> > +	parent_fwspec.param[1] = map->hwirq;
> > +	parent_fwspec.param[2] = type;
> > +
> > +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
> > +					    &parent_fwspec);
> > +}
> > +
> > +static const struct irq_domain_ops qcom_mpm_ops = {
> > +	.alloc		= qcom_mpm_alloc,
> > +	.free		= irq_domain_free_irqs_common,
> > +	.translate	= irq_domain_translate_twocell,
> > +};
> > +
> > +/* Triggered by RPM when system resumes from deep sleep */
> > +static irqreturn_t qcom_mpm_handler(int irq, void *dev_id)
> > +{
> > +	struct qcom_mpm_priv *priv = dev_id;
> > +	unsigned long enable, pending;
> > +	irqreturn_t ret = IRQ_NONE;
> > +	unsigned long flags;
> > +	int i, j;
> > +
> > +	for (i = 0; i < priv->reg_stride; i++) {
> > +		raw_spin_lock_irqsave(&priv->lock, flags);
> > +		enable = qcom_mpm_read(priv, MPM_REG_ENABLE, i);
> > +		pending = qcom_mpm_read(priv, MPM_REG_STATUS, i);
> > +		pending &= enable;
> > +		raw_spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +		for_each_set_bit(j, &pending, 32) {
> > +			unsigned int pin = 32 * i + j;
> > +			struct irq_desc *desc = irq_resolve_mapping(priv->domain, pin);
> > +			struct irq_data *d = &desc->irq_data;
> > +
> > +			if (!irqd_is_level_type(d))
> > +				irq_set_irqchip_state(d->irq,
> > +						IRQCHIP_STATE_PENDING, true);
> > +			ret = IRQ_HANDLED;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int qcom_mpm_enter_sleep(struct qcom_mpm_priv *priv)
> > +{
> > +	int i, ret;
> > +
> > +	for (i = 0; i < priv->reg_stride; i++)
> > +		qcom_mpm_write(priv, MPM_REG_STATUS, i, 0);
> > +
> > +	/* Notify RPM to write vMPM into HW */
> > +	ret = mbox_send_message(priv->mbox_chan, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mpm_pd_power_off(struct generic_pm_domain *genpd)
> > +{
> > +	struct qcom_mpm_priv *priv = container_of(genpd, struct qcom_mpm_priv,
> > +						  genpd);
> > +
> > +	return qcom_mpm_enter_sleep(priv);
> > +}
> 
> Merge these two functions:

OK.  Thanks for all these code changes!

Shawn

> 
> @@ -297,8 +294,10 @@ static irqreturn_t qcom_mpm_handler(int irq, void *dev_id)
>  	return ret;
>  }
>  
> -static int qcom_mpm_enter_sleep(struct qcom_mpm_priv *priv)
> +static int mpm_pd_power_off(struct generic_pm_domain *genpd)
>  {
> +	struct qcom_mpm_priv *priv = container_of(genpd, struct qcom_mpm_priv,
> +						  genpd);
>  	int i, ret;
>  
>  	for (i = 0; i < priv->reg_stride; i++)
> @@ -312,14 +311,6 @@ static int qcom_mpm_enter_sleep(struct qcom_mpm_priv *priv)
>  	return 0;
>  }
>  
> -static int mpm_pd_power_off(struct generic_pm_domain *genpd)
> -{
> -	struct qcom_mpm_priv *priv = container_of(genpd, struct qcom_mpm_priv,
> -						  genpd);
> -
> -	return qcom_mpm_enter_sleep(priv);
> -}
> -
>  static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>  {
>  	struct platform_device *pdev = of_find_device_by_node(np);
