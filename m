Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2452C465B54
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354819AbhLBAuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:50:12 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60134 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344534AbhLBAuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:50:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 640FECE2073;
        Thu,  2 Dec 2021 00:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92958C00446;
        Thu,  2 Dec 2021 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405996;
        bh=JdyUZusnbMsfG6eCXlvnQlo13H3WNWvpJ43QR9UXbSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFr2sEGtFMrLlbiB/De75nLRw6qvYXSWouq99m80/v4IDa07+z3FLJjw5xk/3dJ7A
         y4T/MaaokwpuUDsBViZIEme12MsZSTg7jjOjGRKUTvW0vOLZAGfEcXbVcI9IYuJKjw
         cURj7W9OoJcPr6sITffgEj8sHUvyxYX0WFDPwzFc7iGF5m8xequBFyUrWFeZfUbLxS
         CxSAGF+hpucbsDAJosdqI6S59Le4kTWL+jVWhza4a+BvJWBOJJf85l7i9gRId1nR1x
         CmZRN9DcjRZAOscA04Y6WluJEKSdK2MW9SrTumUMvS+UFRbicWW5K5+3PuGncGC1kb
         FhSVC88A13xKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 62B335C0FCD; Wed,  1 Dec 2021 16:46:36 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/8] rcutorture: Add CONFIG_PREEMPT_DYNAMIC=n to tiny scenarios
Date:   Wed,  1 Dec 2021 16:46:27 -0800
Message-Id: <20211202004634.3130489-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_PREEMPT_DYNAMIC=y, the kernel builds with CONFIG_PREEMPTION=y
because preemption can be enabled at runtime.  This prevents any tests
of Tiny RCU or Tiny SRCU from running correctly.  This commit therefore
explicitly sets CONFIG_PREEMPT_DYNAMIC=n for those scenarios.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-T    | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-U    | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TINY01    | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TINY02    | 1 +
 tools/testing/selftests/rcutorture/configs/rcuscale/TINY | 1 +
 5 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
index d6557c38dfe47..c70cf0405f248 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
@@ -2,6 +2,7 @@ CONFIG_SMP=n
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TINY_SRCU=y
 CONFIG_RCU_TRACE=n
 CONFIG_DEBUG_LOCK_ALLOC=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
index 6bc24e99862f9..bc9eeabaa1b18 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
@@ -2,6 +2,7 @@ CONFIG_SMP=n
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TINY_SRCU=y
 CONFIG_RCU_TRACE=n
 CONFIG_DEBUG_LOCK_ALLOC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY01 b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
index 6db705e554874..0953c52fcfd76 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
@@ -2,6 +2,7 @@ CONFIG_SMP=n
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TINY_RCU=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY02 b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
index d8674264318d6..30439f6fc20e6 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY02
@@ -2,6 +2,7 @@ CONFIG_SMP=n
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TINY_RCU=y
 CONFIG_HZ_PERIODIC=y
 CONFIG_NO_HZ_IDLE=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
index fb05ef5279b43..64e9490c1f797 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
@@ -2,6 +2,7 @@ CONFIG_SMP=n
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TINY_RCU=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
-- 
2.31.1.189.g2e36527f23

