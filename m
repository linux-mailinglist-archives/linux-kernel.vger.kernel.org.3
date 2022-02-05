Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5CC4AA911
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 14:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379952AbiBENOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 08:14:25 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34062 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232557AbiBENOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 08:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644066864; x=1675602864;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=wk8UjLb/k9KFh/i4SHSW5VLjIJda2DIfpQOvTKhJiGY=;
  b=Jyp4Y2GYocWqt/mZPDN/aSGbrbsNriSpaWOuweJm0j9VRT56gXuqDAy6
   n5puh+y+jvc7NSnlKlmG9RnxQJRwZQctpLXwUfySg91scV/vSHeBC6AVI
   5mPtDueUSmT9Y7LQYTnCBx6BHRySb3DlaasMe14x5tCtCtJjqBx1569fZ
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Feb 2022 05:14:24 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 05:14:23 -0800
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sat, 5 Feb 2022 05:14:20 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <tglx@linutronix.de>, <paulmck@kernel.org>,
        <will@kernel.org>, <dave@stgolabs.net>, <frederic@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] softirq: Remove raise_softirq from tasklet_action_common()
Date:   Sat, 5 Feb 2022 18:43:25 +0530
Message-ID: <1644066805-17212-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Think about a scenario when all other cores are in suspend
and one core is only running ksoftirqd and it is because
some client has invoked tasklet_hi_schedule() only once
during that phase.

tasklet_action_common() handles that softirq and marks the
same softirq as pending again. And due to that core keeps
running the softirq handler [1] forever and it is not able to
go to suspend.

We can get rid of raising softirq from tasklet handler.

[1]
<idle>-0    [003]   13058.769081:  softirq_entry   vec=0  action=HI_SOFTIRQ
<idle>-0     [003]  13058.769085: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
<idle>-0    [003]   13058.769087:  softirq_exit   vec=0  action=HI_SOFTIRQ
<idle>-0    [003]   13058.769091:  softirq_entry   vec=0  action=HI_SOFTIRQ
<idle>-0     [003]  13058.769094: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
<idle>-0    [003]   13058.769097:  softirq_exit   vec=0  action=HI_SOFTIRQ
<idle>-0    [003]   13058.769100:  softirq_entry   vec=0  action=HI_SOFTIRQ
<idle>-0     [003]  13058.769103: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
<idle>-0    [003]   13058.769106:  softirq_exit   vec=0  action=HI_SOFTIRQ
<idle>-0    [003]   13058.769109:  softirq_entry   vec=0  action=HI_SOFTIRQ
<idle>-0    [003]   13059.058923:  softirq_entry   vec=0  action=HI_SOFTIRQ
...
..
..
..

<idle>-0    [003]   13059.058951:  softirq_entry   vec=0  action=HI_SOFTIRQ
<idle>-0     [003]  13059.058954: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
<idle>-0    [003]   13059.058957:  softirq_exit   vec=0  action=HI_SOFTIRQ
<idle>-0    [003]   13059.058960:  softirq_entry   vec=0  action=HI_SOFTIRQ
<idle>-0     [003]  13059.058963: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
<idle>-0    [003]   13059.058966:  softirq_exit   vec=0  action=HI_SOFTIRQ
<idle>-0    [003]   13059.058969:  softirq_entry   vec=0  action=HI_SOFTIRQ
<idle>-0     [003]  13059.058972: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
<idle>-0    [003]   13059.058975:  softirq_exit   vec=0  action=HI_SOFTIRQ
<idle>-0    [003]   13059.058978:  softirq_entry   vec=0  action=HI_SOFTIRQ
<idle>-0     [003]  13059.058981: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
<idle>-0    [003]   13059.058984:  softirq_exit   vec=0  action=HI_SOFTIRQ
<idle>-0    [003]   13059.058987:  softirq_entry   vec=0  action=HI_SOFTIRQ
<idle>-0     [003]  13059.058990: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
<idle>-0    [003]   13059.058993:  softirq_exit   vec=0  action=HI_SOFTIRQ
<idle>-0    [003]   13059.058996:  softirq_entry   vec=0  action=HI_SOFTIRQ
<idle>-0     [003]  13059.059000: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
<idle>-0    [003]   13059.059002:  softirq_exit   vec=0  action=HI_SOFTIRQ

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 kernel/softirq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 41f4709..d3e6fb9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -795,7 +795,6 @@ static void tasklet_action_common(struct softirq_action *a,
 		t->next = NULL;
 		*tl_head->tail = t;
 		tl_head->tail = &t->next;
-		__raise_softirq_irqoff(softirq_nr);
 		local_irq_enable();
 	}
 }
-- 
2.7.4

