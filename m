Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE9E50C002
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiDVSyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiDVSyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:54:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE08616D987;
        Fri, 22 Apr 2022 11:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB32DB8321E;
        Fri, 22 Apr 2022 18:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937C6C385A0;
        Fri, 22 Apr 2022 18:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650652932;
        bh=U10hpA2FN+1veBlILEFUKuB1ORcAow417p82jNSKGes=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ChtK86B1kZFaIlBSPd8+2tmh2neTUtBuotxyGuN3GvEmlo6fTTkQ/6O1uQwW6M6Sx
         p8uRBELGKdZZfG5KG1QbVaA38AuI5ftrUOp/8HhuriwDR8ZghI8fjyOLtwZLhy/BUa
         Ugq5/xN2H8I7fhS3qrFdmNn3tm1k5zoMISHLPecd3xVKi0DMG4FA+lTxexdgJGo3Dh
         eCCHZv0mrdW44y0gRYgFmL2ce1Lkn/9Jc/tJ3hSaNgu0h2ufwcaq0jBMz7Nq7Jqbnj
         zQLSVSnss8P5UzMuIA2D3nQd5nWqVwr316dLDSZhb8NzxXwBrpXHtjxOZCRbPjZ6gG
         DuhfYFilCgJfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 385DC5C0641; Fri, 22 Apr 2022 11:42:12 -0700 (PDT)
Date:   Fri, 22 Apr 2022 11:42:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        kernel test robot <lkp@intel.com>, rcu@vger.kernel.org,
        rushikesh.s.kadam@intel.com
Subject: Re: [PATCH v4.1] rcu/nocb: Add an option to offload all CPUs on boot
Message-ID: <20220422184212.GH4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220422175247.2197949-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422175247.2197949-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 05:52:47PM +0000, Joel Fernandes (Google) wrote:
> From: Joel Fernandes <joel@joelfernandes.org>
> 
> On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> which ends up not offloading any CPU. This patch removes a dependency
> from the bootloader having to know about RCU and about how to provide
> the mask.
> 
> With the new option enabled, all CPUs will be offloaded on boot unless
> rcu_nocbs= or rcu_nohz_full= kernel parameters provide a CPU list.
> 
> Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
> Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
> (In v4.1, fixed issues with CONFIG maze reported by kernel test robot).
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> ---
> 
> Rebased and tested on rcu/dev branch.
> 
>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>  kernel/rcu/Kconfig                              | 13 +++++++++++++
>  kernel/rcu/tree_nocb.h                          | 15 ++++++++++++++-
>  3 files changed, 33 insertions(+), 1 deletion(-)

Thank you, Joel!  I have queued this for v5.20 and for testing and
further review.  As before, please see below to check my wordsmithing.

							Thanx, Paul

------------------------------------------------------------------------

commit 42942fb3cad5d96e0b2b97deec05504d57908e1c
Author: Joel Fernandes <joel@joelfernandes.org>
Date:   Fri Apr 22 17:52:47 2022 +0000

    rcu/nocb: Add an option to offload all CPUs on boot
    
    Systems built with CONFIG_RCU_NOCB_CPU=y but booted without either
    the rcu_nocbs= or rcu_nohz_full= kernel-boot parameters will not have
    callback offloading on any of the CPUs, nor can any of the CPUs be
    switched to enable callback offloading at runtime.  Although this is
    intentional, it would be nice to have a way to offload all the CPUs
    without having to make random bootloaders specify either the rcu_nocbs=
    or the rcu_nohz_full= kernel-boot parameters.
    
    This commit therefore provides a new CONFIG_RCU_NOCB_CPU_DEFAULT_ALL
    Kconfig option that switches the default so as to offload callback
    processing on all of the CPUs.  This default can still be overridden
    using the rcu_nocbs= and rcu_nohz_full= kernel-boot parameters.
    
    Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
    Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
    (In v4.1, fixed issues with CONFIG maze reported by kernel test robot).
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b80c458d12ec4..9a690d49547e8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3572,6 +3572,9 @@
 			just as if they had also been called out in the
 			rcu_nocbs= boot parameter.
 
+			Note that this argument takes precedence over
+			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
+
 	noiotrap	[SH] Disables trapped I/O port accesses.
 
 	noirqdebug	[X86-32] Disables the code which attempts to detect and
@@ -4475,6 +4478,9 @@
 			no-callback mode from boot but the mode may be
 			toggled at runtime via cpusets.
 
+			Note that this argument takes precedence over
+			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
+
 	rcu_nocb_poll	[KNL]
 			Rather than requiring that offloaded CPUs
 			(specified by rcu_nocbs= above) explicitly
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 1c630e573548d..27aab870ae4cf 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -262,6 +262,19 @@ config RCU_NOCB_CPU
 	  Say Y here if you need reduced OS jitter, despite added overhead.
 	  Say N here if you are unsure.
 
+config RCU_NOCB_CPU_DEFAULT_ALL
+	bool "Offload RCU callback processing from all CPUs by default"
+	depends on RCU_NOCB_CPU
+	default n
+	help
+	  Use this option to offload callback processing from all CPUs
+	  by default, in the absence of the rcu_nocbs or nohz_full boot
+	  parameter. This also avoids the need to use any boot parameters
+	  to achieve the effect of offloading all CPUs on boot.
+
+	  Say Y here if you want offload all CPUs by default on boot.
+	  Say N here if you are unsure.
+
 config TASKS_TRACE_RCU_READ_MB
 	bool "Tasks Trace RCU readers use memory barriers in user and idle"
 	depends on RCU_EXPERT && TASKS_TRACE_RCU
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 4cf9a29bba79d..60cc92cc66552 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1197,11 +1197,21 @@ void __init rcu_init_nohz(void)
 {
 	int cpu;
 	bool need_rcu_nocb_mask = false;
+	bool offload_all = false;
 	struct rcu_data *rdp;
 
+#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
+	if (!rcu_state.nocb_is_setup) {
+		need_rcu_nocb_mask = true;
+		offload_all = true;
+	}
+#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
+
 #if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
+	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
 		need_rcu_nocb_mask = true;
+		offload_all = false; /* NO_HZ_FULL has its own mask. */
+	}
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
 	if (need_rcu_nocb_mask) {
@@ -1222,6 +1232,9 @@ void __init rcu_init_nohz(void)
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
+	if (offload_all)
+		cpumask_setall(rcu_nocb_mask);
+
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
