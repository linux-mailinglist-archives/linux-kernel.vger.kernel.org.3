Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21A85060D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbiDSAS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbiDSASM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F61140B9;
        Mon, 18 Apr 2022 17:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800DE61345;
        Tue, 19 Apr 2022 00:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBD4C385C8;
        Tue, 19 Apr 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327327;
        bh=l24NnFXImrXB1wlbsG6oWhuBGpxHWz1mLxrXcL33cVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bUTKNJSM9grlp7vlX57pNLQxKxFEGipN1VRjs6VBPtKUcfSokqFjqUaSguld5nsh1
         nCsTjPgdvpw/FvXxPMZlgqiUoCHhor5R+bsjNrXV/yX0vlQAVokyqBEzBegHOJQhE0
         eGm8bLojrdcvi554q/tfbf+1LTEl7/OX0bitRYOBsHl+tbKVSASfzVRBX7Hky72ler
         5Ikdg5utDuAQLBURH4eBGppQSHtEhzGnBMEAXza+ywDbacFW7YRLJsjYoaz4z+Xp8A
         5bJ1hs9cAjvRrZIe7PXOhwSMXukjEAiDdYrhPZyNqgFurZ+l8X8iv16SDBBUa9XMPx
         az00sVM0GCEkQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CEF3A5C0DFD; Mon, 18 Apr 2022 17:15:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/12] rcutorture: Adjust scenarios' Kconfig options for CONFIG_PREEMPT_DYNAMIC
Date:   Mon, 18 Apr 2022 17:15:20 -0700
Message-Id: <20220419001525.3950505-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
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

Now that CONFIG_PREEMPT_DYNAMIC=y is the default, kernels that are
ostensibly built with CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y
are now actually built with CONFIG_PREEMPT=y, but are by default booted
so as to disable preemption.  Although this allows much more flexibility
from a single kernel binary, it means that the current rcutorture
scenarios won't find build errors that happen only when preemption is
fully disabled at build time.

This commit therefore adds CONFIG_PREEMPT_DYNAMIC=n to several scenarios,
and while in the area switches one from CONFIG_PREEMPT_NONE=y to
CONFIG_PREEMPT_VOLUNTARY=y to add coverage of this Kconfig option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01 | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE04  | 5 +++--
 tools/testing/selftests/rcutorture/configs/rcu/TREE07  | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE10  | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
index e4d74e5fc1d0..b54cefde6e87 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -4,6 +4,7 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
 #CHECK#CONFIG_PROVE_RCU=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
index 22ad0261728d..ae395981b5e5 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
@@ -1,8 +1,9 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
-CONFIG_PREEMPT_NONE=y
-CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TREE_RCU=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE07 b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
index 2789b47e4ecd..d30922d8c883 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE07
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
@@ -3,6 +3,7 @@ CONFIG_NR_CPUS=16
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TREE_RCU=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index 4a00539bfdd7..a323d8948b7c 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -3,6 +3,7 @@ CONFIG_NR_CPUS=56
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TREE_RCU=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
-- 
2.31.1.189.g2e36527f23

