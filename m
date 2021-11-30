Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4214641DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344739AbhK3XAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbhK3XAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:00:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68A3C061746;
        Tue, 30 Nov 2021 14:56:38 -0800 (PST)
Date:   Tue, 30 Nov 2021 22:56:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638312995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQef0IT6F70Va/5SjEb4lPGuqE0knLueD/JUk1SrsjU=;
        b=2+urwjfVkzH3iUKeeMcgWB/X3E6gUuZj+tDOCESLvf6RlzcSoLt4wxjHz4vGphqCSGipZ/
        0LLI+HPv5Rm4cobBnj1sblyfXojD+4xZhbxUmtLGJPA+n9IBv49e7DgXT07IHQF5eKf1Xm
        MGTFPSQxnfKOvgVzE0mob/nv5mAr+DZ/ZlZ52AzwPdzGxj0vzgK0mdzrdvHWvlSledOrEH
        QK+UNa4PIRRo3Mxd5osaJdI/8SXztwCC5Pnt+qtVMIR7a9KwuZMaT5RHFgtxiCDhwrPCs4
        KI+xmKF8gN/51D6VGYw5ZTrxx0bYX29burX/9tKA9pZC1an8+svqGARMmvZ+gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638312995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQef0IT6F70Va/5SjEb4lPGuqE0knLueD/JUk1SrsjU=;
        b=6zBQMqvvLJMkncUfuoF7dZ6OzMwwZJ3GCjGj9/TohzBuiNK1IJZ2hyh5fM9RzF1QkZCZNW
        vI1kBf/ehDGFprCQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/sev-es: Use insn_decode_mmio() for MMIO implementation
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211130184933.31005-5-kirill.shutemov@linux.intel.com>
References: <20211130184933.31005-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163831299453.11128.8997662164565612069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     c494eb366dbfc5095c0f159bbb5c6d4ec3ed37ec
Gitweb:        https://git.kernel.org/tip/c494eb366dbfc5095c0f159bbb5c6d4ec3ed37ec
Author:        Kirill A. Shutemov <kirill@shutemov.name>
AuthorDate:    Tue, 30 Nov 2021 21:49:33 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 30 Nov 2021 14:53:30 -08:00

x86/sev-es: Use insn_decode_mmio() for MMIO implementation

Switch SEV implementation to insn_decode_mmio(). The helper is going
to be used by TDX too.

No functional changes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20211130184933.31005-5-kirill.shutemov@linux.intel.com
---
 arch/x86/kernel/sev.c | 172 +++++++++--------------------------------
 1 file changed, 41 insertions(+), 131 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 74f0ec9..09c06c0 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -776,22 +776,6 @@ static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
 	do_early_exception(ctxt->regs, trapnr);
 }
 
-static long *vc_insn_get_reg(struct es_em_ctxt *ctxt)
-{
-	long *reg_array;
-	int offset;
-
-	reg_array = (long *)ctxt->regs;
-	offset    = insn_get_modrm_reg_off(&ctxt->insn, ctxt->regs);
-
-	if (offset < 0)
-		return NULL;
-
-	offset /= sizeof(long);
-
-	return reg_array + offset;
-}
-
 static long *vc_insn_get_rm(struct es_em_ctxt *ctxt)
 {
 	long *reg_array;
@@ -839,76 +823,6 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 	return sev_es_ghcb_hv_call(ghcb, true, ctxt, exit_code, exit_info_1, exit_info_2);
 }
 
-static enum es_result vc_handle_mmio_twobyte_ops(struct ghcb *ghcb,
-						 struct es_em_ctxt *ctxt)
-{
-	struct insn *insn = &ctxt->insn;
-	unsigned int bytes = 0;
-	enum es_result ret;
-	int sign_byte;
-	long *reg_data;
-
-	switch (insn->opcode.bytes[1]) {
-		/* MMIO Read w/ zero-extension */
-	case 0xb6:
-		bytes = 1;
-		fallthrough;
-	case 0xb7:
-		if (!bytes)
-			bytes = 2;
-
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		/* Zero extend based on operand size */
-		reg_data = vc_insn_get_reg(ctxt);
-		if (!reg_data)
-			return ES_DECODE_FAILED;
-
-		memset(reg_data, 0, insn->opnd_bytes);
-
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-
-		/* MMIO Read w/ sign-extension */
-	case 0xbe:
-		bytes = 1;
-		fallthrough;
-	case 0xbf:
-		if (!bytes)
-			bytes = 2;
-
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		/* Sign extend based on operand size */
-		reg_data = vc_insn_get_reg(ctxt);
-		if (!reg_data)
-			return ES_DECODE_FAILED;
-
-		if (bytes == 1) {
-			u8 *val = (u8 *)ghcb->shared_buffer;
-
-			sign_byte = (*val & 0x80) ? 0xff : 0x00;
-		} else {
-			u16 *val = (u16 *)ghcb->shared_buffer;
-
-			sign_byte = (*val & 0x8000) ? 0xff : 0x00;
-		}
-		memset(reg_data, sign_byte, insn->opnd_bytes);
-
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-
-	default:
-		ret = ES_UNSUPPORTED;
-	}
-
-	return ret;
-}
-
 /*
  * The MOVS instruction has two memory operands, which raises the
  * problem that it is not known whether the access to the source or the
@@ -976,83 +890,79 @@ static enum es_result vc_handle_mmio_movs(struct es_em_ctxt *ctxt,
 		return ES_RETRY;
 }
 
-static enum es_result vc_handle_mmio(struct ghcb *ghcb,
-				     struct es_em_ctxt *ctxt)
+static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct insn *insn = &ctxt->insn;
 	unsigned int bytes = 0;
+	enum mmio_type mmio;
 	enum es_result ret;
+	u8 sign_byte;
 	long *reg_data;
 
-	switch (insn->opcode.bytes[0]) {
-	/* MMIO Write */
-	case 0x88:
-		bytes = 1;
-		fallthrough;
-	case 0x89:
-		if (!bytes)
-			bytes = insn->opnd_bytes;
+	mmio = insn_decode_mmio(insn, &bytes);
+	if (mmio == MMIO_DECODE_FAILED)
+		return ES_DECODE_FAILED;
 
-		reg_data = vc_insn_get_reg(ctxt);
+	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
+		reg_data = insn_get_modrm_reg_ptr(insn, ctxt->regs);
 		if (!reg_data)
 			return ES_DECODE_FAILED;
+	}
 
+	switch (mmio) {
+	case MMIO_WRITE:
 		memcpy(ghcb->shared_buffer, reg_data, bytes);
-
 		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
 		break;
-
-	case 0xc6:
-		bytes = 1;
-		fallthrough;
-	case 0xc7:
-		if (!bytes)
-			bytes = insn->opnd_bytes;
-
+	case MMIO_WRITE_IMM:
 		memcpy(ghcb->shared_buffer, insn->immediate1.bytes, bytes);
-
 		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
 		break;
-
-		/* MMIO Read */
-	case 0x8a:
-		bytes = 1;
-		fallthrough;
-	case 0x8b:
-		if (!bytes)
-			bytes = insn->opnd_bytes;
-
+	case MMIO_READ:
 		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
 		if (ret)
 			break;
 
-		reg_data = vc_insn_get_reg(ctxt);
-		if (!reg_data)
-			return ES_DECODE_FAILED;
-
 		/* Zero-extend for 32-bit operation */
 		if (bytes == 4)
 			*reg_data = 0;
 
 		memcpy(reg_data, ghcb->shared_buffer, bytes);
 		break;
+	case MMIO_READ_ZERO_EXTEND:
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		/* Zero extend based on operand size */
+		memset(reg_data, 0, insn->opnd_bytes);
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case MMIO_READ_SIGN_EXTEND:
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
 
-		/* MOVS instruction */
-	case 0xa4:
-		bytes = 1;
-		fallthrough;
-	case 0xa5:
-		if (!bytes)
-			bytes = insn->opnd_bytes;
+		if (bytes == 1) {
+			u8 *val = (u8 *)ghcb->shared_buffer;
 
-		ret = vc_handle_mmio_movs(ctxt, bytes);
+			sign_byte = (*val & 0x80) ? 0xff : 0x00;
+		} else {
+			u16 *val = (u16 *)ghcb->shared_buffer;
+
+			sign_byte = (*val & 0x8000) ? 0xff : 0x00;
+		}
+
+		/* Sign extend based on operand size */
+		memset(reg_data, sign_byte, insn->opnd_bytes);
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
 		break;
-		/* Two-Byte Opcodes */
-	case 0x0f:
-		ret = vc_handle_mmio_twobyte_ops(ghcb, ctxt);
+	case MMIO_MOVS:
+		ret = vc_handle_mmio_movs(ctxt, bytes);
 		break;
 	default:
 		ret = ES_UNSUPPORTED;
+		break;
 	}
 
 	return ret;
