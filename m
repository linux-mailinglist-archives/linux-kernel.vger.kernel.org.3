Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D414660B3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356653AbhLBJy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:54:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:56019 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356657AbhLBJyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:54:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="260668461"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="260668461"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:50:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="677605200"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2021 01:50:44 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>, chang.seok.bae@intel.com
Subject: [PATCH 4/6] x86/insn: Add misc instructions to x86 instruction decoder
Date:   Thu,  2 Dec 2021 11:50:27 +0200
Message-Id: <20211202095029.2165714-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202095029.2165714-1-adrian.hunter@intel.com>
References: <20211202095029.2165714-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 instruction decoder is used for both kernel instructions and user space
instructions (e.g. uprobes, perf tools Intel PT), so it is good to update
it with new instructions.

Add instructions to x86 instruction decoder:

	User Interrupt

		clui
		senduipi
		stui
		testui
		uiret

	Prediction history reset

		hreset

	Serialize instruction execution

		serialize

	TSX suspend load address tracking

		xresldtrk
		xsusldtrk

Reference:
Intel Architecture Instruction Set Extensions and Future Features
Programming Reference
May 2021
Document Number: 319433-044

Example using perf tools' x86 instruction decoder test:

  $ perf test -v "x86 instruction decoder" |& grep -i hreset
  Decoded ok: f3 0f 3a f0 c0 00           hreset $0x0
  Decoded ok: f3 0f 3a f0 c0 00           hreset $0x0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/lib/x86-opcode-map.txt       | 6 +++---
 tools/arch/x86/lib/x86-opcode-map.txt | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index b2cc6c04cbfe..591797a931bf 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -893,7 +893,7 @@ cc: sha1rnds4 Vdq,Wdq,Ib
 ce: vgf2p8affineqb Vx,Wx,Ib (66)
 cf: vgf2p8affineinvqb Vx,Wx,Ib (66)
 df: VAESKEYGEN Vdq,Wdq,Ib (66),(v1)
-f0: RORX Gy,Ey,Ib (F2),(v)
+f0: RORX Gy,Ey,Ib (F2),(v) | HRESET Gv,Ib (F3),(000),(11B)
 EndTable
 
 GrpTable: Grp1
@@ -976,7 +976,7 @@ GrpTable: Grp7
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
-5: rdpkru (110),(11B) | wrpkru (111),(11B) | SAVEPREVSSP (F3),(010),(11B) | RSTORSSP Mq (F3) | SETSSBSY (F3),(000),(11B)
+5: rdpkru (110),(11B) | wrpkru (111),(11B) | SAVEPREVSSP (F3),(010),(11B) | RSTORSSP Mq (F3) | SETSSBSY (F3),(000),(11B) | CLUI (F3),(110),(11B) | SERIALIZE (000),(11B) | STUI (F3),(111),(11B) | TESTUI (F3)(101)(11B) | UIRET (F3),(100),(11B) | XRESLDTRK (F2),(000),(11B) | XSUSLDTRK (F2),(001),(11B)
 6: LMSW Ew
 7: INVLPG Mb | SWAPGS (o64),(000),(11B) | RDTSCP (001),(11B)
 EndTable
@@ -993,7 +993,7 @@ GrpTable: Grp9
 3: xrstors
 4: xsavec
 5: xsaves
-6: VMPTRLD Mq | VMCLEAR Mq (66) | VMXON Mq (F3) | RDRAND Rv (11B)
+6: VMPTRLD Mq | VMCLEAR Mq (66) | VMXON Mq (F3) | RDRAND Rv (11B) | SENDUIPI Gq (F3)
 7: VMPTRST Mq | VMPTRST Mq (F3) | RDSEED Rv (11B)
 EndTable
 
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index b2cc6c04cbfe..591797a931bf 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -893,7 +893,7 @@ cc: sha1rnds4 Vdq,Wdq,Ib
 ce: vgf2p8affineqb Vx,Wx,Ib (66)
 cf: vgf2p8affineinvqb Vx,Wx,Ib (66)
 df: VAESKEYGEN Vdq,Wdq,Ib (66),(v1)
-f0: RORX Gy,Ey,Ib (F2),(v)
+f0: RORX Gy,Ey,Ib (F2),(v) | HRESET Gv,Ib (F3),(000),(11B)
 EndTable
 
 GrpTable: Grp1
@@ -976,7 +976,7 @@ GrpTable: Grp7
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
-5: rdpkru (110),(11B) | wrpkru (111),(11B) | SAVEPREVSSP (F3),(010),(11B) | RSTORSSP Mq (F3) | SETSSBSY (F3),(000),(11B)
+5: rdpkru (110),(11B) | wrpkru (111),(11B) | SAVEPREVSSP (F3),(010),(11B) | RSTORSSP Mq (F3) | SETSSBSY (F3),(000),(11B) | CLUI (F3),(110),(11B) | SERIALIZE (000),(11B) | STUI (F3),(111),(11B) | TESTUI (F3)(101)(11B) | UIRET (F3),(100),(11B) | XRESLDTRK (F2),(000),(11B) | XSUSLDTRK (F2),(001),(11B)
 6: LMSW Ew
 7: INVLPG Mb | SWAPGS (o64),(000),(11B) | RDTSCP (001),(11B)
 EndTable
@@ -993,7 +993,7 @@ GrpTable: Grp9
 3: xrstors
 4: xsavec
 5: xsaves
-6: VMPTRLD Mq | VMCLEAR Mq (66) | VMXON Mq (F3) | RDRAND Rv (11B)
+6: VMPTRLD Mq | VMCLEAR Mq (66) | VMXON Mq (F3) | RDRAND Rv (11B) | SENDUIPI Gq (F3)
 7: VMPTRST Mq | VMPTRST Mq (F3) | RDSEED Rv (11B)
 EndTable
 
-- 
2.25.1

