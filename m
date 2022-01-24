Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3E1498033
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242977AbiAXM7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:59:37 -0500
Received: from foss.arm.com ([217.140.110.172]:33302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242971AbiAXM7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:59:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 490841396;
        Mon, 24 Jan 2022 04:59:12 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DCC033F774;
        Mon, 24 Jan 2022 04:59:09 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V1 31/31] mm/mmap: Define macros for vm_flags access permission combinations
Date:   Mon, 24 Jan 2022 18:27:08 +0530
Message-Id: <1643029028-12710-32-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros will be useful in cleaning up the all those switch statements
in vm_get_page_prot() across all platforms.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mm.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6c0844b99b3e..b3691eeec500 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2828,6 +2828,45 @@ static inline bool range_in_vma(struct vm_area_struct *vma,
 	return (vma && vma->vm_start <= start && end <= vma->vm_end);
 }
 
+/*
+ * Access permission related vm_flags combination is used to map into
+ * platform defined page protection flags. This enumeration helps in
+ * abstracting out possible indices after vm_flags is probed for all
+ * access permission i.e  (VM_SHARED | VM_EXEC | VM_READ | VM_WRITE).
+ *
+ * VM_EXEC ---------------------|
+ *                              |
+ * VM_WRITE ---------------|    |
+ *                         |    |
+ * VM_READ -----------|    |    |
+ *                    |    |    |
+ * VM_SHARED ----|    |    |    |
+ *               |    |    |    |
+ *               v    v    v    v
+ * VMFLAGS_IDX_(S|X)(R|X)(W|X)(E|X)
+ *
+ * X - Indicates that the access flag is absent
+ */
+enum vmflags_idx {
+	VMFLAGS_IDX_XXXX,	/* (VM_NONE)                                    */
+	VMFLAGS_IDX_XRXX,	/* (VM_READ)                                    */
+	VMFLAGS_IDX_XXWX,	/* (VM_WRITE)                                   */
+	VMFLAGS_IDX_XRWX,	/* (VM_READ | VM_WRITE)                         */
+	VMFLAGS_IDX_XXXE,	/* (VM_EXEC)                                    */
+	VMFLAGS_IDX_XRXE,	/* (VM_EXEC | VM_READ)                          */
+	VMFLAGS_IDX_XXWE,	/* (VM_EXEC | VM_WRITE)                         */
+	VMFLAGS_IDX_XRWE,	/* (VM_EXEC | VM_READ | VM_WRITE)               */
+	VMFLAGS_IDX_SXXX,	/* (VM_SHARED | VM_NONE)                        */
+	VMFLAGS_IDX_SRXX,	/* (VM_SHARED | VM_READ)                        */
+	VMFLAGS_IDX_SXWX,	/* (VM_SHARED | VM_WRITE)                       */
+	VMFLAGS_IDX_SRWX,	/* (VM_SHARED | VM_READ | VM_WRITE)             */
+	VMFLAGS_IDX_SXXE,	/* (VM_SHARED | VM_EXEC)                        */
+	VMFLAGS_IDX_SRXE,	/* (VM_SHARED | VM_EXEC | VM_READ)              */
+	VMFLAGS_IDX_SXWE,	/* (VM_SHARED | VM_EXEC | VM_WRITE)             */
+	VMFLAGS_IDX_SRWE,	/* (VM_SHARED | VM_EXEC | VM_READ | VM_WRITE)   */
+	VMFLAGS_IDX_MAX
+};
+
 #ifdef CONFIG_MMU
 pgprot_t vm_get_page_prot(unsigned long vm_flags);
 void vma_set_page_prot(struct vm_area_struct *vma);
-- 
2.25.1

