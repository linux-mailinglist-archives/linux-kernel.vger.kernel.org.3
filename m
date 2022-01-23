Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017F6497554
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbiAWTpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiAWTo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:44:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C6DC06173D;
        Sun, 23 Jan 2022 11:44:57 -0800 (PST)
Date:   Sun, 23 Jan 2022 19:44:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642967096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TM9soNCJboITFmNVzU2NlgFaz9sCKFGG0XmUROJicDo=;
        b=Prqi5Jhv8YE1Xv/wx5gZVwTDZVr93Fv12+ap/sfrceyBNNycKGWLidXqSSU82bTVKoVy8q
        YoE3obI2ccuofYwHqfEz3xgGxNOI8A3od7uzymH1igrzywsRSrFbROUA+nPuqCoQJ6qrXx
        Sle3166UU6teTC4bidTAvwHHE2tJhOCuQ2QGhg3tXDazntidEGcel0xRKFs4PQnVDWgU8H
        mAuZsh4FIwu5p4ghvcc/QrQQboZ3UqaEhpJZpsGd4MCYislqmcpCspdEiFfWsi72h5kiJS
        jZAdFVfPUltablyutswV0JuhzPzchr1i9lZo3tE209dQwNw9Qrok1oBTAQ7gfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642967096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TM9soNCJboITFmNVzU2NlgFaz9sCKFGG0XmUROJicDo=;
        b=uHQY6SX6jZJQKSRjj/ExybVsOX7GId7gaxAHVOCfDF2JC2bLGTJOjAh+SFkEtrQnLijfuY
        1KqgBxPATIWOLtAA==
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/insn: Add misc instructions to x86 instruction decoder
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211202095029.2165714-5-adrian.hunter@intel.com>
References: <20211202095029.2165714-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164296709502.16921.15205293293969486611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     0153d98f2dd6d5161fc4d496d785c10686d0d7b6
Gitweb:        https://git.kernel.org/tip/0153d98f2dd6d5161fc4d496d785c10686d0d7b6
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 Dec 2021 11:50:27 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 23 Jan 2022 20:37:54 +01:00

x86/insn: Add misc instructions to x86 instruction decoder

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
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20211202095029.2165714-5-adrian.hunter@intel.com
---
 arch/x86/lib/x86-opcode-map.txt       | 6 +++---
 tools/arch/x86/lib/x86-opcode-map.txt | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index b2cc6c0..591797a 100644
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
index b2cc6c0..591797a 100644
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
 
