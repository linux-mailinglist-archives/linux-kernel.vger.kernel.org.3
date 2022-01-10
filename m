Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4857548A093
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245029AbiAJT6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:58:20 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22524 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244944AbiAJT6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:58:18 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJlgoG011397;
        Mon, 10 Jan 2022 19:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=aWgZ1bwTA8+0X9r//DWulA2ujyrRiXrIb43veEGu5qE=;
 b=KkwcipXuvEpO7jfAwlOOTLNBJOLAPnYiA0V5UY2UbOI486eqiz8dPiUzeDxXn137mZlS
 x3sqT3txRXih7qzdMeuDA5BFACEAv9cT1HEFMJO37jQ6YTZN47u0CP28S8hf8poeot3D
 PX8ch6X2tzllrIyGiCTKMxaP4g4ChtVP6a79K+01jKn+YkynjuVVIsPOny5bLAPqxVn2
 uOQjMUQ0Q3UddKwFC0ePGU68yhBUjTCPhu4WU8JdfkHGfG7M0cv5/buAC+LqW7XC1wNG
 0UcNJ2tLlVOzLwJ4tXrApKjezPJOgcr6nWAAQmR1HdLGi8p66/CWo00hEfbbh0AXH0Sa Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbshnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:57:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AJu5bN176543;
        Mon, 10 Jan 2022 19:57:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3030.oracle.com with ESMTP id 3deyqvwywm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:57:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5bP9WmWZkCF+4dBrrRFVJPoKZdIkPe8dFWVtxyFyHXTNUOeC/OzA2Vwvz9aOaqOJj/fmVga2xKyFk9YCQ6KNnsnKfXpzR2Amq1H6eezY2FUd3w3B5RXiS18e42xymszwdoWptHPqyd/FseuydEP3ol2iAXuh7Hh2tLujlTgcjdVUfRwO3McEGI6uO8ei/xr2ZX0ewdvJKMvKhL3/8dqFHWs2A33FhlFDC+6klu9vHGFfSdlo+PX3sFVmcErDGYoWm4qAJl/103pND22C+fUGThtbD/mJT3MhrjfRWxGthiU2xlycrr160yfpu6Unk7CVo/LLagN2moZsSnECoHFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWgZ1bwTA8+0X9r//DWulA2ujyrRiXrIb43veEGu5qE=;
 b=LCO603AvxBMnbDg2bxmIxZvG84PLN3CnsB3pCa2E/SJX0T38nrHF0A6p/QceKJWKeavkewQk95JWX61K5tUtpGFQzgkQ9Z045251ePoPFasN1kkat3LFL9X5bapl8bYicdTnNeit0yNa7Cr/qmwqp+dZ7W5KGAJqgRH235UQJi6DhTWBc5RnSg9FrKlWxtjpLBX/Sg/JJ+GpHxNOXq2f+p3A79diTYFif8xmOYTrujN0ILX/WZiEMQCRyY7YLZ+Wu1YXDnbnapiFQtUFQXZAQv06lAdVBOxTMqmLVvNpnE3fskgfsdhZNwF8fwOouCIjuSEeXCjqr+k9DBGwAiSOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWgZ1bwTA8+0X9r//DWulA2ujyrRiXrIb43veEGu5qE=;
 b=kHcsvgMXiDAETnKPJ4uEjvGVJyz6P7KFgZpDpWF2D5dIC8seW9zCGSAh8+0NxIvjB4ksprql/0h35qbzCz5HJUKM9P3ce8ZZxgZnWFgl/Zk6H+ialUNWFLagDLzEHI8G7WKIEuKlNX0Wplb/No+04f4Wh+sacK3HAPsWqIB09II=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Mon, 10 Jan
 2022 19:57:54 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 19:57:54 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v3 4/6] crash hp: generic crash hotplug support infrastructure
Date:   Mon, 10 Jan 2022 14:57:25 -0500
Message-Id: <20220110195727.1682-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220110195727.1682-1-eric.devolder@oracle.com>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0149.namprd11.prod.outlook.com
 (2603:10b6:806:131::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 689d51ae-6aab-4cfd-ef76-08d9d4737d85
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB57018E99034F2D8057E67A7B97509@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQSW0x3+oALJvLNanJUyO1MnDOlG4eyMElR0g/MSAvyVC/H7QZV+aEttQpA/ibcqmlOvyZfsYZGCH3gtAyuCNTgWyE3O1JIsS5KIL++g8oZfk55b6T5PVVUeJ6nc/IRtMb6NcYBx/TEM49tzi0NhQs3niulqT7cUA00QCKQ78hKkzEzZAndmyKxZI7+bfaZsJ4p3VMBimWpIyibUueBUuIDXQvMfwNelRF9PzLYlBor1C2zDwUAsVYQdFxTIwRkyVtufy5SKauhrB2U1mHCCRgacBfBKOKyREoOvx2vahxZL8cZfGmgjPXPa9GSW0L4gZ3gKuiwmMkHoUNt7uFHW1pEvRh0HyZJF1qn+pUeb6bJZyFv9UEG8YaeiqjIlShLi5QRdDLgaAA35v8aHxYa/J0Wrz9k7KI5mYCrQ4mQeCOWcrB9z1UlhaMkSVyVdnZCW0G4WU4Mq0Z4LFby3vIyv487aCIhJOSFq73wJP3NtNzaJ3RpdBlwc9lpGK4sN0q5iNoq8TSJhj00DG5umMggbOnN32TqkGHjub+bp5Lsu8+iDt6+jldbaZ90wB+PkT2I0rc7sBqp7nto7spvlAMrOIAStdCW0lzaJsNxvXBlhu6AzS6YJrBH6Y77GeXNHsX2GbdR3hyWRwUwfDsOtPl7fpR40rZUQbaBEifbSnzbnXXJxXR8pflaTIwXjVZ287BtmYEw6MuK7/oz6i0vufyffTAWd+pSAFbehJOhWS3DaQx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66946007)(66476007)(5660300002)(36756003)(2906002)(8676002)(6512007)(52116002)(8936002)(6506007)(4326008)(26005)(508600001)(1076003)(66556008)(6486002)(38100700002)(107886003)(38350700002)(186003)(316002)(7416002)(6666004)(83380400001)(2616005)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/DbSohMCjDuxvl9M/GfXJjjIlZRWQfpo4EeveJzAnKlL6npbX+BfJ+0ZK0UR?=
 =?us-ascii?Q?6PxfUWxUBu4GXqQcCbOl1bwaP/vAOfNBy17AOzVfbu2bZXZ4pWvZFSdZPCeU?=
 =?us-ascii?Q?y/4/AnAor9a/1xRYn1oZJLNjSk2EVJt38+5bk8VI+atxxnySJPTELcwhgl7c?=
 =?us-ascii?Q?iy7BiunpE3tpyONXKfYeLsfxTpQEUfhZzti34M1lbW2Kz4O8g4EU9Kmuej+d?=
 =?us-ascii?Q?/nBSw+DjAzZa3Xct0JSyS3hmx+dYOaTBsHlg57WUlAFyoNd59JP0xnvFrHCw?=
 =?us-ascii?Q?z3Iy1atLBLgTaKxdwaQeGTKjSHEFQk8qSUNf8OR/xmHbfRogXKRO/nGbslZA?=
 =?us-ascii?Q?CtbLWwNfVrcunvcJ0hVrEHN0t7wXCfKw80dyO5WAcWgt6bNkYROU41BMyb3u?=
 =?us-ascii?Q?/NcSJqvIs0pvoaWIQBueSH2ikwNM5wv3QOFyRk97iBSEIdHkBX09rCwZUlhP?=
 =?us-ascii?Q?0EdwqRyl4dJuUhYsTR99ene1PK0I0mNlLfBUF9Zs22frCkkachYaN3zFue+x?=
 =?us-ascii?Q?1dIXWBE2gx1GFK3nXqRvb0fWaXhL/jcBLaFGyyuUGhUjpPYbgBnM8qcyvMv+?=
 =?us-ascii?Q?Pz8M2UuaccI7qGuGTFZBNMDFk3QP0te+1ZPI9zkUVGLLgN4ELGW/mwXX46Jh?=
 =?us-ascii?Q?6HR2EmXXSAiEOvnYZa+RBXgLrHAAM46gzDyU4GYzcsPlim0552UkRyyzhSx4?=
 =?us-ascii?Q?RyuACj4cMPtYaC7ZKn1Ie1wIHM0TfmjmwZaiL5YcRw7dXryoXQHrpwpXILzD?=
 =?us-ascii?Q?XJ1BXszrf2U2dPwC9Qm3wYsLG42cCZ3Uyn+Z6z6XvB1//YX2HjmrdtL6nAUb?=
 =?us-ascii?Q?l5f1IxgI37nzjzUxw2Gh/w1O2ArV+HXWc3qV39/m1ozY7anInn/EH5BFTwX0?=
 =?us-ascii?Q?1eVUCd1G+eoKcCnBYFZrC/qRoaS6WUQTipb8oAmhONhX4gvZDUMaS2A8ye9y?=
 =?us-ascii?Q?5Mp26I5AMJxp6dpj4zyQG9ABd8URANa6KvLrwqfY6bnpshNOc9OOoDBwDP++?=
 =?us-ascii?Q?GgGlqVOc5wjPvp87GPzifiOqC5sHMHWZW7ld5FZXwp2AZ5NQp+lZuLpYwuj+?=
 =?us-ascii?Q?CyRkstS+4z/4/jTo2d+Y1AqfH8iqNu9KbWCU/256vsI2du6K171PFitPE5SV?=
 =?us-ascii?Q?ft1hCoOkgsHPm81zpXzLWaGzN1uGBPpSwWiuiq09qmsIGLaTJRlbBNcsaAFY?=
 =?us-ascii?Q?5VPyndpB2gtKINA0MeH7tcnpOgdH8jfPZCTdcneRF+RzlHIwLm3WseRF/A+v?=
 =?us-ascii?Q?MW8Y6Ttw2xYhnl22QcfkcOMVnRaQqKTF+4LWSy/BqtRkDkDvU1OWUtIp+lzO?=
 =?us-ascii?Q?r5rhDFVaCQw68h2mcqGT3Lk+fG09I545rkhPkOGFRI23nOjM7OsnDWdF9iPE?=
 =?us-ascii?Q?Ybq+flHDyQz2O1liDhTK/Th7kvyuLoPvech2h052mPplOigAtNXBvb7/cgQE?=
 =?us-ascii?Q?Xk/ZQbhsuu9GA/rrtSL4YZyK/9IzasIa8hQeQ823N8gejDzDXc72vZsQUVyf?=
 =?us-ascii?Q?OF3GEBsxmZbOq/feN9tB/JXVaYRzzWm294xO5bGESTCPzcN44dQBMuW3RJwN?=
 =?us-ascii?Q?VDSOQnmhsHUQ+tlpy4G0k3/Z3sZ0FQXp7jYZeljLfP//JgE9JVHxVFylXDgY?=
 =?us-ascii?Q?jCbhZ3iP3G36IwH8eEBHssd+pDIPDV0ffnu5jflJZs7a+mmulBliGXdepaxp?=
 =?us-ascii?Q?1c6yJg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689d51ae-6aab-4cfd-ef76-08d9d4737d85
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 19:57:54.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvfCEq6MJGyBOKHv8VMUo5+EGFGI9KWinKwJ1H/ffhZtmiOVGf53+FvkCWay1KynSe3S5QGy0N8NUoZCGw5m9bxtTXEzuLGKcRovsAMS1D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100136
X-Proofpoint-GUID: fF_x8sosoXNjNIejs1iZvoEuGnp8634j
X-Proofpoint-ORIG-GUID: fF_x8sosoXNjNIejs1iZvoEuGnp8634j
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
 kernel/crash_core.c | 117 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573c..acdb9c7ad5f4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -9,12 +9,16 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
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
@@ -491,3 +495,116 @@ static int __init crash_save_vmcoreinfo_init(void)
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
+		/*
+		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+		 * this callback, the CPU is still in the for_each_present_cpu()
+		 * list. Must explicitly look to exclude this CPU when building
+		 * new list.
+		 */
+		kexec_crash_image->offlinecpu =
+			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+				(unsigned int)a : ~0U;
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

