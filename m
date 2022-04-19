Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C195060C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiDSAPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbiDSAPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:15:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C217562C8;
        Mon, 18 Apr 2022 17:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 833F7B8113A;
        Tue, 19 Apr 2022 00:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67C1C385B8;
        Tue, 19 Apr 2022 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327155;
        bh=a/jgEw201k/x9500vftbHutjfS0iPgA2hRuL31Qcr/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWqxWA7A2WFAhxXQAa2sHNk+3D9Qj2VauHXePaDYXlq9mqQRH8Cq0ESkr0U+MKupM
         Zy7mBy8Kt3EcSNAqiM1QKR5wrbjCtHlH+Xh8YXvNy+ipe2/f53YtBHf2LXLdhRK+yr
         5DYkA0wXcq6sT/k+FGHScSuAQWqzSkz6dyS5v0oHbVnXmoRIIDTm0a7OSQswP4DTFN
         Ygziixwb8e/p3DPos4pKHB3+FsdF9cNypKrMiRFR3LFeTqDPTBom2rvNdjCLYUC5rv
         OkiEFrnKpPZ3xHz8Zd2JMYMGk/Ihv9R1sQAMhpKJJAWTB1DvQDqCRYtAUiJYzXvy/8
         goFEQJP6nYONw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4B3C75C0DFD; Mon, 18 Apr 2022 17:12:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/12] rcutorture: Allow specifying per-scenario stat_interval
Date:   Mon, 18 Apr 2022 17:12:28 -0700
Message-Id: <20220419001233.3950188-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcutorture test suite makes double use of the rcutorture.stat_interval
module parameter.  As its name suggests, it controls the frequency
of statistics printing, but it also controls the rcu_torture_writer()
stall timeout.  The current setting of 15 seconds works surprisingly well.
However, given that the RCU tasks stall-warning timeout is ten -minutes-,
15 seconds is too short for TASKS02, which runs a non-preemptible kernel
on a single CPU.

This commit therefore adds checks for per-scenario specification of the
rcutorture.stat_interval module parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../rcutorture/configs/rcu/TASKS02.boot          |  1 +
 .../rcutorture/configs/rcu/ver_functions.sh      | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS02.boot b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02.boot
index cd2a188eeb6d..b9b6d67cbc5f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS02.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02.boot
@@ -1 +1,2 @@
 rcutorture.torture_type=tasks
+rcutorture.stat_interval=60
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh
index effa415f9b92..e2bc99c785e7 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh
@@ -9,7 +9,7 @@
 
 # rcutorture_param_n_barrier_cbs bootparam-string
 #
-# Adds n_barrier_cbs rcutorture module parameter to kernels having it.
+# Adds n_barrier_cbs rcutorture module parameter if not already specified.
 rcutorture_param_n_barrier_cbs () {
 	if echo $1 | grep -q "rcutorture\.n_barrier_cbs"
 	then
@@ -30,13 +30,25 @@ rcutorture_param_onoff () {
 	fi
 }
 
+# rcutorture_param_stat_interval bootparam-string
+#
+# Adds stat_interval rcutorture module parameter if not already specified.
+rcutorture_param_stat_interval () {
+	if echo $1 | grep -q "rcutorture\.stat_interval"
+	then
+		:
+	else
+		echo rcutorture.stat_interval=15
+	fi
+}
+
 # per_version_boot_params bootparam-string config-file seconds
 #
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
 	echo $1 `rcutorture_param_onoff "$1" "$2"` \
 		`rcutorture_param_n_barrier_cbs "$1"` \
-		rcutorture.stat_interval=15 \
+		`rcutorture_param_stat_interval "$1"` \
 		rcutorture.shutdown_secs=$3 \
 		rcutorture.test_no_idle_hz=1 \
 		rcutorture.verbose=1
-- 
2.31.1.189.g2e36527f23

