Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C634CC2BA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiCCQ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiCCQ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:29:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFA8BDE42
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:28:23 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223F69Mn011457;
        Thu, 3 Mar 2022 16:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=cFQtBXS5PCS2o9WKDXCwat/TCbRq/0pOqe6ZaQekk0c=;
 b=KSt77R5MD9Q2+DRzJ7o0tIqnR5dZJpz9wr6UkcAbZC31+294IWD+Hm5MgDSlRGcl8BZu
 m1xger7A2rsJDkXOLuxazq140Sa0K1NZ93k5sffY+8X4JuK5dp7ISzdU9woew9lKUrVQ
 DtESJFwljtcj5fgV2ItfM0NxdlI0fS7A6bZNBCWYFvfHmYDTvK2YDlc+KAksivJu9VxK
 3BQl+RF/1oq3Lq5qp+MWLBcVmaKFbDBQZMHTCKKh5dsK882aw0JwOAIVhnMuO+LC639v
 BQG7JyuI7/MQZ74RhtYHrgyq8V2F4xAlExL4VEy6BTlf8ITMiVrbzLpIRXZb9giNgFxK cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehdayyn0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:28:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223GGx4f100131;
        Thu, 3 Mar 2022 16:28:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3020.oracle.com with ESMTP id 3efc1900f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:28:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2ndW5OWRHZI0gOGFg9mOu3LBbVoCcudHbqRRouZTwiSnUSXPfynR0SpFnis+tm9C3ONq6MIooqS8EY2jDlyKI47coC/lZg9CPvkfMKwTprcDlFuKFgKF2ZSEenndn3JQAPmdeeAU2Q2c9GHNH3rd+4HCnL5UU2S8H9k8MQU0rPYB9bmhiJwPLZTq2GZLmfMWeLv77y4F70+tsnPGj6T8uUn2LD6Ljzrpfv3+RQhNszpL88mFLb2+wimkaQzFxzaevrs+IAd50V1zIaTFJV7i5uK0YmHyKZ+hnIwWDnaKkHap9ZZZzlYp43ojaF2OQ+PPjLRZlVng5tqmNTP+csIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFQtBXS5PCS2o9WKDXCwat/TCbRq/0pOqe6ZaQekk0c=;
 b=GI9Ro6JXmsceWVAdn1pnRcIz4q1vJwtTfkcFOjphsxb58fe7ya4wHyw3rkD8U7mIQkbR9DIa5eEAFjSSajEnND/jeuSzCBZIq0tmhX+zNsAsr24vHaeta04nV/S04KAnWJXvRCzmS/phSXCmIJiXYXwdKN0dfO42FKSsIFer6njeM9NT0IHK8njtmPIbcZzAQIg7CmUmP7H+suYEMVlnalsoLmAC9l1pH9WHyrKIr1JBguqoDwRQBEoRKEJDn8f4S9iefrlgxFsTggCVIqvTiDwYBQe68m7giViBPP7ylpK5RkzEDIYQgXn8Yh3Mct8ejhTD4Xkmy79yWNMuYSXMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFQtBXS5PCS2o9WKDXCwat/TCbRq/0pOqe6ZaQekk0c=;
 b=fQ+RTiCUfqjVEwNL2n/ZZwUnq9DtynqIbIAvEd84YJWh4jna5C+H/gYo9T0A8pwvvzDqvXQYgDnZ3l/XVlb8podP/Vd9RxkTOth+kkjlhsQMDoRsMv3ikWVeWKKNcTCNuozAWVRIBvOrbzApCGdyGnknCAiQkALLt13aYT9+VFI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 16:27:59 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%7]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 16:27:59 +0000
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
Subject: [PATCH v5 7/8] x86/crash: Add x86 crash hotplug support for kexec_file_load
Date:   Thu,  3 Mar 2022 11:27:24 -0500
Message-Id: <20220303162725.49640-8-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21a76831-f0f3-4415-b9b4-08d9fd32c7c5
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4704:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB470415B28ADD58B5034B5DC297049@SJ0PR10MB4704.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEHGGwrgGS82MphELISi2GHZW//FusadYh8EIY/Sj+K/RVNN2DzqbRc8Yxi4hhToaos3jpLSespkgCLlyIguC1FE11n0t0OpiFkJSjyUmbElGcTRL3l1+4y5SyZVnb1w24stEmtsgtmA+vdRIGokq12GiXrA0A+xZiKKOoH1AM0cmzhZU/2ij8JoqO9hK6wbRANisLFfxsS5CGMfchEZaFEiGWHJki4QlTq1SLTrvNBEs7y1zBmOoTNNhYLyk/K2cvTRY6GKKpK1GekpR5pCgWo1oshL3Krhz7lYP3LT3hovevEIygc5W1a20Oz1xjfmh//gLBiuFa4Ygob5MipkPpmViwlFovTtYwQMEj42a9+ADLVgiJIFDVnFvrIkyJgifS4se/QeEFmXMOyL+QBn2lBCdjN3bpymvcA7fb/EXAKIqpDr2UdrgZ1UcLO7Vg2baNqKrNqEP4y614Afz04AKPQuA6yQ45WC1PQZ59WUIlwp4j9blVM1ZglcyR53W7nVoo2vQ/WzU0l0v9u5KKatY3fT3eC+f0rEM24Rf4e3UbVC9RdZesp/aoHSNBom1XhsPKxHwSlISjCwGlSGgUIRy5yj4ykCHz+DehXk9gtz0mx4WX7Ak2vbYvN9+2doQ/YztnfiAG+Om/xxpb6V3Wp/2DkcggPkhiNs1stY0IQP7fQx2lcIMmKt63v24AK/vX3u0zRf/XgqGWsLU2iEnU8cpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(38100700002)(38350700002)(8936002)(1076003)(26005)(186003)(107886003)(2616005)(6506007)(52116002)(6666004)(6486002)(6512007)(4326008)(66476007)(8676002)(66556008)(66946007)(316002)(83380400001)(2906002)(86362001)(36756003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XrB33BG08jnFGIrlEb67tgTfmcoZuU7qzqaSfJ7s8AJJ6P8lI9tF7cp6fp8N?=
 =?us-ascii?Q?3wm7lKM/91hUxEmHJM9jE5zVusgunu6zWL7+zyAkNq2bmLcwBInHa7zaWmVk?=
 =?us-ascii?Q?4jv4mT8FXnI19C++1i77DRyex860vuCQ4IwI+n1OUmONBA0PqoqsszMEVplw?=
 =?us-ascii?Q?7tSGIurPHj5casMvze5PGxjcAVkmCWjnZZxhYZ+FwhXtlW3Ln4YMZ08oJ7RT?=
 =?us-ascii?Q?Cg2KEftMuXaxfvNyDiP8jCPFM5bBTB3ajwV7WYuWvMPAIaeSXiChDXA74WxA?=
 =?us-ascii?Q?UvtneW5KkpHhTLPrIIW1JLdFoCUZI/hvS/u51dyBWuv08wvTramNLBI/B84u?=
 =?us-ascii?Q?EH2SBZ5KOOU/V6DFcnjHqchetOBlyAi+Tk0iFh/0oJOlT9G7PoTBkpbH41u5?=
 =?us-ascii?Q?2fruIMRIxPif9Red7tWqevsu4q2h+bc/Sjyp5+eQTev0z2G5T5dPsr49g3Fq?=
 =?us-ascii?Q?9kGC9IK+cER0cNUqXvIpMDxXWnGMyifTTdUSoRt5IAY52XIllDHPcxHT+18B?=
 =?us-ascii?Q?7JQKPMGfuzwuSb8akgswj0vQ321gTQCwFXojYfGb3GW0gylwmhde6NkhF4nI?=
 =?us-ascii?Q?BmO9FgID3GJ7ZFqkduEXYErcOjThIzyUXmBNT9vN42q0zT7OYduJWiXiMwET?=
 =?us-ascii?Q?glIRc0O4fBzkR5dTNcUoS2FEwuX0tMzqMpRROb3OSLiw9P4wjSbL1HgZIC9v?=
 =?us-ascii?Q?Hrfsb6zQe4rBIRM1n9hpWYbxP76LNGU8x0XZG6Yv63yEJr3zLj89LfYD+bEf?=
 =?us-ascii?Q?PJ2aQBH3UPOeTEPvX/VDoOCdA2zjHvtTDN8/+VgSwy/l08FxRwycTa4rVJhf?=
 =?us-ascii?Q?PkTTMhG2kwXRiwoCC/OgnKb6/IFj4gx2RTb4zybDoaCqFOIkOkbXpcMHLUSW?=
 =?us-ascii?Q?3AKTvpfNpSAiU/TqtYzwCrHCH9PMzQIYJg2iwmIKu9jS5WxChoPU42rwuOLG?=
 =?us-ascii?Q?9m5VQuk0S6SA3qgWCHx8Z0XI0DVKh3j77S6FDi1ZsAlEf/dA5qn2Xg2e6ATY?=
 =?us-ascii?Q?ipwfdaZGlWoPu8O6lux/lq5P9SR9xBWG+fulx3iSOSUMlZS6C4H9VeGqfwGa?=
 =?us-ascii?Q?eISZU1u9GhVg0ROvK8nDdKgyhjGZeaTCftS898DrpGW6KKmjjL8sXdvkl0rw?=
 =?us-ascii?Q?bKs++88VSCYnQ/Dv2XoOjELuCxfVopePxSzcVw5LIW3FVuvXVvZjq7Rna5gZ?=
 =?us-ascii?Q?oRVJRskVmMmIHYjitklN/5WxBF2FkoTUxtVGA3jN7SZBMcbR9zI/e1LrsUBd?=
 =?us-ascii?Q?pGZ710ALBtxkuXLDh57XYPrGbl86r6Ys4X2q5WIqSUDNSJZAKCX7pHzf9jul?=
 =?us-ascii?Q?8p7TBqmjYB5ij3uVZ2vKdkJfjsYVtbF0v/afMXzzd2WL/cvuZhVIHowKCYk7?=
 =?us-ascii?Q?GgUJOlA40FZBXmMm4vXVfXlAlAWYHdjCSVWc1Mv4rkT5zEqfu4b5puVVX2Jb?=
 =?us-ascii?Q?H+YxWPzsceFP+KmmxmCRU0NeKQ46Bf54OYsc8dLYBS9bDzOQCqrRZwWVEIQJ?=
 =?us-ascii?Q?qSO0kfpZT2eMXxR5X7tslljKwhyFxExQXXAMq1mE6MVjh96YMoZ0kdMmnzaZ?=
 =?us-ascii?Q?1yCAJM18F2U9pH5IDXM27WbhMIaVHal9CfFXn710J83TAU/PzOj7E+77fKHT?=
 =?us-ascii?Q?cDCP18Ffbg/i3dIpr4lRK0c9dO9RuqNHiwR91U19NyhbyzEkpV/OI0bXzUPl?=
 =?us-ascii?Q?zRueSw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a76831-f0f3-4415-b9b4-08d9fd32c7c5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:27:59.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RrxVrHo/ANV2Oqtx5DL/DMIVI39mK20uULO/YUL4zkqCwEHHfOuxqDFT9yJrxGvuPhM/DfG5F0DECvuQAf8IwzIKOhvM5IOAxid9NcZf5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030079
X-Proofpoint-GUID: qNprCAJPn6tqvyio3eG431F7RSmJ-IBi
X-Proofpoint-ORIG-GUID: qNprCAJPn6tqvyio3eG431F7RSmJ-IBi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86_64, when CPU or memory is hot un/plugged, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

To update the elfcorehdr for x86_64, a new elfcorehdr must be
generated from the available CPUs and memory. The new elfcorehdr
is prepared into a buffer, and if no errors occur, it is
installed over the top of the existing elfcorehdr.

In the patch 'crash hp: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.

With this change, the kexec_file_load syscall (not kexec_load)
is supported. When loading the crash kernel via kexec_file_load,
the elfcorehdr is identified at load time in crash_load_segments().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 120 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9db41cce8d97..5da30e2bc780 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/highmem.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers = kbuf.buffer;
 	image->elf_headers_sz = kbuf.bufsz;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* Ensure elfcorehdr segment large enough for hotplug changes */
+	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
+	/* For marking as usable to crash kernel */
+	image->elf_headers_sz = kbuf.memsz;
+	/* Record the index of the elfcorehdr segment */
+	image->elf_index = image->nr_segments;
+	image->elf_index_valid = true;
+#else
 	kbuf.memsz = kbuf.bufsz;
+#endif
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -413,3 +424,112 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+static void *map_crash_pages(unsigned long paddr, unsigned long size)
+{
+	/*
+	 * NOTE: The addresses and sizes passed to this routine have
+	 * already been fully aligned on page boundaries. There is no
+	 * need for massaging the address or size.
+	 */
+	void *ptr = NULL;
+
+	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
+	if (size > 0) {
+		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+
+		ptr = kmap(page);
+	}
+
+	return ptr;
+}
+
+static void unmap_crash_pages(void **ptr)
+{
+	if (ptr) {
+		if (*ptr)
+			kunmap(*ptr);
+		*ptr = NULL;
+	}
+}
+
+/**
+ * arch_crash_hotplug_handler() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ * @hp_action: the hot un/plug action being handled
+ * @a: first parameter dependent upon hp_action
+ * @b: first parameter dependent upon hp_action
+ *
+ * To accurately reflect hot un/plug changes, the elfcorehdr (which
+ * is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories. The new
+ * elfcorehdr is prepared in a kernel buffer, and if no errors,
+ * then it is written on top of the existing/old elfcorehdr.
+ *
+ * For hotplug changes to elfcorehdr to work, two conditions are
+ * needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources. See
+ * CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ *
+ */
+void arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b)
+{
+	struct kexec_segment *ksegment;
+	unsigned char *ptr = NULL;
+	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	unsigned long mem, memsz;
+
+	/* Must have valid elfcorehdr index */
+	if (!image->elf_index_valid) {
+		pr_err("crash hp: unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	ksegment = &image->segment[image->elf_index];
+	mem = ksegment->mem;
+	memsz = ksegment->memsz;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources. The elfcorehdr segment memsz must be
+	 * sufficiently large to accommodate increases due to hotplug
+	 * activity. See CRASH_HOTPLUG_ELFCOREHDR_SZ.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
+		pr_err("crash hp: unable to prepare elfcore headers");
+		goto out;
+	}
+	if (elfsz > memsz) {
+		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * At this point, we are all but assured of success.
+	 * Copy new elfcorehdr into destination.
+	 */
+	ptr = map_crash_pages(mem, memsz);
+	if (ptr) {
+		/* Temporarily invalidate the crash image while it is replaced */
+		xchg(&kexec_crash_image, NULL);
+		/* Write the new elfcorehdr into memory */
+		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
+		/* The crash image is now valid once again */
+		xchg(&kexec_crash_image, image);
+	}
+	unmap_crash_pages((void **)&ptr);
+	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
+
+out:
+	if (elfbuf)
+		vfree(elfbuf);
+}
+#endif /* CONFIG_CRASH_HOTPLUG */
-- 
2.27.0

