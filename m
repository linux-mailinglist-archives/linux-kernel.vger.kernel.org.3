Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA13475951
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhLONFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:05:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhLONFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:05:50 -0500
Date:   Wed, 15 Dec 2021 13:05:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639573548;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJbh9RBDas7JBSFcpYKrkuMQYwvI0JIn1Tz/C8Xdh1U=;
        b=mWcwSnrso1YyBJwI7vOf9iHU8jS5tLexWhg3YFwhLCS8rcQkxnmqdfzgF2oPHUOaGGh/V0
        I7FMLE7iuzL1HFWe5o8hOLSJMrDgvskcIPrN4jnWiQSWQflDbzpaog+PvhsjM/HuZWYbIo
        wtg4P946VH8U1gOCTlQEm4IA2f4pccEKozNNsz7HEQHq0G4rN9jrZAhIiuR+V6bCnv+Z79
        8sGuH3AGkTWPWP3jZ0kHulPAYt5LzzJVa9lMDjocD0LuCPg2psJDRaT/4jAUH30EpGa3t1
        BxON1w3jhm/XsHMyWs++9D0Iy51h4DpFmfxtTE/ZicINoFGRkay+WRniOlxqew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639573548;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJbh9RBDas7JBSFcpYKrkuMQYwvI0JIn1Tz/C8Xdh1U=;
        b=MEIJBb2mIdraEc2RxxzG0X5Meb+hkbo9AHPbVtqQT/KCR1lUzEw8FIRQan2g54Me/HpN1N
        LMmNHUSBQXFAGeCg==
From:   "tip-bot2 for Mike Rapoport" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot: Move EFI range reservation after cmdline parsing
Cc:     Borislav Petkov <bp@suse.de>, Mike Rapoport <rppt@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <e8dd8993c38702ee6dd73b3c11f158617e665607.camel@intel.com>
References: <e8dd8993c38702ee6dd73b3c11f158617e665607.camel@intel.com>
MIME-Version: 1.0
Message-ID: <163957354693.23020.8537268805198191781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     83757bbb9fe029b704fb28e80c3f2b92f23a1994
Gitweb:        https://git.kernel.org/tip/83757bbb9fe029b704fb28e80c3f2b92f23a1994
Author:        Mike Rapoport <rppt@kernel.org>
AuthorDate:    Mon, 13 Dec 2021 12:27:57 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 15 Dec 2021 12:36:47 +01:00

x86/boot: Move EFI range reservation after cmdline parsing

The memory reservation in arch/x86/platform/efi/efi.c depends on at
least two command line parameters. Put it back later in the boot process
and move efi_memblock_x86_reserve_range() out of early_memory_reserve().

An attempt to fix this was done in

  8d48bf8206f7 ("x86/boot: Pull up cmdline preparation and early param parsing")

but that caused other troubles so it got reverted.

The bug this is addressing is:

Dan reports that Anjaneya Chagam can no longer use the efi=nosoftreserve
kernel command line parameter to suppress "soft reservation" behavior.

This is due to the fact that the following call-chain happens at boot:

early_reserve_memory
|-> efi_memblock_x86_reserve_range
    |-> efi_fake_memmap_early

which does

        if (!efi_soft_reserve_enabled())
                return;

and that would have set EFI_MEM_NO_SOFT_RESERVE after having parsed
"nosoftreserve".

However, parse_early_param() gets called *after* it, leading to the boot
cmdline not being taken into account.

 [ bp: Produce into a proper patch. ]

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/e8dd8993c38702ee6dd73b3c11f158617e665607.camel@intel.com
Link: https://lore.kernel.org/r/20211213112757.2612-4-bp@alien8.de
---
 arch/x86/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 49b596d..e04f5e6 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -713,9 +713,6 @@ static void __init early_reserve_memory(void)
 
 	early_reserve_initrd();
 
-	if (efi_enabled(EFI_BOOT))
-		efi_memblock_x86_reserve_range();
-
 	memblock_x86_reserve_range_setup_data();
 
 	reserve_ibft_region();
@@ -890,6 +887,9 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	if (efi_enabled(EFI_BOOT))
+		efi_memblock_x86_reserve_range();
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 	/*
 	 * Memory used by the kernel cannot be hot-removed because Linux
