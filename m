Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DAD4CEB97
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 13:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiCFM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 07:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiCFM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 07:58:10 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D041628
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 04:57:18 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 6so6840063pgg.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 04:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AGNlNYvrYq+F+LYnefVTTHEG0vAmzNrpj7QYD32tJhY=;
        b=GvPjdJ0lJdL9rTjiFTxQKmLTmmVFYsrRwAD5ohdBTYZ8+EERBC6QIp85nNKtpBHCA6
         iVd+/Txv+wgH01Fe/DHVjsvse4ANlwiGApz3RsCAArNst+pXbyqolo66ND6ktY+Opgjc
         NZ4Dg7QGQkMmoNOKTQ4Fkg9I0aKpco8ptnKX5zHOdzcl5uYpkbkPbUvEc3GXf2FFpPHZ
         jmB6vPOzAytT1Ok6M9ioAFVSGcSX9lq87RW43xExV9oqyU1GekpiPD4LYsgoFaiveExk
         vhl7PpMWRwo9zP/ojcUig7tTKMDgyG2/A2NmNMyVgnZz8GDf9abkPRWmYeKS6iWO6zsC
         CPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AGNlNYvrYq+F+LYnefVTTHEG0vAmzNrpj7QYD32tJhY=;
        b=H7Y9Mshhy2kOHZOh86AzLmkdsrjtYJRYDpZnmM3UqBwRW4H/h2ifvgucBCv7LkwGyb
         sH8/9pp520S3+o9tWq253EbNvyZzoajRgTB5TObJDncC1epQBebMeANnCK1PK/FbwfCV
         S9/crQ98pmGW6frbGvQ220EVcL8bGiiOMYmop8kk+maU6SftT+GVwNymSwMBZKa1nQ4p
         q/7TgvUncWr9i2EGUwhgXg5fGwz4hFn7RbXnjOJ+T0xEvls23Jm7DchIA/CfieVZTkWc
         9sKJNietHCOkEnBwpJMiBZkpwQqscBNrgvfTKkoql0qHRL7YR8CrLzAN1zDsad6j5tF9
         uO7A==
X-Gm-Message-State: AOAM53070I1mExbZylY+vawKCH8bpUV8wMrC+Bm/r8509L4xCpZcFHZY
        XIEVUzEISg1fVm3NIknm0jCh9Q==
X-Google-Smtp-Source: ABdhPJz/XXcg7KC7A+AktmZhW/Po/W5UWWZkGBdtvfYCN/S7VBZ2hrI9FbT1kObOi8mZMARBEVROGQ==
X-Received: by 2002:a63:d306:0:b0:34e:4330:efea with SMTP id b6-20020a63d306000000b0034e4330efeamr6011096pgg.174.1646571437919;
        Sun, 06 Mar 2022 04:57:17 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a0016c200b004e10af156adsm12538057pfc.190.2022.03.06.04.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 04:57:17 -0800 (PST)
Date:   Sun, 6 Mar 2022 20:57:10 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] irqchip: Add Qualcomm MPM controller driver
Message-ID: <20220306125710.GQ269879@dragon>
References: <20220302084028.GL269879@dragon>
 <877d9c3b2u.wl-maz@kernel.org>
 <20220302133441.GM269879@dragon>
 <875yow31a0.wl-maz@kernel.org>
 <20220303040229.GN269879@dragon>
 <87fsnytagc.wl-maz@kernel.org>
 <20220304082342.GO269879@dragon>
 <87lexp211g.wl-maz@kernel.org>
 <20220305092420.GP269879@dragon>
 <87czj0u0bg.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czj0u0bg.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 11:05:07AM +0000, Marc Zyngier wrote:
> On Sat, 05 Mar 2022 09:24:20 +0000,
> Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > On Fri, Mar 04, 2022 at 03:24:43PM +0000, Marc Zyngier wrote:
> > > On Fri, 04 Mar 2022 08:23:42 +0000,
> > > Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > 
> > > > On Fri, Mar 04, 2022 at 07:59:15AM +0000, Marc Zyngier wrote:
> > > > > On Thu, 03 Mar 2022 04:02:29 +0000,
> > > > > Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > > > 
> > > > > > On Wed, Mar 02, 2022 at 01:57:27PM +0000, Marc Zyngier wrote:
> > > > > > > This code actually makes me ask more questions. Why is it programming
> > > > > > > 2 'pins' for each IRQ?
> > > > > > 
> > > > > > The mapping between MPM pin and GIC IRQ is not strictly 1-1.  There are
> > > > > > some rare case that up to 2 MPM pins map to a single GIC IRQ, for
> > > > > > example the last two in QC2290 'qcom,mpm-pin-map' below.
> > > > > > 
> > > > > > 	qcom,mpm-pin-map = <2 275>,     /* tsens0_tsens_upper_lower_int */
> > > > > > 			   <5 296>,     /* lpass_irq_out_sdc */
> > > > > > 			   <12 422>,    /* b3_lfps_rxterm_irq */
> > > > > > 			   <24 79>,     /* bi_px_lpi_1_aoss_mx */
> > > > > > 			   <86 183>,    /* mpm_wake,spmi_m */
> > > > > > 			   <90 260>,    /* eud_p0_dpse_int_mx */
> > > > > > 			   <91 260>;    /* eud_p0_dmse_int_mx */
> > > > > > 
> > > > > > 
> > > > > > The downstream uses a DT bindings that specifies GIC hwirq number in
> > > > > > client device nodes.  In that case, d->hwirq in the driver is GIC IRQ
> > > > > > number, and the driver will need to query mapping table, find out the
> > > > > > possible 2 MPM pins, and set them up.
> > > > > > 
> > > > > > The patches I'm posting here use a different bindings that specifies MPM
> > > > > > pin instead in client device nodes.  Thus the driver can simply get the
> > > > > > MPM pin from d->hwirq, so that the whole look-up procedure can be saved.
> > > > > 
> > > > > It still remains that there is no 1:1 mapping between input and
> > > > > output, which is the rule #1 to be able to use a hierarchical setup.
> > > > 
> > > > For direction of MPM pin -> GIC interrupt, it's a 1:1 mapping, i.e. for
> > > > given MPM pin, there is only one GIC interrupt.  And that's the
> > > > mapping MPM driver relies on.  For GIC interrupt -> MPM pin, it's not
> > > > a strict 1:1 mapping.
> > > 
> > > Then this isn't a 1:1 mapping *AT ALL*. The hierarchical setup
> > > mandates that the mapping is a bijective function, and that's exactly
> > > what 1:1 means. There is no such thing a 1:1 in a single
> > > direction. When you take an interrupt, all you see is the GIC
> > > interrupt. How do you know which of the *two* pins interrupted you? Oh
> > > wait, you *can't* know. You end-up never servicing one of the two
> > > interrupts
> > 
> > Yes, you are right!  But that might be a problem only in theory.  I
> > checked all the Qualcomm platforms I know built on MPM, and found that
> > the only 2:1 case is USB DP & DM sensing pins.  Since these two pins
> > will be handled by USB driver with a single interrupt handler, it should
> > not cause any problem in practice.  That said, the 2:1 mapping is just
> > a special case specific to USB, and MPM driver can be implemented as if
> > it's just a 1:1 mapping.
> >
> > Shawn
> > 
> > > (and I suspect this results in memory corruption if you
> > > tear a hierarchy down).
> 
> Key point here ^^^^^^^^^^
> 
> You can't have *any* interrupt that fits this 2:1 model if the irqchip
> implements 1:1. Think about the data structures for a second:
> 
> Pins x and y and routed to GIC interrupt z. This results in the
> following irq_data structures:
> 
>    MPM-x ---\
>              GIC-z
>    MPM-y ---/
> 
> Now, the driver using these interrupts is being removed, and the
> hierarchies is being freed. Tearing down the interrupt with pin x will
> result in z being also freed. And then you'll process pin y, which
> will just explode.

I tested with manually unbinding the USB driver and didn't run into any
memory corruption.  If I read irq_domain code right, it seems that
irq_domain_alloc_irq_data() will call into irq_domain_insert_irq_data()
to allocate z irq_data in context of virq x and y respectively.  So x
and y do not share a single parent (z) irq_data but have their own copy
of z irq_data, no?

Shawn
