Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF95890EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiHCRD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiHCRDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:03:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2A4E862;
        Wed,  3 Aug 2022 10:03:20 -0700 (PDT)
Date:   Wed, 03 Aug 2022 17:03:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659546198;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXSabjNJjRfwC9JFIBmyear8cE5dLFtL3ysvEWzyh9Q=;
        b=nob9bSrJp280n42Pa4q1E0LgcMknzroqzp9bmlED1L+iUbDeuRhVy6UQ/B0j3HYDBnxtxK
        Pm6D1Hkj31rMuvZDxNYKYpL9zQB5Mw3IJOUp471H94LHCBtuz9chJtEO2r0gfC/tGyqsJ6
        hLq53NBUs4nhLn4Xsf1pvdiyZ4omyOvx91RWlMTHWTnCiI5fh56swa6fluE7mlbsoOkMiX
        qh1xtBF8iD5vJGpiu0jCotlKuJIqi0UYJudRN5TV/amFFxVvzIZxxej15zwmKwpaLlGmc6
        jrwzRjFkZqRnN+1WQpU8WFsWert2Q2O79Er/YUDdbBLJUZ5lXxgVhRkil2zulA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659546198;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXSabjNJjRfwC9JFIBmyear8cE5dLFtL3ysvEWzyh9Q=;
        b=N4ZbaufxcQl9SRixIVhsnSYeyD8Tntjjo6gDIEwCxbWwkByzQ8JMj4dyY4iFOqXHpuH0FV
        SVkmho5ziaBbBIAQ==
From:   "tip-bot2 for Hao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove unused parameter idle of
 _nohz_idle_balance()
Cc:     Hao Jia <jiahao.os@bytedance.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220803130223.70419-1-jiahao.os@bytedance.com>
References: <20220803130223.70419-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Message-ID: <165954619718.15455.1084400841351133182.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d985ee9f449aafe45397ae1cf8887e9ac91d2f95
Gitweb:        https://git.kernel.org/tip/d985ee9f449aafe45397ae1cf8887e9ac91d2f95
Author:        Hao Jia <jiahao.os@bytedance.com>
AuthorDate:    Wed, 03 Aug 2022 21:02:23 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Aug 2022 18:54:26 +02:00

sched/fair: Remove unused parameter idle of _nohz_idle_balance()

After commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu loop of ILB"),
_nohz_idle_balance()'s 'idle' parameter is not used anymore, so we can remove it.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220803130223.70419-1-jiahao.os@bytedance.com
---
 kernel/sched/fair.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41486d9..d22c5e8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10916,8 +10916,7 @@ static bool update_nohz_stats(struct rq *rq)
  * can be a simple update of blocked load or a complete load balance with
  * tasks movement depending of flags.
  */
-static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
-			       enum cpu_idle_type idle)
+static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 {
 	/* Earliest time when we have to do rebalance again */
 	unsigned long now = jiffies;
@@ -11032,7 +11031,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	if (idle != CPU_IDLE)
 		return false;
 
-	_nohz_idle_balance(this_rq, flags, idle);
+	_nohz_idle_balance(this_rq, flags);
 
 	return true;
 }
@@ -11052,7 +11051,7 @@ void nohz_run_idle_balance(int cpu)
 	 * (ie NOHZ_STATS_KICK set) and will do the same.
 	 */
 	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
-		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
+		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
 }
 
 static void nohz_newidle_balance(struct rq *this_rq)
