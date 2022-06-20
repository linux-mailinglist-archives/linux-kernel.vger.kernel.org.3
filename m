Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D0D55276E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346188AbiFTXAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346008AbiFTW7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:59:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5394819C16;
        Mon, 20 Jun 2022 15:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C694DB8164C;
        Mon, 20 Jun 2022 22:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A404C341CF;
        Mon, 20 Jun 2022 22:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765900;
        bh=lkXPYbCU6J1sMOYOFTGUNwP6b8VX52iPPeaB18M4sJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+NV2xHvgTWjzhRFD6v8kuYd+nTk5kr3p1xxBKsFK530HaLi/h3o4eqmzPETv3Qfi
         9tOOS/DN8WI4N88fVjdF7Ow48RAOEl8IPfpGhhrm9AY+AQxVK2gpE2TpkdXCZK6DA7
         TWf20BsYspTzE914RXl1ncX9qjOq8xklNLLvi5FO1317rRz+7weDcc6/JTN+xPVUej
         VkMqiKPwHFTp+/U4XGnEO6gG9IDLWB9TH0sG6A8Ans/2q1ucmBh23QnnXKHO06pOYH
         XTwyoRoLstOOaaIcY4+hVk954GGpormi4tqSoac4yt0tUtlPdNdY40iTS1Dv1TqQYg
         NnfFc/NKIQHYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A19455C0BCC; Mon, 20 Jun 2022 15:58:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/12] rcu/rcuscale: Fix smp_processor_id()-in-preemptible warnings
Date:   Mon, 20 Jun 2022 15:58:12 -0700
Message-Id: <20220620225817.3843106-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
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

From: Zqiang <qiang1.zhang@intel.com>

Systems built with CONFIG_DEBUG_PREEMPT=y can trigger the following
BUG while running the rcuscale performance test:

BUG: using smp_processor_id() in preemptible [00000000] code: rcu_scale_write/69
CPU: 0 PID: 66 Comm: rcu_scale_write Not tainted 5.18.0-rc7-next-20220517-yoctodev-standard+
caller is debug_smp_processor_id+0x17/0x20
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x5e
dump_stack+0x10/0x12
check_preemption_disabled+0xdf/0xf0
debug_smp_processor_id+0x17/0x20
rcu_scale_writer+0x2b5/0x580
kthread+0x177/0x1b0
ret_from_fork+0x22/0x30
</TASK>

Reproduction method:
runqemu kvm slirp nographic qemuparams="-m 4096 -smp 8" bootparams="isolcpus=2,3
nohz_full=2,3 rcu_nocbs=2,3 rcutree.dump_tree=1 rcuscale.shutdown=false
rcuscale.gp_async=true" -d

The problem is that the rcu_scale_writer() kthreads fail to set the
PF_NO_SETAFFINITY flags, which causes is_percpu_thread() to assume
that the kthread's affinity might change at any time, thus the BUG
noted above.

This commit therefore causes rcu_scale_writer() to set PF_NO_SETAFFINITY
in its kthread's ->flags field, thus preventing this BUG.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 277a5bfb37d48..3ef02d4a81085 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -419,6 +419,7 @@ rcu_scale_writer(void *arg)
 	VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
 	WARN_ON(!wdpp);
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	current->flags |= PF_NO_SETAFFINITY;
 	sched_set_fifo_low(current);
 
 	if (holdoff)
-- 
2.31.1.189.g2e36527f23

