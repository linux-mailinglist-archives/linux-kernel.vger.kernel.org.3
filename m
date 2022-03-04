Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0503F4CCFDE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiCDIYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiCDIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:24:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B31D18A7AF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:23:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so7351962pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N+axBdq9gIf7Sm45r2wp0IbGpMCe8j9pbsmbjijGtEs=;
        b=f0829CVHzlWItVcZBqryJZuX5e70twUX9KzKUD6tLvj+/lFCRe2gezWAbn4XvkN9gW
         RX9D927IMO5VWmFw/dT2JzOJF4XFZlkvooVVVwck1QjBq+qIetDHaHeBMru7r02HxVAo
         v0TQUsT4E+NMM0bFygzW0RBla5Iu3Zt0/QmNtQcAv8Snx4xBINawzNKpqJU/rLNsldvd
         n4hf8eypUH+SNXZIj2hTmqFnmRusfnthhxwGrPyXfsfeCfyxwV/3AWSUxQ30lWdo4qQo
         AL1caR8IHWqwPxaONOiBkZxJPFMTAKv4E2ec5Qprect3vZDulpo0alU7hRDVUWjqhyJc
         /R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N+axBdq9gIf7Sm45r2wp0IbGpMCe8j9pbsmbjijGtEs=;
        b=MKJYdIXD7AZIXTFhmDjj6cabjc+zN27CTGf3by+QN/Ao2emIRIrHPmiABXnTI7joM5
         vYiLmP3ObgMvfHwI+ywnxCvs4hk7JSBjihh1HEV4RQpHJSS7+NljE8UKKI0bqIPvQ2uO
         iZUQUPzoxz7UGdhlVXCuqx7Ss5HQ+XauAo3CBwURk6vZNRKlBvQ1zdgmD7wARKGbqFVF
         g2+EEEY3aS1Haiz+5u7V0ZUD4URSaXMcJH5Yg+srihAjEH9MzDqiHepCEz6hfyCAqO2Q
         e+0MKgMTCC2NqNUIbw0sujKdvfRVLDSHln3i5caO+q7kgPrMvqM4JKzR3L6jee84iQSm
         qrCA==
X-Gm-Message-State: AOAM532vRIyK+mq9a2xgvxBLBETPM6VKm1qVhkPyKCqmlFDlWiEwwC/g
        F2u2tqCkgqqbIGCqU76taE5RBQ==
X-Google-Smtp-Source: ABdhPJy8J5ilB+dFny6fOUlfNEKYRdwad4gzPC5QyQ9vdQkTY78rBNDkNRO6BhI/UBTXUl5qRfmbuA==
X-Received: by 2002:a17:90b:4f4e:b0:1bf:887:9352 with SMTP id pj14-20020a17090b4f4e00b001bf08879352mr9410324pjb.199.1646382229105;
        Fri, 04 Mar 2022 00:23:49 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090aa38600b001bce781ce03sm4105189pjp.18.2022.03.04.00.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:23:48 -0800 (PST)
Date:   Fri, 4 Mar 2022 16:23:42 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] irqchip: Add Qualcomm MPM controller driver
Message-ID: <20220304082342.GO269879@dragon>
References: <20220301062414.2987591-1-shawn.guo@linaro.org>
 <20220301062414.2987591-3-shawn.guo@linaro.org>
 <87ee3m2aed.wl-maz@kernel.org>
 <20220302084028.GL269879@dragon>
 <877d9c3b2u.wl-maz@kernel.org>
 <20220302133441.GM269879@dragon>
 <875yow31a0.wl-maz@kernel.org>
 <20220303040229.GN269879@dragon>
 <87fsnytagc.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsnytagc.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 07:59:15AM +0000, Marc Zyngier wrote:
> On Thu, 03 Mar 2022 04:02:29 +0000,
> Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > On Wed, Mar 02, 2022 at 01:57:27PM +0000, Marc Zyngier wrote:
> > > This code actually makes me ask more questions. Why is it programming
> > > 2 'pins' for each IRQ?
> > 
> > The mapping between MPM pin and GIC IRQ is not strictly 1-1.  There are
> > some rare case that up to 2 MPM pins map to a single GIC IRQ, for
> > example the last two in QC2290 'qcom,mpm-pin-map' below.
> > 
> > 	qcom,mpm-pin-map = <2 275>,     /* tsens0_tsens_upper_lower_int */
> > 			   <5 296>,     /* lpass_irq_out_sdc */
> > 			   <12 422>,    /* b3_lfps_rxterm_irq */
> > 			   <24 79>,     /* bi_px_lpi_1_aoss_mx */
> > 			   <86 183>,    /* mpm_wake,spmi_m */
> > 			   <90 260>,    /* eud_p0_dpse_int_mx */
> > 			   <91 260>;    /* eud_p0_dmse_int_mx */
> > 
> > 
> > The downstream uses a DT bindings that specifies GIC hwirq number in
> > client device nodes.  In that case, d->hwirq in the driver is GIC IRQ
> > number, and the driver will need to query mapping table, find out the
> > possible 2 MPM pins, and set them up.
> > 
> > The patches I'm posting here use a different bindings that specifies MPM
> > pin instead in client device nodes.  Thus the driver can simply get the
> > MPM pin from d->hwirq, so that the whole look-up procedure can be saved.
> 
> It still remains that there is no 1:1 mapping between input and
> output, which is the rule #1 to be able to use a hierarchical setup.

For direction of MPM pin -> GIC interrupt, it's a 1:1 mapping, i.e. for
given MPM pin, there is only one GIC interrupt.  And that's the
mapping MPM driver relies on.  For GIC interrupt -> MPM pin, it's not
a strict 1:1 mapping.  For given GIC interrupt, there could be up to 2
MPM pin mapped to it.  MPM driver doesn't use this direction of mapping
though.

> 
> /me puzzled.
> 
> >
> > > 
> > > > 
> > > > It seems MPM_REG_POLARITY is only meant for level interrupts, since edge
> > > > interrupts already have separate registers for rising and falling.
> > > 
> > > Then level interrupts must clear both the edge registers at all times.
> > 
> > The downstream logic already covers that, right?  The edge register bits
> > will be cleared as long as 'flowtype' is not EDGE.
> 
> I am talking about *your* code, not the Qualcomm stuff.

OK. If you do not see anything wrong on the vendor code logic, I plan to
replace my broken code with it.

Shawn
