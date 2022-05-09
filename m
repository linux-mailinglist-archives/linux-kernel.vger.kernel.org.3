Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318D2520640
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiEIVCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiEIVCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:02:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7E32B8268;
        Mon,  9 May 2022 13:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 051B861713;
        Mon,  9 May 2022 20:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA88C385BC;
        Mon,  9 May 2022 20:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652129896;
        bh=IeKZl1KrNR+/gyLaaVHgSTmZTx8tZ7Ut+UE732PbzY0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Z7hyQ9vdA8hcPsJOX0QKUWGEPk73NEEMkZCaMstQuinUwliA5ZJ1DzghKE9H8+iPH
         hZTdxffQGxTruSgPhdosJaclIIwphu1NHrCIJz9jIVpSC06+1rTiAprrP+M5px2244
         hWlqMs8/M0EmNHxfkMmm8N0RvDLotZvsibTKKnzddqSNewDGe7J1QT55WXDVjSHdM8
         +FY26rlCnfGjObyjiiNvUH3YTYRWyvB/VFGkGNhdj5Evgi9I5g12vjshVFw9hxq4cH
         XeP+d4lsUzFsri6vVmtfvYty3QMyaSxEQAjRqHgoUNcdm8rx99l32vCthdJcSKu4P2
         t1fTMMm2+tjFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E87505C05F9; Mon,  9 May 2022 13:58:15 -0700 (PDT)
Date:   Mon, 9 May 2022 13:58:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     urezki@gmail.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: And speaking of avoiding inconveniencing users...
Message-ID: <20220509205815.GA1885269@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Uladzislau,

And I wasn't paying attention when reviewing this patch:

084e1c049a8e ("rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT")

Distros specifying 60 seconds for the stall timeout get hit with a silent
change to 21 seconds for the expedited stall timeout.

Unless you tell me otherwise, I will merge the following diff into the
above commit.  So please let me know if this will cause any problems.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 1d863b04727c3..794837eb519b9 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -166,10 +166,12 @@ CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
 --------------------------------
 
 	Same as the CONFIG_RCU_CPU_STALL_TIMEOUT parameter but only for
-	the expedited grace period. This parameter defines the period of
-	time that RCU will wait from the beginning of an expedited grace
-	period until it issues an RCU CPU stall warning. This time period
-	is normally 20 milliseconds on Android devices.
+	the expedited grace period. This parameter defines the period
+	of time that RCU will wait from the beginning of an expedited
+	grace period until it issues an RCU CPU stall warning. This time
+	period is normally 20 milliseconds on Android devices.	A zero
+	value causes the CONFIG_RCU_CPU_STALL_TIMEOUT value to be used,
+	after conversion to milliseconds.
 
 	This configuration parameter may be changed at runtime via the
 	/sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout, however
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 34d44648f3f5d..ca9db809beda3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4936,6 +4936,9 @@
 			and the maximum allowed value is 21000
 			milliseconds. Please note that this value is
 			adjusted to an arch timer tick resolution.
+			Setting this to zero causes the value from
+			rcupdate.rcu_cpu_stall_timeout to be used (after
+			conversion from seconds to milliseconds).
 
 	rcupdate.rcu_expedited= [KNL]
 			Use expedited grace-period primitives, for
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 39dd4b9d647f8..9b64e55d4f615 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -85,15 +85,16 @@ config RCU_CPU_STALL_TIMEOUT
 config RCU_EXP_CPU_STALL_TIMEOUT
 	int "Expedited RCU CPU stall timeout in milliseconds"
 	depends on RCU_STALL_COMMON
-	range 1 21000
+	range 0 21000
 	default 20 if ANDROID
-	default 21000 if !ANDROID
-
+	default 0 if !ANDROID
 	help
 	  If a given expedited RCU grace period extends more than the
 	  specified number of milliseconds, a CPU stall warning is printed.
 	  If the RCU grace period persists, additional CPU stall warnings
-	  are printed at more widely spaced intervals.
+	  are printed at more widely spaced intervals.  A value of zero
+	  says to use the RCU_CPU_STALL_TIMEOUT value converted from
+	  seconds to milliseconds.
 
 config RCU_TRACE
 	bool "Enable tracing for RCU"
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0a25a4ea6eef8..2464b0eccfd02 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -31,15 +31,17 @@ int rcu_exp_jiffies_till_stall_check(void)
 	int exp_stall_delay_delta = 0;
 	int till_stall_check;
 
-	/*
-	 * Limit check must be consistent with the Kconfig limits for
-	 * CONFIG_RCU_EXP_CPU_STALL_TIMEOUT, so check the allowed range.
-	 * The minimum clamped value is "2UL", because at least one full
-	 * tick has to be guaranteed.
-	 */
+	// Zero says to use rcu_cpu_stall_timeout, but in milliseconds.
+	if (!cpu_stall_timeout)
+		cpu_stall_timeout = jiffies_to_msecs(rcu_jiffies_till_stall_check());
+
+	// Limit check must be consistent with the Kconfig limits for
+	// CONFIG_RCU_EXP_CPU_STALL_TIMEOUT, so check the allowed range.
+	// The minimum clamped value is "2UL", because at least one full
+	// tick has to be guaranteed.
 	till_stall_check = clamp(msecs_to_jiffies(cpu_stall_timeout), 2UL, 21UL * HZ);
 
-	if (jiffies_to_msecs(till_stall_check) != cpu_stall_timeout)
+	if (cpu_stall_timeout && jiffies_to_msecs(till_stall_check) != cpu_stall_timeout)
 		WRITE_ONCE(rcu_exp_cpu_stall_timeout, jiffies_to_msecs(till_stall_check));
 
 #ifdef CONFIG_PROVE_RCU
