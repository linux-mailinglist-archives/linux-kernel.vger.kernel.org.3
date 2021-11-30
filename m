Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6124641DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344962AbhK3XAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:00:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhK3XAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:00:00 -0500
Date:   Tue, 30 Nov 2021 22:56:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638312997;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ze50sqBb5roKjgkT4KJKXG6kcT5mDTpCA1BPU7czhoQ=;
        b=ZoR/3PBKUqipY5P/XmphRG71KVMYvLcQojk9nvzgOyOzskudRJS4Ck13NgIEUeMJah51Au
        LODqniJd8y4ASDyORzZbrBzqAb/ydUkMa6Zwb751uj08PeUbw5M5uwqRujAcN+V1hQaCIa
        f/oq2JIoRkfwCKj/M1KcLESfDP+L7hmrLbgAnwN3URK0QOBe4gC1XpMaPg2OXmDLOSb49K
        GzkLa82FY+JyNcLcRbxbpwA38Wvmcn2dV4IIhBYbXN+d5I7pmONIer6kmN0vSxf6Nqwf+C
        Ao9OkG5FS9SotJvoQGgY+VyLDyGOf81eXHpmA6cYleYgwGl5mBgpcyhCBXlbEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638312997;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ze50sqBb5roKjgkT4KJKXG6kcT5mDTpCA1BPU7czhoQ=;
        b=e4uMyKr2Cuc9Oks4UBOY0B7AYg7kFBtRMPYyN9Kak9fq+R6CZeFZa48mnW+8y72XOi8ffK
        MX3rqVVaCU8ZsTAw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211130184933.31005-3-kirill.shutemov@linux.intel.com>
References: <20211130184933.31005-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163831299632.11128.12267680190989491848.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     d5ec1877df6da6a14bbc353aff50689528930dd2
Gitweb:        https://git.kernel.org/tip/d5ec1877df6da6a14bbc353aff50689528930dd2
Author:        Kirill A. Shutemov <kirill@shutemov.name>
AuthorDate:    Tue, 30 Nov 2021 21:49:31 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 30 Nov 2021 14:53:04 -08:00

x86/insn-eval: Introduce insn_get_modrm_reg_ptr()

The helper returns a pointer to the register indicated by
ModRM byte.

It's going to replace vc_insn_get_reg() in the SEV MMIO
implementation. TDX MMIO implementation will also use it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20211130184933.31005-3-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/insn-eval.h |  1 +
 arch/x86/lib/insn-eval.c         | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 4ec3613..33ae404 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -19,6 +19,7 @@ bool insn_has_rep_prefix(struct insn *insn);
 void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs);
+unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs);
 unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
 int insn_get_code_seg_params(struct pt_regs *regs);
 int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip);
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 1c51e8a..8df6236 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -849,6 +849,26 @@ int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs)
 }
 
 /**
+ * insn_get_modrm_reg_ptr() - Obtain register pointer based on ModRM byte
+ * @insn:	Instruction containing the ModRM byte
+ * @regs:	Register values as seen when entering kernel mode
+ *
+ * Returns:
+ *
+ * The register indicated by the reg part of the ModRM byte.
+ * The register is obtained as a pointer within pt_regs.
+ */
+unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs)
+{
+	int offset;
+
+	offset = insn_get_modrm_reg_off(insn, regs);
+	if (offset < 0)
+		return NULL;
+	return (void *)regs + offset;
+}
+
+/**
  * get_seg_base_limit() - obtain base address and limit of a segment
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
