Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF7D52E8E5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346324AbiETJek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiETJeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:34:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344D13F1DB;
        Fri, 20 May 2022 02:34:34 -0700 (PDT)
Date:   Fri, 20 May 2022 09:34:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653039272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sCF3Az+AXTvAL2Bg6o9WbPakpP4ifyu/0tfR5iev4s=;
        b=imDEOGsMAJnWcwBglnf4OR9xf1Y3ohDfn8gZhDKxWdbxjDOZcm8e2uVmvZBc1nnL6vDzoR
        INmjb6SelZIljD+FenoDSa7D01r1SK1l5ewOkneZJ1SymuTOPBXZaKI0IMSqs6uUG9yh9u
        mQRJ36qVd6AN4DzdhHUfo5Cf+98dB3fG/NP4sXYgXxXDpiRjOwsIoOLm1AmAn/+lKV2QZn
        ZNEWMyJ1UcS4bKIhDMkphYS1rN4cRUYBZeW6vOTpDpwYKKGbA7D4qvhJe7FK9QK/HcaUgS
        bcbDWIZwqQYs4hZgUFN4v1/pDiez8zDQnkeI44Qpa3r4FmXiA/uLtaOCOoi61Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653039272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sCF3Az+AXTvAL2Bg6o9WbPakpP4ifyu/0tfR5iev4s=;
        b=VB8CQVYmnMPrsYQcjeEkoDd/nzxnnv8nC37l8wMoY0J0DG6M7WjpE50W71aFGf9GXEZvaQ
        8vMwuELtiWRddKCg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Add explicit CPU vendor dependency
Cc:     Randy Dunlap <rdunlap@infradead.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <8ead0da9-9545-b10d-e3db-7df1a1f219e4@infradead.org>
References: <8ead0da9-9545-b10d-e3db-7df1a1f219e4@infradead.org>
MIME-Version: 1.0
Message-ID: <165303927147.4207.7663213190046631826.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     9c55d99e099bd7aa6b91fce8718505c35d5dfc65
Gitweb:        https://git.kernel.org/tip/9c55d99e099bd7aa6b91fce8718505c35d5dfc65
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 19 May 2022 16:59:13 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 20 May 2022 11:28:32 +02:00

x86/microcode: Add explicit CPU vendor dependency

Add an explicit dependency to the respective CPU vendor so that the
respective microcode support for it gets built only when that support is
enabled.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/8ead0da9-9545-b10d-e3db-7df1a1f219e4@infradead.org
---
 arch/x86/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e0..7ba627c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1313,7 +1313,7 @@ config MICROCODE
 
 config MICROCODE_INTEL
 	bool "Intel microcode loading support"
-	depends on MICROCODE
+	depends on CPU_SUP_INTEL && MICROCODE
 	default MICROCODE
 	help
 	  This options enables microcode patch loading support for Intel
@@ -1325,7 +1325,7 @@ config MICROCODE_INTEL
 
 config MICROCODE_AMD
 	bool "AMD microcode loading support"
-	depends on MICROCODE
+	depends on CPU_SUP_AMD && MICROCODE
 	help
 	  If you select this option, microcode patch loading support for AMD
 	  processors will be enabled.
