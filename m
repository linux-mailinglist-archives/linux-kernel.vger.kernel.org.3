Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B534CA61E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbiCBNfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiCBNfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:35:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536D9BDE74
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:34:48 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so4792099pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 05:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g/0CGihmreYP75AblhYq/wa365Fq2crJ7rthQ8/LRIw=;
        b=OxqV9xSNxet4uLHNXQBA5/6d7VsKxxBep6AmpAfNc7LxzgNLGIKeAxhaibUDtb9JbO
         NSqNAMW71d6Jr9CyMEN5iTigMSS+vQNGjZ87wuFokpzomaZRw4PfZyBaCmiNuKiUH5ya
         p0RyJyCq6zY90YYy8rKZPdeYR7OSfRk5CYFPctWPHvW1qfS23Gd4rvhVW29dEgc7s/fI
         eudBqHWF1y0MMsJq7tOhiBv1qL/R0U309xMXkgUFuR7dNvA6dGxuHm1HaY7u2mEJ6Cin
         vRnzOS+sRNuR2VVQ3Rlq8nzm8arMkJK9wVc2jFHEc6cTU/5dh30jfmynhhVWsVguXu7X
         9gYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g/0CGihmreYP75AblhYq/wa365Fq2crJ7rthQ8/LRIw=;
        b=McEXZt+IayoJCLOI1Pd4dVNWC8xNjxt6E7UCc5r7si7gAzHK8yumGPdDVOKa0aCjRY
         EIka0aQanuMRCTi6KtRj0xrp4QgS+GycB136RVuK3oIFPx8PCmUlVVDIaATtgryOi7IP
         VuRt6TfphuKYTiAXWeIdK2DUg3iNYerGiLumpyJA5AH0+iYF2fLlXnkClQ7jr3P3HKu6
         K8ZXJZK8gwh6yLcbPm+WnhSC50wUDGO86cmVDTFRMlEv11UvFRr6cq25YwGj0ye1PbHj
         Hhkn/tU1LCyj4prwBY2o11Xl1kRx8mh2D/P/pGelgo5NZ0GgjhFojpauO7wfISBGBM5k
         grbw==
X-Gm-Message-State: AOAM5313GhoLOps8yIb0diVQKTchhzUm6SHic1+VzIGTylOl6kBvO3V6
        mTpiP01TuKqN20h0HSelC0qPPA==
X-Google-Smtp-Source: ABdhPJyE1iWx1lWKj+H36O4PN4ngiSgwvqXfNlf2EPfHuhvB6INluq6wAlHqbkUpYueyr3kBnTIugw==
X-Received: by 2002:a17:90a:6542:b0:1bd:149f:1c29 with SMTP id f2-20020a17090a654200b001bd149f1c29mr22011228pjs.240.1646228087854;
        Wed, 02 Mar 2022 05:34:47 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id d10-20020a63360a000000b0037947abe4bbsm2486157pga.34.2022.03.02.05.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:34:47 -0800 (PST)
Date:   Wed, 2 Mar 2022 21:34:41 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] irqchip: Add Qualcomm MPM controller driver
Message-ID: <20220302133441.GM269879@dragon>
References: <20220301062414.2987591-1-shawn.guo@linaro.org>
 <20220301062414.2987591-3-shawn.guo@linaro.org>
 <87ee3m2aed.wl-maz@kernel.org>
 <20220302084028.GL269879@dragon>
 <877d9c3b2u.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d9c3b2u.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 10:25:45AM +0000, Marc Zyngier wrote:
> On Wed, 02 Mar 2022 08:40:28 +0000,
> Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > Hi Marc,
> > 
> > On Tue, Mar 01, 2022 at 11:13:30AM +0000, Marc Zyngier wrote:
> > > Hi Shawn,
> 
> [...]
> 
> > > 
> > > > +static int qcom_mpm_set_type(struct irq_data *d, unsigned int type)
> > > > +{
> > > > +	struct qcom_mpm_priv *priv = d->chip_data;
> > > > +	int pin = d->hwirq;
> > > > +	unsigned int index = pin / 32;
> > > > +	unsigned int shift = pin % 32;
> > > > +
> > > > +	switch (type & IRQ_TYPE_SENSE_MASK) {
> > > > +	case IRQ_TYPE_EDGE_RISING:
> > > > +		mpm_set_type(priv, !!(type & IRQ_TYPE_EDGE_RISING),
> > > > +			     MPM_REG_RISING_EDGE, index, shift);
> > > > +		break;
> > > > +	case IRQ_TYPE_EDGE_FALLING:
> > > > +		mpm_set_type(priv, !!(type & IRQ_TYPE_EDGE_FALLING),
> > > > +			     MPM_REG_FALLING_EDGE, index, shift);
> > > > +		break;
> > > > +	case IRQ_TYPE_LEVEL_HIGH:
> > > > +		mpm_set_type(priv, !!(type & IRQ_TYPE_LEVEL_HIGH),
> > > > +			     MPM_REG_POLARITY, index, shift);
> > > > +		break;
> > > > +	}
> > > 
> > > All these '!!(type & BLAH)' are totally superfluous, as they all expand
> > > to 'true' by construction.
> > 
> > Yes, you are right!
> > 
> > > And this leads to a few questions:
> > > 
> > > - Shouldn't a rising interrupt clear the falling detection?
> > > - Shouldn't a level-low clear the polarity?
> > > - How do you handle IRQ_TYPE_EDGE_BOTH?
> > > - How is MPM_REG_POLARITY evaluated for edge interrupts (resp the EDGE
> > >   registers for level interrupts), as you never seem to be configuring
> > >   a type here?
> > 
> > Honestly, qcom_mpm_set_type() was mostly taken from downstream without
> > too much thinking.

I have to take this statement back.  It seems that the current code has
been diverted from the downstream in a wrong way.

> > I trusted it as a "good" reference as I have no
> > document to verify the code.  These questions are great and resulted the
> > code changes are pretty sensible to me.
> 
> I don't think these changes are enough. For example, an interrupt
> being switched from level to edge is likely to misbehave (how do you
> distinguish the two?). If that's what the downstream driver does, then
> it is terminally broken.

Could you take a look at downstream code and see if it answers all your
questions?

It seems MPM_REG_POLARITY is only meant for level interrupts, since edge
interrupts already have separate registers for rising and falling.

I will fix my broken code by respecting the downstream logic.

> As I asked before, we need some actual specs, or at least someone to
> paraphrase it for us. There are a number of QC folks on Cc, and I
> expect them to chime in and explain how MPM works here.
> 
> > 
> > > - What initialises the MPM trigger types at boot time?
> > 
> > I dumped the vMPM region and it's all zeros.  My understanding is if
> > vMPM needs any sort of initialization, it should be done by RPM firmware
> > before APSS gets booting.
> 
> What about kexec? We can't rely on this memory region to always be
> 0-initialised, nor do we know what that means.

We are not relying on it being 0-initialised, but being initialised by
RPM with initial physical MPM register values.

Shawn

[1] https://source.codeaurora.org/quic/la/kernel/msm-5.4/tree/drivers/irqchip/qcom-mpm.c/?h=LE.UM.6.2.4.r1#n187
