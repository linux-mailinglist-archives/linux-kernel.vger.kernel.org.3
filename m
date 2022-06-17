Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67E355000E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiFQWlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFQWlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:41:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A716212E;
        Fri, 17 Jun 2022 15:41:15 -0700 (PDT)
Date:   Fri, 17 Jun 2022 22:41:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655505673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OTn9QAj/tDMADzB1dZCYs4jWnfGwNKpMtaCQbiwXcM=;
        b=D0ZcQhWhXFZpZkoDBFRQ+nG9YeYnoI49XWLEMzySHMCGZ/Gwxl23fdrPUndd/EPreaQjvn
        1PNkkleDsrlUomXXZhCegvWpRy9ZKxG/D3p+5bkwNfUTRF0tFRzLe40dMZ1z5fzVfe1icF
        A8YPsV4U01fPxrLDcryOxF6NaSXmJsBpCmf7Iz4zONEMo4KaCEhM+VZjncaigZunuQiYpZ
        AFlf87A9LXAKqueaeX7BJ8I/KMDXi+usnUDnkk911UM4iYLdpD8jv1Td6JbXI/BDgGVnsr
        jsTDCJFnTazKvOnerPKrH1fFx1rE/9mg0aU7MudBLQ1yzzVHdagqRuHDfCpqgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655505673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OTn9QAj/tDMADzB1dZCYs4jWnfGwNKpMtaCQbiwXcM=;
        b=102QNJLncAxL6Mmbka8HMhcxDRCHOg0sBfXh6Jld/RtvB7Z7rEUE3KBdPLWyp5wzgoRHpj
        2XyvHUnZgIOnIPCg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tdx: Handle load_unaligned_zeropad() page-cross
 to a shared page
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
References: <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <165550567214.4207.3700499203810719676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1e7769653b06b56b7ea7d56911d2d5b2957750cd
Gitweb:        https://git.kernel.org/tip/1e7769653b06b56b7ea7d56911d2d5b2957750cd
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 14 Jun 2022 15:01:35 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 17 Jun 2022 15:37:33 -07:00

x86/tdx: Handle load_unaligned_zeropad() page-cross to a shared page

load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
The unwanted loads are typically harmless. But, they might be made to
totally unrelated or even unmapped memory. load_unaligned_zeropad()
relies on exception fixup (#PF, #GP and now #VE) to recover from these
unwanted loads.

In TDX guests, the second page can be shared page and a VMM may configure
it to trigger #VE.

The kernel assumes that #VE on a shared page is an MMIO access and tries to
decode instruction to handle it. In case of load_unaligned_zeropad() it
may result in confusion as it is not MMIO access.

Fix it by detecting split page MMIO accesses and failing them.
load_unaligned_zeropad() will recover using exception fixups.

The issue was discovered by analysis and reproduced artificially. It was
not triggered during testing.

[ dhansen: fix up changelogs and comments for grammar and clarity,
	   plus incorporate Kirill's off-by-one fix]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220614120135.14812-4-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c8d44f4..928dcf7 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -333,8 +333,8 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
 
 static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
+	unsigned long *reg, val, vaddr;
 	char buffer[MAX_INSN_SIZE];
-	unsigned long *reg, val;
 	struct insn insn = {};
 	enum mmio_type mmio;
 	int size, extend_size;
@@ -360,6 +360,19 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 			return -EINVAL;
 	}
 
+	/*
+	 * Reject EPT violation #VEs that split pages.
+	 *
+	 * MMIO accesses are supposed to be naturally aligned and therefore
+	 * never cross page boundaries. Seeing split page accesses indicates
+	 * a bug or a load_unaligned_zeropad() that stepped into an MMIO page.
+	 *
+	 * load_unaligned_zeropad() will recover using exception fixups.
+	 */
+	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
+	if (vaddr / PAGE_SIZE != (vaddr + size - 1) / PAGE_SIZE)
+		return -EFAULT;
+
 	/* Handle writes first */
 	switch (mmio) {
 	case MMIO_WRITE:
