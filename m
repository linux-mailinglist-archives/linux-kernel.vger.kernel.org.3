Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3AB54B292
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244909AbiFNNyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243271AbiFNNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:54:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8817C393E3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:54:45 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EDBlGm007090;
        Tue, 14 Jun 2022 13:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mdqeng1MZ6SvkLF1dQ4hAkSq2bHcezRfYJOljLAu0r0=;
 b=gBY40d4EdEZbKP6QQPiGoIOzzs9YHgr53DflXKVCqRwMRvUfyItI1nUwTQdZI4pTb0ZI
 JCSSUVso15qiPAJR34lhfZcO08HOTq/GoAKkEQuiYMNE+Q8InL7NRkK9dwVhocQJx1NC
 4D/oWnJcMuJKR9drwFYvIUazWblFx1z6Rpk8NJe5/u97rtR3kQ/8s8rByqR5lO8PzLAW
 Z7VU45BIY0fXZ0DVTOT3L961u060eFF/sZfHMxATIWFfkCZPEsxrXa051zVUw7MSjoMH
 K588D468OkFp8gAJLaCogXC8wsli1sxkG2vYSvYhib2+vcxEZxFXNbDt6Yszsl54nh1/ iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppbr1kn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 13:54:22 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25EDZ45m008863;
        Tue, 14 Jun 2022 13:54:22 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppbr1kj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 13:54:22 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25EDp3SD024254;
        Tue, 14 Jun 2022 13:54:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3gmjp8uer9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 13:54:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25EDrlC314483732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 13:53:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91D8EAE04D;
        Tue, 14 Jun 2022 13:54:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27C9DAE045;
        Tue, 14 Jun 2022 13:54:17 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jun 2022 13:54:17 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nathanl@linux.ibm.com, haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] watchdog: export watchdog_mutex and lockup_detector_reconfigure
Date:   Tue, 14 Jun 2022 15:54:12 +0200
Message-Id: <20220614135414.37746-3-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614135414.37746-1-ldufour@linux.ibm.com>
References: <20220614135414.37746-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qh2EeZ6fVZ2q05MROgmq4hAdL4D_fSI0
X-Proofpoint-ORIG-GUID: 0g9wm5Gv3lGY_t7E5aLOeEgg91uF0NUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_04,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206140054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cricunstances it may be interesting to reconfigure the watchdog
from inside the kernel.

On PowerPC, this may helpful before and after a LPAR migration (LPM) is
initiated, because it implies some latencies, watchdog, and especially NMI
watchdog is expected to be triggered during this operation. Reconfiguring
the watchdog, would prevent it to happen too frequently during LPM.

The watchdog_mutex is exported to allow some variable to be changed under
its protection and prevent any conflict.
The lockup_detector_reconfigure() function is exported and is expected to
be called under the protection of watchdog_mutex.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 include/linux/nmi.h | 3 +++
 kernel/watchdog.c   | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 750c7f395ca9..84300fb0f90a 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -122,6 +122,9 @@ int watchdog_nmi_probe(void);
 int watchdog_nmi_enable(unsigned int cpu);
 void watchdog_nmi_disable(unsigned int cpu);
 
+extern struct mutex watchdog_mutex;
+void lockup_detector_reconfigure(void);
+
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
  *
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 20a7a55e62b6..0a67a2dd1258 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -27,7 +27,7 @@
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
 
-static DEFINE_MUTEX(watchdog_mutex);
+DEFINE_MUTEX(watchdog_mutex);
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
 # define WATCHDOG_DEFAULT	(SOFT_WATCHDOG_ENABLED | NMI_WATCHDOG_ENABLED)
@@ -541,7 +541,7 @@ int lockup_detector_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void lockup_detector_reconfigure(void)
+void lockup_detector_reconfigure(void)
 {
 	cpus_read_lock();
 	watchdog_nmi_stop();
@@ -583,7 +583,7 @@ static __init void lockup_detector_setup(void)
 }
 
 #else /* CONFIG_SOFTLOCKUP_DETECTOR */
-static void lockup_detector_reconfigure(void)
+void lockup_detector_reconfigure(void)
 {
 	cpus_read_lock();
 	watchdog_nmi_stop();
-- 
2.36.1

