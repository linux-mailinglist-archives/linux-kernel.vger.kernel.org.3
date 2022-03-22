Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2414E476D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiCVUZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiCVUZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:25:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B7C6623B;
        Tue, 22 Mar 2022 13:24:02 -0700 (PDT)
Date:   Tue, 22 Mar 2022 20:23:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647980640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OU+9MCdRKjPoheduOcb7ol1j9uyfiPT/49iygn0hpfM=;
        b=AT+L+48YUJErfQY+IvMDD6m2dgI9HffaCtIVDEyWZK74OPwNsVO7XgtydUqIXev9931X9z
        2KJWsxArLTI8uvAxyG7oecL1BhB9SIKC51jhhhjSk6r2dfKdbJNON92e5nv1HUbpHvQTnw
        pvM5l4/0aGWkWFM2yRCq6TdKxLiNASrNaACTR5hSwvJ484RFwVDtQTrQ6Fv5OMVBeZd96X
        ilodyaSp6UiTRZgwr6ecyiLQO4pco/Bf9icfJJzE2tm4p7P5HiKluJW58OGvQeYEORC6o2
        xwhWQtdeC7VRsGS0gAXjY7+xvaAucLPCwbsyXCcON6mmItJRVD3fcAXoqs4j1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647980640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OU+9MCdRKjPoheduOcb7ol1j9uyfiPT/49iygn0hpfM=;
        b=tSzteDW/T/M09lGP/EUdmBKfiNiO6FER0wH5LfKJneeQXK/ee0jKJ9torZYnRj3RpwqcY7
        VI+24xpJlJ5Y1jBA==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/Kconfig: Only allow CONFIG_X86_KERNEL_IBT with
 ld.lld >= 14.0.0
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220318230747.3900772-3-nathan@kernel.org>
References: <20220318230747.3900772-3-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <164798063954.389.10917139884144168372.tip-bot2@tip-bot2>
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

Commit-ID:     f6a2c2b2de817078ac5a7e58c10e746165e7825d
Gitweb:        https://git.kernel.org/tip/f6a2c2b2de817078ac5a7e58c10e746165e7825d
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Fri, 18 Mar 2022 16:07:47 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Mar 2022 21:12:13 +01:00

x86/Kconfig: Only allow CONFIG_X86_KERNEL_IBT with ld.lld >= 14.0.0

With CONFIG_X86_KERNEL_IBT=y and a version of ld.lld prior to 14.0.0,
there are numerous objtool warnings along the lines of:

  warning: objtool: .plt+0x6: indirect jump found in RETPOLINE build

This is a known issue that has been resolved in ld.lld 14.0.0. Prevent
CONFIG_X86_KERNEL_IBT from being selectable when using one of these
problematic ld.lld versions.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220318230747.3900772-3-nathan@kernel.org
---
 arch/x86/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 921e4eb..8757926 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1875,6 +1875,8 @@ config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
 	bool
 	depends on X86_64 && CC_HAS_IBT && STACK_VALIDATION
+	# https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
+	depends on !LD_IS_LLD || LLD_VERSION >= 140000
 	help
 	  Build the kernel with support for Indirect Branch Tracking, a
 	  hardware support course-grain forward-edge Control Flow Integrity
