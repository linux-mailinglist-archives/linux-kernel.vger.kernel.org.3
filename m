Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20BC495C32
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379623AbiAUIoR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jan 2022 03:44:17 -0500
Received: from mail-eopbgr120077.outbound.protection.outlook.com ([40.107.12.77]:60063
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1379625AbiAUInB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:43:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+Kyvz1CW6FHjb5CKxfXYIFXDKyuQ9xh5bK48M45PncUSVJRFVFBgpN/MelvWCY6K5k+2R9jpZHYniIvTkRzFf66l38uJBgyl2bhFkdSTE+zma9fVW8/4zO3GLOdEnMDsdp5Rc27IJpqQcrD/Ut8N4kx5S1UlFxjpkAFG80wQpJjFIHFg/RNkMsql7uYgEFQvCmH2irKsHBtq9/c49zvUyrpaKkEDtqAmiwxjKHt8DqQTz1ccEymZ9kjMPEEF3be15LOW3n9LQywNDDGGSLOcKtH8W/uqerii/0DKmfo7tivOqZ4mj0Mgoo1f3Q69rGOYF5mldJhFmVAbGhCB+eYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R9HXl3qYoGwoSieVkCnAD5XaAJlrCyaK/qBHE9jM9o=;
 b=NGowRYhyNpcTMfMK3cnTDqVwjaJDziyTZRDiQLhcY8v04eFKPbEIu9E0vMTzKwwmb8oWC8UdYteCHRnzNUrgIniYaD4bXkoeAe/fw2SfyiWl+C6pR4Lu6qgUHGqvpFGy2jRklC8AlnoMLirNKk8Nqsqv83d7J597ofxjrx0QcoC20WGD43NpD4YdcwcG1ZKL6LcA0mOVK4ywe+pB/oF15wdFpFG/Qp+Qj7cob+Q/nkdyB+p6I5VRTYfmltuNlkc9QQnLBAD5Rl2tyZ3LGSD8h0gkLFo8X+evHqYQZfpQmXmfRIDtYseW+I4/0tMaHEdT9Sy2hZ6IZloOWepxaZKahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB0201.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 21 Jan
 2022 08:42:33 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5%5]) with mapi id 15.20.4909.008; Fri, 21 Jan 2022
 08:42:33 +0000
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
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 09/14] powerpc/mm: Use generic_get_unmapped_area() and call
 it from arch_get_unmapped_area()
Thread-Topic: [PATCH v7 09/14] powerpc/mm: Use generic_get_unmapped_area() and
 call it from arch_get_unmapped_area()
Thread-Index: AQHYDqLVm5veIrfhK0GUQ6geY45hSw==
Date:   Fri, 21 Jan 2022 08:42:33 +0000
Message-ID: <d31a52e296a4cead876165158bce415aac3631bb.1642752946.git.christophe.leroy@csgroup.eu>
References: <cover.1642752946.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1642752946.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19fad9a6-63e4-47fa-1fe4-08d9dcb9f806
x-ms-traffictypediagnostic: PR0P264MB0201:EE_
x-microsoft-antispam-prvs: <PR0P264MB0201E707EEE5A6DE901FC782ED5B9@PR0P264MB0201.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kS0v/eP8lnKJxpNHH05Z3vXZLeNmHaltx4fNWVRvAnvgZNkXEBrefXqiXWUvFyJhMu7c2CDCyriykSCsSpNBBbm5qn5dKWx6x71EddjxQL9Lt/9BUb0mMqOJbPybx5xds4IBv5yJ+FJwAXXpcuHtLoSnbgSh+vN8ga7gXSAUKUYjKU2LjlWvrIgMGKHK8ZJQ9enwZrXwKv7ldlGKUisLG1cYuXAnx0GW7gE2rkb76kcGDXnv9uMRFF7Ds0jp1lE99tgV9UzkjP7U0G4IEhMfCE9qLOtsRm0zcxiLbqS7T1kZX1oRfsmkiK4sSz79Gu2VMGUQMBxJDVd8I120xKgBKjdqeFVeHuMi4ev6HIAXllOMcVFhZ5ulNx6aN8nKQNRhJy3WrbVLF439p6W3N6sXu0Azm3G+j+iy/s8rcvxEwScCWjfK2/oYdMBty9X+kb9RgTaNsytxOwwS7lUbqIu0xc8DT7z0AsECHQP/H4H+eAfc3w9lDu4Pu2BNjKeGm7kDSyy1ro2YL2EJw77uFY6VjVIDDw8cUmBl2BfOLyj8mrjablKDwHKiO2bKLVtrS7vMCFUTn3q3ts47aSrzDOWIowMD0bEJ7sovAOUKU6kT+oQ5fUILdn/yHYIdzJ3CSWcBo4115I1HEJp3AxTpNv+uoW1FUyHoJ2pLcOjTLUE9ggvDBKouNFXdKSjFXUPCkuueq9mJJM+fxAF6XJXWid3i97xrTclfNl2OLWP+b5B0hvw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(91956017)(36756003)(66476007)(2906002)(5660300002)(66946007)(8676002)(6512007)(122000001)(71200400001)(8936002)(83380400001)(66446008)(64756008)(4326008)(66556008)(86362001)(26005)(508600001)(6486002)(54906003)(2616005)(44832011)(38070700005)(6506007)(186003)(38100700002)(7416002)(110136005)(316002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ia+kquVdA8s2z6JirQGURGls6h3XGqet30Chvjw+FGdDpGF90fms556Myk?=
 =?iso-8859-1?Q?7PUWSe0B0UXIb5tIm4uKJDUmIwzHJcfKDFPok8c/y/QXEBl1ovE7fWQnGK?=
 =?iso-8859-1?Q?8rh+uXq0YSRVeTsUOVuy5oaoAqXkgIOjg31gAJ8FSdbBH67cLOEJDR12mF?=
 =?iso-8859-1?Q?TBs0McmQgNtLtFLvzdMpbfs1A4cLWiTmnu0VeJFDeAnb74tS4JtpzuL7+v?=
 =?iso-8859-1?Q?jKErX0HqjcHWeUhI1hwUN4HbhAbe1sIY/A0e8ZqS6jXJBTMLxR5Reh8CRl?=
 =?iso-8859-1?Q?aSwBZWhdPu4DrqKaxOFTRDmrKLMIXl3zEDviM1wobscX08Hq0c8OVP+hHp?=
 =?iso-8859-1?Q?1fcxZKZs2y0vUXOHquVXlxNTqqaHAw8El6iae1ktySuzq909eG9woVa7Jv?=
 =?iso-8859-1?Q?aPBUNE06xqbLfgO+YBJiffyNvSY3J2vhCpgeSLqSJjgAWuAAegNZ8F2B0f?=
 =?iso-8859-1?Q?GiTaJS+ZmcGae1LtLNugqUZZj5oX+T/H3IpN0nNGVhlJ1CVUOLavStMvot?=
 =?iso-8859-1?Q?QrjqtrSgvuO62NDIh6IKp1KEBaU5eJK+/VbY/Zr64zbXCWl8MWykSaVNy6?=
 =?iso-8859-1?Q?qXiHouH2U0nZPYubSQjOofEVz4mnxXjXwc5Y05NH8f4KOZy0x7h4A4jOyh?=
 =?iso-8859-1?Q?NtkcnRsge1O86bQPazFyvGojFxA9qjf09ZddI5actE04ZL1Y7/ZmJ4/gH/?=
 =?iso-8859-1?Q?E+53xoFX60Rp6Ftq1/FiEubZuFRezdQy1i2VbM035n7Z8u1CqPi0uRdCS1?=
 =?iso-8859-1?Q?KT4Sj9PCbagT9dgOsaS1av5lFHg6on+NwVMT5CRB4ReD095tYE5jW50flt?=
 =?iso-8859-1?Q?p//2z2z4fJtPDux0lsBxUElkM8p8/minB7pSxu1fF4qXzoqgFv7Y9nqIHR?=
 =?iso-8859-1?Q?kYD61frd5ZSol7pmsK6zHHkPP2WE5GQtOrmkiyt7NgueN3dZcGVcGdOCW5?=
 =?iso-8859-1?Q?hCYQ3IFVxqD9sNMOHrnj1J13pHgl96/0HaT7WmILwsFF5dHgkr3g24MkWL?=
 =?iso-8859-1?Q?8JRlBfYU3XgjMkzDrWCJr++t/eR/qqpotXIxzH6Hq4HtkYbSA/3xS+6JpL?=
 =?iso-8859-1?Q?vRoavfLr/Aue+bB5nofbxZf03x6zdEhcu+v8EZ8IY9z9m5GOPZuQt8kmWu?=
 =?iso-8859-1?Q?wdhp7oaeZUAX7lp8TbpEGLtcq6MIYqojDcNKChv7VfBCt3q1XL2rRwZxkB?=
 =?iso-8859-1?Q?Dc4yii76r8A5vUY5Di92dJ2BaI5+ySIJ7NqC9maW0xommA9Bd7fh5n9t3g?=
 =?iso-8859-1?Q?2A+B+Yv62oBip3FG3PN0JI2xmOiKy8qBlcdx02uyhINLaPpBvaUb5Q0GQK?=
 =?iso-8859-1?Q?+t5VdAdtR5RT3RCL7v63hMu40elRYY9Bg74k7jyfM795QWVB7eYQz914sF?=
 =?iso-8859-1?Q?9v+fmdRcG9Udv2omaK3/Lzm94zggXoBJTA49aeRBJAhZAbPEgzM9xrHUaV?=
 =?iso-8859-1?Q?StZt/KdWq2pr93h/OJxOKqnivmeq3O61heAjZl+9wngPUJyNHvnjo6JFH+?=
 =?iso-8859-1?Q?XJ5g7CQPJN8KJTeyy/Eqx/P1umJnnniUF01HUawXr5eLR3vCYfidESlxgQ?=
 =?iso-8859-1?Q?RYbZw/BSmcsJ0sSB0CoHfZOIscDySF6GtSNRXZkt1Hi9DyHOUybLlkQQcs?=
 =?iso-8859-1?Q?pjq/BbIUU0BKkVlUcg6jyWbawL+j4zU6Dh4qixSxomxXwPIOv4PFaQrQoR?=
 =?iso-8859-1?Q?lyj8iIp7G0ix5xQ/F8JS2qH2WVZggM7c0q14rCrZzuKToCi4Y6HoKZw43k?=
 =?iso-8859-1?Q?io2wYESgZmBp4VikcK6zDl7M4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fad9a6-63e4-47fa-1fe4-08d9dcb9f806
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 08:42:33.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Umo8CPIWc9oXF7wzgCLBSs3WLFBuP12r+u8GN7cM+Vdgf51XSkF09jm/4WuE5evnr1pCjVkPc9kHi2HgZylwS1KKbok+sIP7QxWsWgELjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB0201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic version of arch_get_unmapped_area() which
is now available at all time instead of its copy
radix__arch_get_unmapped_area()

To allow that for PPC64, add arch_get_mmap_base() and
arch_get_mmap_end() macros.

Instead of setting mm->get_unmapped_area() to either
arch_get_unmapped_area() or generic_get_unmapped_area(),
always set it to arch_get_unmapped_area() and call
generic_get_unmapped_area() from there when radix is enabled.

Do the same with radix__arch_get_unmapped_area_topdown()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/task_size_64.h |   8 ++
 arch/powerpc/mm/mmap.c                  | 127 ++----------------------
 2 files changed, 14 insertions(+), 121 deletions(-)

diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
index 38fdf8041d12..5a709951c901 100644
--- a/arch/powerpc/include/asm/task_size_64.h
+++ b/arch/powerpc/include/asm/task_size_64.h
@@ -72,4 +72,12 @@
 #define STACK_TOP_MAX TASK_SIZE_USER64
 #define STACK_TOP (is_32bit_task() ? STACK_TOP_USER32 : STACK_TOP_USER64)
 
+#define arch_get_mmap_base(addr, base) \
+	(((addr) > DEFAULT_MAP_WINDOW) ? (base) + TASK_SIZE - DEFAULT_MAP_WINDOW : (base))
+
+#define arch_get_mmap_end(addr, len, flags) \
+	(((addr) > DEFAULT_MAP_WINDOW) || \
+	 (((flags) & MAP_FIXED) && ((addr) + (len) > DEFAULT_MAP_WINDOW)) ? TASK_SIZE : \
+									    DEFAULT_MAP_WINDOW)
+
 #endif /* _ASM_POWERPC_TASK_SIZE_64_H */
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index 9b0d6e395bc0..46781d0103d1 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -81,115 +81,15 @@ static inline unsigned long mmap_base(unsigned long rnd,
 }
 
 #ifdef HAVE_ARCH_UNMAPPED_AREA
-#ifdef CONFIG_PPC_RADIX_MMU
-/*
- * Same function as generic code used only for radix, because we don't need to overload
- * the generic one. But we will have to duplicate, because hash select
- * HAVE_ARCH_UNMAPPED_AREA
- */
-static unsigned long
-radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
-			     unsigned long len, unsigned long pgoff,
-			     unsigned long flags)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	int fixed = (flags & MAP_FIXED);
-	unsigned long high_limit;
-	struct vm_unmapped_area_info info;
-
-	high_limit = DEFAULT_MAP_WINDOW;
-	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
-		high_limit = TASK_SIZE;
-
-	if (len > high_limit)
-		return -ENOMEM;
-
-	if (fixed) {
-		if (addr > high_limit - len)
-			return -ENOMEM;
-		return addr;
-	}
-
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma(mm, addr);
-		if (high_limit - len >= addr && addr >= mmap_min_addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
-
-	info.flags = 0;
-	info.length = len;
-	info.low_limit = mm->mmap_base;
-	info.high_limit = high_limit;
-	info.align_mask = 0;
-
-	return vm_unmapped_area(&info);
-}
-
-static unsigned long
-radix__arch_get_unmapped_area_topdown(struct file *filp,
-				     const unsigned long addr0,
-				     const unsigned long len,
-				     const unsigned long pgoff,
-				     const unsigned long flags)
-{
-	struct vm_area_struct *vma;
-	struct mm_struct *mm = current->mm;
-	unsigned long addr = addr0;
-	int fixed = (flags & MAP_FIXED);
-	unsigned long high_limit;
-	struct vm_unmapped_area_info info;
-
-	high_limit = DEFAULT_MAP_WINDOW;
-	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
-		high_limit = TASK_SIZE;
-
-	if (len > high_limit)
-		return -ENOMEM;
-
-	if (fixed) {
-		if (addr > high_limit - len)
-			return -ENOMEM;
-		return addr;
-	}
-
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma(mm, addr);
-		if (high_limit - len >= addr && addr >= mmap_min_addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
-
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
-	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
-	info.align_mask = 0;
-
-	addr = vm_unmapped_area(&info);
-	if (!(addr & ~PAGE_MASK))
-		return addr;
-	VM_BUG_ON(addr != -ENOMEM);
-
-	/*
-	 * A failed mmap() very likely causes application failure,
-	 * so fall back to the bottom-up function here. This scenario
-	 * can happen with large stack limits and large mmap()
-	 * allocations.
-	 */
-	return radix__arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
-}
-#endif
-
 unsigned long arch_get_unmapped_area(struct file *filp,
 				     unsigned long addr,
 				     unsigned long len,
 				     unsigned long pgoff,
 				     unsigned long flags)
 {
+	if (radix_enabled())
+		return generic_get_unmapped_area(filp, addr, len, pgoff, flags);
+
 #ifdef CONFIG_PPC_64S_HASH_MMU
 	return slice_get_unmapped_area(addr, len, flags,
 				       mm_ctx_user_psize(&current->mm->context), 0);
@@ -204,6 +104,9 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 					     const unsigned long pgoff,
 					     const unsigned long flags)
 {
+	if (radix_enabled())
+		return generic_get_unmapped_area_topdown(filp, addr0, len, pgoff, flags);
+
 #ifdef CONFIG_PPC_64S_HASH_MMU
 	return slice_get_unmapped_area(addr0, len, flags,
 				       mm_ctx_user_psize(&current->mm->context), 1);
@@ -213,21 +116,6 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 }
 #endif /* HAVE_ARCH_UNMAPPED_AREA */
 
-static void radix__arch_pick_mmap_layout(struct mm_struct *mm,
-					unsigned long random_factor,
-					struct rlimit *rlim_stack)
-{
-#ifdef CONFIG_PPC_RADIX_MMU
-	if (mmap_is_legacy(rlim_stack)) {
-		mm->mmap_base = TASK_UNMAPPED_BASE;
-		mm->get_unmapped_area = radix__arch_get_unmapped_area;
-	} else {
-		mm->mmap_base = mmap_base(random_factor, rlim_stack);
-		mm->get_unmapped_area = radix__arch_get_unmapped_area_topdown;
-	}
-#endif
-}
-
 /*
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
@@ -239,9 +127,6 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	if (current->flags & PF_RANDOMIZE)
 		random_factor = arch_mmap_rnd();
 
-	if (radix_enabled())
-		return radix__arch_pick_mmap_layout(mm, random_factor,
-						    rlim_stack);
 	/*
 	 * Fall back to the standard layout if the personality
 	 * bit is set, or if the expected stack growth is unlimited:
-- 
2.33.1
