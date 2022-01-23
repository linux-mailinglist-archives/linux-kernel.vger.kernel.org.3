Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38E49755A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbiAWTpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbiAWTo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:44:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FB7C061401;
        Sun, 23 Jan 2022 11:44:58 -0800 (PST)
Date:   Sun, 23 Jan 2022 19:44:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642967096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VegsggeBnvaV8UQUUPNWzG4f575DbNpp3Vzmh4wFu78=;
        b=IfiMr6PwyirixR4gCNd6xMMsfU0BY6W179UeNFrSpjSKPoMHqRvBvHJYaAVFCuDb483ynQ
        lQc6MwIYt7oN5axvaBb9FnHnGova+VxO0DpDTO2Sxq8OZD+2vUcqJcoaxtORVfwKX5lcsh
        FlwpFpmDm9XqrcIBbpWJYv0+z6GQY3qi/0HjM0yG7yZEVJnOVeP7kmSMIvI/kU/6CGHP0P
        E+ricYLCAXKStKKUyDdvRZReDppOnSJCUL4hO6UeSa7UEb9b9kdlmgaxb9AOKY8u4qm3lV
        8X8cLaPZxNN3XCtqKUw0TX1/p9lnQRo/0sNDxRlhwzrTqJPTzFhQCJHbrhj3ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642967096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VegsggeBnvaV8UQUUPNWzG4f575DbNpp3Vzmh4wFu78=;
        b=sexV8iBFQGALOHXvyPkRXikpL9bvhY9mDDW/H5W5mlgr888tIs+r/KqYeDoNe0bJyIt8nW
        cP5XER1VLboWbNCw==
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] perf/tests: Add misc instructions to the x86
 instruction decoder test
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211202095029.2165714-4-adrian.hunter@intel.com>
References: <20211202095029.2165714-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164296709589.16921.8931307392168492759.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     a6ea1142dee66f054a7ce51ebd053ef5ad976227
Gitweb:        https://git.kernel.org/tip/a6ea1142dee66f054a7ce51ebd053ef5ad976227
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 Dec 2021 11:50:26 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 23 Jan 2022 20:37:50 +01:00

perf/tests: Add misc instructions to the x86 instruction decoder test

The x86 instruction decoder is used for both kernel instructions and
user space instructions (e.g. uprobes, perf tools Intel PT), so it is
good to update it with new instructions.

Add the following instructions to the x86 instruction decoder test:

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

A subsequent patch adds the instructions to the instruction decoder.

Reference:
Intel Architecture Instruction Set Extensions and Future Features
Programming Reference
May 2021
Document Number: 319433-044

Example:

  $ perf test -v "x86 instruction decoder" |& grep -i hreset
  Failed to decode length (4 vs expected 6): f3 0f 3a f0 c0 00    	hreset $0x0
  Failed to decode length (4 vs expected 6): f3 0f 3a f0 c0 00    	hreset $0x0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20211202095029.2165714-4-adrian.hunter@intel.com
---
 tools/perf/arch/x86/tests/insn-x86-dat-32.c  |  8 +++++++-
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 20 +++++++++++++++++-
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 22 +++++++++++++++++++-
 3 files changed, 50 insertions(+)

diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-32.c b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
index 9708ae8..79e2050 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-32.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
@@ -2197,6 +2197,14 @@
 "3e f2 ff 25 78 56 34 12 \tnotrack bnd jmp *0x12345678",},
 {{0x3e, 0xf2, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "jmp", "indirect",
 "3e f2 ff a4 c8 78 56 34 12 \tnotrack bnd jmp *0x12345678(%eax,%ecx,8)",},
+{{0xf3, 0x0f, 0x3a, 0xf0, 0xc0, 0x00, }, 6, 0, "", "",
+"f3 0f 3a f0 c0 00    \threset $0x0",},
+{{0x0f, 0x01, 0xe8, }, 3, 0, "", "",
+"0f 01 e8             \tserialize ",},
+{{0xf2, 0x0f, 0x01, 0xe9, }, 4, 0, "", "",
+"f2 0f 01 e9          \txresldtrk ",},
+{{0xf2, 0x0f, 0x01, 0xe8, }, 4, 0, "", "",
+"f2 0f 01 e8          \txsusldtrk ",},
 {{0x0f, 0x01, 0xcf, }, 3, 0, "", "",
 "0f 01 cf             \tencls  ",},
 {{0x0f, 0x01, 0xd7, }, 3, 0, "", "",
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-64.c b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
index 3548565..b2d0ba4 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-64.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
@@ -2495,6 +2495,26 @@
 "c4 e2 7b 49 c0       \ttilezero %tmm0",},
 {{0xc4, 0xe2, 0x7b, 0x49, 0xf8, }, 5, 0, "", "",
 "c4 e2 7b 49 f8       \ttilezero %tmm7",},
+{{0xf3, 0x0f, 0x01, 0xee, }, 4, 0, "", "",
+"f3 0f 01 ee          \tclui   ",},
+{{0xf3, 0x0f, 0xc7, 0xf0, }, 4, 0, "", "",
+"f3 0f c7 f0          \tsenduipi %rax",},
+{{0xf3, 0x41, 0x0f, 0xc7, 0xf0, }, 5, 0, "", "",
+"f3 41 0f c7 f0       \tsenduipi %r8",},
+{{0xf3, 0x0f, 0x01, 0xef, }, 4, 0, "", "",
+"f3 0f 01 ef          \tstui   ",},
+{{0xf3, 0x0f, 0x01, 0xed, }, 4, 0, "", "",
+"f3 0f 01 ed          \ttestui ",},
+{{0xf3, 0x0f, 0x01, 0xec, }, 4, 0, "", "",
+"f3 0f 01 ec          \tuiret  ",},
+{{0xf3, 0x0f, 0x3a, 0xf0, 0xc0, 0x00, }, 6, 0, "", "",
+"f3 0f 3a f0 c0 00    \threset $0x0",},
+{{0x0f, 0x01, 0xe8, }, 3, 0, "", "",
+"0f 01 e8             \tserialize ",},
+{{0xf2, 0x0f, 0x01, 0xe9, }, 4, 0, "", "",
+"f2 0f 01 e9          \txresldtrk ",},
+{{0xf2, 0x0f, 0x01, 0xe8, }, 4, 0, "", "",
+"f2 0f 01 e8          \txsusldtrk ",},
 {{0x0f, 0x01, 0xcf, }, 3, 0, "", "",
 "0f 01 cf             \tencls  ",},
 {{0x0f, 0x01, 0xd7, }, 3, 0, "", "",
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-src.c b/tools/perf/arch/x86/tests/insn-x86-dat-src.c
index 7906f7b..425db6a 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-src.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-src.c
@@ -1931,6 +1931,15 @@ int main(void)
 	asm volatile("tilezero %tmm0");
 	asm volatile("tilezero %tmm7");
 
+	/* User Interrupt */
+
+	asm volatile("clui");
+	asm volatile("senduipi %rax");
+	asm volatile("senduipi %r8");
+	asm volatile("stui");
+	asm volatile("testui");
+	asm volatile("uiret");
+
 #else  /* #ifdef __x86_64__ */
 
 	/* bound r32, mem (same op code as EVEX prefix) */
@@ -3693,6 +3702,19 @@ int main(void)
 
 #endif /* #ifndef __x86_64__ */
 
+	/* Prediction history reset */
+
+	asm volatile("hreset $0");
+
+	/* Serialize instruction execution */
+
+	asm volatile("serialize");
+
+	/* TSX suspend load address tracking */
+
+	asm volatile("xresldtrk");
+	asm volatile("xsusldtrk");
+
 	/* SGX */
 
 	asm volatile("encls");
