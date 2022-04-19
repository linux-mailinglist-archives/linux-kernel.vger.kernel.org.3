Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D838F507ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357605AbiDSUL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357157AbiDSUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ED23C712;
        Tue, 19 Apr 2022 13:08:43 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4w8jxpYdmM6lWbdRGnbNyjXIF4bzcc3DgY6eXGpjZrA=;
        b=E2kMeMEIVIT5jU+IjTAX9LrXWvXcQBeqWsYEb3aWePhRSDv1noBGXb5jgtOCxgDJ8Y4OhX
        5gph0uNkO4Vi9HUrH03xS0ujvqzedQ6LKh76ScXQUoR0ibsIEek9D3RzLuaSu2yevAm+9f
        9kg0obbIWS50NIjoSIJNShjygA3xH3xNM4BSVUk57Sw7EaqKuaHjdpIfKDY/sP/r9DlCti
        z6fGfh0YgNHh5CldHypjLeyIuWa5MduZ1VSCx7j4OfyQrWhTchf7xNVHyuBEZHeM7V6lNH
        NnhDXJ+o6fX+kIxyNEvSU7Jmxbupf+YCnJGXWPtgqh7Fg66gMUDhjB1O+cLcXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4w8jxpYdmM6lWbdRGnbNyjXIF4bzcc3DgY6eXGpjZrA=;
        b=eH9rMn99GlwZSSNzQEEDDnj5hiePbQRSBt2WyJL6e5R4DPVxn1eikBB+TGTQGDLEtJIzjq
        hVz5kSuO0CyydtBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] objtool: Enable unreachable warnings for CLANG LTO
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <7b12df54bceeb0761fe9fc8269ea0c00501214a9.1650300597.git.jpoimboe@redhat.com>
References: <7b12df54bceeb0761fe9fc8269ea0c00501214a9.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165039892049.4207.1956726693820376052.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4a5de9b76fcb3f477f73d5a63f6e27709e8af81f
Gitweb:        https://git.kernel.org/tip/4a5de9b76fcb3f477f73d5a63f6e27709e8af81f
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:20 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:48 +02:00

objtool: Enable unreachable warnings for CLANG LTO

With IBT support in, objtool is now fully capable of following vmlinux
code flow in LTO mode.  Start reporting unreachable warnings for Clang
LTO as well.

Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/7b12df54bceeb0761fe9fc8269ea0c00501214a9.1650300597.git.jpoimboe@redhat.com
---
 scripts/Makefile.build  | 2 +-
 scripts/link-vmlinux.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9717e6f..33c1ed5 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -231,7 +231,7 @@ objtool_args =								\
 	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
 	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
-	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
+	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)			\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 20f4450..9361a1e 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -140,7 +140,7 @@ objtool_link()
 		if ! is_enabled CONFIG_FRAME_POINTER; then
 			objtoolopt="${objtoolopt} --no-fp"
 		fi
-		if is_enabled CONFIG_GCOV_KERNEL || is_enabled CONFIG_LTO_CLANG; then
+		if is_enabled CONFIG_GCOV_KERNEL; then
 			objtoolopt="${objtoolopt} --no-unreachable"
 		fi
 		if is_enabled CONFIG_RETPOLINE; then
