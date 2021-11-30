Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE972463E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245641AbhK3SyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245579AbhK3SxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:53:11 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC199C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:49:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b40so56225302lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3obENNH8Gu3yX3pZw7OyG+XCZ1D8kVqCUfic1FzQ9iE=;
        b=WlHNnTuJhqn197szZoKaUN7NTXmNeawrKDSjY4xM8ExwSJM2H9msgpFUwP5F8qnWvq
         1gRF647G02xC2O+tEfGrrT24QW2Slpu95tveZWlWh6yAh04JjfvDCHZ1kT7dpdULCR6c
         5w3M14f4kwWBrY7cnxJxyNzublhglwMIpvik2XPc21PqjPYeGipUxje1n7lE3AFzLJGf
         kxR/s66Eu/me5UQJBhnJKf39Id+Asmyhz/i4Yr5DU1vgczKrThCwk3lqcE9eiwQPXuJF
         j+41GkrM2j22wIJRsj4eFSM7OOhUW7DCuu2wFSb6HmU15Kbi+xFBWJXa2VPeEv6Jd4cA
         MWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3obENNH8Gu3yX3pZw7OyG+XCZ1D8kVqCUfic1FzQ9iE=;
        b=acq1S8m51McCCB/ibP6CcKMv6PbkYitIm3wPdVUIGNGX6ArYPtjZ2PGWaNzTOLvRzD
         reIR7bsCatxLwG9l/bjsy8oYa1TLrK/5NTU8ulTfJ8rcKUEndBUP/iCU7T6wDaCLSnx/
         PsG5IuxlPY5k3GE9ZtkAxCTZzizNKtGBQaxC9/Eq2K4lJSG1NpCkVz4o7xV/BpzsB4fX
         +9Eyj140ByKUeKsnKEe25/d6XzLggZlqdX7vSuDm1695ggfDUeKf49zTrU+u62RcC7Ke
         LO1UgAKOLp0YiTz0EisH+cMoRb+y4zIbHWmYnnco6WuuzgFO0VvNLPcGvFKHJ5T3jWWR
         ejog==
X-Gm-Message-State: AOAM532fgskLs7tERoVEeV3lBrPMvTWiQkTNifEBFEWh28XgcaS51nKe
        pbmeMuSIgdqNcvsiBCYKDZ3FBOXBzcuafg==
X-Google-Smtp-Source: ABdhPJxVt6ZmtncFctFB1qL9dZqkZGEUi1B0cYZvQQnh63Iile4DDpG6uKlIlltXCx0d3VpNMKxlnQ==
X-Received: by 2002:ac2:5317:: with SMTP id c23mr980256lfh.430.1638298189940;
        Tue, 30 Nov 2021 10:49:49 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q1sm1803055lfh.234.2021.11.30.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:49:48 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id A300610366F; Tue, 30 Nov 2021 21:49:49 +0300 (+03)
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
Subject: [PATCHv4 3/4] x86/insn-eval: Introduce insn_decode_mmio()
Date:   Tue, 30 Nov 2021 21:49:32 +0300
Message-Id: <20211130184933.31005-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130184933.31005-1-kirill.shutemov@linux.intel.com>
References: <20211130184933.31005-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill@shutemov.name>

In preparation for sharing MMIO instruction decode between SEV-ES and
TDX, factor out the common decode into a new insn_decode_mmio() helper.

For regular virtual machine, MMIO is handled by the VMM and KVM
emulates instructions that caused MMIO. But, this model doesn't work
for a secure VMs (like SEV or TDX) as VMM doesn't have access to the
guest memory and register state. So, for TDX or SEV VMM needs
assistance in handling MMIO. It induces exception in the guest. Guest
has to decode the instruction and handle it on its own.

The code is based on the current SEV MMIO implementation.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/insn-eval.h | 12 +++++
 arch/x86/lib/insn-eval.c         | 84 ++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 33ae4040c7ee..43785ee363f1 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -30,4 +30,16 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs,
 bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 			   unsigned char buf[MAX_INSN_SIZE], int buf_size);
 
+enum mmio_type {
+	MMIO_DECODE_FAILED,
+	MMIO_WRITE,
+	MMIO_WRITE_IMM,
+	MMIO_READ,
+	MMIO_READ_ZERO_EXTEND,
+	MMIO_READ_SIGN_EXTEND,
+	MMIO_MOVS,
+};
+
+enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
+
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 0168378ee2d4..cbfc97229dbf 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1560,3 +1560,87 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 
 	return true;
 }
+
+/**
+ * insn_decode_mmio() - Decode a MMIO instruction
+ * @insn:	Structure to store decoded instruction
+ * @bytes:	Returns size of memory operand
+ *
+ * Decodes instruction that used for Memory-mapped I/O.
+ *
+ * Returns:
+ *
+ * Type of the instruction. Size of the memory operand is stored in
+ * @bytes. If decode failed, MMIO_DECODE_FAILED returned.
+ */
+enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
+{
+	enum mmio_type type = MMIO_DECODE_FAILED;
+
+	*bytes = 0;
+
+	if (insn_get_opcode(insn))
+		return MMIO_DECODE_FAILED;
+
+	switch (insn->opcode.bytes[0]) {
+	case 0x88: /* MOV m8,r8 */
+		*bytes = 1;
+		fallthrough;
+	case 0x89: /* MOV m16/m32/m64, r16/m32/m64 */
+		if (!*bytes)
+			*bytes = insn->opnd_bytes;
+		type = MMIO_WRITE;
+		break;
+
+	case 0xc6: /* MOV m8, imm8 */
+		*bytes = 1;
+		fallthrough;
+	case 0xc7: /* MOV m16/m32/m64, imm16/imm32/imm64 */
+		if (!*bytes)
+			*bytes = insn->opnd_bytes;
+		type = MMIO_WRITE_IMM;
+		break;
+
+	case 0x8a: /* MOV r8, m8 */
+		*bytes = 1;
+		fallthrough;
+	case 0x8b: /* MOV r16/r32/r64, m16/m32/m64 */
+		if (!*bytes)
+			*bytes = insn->opnd_bytes;
+		type = MMIO_READ;
+		break;
+
+	case 0xa4: /* MOVS m8, m8 */
+		*bytes = 1;
+		fallthrough;
+	case 0xa5: /* MOVS m16/m32/m64, m16/m32/m64 */
+		if (!*bytes)
+			*bytes = insn->opnd_bytes;
+		type = MMIO_MOVS;
+		break;
+
+	case 0x0f: /* Two-byte instruction */
+		switch (insn->opcode.bytes[1]) {
+		case 0xb6: /* MOVZX r16/r32/r64, m8 */
+			*bytes = 1;
+			fallthrough;
+		case 0xb7: /* MOVZX r32/r64, m16 */
+			if (!*bytes)
+				*bytes = 2;
+			type = MMIO_READ_ZERO_EXTEND;
+			break;
+
+		case 0xbe: /* MOVSX r16/r32/r64, m8 */
+			*bytes = 1;
+			fallthrough;
+		case 0xbf: /* MOVSX r32/r64, m16 */
+			if (!*bytes)
+				*bytes = 2;
+			type = MMIO_READ_SIGN_EXTEND;
+			break;
+		}
+		break;
+	}
+
+	return type;
+}
-- 
2.32.0

