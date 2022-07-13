Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F15E573A78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiGMPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbiGMPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:48:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779D04F1A5;
        Wed, 13 Jul 2022 08:48:08 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DFiOdo029351;
        Wed, 13 Jul 2022 15:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JtKwEmpnzjtAWixLZG3p75w/fSMVduVmKn+32o3EkJM=;
 b=RVWla6H1ULfV47ZniOsUGQqMubwoTkpj+aJZmX8zkjtEqLrZbRUrp5hIp47X2ojC5K6U
 owgUjiyT9cK0+GDUHcjbIr/zWi0sVVOfe+J/3fBM4nrbAKDtyme6LFJ+pr1Vtpx6xnfF
 q1g6UHDkrop3AgMO/fCBCoVjmm0n5AVuTqVo/U0GdYDtCgH5c7o3zjyHA/Ao3oDRcdk1
 vqcLBbdR+S9Wc00Rrgq/tjtvBewYIkRx6V1UpyTaJzQw1Hz8wI1fWKd1jOOjwWRdPuJB
 pS8ASW4OJzraBe7tZDtxCvoT2qVoidM4G7k/gdorZ4eeI+4wUfOicpyNqQ4wUNKmZeij Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ha0xxr2fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 15:47:38 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26DFjH24031176;
        Wed, 13 Jul 2022 15:47:38 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ha0xxr2ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 15:47:38 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26DFOCsV008894;
        Wed, 13 Jul 2022 15:47:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3h71a8wvgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 15:47:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26DFk1IM23134598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 15:46:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C522AE04D;
        Wed, 13 Jul 2022 15:47:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D8EFAE051;
        Wed, 13 Jul 2022 15:47:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.2.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jul 2022 15:47:32 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        wim@linux-watchdog.org, linux@roeck-us.net, nathanl@linux.ibm.com,
        rdunlap@infradead.org
Cc:     haren@linux.vnet.ibm.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v5 4/4] pseries/mobility: set NMI watchdog factor during an LPM
Date:   Wed, 13 Jul 2022 17:47:29 +0200
Message-Id: <20220713154729.80789-5-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713154729.80789-1-ldufour@linux.ibm.com>
References: <20220713154729.80789-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lUDFZl9W97dLVwAsA3N4FbmcqFn696ut
X-Proofpoint-GUID: 2sMueNNtOCs5vLxNWpibAijQkb12eMh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_05,2022-07-13_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During an LPM, while the memory transfer is in progress on the arrival
side, some latencies are generated when accessing not yet transferred pages
on the arrival side. Thus, the NMI watchdog may be triggered too
frequently, which increases the risk to hit an NMI interrupt in a bad place
in the kernel, leading to a kernel panic.

Disabling the Hard Lockup Watchdog until the memory transfer could be a too
strong work around, some users would want this timeout to be eventually
triggered if the system is hanging even during an LPM.

Introduce a new sysctl variable nmi_watchdog_factor. It allows to apply a
factor to the NMI watchdog timeout during an LPM. Just before the CPUs are
stopped for the switchover sequence, the NMI watchdog timer is set to
watchdog_thresh + factor%

A value of 0 has no effect. The default value is 200, meaning that the NMI
watchdog is set to 30s during LPM (based on a 10s watchdog_thresh value).
Once the memory transfer is achieved, the factor is reset to 0.

Setting this value to a high number is like disabling the NMI watchdog
during an LPM.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 12 ++++++
 arch/powerpc/platforms/pseries/mobility.c   | 43 +++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ddccd1077462..d73faa619c15 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -592,6 +592,18 @@ to the guest kernel command line (see
 Documentation/admin-guide/kernel-parameters.rst).
 
 
+nmi_wd_lpm_factor (PPC only)
+============================
+
+Factor apply to the NMI watchdog timeout (only when ``nmi_watchdog`` is
+set to 1). This factor represents the percentage added to
+``watchdog_thresh`` when calculating the NMI watchdog timeout during an
+LPM. The soft lockup timeout is not impacted.
+
+A value of 0 means no change. The default value is 200 meaning the NMI
+watchdog is set to 30s (based on ``watchdog_thresh`` equal to 10).
+
+
 numa_balancing
 ==============
 
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 6297467072e6..3d36a8955eaf 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -48,6 +48,39 @@ struct update_props_workarea {
 #define MIGRATION_SCOPE	(1)
 #define PRRN_SCOPE -2
 
+#ifdef CONFIG_PPC_WATCHDOG
+static unsigned int nmi_wd_lpm_factor = 200;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table nmi_wd_lpm_factor_ctl_table[] = {
+	{
+		.procname	= "nmi_wd_lpm_factor",
+		.data		= &nmi_wd_lpm_factor,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+	},
+	{}
+};
+static struct ctl_table nmi_wd_lpm_factor_sysctl_root[] = {
+	{
+		.procname       = "kernel",
+		.mode           = 0555,
+		.child          = nmi_wd_lpm_factor_ctl_table,
+	},
+	{}
+};
+
+static int __init register_nmi_wd_lpm_factor_sysctl(void)
+{
+	register_sysctl_table(nmi_wd_lpm_factor_sysctl_root);
+
+	return 0;
+}
+device_initcall(register_nmi_wd_lpm_factor_sysctl);
+#endif /* CONFIG_SYSCTL */
+#endif /* CONFIG_PPC_WATCHDOG */
+
 static int mobility_rtas_call(int token, char *buf, s32 scope)
 {
 	int rc;
@@ -702,13 +735,20 @@ static int pseries_suspend(u64 handle)
 static int pseries_migrate_partition(u64 handle)
 {
 	int ret;
+	unsigned int factor = 0;
 
+#ifdef CONFIG_PPC_WATCHDOG
+	factor = nmi_wd_lpm_factor;
+#endif
 	ret = wait_for_vasi_session_suspending(handle);
 	if (ret)
 		return ret;
 
 	vas_migration_handler(VAS_SUSPEND);
 
+	if (factor)
+		watchdog_nmi_set_timeout_pct(factor);
+
 	ret = pseries_suspend(handle);
 	if (ret == 0) {
 		post_mobility_fixup();
@@ -722,6 +762,9 @@ static int pseries_migrate_partition(u64 handle)
 	} else
 		pseries_cancel_migration(handle, ret);
 
+	if (factor)
+		watchdog_nmi_set_timeout_pct(0);
+
 	vas_migration_handler(VAS_RESUME);
 
 	return ret;
-- 
2.37.0

