Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620BE4A01EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347745AbiA1U3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:29:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:39617 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351198AbiA1U3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643401763; x=1674937763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zs6a0hud3tcEUziiNk3cD8a/Ewh7oEDNlHJ8E4IWhEw=;
  b=SmQjAXmaU8M4b4WAcvLSJTRQeRq47gv114QE8uzb5yEYNb9iPiXUj3pg
   6aDY7tdOo+WgCh4PvY1GfZcJFThhQN7JCznwLpLXpgsXx2Kh1Mlxi8eg8
   zhjFT7czIuQAsf62Kz9JLeRH0bfwQVheWHH/R3/rLPkKdT+N+XwwTqnGz
   mJ9xNq61jSUlnOEWzhfxP7eQoPYrThL2G01AwV4syoj5VGVeN1pC6QewI
   +U3rQZBILCof2G/FO4fXnfQ3PmqapXYvlBrXLuxZbDzYIuMog1ZgKG9tD
   dCmZ4ZmdvsX10V+bt8dfeE0YpZ12lP+6m4kY9+8lar5RGeORqO8WfDNim
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227170807"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="227170807"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 12:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="618827715"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 12:29:23 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 10/11] tools/objtool: Check for use of the ENQCMD instruction in the kernel
Date:   Fri, 28 Jan 2022 12:29:04 -0800
Message-Id: <20220128202905.2274672-11-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128202905.2274672-1-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ENQCMD implicitly accesses the PASID_MSR to fill in the pasid field
of the descriptor being submitted to an accelerator. But there is no
precise (and stable across kernel changes) point at which the PASID_MSR
is updated from the value for one task to the next.

Kernel code that uses accelerators must always use the ENQCMDS instruction
which does not access the PASID_MSR.

Check for use of the ENQCMD instruction in the kernel and warn on its
usage.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
v3:
- Add Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

v2:
- Simplify handling ENQCMD (PeterZ and Josh)

 tools/objtool/arch/x86/decode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index c10ef78df050..479e769ca324 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -112,7 +112,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 	const struct elf *elf = file->elf;
 	struct insn insn;
 	int x86_64, ret;
-	unsigned char op1, op2,
+	unsigned char op1, op2, op3,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
 		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
@@ -139,6 +139,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 
 	op1 = insn.opcode.bytes[0];
 	op2 = insn.opcode.bytes[1];
+	op3 = insn.opcode.bytes[2];
 
 	if (insn.rex_prefix.nbytes) {
 		rex = insn.rex_prefix.bytes[0];
@@ -491,6 +492,14 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			/* nopl/nopw */
 			*type = INSN_NOP;
 
+		} else if (op2 == 0x38 && op3 == 0xf8) {
+			if (insn.prefixes.nbytes == 1 &&
+			    insn.prefixes.bytes[0] == 0xf2) {
+				/* ENQCMD cannot be used in the kernel. */
+				WARN("ENQCMD instruction at %s:%lx", sec->name,
+				     offset);
+			}
+
 		} else if (op2 == 0xa0 || op2 == 0xa8) {
 
 			/* push fs/gs */
-- 
2.35.0

