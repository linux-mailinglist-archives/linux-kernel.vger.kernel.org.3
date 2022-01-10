Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB6489939
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiAJNGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:06:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiAJNGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:06:48 -0500
Date:   Mon, 10 Jan 2022 13:06:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641820007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=T0Slxnn14JAnVhGb1mweykYnC4DBxw82mWSx/26Vbvk=;
        b=X0r0PA+FfW/itO+tWL3qd+luUpcI/O46vlnJOHjuHGlkHDEniAtB9uOLgnpy3I+DiPwr/7
        HJXmVDrYO8pIrfIdzM11kvN1VL6pRL2ih/GN9cBqMwKH4NRapif7Sg6k4ONyY46OsU5Ods
        E7HTRg5XfPMy1JQ8lBeyvcRu9IoBTDpKOusYsplDu6651AJ206mzXSBR40SoRoPh7WsybM
        NYFrXMNw64XAsJjwZDa7PZ020uKiOZjPby/UL5H56rm6QqnWZq8mGfaT+hEop4ZiZiTUOs
        MukoU2dsrEbmVInvH2p7VmYkBgh1Zqmh7fh5ND1sWsBAxMot6GJ4y8Gb4nMCRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641820007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=T0Slxnn14JAnVhGb1mweykYnC4DBxw82mWSx/26Vbvk=;
        b=eUphaHYLem7CoaY4zf9iiCtK2J/P3sumcJY9B4AdkOAe2396bCjCq08v1lRWI/eIG1YpvS
        gZTSKp9OMX1SjICg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] rcutorture: Add CONFIG_PREEMPT_DYNAMIC=n to tiny scenarios
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164182000627.16921.16262863092313787853.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8c0abfd6d2f6b0221194241ac2908751a2a0385f
Gitweb:        https://git.kernel.org/tip/8c0abfd6d2f6b0221194241ac2908751a2a0385f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 17 Nov 2021 18:57:01 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 30 Nov 2021 17:20:58 -08:00

rcutorture: Add CONFIG_PREEMPT_DYNAMIC=n to tiny scenarios

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
index d6557c3..c70cf04 100644
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
index 6bc24e9..bc9eeab 100644
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
index 6db705e..0953c52 100644
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
index d867426..30439f6 100644
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
index fb05ef5..64e9490 100644
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
