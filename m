Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B949755C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbiAWTpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiAWTpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:45:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BCCC061747;
        Sun, 23 Jan 2022 11:45:00 -0800 (PST)
Date:   Sun, 23 Jan 2022 19:44:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642967098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HkpvBqfRx7KsvzCvKz6Aih4iVGHdbFXqW/a8qrWzHcg=;
        b=JiuvGCNziBFlmU/Vbxxh0rGCnUveidGPuRIBXu2nH/XMyUDAmp4W6NKYLP4iqtTnDmzi1N
        +ZXDGhbGVzMuyQNthSB5zBEN++28d+ItdOeFRJAQUxfQdXKY3j2omzeGxNcNlcJnAUuRWT
        frFi3CwIAd5+Z5Nwa1V656RTWbGT4ea8ta+Uwg4TLmnUzDdMiMTjaThxQmB1/WLJRz0+Ru
        kRdUp9KrRH2PZCLSRGwBFgakU5KSutz5vaHv7PIfYJXy4McG8OecggcIcYs1Lrhh1zf9hl
        Vnqabz0OcU0RKaGJp6grS3BpCSs/d6E8snGXcEpr41QpiZZosARlimenu7bFaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642967098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HkpvBqfRx7KsvzCvKz6Aih4iVGHdbFXqW/a8qrWzHcg=;
        b=B70eRow+yovAC6oU4edwpwZh8z1P70WTBnOxEZt3zQ47nU2A32iUPqtoQ4gqaNSkCfD8+V
        nw11Jyeeh33nl+Aw==
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] perf/tests: Add AMX instructions to x86 instruction
 decoder test
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211202095029.2165714-2-adrian.hunter@intel.com>
References: <20211202095029.2165714-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164296709764.16921.15346454086720097619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     4810dd2c943edd98cd41a12b96745b16b1d6b4f5
Gitweb:        https://git.kernel.org/tip/4810dd2c943edd98cd41a12b96745b16b1d6b4f5
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 Dec 2021 11:50:24 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 23 Jan 2022 20:37:42 +01:00

perf/tests: Add AMX instructions to x86 instruction decoder test

The x86 instruction decoder is used for both kernel instructions and
user space instructions (e.g. uprobes, perf tools Intel PT), so it is
good to update it with new instructions.

Add AMX instructions to the x86 instruction decoder test.

A subsequent patch adds the instructions to the instruction decoder.

Reference:
Intel Architecture Instruction Set Extensions and Future Features
Programming Reference
May 2021
Document Number: 319433-044

Example:

  $ INSN='ldtilecfg\|sttilecfg\|tdpbf16ps\|tdpbssd\|'
  $ INSN+='tdpbsud\|tdpbusd\|'tdpbuud\|tileloadd\|'
  $ INSN+='tileloaddt1\|tilerelease\|tilestored\|tilezero'
  $ perf test -v "x86 instruction decoder" |& grep -i $INSN
  Failed to decode: c4 e2 78 49 04 c8    	ldtilecfg (%rax,%rcx,8)
  Failed to decode: c4 c2 78 49 04 c8    	ldtilecfg (%r8,%rcx,8)
  Failed to decode: c4 e2 79 49 04 c8    	sttilecfg (%rax,%rcx,8)
  Failed to decode: c4 c2 79 49 04 c8    	sttilecfg (%r8,%rcx,8)
  Failed to decode: c4 e2 7a 5c d1       	tdpbf16ps %tmm0,%tmm1,%tmm2
  Failed to decode: c4 e2 7b 5e d1       	tdpbssd %tmm0,%tmm1,%tmm2
  Failed to decode: c4 e2 7a 5e d1       	tdpbsud %tmm0,%tmm1,%tmm2
  Failed to decode: c4 e2 79 5e d1       	tdpbusd %tmm0,%tmm1,%tmm2
  Failed to decode: c4 e2 78 5e d1       	tdpbuud %tmm0,%tmm1,%tmm2
  Failed to decode: c4 e2 7b 4b 0c c8    	tileloadd (%rax,%rcx,8),%tmm1
  Failed to decode: c4 c2 7b 4b 14 c8    	tileloadd (%r8,%rcx,8),%tmm2
  Failed to decode: c4 e2 79 4b 0c c8    	tileloaddt1 (%rax,%rcx,8),%tmm1
  Failed to decode: c4 c2 79 4b 14 c8    	tileloaddt1 (%r8,%rcx,8),%tmm2
  Failed to decode: c4 e2 78 49 c0       	tilerelease
  Failed to decode: c4 e2 7a 4b 0c c8    	tilestored %tmm1,(%rax,%rcx,8)
  Failed to decode: c4 c2 7a 4b 14 c8    	tilestored %tmm2,(%r8,%rcx,8)
  Failed to decode: c4 e2 7b 49 c0       	tilezero %tmm0
  Failed to decode: c4 e2 7b 49 f8       	tilezero %tmm7

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20211202095029.2165714-2-adrian.hunter@intel.com
---
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 36 +++++++++++++++++++-
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 21 +++++++++++-
 2 files changed, 57 insertions(+)

diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-64.c b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
index 5da17d4..3548565 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-64.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
@@ -2459,6 +2459,42 @@
 "3e f2 ff a4 c8 78 56 34 12 \tnotrack bnd jmpq *0x12345678(%rax,%rcx,8)",},
 {{0x3e, 0xf2, 0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "jmp", "indirect",
 "3e f2 41 ff a4 c8 78 56 34 12 \tnotrack bnd jmpq *0x12345678(%r8,%rcx,8)",},
+{{0xc4, 0xe2, 0x78, 0x49, 0x04, 0xc8, }, 6, 0, "", "",
+"c4 e2 78 49 04 c8    \tldtilecfg (%rax,%rcx,8)",},
+{{0xc4, 0xc2, 0x78, 0x49, 0x04, 0xc8, }, 6, 0, "", "",
+"c4 c2 78 49 04 c8    \tldtilecfg (%r8,%rcx,8)",},
+{{0xc4, 0xe2, 0x79, 0x49, 0x04, 0xc8, }, 6, 0, "", "",
+"c4 e2 79 49 04 c8    \tsttilecfg (%rax,%rcx,8)",},
+{{0xc4, 0xc2, 0x79, 0x49, 0x04, 0xc8, }, 6, 0, "", "",
+"c4 c2 79 49 04 c8    \tsttilecfg (%r8,%rcx,8)",},
+{{0xc4, 0xe2, 0x7a, 0x5c, 0xd1, }, 5, 0, "", "",
+"c4 e2 7a 5c d1       \ttdpbf16ps %tmm0,%tmm1,%tmm2",},
+{{0xc4, 0xe2, 0x7b, 0x5e, 0xd1, }, 5, 0, "", "",
+"c4 e2 7b 5e d1       \ttdpbssd %tmm0,%tmm1,%tmm2",},
+{{0xc4, 0xe2, 0x7a, 0x5e, 0xd1, }, 5, 0, "", "",
+"c4 e2 7a 5e d1       \ttdpbsud %tmm0,%tmm1,%tmm2",},
+{{0xc4, 0xe2, 0x79, 0x5e, 0xd1, }, 5, 0, "", "",
+"c4 e2 79 5e d1       \ttdpbusd %tmm0,%tmm1,%tmm2",},
+{{0xc4, 0xe2, 0x78, 0x5e, 0xd1, }, 5, 0, "", "",
+"c4 e2 78 5e d1       \ttdpbuud %tmm0,%tmm1,%tmm2",},
+{{0xc4, 0xe2, 0x7b, 0x4b, 0x0c, 0xc8, }, 6, 0, "", "",
+"c4 e2 7b 4b 0c c8    \ttileloadd (%rax,%rcx,8),%tmm1",},
+{{0xc4, 0xc2, 0x7b, 0x4b, 0x14, 0xc8, }, 6, 0, "", "",
+"c4 c2 7b 4b 14 c8    \ttileloadd (%r8,%rcx,8),%tmm2",},
+{{0xc4, 0xe2, 0x79, 0x4b, 0x0c, 0xc8, }, 6, 0, "", "",
+"c4 e2 79 4b 0c c8    \ttileloaddt1 (%rax,%rcx,8),%tmm1",},
+{{0xc4, 0xc2, 0x79, 0x4b, 0x14, 0xc8, }, 6, 0, "", "",
+"c4 c2 79 4b 14 c8    \ttileloaddt1 (%r8,%rcx,8),%tmm2",},
+{{0xc4, 0xe2, 0x78, 0x49, 0xc0, }, 5, 0, "", "",
+"c4 e2 78 49 c0       \ttilerelease ",},
+{{0xc4, 0xe2, 0x7a, 0x4b, 0x0c, 0xc8, }, 6, 0, "", "",
+"c4 e2 7a 4b 0c c8    \ttilestored %tmm1,(%rax,%rcx,8)",},
+{{0xc4, 0xc2, 0x7a, 0x4b, 0x14, 0xc8, }, 6, 0, "", "",
+"c4 c2 7a 4b 14 c8    \ttilestored %tmm2,(%r8,%rcx,8)",},
+{{0xc4, 0xe2, 0x7b, 0x49, 0xc0, }, 5, 0, "", "",
+"c4 e2 7b 49 c0       \ttilezero %tmm0",},
+{{0xc4, 0xe2, 0x7b, 0x49, 0xf8, }, 5, 0, "", "",
+"c4 e2 7b 49 f8       \ttilezero %tmm7",},
 {{0x0f, 0x01, 0xcf, }, 3, 0, "", "",
 "0f 01 cf             \tencls  ",},
 {{0x0f, 0x01, 0xd7, }, 3, 0, "", "",
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-src.c b/tools/perf/arch/x86/tests/insn-x86-dat-src.c
index c3808e9..7906f7b 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-src.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-src.c
@@ -1910,6 +1910,27 @@ int main(void)
 	asm volatile("notrack bnd jmpq *0x12345678(%rax,%rcx,8)");	/* Expecting: jmp indirect 0 */
 	asm volatile("notrack bnd jmpq *0x12345678(%r8,%rcx,8)");	/* Expecting: jmp indirect 0 */
 
+	/* AMX */
+
+	asm volatile("ldtilecfg (%rax,%rcx,8)");
+	asm volatile("ldtilecfg (%r8,%rcx,8)");
+	asm volatile("sttilecfg (%rax,%rcx,8)");
+	asm volatile("sttilecfg (%r8,%rcx,8)");
+	asm volatile("tdpbf16ps %tmm0, %tmm1, %tmm2");
+	asm volatile("tdpbssd %tmm0, %tmm1, %tmm2");
+	asm volatile("tdpbsud %tmm0, %tmm1, %tmm2");
+	asm volatile("tdpbusd %tmm0, %tmm1, %tmm2");
+	asm volatile("tdpbuud %tmm0, %tmm1, %tmm2");
+	asm volatile("tileloadd (%rax,%rcx,8), %tmm1");
+	asm volatile("tileloadd (%r8,%rcx,8), %tmm2");
+	asm volatile("tileloaddt1 (%rax,%rcx,8), %tmm1");
+	asm volatile("tileloaddt1 (%r8,%rcx,8), %tmm2");
+	asm volatile("tilerelease");
+	asm volatile("tilestored %tmm1, (%rax,%rcx,8)");
+	asm volatile("tilestored %tmm2, (%r8,%rcx,8)");
+	asm volatile("tilezero %tmm0");
+	asm volatile("tilezero %tmm7");
+
 #else  /* #ifdef __x86_64__ */
 
 	/* bound r32, mem (same op code as EVEX prefix) */
