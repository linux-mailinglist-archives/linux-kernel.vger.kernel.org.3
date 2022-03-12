Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3C4D6EAE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 13:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiCLMi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 07:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCLMi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 07:38:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54EB6161;
        Sat, 12 Mar 2022 04:37:21 -0800 (PST)
Date:   Sat, 12 Mar 2022 12:37:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647088640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qaTble2oQ+4Cpxf/5u7imIc/SVViBYoo9IryJwIXqc=;
        b=P9YTw+4Ah7LBJy7Dmz2CQ/rSw3RvqHAuc+RcCJafH6YDNFBnpYtGvSa1zyJycOqDJ9Ejy7
        w3BciebBb0PUVHIL58sEy5sjjv+dLM6KagalMkIkR3qXbGP7I4t5j+a197Oo5m31lAWut8
        FwkuM/DmOMHoo1QBCpiq6oHuH3IZgN1OLyKKYmLDNiEWHdU1gyL44qLn0oM3IthcvtECl3
        gHUmsp23LqvLBtjacrtLpHnTWn99r7O/BmC8xavtmkzBv4yagIZ3scOz4uvF6o5bwZft4d
        YhP4OUNdgwW4bcI9CTNIdLsYxjNIUO5nQ9eI8Njtz81WP0cCy5aPfm5KWhklnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647088640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qaTble2oQ+4Cpxf/5u7imIc/SVViBYoo9IryJwIXqc=;
        b=A/pylF72953rLAlSdgcC1nfBZ1q5fKwOBtT9ZblnCujotZtMMsBKu/sulMQGw5F9X4Gjw3
        1qLyTryBpx23J+Dg==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Fix CC_HAS_IBT check for clang
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220311195642.2033108-1-nathan@kernel.org>
References: <20220311195642.2033108-1-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <164708863928.16921.14086507228609940442.tip-bot2@tip-bot2>
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

Commit-ID:     f8afc9d88e65d189653f363eacc1f3131216ef7c
Gitweb:        https://git.kernel.org/tip/f8afc9d88e65d189653f363eacc1f3131216ef7c
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Fri, 11 Mar 2022 12:56:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 12 Mar 2022 13:22:13 +01:00

x86/ibt: Fix CC_HAS_IBT check for clang

Commit 41c5ef31ad71 ("x86/ibt: Base IBT bits") added a check for a crash
in clang. However, this check does not work for two reasons.

The first reason is that '-pg' is missing from the check, which is
required for '-mfentry' to do anything.

The second reason is that cc-option only uses /dev/null as the input
file, which does not show a problem:

$ clang --version | head -1
Ubuntu clang version 12.0.1-8build1

$ clang -fcf-protection=branch -mfentry -pg -c -x c /dev/null -o /dev/null

$ echo $?
0

$ echo "void a(void) {}" | clang -fcf-protection=branch -mfentry -pg -c -x c - -o /dev/null
...

$ echo $?
139

Use this test instead so that the check works for older versions of
clang.

Fixes: 41c5ef31ad71 ("x86/ibt: Base IBT bits")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220311195642.2033108-1-nathan@kernel.org
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4ca7bfe..870e0d1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1867,7 +1867,7 @@ config CC_HAS_IBT
 	# Clang/LLVM >= 14
 	# fentry check to work around https://reviews.llvm.org/D111108
 	def_bool ((CC_IS_GCC && $(cc-option, -fcf-protection=branch -mindirect-branch-register)) || \
-		  (CC_IS_CLANG && $(cc-option, -fcf-protection=branch -mfentry))) && \
+		  (CC_IS_CLANG && $(success,echo "void a(void) {}" | $(CC) -Werror $(CLANG_FLAGS) -fcf-protection=branch -mfentry -pg -x c - -c -o /dev/null))) && \
 		  $(as-instr,endbr64)
 
 config X86_KERNEL_IBT
