Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7029495C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349385AbiAUInG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jan 2022 03:43:06 -0500
Received: from mail-eopbgr120077.outbound.protection.outlook.com ([40.107.12.77]:60063
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1379642AbiAUImm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:42:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kzv8/u7dDO+h0Zv91mJp2bjHy6aZqfquSj7oKA9GhKsS/6RdxRjkntBIWfH03FFzN9cr5fOUEa+QNITjWMx4np0+vzKSUbASp7hMH1N3bzElkJET3dzDkJUNpEoZojcRRDcC68r7aKF3zCl38HI5kM34aRStfJf5foH0FMtkVxT9/8+I24xVplYs8lkNvT21mJ1TJinC5SJDGz5WjV/6SjdiVRxiJNb/PuJIUB2Vd/a6Qmdcu7aaWJd/Lfhi1ILZGH+Dj3+3nqzNsUWt1/BqjHYy6LxCbLLdZ+wv52xe0NbgV/J5+yBu9U/yZ0tjwWh8VQ3MsOykdD0k6ff9Tti1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4ZMB8Vck7S3/jJgq32uH59oM26CdkGvYggP93rU7ZM=;
 b=Hve2v48ZAsgr+62WKfgTuXLVK8UUvOyNybQMWDUN6L2AYvSqkhdAX3IxJ2AmJmMkonqxXCFYXpdQj9lFjXRbURBQv1zZci1CYMoq0s5IIqvaLDMQpeRS5q6QhBevhD8JAb9iBSbpIBsnoqhrcpsHS5PJ4Ns8jLnu1zK2qJlDDTTq6G7FOYBrLWhstQ9pTL3dPUrzR0xUePT+Ar4v7OkxlkNESOjLFEjf/5Yr4TICWgUwVSnNbflXIGWe+ApVTEnhk7uYzSg2IIGm30FDXgEPSlWhy8XWS3KQKup8QX2WjsX9LVjHVox+sw9XVR1zhu2jds+3LwYJYBF1h6GW2jZ+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB0201.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 21 Jan
 2022 08:42:30 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5%5]) with mapi id 15.20.4909.008; Fri, 21 Jan 2022
 08:42:30 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "alex@ghiti.fr" <alex@ghiti.fr>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v7 08/14] powerpc/mm: Remove CONFIG_PPC_MM_SLICES
Thread-Topic: [PATCH v7 08/14] powerpc/mm: Remove CONFIG_PPC_MM_SLICES
Thread-Index: AQHYDqLThRAIxqIg+06VQTsoIjJELg==
Date:   Fri, 21 Jan 2022 08:42:30 +0000
Message-ID: <3e4c787053bfe6f9d566711a8fc486d7235334c5.1642752946.git.christophe.leroy@csgroup.eu>
References: <cover.1642752946.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1642752946.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9ffe691-3a38-4df4-c949-08d9dcb9f626
x-ms-traffictypediagnostic: PR0P264MB0201:EE_
x-microsoft-antispam-prvs: <PR0P264MB0201426CBDB560E1EF6FC27AED5B9@PR0P264MB0201.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6b+17K8DTYd/5xLQJY0NakDLf0+tOTJAzBwkxpsfKnmWBtW6fntv4YW2xkjT/hZ+kXjTXCF1AqGnFYzJBjAp4EfteDVmW1tV9CVcb19nlBsexZGm5jo3SKzXyxcd26b1vK1J5Vcy4QIAnyw4ogZGNbCazKIUJh10AmaAfoiwAzheYKUszWCQ5zNV3756/n7bxbVav5GApU2szpvRWlCnut4hs3YAmYMcSuzZ6XIOwHkXnzetFhrCXFsU7Le+1P4c+oWsax0WdRvscnfL2pRAASsHhwI+QbX7itlCIWCIauEU5cfw7OrfIidUFsh/H7DsQNpQcS0dWdS8fUnLkAy4yivs16bouc8zKlgnx0EF/C7O1z0ZzV7zd2yh1bKoo4JjGzqu4riCihQkucdPITVU3sgld2jYwM27s50fUIszD4misAprFrM3xP8dUq484pvjg6SOIK2nf7E+5I7/noMlzSJxDW9CKYzVAqYZ918g4v2UR3u/EoNluKrr6w0nEVLg3XHhmwGd+b6sXNkHOcVWWK/+m1ZbuGfd26H4l3UQsCelqOtWt0Y0SAWs3OJfijWQwW09AF28YvkTONFExMq8/Tp3wmjjxdSSMUTJlP+6hSTkTcGoeLWVS+KIi8/YYSPhv+4VxlxP0+PRHBl2VxUpf7252vjwPkcqhffiztL5wA/VzXn3xpB0z3t1hL1utSoTqpWlo9M/cLSo0fL2J3Prgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(91956017)(36756003)(66476007)(2906002)(5660300002)(66946007)(8676002)(6512007)(122000001)(71200400001)(8936002)(83380400001)(66446008)(64756008)(4326008)(66556008)(86362001)(26005)(508600001)(6486002)(54906003)(2616005)(44832011)(38070700005)(6506007)(186003)(38100700002)(7416002)(110136005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GqMOABsgUHgTGLkPVdh7LHqzz8Cvr8ILLDfwlp1P8rnstpMkj4t4EgwLnj?=
 =?iso-8859-1?Q?DS5mYWpx69+qpBiCrzn102g1gbucqmjvEkArpvp7vLqjvmpN4TFMWKZShX?=
 =?iso-8859-1?Q?cXMgBVD8UeOeQfNEy7qXilQa0qOq18Yjv7AwCVzcaP2rKVrmLQ/svFRDbL?=
 =?iso-8859-1?Q?dwht5cLc/BkvSpo+8a1fPPxklP9p/DiqnWEQBu7cr1p4p5PRRgGgv1XWJm?=
 =?iso-8859-1?Q?VH3nmCYGlfLQBqmkpkcSe4u2+MGiIBJaArSZSo5u79Jw7oeePdEsz0sTol?=
 =?iso-8859-1?Q?3TMywB8DOeLfMhybydL+f3M/YxdfnpE2+ublzRVM7TdIFfFbk2JSYWQwvL?=
 =?iso-8859-1?Q?lodKIFo0Vstssg3DWNL7jjn6qthQVlF9Z7Q39MrM8sO1E7PvMqEK+ElKSy?=
 =?iso-8859-1?Q?s11dGkITSqSl0KTAm58zDMtVPGEdYMFXB831WJ00s/iT3q2OvqoEYWpzpz?=
 =?iso-8859-1?Q?e+C5Ht0HDnmBuaT+NDRBp2YO19pfppvc7VNUjKXf8xWBmAccc705pB44rg?=
 =?iso-8859-1?Q?LxYn+UG+Ex5Cjx7+0hEWx5CUnLytqjGlnU+GmmoU2MC3FN3+nRSs7xuaTH?=
 =?iso-8859-1?Q?We++N8+10H3gyOizbg+pMb0GZfP63aTJ9V+Y4RAqcRMNRADaqvxDmf/sWG?=
 =?iso-8859-1?Q?N0nZfPbla3BLXfF8c21My6a0QtyiOoIpG3suIK4RgogWb1FkOgk+zJUDjF?=
 =?iso-8859-1?Q?PtoBflibWP6C7x5B16C84DxLEgtgJAhGRfuW6cPOf4WEv2hoPTMIq6+fUb?=
 =?iso-8859-1?Q?4ySt3ACi5LHUbpqejT/h5c32wHfLLJhV3l5fTxsHKDjcZMhixSgRU25M8P?=
 =?iso-8859-1?Q?3oi5O3dtTqN6PRj7DcGcPsZtISmrTr95fRo94Piu/BPSi40trbOeQ40jzy?=
 =?iso-8859-1?Q?9wT85ZB5OnlJKflAOhMzsb7HPtsUmH3mLUv4ZGH9lkQj6baj0RlGfAtNzb?=
 =?iso-8859-1?Q?iB9ff/betwCMBWnxeelyUaxJThCGIgImObudAW6Z5ZmNqhZBFdW2Ata1FW?=
 =?iso-8859-1?Q?IQj0hl6Rx26zdESug6h924+SArjQNzhJ45xbXvUDyf7HSdszVCTAUqgl4L?=
 =?iso-8859-1?Q?T6S3me6EwUdZaVXVDPUn+HAtGFzukoDqgML6Vc0HZ1zQ8AhwxDJHsAWZBP?=
 =?iso-8859-1?Q?N3IzKEaPJYRl7Px7Gkvy1P/gx4KDnsu9Gv5syCcCxGd+vX4wD64lw4ikwT?=
 =?iso-8859-1?Q?kDjJth5sZ4lj8Q2BYPJh706ohJlu/pjpdaHihUmNoL3FGGmP+oV8MWMN10?=
 =?iso-8859-1?Q?qbhJhdDQZCqWcNjlIHlyVXRb/KAnQ1c+v37Jt8R77NqrC7Wlt131QcBEl6?=
 =?iso-8859-1?Q?7b0mrEOj6iJ7IN5QmAt9xEjaFtB2N6A3o36toS/gxpeA+Ww1vccrPfHasN?=
 =?iso-8859-1?Q?egtmXWmJo/F9uk0qXPGlKuTsn+MhGC7Ey+IbcasFn0TAb3t8K3kd+9uAJV?=
 =?iso-8859-1?Q?P6FVu+XN9ZATTSESGqUI4x+BraptCMddyf4FJMJn5K86+Q5g0fcGtTZ5Rc?=
 =?iso-8859-1?Q?I5dXiF7WtYY8Gua0UYifZz9Ch3zeG4L+p393oFJt+yYx2No/NeW+FTdMiF?=
 =?iso-8859-1?Q?RHGBJzo6PDYLLsERmhvETaSV536TVuo3wP3pZeDfw9vUL8gA4Kb3Yq5nVe?=
 =?iso-8859-1?Q?W14z37Y/StQEcnk6eDsXCef+UKp0WhJ0LubOALQB8xwszOqyaokYf2N9Zg?=
 =?iso-8859-1?Q?6d4rc7CqUvyDh3EW6lkZ5GUNqcyX5Lq8F/pdFnlxzhiN26qMg9Vs2XYBw+?=
 =?iso-8859-1?Q?jqHfLY6wW67t39qmxCGaIWbbI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ffe691-3a38-4df4-c949-08d9dcb9f626
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 08:42:30.6120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lD6UlRQum4o89LyJzxfGlpiWXLiaqTuAx7pIyfz/dVEK2wPscf3jP+DC0sWJI//dcD0cmUfztSE1jyk3UhKDtJv4ZSGRsNiQDlFrl06AMXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB0201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PPC_MM_SLICES is always selected by hash book3s/64.
CONFIG_PPC_MM_SLICES is never selected by other platforms.

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hugetlb.h     |  2 +-
 arch/powerpc/include/asm/paca.h        |  7 -------
 arch/powerpc/kernel/paca.c             |  5 -----
 arch/powerpc/mm/book3s64/Makefile      |  3 +--
 arch/powerpc/mm/book3s64/hash_utils.c  | 14 --------------
 arch/powerpc/mm/hugetlbpage.c          |  2 +-
 arch/powerpc/mm/mmap.c                 |  4 ++--
 arch/powerpc/platforms/Kconfig.cputype |  4 ----
 8 files changed, 5 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 962708fa1017..46e0b9dc77bf 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -24,7 +24,7 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr,
 					 unsigned long len)
 {
-	if (IS_ENABLED(CONFIG_PPC_MM_SLICES) && !radix_enabled())
+	if (IS_ENABLED(CONFIG_PPC_64S_HASH_MMU) && !radix_enabled())
 		return slice_is_hugepage_only_range(mm, addr, len);
 	return 0;
 }
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 295573a82c66..bd4dd02e61c8 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -152,16 +152,9 @@ struct paca_struct {
 	struct tlb_core_data tcd;
 #endif /* CONFIG_PPC_BOOK3E */
 
-#ifdef CONFIG_PPC_BOOK3S
 #ifdef CONFIG_PPC_64S_HASH_MMU
-#ifdef CONFIG_PPC_MM_SLICES
 	unsigned char mm_ctx_low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
 	unsigned char mm_ctx_high_slices_psize[SLICE_ARRAY_SIZE];
-#else
-	u16 mm_ctx_user_psize;
-	u16 mm_ctx_sllp;
-#endif
-#endif
 #endif
 
 	/*
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 39da688a9455..ba593fd60124 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -344,15 +344,10 @@ void copy_mm_to_paca(struct mm_struct *mm)
 {
 	mm_context_t *context = &mm->context;
 
-#ifdef CONFIG_PPC_MM_SLICES
 	VM_BUG_ON(!mm_ctx_slb_addr_limit(context));
 	memcpy(&get_paca()->mm_ctx_low_slices_psize, mm_ctx_low_slices(context),
 	       LOW_SLICE_ARRAY_SZ);
 	memcpy(&get_paca()->mm_ctx_high_slices_psize, mm_ctx_high_slices(context),
 	       TASK_SLICE_ARRAY_SZ(context));
-#else /* CONFIG_PPC_MM_SLICES */
-	get_paca()->mm_ctx_user_psize = context->user_psize;
-	get_paca()->mm_ctx_sllp = context->sllp;
-#endif
 }
 #endif /* CONFIG_PPC_64S_HASH_MMU */
diff --git a/arch/powerpc/mm/book3s64/Makefile b/arch/powerpc/mm/book3s64/Makefile
index af2f3e75d458..d527dc8e30a8 100644
--- a/arch/powerpc/mm/book3s64/Makefile
+++ b/arch/powerpc/mm/book3s64/Makefile
@@ -5,7 +5,7 @@ ccflags-y	:= $(NO_MINIMAL_TOC)
 obj-y				+= mmu_context.o pgtable.o trace.o
 ifdef CONFIG_PPC_64S_HASH_MMU
 CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
-obj-y				+= hash_pgtable.o hash_utils.o hash_tlb.o slb.o
+obj-y				+= hash_pgtable.o hash_utils.o hash_tlb.o slb.o slice.o
 obj-$(CONFIG_PPC_HASH_MMU_NATIVE)	+= hash_native.o
 obj-$(CONFIG_PPC_4K_PAGES)	+= hash_4k.o
 obj-$(CONFIG_PPC_64K_PAGES)	+= hash_64k.o
@@ -21,7 +21,6 @@ obj-$(CONFIG_PPC_RADIX_MMU)	+= radix_hugetlbpage.o
 endif
 obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= iommu_api.o
 obj-$(CONFIG_PPC_PKEY)	+= pkeys.o
-obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 
 # Instrumenting the SLB fault path can lead to duplicate SLB entries
 KCOV_INSTRUMENT_slb.o := n
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 7abf82a698d3..154a5a860959 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1264,7 +1264,6 @@ unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
 	return pp;
 }
 
-#ifdef CONFIG_PPC_MM_SLICES
 static unsigned int get_paca_psize(unsigned long addr)
 {
 	unsigned char *psizes;
@@ -1281,12 +1280,6 @@ static unsigned int get_paca_psize(unsigned long addr)
 	return (psizes[index >> 1] >> (mask_index * 4)) & 0xF;
 }
 
-#else
-unsigned int get_paca_psize(unsigned long addr)
-{
-	return get_paca()->mm_ctx_user_psize;
-}
-#endif
 
 /*
  * Demote a segment to using 4k pages.
@@ -1710,7 +1703,6 @@ DEFINE_INTERRUPT_HANDLER_RAW(do_hash_fault)
 	return 0;
 }
 
-#ifdef CONFIG_PPC_MM_SLICES
 static bool should_hash_preload(struct mm_struct *mm, unsigned long ea)
 {
 	int psize = get_slice_psize(mm, ea);
@@ -1727,12 +1719,6 @@ static bool should_hash_preload(struct mm_struct *mm, unsigned long ea)
 
 	return true;
 }
-#else
-static bool should_hash_preload(struct mm_struct *mm, unsigned long ea)
-{
-	return true;
-}
-#endif
 
 static void hash_preload(struct mm_struct *mm, pte_t *ptep, unsigned long ea,
 			 bool is_exec, unsigned long trap)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 0eec3b61bd13..f18b3a1d18f0 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -558,7 +558,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 		return radix__hugetlb_get_unmapped_area(file, addr, len,
 						       pgoff, flags);
 #endif
-#ifdef CONFIG_PPC_MM_SLICES
+#ifdef CONFIG_PPC_64S_HASH_MMU
 	return slice_get_unmapped_area(addr, len, flags, file_to_psize(file), 1);
 #endif
 	BUG();
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index c475cf810aa8..9b0d6e395bc0 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -190,7 +190,7 @@ unsigned long arch_get_unmapped_area(struct file *filp,
 				     unsigned long pgoff,
 				     unsigned long flags)
 {
-#ifdef CONFIG_PPC_MM_SLICES
+#ifdef CONFIG_PPC_64S_HASH_MMU
 	return slice_get_unmapped_area(addr, len, flags,
 				       mm_ctx_user_psize(&current->mm->context), 0);
 #else
@@ -204,7 +204,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 					     const unsigned long pgoff,
 					     const unsigned long flags)
 {
-#ifdef CONFIG_PPC_MM_SLICES
+#ifdef CONFIG_PPC_64S_HASH_MMU
 	return slice_get_unmapped_area(addr0, len, flags,
 				       mm_ctx_user_psize(&current->mm->context), 1);
 #else
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 87bc1929ee5a..c775b566e7b4 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -376,7 +376,6 @@ config SPE
 config PPC_64S_HASH_MMU
 	bool "Hash MMU Support"
 	depends on PPC_BOOK3S_64
-	select PPC_MM_SLICES
 	default y
 	help
 	  Enable support for the Power ISA Hash style MMU. This is implemented
@@ -450,9 +449,6 @@ config PPC_BOOK3E_MMU
 	def_bool y
 	depends on FSL_BOOKE || PPC_BOOK3E
 
-config PPC_MM_SLICES
-	bool
-
 config PPC_HAVE_PMU_SUPPORT
 	bool
 
-- 
2.33.1
