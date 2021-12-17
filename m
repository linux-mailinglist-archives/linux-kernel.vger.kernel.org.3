Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839EE4796CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhLQWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:02:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:26506 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhLQWBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639778512; x=1671314512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WUETfejsiNGR9gILAkgt74/RWnHGbmhPzWPMpp74bp0=;
  b=Il+bB43Ak33zpq3/eSK8DrhhP//vZ2BIH8zirx4LW6OqQGTh+gSDjI6g
   0VKMk47Aic2bBFl0hKtb50opQf6Ovhoc9oKeObg1JSSPTqzPk4C8cygub
   nFFAM1u9dJVzre+m6GR1SIon3gHrYMjK9cJjiD6DbHlLwfnQ5FH8dtvZ+
   +JgwQ7jFoxLzHGC6qSdfiMQg2uFZ72B7u00ACTwCX4M0KbJlRjn9prlan
   2utZzMz7hZu4rUn239R+qLrI+R0lEsWwg7sR2kQBG+DApNuK33TTvn8i8
   TrzjplY/h8oUY+oFUhRY9MTAPtALxtA2JpYRO23tHh2Wr6rH1K7i1LHB2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237381604"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237381604"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="506928110"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:51 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
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
Subject: [PATCH v2 10/11] tools/objtool: Check for use of the ENQCMD instruction in the kernel
Date:   Fri, 17 Dec 2021 22:01:35 +0000
Message-Id: <20211217220136.2762116-11-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
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
---
v2:
- Simplify handling ENQCMD (PeterZ and Josh)

 tools/objtool/arch/x86/decode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 4d6d7fc13255..11ffa0e53f84 100644
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
2.34.1

