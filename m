Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE17D465A93
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354180AbhLBAWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354130AbhLBAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:22:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8008FC061574;
        Wed,  1 Dec 2021 16:19:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48128B8210E;
        Thu,  2 Dec 2021 00:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F316BC53FAD;
        Thu,  2 Dec 2021 00:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404347;
        bh=fTzinK33PcZDFaHv7z1fe+4X03/KelxR0tcF1N+eP1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aPQxE5K8Vfo4Bg4WqvEdLbRFLJLX/K7fiDeEg64xVmj72SAQ9ls+7SWQrm2/gLMxG
         N7DLtOMIuv4c/vnVnafUBod44+00lCdgQY6++lcLcYAIHm5P7VLZ0K04brojxRZyZs
         yia63DoD6euETBaHSrhUXKE9t4U/k2XMzjyHa71Smf9CFgRHWzq1qCviYjuA7h7NNq
         o2NAU94Zyr1jzNTxVLKYH/k1uRX0XcH7DETzhq/Crek6uKZ+h/JQ1g3WvaGkFQLUPJ
         fjGqM2Nd1/f18dDwMx3n4ij+gjY+Ql/7mR619R1bcgOmSTQlBTTdOA4xM2Zw2sNHTT
         o/pGXI0iT8nnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C2F665C1107; Wed,  1 Dec 2021 16:19:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/4] torture: Remove RCU_FAST_NO_HZ from rcuscale and refscale scenarios
Date:   Wed,  1 Dec 2021 16:19:01 -0800
Message-Id: <20211202001904.3126929-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202001838.GA3126627@paulmck-ThinkPad-P17-Gen-1>
References: <20211202001838.GA3126627@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the rcuscale and refscale scenarios that mention the Kconfig option
CONFIG_RCU_FAST_NO_HZ disable it.  But this Kconfig option is disabled by
default, so this commit removes the pointless "CONFIG_RCU_FAST_NO_HZ=n"
lines from these scenarios.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcuscale/TINY      | 1 -
 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01   | 1 -
 tools/testing/selftests/rcutorture/configs/rcuscale/TREE      | 1 -
 tools/testing/selftests/rcutorture/configs/rcuscale/TREE54    | 1 -
 tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT | 1 -
 tools/testing/selftests/rcutorture/configs/refscale/PREEMPT   | 1 -
 6 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
index 64e9490c1f797..0fa2dc086e10c 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
@@ -7,7 +7,6 @@ CONFIG_PREEMPT_DYNAMIC=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
index e6baa2fbaeb33..227aba7783aff 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
@@ -5,7 +5,6 @@ CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
index 4cc1cc5813214..f110d9ffbe4cb 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
@@ -6,7 +6,6 @@ CONFIG_PREEMPT=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_HOTPLUG_CPU=y
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
index f5952061fde7b..9f83e53727969 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
@@ -7,7 +7,6 @@ CONFIG_PREEMPT=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_HOTPLUG_CPU=y
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
index ad505a887bec4..7f06838a91e61 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
@@ -6,7 +6,6 @@ CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_HOTPLUG_CPU=y
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
index 4f08e641bb6b8..52e3ef6740567 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
@@ -6,7 +6,6 @@ CONFIG_PREEMPT=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_HOTPLUG_CPU=y
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
-- 
2.31.1.189.g2e36527f23

