Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A675229CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbiEKCaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbiEKC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:29:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E4421AAA6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652236183; x=1683772183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/zG/vU7kvADc4pg2W2FY9O2Nfewu2j+VHOpdujenCaM=;
  b=gmk2r5wBt/7PsfYhVYBG67UJ0PRmh76OD0ED3YZH/6eYgHewzckcHqY4
   ZRl7HAltD6SqAzYsbBvtqncgMLArj05PzTG0y3BBOWqHTlK8mKosnP38u
   sZ/56wz2+9SiS8eiq/3pnQNjIX7TlkrCmwuxLBh4lzbfmVVp1J3xbZp2G
   UgGOzGdD+eUfxCjq9B7yNaEd6iY3d53aBb84h7yf7knZnNltr7fZq1lF9
   EOAuDdaiaD8RLguoh7ESPyD+U5ussBoey1kj7DKd8Xk6ngh88w5fjSEdX
   tYUl+WkX6RLHTve9kDFANmVlhnmH2Ui/aIl/APDrsoztftpnFWlHuBrDw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="250093485"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="250093485"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="670166554"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 10 May 2022 19:29:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 53BBA5D0; Wed, 11 May 2022 05:28:01 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFCv2 07/10] x86/mm: Handle tagged memory accesses from kernel threads
Date:   Wed, 11 May 2022 05:27:48 +0300
Message-Id: <20220511022751.65540-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a kernel thread performs memory access on behalf of a process (like
in async I/O, io_uring, etc.) it has to respect tagging setup of the
process as user addresses can include tags.

Normally, LAM setup is per-thread and recorded in thread features, but
for this use case kernel also tracks LAM setup per-mm. mm->context.lam
would record LAM that allows the most tag bits among the threads of
the mm.

The info used by switch_mm_irqs_off() to construct CR3 if the task is
kernel thread. Thread featrues of the kernel thread get updated
according to mm->context.lam. It allows untagged_addr() to work
correctly.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mmu.h |  1 +
 arch/x86/mm/tlb.c          | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..52f3749f14e8 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -40,6 +40,7 @@ typedef struct {
 
 #ifdef CONFIG_X86_64
 	unsigned short flags;
+	u8 lam;
 #endif
 
 	struct mutex lock;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f9fe71d1f42c..b320556e1c22 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -185,6 +185,34 @@ static u8 gen_lam(struct task_struct *tsk, struct mm_struct *mm)
 	if (!tsk)
 		return LAM_NONE;
 
+	if (tsk->flags & PF_KTHREAD) {
+		/*
+		 * For kernel thread use the most permissive LAM
+		 * used by the mm. It's required to handle kernel thread
+		 * memory accesses on behalf of a process.
+		 *
+		 * Adjust thread flags accodringly, so untagged_addr() would
+		 * work correctly.
+		 */
+
+		tsk->thread.features &= ~(X86_THREAD_LAM_U48 |
+					  X86_THREAD_LAM_U57);
+
+		switch (mm->context.lam) {
+		case LAM_NONE:
+			return LAM_NONE;
+		case LAM_U57:
+			tsk->thread.features |= X86_THREAD_LAM_U57;
+			return LAM_U57;
+		case LAM_U48:
+			tsk->thread.features |= X86_THREAD_LAM_U48;
+			return LAM_U48;
+		default:
+			WARN_ON_ONCE(1);
+			return LAM_NONE;
+		}
+	}
+
 	if (tsk->thread.features & X86_THREAD_LAM_U57)
 		return LAM_U57;
 	if (tsk->thread.features & X86_THREAD_LAM_U48)
-- 
2.35.1

