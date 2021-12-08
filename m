Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B0646D982
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhLHRWQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Dec 2021 12:22:16 -0500
Received: from mail-eopbgr120045.outbound.protection.outlook.com ([40.107.12.45]:25850
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234590AbhLHRWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:22:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuITD7IHr8mpH3MXdMHkerX+Vw3EPZDKI0cFHlAToWKHe3tLusmcQi2LhYxenreBCApS7eP28x/wIC+3ySj7wApk1bw6Lpq1h9Koi6uNGhAEKZAvJzKsQWpyi81IMnNxzLCuNLQ5EOz6W/PQAIGjglnAyo+DFDahPP8lHC4BWgbRLh+0iWy5IChAiDWgqiMQdUKYnx2d3h/VaCDwm+Lm5duFBjJ+cSRUDYoEQb7VPbQuSucPdWZ8qRdO2B9toblT4R26xlrernpXKPwYabzJ6EFUWxUa98pvLxVaOHjVcpjjRB0FwOU+NGmHMimizXLBVame8fDFuw86I6gZT89KRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39FFmOvJEbICLmGjehFIN4rt9ehZmkF/y1NsezPHRsA=;
 b=Juc6gDZEu2PmRYRGJhprsAcbUfTIauOW9Lxx8JP2yEfP81R5fAZ8pCqQ5NHFv3parduSt7AVJ6/g9FRe8H/bPjAZpaDfTJSsk2+AgZXeRq1F97QaA+RdIrmzK6mrCoDyRdHHLr077ILs6l1hszeS8O5VTTGeWoPb8hFDqmMYYc4HH7PKBdt0JBEisnwvsU05e2OOIbs1wszYU/IIFBF7e00v+iElAa6vw+yQtD7Yxd7W9mxwliUJsmbTm59cmvRqTAtzLvmcwUDvB00FRHoVVDgyQeF7CBZ9TPRSIHvyKhVVzy4U9esaC+RZ5dRA9xiqNj01DCd7PUjBQd6dGpQ5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR2P264MB0228.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 17:18:20 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fc67:d895:7965:663f]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fc67:d895:7965:663f%2]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 17:18:20 +0000
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
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v4 05/10] powerpc/mm: Remove CONFIG_PPC_MM_SLICES
Thread-Topic: [PATCH v4 05/10] powerpc/mm: Remove CONFIG_PPC_MM_SLICES
Thread-Index: AQHX7FeY8SQL1cZ4Pkif6fv54TDK0g==
Date:   Wed, 8 Dec 2021 17:18:19 +0000
Message-ID: <fea50feae19a2bca544d7f779a8c81335dcb5b6b.1638976229.git.christophe.leroy@csgroup.eu>
References: <cover.1638976228.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1638976228.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72913f7a-0c43-497b-c3bf-08d9ba6ebb47
x-ms-traffictypediagnostic: MR2P264MB0228:EE_
x-microsoft-antispam-prvs: <MR2P264MB02283EBD33ACF7E1B3557353ED6F9@MR2P264MB0228.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfawERVPxfm9mVwYyZlT+Lu7hl66gPn7iZzyNlp13OxD/wXX23HuW8lhDf4X0kO/XgQdefkUytADIUFEFtuoenSJaxK11a65+fSGq/zlTsjaXujffhKrfJ+phgp/Z3TCvKsAT2pBdjeE3ZoU2U4qe5i5EnaCiqHL1l6CtHYPyehcgZIIncRD5zUAeYaa/z9cfl2cUBkg3b0TgclSrildyHnnGZ5uJKf7Uc6Zq3YIK4vYpN2iGHDSzIUQxyWLRfsFacwjnow4sVeN+UyYnX7Su/6SUpeZBhN16oGENzn9lZfqeJCPXuo5It3qBUzU+JWtbmBzXPGTBC5rvw1OfDYLAYLYGkk7YGpX/2gdrt2WNb4nIrldi/eKYsHznB9Cmm6s4dGlPfIaTUUrca5RP8nmV0znPfAEUAo65v4M4iq8NiClrF++FU5qlfS4lDuL0uvXrXwjIRnioYKGKmql9aq7NM4SVYg0CCX9umSOG+NIugv/Qt5mG4KI1mkRjfkS6JGXhQU8cGTKiyblmuhd4aoqsLZtAspZlrvskKFbr63PEaY88q94VJvjjbOHGY/kv3X0ubvRc97+eJs5mfl19WAm2Bdsr7SYDFsDFYu4msUaVt/8XbjGm4ZO8AD3skHSSYe7UbfbDa1DRC4RalRXDszngSekzMgOdx4PIOqKYjTHm0b4wKqBlAg23S1c17qF5QhEDbsP5Y9YXDtgtKqxMHHUeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(91956017)(76116006)(66946007)(122000001)(5660300002)(38100700002)(66476007)(44832011)(6512007)(64756008)(66446008)(6486002)(66556008)(8676002)(86362001)(4326008)(8936002)(54906003)(508600001)(36756003)(71200400001)(38070700005)(316002)(83380400001)(26005)(110136005)(6506007)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1DF4nrcn3ZEtkepLAmGF5Sxrw7TBLXtsg2BYmzmLpoDJyIbQiyALPIoVMa?=
 =?iso-8859-1?Q?uQDN4aVMwtkt3FWkmMuQf84buHIoaebGgRufkkdz+PHJq17tAGHvFXPozH?=
 =?iso-8859-1?Q?6C7OVRPw+9s+fGX/HY4plGclV+yYM3qA06gVbB1KQv1gGCHpMtjgaRm1BT?=
 =?iso-8859-1?Q?8yX5F3PsNSaTkS4nV09svSCjqsiSXvYEqHsqsPL4gn9qhklw2fL416Y9Jv?=
 =?iso-8859-1?Q?I2uqpeHJ+comyFf0N9+B3IqSQIqbWxDIraXi/XOs7kigJKTqLnP3v//T4I?=
 =?iso-8859-1?Q?kG+xCFi2XaXubj2pMFfi3wVkle7lR3jt8u41xjN/mh/uEOj8mIY5C2A7Yn?=
 =?iso-8859-1?Q?9SsDP1GIlQ3RBnBDQFB+e9GPO66oG63fmKrA8XS0Tn0BZVh6oAbJqhQipH?=
 =?iso-8859-1?Q?ouqQShtHBfYD5I0Gk03l4OYn29oD9qnr4tbSz1TNfnM+YR8iBraY036QI3?=
 =?iso-8859-1?Q?5kLV2aSb1PP0xIn07yadUOHLcdtFqCYxbt9H6JpIYxUohFOcLLLrr0QNGk?=
 =?iso-8859-1?Q?PU+HoJKAhGU3hOGDc9fCjQx9LXewauU6gD6uorqZ98LkG5Lf9gGxD6dpjI?=
 =?iso-8859-1?Q?5XelF7PcUc42mlV0XvdsmPJfPpDcVJoiNObI3nOmCCiEaI+SwwLTuOSH1O?=
 =?iso-8859-1?Q?G8K5wA/qkN2GSOBrFzIzAMrbJs3MQYjQIv+r5EQSH5eLSQM3LUWybNSzMM?=
 =?iso-8859-1?Q?skhBJjFxXZsCfvM9iBZunMzx0j+1eCKWQmdZe++sLhpw/R9dYUd7xmDVW1?=
 =?iso-8859-1?Q?0XKwZLsKZsY48fx5V+enOwrrYWBsrHhBnLw0R+axevZq+AEBNsSpEeFlnP?=
 =?iso-8859-1?Q?8GtFI6SsV9Y94S4UPgbXLTevjJ9t6/r5q3mCWEcvYXP9M0ndjgZTL8tBNO?=
 =?iso-8859-1?Q?EKL+tgaoDUJHeC1ZkvM0YW2LATH4dcuNZp7n0mQZRdEMyJNmMHL4JMh76a?=
 =?iso-8859-1?Q?3qHpSQRIMpCKYHePZ2PwbXFNGzKq8Ie4mKcoBF3M0m+Pt96G1oEg+bPNNM?=
 =?iso-8859-1?Q?eHUL8Im+3Czg4sfgI4CTwqdmj6mOnTmhnjMQMGaQxpkX6ePToeOoNG7FlJ?=
 =?iso-8859-1?Q?IPCA+IUTyo1zR6ksW4y88GnkkUn7lhH26tL0FhFWHaU3EEOKiQEOSSnGwg?=
 =?iso-8859-1?Q?TLpGRGvK2zq/zf5q57FQRmLRWQ6ikteriqK94+bM7DnE409t0PjUtvnD/9?=
 =?iso-8859-1?Q?FsvXKx47ksbfgo2W0LtA6E4umI3Anz+RS+Tl7Zte1l/YMPVNSTsacsv0lF?=
 =?iso-8859-1?Q?nXTmNAGKWsoZ6WxAX/24v2LoWjYXOmIFIKvf6rjR7jDuW5UXwB3vKbpuiG?=
 =?iso-8859-1?Q?tXlsReQkHqI27yUlNyNF4MEl+r+6mD4KHg1PHY4XvvxVq9JUvDbm8dFlkh?=
 =?iso-8859-1?Q?HtB2wMCWc9aYI/78M7ek2WbECGKEtmNlFslKPIubgBLkkeC5cgQhz4xByM?=
 =?iso-8859-1?Q?///EekzQw+/+4+Vo8cWKRS5+V+eNCaIANatZVvi/BUaYJiIRVaOV27f9OA?=
 =?iso-8859-1?Q?/gSAizwP/1xZssNRTA1G6WP32+H1h+eDE6ngPO8rT1ugI9H8c1u9Q1yBVt?=
 =?iso-8859-1?Q?rH8+A3JcMAbY0rgT3ml1izDYfTf7CXA3iGN0C2VswO7Sz/JbmeDUabS2xQ?=
 =?iso-8859-1?Q?6WG6ZJTKVC8unG+O9vwyfPrU7LPqTelCiidYyIk71E505NxlrrneGju0yF?=
 =?iso-8859-1?Q?eaxbTroQsUztAQaCn/fFTeK/HomgUnJvFRkiG3eF9KqfM/uH4e9oMTA9sI?=
 =?iso-8859-1?Q?y0VHgi5CTJrTD9n3PWWLslHBE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 72913f7a-0c43-497b-c3bf-08d9ba6ebb47
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 17:18:19.9592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MFUOHFb3nwndN914Ddx6u7gBN/5ibTkWkDhSvRNc4HYEL+xQit3Rmu8tQz5w6GiT8rIPDaJ+2HyKiOJWheZ1c4WPjW6Anqxk5InSGM5+0Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR2P264MB0228
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
