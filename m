Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445E94648EE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347774AbhLAHjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347744AbhLAHjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:39:53 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC44C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 23:36:32 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z6so23482531pfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 23:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v/bPnGzpgS/aqERfPNQaK5pckwGE99mbqC1MZQThorw=;
        b=KnAjqEFol52RpzJpcu0BqEmQ+5gdeuVeB2QVa3WqnMXCKUHp0JkSxyE9UNNLBi76T6
         KwDG/QQ6AHk1OUZZgNlmbrgcFewsyijQ6Qq1okgQQLngNNGfQ4iJF2zDFV8zQEOV3ful
         I4+Sa0leE8qTuqg9L94+zWhB6USom/8/PHd1dhYbmYGTkrDE18ZHKjUZlVOGudDpJmYF
         /CUomznbRqkGYDinU7cm+9w6VQXhtdMzqqSumdNKgizlb/P9uEZnqyeJ8rzEddQEOQ7S
         jLnGFQpD3gzBlagEQH3Iyf3RvLUfPFWshGhZ0ebisdmnK6xWRp+r1r+MfD/eRG814bdF
         KaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v/bPnGzpgS/aqERfPNQaK5pckwGE99mbqC1MZQThorw=;
        b=J+9+/RcAB5LJO1dt8yCCbpuoMhsjHWXqJCSk+9MMEoBgM/HRP+KN90WP/Vx2HijMlP
         pw0fe2V+Acp4kyExpleZvP+qNToGMXS3vZMdUiMjhYvCAlYK3dUe7gEeEbhJWCqhadK+
         uXx4oQnKfzPJc0635a6FEZ0c6gYCllSIozSZaDzAz3ULaMP677moWYobJK5tW2jaOrd3
         f6SQclawkiqCvszfTsZ4Eqhx5BZ/PP/rx52cP+qOare+GKyhfnkzWGTHQcZg0JJkoh/i
         6duunzx/fjYz1qKmAz1QBDNFDYeQTsrBFaSLm5W/ZZmBgo/yKZfSGjtkERh/XoeBHC8+
         QK8Q==
X-Gm-Message-State: AOAM531lzibthuiu5byvq3edonvoKbD+UF/yql4WXsh0jKEge5CqHRBd
        nO1zKp/Z38G7MXSNsPBfHALhRQ==
X-Google-Smtp-Source: ABdhPJy6MKItXBesVd26sIBAPUe0gijdCE3uSCObZrXrMQakChIFjeDuWzNG7rtalroOIDmtecX3fQ==
X-Received: by 2002:aa7:8e48:0:b0:4a7:fe01:5971 with SMTP id d8-20020aa78e48000000b004a7fe015971mr4321163pfr.20.1638344192465;
        Tue, 30 Nov 2021 23:36:32 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id w142sm23265118pfc.115.2021.11.30.23.36.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Nov 2021 23:36:32 -0800 (PST)
Date:   Wed, 1 Dec 2021 15:36:25 +0800
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
Message-ID: <20211201073622.GJ10105@dragon>
References: <20211126093529.31661-1-shawn.guo@linaro.org>
 <20211126093529.31661-3-shawn.guo@linaro.org>
 <87czmmbu8k.wl-maz@kernel.org>
 <20211129133308.GB10105@dragon>
 <87pmqjm1c8.wl-maz@kernel.org>
 <20211130023151.GD10105@dragon>
 <87lf16m3ua.wl-maz@kernel.org>
 <20211130091708.GH10105@dragon>
 <87fsrdncsg.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsrdncsg.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:44:15AM +0000, Marc Zyngier wrote:
> On Tue, 30 Nov 2021 09:17:08 +0000,
> Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > On Tue, Nov 30, 2021 at 08:42:53AM +0000, Marc Zyngier wrote:
> > > On Tue, 30 Nov 2021 02:31:52 +0000,
> > > Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > 
> > > > + Maulik
> > > > 
> > > > On Mon, Nov 29, 2021 at 03:24:39PM +0000, Marc Zyngier wrote:
> > > > [...]
> > > > > > > > @@ -430,6 +430,14 @@ config QCOM_PDC
> > > > > > > >  	  Power Domain Controller driver to manage and configure wakeup
> > > > > > > >  	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
> > > > > > > >  
> > > > > > > > +config QCOM_MPM
> > > > > > > > +	bool "QCOM MPM"
> > > > > > > 
> > > > > > > Can't be built as a module?
> > > > > > 
> > > > > > The driver is implemented as a builtin_platform_driver().
> > > > > 
> > > > > This, on its own, shouldn't preclude the driver from being built as a
> > > > > module. However, the config option only allows it to be built in. Why?
> > > > 
> > > > I just tried to build it as a module, and it seems that "irq_to_desc" is
> > > > only available for built-in build.
> > > 
> > > Yet another thing that you should not be using. The irqdomain code
> > > gives you everything you need without having to resort to the
> > > internals of the core IRQ infrastructure.
> > 
> > I see.  I should use irq_get_irq_data() rather than &desc->irq_data.
> 
> Even better:
> 
> 	desc = irq_resolve_mapping(domain, hwirq);
> 
> Job done. No extra tracking, no dubious hack in the unmask callback,
> works with modules.
> 
> > 
> > > 
> > > > > Furthermore, why would you look up anywhere other than the wake-up
> > > > > domain? My impression was that only these interrupts would require
> > > > > being re-triggered.
> > > > 
> > > > Both domains have MPM pins that could wake up system.
> > > 
> > > Then why do you need two domains?
> > 
> > This is basically the same situation as qcom-pdc, and I have some
> > description about that in the commit log:
> > 
> > - For given SoC, a fixed number of MPM pins are supported, e.g. 96 pins
> >   on QCM2290.  Each of these MPM pins can be either a MPM_GIC pin or
> >   a MPM_GPIO pin. The mapping between MPM_GIC pin and GIC interrupt
> >   is defined by SoC, as well as the mapping between MPM_GPIO pin and
> >   GPIO number.  The former mapping can be found as the SoC data in this
> >   MPM driver, while the latter can be found as the msm_gpio_wakeirq_map[]
> >   in TLMM driver.
> > 
> > - Two irq domains are created for a single irq_chip to handle MPM_GIC
> >   and MPM_GPIO pins respectively, i.e. MPM_GIC domain and MPM_GPIO domain.
> >   The former is a child domain of GIC irq domain, while the latter is
> >   a parent domain of TLMM/GPIO irq domain.
> 
> That doesn't answer my question.
> 
> It doesn't matter what the pins are used for as long as you can
> identify which ones are routed to the GIC and which are not. You are
> obviously are able to do so, since you are able to disconnect part of
> the hierarchy (why is qcom_mpm_gic_alloc() named as such, since most
> of the interrupts it deals with are *never* routed to the GIC).
> 
> All the interrupts have the same irqchip callbacks and act on the same
> 'priv' data, so they it is obvious they don't overlap in the hwirq
> space.
> 
> Ergo: you can implement the whole thing with a single domain. All you
> need to make sure is that you identify the pins that are routed to the
> GIC, and you already have that information.

You are right!  A single domain works.  Nice and clean!  Thanks for the
comment, Marc!

Shawn
