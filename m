Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A169252EE4A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350335AbiETOgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348785AbiETOgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:36:24 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76BA57B30
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:36:23 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-e5e433d66dso10511152fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iyg09MXx3MxUDrIc80FSkTauSbtXFvQYu5GaFcUD4A8=;
        b=6A/ZADbDOwV84hhjbq0VUFECjbAJ6n9rXYOhPXYnmVuYdV0+TYBj4xyxGEI8vBXHq5
         G4KtzH+Ak1xhfjiBCMNmdQ+GAizmpGk3hg4KY4HH3gt/9vef1utHbc6h7BmN5prMLBiE
         WTagxyn0/05V2ETZl1KlacfQ1gtwe2fZfhYfzQDFrXOyxsg8v1Ukm1Pf8UndwhVAaO+O
         raaCxetI24HzGygLTt/fL15xFyyCmqFE5CbiwNInMizTTwr+xmM2HQZX1Q+5MwfxaKf0
         9I1aWW0/FurcLam2XoJ3XYq6Xt04FlTwiPza5Zk1ggNPQ5tkXI5zvOmIIXoRtm8PwrZW
         /qeg==
X-Gm-Message-State: AOAM532q4EK3/PwrfE952cb9WowRwoTXxKTwf6kX/ePYRBqlKEK+GJS+
        UyF89Lz10xwZEjkQVqw92g==
X-Google-Smtp-Source: ABdhPJyMUFH7t+iQryu0gI+MIfzU/pVaixAR4w3tzpu5naOonR9QLmz8Q4jg4oru81EwcHVye5wwIA==
X-Received: by 2002:a05:6870:d60d:b0:f1:ddfc:2f26 with SMTP id a13-20020a056870d60d00b000f1ddfc2f26mr6255111oaq.296.1653057382154;
        Fri, 20 May 2022 07:36:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p13-20020a0568301d4d00b0060603221236sm975958oth.6.2022.05.20.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 07:36:21 -0700 (PDT)
Received: (nullmailer pid 3813862 invoked by uid 1000);
        Fri, 20 May 2022 14:36:20 -0000
Date:   Fri, 20 May 2022 09:36:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 8/8] arch_topology: Add support to build llc_sibling
 on DT platforms
Message-ID: <20220520143620.GA3788938-robh@kernel.org>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
 <20220518093325.2070336-9-sudeep.holla@arm.com>
 <CAL_JsqKig8U4hQEtHW8ct1Pd0a29ZtoTp1HuWQv389yb+SuW_A@mail.gmail.com>
 <20220520125959.wlxz53cfqldljxjy@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520125959.wlxz53cfqldljxjy@bogus>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 01:59:59PM +0100, Sudeep Holla wrote:
> On Thu, May 19, 2022 at 01:10:51PM -0500, Rob Herring wrote:
> > On Wed, May 18, 2022 at 4:34 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > ACPI PPTT provides cache identifiers and especially the last level cache
> > > identifier is used in obtaining last level cache siblings amongst CPUs.
> > >
> > > While we have the cpu map representing all the CPUs sharing last level
> > > cache in the cacheinfo driver, it is populated quite late in the boot
> > > while the information is needed to build scheduler domains quite early.
> >
> > Late is because it's a device_initcall() rather than late in the cpu
> > hotplug state machine, right?
> 
> Right. The expectation is to run in on each online CPU in CPU hotplug state
> machine for some architectures. We may not need that on arm64 especially
> since we get all info from DT or ACPI, but e.g. x86 uses cpuid which needs
> to be executed on that CPU.

That's a separate issue. I'm not suggesting changing that part (that 
would just be an optimization).

> > The late aspect is for sysfs presumably,but I think we could decouple that.
> 
> OK, not sure when this sched_domain info is actually needed. It think it
> could be decoupled if we can wait until all the cpus are online.

No need to wait for all cpus to be online. I think you keep doing 
it as part of cpu hotplug. The device_initcall() is used because you 
cannot have struct device or sysfs calls before the driver core is 
initialized. If we run the cacheinfo code earlier (I think the arch code 
will have to call it) just like the topology code and skip the sysfs 
parts, then you can use it.

> > Do all the firmware cache parsing early and then populate the sysfs parts
> > later.
> 
> Yes that may work on DT/ACPI based systems, as I said x86 relies on cpuid.

I'd assume using cpuid works at any time?

> > It's not a unique problem as the DT unflattening and init code has to
> > do the same thing. I'd assume the hotplug and cpu sysfs devices have
> > to deal with the same thing.
> >
> 
> OK, I will take a look at how to do that.
> 
> --
> Regards,
> Sudeep
