Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D74AFDEA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiBIT7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:59:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiBIT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:59:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A81E06C407
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:59:26 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HQ89m020178;
        Wed, 9 Feb 2022 19:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=3Nq4MkJMFFvq2gmL3qOU5qrvS3ywvSPoY6fn4Kkgsj4=;
 b=coYom47f+ZFRQBa4Pwz5BUIxB3qHBKK5CTimz61TzHzKtSLMNpj32Tv/B4GNV04aglZM
 5ejgWfPLU5OwoQ1CTHlfR2+ImdHQzF+LPQ69OWC0x7XoDSLS1YNF77qgCp3bMNIsj14j
 5gIWizTB3N71nYH9iF585WcnATcp+3gIrky9ZSNqN3gE4MBAifUA3YVeUxhiBt+atu1o
 3zTNGSA9S3bIjV2VmLmAALFVm/EATBM87HcASSqN2jLzGOlU+K5nXqTzCPNiFL1mj5CF
 0d3dp4CxIPC2ytCltb/epVZpZme5SPwHjNMNcHoHZxgowQ+hJslfY3d+1KyqLFyR1pU+ ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wxyjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219JuBUZ095710;
        Wed, 9 Feb 2022 19:57:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3030.oracle.com with ESMTP id 3e1f9hy672-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8FjpG0cOkaZ2th2D4df5wJh+bjox1dJewwcsKKQGmG6XvPHwhoSCkLbweYjCP3Y5N1mComMG/tGVtYNm06N447K2uvuB0N6S5JrYHIKSh8sU0J77CdJ/YdMVWbR+/qYsZV3A4pcJEP3eTBbZWOszmPssLReYLeh/m/UCloEOIjIWoX2iUmu9BD00Pjm80FQeQdxq5B17lZG8yqFlTYYORn5hs41a3wgpfaE/rXXBNG1YA/9vmRRxiTQKLTro8J+5kkgC8+xRldH+op1bV7CPYPWGFscbWMvbVJYtO51Y2rzU3Af3rJ+LSzCiVigg0RH1uwzDQggfqfgFdbn5bpX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Nq4MkJMFFvq2gmL3qOU5qrvS3ywvSPoY6fn4Kkgsj4=;
 b=UayErf+k3KjsfMvJzLcpaIOkVJzGWEX9BNFB/ZNMMLknhaPmzMAmsNDZ2xG7MFy6p1ZcwlMLR0gjySySvXF32wWxhUaGxIQ/dSPwdNkUEVDubCJ1d/TLyI+SripPqz/vXDZ/ZyDY+l5rsyCszuZtVeLLcy6XugErIMAIJbGRg5JjIh4qUyH6PVg6PU1jNYhi9qoq/ELWVf5bWTI0+SF//GZViX1ERkxQ32VCJnjxC73bUGqNs5Z+Y6dAGYWfROUWFArAkhNdkODRGr2yutQSrXe2/iKEX+tivYWa/nOp1I5q4NEg75yF0AA/ibdSWOdA2TFIkBgth/zqklwgXO0ZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Nq4MkJMFFvq2gmL3qOU5qrvS3ywvSPoY6fn4Kkgsj4=;
 b=JKmk764FrEQr3qN3G3OCI4d5ehkVCfUG9mJlQY2Zk9lBWtm9raLkso+OpVj6xpMexVC8c1ldNx6WYrAR66coVuC0fVuxUKxn/Vi966b8n380FXpfgNKx8c5Sz+eKK5PCDsdaJqXPbxelb+pMGKSRruopErFmNXp2NBRtbM9s9FM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:57:31 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:57:31 +0000
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
Subject: [PATCH v4 05/10] crash hp: introduce helper functions un/map_crash_pages
Date:   Wed,  9 Feb 2022 14:57:01 -0500
Message-Id: <20220209195706.51522-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209195706.51522-1-eric.devolder@oracle.com>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:5:335::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62e775c0-b33f-432b-9d23-08d9ec06683a
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5701EAA4F0F2F83C33DD4DF3972E9@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rg/VZ9MRl4va6uuVtFKK+OuwzgVmTWGEJolbN5NHy06XrnWbltb8vvYNbTuqQXUvy0zf0f0A7waWNzNdKEWN2N/2aIGi/HE5QrT+PUIUP3mlMMXuJCAfMUXkZb1UOgonIhnZ2DKGf8qHmdJqVzD9S/0hvo8oB1eFkvvKpc3SfqBy0gwhlPtRHnMYevnAsGCMc5ZexSeRhKNXta/6hUFWn5pNCcK2Ye/6H6/k0GEKik2YHoqE3p35k690okr8V12yPZ0UCbjBxoXRp/58wVlur+bEqN5qIz25+6pundqADcIZBW8+ebo735Ch3nWpda4dkbbzdftSeF1dsRSUGmgaD4bRooKflaD/qw/QIsDlRrL9lEOEJUlUxL9yWxHG5hMIVIADKT2bAOinrEH/Vljce3BjDSDiTZ2D3qPnAAQ2fii45r/Gr6CglFDFVqGsXCqSUxFSrcao+2CagnkblqXdJIJ0ICbsa1IJlvegMkVMDrM4Edglmw6XcQ81WE0GmcJG8kbVGgeDWNOl7QYcbMMEUm60d3k8xaWEcZHNpSfenO/bdbHDxmFQTfe1/H5qKoxG2gEEYqvoilbhBbgMZ2Ny6kajSfy2JGn7f4thrvcULyTK6GReJ942J1OFc5p0JbYIj6c+CfT/os+5DYNQRgfhwkBSEjAfeXuurN2a+5CUmOhmGaPDTUcj2R/HBb28jtr4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(7416002)(5660300002)(1076003)(26005)(107886003)(2616005)(186003)(38100700002)(2906002)(38350700002)(8676002)(86362001)(316002)(6486002)(508600001)(6666004)(6512007)(52116002)(6506007)(8936002)(4326008)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SDisjgfmblDJDhdS7O21ogvKjWqBWGNzAhs87WEXriTBBimSC08CRQG91KZM?=
 =?us-ascii?Q?nLb1UcUZtKGJoBONJMUkvOic/3FrJ1Em8uSvZr+l1DWy1EQAvnnAtqAE0+KE?=
 =?us-ascii?Q?0HwSEO5rozp2DJLkDXZECQGCLujWo9XL3oC8ZkK2UndheYAgODdU3aiVwmMw?=
 =?us-ascii?Q?CGuuHix3gMiDUJ1QjQWqbkXIugNZISKxbKGdAzWE+y2lD3HDUtAyVhax4wl6?=
 =?us-ascii?Q?irh3deCikDkHvwFkR0TY9TwcZ2kXj8Fg6gdCK+6ayJ3CFw4vU1CEGbNnLtaw?=
 =?us-ascii?Q?xq/S+ORWYFVntTbUh6HXl85QuV4nDoiyAyEJbLgm3qhbhVOMcdQGt/zdY2oB?=
 =?us-ascii?Q?yYrF35jahOVEcrRxmGmbof7/g2fHgiFs4ZxhdKmLw5O3I9PgsJ4w6tyqaBI/?=
 =?us-ascii?Q?qh0D+2IHE1e/PTjprCOdf7ZWh6cKal+TC4yFl/LpBmxt8Io7BNPVBzrcd0YE?=
 =?us-ascii?Q?m7vdWegybJB86OgrhTRzvAb4LJwpq+QMeQDpgbD549uT/lYlqFilVncpSTmb?=
 =?us-ascii?Q?sq3GKV1fe4ZXDtdHIKuTshjipWCkuyEXkNIha1kfj4NpMhDtRUYDAwXwEosw?=
 =?us-ascii?Q?6Z1coi6CmEwYN4P+UVrilJTywXcGhfj2TJTyLecdvXRFc3ibzvQs7lpCCkwM?=
 =?us-ascii?Q?Wi9cKCUB2ouwt5k59CvuR0PQYckGD8QO8ujIerVz3rSkuiM2IYAYRo7mw+hv?=
 =?us-ascii?Q?Hk+lTU1zPJxxCwuFFNbD+X6GvaKiu67QFtiYV2S+brpCBAvgNbkL10HDw9gk?=
 =?us-ascii?Q?M4fyIQv1SR5grxyVPmhSS0L8FznIuur6uW0SGwNogjQZ7FXZBpkzUz477D1S?=
 =?us-ascii?Q?KuYr3HSiSQEcUbsSF3nos8KTHFGzO1qK83AUeCYKZrvN3WmOBU0IqR8vaIUK?=
 =?us-ascii?Q?l6XT204hwqnkbwAtF54Fy962tIEMG8IYWi/6T3ZmygldBkCi7m2e2rRIymyi?=
 =?us-ascii?Q?IJP/JNTryTeY7cWFHbr6y/i/8dff4jBmrTMDdzew5Y8VnlRHa8hE6WFY1Enx?=
 =?us-ascii?Q?OLjXdYMp0suq0lCTRt1JYvcm7f2dKfSy8qI9jk646fpGblTaPf9htGfrcXVA?=
 =?us-ascii?Q?9wFDacP4EPQw6YSaQjGzZevz1u7tgXxzlep1C5JBW0hzm8dvYdOdby3G6aM3?=
 =?us-ascii?Q?c/92q67ZgGnsBt+aQVoP8djoaJGIi9E/BA8vgjsjZf45Edw0/d8Ghw4rMpVe?=
 =?us-ascii?Q?0zexKOA8ikbf90e9GsnU6LuI+91BpMkVU9MK2sNAKEcGYXRS7QicigM5c13U?=
 =?us-ascii?Q?fSh5opu2nHHNK6X9jreWHiCWNEvei4o8uHwVbd6Ab88expfKq126Dyt2Hhje?=
 =?us-ascii?Q?fA4Yw9qnxDxkzfvQqb8obGQ5exLLIYmCgQ3u8CZKJXzQ2abnBk74OkkSXD82?=
 =?us-ascii?Q?b/1TdIZ4518rSmRi1n0HpDhj8BvMwxwTEYsveUcMpmY5eugELSJsP7p2daBy?=
 =?us-ascii?Q?ukKkjYcC15v25Z9OPX2mXRQa8F1IrbVEdiysZDOLF3/01LrgeHjDRwe7qjVf?=
 =?us-ascii?Q?RWy6LxrLwHjFvK9ao70gkHpS3F7nl5N7sJBi3ZHIv8EMACPLDqaTaaDjIQ9k?=
 =?us-ascii?Q?yA+1Q+ncfQKTpxkCFJkAa+6qShiBMg9lPS6TdndaVUMcmICmRX5JZG+dJ0tx?=
 =?us-ascii?Q?WCiyIHeOMdpRQkUb790tXWwBXEP76RlHke1VXMI8G7Et50vIaLAf9NTtPscN?=
 =?us-ascii?Q?eaZ4Tw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e775c0-b33f-432b-9d23-08d9ec06683a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:57:31.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qV4ypv0SA9DOjbMRzt+Ea3r/p06++rIfjKkCM9zLl7LQm1Vs95YiSqJ98TCRpWrUIGCYITHr3Luuh95uAQ13i4gowAhC50jKjcSDGCwcTmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090106
X-Proofpoint-GUID: 4Q_OLwA1WI2fBBb4VBsnF-yPvhlX5mgL
X-Proofpoint-ORIG-GUID: 4Q_OLwA1WI2fBBb4VBsnF-yPvhlX5mgL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change introduces two new functions un/map_crash_pages()
which are used to enable/disable access to the segments in the
crash memory region. (Upon loading of a crash kernel, the
crash memory regions are made inaccessible for integrity purposes.)

For example, on x86_64, one of the segments is the elfcorehdr,
which contains the list of CPUs and memories. This segment
needs to be modified in response to hotplug events. These functions
are used to obtain (and subsequenntly release) access to the crash
memory region in order to make the modifications.

QUESTION: These might need to be in arch/x86 as I'm not certain
the implementatin is valid for all archs?

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/kexec.h |  2 ++
 kernel/crash_core.c   | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b11d75a6b2bc..e00c373c4095 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -324,6 +324,8 @@ struct kimage {
 };
 
 #ifdef CONFIG_CRASH_HOTPLUG
+void *map_crash_pages(unsigned long paddr, unsigned long size);
+void unmap_crash_pages(void **ptr);
 void arch_crash_hotplug_handler(struct kimage *image,
 	unsigned int hp_action, unsigned long a, unsigned long b);
 #define KEXEC_CRASH_HP_REMOVE_CPU   0
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573c..0ff06d0698ad 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/highmem.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -491,3 +492,34 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+void *map_crash_pages(unsigned long paddr, unsigned long size)
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
+void unmap_crash_pages(void **ptr)
+{
+	if (ptr) {
+		if (*ptr)
+			kunmap(*ptr);
+		*ptr = NULL;
+	}
+}
+#endif
+
-- 
2.27.0

