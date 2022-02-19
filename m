Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441C44BC842
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 12:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbiBSLpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 06:45:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiBSLpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 06:45:49 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182121DE896
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 03:45:30 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c4so4508341pfl.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 03:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=veaGMrL3hdVDtkxd6HVx0RSMj8qvQYZM3xAFP3X71zw=;
        b=U6HzRM3NDm4llX+1fgA1l6/KSVeT81P/QYXqKhy9SBiJLp1+gMadwyWTKO87g6Ea+P
         HODGFPPnJi9gQcQWxVlJtM1LvmIx3v8f4lIAXy216Lt5Lmn5y1Mj7Bk087aDG+bcApZk
         67YKtpLfVM+YnDQd5LjFcx998TmRK8P/JTXUgrnHrL/hrV05lidLdihK82L/PkvrMg57
         hQiWff8KV0d4kBQAfOrPhctRhXCHgVxgoD+pqIHLcGejvNfnJnkgGBvf2I5gpGkxdIJq
         FkQxp4Kqz9l6pe1OpQMpD0OVmXYxD/w7Lms9r6zMoTJCLizDG9MKu/TiWImQf6E/SqC2
         +pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=veaGMrL3hdVDtkxd6HVx0RSMj8qvQYZM3xAFP3X71zw=;
        b=o+ZvsNNhB8Nra6MusMtAm+2EE2iWb8Ros6IIz239E5kB38EgmxHRmWIdyYRtEmg5bj
         j+7JUdDTL3RwjSJkuW+9yhTwmPMvFCQy6mxNY6UNf4y7J7QMgb/mzHQyC8Cub30d/jfX
         jmDV+nd/fDHlbdCopFkqbW2hZRx1xRAuU9Pew+lrExLSHwgSjhx+cb0NhxkhczVtzWrm
         gXF2Yi98Ts4guVDilnn/0X45HHTAQdbVjf4S0VgRRha4cf1qD8VTAXaXjKay0ilOo7ym
         nZPdt8ZGYErTtmzihrTVXQWw0dn1p4EpAanUqHmYs6suHPr+dh9SbouSC34WJ8JY+MJ7
         b+5A==
X-Gm-Message-State: AOAM533Mbx+GmAUy5cigeRdanzaS3EaqRGpnKC8EMSxuMgjN87Ddn4Dz
        GL3PkYMjNtVy49tYxE5RCjl4sQ==
X-Google-Smtp-Source: ABdhPJxCBlGh5Cpn08bVcmNqIL5s+aerMII9LZLpkI4mNIzjZ6/m+jMr2eRveLEdq0NYIertNtEHGg==
X-Received: by 2002:a05:6a00:148b:b0:4e0:1001:1063 with SMTP id v11-20020a056a00148b00b004e010011063mr11974580pfu.15.1645271129521;
        Sat, 19 Feb 2022 03:45:29 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g20sm6221007pfj.64.2022.02.19.03.45.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Feb 2022 03:45:28 -0800 (PST)
Date:   Sat, 19 Feb 2022 19:45:21 +0800
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
Message-ID: <20220219114520.GG31965@dragon>
References: <20220216132830.32490-1-shawn.guo@linaro.org>
 <20220216132830.32490-2-shawn.guo@linaro.org>
 <20220216144937.znsba7zbdenl7427@bogus>
 <9bda65e5bb85b00eaca71d95ad78e93b@kernel.org>
 <20220217073130.GD31965@dragon>
 <875ypd50z0.wl-maz@kernel.org>
 <20220217133702.GF31965@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217133702.GF31965@dragon>
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

On Thu, Feb 17, 2022 at 09:37:03PM +0800, Shawn Guo wrote:
> On Thu, Feb 17, 2022 at 08:52:35AM +0000, Marc Zyngier wrote:
> > On Thu, 17 Feb 2022 07:31:32 +0000,
> > Shawn Guo <shawn.guo@linaro.org> wrote:
> > > 
> > > On Wed, Feb 16, 2022 at 03:58:41PM +0000, Marc Zyngier wrote:
> > > > On 2022-02-16 14:49, Sudeep Holla wrote:
> > > > > +Ulf (as you he is the author of cpuidle-psci-domains.c and can help you
> > > > > with that if you require)
> > > 
> > > Thanks, Sudeep!
> > > 
> > > > > 
> > > > > On Wed, Feb 16, 2022 at 09:28:28PM +0800, Shawn Guo wrote:
> > > > > > Make a call to cpu_cluster_pm_enter() on the last CPU going to low
> > > > > > power
> > > > > > state (and cpu_cluster_pm_exit() on the firt CPU coming back), so that
> > > > > > platforms can be notified to set up hardware for getting into the
> > > > > > cluster
> > > > > > low power state.
> > > > > > 
> > > > > 
> > > > > NACK. We are not getting the notion of CPU cluster back to cpuidle
> > > > > again.
> > > > > That must die. Remember the cluster doesn't map to idle states
> > > > > especially
> > > > > in the DSU systems where HMP CPUs are in the same cluster but can be in
> > > > > different power domains.
> > > 
> > > The 'cluster' in cpu_cluster_pm_enter() doesn't necessarily means
> > > a physical CPU cluster.  I think the documentation of the function has a
> > > better description.
> > > 
> > >  * Notifies listeners that all cpus in a power domain are entering a low power
> > >  * state that may cause some blocks in the same power domain to reset.
> > > 
> > > So cpu_domain_pm_enter() might be a better name?  Anyways ...
> > > 
> > > > > 
> > > > > You need to decide which PSCI CPU_SUSPEND mode you want to use first. If
> > > > > it is
> > > > > Platform Co-ordinated(PC), then you need not notify anything to the
> > > > > platform.
> > > > > Just request the desired idle state on each CPU and platform will take
> > > > > care
> > > > > from there.
> > > > > 
> > > > > If for whatever reason you have chosen OS initiated mode(OSI), then
> > > > > specify
> > > > > the PSCI power domains correctly in the DT which will make use of the
> > > > > cpuidle-psci-domains and handle the so called "cluster" state correctly.
> > > 
> > > Yes, I'm running a Qualcomm platform that has OSI supported in PSCI.
> > > 
> > > > 
> > > > My understanding is that what Shawn is after is a way to detect the "last
> > > > man standing" on the system to kick off some funky wake-up controller that
> > > > really should be handled by the power controller (because only that guy
> > > > knows for sure who is the last CPU on the block).
> > > > 
> > > > There was previously some really funky stuff (copy pasted from the existing
> > > > rpmh_rsc_cpu_pm_callback()), which I totally objected to having hidden in
> > > > an irqchip driver.
> > > > 
> > > > My ask was that if we needed such information, and assuming that it is
> > > > possible to obtain it in a reliable way, this should come from the core
> > > > code, and not be invented by random drivers.
> > > 
> > > Thanks Marc for explain my problem!
> > > 
> > > Right, all I need is a notification in MPM irqchip driver when the CPU
> > > domain/cluster is about to enter low power state.  As cpu_pm -
> > > kernel/cpu_pm.c, already has helper cpu_cluster_pm_enter() sending
> > > CPU_CLUSTER_PM_ENTER event, I just need to find a caller to this cpu_pm
> > > helper.  
> > > 
> > > Is .power_off hook of generic_pm_domain a better place for calling the
> > > helper?
> > 
> > I really don't understand why you want a cluster PM event generated by
> > the idle driver.  Specially considering that you are not after a
> > *cluster* PM event, but after some sort of system-wide event (last man
> > standing).
> 
> That's primarily because MPM driver is used in the idle context, either
> s2idle or cpuidle, and idle driver already has some infrastructure that
> could help trigger the event.
> 
> > It looks to me that having a predicate that can be called from a PM
> > notifier event to find out whether you're the last in line would be
> > better suited, and could further be used to remove the crap from the
> > rpmh-rsc driver.
> 
> I will see if I can come up with a patch for discussion.

How about this?

---8<-----------
From 0176b2311764959bb5f3322865bf85440eaf769e Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Sat, 19 Feb 2022 13:35:47 +0800
Subject: [PATCH] PM: cpu: Add CPU_LAST_PM_ENTER and CPU_FIRST_PM_EXIT support

It becomes a common situation on some platforms that certain hardware
setup needs to be done on the last standing cpu, and rpmh-rsc[1] is such
an existing example.  As figuring out the last standing cpu is really
something generic, it adds CPU_LAST_PM_ENTER (and CPU_FIRST_PM_EXIT)
event support to cpu_pm helper, so that individual driver can be
notified when the last standing cpu is about to enter low power state.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/qcom/rpmh-rsc.c?id=v5.16#n773

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 include/linux/cpu_pm.h | 15 +++++++++++++++
 kernel/cpu_pm.c        | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpu_pm.h b/include/linux/cpu_pm.h
index 552b8f9ea05e..153344307b7c 100644
--- a/include/linux/cpu_pm.h
+++ b/include/linux/cpu_pm.h
@@ -55,6 +55,21 @@ enum cpu_pm_event {
 
 	/* A cpu power domain is exiting a low power state */
 	CPU_CLUSTER_PM_EXIT,
+
+	/*
+	 * A cpu is entering a low power state after all other cpus
+	 * in the system have entered the lower power state.
+	 */
+	CPU_LAST_PM_ENTER,
+
+	/* The last cpu failed to enter a low power state */
+	CPU_LAST_PM_ENTER_FAILED,
+
+	/*
+	 * A cpu is exiting a low power state before any other cpus
+	 * in the system exits the low power state.
+	 */
+	CPU_FIRST_PM_EXIT,
 };
 
 #ifdef CONFIG_CPU_PM
diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 246efc74e3f3..7c104446e1e9 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -26,6 +26,8 @@ static struct {
 	.lock  = __RAW_SPIN_LOCK_UNLOCKED(cpu_pm_notifier.lock),
 };
 
+static atomic_t cpus_in_pm;
+
 static int cpu_pm_notify(enum cpu_pm_event event)
 {
 	int ret;
@@ -116,7 +118,20 @@ EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
  */
 int cpu_pm_enter(void)
 {
-	return cpu_pm_notify_robust(CPU_PM_ENTER, CPU_PM_ENTER_FAILED);
+	int ret;
+
+	ret = cpu_pm_notify_robust(CPU_PM_ENTER, CPU_PM_ENTER_FAILED);
+	if (ret)
+		return ret;
+
+	if (atomic_inc_return(&cpus_in_pm) == num_online_cpus()) {
+		ret = cpu_pm_notify_robust(CPU_LAST_PM_ENTER,
+					   CPU_LAST_PM_ENTER_FAILED);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_enter);
 
@@ -134,7 +149,21 @@ EXPORT_SYMBOL_GPL(cpu_pm_enter);
  */
 int cpu_pm_exit(void)
 {
-	return cpu_pm_notify(CPU_PM_EXIT);
+	int ret;
+
+	ret = cpu_pm_notify(CPU_PM_EXIT);
+	if (ret)
+		return ret;
+
+	if (atomic_read(&cpus_in_pm) == num_online_cpus()) {
+		ret = cpu_pm_notify(CPU_FIRST_PM_EXIT);
+		if (ret)
+			return ret;
+	}
+
+	atomic_dec(&cpus_in_pm);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_exit);
 
-- 
2.17.1

