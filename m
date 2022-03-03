Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9022E4CC2CB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiCCQaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiCCQaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:30:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC8E11AA20
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:29:16 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223EpJrq013834;
        Thu, 3 Mar 2022 16:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=UGV6RFlCT4eNTBHTaM/O6/MEW4rP+HUfelNDqPiHLso=;
 b=U6atab9uLITE94zmGmRksiC/Ddci1QDJrpgGblDkCsu9bBYYjsD7w6jVGcvug9t4EN87
 goVGywdkxdyxZrrABuv4sbm6O3aoM0jvluHBQlHhVCBHAU1gwZt9Nis03PIPTPAzF5R9
 +XxLvWhvoFY4CJy7UXyJhoGsftLOcVGdWjhWRlARqP6IZ7yIlhf4LDFzt4h9s66FVQ/V
 WKyaJNzhoRwj/xoAXnZyT6VMK1MY4ntxFo/EFaAleYBFE6SJTGU80WYQvA13XD14z0my
 Ojz2MA0gn8a6N/r8CSVFZYCSTLvv+adGRQF8EDkPe9R7l+RufvT77cjP6ktvkUz7p4UB 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k49c6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223GHNOx084031;
        Thu, 3 Mar 2022 16:27:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3030.oracle.com with ESMTP id 3efa8jf13q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NviUR/RlgN38YyNCf4LUgFsdtylDIMdM4hIocN8yGnbs8LWUG0vgj38iRnhiN+rDXCM99ZyIEjnl8EXqZF980N8Prt1CnaLyPjBIidVcC6DYWEas+toSE9ipCJwTaJyKgQiIjep645DdoFtIC7P8894HD6J9uBxkkxzqwR8dMXyUV/Z1UNN8fbmcUvPSKMEO73wFiO00UIvjJQDt2SPoT/uaqf7jHS8oqMhH20exDH4Y8dTyadrZ8AJgidSUqM4XxASqD3Sa1moPfqQWILCnPOza3EtwpBr6AaDMrkf/iSkfIr2rVCM1X6mWPpXSHCJV7TLxKAEwW39qZ5WhnvWfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGV6RFlCT4eNTBHTaM/O6/MEW4rP+HUfelNDqPiHLso=;
 b=Bhs/9/Shx6da2UDv84KaJkUgQNR8/PaOuyx0UrCfMXUCz3wEEV4Gz4l7RHx3nXqMiNHqCmogYn1/8g16uQ6w8TxsH6l6TNgOoJBB1GuXLc208R3xj3wYE7lQXPUKO2E1xpCgtOmxy4CQIw5gV2Au3V8KIXKllfuqYp31VdLd1MqFPhvryf4KWo22DRiZ/rqfpE+K0wLBMdeOXZEiU/3QjxtkWVNNepAw9FiaL/bPbfo+PRpDCFEp0svJAyh9yHh6ANxU0j7eAZLZ02d5+cOwSXj+XEFcHGtK918gt/DzTJIxi5l4vD6mVXdh6wRnbxbc2AkmTcpcVs9QdIXSdWj9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGV6RFlCT4eNTBHTaM/O6/MEW4rP+HUfelNDqPiHLso=;
 b=uATjcT7bmMTZVoVjCpXDnU/9eK++0GperMtcv0dvUo4t6sI1mFPzdo3eUqQCY0l+n7HEpZqgzQeu2/oGGbDXfP/vBnCsajxaBHdgngmIH4tm4ywNZJ4O3rxrpqTU9rK/ADmrjAByXGi4oKzbqnf0LXdIyRm/hIRBF5dvxeyaIug=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 16:27:51 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%7]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 16:27:51 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v5 4/8] crash: generic crash hotplug support infrastructure
Date:   Thu,  3 Mar 2022 11:27:21 -0500
Message-Id: <20220303162725.49640-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220303162725.49640-1-eric.devolder@oracle.com>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:806:127::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3d48477-fe30-4514-ebfa-08d9fd32c2ef
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4704:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4704F6EDEA3FA66B8ED15BA797049@SJ0PR10MB4704.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHgXaecNrI2t0eXrSMLdj53EyXxp6ZgQ/7TdlmDK5YvQIYOIjLtgbrMHRhXx2esNZ9tbHq1EnuFjsFYarYlVC2GAAwAw8PXTQHEaEctnilRrkSRvUQ1Qx4VNdBDWk9mOmKd5BxgwgZYLi/oNUtZaey7Fg2V050Derawd45EjoG0IKRZRc/5ohgBISDg0Skj+vipdzuPDumBRSiAi0OELte9wia7JfkMqC2n18xgG94kmuFAuwN03pLMj3JZEnL13sWbtxhwSQORT29nrVnIZNBWj4ZEn1WqGhDAvH+BJ7aOm79m9xuYhliIf1xJOAfVRjDQf4s+8eXi8NRGyMDi05qKBIqbmB7i15KOrP43rhc2f9OX4/vp0R0l5VyBK0dpzjB/DVIR5wi6+l3p475R9lI4ftBVwopFhY/KMhi1LBKyQ5BpnDG/HpaT4evj+SCCrE2JbywIOsRMohb+xiBfWTRuPFYB/zNR11cgV6dG2bBuaazLVpG42R8QAVOSAOxhCb+ixoDep7SwT9APeLUIa8e/Y2qT49mzIuQ+1RCqck4bsqzBXpG5iMiEnxOg0c5y2tv1fCchc7ReD8Be8vlimtd9WE12zIAjP93zmzDhqX2FUvJQsoOUzSjmspZK/MI2ACvi84H+jD/IqnQ3k4bzyKRcd9MnVbK9kDfqz42cgV5wPKkP/W8EKHXHhLvVF/8Ad5s0Px90rH43RLlPP2rbkul6qkIpDk06Cm9WNkPkH1Ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(38100700002)(38350700002)(8936002)(1076003)(26005)(186003)(107886003)(2616005)(6506007)(52116002)(6666004)(6486002)(6512007)(4326008)(66476007)(8676002)(66556008)(66946007)(316002)(83380400001)(2906002)(86362001)(36756003)(508600001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n1Qv70Pkz77PEDaECJwlFXf4CH8DZYjE+43dwguVkjCKpJONIR5J90wnew+G?=
 =?us-ascii?Q?77qMbXJA1rPXq6tUJiVgkDA4G5xjDk88yJcFMbmkDz7LglGBxCSzbL5UfWj+?=
 =?us-ascii?Q?ZOTyWD2Y7GyvyVEMePpp3eFQ7E1MGqlDRxNi4JzYdA6Dbf+GcDUtJTCgMhsJ?=
 =?us-ascii?Q?O0GslQoPj5wMuorkd7+SkPwz12g0xBPTSARsQFQZa6BgdZC3IgvACqC9HSX1?=
 =?us-ascii?Q?SXZSa3XaH1DC5pB8W4ejQ/7SnHNXm08nDbx7lt1zLQbRHpd8Xtnz2Xyjj1l+?=
 =?us-ascii?Q?lQJiKQdpZ7Pyh7GbvNRPcfL/zwfAWvCSI6n0E+/pQfrt/5TnvHAsCQ/Nlebo?=
 =?us-ascii?Q?25W5LjD5y0sFU8cKVfhdmQFZBKWkxxs2vLyv2c51a0p3dzYOUI3SqZOU/VOj?=
 =?us-ascii?Q?LqQZBqyE8X+0AFe2420BIMpWrIvyOQasp81/GfaT8Pb+3/ruPTYyR57g1vFL?=
 =?us-ascii?Q?zMSTi+aIlr3bbYsV04K/SNi6d6AYDcOHjWkeQOukm9An34djwLu2JT5NqDsS?=
 =?us-ascii?Q?1FUB7zNY+Oltf8Dc1XLbVq3Q3KbARjXz1K8fyGowkdsNMrnlk0/BNOUvLDp+?=
 =?us-ascii?Q?4b6//Mtxx7H0NOjgftM2DqqJ/zoOZCMnZnJ3YBh6MxmsXXSGLqDteA7BL6SD?=
 =?us-ascii?Q?5LKhijCXYfggGc6iB5mfxMwG0UzwZHzx+tqsfg1W1ZuEI7OptwIOjN4g5Yqn?=
 =?us-ascii?Q?Hp3VklhqwSFnNRbQ1BiE+2O+ypuEKjnuJLTpRwawXICSIKhy+b+VR1a3E4gH?=
 =?us-ascii?Q?sGg2VRvIlIQlBOtRGfbhAyjD3WL44bsE7AV8LLcy+Zk0nELCgCFjXcMdPlyf?=
 =?us-ascii?Q?iCA+cNLqr020DTu7xZW9hPW6v4Xf0kTKmZcxr9gYb6VLiqckNQx5floqljhE?=
 =?us-ascii?Q?wV0jxa+xMIcnjTxRUUZEpK9oA8eD0u8xOux8cD1PwA6rutLsB/TW+oFjYqBL?=
 =?us-ascii?Q?TFnl1Mp+zcFuFT70Dc/ASY4+A74BWYPdAdns1SbK+wRFJZRzwKZHMQqok1X2?=
 =?us-ascii?Q?mrDkftEKk5fu1N4Szizh5nklrykpNHmczTCEz23ChVjbgs01pMplhfUUBKm3?=
 =?us-ascii?Q?VOJiuPo/QV2VaIbnnX88q8rown4byO9CrXGvz0Vz/HQpajBja22MborSY3q/?=
 =?us-ascii?Q?AKeBRvaALs0LYzccKlFMefU11tw1fC+ilHz08Abfn6DsdMlXPFlvFelBsN64?=
 =?us-ascii?Q?VJ1CmSh2sCVYRGOZwbz0GZTx4m4ESnVDyEvuNn9bu3GXJ1HAi8Fy+meRwb41?=
 =?us-ascii?Q?M5ZE/+OqKMH8V9PltAWpeKwVt6P9lNGYYUcuPi68PCYta9kJo/8fta3iu+r8?=
 =?us-ascii?Q?M2//0BzVlMkAHCByehKOI9ruH25oUB/qDjpzDJGHh0wB3JW/JdxwqvIGhE3R?=
 =?us-ascii?Q?SJmN5OALXd+PfhMm1omFfzJ64RtMA2j1QYofeU78lle9eJK04NB1PvaI7Epj?=
 =?us-ascii?Q?F9/4oGgYj4wciGMVebRgpEqc6qE8N3NtEx5sIzv3AY2Voxbt2a6TR/WZ3oMH?=
 =?us-ascii?Q?ifHcEEID0CgDk9nU2IgNFMqZKSMMFQjgT+DqkoubbJn+UXYBkCqM+BNk8cmg?=
 =?us-ascii?Q?TdD2MAyIKT0N2GlKLQryNqZmN3rIRjE7X+STm7l9OHqz9Pab5FJ4jnNwrG1U?=
 =?us-ascii?Q?FqybjkJvCp1jSg/BYOmup9wj3ZyaXQsQjZoHXaSSXp+jeJuxYZra0mpuhsKL?=
 =?us-ascii?Q?iVMgxQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d48477-fe30-4514-ebfa-08d9fd32c2ef
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:27:51.2049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76zymlM/tqnDvHUSiwjq0Qyg/GqdTwvswdKoxGCwTuyz1kpIfRJ0QlQ76r+JgMteqsBn8OcaCA0UW6R+9Fq2osUGUxWRZc0kN12Yzn2KJFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030079
X-Proofpoint-ORIG-GUID: WB5bg2FgfsIgsTwUn7cdw1_zP3ICSUQl
X-Proofpoint-GUID: WB5bg2FgfsIgsTwUn7cdw1_zP3ICSUQl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a generic crash hot plug/unplug infrastructure
for CPU and memory changes. Upon CPU and memory changes, a generic
crash_hotplug_handler() obtains the appropriate lock, does some
important house keeping and then dispatches the hot plug/unplug event
to the architecture specific arch_crash_hotplug_handler(), and when
that handler returns, the lock is released.

This patch modifies crash_core.c to implement a subsys_initcall()
function that installs handlers for hot plug/unplug events. If CPU
hotplug is enabled, then cpuhp_setup_state() is invoked to register a
handler for CPU changes. Similarly, if memory hotplug is enabled, then
register_memory_notifier() is invoked to install a handler for memory
changes. These handlers in turn invoke the common generic handler
crash_hotplug_handler().

On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
the CPU still shows up in foreach_present_cpu() during the regeneration
of the new CPU list, thus the need to explicitly check and exclude the
soon-to-be offlined CPU in crash_prepare_elf64_headers().

On the memory side, each un/plugged memory block passes through the
handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
memory events, one for each 128MiB memblock.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/kexec.h |  16 +++++++
 kernel/crash_core.c   | 108 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index d7b59248441b..b11d75a6b2bc 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -300,6 +300,13 @@ struct kimage {
 
 	/* Information for loading purgatory */
 	struct purgatory_info purgatory_info;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	bool hotplug_event;
+	int offlinecpu;
+	bool elf_index_valid;
+	int elf_index;
+#endif
 #endif
 
 #ifdef CONFIG_IMA_KEXEC
@@ -316,6 +323,15 @@ struct kimage {
 	unsigned long elf_load_addr;
 };
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b);
+#define KEXEC_CRASH_HP_REMOVE_CPU   0
+#define KEXEC_CRASH_HP_ADD_CPU      1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
+#define KEXEC_CRASH_HP_ADD_MEMORY   3
+#endif /* CONFIG_CRASH_HOTPLUG */
+
 /* kexec interface functions */
 extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573c..76959d440f71 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -9,12 +9,17 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/highmem.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
 
 #include <crypto/sha1.h>
 
+#include "kexec_internal.h"
+
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
@@ -491,3 +496,106 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+void __weak arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b)
+{
+	pr_warn("crash hp: %s not implemented", __func__);
+}
+
+static void crash_hotplug_handler(unsigned int hp_action,
+	unsigned long a, unsigned long b)
+{
+	/* Obtain lock while changing crash information */
+	if (!mutex_trylock(&kexec_mutex))
+		return;
+
+	/* Check kdump is loaded */
+	if (kexec_crash_image) {
+		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
+			a, b);
+
+		/* Needed in order for the segments to be updated */
+		arch_kexec_unprotect_crashkres();
+
+		/* Flag to differentiate between normal load and hotplug */
+		kexec_crash_image->hotplug_event = true;
+
+		/* Now invoke arch-specific update handler */
+		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
+
+		/* No longer handling a hotplug event */
+		kexec_crash_image->hotplug_event = false;
+
+		/* Change back to read-only */
+		arch_kexec_protect_crashkres();
+	}
+
+	/* Release lock now that update complete */
+	mutex_unlock(&kexec_mutex);
+}
+
+#if defined(CONFIG_MEMORY_HOTPLUG)
+static int crash_memhp_notifier(struct notifier_block *nb,
+	unsigned long val, void *v)
+{
+	struct memory_notify *mhp = v;
+	unsigned long start, end;
+
+	start = mhp->start_pfn << PAGE_SHIFT;
+	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
+
+	switch (val) {
+	case MEM_ONLINE:
+		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
+			start, end-start);
+		break;
+
+	case MEM_OFFLINE:
+		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			start, end-start);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+#endif
+
+#if defined(CONFIG_HOTPLUG_CPU)
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
+	return 0;
+}
+#endif
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+#if defined(CONFIG_MEMORY_HOTPLUG)
+	register_memory_notifier(&crash_memhp_nb);
+#endif
+
+#if defined(CONFIG_HOTPLUG_CPU)
+	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+				"crash/cpuhp",
+				crash_cpuhp_online, crash_cpuhp_offline);
+#endif
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif /* CONFIG_CRASH_HOTPLUG */
-- 
2.27.0

