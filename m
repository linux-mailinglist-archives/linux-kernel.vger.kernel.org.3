Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB009552724
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344630AbiFTWvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344175AbiFTWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB551CB10;
        Mon, 20 Jun 2022 15:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B35613F7;
        Mon, 20 Jun 2022 22:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B5DC341D5;
        Mon, 20 Jun 2022 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765490;
        bh=oMsHSf3dnE1PCs3K0mPgTlXOBWPjOTVil2QL7Pc287I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tf0sEhNyvz9OwkVPws0rI4VEOFBxn29UvS7QiWe8ip/oReiP4pIWRpTLvr7wFe/A7
         T1wfb9cetYPxZzGdN0dP7Mt6EetSEu+EiOFvupeqJyuEUEWinb0X2qflZPg0lgTqHe
         i3BrbHH0i6e0fPUqVxjgKKqAI5ZQLlD2ytRrYLqmUA0eF9ouJl1PjrCj3H7L8oPvjU
         gq065X++7ih4athDNH7Z4wHLZnUH5s5Fmwbd3+1+4/lQmSYlnXjvUXUCP3QAIjCD3R
         S2kjujXAgKbTSufin7CQ72X2rDtAkQacBqiZXGdKZ2qXeno+oyAI1YG/fA4vNkd4DF
         4EQYkfsIJhC3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A96045C0E3F; Mon, 20 Jun 2022 15:51:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/12] rcu: Add irqs-disabled indicator to expedited RCU CPU stall warnings
Date:   Mon, 20 Jun 2022 15:51:28 -0700
Message-Id: <20220620225128.3842050-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
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

If a CPU has interrupts disabled continuously starting before the
beginning of a given expedited RCU grace period, that CPU will not
execute that grace period's IPI handler.  This will in turn mean
that the ->cpu_no_qs.b.exp field in that CPU's rcu_data structure
will continue to contain the boolean value false.

Knowing whether or not a CPU has had interrupts disabled can be helpful
when debugging an expedited RCU CPU stall warning, so this commit
adds a "D" indicator expedited RCU CPU stall warnings that signifies
that the corresponding CPU has had interrupts disabled throughout.

This capability was tested as follows:

runqemu kvm slirp nographic qemuparams="-m 4096 -smp 4"  bootparams=
"isolcpus=2,3 nohz_full=2,3 rcu_nocbs=2,3 rcutree.dump_tree=1
rcutorture.stall_cpu_holdoff=30 rcutorture.stall_cpu=40
rcutorture.stall_cpu_irqsoff=1 rcutorture.stall_cpu_block=0
rcutorture.stall_no_softlockup=1" -d

The rcu_torture_stall() function ran on CPU 1, which displays the "D"
as expected given the rcutorture.stall_cpu_irqsoff=1 module parameter:

............
rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks:
{ 1-...D } 26467 jiffies s: 13317 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug): l=1:0-1:0x2/.
Task dump for CPU 1:
task:rcu_torture_sta state:R  running task     stack:    0 pid:   76  ppid:     2 flags:0x00004008

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 4c7037b507032..f092c7f18a5f3 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -637,10 +637,11 @@ static void synchronize_rcu_expedited_wait(void)
 					continue;
 				ndetected++;
 				rdp = per_cpu_ptr(&rcu_data, cpu);
-				pr_cont(" %d-%c%c%c", cpu,
+				pr_cont(" %d-%c%c%c%c", cpu,
 					"O."[!!cpu_online(cpu)],
 					"o."[!!(rdp->grpmask & rnp->expmaskinit)],
-					"N."[!!(rdp->grpmask & rnp->expmaskinitnext)]);
+					"N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
+					"D."[!!(rdp->cpu_no_qs.b.exp)]);
 			}
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
-- 
2.31.1.189.g2e36527f23

