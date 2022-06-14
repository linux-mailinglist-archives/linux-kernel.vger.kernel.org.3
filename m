Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542C854B295
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbiFNNyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243512AbiFNNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:54:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6769E39158
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:54:44 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EDBkBM013079;
        Tue, 14 Jun 2022 13:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kArqREhk73Ut+1z9jJrMlqAJP/wYWCHnReUpSy3ttMM=;
 b=btYY/QasVVLCi3WGPqq3f/1pjENLtubGh8Mkcb2SXHo6+jMV6CxI4LNUmHUH207re0AU
 MPSBpMdoxBRGj/9tkjxLSBmkHj+x1IGTX0evgpbQ+/BcXi751gg9gp1pjAX8e0ZbpRYl
 GW9n6ZkPHXqQ6tl7XurTtgRXy4VvRxft4K3taotOOYsWiO+wBjACdYU4GDF1whE+2s7I
 /80ROXg33hi/w1eTLlNv774X+sIgpvrjkNufs9ZTqX1N4C/kd/v57gXKMHwhP4NoVQvA
 K+4/AqSUb10TvUrnR3Llws63yScJ8OvMrKstWsPk4jXluJL+iuHPfznJj/20PEWPI+zM XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpqmvqjxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 13:54:24 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25EDC3jP014467;
        Tue, 14 Jun 2022 13:54:23 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpqmvqjsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 13:54:23 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25EDpP1w007434;
        Tue, 14 Jun 2022 13:54:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3gmjp94djy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 13:54:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25EDsIqp17826262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 13:54:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ED30AE04D;
        Tue, 14 Jun 2022 13:54:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1B80AE045;
        Tue, 14 Jun 2022 13:54:17 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jun 2022 13:54:17 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nathanl@linux.ibm.com, haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] powerpc/watchdog: introduce a LPM factor
Date:   Tue, 14 Jun 2022 15:54:13 +0200
Message-Id: <20220614135414.37746-4-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614135414.37746-1-ldufour@linux.ibm.com>
References: <20220614135414.37746-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TCN9lrw68MFZYP-QQZMJguTgAyt_kkH5
X-Proofpoint-ORIG-GUID: ui_vx9lyrZ4cdNnhCE_T2KIBiGStUONh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_04,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a factor which would apply to the NMI watchdog timeout.

This factor is a percentage added to the watchdog_tresh value. The value is
set under the watchdog_mutex protection and lockup_detector_reconfigure()
is called to recompute wd_panic_timeout_tb.

Once the factor is set, it remains until it is set back to 0, which means
no impact.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/include/asm/nmi.h |  2 ++
 arch/powerpc/kernel/watchdog.c | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index ea0e487f87b1..4eb894ef12a3 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -5,8 +5,10 @@
 #ifdef CONFIG_PPC_WATCHDOG
 extern void arch_touch_nmi_watchdog(void);
 long soft_nmi_interrupt(struct pt_regs *regs);
+void watchdog_nmi_set_lpm_factor(u64 factor);
 #else
 static inline void arch_touch_nmi_watchdog(void) {}
+static void watchdog_nmi_set_lpm_factor(u64 factor) {}
 #endif
 
 #ifdef CONFIG_NMI_IPI
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 7d28b9553654..faaf5ba14d69 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -91,6 +91,10 @@ static cpumask_t wd_smp_cpus_pending;
 static cpumask_t wd_smp_cpus_stuck;
 static u64 wd_smp_last_reset_tb;
 
+#ifdef CONFIG_PPC_PSERIES
+static u64 wd_factor;
+#endif
+
 /*
  * Try to take the exclusive watchdog action / NMI IPI / printing lock.
  * wd_smp_lock must be held. If this fails, we should return and wait
@@ -527,7 +531,13 @@ static int stop_watchdog_on_cpu(unsigned int cpu)
 
 static void watchdog_calc_timeouts(void)
 {
-	wd_panic_timeout_tb = watchdog_thresh * ppc_tb_freq;
+	u64 threshold = watchdog_thresh;
+
+#ifdef CONFIG_PPC_PSERIES
+	threshold += (wd_factor * threshold) / 100;
+#endif
+
+	wd_panic_timeout_tb = threshold * ppc_tb_freq;
 
 	/* Have the SMP detector trigger a bit later */
 	wd_smp_panic_timeout_tb = wd_panic_timeout_tb * 3 / 2;
@@ -570,3 +580,13 @@ int __init watchdog_nmi_probe(void)
 	}
 	return 0;
 }
+
+#ifdef CONFIG_PPC_PSERIES
+void watchdog_nmi_set_lpm_factor(u64 factor)
+{
+	mutex_lock(&watchdog_mutex);
+	wd_factor = factor;
+	lockup_detector_reconfigure();
+	mutex_unlock(&watchdog_mutex);
+}
+#endif
-- 
2.36.1

