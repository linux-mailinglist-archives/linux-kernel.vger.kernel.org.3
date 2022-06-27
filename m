Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE06455D3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiF0Nyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbiF0Nyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:54:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E67F643B;
        Mon, 27 Jun 2022 06:54:31 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RDDPbX030325;
        Mon, 27 Jun 2022 13:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZoX2KeeTTIfhJtt8SK3et9fRdjFWHZxAUxNccobhCQg=;
 b=HmGz0Hub0+afYO6CFlQ/9C7M7pH/thvC9PkBnU6/1gzR3DMjB1MCd47GBjsbJ0imKbex
 HI4jqeULoRe3jNKBT1IwA7gCehEdOJYPdztUuysJ8uVNSJDo2ePga4k7AAZ7NbiXivOC
 9gYdyrH7oAEqIMP0y1WRPzU/TXKjF5+dS8/Sn2IrK8rrddloZYCZOIPfoa5f9EfkqPhk
 y4LVidvX9KgOPoulljUhxdjkZmHypx3UIEJ9dUZwXFTZiikF3e+MhsDFRCZ4TueFEGeL
 3VE8E52LRWSbuuj8e55GZ0x9ciPnYZWBDAQ0+1LeDUM6zwKhUz2Itt5d3LBRBAVpywzl nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gyd89h61u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 13:53:55 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25RDHAXu015356;
        Mon, 27 Jun 2022 13:53:55 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gyd89h61a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 13:53:55 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25RDqYbd030164;
        Mon, 27 Jun 2022 13:53:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3gwt092aem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 13:53:53 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25RDrojS21496136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 13:53:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 103DFAE045;
        Mon, 27 Jun 2022 13:53:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D6A7AE053;
        Mon, 27 Jun 2022 13:53:49 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jun 2022 13:53:49 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, nathanl@linux.ibm.com,
        haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v3 3/4] powerpc/watchdog: introduce a NMI watchdog's factor
Date:   Mon, 27 Jun 2022 15:53:46 +0200
Message-Id: <20220627135347.32624-4-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627135347.32624-1-ldufour@linux.ibm.com>
References: <20220627135347.32624-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sQ5Cqp20Zfj5nFrveBXjq4PbGHHVMD9g
X-Proofpoint-GUID: B-FpR0e-5RjdwG9oRQjvsPe2svmvL4qD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206270059
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
 arch/powerpc/kernel/watchdog.c | 21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index ea0e487f87b1..7d6a8d9b0543 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -5,8 +5,10 @@
 #ifdef CONFIG_PPC_WATCHDOG
 extern void arch_touch_nmi_watchdog(void);
 long soft_nmi_interrupt(struct pt_regs *regs);
+void watchdog_nmi_set_lpm_factor(u64 factor);
 #else
 static inline void arch_touch_nmi_watchdog(void) {}
+static inline void watchdog_nmi_set_lpm_factor(u64 factor) {}
 #endif
 
 #ifdef CONFIG_NMI_IPI
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 7d28b9553654..80851b228f71 100644
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
+	threshold += (READ_ONCE(wd_factor) * threshold) / 100;
+#endif
+
+	wd_panic_timeout_tb = threshold * ppc_tb_freq;
 
 	/* Have the SMP detector trigger a bit later */
 	wd_smp_panic_timeout_tb = wd_panic_timeout_tb * 3 / 2;
@@ -570,3 +580,12 @@ int __init watchdog_nmi_probe(void)
 	}
 	return 0;
 }
+
+#ifdef CONFIG_PPC_PSERIES
+void watchdog_nmi_set_lpm_factor(u64 factor)
+{
+	pr_info("Set the NMI watchdog factor to %llu%%\n", factor);
+	WRITE_ONCE(wd_factor, factor);
+	lockup_detector_reconfigure();
+}
+#endif
-- 
2.36.1

