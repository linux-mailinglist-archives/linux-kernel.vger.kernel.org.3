Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B66B5855A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiG2TmW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Jul 2022 15:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiG2TmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:42:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D60EE0F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:42:20 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26THAKC7027647
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:42:20 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hkjkn5124-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:42:19 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 12:42:19 -0700
Received: by devvm6390.atn0.facebook.com (Postfix, from userid 352741)
        id 57B88189EA0F; Fri, 29 Jul 2022 12:42:16 -0700 (PDT)
From:   <alexlzhu@devvm6390.atn0.facebook.com>, <alexlzhu@fb.com>
To:     <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
CC:     alexlzhu <alexlzhu@fb.com>
Subject: [PATCH] x86/sys_x86_64: fix VMA alginment for mmap file to THP
Date:   Fri, 29 Jul 2022 12:42:14 -0700
Message-ID: <20220729194214.1309313-1-alexlzhu@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: J-uyhaxZv2Lcs68lpPwUrfi4u87W1Nq5
X-Proofpoint-ORIG-GUID: J-uyhaxZv2Lcs68lpPwUrfi4u87W1Nq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_19,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_PDS_FROM_2_EMAILS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: alexlzhu <alexlzhu@fb.com>

With CONFIG_READ_ONLY_THP_FOR_FS, the Linux kernel supports using THPs for
read-only mmapped files, such as shared libraries. However, on x86 the
kernel makes no attempt to actually align those mappings on 2MB boundaries,
which makes it impossible to use those THPs most of the time. This issue
applies to general file mapping THP as well as existing setups using
CONFIG_READ_ONLY_THP_FOR_FS. This is easily fixed by using the alignment
info passed to vm_unmapped_area. The problem can be seen in
/proc/PID/smaps where THPeligible is set to 0 on mappings to eligible
shared object files as shown below.

Before this patch:

7fc6a7e18000-7fc6a80cc000 r-xp 00000000 00:1e 199856
/usr/lib64/libcrypto.so.1.1.1k
Size:               2768 kB
THPeligible:    0
VmFlags: rd ex mr mw me

With this patch the library is mapped at a 2MB aligned address:

fbdfe200000-7fbdfe4b4000 r-xp 00000000 00:1e 199856
/usr/lib64/libcrypto.so.1.1.1k
Size:               2768 kB
THPeligible:    1
VmFlags: rd ex mr mw me

This fixes the alignment of VMAs for any mmap of a file that has the
rd and ex permissions and size >= 2MB. The VMA alignment and
THPeligible field for shared and anonymous memory are handled
separately and are thus not effected by this change.

Signed-off-by: alexlzhu <alexlzhu@fb.com>
---
 arch/x86/entry/vdso/vma.c    |  2 +-
 arch/x86/include/asm/elf.h   |  2 +-
 arch/x86/kernel/sys_x86_64.c | 29 ++++++++++++++++++-----------
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 1000d457c332..da916040d2ba 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -337,7 +337,7 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 	 * Forcibly align the final address in case we have a hardware
 	 * issue that requires alignment for performance reasons.
 	 */
-	addr = align_vdso_addr(addr);
+	addr = align_vdso_addr(addr, len);
 
 	return addr;
 }
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index cb0ff1055ab1..65a09a0e0e97 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -396,5 +396,5 @@ struct va_alignment {
 } ____cacheline_aligned;
 
 extern struct va_alignment va_align;
-extern unsigned long align_vdso_addr(unsigned long);
+extern unsigned long align_vdso_addr(unsigned long addr, unsigned long len);
 #endif /* _ASM_X86_ELF_H */
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 8cc653ffdccd..2506242e37aa 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -25,11 +25,18 @@
 /*
  * Align a virtual address to avoid aliasing in the I$ on AMD F15h.
  */
-static unsigned long get_align_mask(void)
+static unsigned long get_align_mask(unsigned long len)
 {
 	/* handle 32- and 64-bit case with a single conditional */
-	if (va_align.flags < 0 || !(va_align.flags & (2 - mmap_is_ia32())))
+	if (va_align.flags < 0 || !(va_align.flags & (2 - mmap_is_ia32()))) {
+		/*
+		 * Read-only file mappings can be mapped using transparent huge pages;
+		 * make sure that large mappings are 2MB aligned.
+		 */
+		if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && len >= PMD_SIZE)
+			return PMD_SIZE - 1;
 		return 0;
+	}
 
 	if (!(current->flags & PF_RANDOMIZE))
 		return 0;
@@ -47,16 +54,16 @@ static unsigned long get_align_mask(void)
  * value before calling vm_unmapped_area() or ORed directly to the
  * address.
  */
-static unsigned long get_align_bits(void)
+static unsigned long get_align_bits(unsigned long len)
 {
-	return va_align.bits & get_align_mask();
+	return va_align.bits & get_align_mask(len);
 }
 
-unsigned long align_vdso_addr(unsigned long addr)
+unsigned long align_vdso_addr(unsigned long addr, unsigned long len)
 {
-	unsigned long align_mask = get_align_mask();
+	unsigned long align_mask = get_align_mask(len);
 	addr = (addr + align_mask) & ~align_mask;
-	return addr | get_align_bits();
+	return addr | get_align_bits(len);
 }
 
 static int __init control_va_addr_alignment(char *str)
@@ -151,8 +158,8 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.align_mask = 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	if (filp) {
-		info.align_mask = get_align_mask();
-		info.align_offset += get_align_bits();
+		info.align_mask = get_align_mask(len);
+		info.align_offset += get_align_bits(len);
 	}
 	return vm_unmapped_area(&info);
 }
@@ -209,8 +216,8 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.align_mask = 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	if (filp) {
-		info.align_mask = get_align_mask();
-		info.align_offset += get_align_bits();
+		info.align_mask = get_align_mask(len);
+		info.align_offset += get_align_bits(len);
 	}
 	addr = vm_unmapped_area(&info);
 	if (!(addr & ~PAGE_MASK))
-- 
2.30.2

