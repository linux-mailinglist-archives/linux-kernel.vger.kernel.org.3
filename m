Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DFE4D996C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347590AbiCOKr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347405AbiCOKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26EB5132F;
        Tue, 15 Mar 2022 03:44:17 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofiVoDxNxT7b89G+pCs4a9qqcM1lqY7Fm+d3WtFPzXo=;
        b=1BDMEFONE3cXrMCu5RyMNL2Gjuc3HjViG2kLu1Ym4vzS61QiPcUkBY1xXhKA+NBhEyVqeC
        C9c09imt+5Lc6+JjsdF41nXDAwxjPGqX3+aBY4vSeHdYlmJMk8YZ8gCNoZxYFl/BZKzyGj
        F/1BzcO86zrJartQLz6n13tIWdY9kNEAmiBoGfipLDH0SMGaXCB7zru6hpkYEh/hpISI+9
        4clXsa5E7Ojb1C14wtwpOHabVw9pwgqWTE9n1cJugSgDEn45JuMZTUTctBO4MOr8sYBfO0
        gWh5BtrL0NKKEFsZyZAKvdgqGU5uTb9KdTZt16Z8WyLq8ortLe14CwIpGfnV4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofiVoDxNxT7b89G+pCs4a9qqcM1lqY7Fm+d3WtFPzXo=;
        b=j44IKHvyh/KBYM+Hzj4VwbBzX5KVf29QMCXCkF8X8GKRBMh+EYW53kPM4WWbH+7L9MB+N0
        ZMD41z7lTqdvTcCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool,efi: Update __efi64_thunk annotation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.402118218@infradead.org>
References: <20220308154317.402118218@infradead.org>
MIME-Version: 1.0
Message-ID: <164734105479.16921.842689798874309480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     537da1ed54658e916141e50923a7f5b20c728856
Gitweb:        https://git.kernel.org/tip/537da1ed54658e916141e50923a7f5b20c728856
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:32 +01:00

objtool,efi: Update __efi64_thunk annotation

The current annotation relies on not running objtool on the file; this
won't work when running objtool on vmlinux.o. Instead explicitly mark
__efi64_thunk() to be ignored.

This preserves the status quo, which is somewhat unfortunate. Luckily
this code is hardly ever used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.402118218@infradead.org
---
 arch/x86/platform/efi/Makefile       | 1 -
 arch/x86/platform/efi/efi_thunk_64.S | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index 84b09c2..a502451 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
 KASAN_SANITIZE := n
 GCOV_PROFILE := n
 
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 25799d7..854dd81 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -20,12 +20,14 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <asm/page_types.h>
 #include <asm/segment.h>
 
 	.text
 	.code64
-SYM_CODE_START(__efi64_thunk)
+SYM_FUNC_START(__efi64_thunk)
+STACK_FRAME_NON_STANDARD __efi64_thunk
 	push	%rbp
 	push	%rbx
 
@@ -79,7 +81,7 @@ SYM_CODE_START(__efi64_thunk)
 2:	pushl	$__KERNEL_CS
 	pushl	%ebp
 	lret
-SYM_CODE_END(__efi64_thunk)
+SYM_FUNC_END(__efi64_thunk)
 
 	.bss
 	.balign 8
