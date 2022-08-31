Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF12E5A8565
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiHaSVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiHaSVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:21:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D72FCA2C;
        Wed, 31 Aug 2022 11:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5EFBB82275;
        Wed, 31 Aug 2022 18:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907C9C433D6;
        Wed, 31 Aug 2022 18:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969758;
        bh=cOpJs5hW2vyuuvdpJqbaSWv/BpYUcc3a3SIz66ot+sU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHeSUc5vrkyZmaZXYyfv5gghetqxmCZI/3IV1j0ZgBBTh+j6LPsKoeZoaKqAwjCKk
         V3KhZRCjMRZMZ4YRZUb9vI4C2/4L5cUxiBuAoChoK2OYrVmz9mg4SjggSS8Y2XVQNU
         vfZ17DeFZvHCpH14OC2wpWtxWIMaPhE0HpMM/AyIuhmnRZ7n4LIQz5w1gTOk8lNf3A
         KLZddC+nwZZgjzru+1H04rh5pYpES24Ym1qGWKsBvoy/uIv9OK3v3yNMb4miHqrUzn
         b5YbZMVmdn8v12eKgypv4haIsYoDzbrEvLFH54T9pchyo4x51smSh6OObiPx2NvjKM
         CgJckhCxcy6aQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 533045C019C; Wed, 31 Aug 2022 11:15:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/3] rcu-tasks: Ensure RCU Tasks Trace loops have quiescent states
Date:   Wed, 31 Aug 2022 11:15:55 -0700
Message-Id: <20220831181556.2696404-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181553.GA2696186@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181553.GA2696186@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCU Tasks Trace grace-period kthread loops across all CPUs, and
there can be quite a few CPUs, with some commercially available systems
sporting well over a thousand of them.  Some of these loops can feature
IPIs, which can take some time.  This commit therefore places a call to
cond_resched_tasks_rcu_qs() in each such loop.

Link: https://docs.google.com/document/d/1V0YnG1HTWMt9WHJjroiJL9lf-hMrud4v8Fn3fhyY0cI/edit?usp=sharing
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 469bf2a3b505e..f5bf6fb430dab 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1500,6 +1500,7 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 		if (rcu_tasks_trace_pertask_prep(t, true))
 			trc_add_holdout(t, hop);
 		rcu_read_unlock();
+		cond_resched_tasks_rcu_qs();
 	}
 
 	// Only after all running tasks have been accounted for is it
@@ -1520,6 +1521,7 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 			raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 		}
 		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+		cond_resched_tasks_rcu_qs();
 	}
 
 	// Re-enable CPU hotplug now that the holdout list is populated.
@@ -1619,6 +1621,7 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 			trc_del_holdout(t);
 		else if (needreport)
 			show_stalled_task_trace(t, firstreport);
+		cond_resched_tasks_rcu_qs();
 	}
 
 	// Re-enable CPU hotplug now that the holdout list scan has completed.
-- 
2.31.1.189.g2e36527f23

