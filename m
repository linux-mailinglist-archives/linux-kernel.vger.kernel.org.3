Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706E8463E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbhK3SyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbhK3SxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:53:15 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816D0C061757
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:49:53 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c32so56296796lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lcoDfp8NpUhd4JmL01//5vwITBbb6h3Hr5f7E7IEzuY=;
        b=sKYmZjCxd7z/ps05OV3HNdHGCD8i1R45MDnQOmUfLtCUfX/pswWQi+QA/gJIr/oHEP
         ug4hmEiFdghJJ0BszwOoDnPGOfsOixmVtUdWveyhNfcOk1ZrNQ4QJRU8LpzUtbjkAuyX
         ZVq8E4YGG5PZMrKnvUYM9hJdsd1JP14sLFMzx0MSf1aevCXuLER7kuhQO3H60s+N0N6H
         Ki3RLSx6r3QFhpfceULL4WdzF+uhSLQRRtxrBCuZvVEsGo+q5h5PQSLqaq6PrYHUDHsJ
         EphNuQQBcjUhTZNMxo+6dlm11uE3Ebr0y/ecq3HDvsWg633bV7CRM0ohZ6mwu70weigf
         MOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lcoDfp8NpUhd4JmL01//5vwITBbb6h3Hr5f7E7IEzuY=;
        b=U03TH705Euek0o/TvwKm5jT7rw0sUkz4W7Eyc7bpGOW3uT8TOGDMjvMdugPfk5vZX9
         /f5boigUaoGLW7cShzYKpniiw3qjlNFwVjiZWE8JSjJC/Wba33WpSduhByHEJDk4oKdU
         9G7cQBQ+MLqEClACjXtCAziMErNnXn+D2nUX3ivAzFPPQDq4fz/tGItOGxsL9BfEGDGq
         Gul3oboooL5q+0hxRnvsYS3is2F8xNddYZqnZAu068MWU/84d/f57uVnGgPlAaZEq5ap
         OKeYe+t8B9ukLcwyCBWgH3rLJNmpgU8OtQCPtBW6oiOdGd5+3NMgnB7YkEHVB4L6LFjG
         ju4g==
X-Gm-Message-State: AOAM533maX7XWOSauOyBBKR10hMV1/0pZJc15BsWgZzzuG2miW6upOMN
        8w6p04YyU4viaVYMtWDIQuS8/Q==
X-Google-Smtp-Source: ABdhPJw5gBdfBR/VrrqVl5mXf/L+JGp5xOa7f5S6HsRWjxw9T1xetVQSiV/koAe6AGEDClV2e1iqLw==
X-Received: by 2002:a05:6512:a95:: with SMTP id m21mr981366lfu.574.1638298191831;
        Tue, 30 Nov 2021 10:49:51 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n3sm1628233ljc.92.2021.11.30.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:49:48 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id A9051103671; Tue, 30 Nov 2021 21:49:49 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCHv4 4/4] x86/sev-es: Use insn_decode_mmio() for MMIO implementation
Date:   Tue, 30 Nov 2021 21:49:33 +0300
Message-Id: <20211130184933.31005-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130184933.31005-1-kirill.shutemov@linux.intel.com>
References: <20211130184933.31005-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill@shutemov.name>

Switch SEV implementation to insn_decode_mmio(). The helper is going
to be used by TDX too.

No functional changes.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev.c | 172 ++++++++++--------------------------------
 1 file changed, 41 insertions(+), 131 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 74f0ec955384..09c06c025626 100644
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
-- 
2.32.0

