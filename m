Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F94AA39D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355252AbiBDWzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:55:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51522 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355156AbiBDWzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:55:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC5DB61AE3;
        Fri,  4 Feb 2022 22:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1E2C004E1;
        Fri,  4 Feb 2022 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644015309;
        bh=9dVTciEfhGptcn3wHTdf5MGi0l2fBamxpAPctlU28m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jg5LmfB9vKPgT9F4sry4V3UojfJsUFlVavHImbPoT8kVvfzencBqKK92T9XSSKi1i
         fZvs5q8fMtiSUzwquxLE1//pzIQtGMBKIUYGjxbcMAq6tnlFVWC2fI8b3qkKBd7OYh
         c5LWh5Uv3iV6d7MYZm14tdaaz1xqaTpyzJAjuEF/GXvuyMTGbjz+vO5TaPXAwWXZB4
         B7rZAUaAiPt/LRn6jT71YhJFu+wvT74ml2ri/huqdjqDGaCF9cH5fw3a4VIoxTlGtS
         os1HAdJyBZDDYCXFFHzTz0kdzKV/pfw4Ax57O1GeslqnRhjlJEIwuuhQDaKrCh0daq
         iXDf10VKCgDtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0CC845C0418; Fri,  4 Feb 2022 14:55:09 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/3] rcu/exp: Fix check for idle context in rcu_exp_handler
Date:   Fri,  4 Feb 2022 14:55:05 -0800
Message-Id: <20220204225507.4193113-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204225409.GA4193020@paulmck-ThinkPad-P17-Gen-1>
References: <20220204225409.GA4193020@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neeraj Upadhyay <quic_neeraju@quicinc.com>

For PREEMPT_RCU, the rcu_exp_handler() function checks
whether the current CPU is in idle, by calling
rcu_dynticks_curr_cpu_in_eqs(). However, rcu_exp_handler()
is called in IPI handler context. So, it should be checking
the idle context using rcu_is_cpu_rrupt_from_idle(). Fix this
by using rcu_is_cpu_rrupt_from_idle() instead of
rcu_dynticks_curr_cpu_in_eqs(). Non-preempt configuration
already uses the correct check.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 237a79989abae..1568c8ef185b2 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -656,7 +656,7 @@ static void rcu_exp_handler(void *unused)
 	 */
 	if (!depth) {
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
-		    rcu_dynticks_curr_cpu_in_eqs()) {
+		    rcu_is_cpu_rrupt_from_idle()) {
 			rcu_report_exp_rdp(rdp);
 		} else {
 			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
-- 
2.31.1.189.g2e36527f23

