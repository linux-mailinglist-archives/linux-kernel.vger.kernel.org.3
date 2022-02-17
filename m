Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EAA4BA166
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbiBQNh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:37:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiBQNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:37:25 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E7915F089
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:37:10 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so5417776pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02nHroSlazasbyOohrNnb8vU7M/55jk3Ml13ncR5Bag=;
        b=IdYYavNv07RNisGgu/TXShEnKyrJWR/is6EclNeBTQgiqCnQNJXa+3MiniP9HimypK
         mB7edwXnVvvhTHlX4v3bGJ16oBym1g52ArkErSQ0ldoiXVaD8osB7Gtnx0MxzJjbks72
         9Jvv2pQYzQ9YtNQBVw8xseXTcMagltFGxgXla/VyJF0RmwWRjKlA6LXOImiWnbowrMaf
         Kk2jhWX5YHB6w79I2t8V38z7SCSBlTROy+qYpOJeichB7oiXMiCbLxx1KGc+LGuhksj1
         q0bGFZ444N21gtrGXPXouFw7tK+DJ6tRWT3GldzBS37A0m6Ckm0O43+sXktPKuMk/mmk
         X9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=02nHroSlazasbyOohrNnb8vU7M/55jk3Ml13ncR5Bag=;
        b=UTP6gQMeac1hEv/d0z5e9jWXiOxD9TfK14I7/nomtc+8Ke5oRqhemXJElLP2ZaOQa4
         JCYIwqpx/9YSDM6WZK7xz7ch1oCP/K25sQLhZV1ti+Cm6ihTHlbBYJ3n9xstswsObHGM
         GmFKfkrRl+2gz6HRhlHeQxiSrBuJwtpXDdkF63Zv8T29uZ54KvscwIqhU/P8O5K27bXm
         9dZWXgGFsboCA1qRrMdMGl9CrQrTszr2v5bOeE9tBeDKSWuPMtFUTsoWhQb27hcigde7
         WLKuHz6K/+XSmmyOC59tBANMYBHa6rG+K6HtobExJmgYog6XcJLUrRzEPLf8/Zsn94lW
         0nkA==
X-Gm-Message-State: AOAM532lLcyIQ1ZE0iMYgDs1o9C614oqHAPzDXtkjlY5Gx0I4DBX5k4R
        xQFq4d45tpiZH/nuDY+lFZS8Lw==
X-Google-Smtp-Source: ABdhPJwcWuETHUESiM4/nhBPmTEObKuQt3H+aAYmKUzy7lA2D749ZekIREMcr4wZ4L7fDlyvhEijUQ==
X-Received: by 2002:a17:90b:4a4f:b0:1b8:7240:1a47 with SMTP id lb15-20020a17090b4a4f00b001b872401a47mr7457883pjb.84.1645105030366;
        Thu, 17 Feb 2022 05:37:10 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id s19sm46943518pfu.34.2022.02.17.05.37.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Feb 2022 05:37:09 -0800 (PST)
Date:   Thu, 17 Feb 2022 21:37:03 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] cpuidle: psci: Call cpu_cluster_pm_enter() on the
 last CPU
Message-ID: <20220217133702.GF31965@dragon>
References: <20220216132830.32490-1-shawn.guo@linaro.org>
 <20220216132830.32490-2-shawn.guo@linaro.org>
 <20220216144937.znsba7zbdenl7427@bogus>
 <9bda65e5bb85b00eaca71d95ad78e93b@kernel.org>
 <20220217073130.GD31965@dragon>
 <875ypd50z0.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ypd50z0.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 08:52:35AM +0000, Marc Zyngier wrote:
> On Thu, 17 Feb 2022 07:31:32 +0000,
> Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > On Wed, Feb 16, 2022 at 03:58:41PM +0000, Marc Zyngier wrote:
> > > On 2022-02-16 14:49, Sudeep Holla wrote:
> > > > +Ulf (as you he is the author of cpuidle-psci-domains.c and can help you
> > > > with that if you require)
> > 
> > Thanks, Sudeep!
> > 
> > > > 
> > > > On Wed, Feb 16, 2022 at 09:28:28PM +0800, Shawn Guo wrote:
> > > > > Make a call to cpu_cluster_pm_enter() on the last CPU going to low
> > > > > power
> > > > > state (and cpu_cluster_pm_exit() on the firt CPU coming back), so that
> > > > > platforms can be notified to set up hardware for getting into the
> > > > > cluster
> > > > > low power state.
> > > > > 
> > > > 
> > > > NACK. We are not getting the notion of CPU cluster back to cpuidle
> > > > again.
> > > > That must die. Remember the cluster doesn't map to idle states
> > > > especially
> > > > in the DSU systems where HMP CPUs are in the same cluster but can be in
> > > > different power domains.
> > 
> > The 'cluster' in cpu_cluster_pm_enter() doesn't necessarily means
> > a physical CPU cluster.  I think the documentation of the function has a
> > better description.
> > 
> >  * Notifies listeners that all cpus in a power domain are entering a low power
> >  * state that may cause some blocks in the same power domain to reset.
> > 
> > So cpu_domain_pm_enter() might be a better name?  Anyways ...
> > 
> > > > 
> > > > You need to decide which PSCI CPU_SUSPEND mode you want to use first. If
> > > > it is
> > > > Platform Co-ordinated(PC), then you need not notify anything to the
> > > > platform.
> > > > Just request the desired idle state on each CPU and platform will take
> > > > care
> > > > from there.
> > > > 
> > > > If for whatever reason you have chosen OS initiated mode(OSI), then
> > > > specify
> > > > the PSCI power domains correctly in the DT which will make use of the
> > > > cpuidle-psci-domains and handle the so called "cluster" state correctly.
> > 
> > Yes, I'm running a Qualcomm platform that has OSI supported in PSCI.
> > 
> > > 
> > > My understanding is that what Shawn is after is a way to detect the "last
> > > man standing" on the system to kick off some funky wake-up controller that
> > > really should be handled by the power controller (because only that guy
> > > knows for sure who is the last CPU on the block).
> > > 
> > > There was previously some really funky stuff (copy pasted from the existing
> > > rpmh_rsc_cpu_pm_callback()), which I totally objected to having hidden in
> > > an irqchip driver.
> > > 
> > > My ask was that if we needed such information, and assuming that it is
> > > possible to obtain it in a reliable way, this should come from the core
> > > code, and not be invented by random drivers.
> > 
> > Thanks Marc for explain my problem!
> > 
> > Right, all I need is a notification in MPM irqchip driver when the CPU
> > domain/cluster is about to enter low power state.  As cpu_pm -
> > kernel/cpu_pm.c, already has helper cpu_cluster_pm_enter() sending
> > CPU_CLUSTER_PM_ENTER event, I just need to find a caller to this cpu_pm
> > helper.  
> > 
> > Is .power_off hook of generic_pm_domain a better place for calling the
> > helper?
> 
> I really don't understand why you want a cluster PM event generated by
> the idle driver.  Specially considering that you are not after a
> *cluster* PM event, but after some sort of system-wide event (last man
> standing).

That's primarily because MPM driver is used in the idle context, either
s2idle or cpuidle, and idle driver already has some infrastructure that
could help trigger the event.

> It looks to me that having a predicate that can be called from a PM
> notifier event to find out whether you're the last in line would be
> better suited, and could further be used to remove the crap from the
> rpmh-rsc driver.

I will see if I can come up with a patch for discussion.

Shawn
