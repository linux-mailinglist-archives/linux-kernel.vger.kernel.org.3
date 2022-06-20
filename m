Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D029355274A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbiFTWzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344292AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16121EAD7;
        Mon, 20 Jun 2022 15:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E14061475;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36095C341F7;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=weu7N7rP4kpU8s6MhLCuwoG5dY9tPLSUC7e5cLOyDoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUQaNwfyYpdq7A0AhPgV0Kuyq+Nb44akj/EOOSThsfzR/5eD/QfsF40VtMh3MYPmm
         QPP83zdrgT4kKeWWc4mY21ZZxQFwCc/mAnWEWuU89HwUoqj1xD2qf2MnhJLjI99nBj
         l/anCUF55MVaLnAtA5oR2YvHnYU+tOny3WZ0eIQCiQNqWgoOAjC/Gu1FxE/BsE9vdG
         ASDHHYCU67TIfw0zkFAbvJiKF0ptUBvNtac5K0EO+tMV4G8l/27wRYQ7kzR/vfHH3i
         5vdK7st8ypuGwxJIMzMkmtpXAbRkuD4TuAAP3EOy1R0oVOnuxPPQIxro/XnVn0hlYN
         wvEQdDikT/7tA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5FB1C5C16BC; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 29/32] rcu-tasks: Disable and enable CPU hotplug in same function
Date:   Mon, 20 Jun 2022 15:54:08 -0700
Message-Id: <20220620225411.3842519-29-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
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

The rcu_tasks_trace_pregp_step() function invokes cpus_read_lock() to
disable CPU hotplug, and a later call to the rcu_tasks_trace_postscan()
function invokes cpus_read_unlock() to re-enable it.  This was absolutely
necessary in the past in order to protect the intervening scan of the full
tasks list, but there is no longer such a scan.  This commit therefore
improves readability by moving the cpus_read_unlock() call to the end
of the rcu_tasks_trace_pregp_step() function.  This commit is a pure
code-motion commit without any (intended) change in functionality.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index c2aae2643a0b2..bf9cc5bc4ae52 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1525,6 +1525,9 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 		}
 		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	}
+
+	// Re-enable CPU hotplug now that the holdout list is populated.
+	cpus_read_unlock();
 }
 
 /*
@@ -1532,9 +1535,6 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
  */
 static void rcu_tasks_trace_postscan(struct list_head *hop)
 {
-	// Re-enable CPU hotplug now that the tasklist scan has completed.
-	cpus_read_unlock();
-
 	// Wait for late-stage exiting tasks to finish exiting.
 	// These might have passed the call to exit_tasks_rcu_finish().
 	synchronize_rcu();
-- 
2.31.1.189.g2e36527f23

