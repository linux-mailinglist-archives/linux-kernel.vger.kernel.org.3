Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B724B99D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiBQHb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:31:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiBQHby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:31:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B6237E3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:31:39 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y18so3936943plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YX/p690Z+UGZJ7mpw5pzBIYlKuoanH5gezFUNUiq9ls=;
        b=Ujdrb+lzQxBG0ZmwBvpamuEtwe3QV4YDQRngHs5BE5eqbV2wXNXxV618RMADbjshoF
         HdRwripMd0pgfzrrJt9J+CDTkeoCKPfZB56fLOCuyuER7QAiO82VmJeTSm2aSXkpQzND
         NCCOv5ZE+nRwn3VJlmGTW5+WqWa5Ci3aVsFB2SeRg4ha25JZ54eOFJBKf+pgs2iR3t75
         X7LiSdTx9HJeE+zHmtqlF1YPtS68Ie7faK4Z+JTA1+omVpRftshJM1D7GvpC0afcKZ5d
         x2U7+eCZ60bstW3y0EIs3dKTnIGYAb/jK6QkLYq1oj7InsMo18AcuWl6d74FBO9VJrnw
         2MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YX/p690Z+UGZJ7mpw5pzBIYlKuoanH5gezFUNUiq9ls=;
        b=iqiFfH9gC3S2MXPWG17fKY95OMY+QyNcrIAhQ+qdorxXg69L5D79tQ///4r1eNMX8t
         EabFU3D9T91DxUQU7A5+pvi2oMz/BbGM19JTyh+3XBTmf34al7A4kRO3Hkzq8qh2Y+iX
         KS/5fsPGyaKBB0HmWtr+ZrjPAyUjv5889hNCvjdo+nqHjAhZVv7OeF43shL+FGZNI5Us
         2reWwy0shrDJd/EcLca8LRo+cS/uXxZLHwdPHzowiHaaydLZNY23JkycjvNws+S4zNnu
         PUAqfuH7JxsHpkiTZc2vQH5QLtdwmtfAQ4pymfKuOQAeQi1CLs3LOX1VV9J+77mdRP+e
         9azg==
X-Gm-Message-State: AOAM530+NYXixOs0gAMEdJ4aSK/D0+J3v8ShRweIsgj21mTXra7juBV7
        KZliclfftN6xlmLggGwn+7yckQ==
X-Google-Smtp-Source: ABdhPJwnVB7OyOYMPuGLctHI8QjFkDeiOWYfXTGuQo+Sas0Do1QcbH228oOT5yUxWd/PDP/h+2zaHQ==
X-Received: by 2002:a17:903:110d:b0:14d:85b2:4b36 with SMTP id n13-20020a170903110d00b0014d85b24b36mr1652915plh.75.1645083099211;
        Wed, 16 Feb 2022 23:31:39 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id s6sm14254301pfk.86.2022.02.16.23.31.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Feb 2022 23:31:38 -0800 (PST)
Date:   Thu, 17 Feb 2022 15:31:32 +0800
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
Message-ID: <20220217073130.GD31965@dragon>
References: <20220216132830.32490-1-shawn.guo@linaro.org>
 <20220216132830.32490-2-shawn.guo@linaro.org>
 <20220216144937.znsba7zbdenl7427@bogus>
 <9bda65e5bb85b00eaca71d95ad78e93b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bda65e5bb85b00eaca71d95ad78e93b@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 03:58:41PM +0000, Marc Zyngier wrote:
> On 2022-02-16 14:49, Sudeep Holla wrote:
> > +Ulf (as you he is the author of cpuidle-psci-domains.c and can help you
> > with that if you require)

Thanks, Sudeep!

> > 
> > On Wed, Feb 16, 2022 at 09:28:28PM +0800, Shawn Guo wrote:
> > > Make a call to cpu_cluster_pm_enter() on the last CPU going to low
> > > power
> > > state (and cpu_cluster_pm_exit() on the firt CPU coming back), so that
> > > platforms can be notified to set up hardware for getting into the
> > > cluster
> > > low power state.
> > > 
> > 
> > NACK. We are not getting the notion of CPU cluster back to cpuidle
> > again.
> > That must die. Remember the cluster doesn't map to idle states
> > especially
> > in the DSU systems where HMP CPUs are in the same cluster but can be in
> > different power domains.

The 'cluster' in cpu_cluster_pm_enter() doesn't necessarily means
a physical CPU cluster.  I think the documentation of the function has a
better description.

 * Notifies listeners that all cpus in a power domain are entering a low power
 * state that may cause some blocks in the same power domain to reset.

So cpu_domain_pm_enter() might be a better name?  Anyways ...

> > 
> > You need to decide which PSCI CPU_SUSPEND mode you want to use first. If
> > it is
> > Platform Co-ordinated(PC), then you need not notify anything to the
> > platform.
> > Just request the desired idle state on each CPU and platform will take
> > care
> > from there.
> > 
> > If for whatever reason you have chosen OS initiated mode(OSI), then
> > specify
> > the PSCI power domains correctly in the DT which will make use of the
> > cpuidle-psci-domains and handle the so called "cluster" state correctly.

Yes, I'm running a Qualcomm platform that has OSI supported in PSCI.

> 
> My understanding is that what Shawn is after is a way to detect the "last
> man standing" on the system to kick off some funky wake-up controller that
> really should be handled by the power controller (because only that guy
> knows for sure who is the last CPU on the block).
> 
> There was previously some really funky stuff (copy pasted from the existing
> rpmh_rsc_cpu_pm_callback()), which I totally objected to having hidden in
> an irqchip driver.
> 
> My ask was that if we needed such information, and assuming that it is
> possible to obtain it in a reliable way, this should come from the core
> code, and not be invented by random drivers.

Thanks Marc for explain my problem!

Right, all I need is a notification in MPM irqchip driver when the CPU
domain/cluster is about to enter low power state.  As cpu_pm -
kernel/cpu_pm.c, already has helper cpu_cluster_pm_enter() sending
CPU_CLUSTER_PM_ENTER event, I just need to find a caller to this cpu_pm
helper.  

Is .power_off hook of generic_pm_domain a better place for calling the
helper?

Shawn

----8<------------
diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index ff2c3f8e4668..58aad15851f9 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) "CPUidle PSCI: " fmt
 
 #include <linux/cpu.h>
+#include <linux/cpu_pm.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
@@ -33,6 +34,7 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
 {
        struct genpd_power_state *state = &pd->states[pd->state_idx];
        u32 *pd_state;
+       int ret;
 
        if (!state->data)
                return 0;
@@ -44,6 +46,16 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
        pd_state = state->data;
        psci_set_domain_state(*pd_state);
 
+       if (list_empty(&pd->child_links)) {
+               /*
+                * The top domain (not being a child of anyone) should be the
+                * best one triggering PM notification.
+                */
+               ret = cpu_cluster_pm_enter();
+               if (ret)
+                       return ret;
+       }
+
        return 0;
 }

