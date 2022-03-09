Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987E14D2A20
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiCIH7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiCIH5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:57:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8EF163D78;
        Tue,  8 Mar 2022 23:55:33 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JUHn6xA0KOIwvtVSkqBzSD1cqzWgwrredmQK/ifRl/k=;
        b=X2D5MQEVjm8IwvnPRtpaaC7z5PMqOwhUsxqmpIWClTDLtT7UU0uYsLWahi8qm+7X0fjOHa
        QhccLjvRXFtFWQfiox+cSwN9Gxf0EwEehR+Mb0e/EsacVpOMEoYrSENnYXnwHowXhznIRz
        TJtCmaOg/+OAKux5XQaDBgjlDUceBdzATPU03Mk/uXnBKWSqHwkPzPfJR/znP9m91xekZQ
        zIH0C6cWkDFMW9/qGgHy5bFhdidtcRbFEU0NLGx55L7hTOoUcy/6D5GfOnNlIYRGuUvjYK
        mF/O9mJldvO/VCE+C8R8XJXXh3FgrRpcIklMTqyNLdbr8gdH7aIfC19HnTDTpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JUHn6xA0KOIwvtVSkqBzSD1cqzWgwrredmQK/ifRl/k=;
        b=o5EsE0rECbOmAaN//a8ILVKQUbjpFWSkZVsoTF+9TPI2RhqGewYbRwrEfb+xf7KlOj8C5b
        J6yk7kvB6H5D9XBw==
From:   "tip-bot2 for Fangrui Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] arm64: module: remove (NOLOAD) from linker script
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220218081209.354383-1-maskray@google.com>
References: <20220218081209.354383-1-maskray@google.com>
MIME-Version: 1.0
Message-ID: <164681251865.16921.4158298138742512571.tip-bot2@tip-bot2>
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

Commit-ID:     4013e26670c590944abdab56c4fa797527b74325
Gitweb:        https://git.kernel.org/tip/4013e26670c590944abdab56c4fa797527b74325
Author:        Fangrui Song <maskray@google.com>
AuthorDate:    Fri, 18 Feb 2022 00:12:09 -08:00
Committer:     Will Deacon <will@kernel.org>
CommitterDate: Fri, 25 Feb 2022 14:06:50 

arm64: module: remove (NOLOAD) from linker script

On ELF, (NOLOAD) sets the section type to SHT_NOBITS[1]. It is conceptually
inappropriate for .plt and .text.* sections which are always
SHT_PROGBITS.

In GNU ld, if PLT entries are needed, .plt will be SHT_PROGBITS anyway
and (NOLOAD) will be essentially ignored. In ld.lld, since
https://reviews.llvm.org/D118840 ("[ELF] Support (TYPE=<value>) to
customize the output section type"), ld.lld will report a `section type
mismatch` error. Just remove (NOLOAD) to fix the error.

[1] https://lld.llvm.org/ELF/linker_script.html As of today, "The
section should be marked as not loadable" on
https://sourceware.org/binutils/docs/ld/Output-Section-Type.html is
outdated for ELF.

Tested-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Fangrui Song <maskray@google.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20220218081209.354383-1-maskray@google.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/module.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
index a11ccad..094701e 100644
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -1,8 +1,8 @@
 SECTIONS {
 #ifdef CONFIG_ARM64_MODULE_PLTS
-	.plt 0 (NOLOAD) : { BYTE(0) }
-	.init.plt 0 (NOLOAD) : { BYTE(0) }
-	.text.ftrace_trampoline 0 (NOLOAD) : { BYTE(0) }
+	.plt 0 : { BYTE(0) }
+	.init.plt 0 : { BYTE(0) }
+	.text.ftrace_trampoline 0 : { BYTE(0) }
 #endif
 
 #ifdef CONFIG_KASAN_SW_TAGS
