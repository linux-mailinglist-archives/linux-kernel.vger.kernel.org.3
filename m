Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923FE4E23A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346048AbiCUJyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346045AbiCUJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:54:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751961C931;
        Mon, 21 Mar 2022 02:53:08 -0700 (PDT)
Date:   Mon, 21 Mar 2022 09:53:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647856387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5ozfk75sTR+lMOAYEyFLx5lbU0fNr2ZE4gFceh64Co=;
        b=ctaenzuH7fTIpG6QmI4cp0SHkslskx9enL/xxcxde2QIF3yIL7bnF3JoRGyJ5NVBQAZhb8
        ZWYMBfi0ipJ2eFB19vqkSCcdD1iQ5krXPmtPbuwV6+ycgP3Lvtw3xXc1d+Cqc+ftnfs6iK
        K9YZAXBBzivCKv8muOhLZNkwOh8w3R5ijTipHCxmoOMj0R/4AgS9zZiTFczkVhndTt63+X
        fmdG3LrrP9o5G0yvCb30G85AKsqMGf+hecDWMNuIOe1awCp9m/ca/nxHC/5LCFa8jngoWe
        mHOtZQ8sXewfos1FWvFm7tJ9FXz+GyKTycBFEbRDd7q3HR8/xWafONc1d2JmHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647856387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5ozfk75sTR+lMOAYEyFLx5lbU0fNr2ZE4gFceh64Co=;
        b=Ih/i9+Vct/yxefi88d4Jbwf7P6iuGsrLAhnV40Tx84tRvz43KEmsCfM1AQOGq48p0A2Ceb
        /PYGasA+uM48zKDA==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/Kconfig: Only enable CONFIG_CC_HAS_IBT for clang
 >= 14.0.0
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220318230747.3900772-2-nathan@kernel.org>
References: <20220318230747.3900772-2-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <164785638590.389.2607767326848409657.tip-bot2@tip-bot2>
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

Commit-ID:     71a7580b17e9510e5f74c0687567f9d8b5d48f5d
Gitweb:        https://git.kernel.org/tip/71a7580b17e9510e5f74c0687567f9d8b5d48f5d
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Fri, 18 Mar 2022 16:07:46 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 19 Mar 2022 00:47:12 +01:00

x86/Kconfig: Only enable CONFIG_CC_HAS_IBT for clang >= 14.0.0

Commit 156ff4a544ae ("x86/ibt: Base IBT bits") added a check for a crash
with 'clang -fcf-protection=branch -mfentry -pg', which intended to
exclude Clang versions older than 14.0.0 from selecting
CONFIG_X86_KERNEL_IBT.

clang-11 does not have the issue that the check is testing for, so
CONFIG_X86_KERNEL_IBT is selectable. Unfortunately, there is a different
crash in clang-11 that was fixed in clang-12. To make matters worse,
that crash does not appear to be entirely deterministic, as the same
input to the compiler will sometimes crash and other times not, which
makes dynamically checking for the crash like the '-pg' one unreliable.

To make everything work properly for all common versions of clang, use a
hard version check of 14.0.0, as that will be the first release upstream
that has both bugs properly fixed.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220318230747.3900772-2-nathan@kernel.org
---
 arch/x86/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0f0672d..921e4eb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1865,9 +1865,10 @@ config CC_HAS_IBT
 	# GCC >= 9 and binutils >= 2.29
 	# Retpoline check to work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93654
 	# Clang/LLVM >= 14
-	# fentry check to work around https://reviews.llvm.org/D111108
+	# https://github.com/llvm/llvm-project/commit/e0b89df2e0f0130881bf6c39bf31d7f6aac00e0f
+	# https://github.com/llvm/llvm-project/commit/dfcf69770bc522b9e411c66454934a37c1f35332
 	def_bool ((CC_IS_GCC && $(cc-option, -fcf-protection=branch -mindirect-branch-register)) || \
-		  (CC_IS_CLANG && $(success,echo "void a(void) {}" | $(CC) -Werror $(CLANG_FLAGS) -fcf-protection=branch -mfentry -pg -x c - -c -o /dev/null))) && \
+		  (CC_IS_CLANG && CLANG_VERSION >= 140000)) && \
 		  $(as-instr,endbr64)
 
 config X86_KERNEL_IBT
