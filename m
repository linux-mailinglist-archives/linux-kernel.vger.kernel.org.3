Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E643C463E10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245622AbhK3SyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245618AbhK3SxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:53:11 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3969FC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:49:51 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id z7so21897082lfi.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioiimKOpHFjfHbSaf/9ypR95mpT2qGr418ec04ot18I=;
        b=vHv9Il5PmwhtSkUlKGommfUu6vLYQbohrr+3bHcZfujFWihzeOkfxdWPT2+JQBIfl2
         onCIgfGoO7Mn4X8iIVkNt3OG2yb2Tyot+Vq5QtbS/CTDyiOkG0xxuvDpFmhAwYG9AXBo
         VQ0NJFYqCbpjeDj08xc1mTSrPjLV3L+WXwZQiZlcBmhz/Ala2RSnrCqXWu+BUDfcQIAF
         u+/wGnQ6pDw15CSz/USWaZGUF923ePSdFeZH85s4b0yIdDsUcZGw9j2OsqxdoqI+GlTT
         kaoLVUeGeiG1+Xy5/8ncCUA7zUSI8I8mp/OxDBo5uiDbt9JyAXyWRjaMX9nqgId/N4wa
         Hwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioiimKOpHFjfHbSaf/9ypR95mpT2qGr418ec04ot18I=;
        b=7PS2owXTbvXR5CXH/okKp05U2Jm5ufKmcZnYtujiNqXfDkl/J/oMrNqokzXxpfv0uT
         qXtu5ljt05amcnoCVH50WxHsT7tSiLEqpXUMqyF1qwBiiN8vqNwm5o2pSGa6BoBLMV4J
         M0CWkH+78Ln2NRwGh2Xa152hZ0nhuuvPyozVPDe+ead6Pgd/P+vczDnpWADST56HgaU4
         dovs5pYGH51YXwn2wz8XXiPuFGqPdni0sV84CbDg5CQs7YRbKersi0hVQqDwjnmGaovW
         mdeRuTHnhuCEfHm1ylPfGDZ5nTfTZAaZktH8eLAfC0Fr4YLFUUFMeAYiOBGvJixHH0Kx
         ruVw==
X-Gm-Message-State: AOAM531HC0yDdEDrkIvhpch3y+/slmWUyr0DKrsOjLv/GysWpUq2ApxT
        HdNOtj2I/vYfxmhBbjPjcBHDZg==
X-Google-Smtp-Source: ABdhPJxRrXAptRzBnjdsfyXNqdC7qsccE1ZjEwS+98SPGiQBfElo1UyvL90PTZn+5mrylH3EAq1+6A==
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr940966lfb.677.1638298189455;
        Tue, 30 Nov 2021 10:49:49 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o15sm1786827lfu.283.2021.11.30.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:49:48 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 9C40110366E; Tue, 30 Nov 2021 21:49:49 +0300 (+03)
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
Subject: [PATCHv4 2/4] x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
Date:   Tue, 30 Nov 2021 21:49:31 +0300
Message-Id: <20211130184933.31005-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130184933.31005-1-kirill.shutemov@linux.intel.com>
References: <20211130184933.31005-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill@shutemov.name>

The helper returns a pointer to the register indicated by
ModRM byte.

It's going to replace vc_insn_get_reg() in the SEV MMIO
implementation. TDX MMIO implementation will also use it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/insn-eval.h |  1 +
 arch/x86/lib/insn-eval.c         | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 4ec3613551e3..33ae4040c7ee 100644
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
index 868d80ea85d9..0168378ee2d4 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -848,6 +848,26 @@ int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs)
 	return get_reg_offset(insn, regs, REG_TYPE_REG);
 }
 
+/**
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
 /**
  * get_seg_base_limit() - obtain base address and limit of a segment
  * @insn:	Instruction. Must be valid.
-- 
2.32.0

