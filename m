Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE26C4E23AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346057AbiCUJyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346043AbiCUJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:54:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A6610FC1;
        Mon, 21 Mar 2022 02:53:07 -0700 (PDT)
Date:   Mon, 21 Mar 2022 09:53:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647856386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wjonFop97SJxLIIkA1yfkOYs5xrVUOoOy7I0a3jI9qY=;
        b=PBns/DsKtJQdXt6BJNm0qnNtlTgxkauX7daVf03K4Q4pfRouQGy9EEGaXfgoUpM9GMcUTW
        ADH/Ej5D34YdwErWfa5wSdGBouWNrLDAb7fuFaB5Hnw+wPkfVxL/WmNfuERvUxpo+Cphl6
        WdtKYeYJta1VLk6g2N5t1RTN3qBRf6sCpfape3mP9PmpvDjVs90qo6ak3ooLjXQHnsEkgU
        Z6FTk+H0n1l/fxAFqNDWTZyoiTP4zkUUJxL7lB26yetKptLNmluyqzV4Jj32OZhdnsg1ix
        1qgRif0hNwiiY6zsRXmGikDUe8qCV4vegj1j37RAkN49OclE0RzTff5oo3EmDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647856386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wjonFop97SJxLIIkA1yfkOYs5xrVUOoOy7I0a3jI9qY=;
        b=mI9VZkC17hdWzOYOOlOWo21QfxYiWkhSeeJhMljWhLNoIfWIm/+i1D1V+ue4cA4HGLbcB1
        wNo4O+n2PnKDgiCg==
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
Message-ID: <164785638482.389.7255038844058524411.tip-bot2@tip-bot2>
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

Commit-ID:     46a5cf598a940e674a574664c32ad3518dc9ed6f
Gitweb:        https://git.kernel.org/tip/46a5cf598a940e674a574664c32ad3518dc9ed6f
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Fri, 18 Mar 2022 16:07:47 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 19 Mar 2022 00:47:13 +01:00

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
