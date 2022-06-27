Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFED55C2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiF0Nyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbiF0Nyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:54:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD5EA1AF;
        Mon, 27 Jun 2022 06:54:30 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RDhNtm004842;
        Mon, 27 Jun 2022 13:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aL2N43eAIRSKLPFSUp+oRPJIvcuNlMiwt1RDl0sYTXo=;
 b=Ggj9KE0jNcmHTa2ZF72h277oOMgpFE3V1OWtz4ltEA5wS0I504Jk/69GG+dVJiFO+U2O
 W+GnO3QEYZmMMqBnA88mZVnIWz9a9IgLF/9gog1snMWzxEnq4YPScfZBHAdnMzXuT2DF
 tI8WTgkqhC5C3kk1zoxk+q902CIYVifnSDvz+0gPp1kERRpBsK9rzkW4cLAzFULFndIU
 4nKWzi59gXa67drdx0NGieoTxZitBK6itboAFPVn8fwqjnjacV4h5de14UUqZDOJC217
 Cv3K31L2+zhQvNTRSkqi6Fn1AUQloB9z6lByI57e4A7tLBqlugH7OA2MvESe2c6M6UJJ KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gydpa08v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 13:53:55 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25RDl5eP022588;
        Mon, 27 Jun 2022 13:53:54 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gydpa08ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 13:53:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25RDocEO004786;
        Mon, 27 Jun 2022 13:53:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3gwt08u13u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 13:53:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25RDrn2717236380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 13:53:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BAF7AE04D;
        Mon, 27 Jun 2022 13:53:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFB13AE045;
        Mon, 27 Jun 2022 13:53:48 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jun 2022 13:53:48 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, nathanl@linux.ibm.com,
        haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 2/4] watchdog: export lockup_detector_reconfigure
Date:   Mon, 27 Jun 2022 15:53:45 +0200
Message-Id: <20220627135347.32624-3-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627135347.32624-1-ldufour@linux.ibm.com>
References: <20220627135347.32624-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 51LUuHDzlmcy6sYwoMkXpQqQa62TEkAJ
X-Proofpoint-GUID: R2lfIlRFJ8DeQzPd45U8IyAo1jb5DcfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
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

In some circumstances it may be interesting to reconfigure the watchdog
from inside the kernel.

On PowerPC, this may helpful before and after a LPAR migration (LPM) is
initiated, because it implies some latencies, watchdog, and especially NMI
watchdog is expected to be triggered during this operation. Reconfiguring
the watchdog with a factor, would prevent it to happen too frequently
during LPM.

Rename lockup_detector_reconfigure() as __lockup_detector_reconfigure() and
create a new function lockup_detector_reconfigure() calling
__lockup_detector_reconfigure() under the protection of watchdog_mutex.

Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 include/linux/nmi.h |  2 ++
 kernel/watchdog.c   | 21 ++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 750c7f395ca9..f700ff2df074 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -122,6 +122,8 @@ int watchdog_nmi_probe(void);
 int watchdog_nmi_enable(unsigned int cpu);
 void watchdog_nmi_disable(unsigned int cpu);
 
+void lockup_detector_reconfigure(void);
+
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
  *
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 20a7a55e62b6..90e6c41d5e33 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -541,7 +541,7 @@ int lockup_detector_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void lockup_detector_reconfigure(void)
+static void __lockup_detector_reconfigure(void)
 {
 	cpus_read_lock();
 	watchdog_nmi_stop();
@@ -561,6 +561,13 @@ static void lockup_detector_reconfigure(void)
 	__lockup_detector_cleanup();
 }
 
+void lockup_detector_reconfigure(void)
+{
+	mutex_lock(&watchdog_mutex);
+	__lockup_detector_reconfigure();
+	mutex_unlock(&watchdog_mutex);
+}
+
 /*
  * Create the watchdog infrastructure and configure the detector(s).
  */
@@ -577,13 +584,13 @@ static __init void lockup_detector_setup(void)
 		return;
 
 	mutex_lock(&watchdog_mutex);
-	lockup_detector_reconfigure();
+	__lockup_detector_reconfigure();
 	softlockup_initialized = true;
 	mutex_unlock(&watchdog_mutex);
 }
 
 #else /* CONFIG_SOFTLOCKUP_DETECTOR */
-static void lockup_detector_reconfigure(void)
+void __lockup_detector_reconfigure(void)
 {
 	cpus_read_lock();
 	watchdog_nmi_stop();
@@ -591,9 +598,13 @@ static void lockup_detector_reconfigure(void)
 	watchdog_nmi_start();
 	cpus_read_unlock();
 }
+static inline void lockup_detector_reconfigure(void)
+{
+	__lockup_detector_reconfigure();
+}
 static inline void lockup_detector_setup(void)
 {
-	lockup_detector_reconfigure();
+	__lockup_detector_reconfigure();
 }
 #endif /* !CONFIG_SOFTLOCKUP_DETECTOR */
 
@@ -633,7 +644,7 @@ static void proc_watchdog_update(void)
 {
 	/* Remove impossible cpus to keep sysctl output clean. */
 	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, cpu_possible_mask);
-	lockup_detector_reconfigure();
+	__lockup_detector_reconfigure();
 }
 
 /*
-- 
2.36.1

