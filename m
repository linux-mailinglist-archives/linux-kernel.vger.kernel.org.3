Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D044D2A18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiCIH56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiCIH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F57166A64;
        Tue,  8 Mar 2022 23:55:16 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=stA61fcD5w5nUsopVJOsKkSXIWNWdq3D/vij4lbqLwE=;
        b=VUibsTKDBbgGzsbq4q6qMx/Aoxol9UAzj6LpEgNYLc8tln8fPvogo3ItTHymkBnMbKiYoU
        OOWLwtDaAmKOakReUytOmQXqhE2mOyHIQMEb2t6X87f6QAdGhD9mK+ySMVywnDqJBMI/X2
        q8ECZfDLtSrH/gDMlu/vflZWpCjiROlOeNu86uC3AMlxZkggBg7xLm+RBiQK0ldZcl7wv6
        jCy+b6L9CWDaW9vG8Z2NB44X2M/MElrUp9xp5O/FDw81kXdZVGiy6uhkTgMSDYVSHEb31t
        +j+JRE/bOU3j/nbXElfglljhy8oLgNlehOxxOs61uQ4nlX+XKvl9kqEHX5hySw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=stA61fcD5w5nUsopVJOsKkSXIWNWdq3D/vij4lbqLwE=;
        b=GOk+p18baovsu7e+EISWWgCA8cIIQHveuujvMcnqTLYH+tkrGixAJA571GxJJANXiKDwdT
        mU7rzLxTwwTj8MCA==
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
Message-ID: <164681251438.16921.12937403000114406105.tip-bot2@tip-bot2>
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

Commit-ID:     f99b84d14feba2ac011b1a21ceae4aa9e3fe49e8
Gitweb:        https://git.kernel.org/tip/f99b84d14feba2ac011b1a21ceae4aa9e3fe49e8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:27 +01:00

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
