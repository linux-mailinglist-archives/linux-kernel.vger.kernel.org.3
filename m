Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD749755B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiAWTpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:45:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38864 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbiAWTo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:44:59 -0500
Date:   Sun, 23 Jan 2022 19:44:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642967097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G2BgWfXOOYXNTF6VJE9y2Ah2MfQBWPK1+UzxlTeQjK8=;
        b=O1tYuaGfXlthYK5nBcuNKLonrNDj/CMhfJZif5Vj1PwEG1kMoq0MiGJytlWJwPQT2GiRRl
        vxKUeYUwFoZCNfwqWF/5KKDs4eWoGCOyQ67KKxpiHvXzCGLlxswtjC/SpyIbcZATtXcJcs
        wskTJTmuT6Ix3kh3Mcf5u8hVfj4gLbg5og2XaO13+9XasDr7nd0KMnZRMlnR7iYzAsqjE8
        0n0hyLh/vOIIM/faVtCX6s+TMfnUJIRpGiZGPJdm67p33a8/z9hCxXqiZ/4esMdCKHlROW
        vQt1cQCcJgJwikOwyhTHAv5M7vAhW4+N6WM823SxoVK6mrohK2JxWB18EzN2Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642967097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G2BgWfXOOYXNTF6VJE9y2Ah2MfQBWPK1+UzxlTeQjK8=;
        b=1KvLXPrWXpdXn9yGxGaDEA9qs/DBN05VLRKrYq9yqdMPRumEyfngkmpkS2+9jglphVhfJv
        IMuuG2gbiz3kyPAQ==
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/insn: Add AMX instructions to the x86 instruction decoder
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211202095029.2165714-3-adrian.hunter@intel.com>
References: <20211202095029.2165714-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164296709676.16921.12025022630752089334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     9dd94df75b30eca03ed2151dd5bbc152a6f19abf
Gitweb:        https://git.kernel.org/tip/9dd94df75b30eca03ed2151dd5bbc152a6f19abf
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 Dec 2021 11:50:25 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 23 Jan 2022 20:37:46 +01:00

x86/insn: Add AMX instructions to the x86 instruction decoder

The x86 instruction decoder is used for both kernel instructions and
user space instructions (e.g. uprobes, perf tools Intel PT), so it is
good to update it with new instructions.

Add AMX instructions to the x86 instruction decoder.

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
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20211202095029.2165714-3-adrian.hunter@intel.com
---
 arch/x86/lib/x86-opcode-map.txt       | 10 ++++++++--
 tools/arch/x86/lib/x86-opcode-map.txt | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index ec31f5b..b2cc6c0 100644
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
index ec31f5b..b2cc6c0 100644
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
