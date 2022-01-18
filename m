Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A6E492FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349658AbiARVVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:21:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6784 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244436AbiARVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:20:54 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IKEeXe007879;
        Tue, 18 Jan 2022 21:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=IKtghRJml7dROoVgt7NTaYemW9dQC20dDMGSxYcdVG0=;
 b=gzvSOhI7/eiuwu0acx5SQPd+tetoQ7xsAz/kd5atUdwps0xhY3smts53nyHv3Dxk4Ro4
 2rfRNf+UH9yD6577woPRN9ddIPzb4NG4NszbUcWz+nIfLmGBab7/RHihsjFpv2IqFQwX
 agPFS3JWIHHcSnW5NolvPgnfzaN4F6h8KqZBZIsX2YSvMSlVih5Bfdnt7nceUcQeGXFl
 1ZoELs0CE/HKXYBiDFGHVciubJpCWtURdLMPb1kSFnsGnkTjIrTKTkI9SHTxleeDnujS
 e9Arn+kY2S+xxxfg5xzxy3fv22Yv0pZWYV4Y+5vfO7q8cqmMqbqujmrhKm1uRZPPOxOj BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4vk8pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ILKY4k129513;
        Tue, 18 Jan 2022 21:20:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by userp3030.oracle.com with ESMTP id 3dkkcy0wu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLakHh0oPnPVXhzSxTTwUpLnspL/gbLLW1COPJGgJ/Mb7vfQF4TT50di/WCnrgoxFGNoTwQYkTEGDhwJ1j/0fq5+NPoCsDHtCvLLlh/ht1TaMYEwTO+L7FUbKuDQ4EhMwfrq+Q7kG59SGb4VX3rkI/WRupVso+Fo1nCGLgHl4gxaFr1dVAIkP/9BLtS273olKxzlT9+MZ3xVcxLGwhkCN0roAHDHWt8NxNEp2FcyIRhBjdqI/20pqAjzs5wsFXwY30z3fo7TRkxhuv7YAjf5wL/+tNEOj4Akro8H0FzFhGzEAZ+g8v03/OdUGUjneXK4LgpQWw8ZTMa9oF3I2R/3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKtghRJml7dROoVgt7NTaYemW9dQC20dDMGSxYcdVG0=;
 b=lF2lvHo+r39wEGu8KZZNH9QwVbz291orFlTxd46xWlcoj4XzAvR3QSMwsTinbo40eA/p4HETTBtp3YKA9HKGumiI4uW479HxcRHCnbB83BOmleQnZMgBYoxYlWg2Rb74LG9Cuh40Ravr2h8u1JS1LzJDGgotZJMPMFkld3BH4L2ymCbNvSkAmYR5QqtYXKouOrvbrb54NFC5GZGdzspJKJ3IUvC+qlN8IZYVU1/phcffs/034+hkyoL5bE9MSZt3lJbBjnqY49abbPZNCIWT5vPMH8k9fK6ZIce6FQCRd2tMBo+LbQEmNZbcLXI8o69Q92iAbo5loUQBlBwzeZ7rqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKtghRJml7dROoVgt7NTaYemW9dQC20dDMGSxYcdVG0=;
 b=wzeYXstJlKz3WVq1Fw52XUt03V4TalBFdKUbjWUZMGfAk+MffNNfOoYMLHMbDqbn+qenMT3k3vhgVHPAch2CJ4WHgJS6PJKhXP5bpV4Q2XHKX9amuEkM25WaK9iirTxEP9ufbauvlTpNR2vswqXJ6iaj5YaRZjakwtPQ7+znzDc=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BYAPR10MB3029.namprd10.prod.outlook.com (2603:10b6:a03:8d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 18 Jan
 2022 21:20:28 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 21:20:28 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH 6/6] mm: Add basic page table sharing using mshare
Date:   Tue, 18 Jan 2022 14:19:18 -0700
Message-Id: <5c1e369b7620c20d51729acd745f8180c4e2a416.1642526745.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642526745.git.khalid.aziz@oracle.com>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::14) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d915b6e-49e5-4a16-04a7-08d9dac8599f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3029:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB30296DC8F2E66152D9AB5C1586589@BYAPR10MB3029.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tw5tBx/KdZvh8gjhcAdxAqQyjR1STU4ut7NMn84IdYUvagqeKJ1Od1itpPbaGKsqJieCdHVrN4Z2RqERngh3eVktxXNIcqcRRwrBMENfhw2dVxbSIywQIcY6zQy1IH1/bofxgR0Cxs0F1dDp/g/qCfBQ39qWwvnHwXuB0KdiP3g0HHNctSqMMkyjD1xbJPIof1VnQOeVSLnbKDfv61Chud+jCBjM7EmPaSp7O3yz57QNJtLYvdifNnmMqp56sIVqvKIaLZNU/HVuCuIkJLp2AJu12cN8vIGhejVakmbZVkoqQFWtKP8pHUmyGngo+joZIxpT1pQYVEzyjwb8cEujndtRD3tMX5MyrONByainzJKyv5plULMikmgLPDesvdOCr/JqpSiWMrXO+WykkNa+5/KVTy981JKn11DbJ7IRqp0sXrVyCgFYNO5mAwrDAwyYNL2c2RmCU81Gh45CXLiGv9KgAhm1ez8FNPVJw7A31ovVudM2AKzuns1kt6bNYHF5OPaRjHO/jvWH3cR6hZMkxkouKmC9h8h5g3P1Vxo+14HhG8HKsiSW90Ps5ED19t0c3dOZ4bkz1OpvEoPh++x5Z41uOzwpj2tD81QFAi4oBszcKGQ1TJCpgq1SCdTU36/kknOnsYRZU9c/cJ0H3ypT8JCxxq4EuFisMkVd/hRswzAWL0zGPwYd1SC3NsGnuKkori0sMJOphUqnHkqyeaOhmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(38100700002)(316002)(921005)(6512007)(186003)(6506007)(44832011)(83380400001)(6486002)(8936002)(6666004)(2906002)(66946007)(2616005)(52116002)(4326008)(7416002)(86362001)(30864003)(66476007)(8676002)(508600001)(66556008)(107886003)(5660300002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2uHQTlcvOrpcXkOvXkFvb5c/cUNY84QsLW1VgcXkJ/VAuFCldEBa//fz03NX?=
 =?us-ascii?Q?9oMpzpJSkxQASRzzpv2HBfo+ZOj3/AoHMdUSKsxzHDs4nDxpF54s6acXyxWb?=
 =?us-ascii?Q?23bcdO448ZNqvk9x1Aw/VFp/mUrKYK4p9WysP2BmKxupUrHxTJmWU5sfJMbp?=
 =?us-ascii?Q?YmeXRZPCvVFeobVUk7ZTzAK8vOSm4DveYG3s/U6WW7upcH5h9vLQJJ2wprgs?=
 =?us-ascii?Q?3WxOUhqYu66tQPmvLsYNjQ/pg4LF/pCN7mSNpFMGgPbR6IAT5BXShvdemzyA?=
 =?us-ascii?Q?c7ASdyUCQm1YLYwf4ynvinReye8mu2xZlYQJwdytfTL89+KdScSSaYmzsJjT?=
 =?us-ascii?Q?8RzsbA4mzusg/L4Mm+KWgzv7HlsneXKoFahJ0bsssNvIcmxNEb3HS5xnC2mI?=
 =?us-ascii?Q?ZiO9Jpz9uu7H8z+E0S4MyqWJUWFfHwxGSIai6EVoWsovO5K0eH+otVzD4b8/?=
 =?us-ascii?Q?k78wH/Ez+c65ccB6d6llJN83bO0vDfiXxr5Szi4KFxqqbe/m1gls3cZ3f2FR?=
 =?us-ascii?Q?HTIKEfafcku0NLZtzlg1Kux72IiC7Cbxg+9RhPHrRb3WSZ1VkhQgGIhRSWK8?=
 =?us-ascii?Q?lxNZ27eV+tG2AX0Eugvje8WX6Lrer5WLoQ7Vm7MHpXX5/n7BXFZ0rsb5bO9r?=
 =?us-ascii?Q?s/xnd80B7HB3NvVYLIIubtVkv8lw7h06bSw0xKijRpqKl2NdLeZ4P5x5mcWb?=
 =?us-ascii?Q?RQqKXdSW+sptNQvj5E/VSB1OtNcgMlrergzsgiGzDbp3GL8XrDn/hfkbyBsk?=
 =?us-ascii?Q?Y/ld6aXYz7HnGHZSYpdVDWvfPxJQAnoQK5rMJardQD77eBFdLvgdoqCQVkdL?=
 =?us-ascii?Q?lGjdK71OTtoL7ymGdf/5l68OgiTBaXneI8uRzAoTvBdl+Dm1z9SqaFnzdfK/?=
 =?us-ascii?Q?ZX1Fw8gZ0K3y+gzqnI0Mg1wLkxWJO96Nc7bKsmRgR8MU1543GL3leqlZ035V?=
 =?us-ascii?Q?pbjPWcn+Jd62xtj2k4SGG48Sy7czNLVAEuI71Cqwy4ah4cV2lkBnHoO3HeI4?=
 =?us-ascii?Q?Cf1Wvumoxck8QPEEMaNAx5Z1us/LFk4KxU5GrjTCB9P+uNo8Spx/8C5owpmQ?=
 =?us-ascii?Q?i0CkEFBivKVNmQscUqoDfWhA3OgOqe3lZsYTTY29spJERu52GslGGPKe/ocz?=
 =?us-ascii?Q?6Juw5tv3QBM6PdJINBlgygUtVybnEEa5ADqOTIncN9OK9qJMT/AmSZnysHQt?=
 =?us-ascii?Q?CFPYNu8wCXOPriiSe8xMLurWtH05gPrO5Iz/MKclGmMryHceXPgxyK2kd6F+?=
 =?us-ascii?Q?t5WzJDFSlBUeMqZWH3hSakPPZQmfBuQVVcFY1QxAgEOlrs6zJtrBjR5e2izI?=
 =?us-ascii?Q?bfJt8fkvwoLLhuUBTLUa4SgA7UR3CHW+d2oxbNra8ZvD9tAKL40Gq2ckL/He?=
 =?us-ascii?Q?i2SwItF7XJdUIM861JQINTnvIA8OehTNSH2TTsIFMQi7w7VtvXsMfTOd5HXn?=
 =?us-ascii?Q?KI+FpxP4Q7/OzFQnImgFcBKX9gq/AGbV+n82bd9v92RmvHBQYYne8pfpDoBK?=
 =?us-ascii?Q?dxUwIrdfnBPiQ+Fck+MRcqpI6vAVLsy1h8VTnsjUmSFnxN0CGPfT++U+spKY?=
 =?us-ascii?Q?+R1ZabgwRDFREyBBqWlhTphSP38HAZPZcBJ/qSh0N/k1+vXGaV+Mxv6f1lOR?=
 =?us-ascii?Q?Ac4zigkJkkFIdW0N8NXhHPp6J/ndl/qcQFS7aenSUJaZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d915b6e-49e5-4a16-04a7-08d9dac8599f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:20:28.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkO2if1IIbFZWWkZcdSwT5/1euAyqa6YaFJeBcxEZ7B01KTm5Qk3yppWnFbS6/X4zo3HXmDMK8i9GkfeJ+muMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3029
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180122
X-Proofpoint-GUID: 4y36GxPkK4cdn-3CnahSESEsrIt9STXV
X-Proofpoint-ORIG-GUID: 4y36GxPkK4cdn-3CnahSESEsrIt9STXV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic page table sharing across tasks by making
mshare syscall. It does this by creating a new mm_struct which
hosts the shared vmas and page tables. This mm_struct is
maintained as long as there is at least one task using the mshare'd
range. It is cleaned up by the last mshare_unlink syscall.

NOTE: WORK IN PRGRESS. This is only a working prototype and has
bugs and many missing pieces. mm/mshare.c documents these bugs and
issues that should be addressed in a more complete implementation.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h             |   8 +
 include/trace/events/mmflags.h |   3 +-
 mm/internal.h                  |   7 +
 mm/memory.c                    |  35 ++++-
 mm/mshare.c                    | 265 +++++++++++++++++++++++++++++++--
 5 files changed, 299 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..63128f6c83cd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -308,11 +308,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -354,6 +356,12 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MTE_ALLOWED	VM_NONE
 #endif
 
+#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
+#define VM_SHARED_PT	VM_HIGH_ARCH_5
+#else
+#define VM_SHARED_PT	0
+#endif
+
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
 #endif
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 116ed4d5d0f8..002dbf2711c5 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -184,7 +184,8 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_MIXEDMAP,			"mixedmap"	},		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
-	{VM_MERGEABLE,			"mergeable"	}		\
+	{VM_MERGEABLE,			"mergeable"	},		\
+	{VM_SHARED_PT,			"sharedpt"	}		\
 
 #define show_vma_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/internal.h b/mm/internal.h
index 3b79a5c9427a..9bfc4dde7d70 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -713,4 +713,11 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
+extern vm_fault_t find_shared_vma(struct vm_area_struct **vma,
+			unsigned long *addrp);
+static inline bool vma_is_shared(const struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_SHARED_PT;
+}
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index 8f1de811a1dc..b506bbbfae60 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -418,16 +418,25 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		} else {
 			/*
 			 * Optimization: gather nearby vmas into one call down
+			 * as long as they all belong to the same mm (that
+			 * may not be the case if a vma is part of mshare'd
+			 * range
 			 */
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			       && !is_vm_hugetlb_page(next)) {
+			       && !is_vm_hugetlb_page(next)
+			       && vma->vm_mm == tlb->mm) {
 				vma = next;
 				next = vma->vm_next;
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
-			free_pgd_range(tlb, addr, vma->vm_end,
-				floor, next ? next->vm_start : ceiling);
+			/*
+			 * Free pgd only if pgd is not allocated for an
+			 * mshare'd range
+			 */
+			if (vma->vm_mm == tlb->mm)
+				free_pgd_range(tlb, addr, vma->vm_end,
+					floor, next ? next->vm_start : ceiling);
 		}
 		vma = next;
 	}
@@ -1528,6 +1537,13 @@ void unmap_page_range(struct mmu_gather *tlb,
 	pgd_t *pgd;
 	unsigned long next;
 
+	/*
+	 * If this is an mshare'd page, do not unmap it since it might
+	 * still be in use.
+	 */
+	if (vma->vm_mm != tlb->mm)
+		return;
+
 	BUG_ON(addr >= end);
 	tlb_start_vma(tlb, vma);
 	pgd = pgd_offset(vma->vm_mm, addr);
@@ -4757,6 +4773,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
 {
 	vm_fault_t ret;
+	bool shared = false;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -4766,6 +4783,15 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	/* do counter updates before entering really critical section. */
 	check_sync_rss_stat(current);
 
+	if (unlikely(vma_is_shared(vma))) {
+		ret = find_shared_vma(&vma, &address);
+		if (ret)
+			return ret;
+		if (!vma)
+			return VM_FAULT_SIGSEGV;
+		shared = true;
+	}
+
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE))
@@ -4783,6 +4809,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	else
 		ret = __handle_mm_fault(vma, address, flags);
 
+	if (shared)
+		mmap_read_unlock(vma->vm_mm);
+
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
 		/*
diff --git a/mm/mshare.c b/mm/mshare.c
index adfd5a280e5b..ffdc72963b6b 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -6,8 +6,37 @@
  *
  *
  * Copyright (C) 2021 Oracle Corp. All rights reserved.
- * Authors:	Matthew Wilcox
- *		Khalid Aziz
+ * Authors:	Matthew Wilcox <willy@infradead.org>
+ *		Khalid Aziz <khalid.aziz@oracle.com>
+ *
+ * Current issues/questions:
+ *	- mshare_unlink should unmap all shared VMAs for the calling task
+ *	- If a task that had called mshare dies, make sure its shared VMAs
+ *	  are cleaned up properly and refcount to shared region is
+ *	  updated correctly.
+ *	- Should mshare_unlink be allowed only for the tasks that called
+ *	  mshare() originally so the two calls are matched up? If yes,
+ *	  should there still be a way to clean up stale shared regions?
+ *	- Allow already mapped in VMAs to be mshare'd by the task creating
+ *	  mshare region. This will potentially require splitting VMAs
+ *	- What happens when a task tries to attach to an existing mshare
+ *	  region and it already has VMAs mapped into that address range?
+ *	  Possibilities - (1) mshare() fails, or (2) unmap current VMAs
+ *	  and create new ones with new mapping. If (2), what happens
+ *	  if exisiting VMA is larger than mshare region - split the
+ *	  VMA and leave partial original mapping intact, or unmap all
+ *	  overlapping VMAs
+ *	- Can the tasks using mshare region mmap/mremap things into sections
+ *	  of the range? If yes, that will require additional work. Which
+ *	  mmaps  should be supported - anonymous, files??
+ *	- How does this work with hugepages?
+ *	- How does this work with OOM killer?
+ *	- BUG: PTEs no longer work once the task that created mshare
+ *	  range dies.
+ *	- mmu_notifier uses vma->vm_mm. That very likely breaks with
+ *	  this code
+ *	- Should consumer processes be allowed to only map the entire
+ *	  mshare'd region or should they be allowed to map subset of it?
  */
 
 #include <linux/fs.h>
@@ -17,17 +46,50 @@
 #include <linux/pseudo_fs.h>
 #include <linux/fileattr.h>
 #include <linux/refcount.h>
+#include <linux/mman.h>
 #include <uapi/linux/magic.h>
 #include <uapi/linux/limits.h>
+#include "internal.h"
 
 struct mshare_data {
-	struct mm_struct *mm;
+	struct mm_struct *mm, *host_mm;
 	mode_t mode;
 	refcount_t refcnt;
 };
 
 static struct super_block *msharefs_sb;
 
+/* Returns holding the host mm's lock for read.  Caller must release. */
+vm_fault_t
+find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp)
+{
+	struct vm_area_struct *vma, *guest = *vmap;
+	struct mshare_data *info = guest->vm_private_data;
+	struct mm_struct *host_mm = info->mm;
+	unsigned long host_addr;
+	pgd_t *pgd, *guest_pgd;
+
+	host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
+	pgd = pgd_offset(host_mm, host_addr);
+	guest_pgd = pgd_offset(current->mm, *addrp);
+	if (!pgd_same(*guest_pgd, *pgd)) {
+		set_pgd(guest_pgd, *pgd);
+		return VM_FAULT_NOPAGE;
+	}
+
+	*addrp = host_addr;
+	mmap_read_lock(host_mm);
+	vma = find_vma(host_mm, host_addr);
+
+	/* XXX: expand stack? */
+	if (vma && vma->vm_start > host_addr)
+		vma = NULL;
+
+	*vmap = vma;
+	vma->vm_mm = host_mm;
+	return 0;
+}
+
 static void
 msharefs_evict_inode(struct inode *inode)
 {
@@ -168,13 +230,23 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		unsigned long, len, int, oflag, mode_t, mode)
 {
 	struct mshare_data *info;
-	struct mm_struct *mm;
 	struct filename *fname = getname(name);
 	struct dentry *dentry;
 	struct inode *inode;
 	struct qstr namestr;
+	struct vm_area_struct *vma, *next, *new_vma;
+	struct mm_struct *new_mm;
+	unsigned long end;
 	int err = PTR_ERR(fname);
 
+
+	/*
+	 * Is msharefs mounted? TODO: If not mounted, return error
+	 * or automount?
+	 */
+	if (msharefs_sb == NULL)
+		return -ENOENT;
+
 	/*
 	 * Address range being shared must be aligned to pgdir
 	 * boundary and its size must be a multiple of pgdir size
@@ -185,6 +257,8 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	if (IS_ERR(fname))
 		goto err_out;
 
+	end = addr + len;
+
 	/*
 	 * Does this mshare entry exist already? If it does, calling
 	 * mshare with O_EXCL|O_CREAT is an error
@@ -197,49 +271,183 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	inode_lock(d_inode(msharefs_sb->s_root));
 	dentry = d_lookup(msharefs_sb->s_root, &namestr);
 	if (dentry && (oflag & (O_EXCL|O_CREAT))) {
+		inode = d_inode(dentry);
 		err = -EEXIST;
 		dput(dentry);
 		goto err_unlock_inode;
 	}
 
 	if (dentry) {
+		unsigned long mapaddr, prot = PROT_NONE;
+
+		/*
+		 * TODO: Address the following comment
+		 *
+		 * For now, we do not allow mshare mapping an existing mshare
+		 * region if any overlapping mappings exist in calling
+		 * process already
+		 */
+		mmap_write_lock(current->mm);
+		vma = find_vma_intersection(current->mm, addr, end);
+		if (vma) {
+			mmap_write_unlock(current->mm);
+			err = -EINVAL;
+			goto err_out;
+		}
+
 		inode = d_inode(dentry);
 		if (inode == NULL) {
+			mmap_write_unlock(current->mm);
 			err = -EINVAL;
 			goto err_out;
 		}
 		info = inode->i_private;
-		refcount_inc(&info->refcnt);
 		dput(dentry);
+
+		/*
+		 * Map in the address range as anonymous mappings
+		 */
+		mmap_write_unlock(current->mm);
+		oflag &= (O_RDONLY | O_WRONLY | O_RDWR);
+		if (oflag & O_RDONLY)
+			prot |= PROT_READ;
+		else if (oflag & O_WRONLY)
+			prot |= PROT_WRITE;
+		else if (oflag & O_RDWR)
+			prot |= (PROT_READ | PROT_WRITE);
+		mapaddr = vm_mmap(NULL, addr, len, prot,
+				MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, 0);
+		if (IS_ERR((void *)mapaddr)) {
+			err = -EINVAL;
+			goto err_out;
+		}
+
+		refcount_inc(&info->refcnt);
+
+		/*
+		 * Now that we have mmap'd the mshare'd range, update vma
+		 * flags and vm_mm pointer for this mshare'd range.
+		 */
+		mmap_write_lock(current->mm);
+		vma = find_vma(current->mm, addr);
+		if (vma && vma->vm_start < addr) {
+			mmap_write_unlock(current->mm);
+			err = -EINVAL;
+			goto err_out;
+		}
+
+		while (vma && vma->vm_start < (addr + len)) {
+			vma->vm_private_data = info;
+			vma->vm_mm = info->mm;
+			vma->vm_flags |= VM_SHARED_PT;
+			next = vma->vm_next;
+			vma = next;
+		}
 	} else {
-		mm = mm_alloc();
-		if (!mm)
+		unsigned long myaddr;
+		struct mm_struct *old_mm;
+
+		old_mm = current->mm;
+		new_mm = mm_alloc();
+		if (!new_mm)
 			return -ENOMEM;
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
 			err = -ENOMEM;
 			goto err_relmm;
 		}
-		mm->mmap_base = addr;
-		mm->task_size = addr + len;
-		if (!mm->task_size)
-			mm->task_size--;
-		info->mm = mm;
+		new_mm->mmap_base = addr;
+		new_mm->task_size = addr + len;
+		if (!new_mm->task_size)
+			new_mm->task_size--;
+		info->mm = new_mm;
+		info->host_mm = old_mm;
 		info->mode = mode;
 		refcount_set(&info->refcnt, 1);
+
+		/*
+		 * VMAs for this address range may or may not exist.
+		 * If VMAs exist, they should be marked as shared at
+		 * this point and page table info should be copied
+		 * over to newly created mm_struct. TODO: If VMAs do not
+		 * exist, create them and mark them as shared.
+		 */
+		mmap_write_lock(old_mm);
+		vma = find_vma_intersection(old_mm, addr, end);
+		if (!vma) {
+			err = -EINVAL;
+			goto unlock;
+		}
+		/*
+		 * TODO: If the currently allocated VMA goes beyond the
+		 * mshare'd range, this VMA needs to be split.
+		 *
+		 * Double check that source VMAs do not extend outside
+		 * the range
+		 */
+		vma = find_vma(old_mm, addr + len);
+		if (vma && vma->vm_start < (addr + len)) {
+			err = -EINVAL;
+			goto unlock;
+		}
+
+		vma = find_vma(old_mm, addr);
+		if (vma && vma->vm_start < addr) {
+			err = -EINVAL;
+			goto unlock;
+		}
+
+		mmap_write_lock(new_mm);
+		while (vma && vma->vm_start < (addr + len)) {
+			/*
+			 * Copy this vma over to host mm
+			 */
+			new_vma = vm_area_dup(vma);
+			if (!new_vma) {
+				err = -ENOMEM;
+				goto unlock;
+			}
+			vma->vm_mm = new_mm;
+			err = insert_vm_struct(new_mm, new_vma);
+			if (err)
+				goto unlock;
+
+			vma->vm_private_data = info;
+			vma->vm_mm = new_mm;
+			vma->vm_flags |= VM_SHARED_PT;
+			vma = vma->vm_next;
+		}
+		mmap_write_unlock(new_mm);
+
+
 		err = mshare_file_create(fname, oflag, info);
 		if (err)
-			goto err_relinfo;
+			goto unlock;
+
+		/*
+		 * Copy over current PTEs
+		 */
+		myaddr = addr;
+		while (myaddr < new_mm->task_size) {
+			*pgd_offset(new_mm, myaddr) = *pgd_offset(old_mm, myaddr);
+			myaddr += PGDIR_SIZE;
+		}
+		/*
+		 * TODO: Free the corresponding page table in calling
+		 * process
+		 */
 	}
 
+	mmap_write_unlock(current->mm);
 	inode_unlock(d_inode(msharefs_sb->s_root));
 	putname(fname);
 	return 0;
 
-err_relinfo:
+unlock:
+	mmap_write_unlock(current->mm);
 	kfree(info);
 err_relmm:
-	mmput(mm);
+	mmput(new_mm);
 err_unlock_inode:
 	inode_unlock(d_inode(msharefs_sb->s_root));
 err_out:
@@ -259,6 +467,9 @@ SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 	struct mshare_data *info;
 	struct qstr namestr;
 
+	if (msharefs_sb == NULL)
+		return -ENOENT;
+
 	if (IS_ERR(fname))
 		goto err_out;
 
@@ -283,14 +494,38 @@ SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 
 	/*
 	 * Is this the last reference?
+	 * TODO: permission checks are needed before proceeding
 	 */
 	if (refcount_dec_and_test(&info->refcnt)) {
 		simple_unlink(d_inode(msharefs_sb->s_root), dentry);
 		d_drop(dentry);
 		d_delete(dentry);
+		/*
+		 * TODO: Release all physical pages allocated for this
+		 * mshare range and release associated page table. If
+		 * the final unlink happens from the process that created
+		 * mshare'd range, do we return page tables and pages to
+		 * that process so the creating process can continue using
+		 * the address range it had chosen to mshare at some
+		 * point?
+		 *
+		 * TODO: unmap shared vmas from every task that is using
+		 * this mshare'd range.
+		 */
 		mmput(info->mm);
 		kfree(info);
 	} else {
+		/*
+		 * TODO: If mshare'd range is still mapped in the process,
+		 * it should be unmapped. Following is minimal code and
+		 * might need fix up
+		 */
+		unsigned long tmp;
+
+		tmp = info->mm->task_size - info->mm->mmap_base;
+		if (info->host_mm != current->mm)
+			vm_munmap(info->mm->mmap_base, tmp);
+
 		dput(dentry);
 	}
 
-- 
2.32.0

