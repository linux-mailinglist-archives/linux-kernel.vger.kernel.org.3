Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A14CE3F4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 10:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiCEJZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 04:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiCEJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 04:25:38 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5390020054E
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 01:24:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id bx5so9236658pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 01:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mHyiLiIrRpFigcy5JiGI43jKPJbXrn3zCVVn65B5ie4=;
        b=CFqmsvaxdRzeOiwnuUIJ3DytjNjXccEl+NbwiDmrxzpP/JhovMRXzR/WjjlbgvOckW
         UKVlqyYDnQdf6ToZXe99zGakh6V3X9ExwQDZvanjQKYUt/z9ktKk1V70XFiYd5dc1GUD
         jC9ys+d2gS7pYAI4aONvJItU63NhqmE8mNnria5CXcC13ubbt2G/rx/VXP24bpt1WV6h
         HWz3cp0nfRfFOvND0Rbw8j3FcfVawUDZQlayDdaZ5iTDvEG80NvU43qUcFpINkUtYcZp
         EVomgxahW3gRzbL2VT2BWjOz90YNTvnkjZ+VaJb18FDgDE5xF6E3c1WtVdGt6weLDPeF
         E6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mHyiLiIrRpFigcy5JiGI43jKPJbXrn3zCVVn65B5ie4=;
        b=OD4+GRBINwvBQ8frPz8f2zNhjjsISHJ5HcfAColV2Dxel1Iu6ealpGug9mUCClU397
         +9jlpkmoxaZHTC3B+lC7Y1c0un0iaZDoPXj9dHDhWpmeWjalH7ud3E+UgyrCB/O1sWgs
         ZFwwEDEeN5x2SOxJOV19aY0wzhujouNOgWVK1c1vAOuxcw5oZVi/T7BHhv8v+pgvUiXS
         LqIyvFwZFdpeiRoM6eOjv3XImgQDt/op9QyYRevlKKBjM8b/WE4LoWRA7Q10z2GHcMV2
         5KHBS+SESVYXDrPRId/PTPc0+3ROdCI0uc3V9kUl1m5Kh/frmGZRRRmf2zv3mzhx6/Ye
         Ckyg==
X-Gm-Message-State: AOAM533Q3uul+OE+E+MYHJRm7UmwlsCmiWchZSOOx6pBK5iFNgY4nNJ1
        NB8/CltdNxxVZSP3e/2hhFJEBw==
X-Google-Smtp-Source: ABdhPJyJiXUhe/a8Me8H7MP3LXIBW/eicZeW9IEeCMhfX1/t9Wil2TcPX6VFyXsdyWpWzd9LpNNLKQ==
X-Received: by 2002:a17:902:9008:b0:14f:b1f9:5271 with SMTP id a8-20020a170902900800b0014fb1f95271mr2481434plp.86.1646472287857;
        Sat, 05 Mar 2022 01:24:47 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id j2-20020a655582000000b00372b2b5467asm6684720pgs.10.2022.03.05.01.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 01:24:27 -0800 (PST)
Date:   Sat, 5 Mar 2022 17:24:20 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] irqchip: Add Qualcomm MPM controller driver
Message-ID: <20220305092420.GP269879@dragon>
References: <20220301062414.2987591-3-shawn.guo@linaro.org>
 <87ee3m2aed.wl-maz@kernel.org>
 <20220302084028.GL269879@dragon>
 <877d9c3b2u.wl-maz@kernel.org>
 <20220302133441.GM269879@dragon>
 <875yow31a0.wl-maz@kernel.org>
 <20220303040229.GN269879@dragon>
 <87fsnytagc.wl-maz@kernel.org>
 <20220304082342.GO269879@dragon>
 <87lexp211g.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lexp211g.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 03:24:43PM +0000, Marc Zyngier wrote:
> On Fri, 04 Mar 2022 08:23:42 +0000,
> Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > On Fri, Mar 04, 2022 at 07:59:15AM +0000, Marc Zyngier wrote:
> > > On Thu, 03 Mar 2022 04:02:29 +0000,
> > > Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > 
> > > > On Wed, Mar 02, 2022 at 01:57:27PM +0000, Marc Zyngier wrote:
> > > > > This code actually makes me ask more questions. Why is it programming
> > > > > 2 'pins' for each IRQ?
> > > > 
> > > > The mapping between MPM pin and GIC IRQ is not strictly 1-1.  There are
> > > > some rare case that up to 2 MPM pins map to a single GIC IRQ, for
> > > > example the last two in QC2290 'qcom,mpm-pin-map' below.
> > > > 
> > > > 	qcom,mpm-pin-map = <2 275>,     /* tsens0_tsens_upper_lower_int */
> > > > 			   <5 296>,     /* lpass_irq_out_sdc */
> > > > 			   <12 422>,    /* b3_lfps_rxterm_irq */
> > > > 			   <24 79>,     /* bi_px_lpi_1_aoss_mx */
> > > > 			   <86 183>,    /* mpm_wake,spmi_m */
> > > > 			   <90 260>,    /* eud_p0_dpse_int_mx */
> > > > 			   <91 260>;    /* eud_p0_dmse_int_mx */
> > > > 
> > > > 
> > > > The downstream uses a DT bindings that specifies GIC hwirq number in
> > > > client device nodes.  In that case, d->hwirq in the driver is GIC IRQ
> > > > number, and the driver will need to query mapping table, find out the
> > > > possible 2 MPM pins, and set them up.
> > > > 
> > > > The patches I'm posting here use a different bindings that specifies MPM
> > > > pin instead in client device nodes.  Thus the driver can simply get the
> > > > MPM pin from d->hwirq, so that the whole look-up procedure can be saved.
> > > 
> > > It still remains that there is no 1:1 mapping between input and
> > > output, which is the rule #1 to be able to use a hierarchical setup.
> > 
> > For direction of MPM pin -> GIC interrupt, it's a 1:1 mapping, i.e. for
> > given MPM pin, there is only one GIC interrupt.  And that's the
> > mapping MPM driver relies on.  For GIC interrupt -> MPM pin, it's not
> > a strict 1:1 mapping.
> 
> Then this isn't a 1:1 mapping *AT ALL*. The hierarchical setup
> mandates that the mapping is a bijective function, and that's exactly
> what 1:1 means. There is no such thing a 1:1 in a single
> direction. When you take an interrupt, all you see is the GIC
> interrupt. How do you know which of the *two* pins interrupted you? Oh
> wait, you *can't* know. You end-up never servicing one of the two
> interrupts

Yes, you are right!  But that might be a problem only in theory.  I
checked all the Qualcomm platforms I know built on MPM, and found that
the only 2:1 case is USB DP & DM sensing pins.  Since these two pins
will be handled by USB driver with a single interrupt handler, it should
not cause any problem in practice.  That said, the 2:1 mapping is just
a special case specific to USB, and MPM driver can be implemented as if
it's just a 1:1 mapping.

Shawn

> (and I suspect this results in memory corruption if you
> tear a hierarchy down).
