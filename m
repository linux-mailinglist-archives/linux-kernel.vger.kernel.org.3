Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC54CB5CB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 05:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiCCEDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 23:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCCEDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 23:03:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480EA11C2B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 20:02:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gb21so3585895pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 20:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7sVtzpHpTJ/PnEOYIWifwgwlsyi1lazyvrfz9DJzlzs=;
        b=nEOrmbb6wkMBn4pcKHcPlV7engy0FKb++ii1IkQLJrQd8aMos0rJAeKLByOJvOAETb
         luAzROCtJyVwDCSFLvCjRnQoaoiAWVQqtOAkpsV5ENHX2+1TuRkPfT//DHEIbG63rcIU
         RIj/qMZtnsFV5RjtqYCriBMCmh9IaX2jKAwlcqQJo14YIfjoL9f9n4G4Z2ayZwe7TEbQ
         SS6nLZuVAsspvS4AEhK3nlcrG0Syo+XzJt/1I5vrYxOVnlCQBs0mAvk6NVvR447zoTmg
         4mC0xjpW+I0M4fOjF86xxOQVvxWRAe7euipo5+dw7ataSl9YahH4FDKeM320HFRipNrU
         8tgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7sVtzpHpTJ/PnEOYIWifwgwlsyi1lazyvrfz9DJzlzs=;
        b=boZHSgFI9rnH3Y9Es5/QTijhxbmZQ09mvVsQ0bo7GgzRWDhkYFsqNPY1J3Ox+hmZmE
         wZICbCE/hfItROYGrrlSO03/GRjuvReKwtsuYGBggcikn26OF9sTvQ9D2oyTRAJlN+Ms
         OiwmVXeWOJyBAaYPGumhKbYrWB+DlY2EG2H4s9Q3jvIXDsX/iMhwm3+gxxUH9Z5eg3S1
         cVFyCnx6gGeSDtvMVDOBtYQFfMGHvItmH8CiGJlF5o5F9dz6inNJWrOse4cesfnJ6n/8
         4A3bSnunbVMfqf/rWhr/8eTPGPxfAsXHh63U/Awua0aSYVUMESsL+I7A6aYzb6Bw2GN0
         kRcA==
X-Gm-Message-State: AOAM532cdWjcS5TMpsiTiuTIZ8IH7UJG7nn+BFZ1AzZX3JmdxcxyMvbA
        qktkC6Wzfm5S2Bz/8AEmOnSP2w==
X-Google-Smtp-Source: ABdhPJwMj69xOeKGqcq5Er/dpcnjvBP/n2lHzwjWoTgCF0/7haEx+6VjJklz/ouLQ+nB1MtmyUPi9A==
X-Received: by 2002:a17:902:f684:b0:151:93ab:3483 with SMTP id l4-20020a170902f68400b0015193ab3483mr8043486plg.4.1646280155720;
        Wed, 02 Mar 2022 20:02:35 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00170300b004f104c635e4sm704484pfc.99.2022.03.02.20.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:02:35 -0800 (PST)
Date:   Thu, 3 Mar 2022 12:02:29 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] irqchip: Add Qualcomm MPM controller driver
Message-ID: <20220303040229.GN269879@dragon>
References: <20220301062414.2987591-1-shawn.guo@linaro.org>
 <20220301062414.2987591-3-shawn.guo@linaro.org>
 <87ee3m2aed.wl-maz@kernel.org>
 <20220302084028.GL269879@dragon>
 <877d9c3b2u.wl-maz@kernel.org>
 <20220302133441.GM269879@dragon>
 <875yow31a0.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yow31a0.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 01:57:27PM +0000, Marc Zyngier wrote:
> On Wed, 02 Mar 2022 13:34:41 +0000,
> Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > On Wed, Mar 02, 2022 at 10:25:45AM +0000, Marc Zyngier wrote:
> > > On Wed, 02 Mar 2022 08:40:28 +0000,
> > > Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > 
> > > > Hi Marc,
> > > > 
> > > > On Tue, Mar 01, 2022 at 11:13:30AM +0000, Marc Zyngier wrote:
> > > > > Hi Shawn,
> > > 
> > > [...]
> > > 
> > > > > 
> > > > > > +static int qcom_mpm_set_type(struct irq_data *d, unsigned int type)
> > > > > > +{
> > > > > > +	struct qcom_mpm_priv *priv = d->chip_data;
> > > > > > +	int pin = d->hwirq;
> > > > > > +	unsigned int index = pin / 32;
> > > > > > +	unsigned int shift = pin % 32;
> > > > > > +
> > > > > > +	switch (type & IRQ_TYPE_SENSE_MASK) {
> > > > > > +	case IRQ_TYPE_EDGE_RISING:
> > > > > > +		mpm_set_type(priv, !!(type & IRQ_TYPE_EDGE_RISING),
> > > > > > +			     MPM_REG_RISING_EDGE, index, shift);
> > > > > > +		break;
> > > > > > +	case IRQ_TYPE_EDGE_FALLING:
> > > > > > +		mpm_set_type(priv, !!(type & IRQ_TYPE_EDGE_FALLING),
> > > > > > +			     MPM_REG_FALLING_EDGE, index, shift);
> > > > > > +		break;
> > > > > > +	case IRQ_TYPE_LEVEL_HIGH:
> > > > > > +		mpm_set_type(priv, !!(type & IRQ_TYPE_LEVEL_HIGH),
> > > > > > +			     MPM_REG_POLARITY, index, shift);
> > > > > > +		break;
> > > > > > +	}
> > > > > 
> > > > > All these '!!(type & BLAH)' are totally superfluous, as they all expand
> > > > > to 'true' by construction.
> > > > 
> > > > Yes, you are right!
> > > > 
> > > > > And this leads to a few questions:
> > > > > 
> > > > > - Shouldn't a rising interrupt clear the falling detection?
> > > > > - Shouldn't a level-low clear the polarity?
> > > > > - How do you handle IRQ_TYPE_EDGE_BOTH?
> > > > > - How is MPM_REG_POLARITY evaluated for edge interrupts (resp the EDGE
> > > > >   registers for level interrupts), as you never seem to be configuring
> > > > >   a type here?
> > > > 
> > > > Honestly, qcom_mpm_set_type() was mostly taken from downstream without
> > > > too much thinking.
> > 
> > I have to take this statement back.  It seems that the current code has
> > been diverted from the downstream in a wrong way.
> > 
> > > > I trusted it as a "good" reference as I have no
> > > > document to verify the code.  These questions are great and resulted the
> > > > code changes are pretty sensible to me.
> > > 
> > > I don't think these changes are enough. For example, an interrupt
> > > being switched from level to edge is likely to misbehave (how do you
> > > distinguish the two?). If that's what the downstream driver does, then
> > > it is terminally broken.
> > 
> > Could you take a look at downstream code and see if it answers all your
> > questions?
> 
> This code actually makes me ask more questions. Why is it programming
> 2 'pins' for each IRQ?

The mapping between MPM pin and GIC IRQ is not strictly 1-1.  There are
some rare case that up to 2 MPM pins map to a single GIC IRQ, for
example the last two in QC2290 'qcom,mpm-pin-map' below.

	qcom,mpm-pin-map = <2 275>,     /* tsens0_tsens_upper_lower_int */
			   <5 296>,     /* lpass_irq_out_sdc */
			   <12 422>,    /* b3_lfps_rxterm_irq */
			   <24 79>,     /* bi_px_lpi_1_aoss_mx */
			   <86 183>,    /* mpm_wake,spmi_m */
			   <90 260>,    /* eud_p0_dpse_int_mx */
			   <91 260>;    /* eud_p0_dmse_int_mx */


The downstream uses a DT bindings that specifies GIC hwirq number in
client device nodes.  In that case, d->hwirq in the driver is GIC IRQ
number, and the driver will need to query mapping table, find out the
possible 2 MPM pins, and set them up.

The patches I'm posting here use a different bindings that specifies MPM
pin instead in client device nodes.  Thus the driver can simply get the
MPM pin from d->hwirq, so that the whole look-up procedure can be saved.

> 
> > 
> > It seems MPM_REG_POLARITY is only meant for level interrupts, since edge
> > interrupts already have separate registers for rising and falling.
> 
> Then level interrupts must clear both the edge registers at all times.

The downstream logic already covers that, right?  The edge register bits
will be cleared as long as 'flowtype' is not EDGE.

static void msm_mpm_set_type(struct irq_data *d,
                                        unsigned int flowtype, bool is_mpmgic)
{   
        int mpm_pin[MAX_MPM_PIN_PER_IRQ] = {-1, -1};
        unsigned long flags;  
        int i = 0;
        unsigned int index, mask;      
        unsigned int reg = 0; 
    
        msm_get_mpm_pin(d, mpm_pin, is_mpmgic);
        for (i = 0; i < MAX_MPM_PIN_PER_IRQ; i++) {
                if (mpm_pin[i] < 0)            
                        return;                        
    
                index = mpm_pin[i]/32;         
                mask = mpm_pin[i]%32;          
    
                spin_lock_irqsave(&mpm_lock, flags);
                reg = MPM_REG_RISING_EDGE;     
                if (flowtype & IRQ_TYPE_EDGE_RISING)
                        msm_mpm_program_set_type(1, reg, index, mask);
                else          
                        msm_mpm_program_set_type(0, reg, index, mask);

                reg = MPM_REG_FALLING_EDGE;    
                if (flowtype & IRQ_TYPE_EDGE_FALLING)
                        msm_mpm_program_set_type(1, reg, index, mask);
                else          
                        msm_mpm_program_set_type(0, reg, index, mask);
    
                reg = MPM_REG_POLARITY;        
                if (flowtype & IRQ_TYPE_LEVEL_HIGH)
                        msm_mpm_program_set_type(1, reg, index, mask);
                else
                        msm_mpm_program_set_type(0, reg, index, mask);
                spin_unlock_irqrestore(&mpm_lock, flags);
        }
}

> > I will fix my broken code by respecting the downstream logic.
> > 
> > > As I asked before, we need some actual specs, or at least someone to
> > > paraphrase it for us. There are a number of QC folks on Cc, and I
> > > expect them to chime in and explain how MPM works here.
> > > 
> > > > 
> > > > > - What initialises the MPM trigger types at boot time?
> > > > 
> > > > I dumped the vMPM region and it's all zeros.  My understanding is if
> > > > vMPM needs any sort of initialization, it should be done by RPM firmware
> > > > before APSS gets booting.
> > > 
> > > What about kexec? We can't rely on this memory region to always be
> > > 0-initialised, nor do we know what that means.
> > 
> > We are not relying on it being 0-initialised, but being initialised by
> > RPM with initial physical MPM register values.
> 
> Whatever. It simply cannot be trusted. If you kexec another kernel,
> you need to be able to restore a sane state at probe time. This isn't
> optional.

Right, I will add an explicit initialization on vMPM region at probe
time.

Shawn
