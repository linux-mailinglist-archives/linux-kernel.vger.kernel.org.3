Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF2C4AA4BB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378438AbiBDX4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57320 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359219AbiBDX4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D018661CE6;
        Fri,  4 Feb 2022 23:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0233C340FF;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=shurJ2a87z3WWsM/OwHqpKalILP1DiRVFwqVYqO+z1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQWhG1vt2wow6LmszqC6l+DMqxJjeHhFe4swKqRDCqFsTWHF0/fpZXKnJGwrM9Ms+
         BbkmhSmYCq2kP4IeJ/JEMTHgHPn+1h2mwAnaCj1hgDVN3xAL8V7su6s0gdaSVKmiZS
         khDpF8qWB+67Re4GaPzYTAdJE1AHDjbTzj1QtkKH934poBmZhoMkSb4Rm4DiGmEqBf
         RgGsLuqWiF8uqzfZh13dZXRtV/JtW1xRZEDaMKxOzwR5LqNMz+9lyBjRK4B1IeEi1U
         q/1sX5CuitHUGlfcCMkcT3ItZ6vvo5/KHS4lUVCsF1Q0ER578mlOaXrYC+RGOManHx
         MnDbH0U8n2Vfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6ABA45C0F91; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/13] rcutorture: Provide non-power-of-two Tasks RCU scenarios
Date:   Fri,  4 Feb 2022 15:56:01 -0800
Message-Id: <20220204235601.3438-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adjusts RUDE01 to 3 CPUs and TRACE01 to 5 CPUs in order to
test Tasks RCU's ability to handle non-power-of-two numbers of CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01  | 2 +-
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01 b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
index 3ca112444ce77..7093422050f66 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
@@ -1,5 +1,5 @@
 CONFIG_SMP=y
-CONFIG_NR_CPUS=4
+CONFIG_NR_CPUS=3
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
index 34c8ff5a12f20..e4d74e5fc1d09 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -1,5 +1,5 @@
 CONFIG_SMP=y
-CONFIG_NR_CPUS=4
+CONFIG_NR_CPUS=5
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
-- 
2.31.1.189.g2e36527f23

