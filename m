Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBDC4720F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhLMGKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:10:33 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:31099 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229866AbhLMGKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639375832; x=1670911832;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=IXd3JhSGDhc5QndANZs2NvNZOFVCvIjyJBd1zc9vP3s=;
  b=grYytRsLPWiMrs4Yf4yKmYNSqXW8JLVyCM2HZ0Uu5/oAOOJsGCLONoC0
   WptKRYFNd3wQlA6x36sTJbnowJz70vTz81fHhCnoAf9/WvUb/0TjEFVog
   eiJ45p4hAIUwUeATLyaOsexFuncZoagfQf7Rs9yLH5nP7hap0lFgoK/S0
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Dec 2021 22:10:32 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 22:10:30 -0800
Received: from localhost (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 12 Dec
 2021 22:10:29 -0800
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
To:     <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <urezki@gmail.com>, <frederic@kernel.org>, <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH] rcu/exp: Fix check for idle context in rcu_exp_handler
Date:   Mon, 13 Dec 2021 11:40:24 +0530
Message-ID: <20211213061024.24285-1-quic_neeraju@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PREEMPT_RCU, the rcu_exp_handler() function checks
whether the current CPU is in idle, by calling
rcu_dynticks_curr_cpu_in_eqs(). However, rcu_exp_handler()
is called in IPI handler context. So, it should be checking
the idle context using rcu_is_cpu_rrupt_from_idle(). Fix this
by using rcu_is_cpu_rrupt_from_idle() instead of
rcu_dynticks_curr_cpu_in_eqs(). Non-preempt configuration
already uses the correct check.

Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 237a79989aba..1568c8ef185b 100644
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
2.17.1

