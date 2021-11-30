Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691EA462A81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbhK3CfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbhK3CfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:35:17 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64958C061746
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:31:59 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n85so18959527pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lG4AjBhC5J+FzFODL5/WiViCKaMNWbKXs7i/Pntm3u0=;
        b=HVQtWkksKbh4dpVWQ84wWG2SFnZoPFhI3oIk9l6ecGeD4zYaTAcgVRun84uDjfFpE1
         ORJJjmRfLwfrIcmglkd1hWOPjQHltuq06RGvLiOJ8tvyRJxulljc0oJouVcI6qn8fDy7
         8TY41w/qdoeZhN+2SgIP5Oe0nX4z4l9aI+VGXBeQibgjArQUhuC8eFqHzQhWwVCVw6k1
         KJmDyR18xG20k5ETaSYEye+3C5lzrT/VBEbok5zfXJGG9f7h/CIIEhAuzW6iFSMn/9m4
         qB7sl9x9DvHxiY/tNqVja+1q3yP/tnD/nGG2MceuCrtJNnVQwi4NohJ8m8eQLDSyMgiU
         R16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lG4AjBhC5J+FzFODL5/WiViCKaMNWbKXs7i/Pntm3u0=;
        b=ibdU4AHSu+Sd/n1Q1yYeT6qenRpQ9QalB71Iu5yaBjK+EueTxagkQrmkdMdcWu0i68
         c+WOQLUcI3PPMSjcOiVs1TzXNIa4x9Xw8pffrz2Ne9PNzYz0coUzWoZmMddk5dFUKKZf
         O5InMyTyqDlmH6Xhxq3+QZ1rwoZaJtyqyjdJM3OgOlKVVPDddig65OsgMkCa6aeo/LNc
         2jeCd9yblA3fGNzRZgbByvDzjc4pHfyrcRN6gmixGGZHZac2Ig575rptUyDeM6DYA4BL
         DlVfap91U+18TS+4xGA9Gq0RyDGWdxtOqebbaW/YPdFo+H/wrBxytXx7Ne/7EfqbQZT3
         56Fg==
X-Gm-Message-State: AOAM531Ka1rSZnJe9DXLc3p/XSoZCq6Zdsvhn+71dtvSL/6jRLummZ/A
        aVQzU7/GDE4OYRVUhQMSAcdDWw==
X-Google-Smtp-Source: ABdhPJxff0dhZRIljktLh4G9EqseIFJQwUueHfOYkEOwVc1wgEagjPY6x8uzMcuH52H/G2qbej52vQ==
X-Received: by 2002:a63:4a63:: with SMTP id j35mr38381313pgl.409.1638239518796;
        Mon, 29 Nov 2021 18:31:58 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id p16sm19781258pfh.97.2021.11.29.18.31.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Nov 2021 18:31:58 -0800 (PST)
Date:   Tue, 30 Nov 2021 10:31:52 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] irqchip: Add Qualcomm MPM controller driver
Message-ID: <20211130023151.GD10105@dragon>
References: <20211126093529.31661-1-shawn.guo@linaro.org>
 <20211126093529.31661-3-shawn.guo@linaro.org>
 <87czmmbu8k.wl-maz@kernel.org>
 <20211129133308.GB10105@dragon>
 <87pmqjm1c8.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmqjm1c8.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Maulik

On Mon, Nov 29, 2021 at 03:24:39PM +0000, Marc Zyngier wrote:
[...]
> > > > @@ -430,6 +430,14 @@ config QCOM_PDC
> > > >  	  Power Domain Controller driver to manage and configure wakeup
> > > >  	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
> > > >  
> > > > +config QCOM_MPM
> > > > +	bool "QCOM MPM"
> > > 
> > > Can't be built as a module?
> > 
> > The driver is implemented as a builtin_platform_driver().
> 
> This, on its own, shouldn't preclude the driver from being built as a
> module. However, the config option only allows it to be built in. Why?

I just tried to build it as a module, and it seems that "irq_to_desc" is
only available for built-in build.

> 
> [...]
> 
> > > > +static inline void
> > > > +qcom_mpm_write(struct qcom_mpm_priv *priv, unsigned int reg,
> > > > +	       unsigned int index, u32 val)
> > > > +{
> > > > +	unsigned int offset = (reg * priv->reg_stride + index + 2) * 4;
> > > > +	u32 r_val;
> > > > +
> > > > +	writel(val, priv->base + offset);
> > > > +
> > > > +	do {
> > > > +		r_val = readl(priv->base + offset);
> > > > +		udelay(5);
> > > > +	} while (r_val != val);
> > > 
> > > What? Is this waiting for a bit to clear? Why isn't this one of the
> > > read*_poll_timeout*() function instead? Surely you can't wait forever
> > > here.
> > 
> > This is taken from downstream, and it seems to double check the written
> > value by reading it back.  But to be honest, I'm not really this is
> > necessary.  I will do some testing with the read-back check dropped.
> 
> How about asking for specs instead? There are QC people on Cc, and
> many more reading the list. Hopefully they can explain what this is
> all about.

Maulik,

If you have some information about this, that would be great.

> 
> > > 
> > > > +}
> > > > +
> > > > +static inline void qcom_mpm_enable_irq(struct irq_data *d, bool en)
> > > > +{
> > > > +	struct qcom_mpm_priv *priv = d->domain->host_data;
> > > 
> > > This really should be stored in d->chip_data.
> > 
> > OK.
> > 
> > > 
> > > > +	int pin = d->hwirq;
> > > > +	unsigned int index = pin / 32;
> > > > +	unsigned int shift = pin % 32;
> > > > +	unsigned long flags;
> > > > +	u32 val;
> > > > +
> > > > +	priv->pin_to_irq[pin] = d->irq;
> > > 
> > > This makes no sense. This is only reinventing the very notion of an
> > > irq domain, which is to lookup the Linux interrupt based on a context
> > > and a signal number.
> > 
> > The uniqueness of this driver is that it has two irq domains.  This
> > little lookup table is created to avoid resolving mapping on each of
> > these domains, which is less efficient.  But you think this is really
> > nonsense, I can change.
> 
> "efficient"? You are taking an interrupt to... err... reinject some
> other interrupts. I'm sorry, but the efficiency argument sailed once
> someone built this wonderful piece of HW. The first mistake was to
> involve SW here, so let's not optimise for something that really
> doesn't need it.

OK.

> 
> Furthermore, why would you look up anywhere other than the wake-up
> domain? My impression was that only these interrupts would require
> being re-triggered.

Both domains have MPM pins that could wake up system.

> 
> [...]
> 
> > > > +static inline void
> > > > +mpm_set_type(struct qcom_mpm_priv *priv, bool set, unsigned int reg,
> > > > +	     unsigned int index, unsigned int shift)
> > > > +{
> > > > +	u32 val;
> > > > +
> > > > +	val = qcom_mpm_read(priv, reg, index);
> > > > +	if (set)
> > > > +		val |= 1 << shift;
> > > > +	else
> > > > +		val &= ~(1 << shift);
> > > > +	qcom_mpm_write(priv, reg, index, val);
> > > > +}
> > > > +
> > > > +static int qcom_mpm_set_type(struct irq_data *d, unsigned int type)
> > > > +{
> > > > +	struct qcom_mpm_priv *priv = d->domain->host_data;
> > > > +	int pin = d->hwirq;
> > > > +	unsigned int index = pin / 32;
> > > > +	unsigned int shift = pin % 32;
> > > > +	unsigned long flags;
> > > > +
> > > > +	spin_lock_irqsave(&priv->lock, flags);
> > > > +
> > > > +	mpm_set_type(priv, (type & IRQ_TYPE_EDGE_RISING) ? 1 : 0,
> > > 
> > > You have a bool type as the second parameter. Why the convoluted ?:
> > > operator?
> > 
> > Will change to !!(type & IRQ_TYPE_EDGE_RISING).
> > 
> > > 
> > > > +		     MPM_REG_RISING_EDGE, index, shift);
> > > > +	mpm_set_type(priv, (type & IRQ_TYPE_EDGE_FALLING) ? 1 : 0,
> > > > +		     MPM_REG_FALLING_EDGE, index, shift);
> > > > +	mpm_set_type(priv, (type & IRQ_TYPE_LEVEL_HIGH) ? 1 : 0,
> > > > +		     MPM_REG_POLARITY, index, shift);
> > > 
> > > Why does this mean for an edge interrupt?
> > 
> > Edge polarity is configured above on MPM_REG_RISING_EDGE and
> > MPM_REG_FALLING_EDGE.  So I guess MPM_REG_POLARITY doesn't have an
> > impact on edge interrupt.  I do not have any document or information
> > other than downstream code to be sure though.
> 
> A well formed 'type' will have that bit clear when any of the EDGE
> flags is set. So this will always be 0. It would also be much better
> if you expressed the whole thing as a switch/case.

OK.

> 
> [...]
> 
> > > > +static int qcom_mpm_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct irq_domain *parent_domain, *mpm_gic_domain, *mpm_gpio_domain;
> > > > +	struct device *dev = &pdev->dev;
> > > > +	struct device_node *np = dev->of_node;
> > > > +	struct device_node *parent = of_irq_find_parent(np);
> > > > +	struct qcom_mpm_priv *priv;
> > > > +	unsigned int pin_num;
> > > > +	int irq;
> > > > +	int ret;
> > > > +
> > > > +	/* See comments in platform_irqchip_probe() */
> > > > +	if (parent && !irq_find_matching_host(parent, DOMAIN_BUS_ANY))
> > > > +		return -EPROBE_DEFER;
> > > 
> > > So why aren't you using that infrastructure?
> > 
> > Because I need to populate .pm of platform_driver and use match data to
> > pass mpm_data.
> 
> Then I'd rather you improve the existing infrastructure to pass the
> bit of extra data you need, instead than reinventing your own.

OK.  I will see what I can do here.

> 
> [...]
> 
> > > > +	priv->mbox_client.dev = dev;
> > > > +	priv->mbox_chan = mbox_request_channel(&priv->mbox_client, 0);
> > > > +	if (IS_ERR(priv->mbox_chan)) {
> > > > +		ret = PTR_ERR(priv->mbox_chan);
> > > > +		dev_err(dev, "failed to acquire IPC channel: %d\n", ret);
> > > > +		goto remove_gpio_domain;
> > > 
> > > Why don't you request this first, before all the allocations?
> > 
> > Then I will need to call mbox_free_channel() for any allocation failures
> > afterward.
> 
> Which would be fine. Checking for dependencies before allocating
> resources is good practice, specially when this can result in a probe
> deferral.

Good point, thanks!

Shawn
