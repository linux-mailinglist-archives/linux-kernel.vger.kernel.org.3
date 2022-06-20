Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F083552738
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345317AbiFTWyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242451AbiFTWyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1824318B15;
        Mon, 20 Jun 2022 15:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9AE0B8164A;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672EEC385A5;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=ToJk+sLLqOfG4GHDaC0eRSDzktQ3ZFTWzONjt6nK0KI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=peYZksBc9a5So6vThQhMB4lXHtu16RjlJRyPDmlXeLLBNIR/0aPHig03gBbYIAJoA
         0YPphguW5AzIonll26e2p+XA0WqoVulrnvsWRAjcdjecrOgJHqSQLyf8v6iYqCEy4Y
         XB1AEep9vrN12O+5psk+1ibh00Cohi3V1hIDaFKDmhzQoOsQsFFKrnTNfvDM0zsBb8
         TsYwsrf8RxA+V+7dCSB+icU+4ZCtcuathHLNF1U2BR9RSV3/k/r5el4cORUce4XGF8
         A4XSxsR17BnkH09gznjGjGac1qoeSBZb4sb8XKjH6WbYjyZdL/tbug/B+w9vYOF9cx
         Q9RdfzhQSgHWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 272265C05B9; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/32] rcu-tasks: Check for abandoned callbacks
Date:   Mon, 20 Jun 2022 15:53:40 -0700
Message-Id: <20220620225411.3842519-1-paulmck@kernel.org>
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

This commit adds a debugging scan for callbacks that got lost during a
callback-queueing transition.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 3925e32159b5a..b8690a412c5bf 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -439,6 +439,11 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			WRITE_ONCE(rtp->percpu_dequeue_lim, 1);
 			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
 		}
+		for (cpu = rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
+			struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
+
+			WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
+		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
 
-- 
2.31.1.189.g2e36527f23

