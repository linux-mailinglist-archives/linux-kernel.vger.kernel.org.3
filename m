Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB6C505FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiDRW53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiDRW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86562D1CA;
        Mon, 18 Apr 2022 15:54:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC07CB81147;
        Mon, 18 Apr 2022 22:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A7AC385B8;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322441;
        bh=hgEd3cpLsRyZZOBZzaKl/DvFtkkxfVr47Q/gsMtP94Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIwQHmfCQMiJX9gTWhnRiYrGeGRiAjSnmKfKNwTX3T8czHIPfXHr20hQj4H4RIV3Z
         5+ikJZSPNMdE0p+FEq9BR/D+Dn8IsDp5na/wlQAWlR+R4StiOrff1O+nkjBVxTFqNl
         M42Ap8B38iWEo2feWC8XVIFDcliBrq/tMK2AuVYPwfTdhboYt0/on7ejp6W6yHg4NW
         YIzNXuPfYq/16AgqG5nCLTIhI3J+nOCMj7tcLwLLDMc1yVr0XnrEtSlERZlHTsQBhI
         8EZHd7b0BDx7d6DrGd6HTNBpxtcsHdE2bKDYpFvObzSReN88mfq8excuSUkZ5DzHtc
         rxLMARwgOE+YQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F20BD5C1355; Mon, 18 Apr 2022 15:54:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/11] rcu: Use IRQ_WORK_INIT_HARD() to avoid rcu_read_unlock() hangs
Date:   Mon, 18 Apr 2022 15:53:59 -0700
Message-Id: <20220418225359.3945217-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
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

When booting kernels built with both CONFIG_RCU_STRICT_GRACE_PERIOD=y
and CONFIG_PREEMPT_RT=y, the rcu_read_unlock_special() function's
invocation of irq_work_queue_on() the init_irq_work() causes the
rcu_preempt_deferred_qs_handler() function to work execute in SCHED_FIFO
irq_work kthreads.  Because rcu_read_unlock_special() is invoked on each
rcu_read_unlock() in such kernels, the amount of work just keeps piling
up, resulting in a boot-time hang.

This commit therefore avoids this hang by using IRQ_WORK_INIT_HARD()
instead of init_irq_work(), but only in kernels built with both
CONFIG_PREEMPT_RT=y and CONFIG_RCU_STRICT_GRACE_PERIOD=y.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5c23aceecd62..2a3715419073 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -661,7 +661,13 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
+				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
+				    IS_ENABLED(CONFIG_PREEMPT_RT))
+					rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(
+								rcu_preempt_deferred_qs_handler);
+				else
+					init_irq_work(&rdp->defer_qs_iw,
+						      rcu_preempt_deferred_qs_handler);
 				rdp->defer_qs_iw_pending = true;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
-- 
2.31.1.189.g2e36527f23

