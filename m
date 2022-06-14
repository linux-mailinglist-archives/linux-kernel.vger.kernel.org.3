Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBBD54B296
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbiFNNzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243942AbiFNNys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:54:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D4393E6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:54:46 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EDBGei017572;
        Tue, 14 Jun 2022 13:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rqaTk/7JxQpwq10EJN3XIZVAWqQV9tjCYBn+r9nRLq4=;
 b=fhdnscZ8BMcZug2VLR38k0eTunIGG9s/YUVKI/lN2jUDOT2qIX+fSpR0Kls+fMR44yAz
 n+kjyQfJ97lK/ix5sp2rXx1nv4gW0f4CUSyhEGSck7vJpbgLJ6DfwmULYfyAyAJ7X4G3
 EXd9CXk6QLJO4opnNe3CGbkubT6Ks2UsMyGrndCBfX7akDZHwks2/cJysaoRUORXkN1M
 MljrOUYyiYyOoBu25CELhoh0Fev7ODzBEw+YrIrehSAOeRn0leP6nsKRTWID+XmoANen
 DRiwb4Jtkbcplwbiw0+Dd2v57+1/juKFjhmI/C9AGw/4zH5aDsmS7ZGKZeYjm3U6rYs2 +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpq770fjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 13:54:25 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25EDBMM0018504;
        Tue, 14 Jun 2022 13:54:24 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpq770fc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 13:54:24 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25EDqOmn026275;
        Tue, 14 Jun 2022 13:54:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3gmjp93e9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 13:54:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25EDsIQp21823860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 13:54:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E934AE04D;
        Tue, 14 Jun 2022 13:54:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E5CEAE045;
        Tue, 14 Jun 2022 13:54:18 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jun 2022 13:54:18 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nathanl@linux.ibm.com, haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] pseries/mobility: Set NMI watchdog factor during LPM
Date:   Tue, 14 Jun 2022 15:54:14 +0200
Message-Id: <20220614135414.37746-5-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614135414.37746-1-ldufour@linux.ibm.com>
References: <20220614135414.37746-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D7arwWxqTjrYkx2zhH4tsXljxcCIUqN4
X-Proofpoint-GUID: HgHok-0-eqnYy9wBFOmqWNjH8GvTLPOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_04,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206140054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a LPM, while the memory transfer is in progress on the arrival side,
some latencies is generated when accessing not yet transferred pages on the
arrival side. Thus, the NMI watchdog may be triggered too frequently, which
increases the risk to hit a NMI interrupt in a bad place in the kernel,
leading to a kernel panic.

Disabling the Hard Lockup Watchdog until the memory transfer could be a too
strong work around, some users would want this timeout to be eventually
triggered if the system is hanging even during LPM.

Introduce a new sysctl variable lpm_nmi_watchdog_factor. It allows to apply
a factor to the NMI watchdog timeout during a LPM. Just before the CPU are
stopped for the switchover sequence, the NMI watchdog timer is set to
 watchdog_tresh + factor%

A value of 0 has no effect. The default value is 200, meaning that the NMI
watchdog is set to 30s during LPM (based on a 10s watchdog_tresh value).
Once the memory transfer is achieved, the factor is reset to 0.

Setting this value to a high number is like disabling the NMI watchdog
during a LPM.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 12 ++++++
 arch/powerpc/platforms/pseries/mobility.c   | 48 +++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ddccd1077462..53701ed671de 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -485,6 +485,18 @@ When ``kptr_restrict`` is set to 2, kernel pointers printed using
 %pK will be replaced with 0s regardless of privileges.
 
 
+lpm_nmi_watchdog_factor (PPC only)
+==================================
+
+Factor apply to to the NMI watchdog timeout (only when ``nmi_watchdog`` is
+set to 1). This factor represents the percentage added to
+``watchdog_thresh`` when calculating the NMI watchdog timeout during a
+LPM. The soft lockup timeout is not impacted.
+
+A value of 0 means no change. The default value is 200 meaning the NMI
+watchdog is set to 30s (based on ``watchdog_thresh`` equal to 10).
+
+
 modprobe
 ========
 
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 179bbd4ae881..4284ceaf9060 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -48,6 +48,39 @@ struct update_props_workarea {
 #define MIGRATION_SCOPE	(1)
 #define PRRN_SCOPE -2
 
+#ifdef CONFIG_PPC_WATCHDOG
+static unsigned int lpm_nmi_wd_factor = 200;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table lpm_nmi_wd_factor_ctl_table[] = {
+	{
+		.procname	= "lpm_nmi_watchdog_factor",
+		.data		= &lpm_nmi_wd_factor,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+	},
+	{}
+};
+static struct ctl_table lpm_nmi_wd_factor_sysctl_root[] = {
+	{
+		.procname       = "kernel",
+		.mode           = 0555,
+		.child          = lpm_nmi_wd_factor_ctl_table,
+	},
+	{}
+};
+
+static int __init register_lpm_nmi_wd_factor_sysctl(void)
+{
+	register_sysctl_table(lpm_nmi_wd_factor_sysctl_root);
+
+	return 0;
+}
+device_initcall(register_lpm_nmi_wd_factor_sysctl);
+#endif /* CONFIG_SYSCTL */
+#endif /* CONFIG_PPC_WATCHDOG */
+
 static int mobility_rtas_call(int token, char *buf, s32 scope)
 {
 	int rc;
@@ -702,6 +735,7 @@ static int pseries_suspend(u64 handle)
 static int pseries_migrate_partition(u64 handle)
 {
 	int ret;
+	unsigned int factor = lpm_nmi_wd_factor;
 
 	ret = wait_for_vasi_session_suspending(handle);
 	if (ret)
@@ -709,6 +743,13 @@ static int pseries_migrate_partition(u64 handle)
 
 	vas_migration_handler(VAS_SUSPEND);
 
+#ifdef CONFIG_PPC_WATCHDOG
+	if (factor) {
+		pr_info("Set the NMI watchdog factor to %u%%\n", factor);
+		watchdog_nmi_set_lpm_factor(factor);
+	}
+#endif /* CONFIG_PPC_WATCHDOG */
+
 	ret = pseries_suspend(handle);
 	if (ret == 0) {
 		post_mobility_fixup();
@@ -716,6 +757,13 @@ static int pseries_migrate_partition(u64 handle)
 	} else
 		pseries_cancel_migration(handle, ret);
 
+#ifdef CONFIG_PPC_WATCHDOG
+	if (factor) {
+		pr_info("Restoring NMI watchdog timer\n");
+		watchdog_nmi_set_lpm_factor(0);
+	}
+#endif /* CONFIG_PPC_WATCHDOG */
+
 	vas_migration_handler(VAS_RESUME);
 
 	return ret;
-- 
2.36.1

