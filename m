Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B03B46C409
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbhLGT5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:57:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58306 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236246AbhLGT53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:57:29 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7I4Od0028622;
        Tue, 7 Dec 2021 19:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=XzfELeoNEAQGq75fkvkaRBn8i8HMxag8QX7YgHD73Sc=;
 b=I28Z7jsUJMcyml+USdrg9NnRZjou3BLv5SzavY6IFGRUIJEtetaLRJwcvyqO6cwQxu5F
 rfWJ6FQ29Q1RROtaiJQGdb8JFqBm0+CNfgajjKe+mYawNmnNSjNGMKEjMQ3/Tpdw/paF
 FjwuuhOAyGJpeTZCuchHogNOkI4vvAEGA9VPUSPiFc9rSvgRNjAmfNR/YG4fzsvcTQkc
 wPVJg4v/eo1fPsgpFrIi05IT60DMQWePnbXPEh6AoIf71CScea0LiTw6s73n6f3odXXp
 +kTq/u9kDU1Ac2KQpRgQl9dEHS9J7pbTKOBkKUQstgKqrjirAIWqaZmdzC3Rxp6MJWxf yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cscwcemfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7Jkffs089632;
        Tue, 7 Dec 2021 19:52:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3020.oracle.com with ESMTP id 3cr1spgv5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJpL46stmnbe55CBsWeK52JKAmrIAuGvmCzRu7dqxd8TbbNR2JeAlPLZQSdPRrBi/Vp0Mamzd4e13/ktMBvE/RVSa6YXnFi++h+JMHhnlH7qo9OGhFZ5SPb+i/URSpJmaz3JUTvRL//onS2J7evJ4ErWEujle1Rzj9zTsiSnTTDlAflk4cXKBezqHGmWegQavNT5cC3pG48VxZ6Wylk3NtzgZX7xa/160Xijoewg1xUQwzs2a3U+Z65hDIp8cHahybxL36vvkChlVDXMxr3rYaI/yOdVS3dVfr8lyqgNO6Z+CLdfR2Y8vpDBnorFIROO4WUGdLgY72n/h/x12QHQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzfELeoNEAQGq75fkvkaRBn8i8HMxag8QX7YgHD73Sc=;
 b=Y99OHZbDUAayxHoaKC/thaEeLu1Z5rogpSaFk3FqyMw47Ivzrm84YG85iF03MaoxuVY2RlhOCvHaJxuEzZrqjCF0OxfCGaO1QzT20C0XrTPfysVnytmBjok7IQDdODILqCI4eARC//WZEE5r5B6Re0Z4ymUmMRCiZkCDUuM/0D3dtkRNeUKn9OVsKDRl9ObpWrJnXxRpfVlhOIu2f/iTQAr4aMKBaj/HxUgfJXu7Ie0cDnNCCRX4EYODr4HTt4DU83DYmzhBpkZvajLtyiNakSe3ErUzNLjkO4ipOWaeB0WfJPJPmaM/5FBidH1nLC6c2KI/t83W8qDOTmCgmj4P0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzfELeoNEAQGq75fkvkaRBn8i8HMxag8QX7YgHD73Sc=;
 b=jmtdfP6uU3DQHAEtyh1TiHQEjgOb+BIwhC65Wecnza5qckBykE7Mxd0tOua0Wx5CrjrZIG9ixnrQ8b2UDHVwNAT2A1yTfglwI6N6wDI1QKXYOrA115MxjpbV/m0iLQ8EBiacIrDSMZua0IaQ9egQ3zWl6dLsY5n4Ugp3qs5HU6k=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1695.namprd10.prod.outlook.com (2603:10b6:301:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 19:52:28 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f%4]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 19:52:28 +0000
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
Subject: [RFC v2 4/6] crash hp: generic crash hotplug support infrastructure
Date:   Tue,  7 Dec 2021 14:52:02 -0500
Message-Id: <20211207195204.1582-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211207195204.1582-1-eric.devolder@oracle.com>
References: <20211207195204.1582-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0210.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 19:52:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b800970f-f044-4ea0-78b3-08d9b9bb190f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1695:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB169564B1F40BCC730BDEC0A9976E9@MWHPR10MB1695.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySPhEc5QB+rjA5/QgBrvW9Tqsv1/jnREmC61vJny6AtyOATaPuOXpwAkgVNbjXYAyanoAA3XRACNnawjRpZGjRx51j/bOvPtwxnUNKIkwX1ggUnS+N1R1ddq8VQYuPfPpbLExf+jFdAYK3AP6svT3jC+qxx++LdmACLXTWpovva43HHCyF9ValdBm2RyOyPscVxzG3xfiuBh9qTmJ6k5H++7R8m4cZ7UbIQ0Ln0CIB+qK2acn5Ox52jAKkzmqrQ6Kf+/JQqinq05l/gxyO10RipEvpavWShuvrNY7Txh6BDKgFA3ArYRQKl9lM7Lp9Pw8pN2GtmxzoTxQxJVD8id/NkRFhGAhwHQq0jPPw1SF4z7zAs3suF9XpQ5zRWzKnk3bFFZOrEDGep3JzTomMCDcbJF+41w5uKIO0jQYM5j7aGOlfBFp8B+TvhOY7WDRBdX3jd+NztYyCgj7SVlgG1npOzPw6JtS685Mx4VIqQ5+8D10eNYcT0Qg0SzTlP9CQ7BPhWws4YFTjl8IFcmdvWLtwOENwbz9s4vBaT0JikbxSfuBbiMjwV7V/M9VVfslw3KViOpPbpLiU9Lfl4qEY0PR6Dah782Y30rejFYxfQ8iNKjSsGYtP0J/YjLIKvBS7tWSYQ1+e3yrFN8RjHCUHN9nQFlH/nTZkTKdrc0U/tVt7nnJbIsBYrCdqj4gQLG9AN0YVNQjdwl+E8LXlMw7B9vuz6aZp74Rv0FbMRnZf9neFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(508600001)(7416002)(6486002)(36756003)(4326008)(6512007)(6506007)(8936002)(66556008)(38100700002)(2616005)(52116002)(38350700002)(26005)(186003)(6666004)(2906002)(86362001)(956004)(107886003)(66476007)(5660300002)(66946007)(1076003)(83380400001)(8676002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CFzVJTBEVaYUn32ajo4YaU/Wk2EM4DihjD3qIZUmlCJGOAdhs5HBGOjmj0XJ?=
 =?us-ascii?Q?qJxrvJRHN46U8UfuAjOFclMwo9hO0bAw3rLFs3A6Gkanz339LMiwC0hro8LH?=
 =?us-ascii?Q?e9h8I/sos5fScdiyCLZkoHKks9DpAx8pafqNZFJStiKpwf9F/BHw5H8HdbEX?=
 =?us-ascii?Q?V0gv0GYfZk/XehEBsziQiEUXG6/XAltp59XgzOt7NX9yJdxA7bXVxnAG76WG?=
 =?us-ascii?Q?aDUgpnOfh3S7vs1/4v2SA4lZgxdoWBcrfBvKCM/ZDZQnYNubmfNoSshIg1sf?=
 =?us-ascii?Q?5iXmeMq/Po/gQVlnyCS0pTpvBQBi3fwU+rGt6BJproqFNWq/YU7z9v4tXooh?=
 =?us-ascii?Q?mNSRPBixg5sU9amE1+fi7hRQFJURO1QZqyiNnkQNhlfWWY5QbZjG7lVprXoa?=
 =?us-ascii?Q?yULiqF2YCx5fdWXPJWy5KeM2gSwoyp7PBH8JGFKHmB6ScnU1scUGMsr646zE?=
 =?us-ascii?Q?bdPY6O3cQgOXFrynxdi6Pkb7xrkvCtq9KBNEdBXVelPBnbIy1jr1a9TJ5Leo?=
 =?us-ascii?Q?aJUEk2UrMl4oTRwakb5JkAA5FL7Y/kgZ/pRN3b0EHEjFM7Pw5ZWeBsXTtJoy?=
 =?us-ascii?Q?5uBUkXWSeiy0ToKwZWMuLOZOQ3OCD2tOs1AOfafJpJCVyss+fsWPQ4yaqfXR?=
 =?us-ascii?Q?rItCMoJ8eanXvuTZZ8OlvoKo0cBXZTyXpBoXh7ZzKhQ9sovfROv/aY4J6Ths?=
 =?us-ascii?Q?yXmsb6u3KXCGeDu4GWcUNfyQXszGbymhw9PAf56dwa4YVeYD6cFIHRWKzH+y?=
 =?us-ascii?Q?4RE6CPXHglId7267pAMHf7510f1AJwaZpALU5xHwUrMs7ghJHeC14eJNE5HS?=
 =?us-ascii?Q?T/WlO/H5cxoEdf4whiowXYyRGsAqOo3VgnuwvKNcXS9eX9lfgX7Z4WjbEdLw?=
 =?us-ascii?Q?z0DC9xT0QGyNZt96GWvoPEx/GnDN83hpH/zkyoUnctq20FDCwCesHA4FYka6?=
 =?us-ascii?Q?E0CXRoOp2DekfqSERGGto5Kv0wLAyRG80ZUfJLNfVkxleDDwr+f8hPJQIgzo?=
 =?us-ascii?Q?60Rwdy0fB7dDAqzE9xKr2qipet5V7CRCyByj0Osn6VjAz75U6UvqNsdmouRb?=
 =?us-ascii?Q?EXeP38YpxeYclDRgUCLkg2XqVo3nyp0UF+5H8azuF7XslyXU5FMllnhqYxHo?=
 =?us-ascii?Q?UaOXQ32NAmjayqQjiLpXv8gFgi7+3PChMIlC0d3tHNhyyf3t6tOzfzDKhKAB?=
 =?us-ascii?Q?4YHAEn2/1i+85yg1xTkRGWOFoyVuMQZS5T+KLSj1DwjMrvNGqj127w0l0Iec?=
 =?us-ascii?Q?bjPLNyMjwgOZxOsEevFeUSU//hfpfgEDkoduYn9HzIT09IS+4eUef1b5RtCz?=
 =?us-ascii?Q?BfETsuo34T2G8EVBjXVSMbEd0t4WYpOgv3GBucTy3ByY6cR81PIc8tc6jltM?=
 =?us-ascii?Q?uGC9681NlnqpLDQBgU2FuR9R5FgUDALvutvHAa4UYEL+zclyUBkungKPf/G3?=
 =?us-ascii?Q?U+WJbxOPAr+ow41XjFe0P8ODyBC8BuJh3P9DOSOcemXuTppNKEMg608xvjz+?=
 =?us-ascii?Q?UcQRj6CYM4MVOMJ4D0oC00Aw1xwt2pACg2EfKLZEQxvcKIpI9tZphpV+gm1R?=
 =?us-ascii?Q?KFiXwutjUjBhVqDe5FbZFo403oTynqg9DP+7jvYmcIE9C0zOfP/L4Km13KMn?=
 =?us-ascii?Q?v1sVw3g6FHcNjjB2UpPhCYr4eUl6HyxoMEszOOTt5yLxdHTIUrjHlgyaBTSW?=
 =?us-ascii?Q?c/g7NA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b800970f-f044-4ea0-78b3-08d9b9bb190f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:52:28.1821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkQAk+soaIcvO5JUrh53xEHiCo5TixqinSrspll7eo3D3kvjU1kwV3anywQIegevkf3lTB1RT+NzsdpgvFk3Wcg9FCuxNJXp3m8TbDnKuHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1695
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070124
X-Proofpoint-ORIG-GUID: V2-HfuT3p4VaUHlFz0b5yKEkV8w4dmLr
X-Proofpoint-GUID: V2-HfuT3p4VaUHlFz0b5yKEkV8w4dmLr
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
 kernel/crash_core.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index eb53f5ec62c9..9a30a305b04d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -8,12 +8,16 @@
 #include <linux/crash_core.h>
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
@@ -480,3 +484,117 @@ static int __init crash_save_vmcoreinfo_init(void)
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
+	case MEM_GOING_ONLINE:
+		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
+			start, end-start);
+		break;
+
+	case MEM_OFFLINE:
+	case MEM_CANCEL_ONLINE:
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

