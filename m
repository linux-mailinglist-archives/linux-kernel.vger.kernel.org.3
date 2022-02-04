Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4850A4AA448
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378115AbiBDXYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:24:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60958 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346197AbiBDXYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:24:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 553CFB83973;
        Fri,  4 Feb 2022 23:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07821C340F0;
        Fri,  4 Feb 2022 23:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017048;
        bh=EnUP4evSm9pHbY5I/gW2mI3yvHr8E8M9zkokamOt2mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LkD/mAKjCco9ffJfgdLcTqIeY8837S5n7V0mSJLhZ5dsqX6t4FeLKLlgU8O/XBU5p
         n8c0AiSdU13zdV5Hz6XX9z51F30/yMvu5CZUS1z0N4M+lDvHP+L9Yv0L+1wnoqLABI
         /e7Lq+VRyGbyMbfXg80LR366FfwpyV++HAZivjWsQ91LyPXB9sa0r4FZJjvpwgkpnH
         m0gb5rdpkuQqvLfpV8dN2/TzE2UbWn54dtBK2bR3D6L7DHWe8xCgJYF+jps5LBsC2r
         F52z5iD4RB7gs8TD0AXhZdnXH2cK4cW2NdHweTjegJiCqNoyFNu6diGEGcg15yurTH
         SHmH7tjNEhB7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C58AB5C08DD; Fri,  4 Feb 2022 15:24:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/10] rcu: Create per-cpu rcuc kthreads only when rcutree.use_softirq=0
Date:   Fri,  4 Feb 2022 15:24:00 -0800
Message-Id: <20220204232406.814-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
References: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

The per-CPU "rcuc" kthreads are used only by kernels booted with
rcutree.use_softirq=0, but they are nevertheless unconditionally created
by kernels built with CONFIG_RCU_BOOST=y.  This results in "rcuc"
kthreads being created that are never actually used.  This commit
therefore refrains from creating these kthreads unless the kernel
is actually booted with rcutree.use_softirq=0.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4c25a6283b0b..4e5e37e5ee3c9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2894,7 +2894,7 @@ static int __init rcu_spawn_core_kthreads(void)
 
 	for_each_possible_cpu(cpu)
 		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
-	if (!IS_ENABLED(CONFIG_RCU_BOOST) && use_softirq)
+	if (use_softirq)
 		return 0;
 	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec),
 		  "%s: Could not start rcuc kthread, OOM is now expected behavior\n", __func__);
-- 
2.31.1.189.g2e36527f23

