Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E3A4788C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhLQK2G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Dec 2021 05:28:06 -0500
Received: from mail-eopbgr120052.outbound.protection.outlook.com ([40.107.12.52]:47424
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234936AbhLQK14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:27:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoQLj1n4uD23yVRU+k1i8EukaH8lLs/0WoviHhciKPD5Se65i7VZ4zEqT4ye+8Rn4teKdlIml6a7HOyIbB7+Iwq6H9DFF33zueHn4WE7X5P+3fpHNKsv8PQDXxVOJ6ETKt3Z9u/E9bTiYRM9I/9DeM/CD2lG3TqHGdz/8gU3u0nS34kEaXklvKJZpLNjiTWD+Ei37XdbWB6tgN3YlMLofIrAelFYiMbkSinooL0CCUErOWcf/YiUpOOyljwj0jfxgvtxlGXT4ZQ+zfxocu3sMQYS/2TqxTO71tqVoDepEA7IRzH4PlJ4ub1GgeW3ECEKK0ErC2J4DWHgGnMoblFgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39FFmOvJEbICLmGjehFIN4rt9ehZmkF/y1NsezPHRsA=;
 b=fAg+OcXmW5ujhdm2sUdJkI+qKsPxgT0PKwSzH1xdwQi+ndcKyt+6gkuET680UUN8p6abfUMCTFXJLWEeKcJ+UOwHXxQLvLaLJN/aTCzisVjqtcyMdB48T8YHr7sXQ7xaBzPY6z3QPaJVXk/DAcpOmNJTh9ukNrdoIJGTWv2r2S9qA7aD8QwJ5PJs4vdAjC14ruS5G8vgqAUkJEn41ybz2D90jHx8RQAU0yGKQDLHL+FC81Ey3DYcNne0nUd4N8PZpuODTfIxFD5AcIbgQCA//WC9yCQ3gKPLBjSdWcmMXVion9JUrpGED64dWDfgdoakdz/9P7cXFUmJHccTIEg2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR2P264MB0146.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 10:27:48 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f0ef:856d:b0de:e85d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f0ef:856d:b0de:e85d%5]) with mapi id 15.20.4801.016; Fri, 17 Dec 2021
 10:27:48 +0000
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
Subject: [PATCH v6 08/14] powerpc/mm: Remove CONFIG_PPC_MM_SLICES
Thread-Topic: [PATCH v6 08/14] powerpc/mm: Remove CONFIG_PPC_MM_SLICES
Thread-Index: AQHX8zC9azDg+V7pj0qHryg9Tl75pw==
Date:   Fri, 17 Dec 2021 10:27:48 +0000
Message-ID: <5628af991a438cf96d06df5f40bb945742928b95.1639736449.git.christophe.leroy@csgroup.eu>
References: <cover.1639736449.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1639736449.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63bf9857-ef8c-4c1f-a4d0-08d9c147df89
x-ms-traffictypediagnostic: MR2P264MB0146:EE_
x-microsoft-antispam-prvs: <MR2P264MB014659FB6F314AA34CCE6431ED789@MR2P264MB0146.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w24+gJ3vBvDiLYPnbQ+YhVW4SPltr7LGzVw378mBhH6XZmngzKddZpbiy9Sb4aYdq1tqDwxQNTbKmQuH2n0XAbXo/yOPvSwiNsnt4aEfLdqbviNNnQkq4uc91NomOAoCC1n/wg58PNrPIqHgMmDX//oOWQ4/axKhuKxgCikYmSa9t4iEA0zvXGHOm4SWeix8S+AVQhyZxg+KvWFzdHAEJHy/YolbsDBUyH/Do9TCMosyCyEYYdiElv3pNMmH8GgLf7r1s8fkNcoBwVvBoACvsn/GyECqV5jo8ZsigJT31qMfxEUsQAC2cRIwZaPsFUCA3fX371KsAoKXy1AF0H9J+J7tt34tHC+FMtOOgzufRcp1Hw1wC823uIGsbf7kWtILb4+QqvcLPdjGJuhh5u4p6fBusg+gkuOzaBOQRso8O8t7Sc5Upm/Qk5qjuVLmHwIS2CvBAXDMjPhliHeOlJaMTV+weCsvn3mNyQPtVqhAdcY1GsPoHJfLV2JEKTRZdgMxx/LrlI0EFXPw/svksIM09GTuyuyWGq4CynhVzGI/3RuacJgWZe4aAyYRu3siNKtn47D94mVxLtIYADdxlbdg2cBkMOvsjeyE1wIArsgaS9Y4dcyM5zvZibXyJOkiFKrEM6UJgr1AFv9Ve6ngDbFIT13MxRwUQo+LtrlntUTjzhP5RfESEOSl9yx3wkfFxaP8c2Ej5ECA+esX+1fDNPqd5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(91956017)(71200400001)(86362001)(83380400001)(66476007)(66556008)(66446008)(2906002)(64756008)(38070700005)(7416002)(44832011)(6506007)(76116006)(4326008)(36756003)(26005)(2616005)(5660300002)(122000001)(8936002)(38100700002)(508600001)(6486002)(54906003)(110136005)(66946007)(8676002)(316002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GCMrwfus0uM3b0MtByzAtsyo0yqux+jKQvHtqLQznQoBQMyCrMd9ZID7rP?=
 =?iso-8859-1?Q?jJHEsZlxn8lz6JOmfR5h4liJ1Ei8i20WNz4hzJ0Qa688ClnlTNeADgCuFz?=
 =?iso-8859-1?Q?7XywPlrlwTrVBzBTsx+rSAPoMiNu72IEndpiU368wgpUmMJ1BRto1hMfj+?=
 =?iso-8859-1?Q?9eBs9rAfgYTNYXVQUCBWF59DlE0IyUnOujJBrPPfh2nUFvttUGfsjAI+wT?=
 =?iso-8859-1?Q?jTstSURakX8Ig+yvgMXQtHkpnpYMqJEzf+P3Qupn1w/3OfCbAu60QmVNBk?=
 =?iso-8859-1?Q?vjbyUwU3NT5IPnUBsPTSqCO8X4lBcrsw1UMeHCyhSGc9xE4nEZivJsydQZ?=
 =?iso-8859-1?Q?o3j4Qym8Zqo568wJ610SU2FK15xei33kJYwdMlUGLJwHf6HdnggK6W9X4N?=
 =?iso-8859-1?Q?7Xu+ZSYyRZrrjr/HGT0eV7hGu1OjC/eipCI99qiqJh45Qj7Io6yfokfing?=
 =?iso-8859-1?Q?svxnbuw4FULPWiOgnBunkfasFvM739lBH75mC2KOTyObiqtCBfhOYYIVA8?=
 =?iso-8859-1?Q?l4nUrKh5ziCz897H6J39QXs2h+OpuXAgXm6SU8YaF2qOHyosOHvY9h7LQ/?=
 =?iso-8859-1?Q?rqLTb5YRjSdC2IG8G6lsjy30MN+tWdTwION8Aw7UqqYB6Tqev/e+7V6Cyy?=
 =?iso-8859-1?Q?O7iSExBopzVNt0wJNjP+Vjc39mFL9cY21kj0feVuVsC6dK1oJp72yu1ZvU?=
 =?iso-8859-1?Q?ibqJPpFpf7XgE8W13q3VUb5FngoK2EPCzPfc/EC4iMtX53NlLx/eQAQu+0?=
 =?iso-8859-1?Q?J+63m4IQd6PJdla9ffb5Qa4sOsfH9BoUMYTlIja2H2VjwwouGEaUhg1vWi?=
 =?iso-8859-1?Q?xecLiqjhPuFZTjlBVDjrLvH5YGjnu2eWa6Rd/p7YfwnHZxYHzelqiotvyN?=
 =?iso-8859-1?Q?vXVKsoMcU58Ek09VAdWX93119EYwmnu3wWyQjUyKmKsap+ZultVceDauH+?=
 =?iso-8859-1?Q?uJLW7E0iXQlz/MxO7k/1wOXq0Az+dQ4/k8lfnRyBiLzTcAnDXJcih2FD+I?=
 =?iso-8859-1?Q?V2ISZL8aqCmptfjANqkQmvUV/KUzoBfOKdVUSOtvstgdlz6rrSEOQggjlI?=
 =?iso-8859-1?Q?6Xvn2Vi16Wu+YsV4luWGzs8g3iSQu5C3aRU8D863rif1/H6bpWffDi1KrZ?=
 =?iso-8859-1?Q?9BwbgHIdyB7mlOxAGP6rnDgnoBgwrKS6pD1qjueeVHhoFj71bQE17xbK2C?=
 =?iso-8859-1?Q?BOTH/X7fIj3EQmxLoBELkTVb9DdRy4g70WzU5fVvR+wcWSw3bes7HJEA9U?=
 =?iso-8859-1?Q?P8MV/wbXDKndoK56fTB+UriZriH+xBRp5OQYVtEbpZUXk0cYra/9/MBcC4?=
 =?iso-8859-1?Q?2kKxJ3EMuUDUClMI8e40CBS0fTdd46GU9fH9Z2ANPcpFbyWtHIr2WIZi4K?=
 =?iso-8859-1?Q?m+82B2bWDR9IMwPoDpl4xmNUMfALRXzZI4MTS5M6xVEYtYRmqia9sXmD8i?=
 =?iso-8859-1?Q?/EpZhlTt8W4N4ePnAa8MKQodrOLo8xT2No5tkvHTXEGacV63Z2aWAnDnF/?=
 =?iso-8859-1?Q?Ly7VYuR2tHRs1eE/IolAO1wwpwO4y/OmfeLZ6HjViNxOvJdPuLGo0gjNTe?=
 =?iso-8859-1?Q?ZQvZgUKXKxhBT9tS0kDysTl8LDpG0SUkNAzjlpP8Aua6APBSjZ2Z70ZUl2?=
 =?iso-8859-1?Q?gjmG89+eHBPyg01mzaciOaz2qLO+H1BFB8I5g1rdi9bBXcdD0HlxxdNdg5?=
 =?iso-8859-1?Q?OU3HZ7q2Ys15p1Jwh0oDqjqZtjJUlLAd6UXmqz7NfR0AFCuElDUCrjAKZJ?=
 =?iso-8859-1?Q?1yE9SZFrjrvWgw39cgsKDwTK8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bf9857-ef8c-4c1f-a4d0-08d9c147df89
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 10:27:48.6346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5CO/SMK7sTLP/QelzLr2ae8Ca0DLwEwSTFwJ6Oh9YFx/8rBX8rk76WGVUqT+Rl6Q5rwt3y4GhaChdh7zZNQWyioJuBMjelAfdRLwDTvzmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR2P264MB0146
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
index f18c543bc01d..86a60ba6bd2a 100644
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
index eced266dc5e9..7ecadf5e6bf9 100644
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
