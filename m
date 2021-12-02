Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422FA4660AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356624AbhLBJyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:54:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:56004 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356608AbhLBJyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:54:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="260668441"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="260668441"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:50:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="677605146"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2021 01:50:37 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>, chang.seok.bae@intel.com
Subject: [PATCH 2/6] x86/insn: Add AMX instructions to x86 instruction decoder
Date:   Thu,  2 Dec 2021 11:50:25 +0200
Message-Id: <20211202095029.2165714-3-adrian.hunter@intel.com>
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

Add AMX instructions to x86 instruction decoder.

Reference:
Intel Architecture Instruction Set Extensions and Future Features
Programming Reference
May 2021
Document Number: 319433-044

Example using perf tools' x86 instruction decoder test:

  $ INSN='ldtilecfg\|sttilecfg\|tdpbf16ps\|tdpbssd\|'
  $ INSN+='tdpbsud\|tdpbusd\|'tdpbuud\|tileloadd\|'
  $ INSN+='tileloaddt1\|tilerelease\|tilestored\|tilezero'
  $ perf test -v "x86 instruction decoder" |& grep -i $INSN
  Decoded ok: c4 e2 78 49 04 c8    	ldtilecfg (%rax,%rcx,8)
  Decoded ok: c4 c2 78 49 04 c8    	ldtilecfg (%r8,%rcx,8)
  Decoded ok: c4 e2 79 49 04 c8    	sttilecfg (%rax,%rcx,8)
  Decoded ok: c4 c2 79 49 04 c8    	sttilecfg (%r8,%rcx,8)
  Decoded ok: c4 e2 7a 5c d1       	tdpbf16ps %tmm0,%tmm1,%tmm2
  Decoded ok: c4 e2 7b 5e d1       	tdpbssd %tmm0,%tmm1,%tmm2
  Decoded ok: c4 e2 7a 5e d1       	tdpbsud %tmm0,%tmm1,%tmm2
  Decoded ok: c4 e2 79 5e d1       	tdpbusd %tmm0,%tmm1,%tmm2
  Decoded ok: c4 e2 78 5e d1       	tdpbuud %tmm0,%tmm1,%tmm2
  Decoded ok: c4 e2 7b 4b 0c c8    	tileloadd (%rax,%rcx,8),%tmm1
  Decoded ok: c4 c2 7b 4b 14 c8    	tileloadd (%r8,%rcx,8),%tmm2
  Decoded ok: c4 e2 79 4b 0c c8    	tileloaddt1 (%rax,%rcx,8),%tmm1
  Decoded ok: c4 c2 79 4b 14 c8    	tileloaddt1 (%r8,%rcx,8),%tmm2
  Decoded ok: c4 e2 78 49 c0       	tilerelease
  Decoded ok: c4 e2 7a 4b 0c c8    	tilestored %tmm1,(%rax,%rcx,8)
  Decoded ok: c4 c2 7a 4b 14 c8    	tilestored %tmm2,(%r8,%rcx,8)
  Decoded ok: c4 e2 7b 49 c0       	tilezero %tmm0
  Decoded ok: c4 e2 7b 49 f8       	tilezero %tmm7

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/lib/x86-opcode-map.txt       | 10 ++++++++--
 tools/arch/x86/lib/x86-opcode-map.txt | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..b2cc6c04cbfe 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -690,7 +690,10 @@ AVXcode: 2
 45: vpsrlvd/q Vx,Hx,Wx (66),(v)
 46: vpsravd Vx,Hx,Wx (66),(v) | vpsravd/q Vx,Hx,Wx (66),(evo)
 47: vpsllvd/q Vx,Hx,Wx (66),(v)
-# Skip 0x48-0x4b
+# Skip 0x48
+49: TILERELEASE (v1),(000),(11B) | LDTILECFG Mtc (v1)(000) | STTILECFG Mtc (66),(v1),(000) | TILEZERO Vt (F2),(v1),(11B)
+# Skip 0x4a
+4b: TILELOADD Vt,Wsm (F2),(v1) | TILELOADDT1 Vt,Wsm (66),(v1) | TILESTORED Wsm,Vt (F3),(v)
 4c: vrcp14ps/d Vpd,Wpd (66),(ev)
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
@@ -705,7 +708,10 @@ AVXcode: 2
 59: vpbroadcastq Vx,Wx (66),(v) | vbroadcasti32x2 Vx,Wx (66),(evo)
 5a: vbroadcasti128 Vqq,Mdq (66),(v) | vbroadcasti32x4/64x2 Vx,Wx (66),(evo)
 5b: vbroadcasti32x8/64x4 Vqq,Mdq (66),(ev)
-# Skip 0x5c-0x61
+5c: TDPBF16PS Vt,Wt,Ht (F3),(v1)
+# Skip 0x5d
+5e: TDPBSSD Vt,Wt,Ht (F2),(v1) | TDPBSUD Vt,Wt,Ht (F3),(v1) | TDPBUSD Vt,Wt,Ht (66),(v1) | TDPBUUD Vt,Wt,Ht (v1)
+# Skip 0x5f-0x61
 62: vpexpandb/w Vx,Wx (66),(ev)
 63: vpcompressb/w Wx,Vx (66),(ev)
 64: vpblendmd/q Vx,Hx,Wx (66),(ev)
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..b2cc6c04cbfe 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -690,7 +690,10 @@ AVXcode: 2
 45: vpsrlvd/q Vx,Hx,Wx (66),(v)
 46: vpsravd Vx,Hx,Wx (66),(v) | vpsravd/q Vx,Hx,Wx (66),(evo)
 47: vpsllvd/q Vx,Hx,Wx (66),(v)
-# Skip 0x48-0x4b
+# Skip 0x48
+49: TILERELEASE (v1),(000),(11B) | LDTILECFG Mtc (v1)(000) | STTILECFG Mtc (66),(v1),(000) | TILEZERO Vt (F2),(v1),(11B)
+# Skip 0x4a
+4b: TILELOADD Vt,Wsm (F2),(v1) | TILELOADDT1 Vt,Wsm (66),(v1) | TILESTORED Wsm,Vt (F3),(v)
 4c: vrcp14ps/d Vpd,Wpd (66),(ev)
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
@@ -705,7 +708,10 @@ AVXcode: 2
 59: vpbroadcastq Vx,Wx (66),(v) | vbroadcasti32x2 Vx,Wx (66),(evo)
 5a: vbroadcasti128 Vqq,Mdq (66),(v) | vbroadcasti32x4/64x2 Vx,Wx (66),(evo)
 5b: vbroadcasti32x8/64x4 Vqq,Mdq (66),(ev)
-# Skip 0x5c-0x61
+5c: TDPBF16PS Vt,Wt,Ht (F3),(v1)
+# Skip 0x5d
+5e: TDPBSSD Vt,Wt,Ht (F2),(v1) | TDPBSUD Vt,Wt,Ht (F3),(v1) | TDPBUSD Vt,Wt,Ht (66),(v1) | TDPBUUD Vt,Wt,Ht (v1)
+# Skip 0x5f-0x61
 62: vpexpandb/w Vx,Wx (66),(ev)
 63: vpcompressb/w Wx,Vx (66),(ev)
 64: vpblendmd/q Vx,Hx,Wx (66),(ev)
-- 
2.25.1

