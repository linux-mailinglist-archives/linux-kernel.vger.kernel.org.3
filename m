Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C146969F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244212AbhLFNTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244194AbhLFNTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:19:06 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64040C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 05:15:38 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x131so10086373pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 05:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HwaHWN7G8+xCLyfssIqI43tmQKOkAF6o7H366O1fLaA=;
        b=XSpi4ypOGQpTCnJuUcdZyw/iW8KBGaqlEr/2ayA8WbHvMliK8JSIK+DWSdfFbepHXs
         LVO8eePip6LU+Rppjc+Pq8o27c4/J0S5kccPxkev99hYav5f/2ApghkD+dgYtUUGK1D0
         O40q0AzK0KiEKVDD24SBXpYQ+W7CN26dXW9baGjvkDd9BQhPinWUwO9GvI8ayHLVCrH2
         emFm+q7AqCOX8ERFCT9+/G+rXEyP7R8sXHBdhG0B2LXYC1WLKVbcGmjeVOOb9di7bdgt
         P+VjvRrna+T9WFuBz+xlBYbm9Z2UTDMukNLKETEhV1f13Pl3Ibrd0JD9/yta8voILDhN
         xspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HwaHWN7G8+xCLyfssIqI43tmQKOkAF6o7H366O1fLaA=;
        b=MTwb9HFt96Oe0gOu4LWPyoW9ON85Cs89vp2uGWag08Z/pvWWODDBXb3faLl6a9VMxU
         5xFvoJ6soWnXChi0wAdK8yi2uoCINQYPbPTErcYuON+5/AjUQSA4NUy211QHQEx0mXmi
         kBr2KbmmV4pARI4Ls6O06kKnfh3QgONpda+seJusIYA5N3yWMd2GTROr20hOYj34oSv5
         QBUjYJ017V02q1CJssVWQSePVlJRI4UzaS62zQ5n1KfEhH1oYGIeVp3+gCWkLQimSGCY
         M2nzLpnxGiJYenJ42NlqTpVxHS+PF4Ig66mAVBwpsZhRgYNmzlNvZC8mfcsUqYuDHBmX
         Gw3w==
X-Gm-Message-State: AOAM530q5jPatErgbVypzDLOMgVdNCgLDfVQ5Wtfpf8ZpKiISS00iWpw
        dpH07sMIz0psIji8nDnMLSNi9A==
X-Google-Smtp-Source: ABdhPJyF2Stkv/D6QBdfAYev+oaGr18Jinm5jxI+qCYT0YELDtubbL9uNSOklbEalxT68/aRgvs7sA==
X-Received: by 2002:a63:7103:: with SMTP id m3mr601552pgc.376.1638796537791;
        Mon, 06 Dec 2021 05:15:37 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id t38sm5351975pfg.199.2021.12.06.05.15.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Dec 2021 05:15:37 -0800 (PST)
Date:   Mon, 6 Dec 2021 21:15:31 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] irqchip: Add Qualcomm MPM controller driver
Message-ID: <20211206131530.GN10105@dragon>
References: <20211202122122.23548-1-shawn.guo@linaro.org>
 <20211202122122.23548-4-shawn.guo@linaro.org>
 <87wnkikqve.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnkikqve.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 09:46:29AM +0000, Marc Zyngier wrote:
[...]
> > +/* Triggered by RPM when system resumes from deep sleep */
> > +static irqreturn_t qcom_mpm_handler(int irq, void *dev_id)
> > +{
> > +	struct qcom_mpm_priv *priv = dev_id;
> > +	unsigned long enable, pending;
> > +	int i, j;
> > +
> > +	for (i = 0; i < priv->reg_stride; i++) {
> > +		enable = qcom_mpm_read(priv, MPM_REG_ENABLE, i);
> > +		pending = qcom_mpm_read(priv, MPM_REG_STATUS, i);
> > +		pending &= enable;
> > +
> > +		for_each_set_bit(j, &pending, 32) {
> > +			unsigned int pin = 32 * i + j;
> > +			struct irq_desc *desc =
> > +					irq_resolve_mapping(priv->domain, pin);
> 
> Assignments on a single line, please.

This is to avoid over 80 columns check patch warning.

> 
> > +			struct irq_data *d = &desc->irq_data;
> > +
> > +			if (!irqd_is_level_type(d))
> > +				irq_set_irqchip_state(d->irq,
> > +						IRQCHIP_STATE_PENDING, true);
> > +
> > +		}
> > +	}
> > +
> > +	return IRQ_HANDLED;
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
> 
> What do you mean by 'into HW'? We just did that, right? or are these
> registers just fake and most of the stuff is in the RPM?

I have a note about this in commit log.

- All the register settings are done by APSS on an internal memory
  region called vMPM, and RPM will flush them into hardware after it
  receives a mailbox/IPC notification from APSS.

So yes, these registers are fake/virtual in memory, and RPM will
actually flush the values into the MPM hardware block.

> 
> > +	ret = mbox_send_message(priv->mbox_chan, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int qcom_mpm_cpu_pm_callback(struct notifier_block *nb,
> > +				    unsigned long action, void *data)
> > +{
> > +	struct qcom_mpm_priv *priv = container_of(nb, struct qcom_mpm_priv,
> > +						  pm_nb);
> > +	int ret = NOTIFY_OK;
> > +	int cpus_in_pm;
> > +
> > +	switch (action) {
> > +	case CPU_PM_ENTER:
> > +		cpus_in_pm = atomic_inc_return(&priv->cpus_in_pm);
> > +		/*
> > +		 * NOTE: comments for num_online_cpus() point out that it's
> > +		 * only a snapshot so we need to be careful. It should be OK
> > +		 * for us to use, though.  It's important for us not to miss
> > +		 * if we're the last CPU going down so it would only be a
> > +		 * problem if a CPU went offline right after we did the check
> > +		 * AND that CPU was not idle AND that CPU was the last non-idle
> > +		 * CPU. That can't happen. CPUs would have to come out of idle
> > +		 * before the CPU could go offline.
> > +		 */
> > +		if (cpus_in_pm < num_online_cpus())
> > +			return NOTIFY_OK;
> > +		break;
> 
> I'm really not keen on this sort of tracking in an irqchip driver.
> Nobody else needs this. This is also copy-pasted (without even
> mentioning it) from rpmh_rsc_cpu_pm_callback(). Why is that logic
> needed twice, given that the RPM is also involved is this sequence?

Yes, this is copy-pasted from rpmh-rsc and I should have mentioned that
in some way.  But rpmh-rsc is a driver specific to RPM-Hardened (RPMH)
which can be found on Qualcomm high-range SoCs like SDM845, SC7180.  And
on these RPMH based SoCs, PDC works as the wake-up interrupt controller.
However, on mid-range SoCs like SDM660, QCM2290, they run a different
combination, that is RPM + MPM.  Note - RPMH and RPM are two similar but
different and separate blocks.

What we are implementing is for RPM + MPM based SoCs, and rpmh-rsc is
irrelevant here.  The same cpu_pm tracking logic can be reused though.

> 
> > +	case CPU_PM_ENTER_FAILED:
> > +	case CPU_PM_EXIT:
> > +		atomic_dec(&priv->cpus_in_pm);
> > +		return NOTIFY_OK;
> > +	default:
> > +		return NOTIFY_DONE;
> > +	}
> > +
> > +	/*
> > +	 * It's likely we're on the last CPU. Grab the lock and write MPM for
> > +	 * sleep. Grabbing the lock means that if we race with another CPU
> > +	 * coming up we are still guaranteed to be safe.
> > +	 */
> > +	if (raw_spin_trylock(&priv->lock)) {
> > +		if (qcom_mpm_enter_sleep(priv))
> > +			ret = NOTIFY_BAD;
> > +		raw_spin_unlock(&priv->lock);
> > +	} else {
> > +		/* Another CPU must be up */
> > +		return NOTIFY_OK;
> > +	}
> > +
> > +	if (ret == NOTIFY_BAD) {
> > +		/* Double-check if we're here because someone else is up */
> > +		if (cpus_in_pm < num_online_cpus())
> > +			ret = NOTIFY_OK;
> > +		else
> > +			/* We won't be called w/ CPU_PM_ENTER_FAILED */
> > +			atomic_dec(&priv->cpus_in_pm);
> > +	}
> > +
> > +	return ret;
> > +}

[...]

> > +/*
> > + * The mapping between MPM_GIC pin and GIC SPI number on QCM2290.  It's taken
> > + * from downstream qcom-mpm-scuba.c with a little transform on the GIC
> > + * SPI numbers (the second column).  Due to the binding difference from
> > + * the downstream, where GIC SPI numbering starts from 32, we expect the
> > + * numbering starts from 0 here, and that's why we have the number minus 32
> > + * comparing to the downstream.
> 
> This doesn't answer my earlier question: is this list complete? Or is
> it likely to change?

Yes, it's complete for QCM2290.

> Also, why is that in not in the device tree,
> given that it is likely to change from one SoC to another?

Yes, this is a SoC specific data, and will be different from one SoC to
another.  Different subsystem maintainers have different views on such
SoC data.  Some think they belong to kernel/driver and can be matched
using SoC specific compatible, while others prefer to have them in DT.

As I mentioned in the commit log, this SoC data actually consists of two
parts:

 1) Map of MPM_GIC pin <--> GIC interrupt number
 2) Map of MPM_GPIO pin <--> GPIO number

Since we already have map 2) defined in pinctrl driver rather than DT,
I put map 1) in MPM driver.

Shawn

> 
> > + */
> > +const struct mpm_pin qcm2290_gic_pins[] = {
> > +	{ 2, 275 },	/* tsens0_tsens_upper_lower_int */
> > +	{ 5, 296 },	/* lpass_irq_out_sdc */
> > +	{ 12, 422 },	/* b3_lfps_rxterm_irq */
> > +	{ 24, 79 },	/* bi_px_lpi_1_aoss_mx */
> > +	{ 86, 183 },	/* mpm_wake,spmi_m */
> > +	{ 90, 260 },	/* eud_p0_dpse_int_mx */
> > +	{ 91, 260 },	/* eud_p0_dmse_int_mx */
> > +	{ -1 },
> > +};
> > +
> > +const struct mpm_data qcm2290_data = {
> > +	.pin_num = 96,
> > +	.gic_pins = qcm2290_gic_pins,
> > +};
> > +
> > +static int qcm2290_mpm_init(struct platform_device *pdev,
> > +			    struct device_node *parent)
> > +{
> > +	return qcom_mpm_init(pdev, parent, &qcm2290_data);
> > +}
> > +
> > +IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_mpm)
> > +IRQCHIP_MATCH("qcom,qcm2290-mpm", qcm2290_mpm_init)
> > +IRQCHIP_PLATFORM_DRIVER_END(qcom_mpm)
> > +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. MSM Power Manager");
> > +MODULE_LICENSE("GPL v2");
