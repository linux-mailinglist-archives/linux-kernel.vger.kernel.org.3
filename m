Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591EC475976
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbhLONMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:12:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhLONMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:12:30 -0500
Date:   Wed, 15 Dec 2021 13:12:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639573949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSmE6urDlzLoZsUUpW4NctKQD0GQ5jnp6Rx5IEXBS9w=;
        b=AtPT0A6CQeXs5T4aVcKhRJdA/TIltHeQDrtXZ7wx0tjk+M5dyLFRfDw3ki+pU+amn79cum
        /x5LLp+KqoDR/vcgzQqJf0GeqQWwmcwMvrjIpXl8p1+n0H8fVGFcxk+cdgQG7bCjljNGuz
        JjAaGyTHY9fHDlFOC+er3R+e5S7RwrO6crKXbQ1H6beJttBw6LJFcOvZimqzai0pf1nmwh
        C3ERcWW/YvEhVrUK+QxoLuA4Nqoov0IGRWyfSc7CqnliksueC31NCZweKTo2rB0k6xYlG/
        8YT+5XGkjCru/uzB4MMiEr92BYEjiF0w0k3RDkQkN6dCfkvQJ+G4h8RzjcMcPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639573949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSmE6urDlzLoZsUUpW4NctKQD0GQ5jnp6Rx5IEXBS9w=;
        b=dDeCCFHkvlCtjKtzdxpmZIlTfKdQ8FzK8U5D9aqSdO9ctZKieoVTBESkFAQsl6brizKNlI
        wrlRxUHTEr51RcBg==
From:   "tip-bot2 for Mike Rapoport" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot: Move EFI range reservation after cmdline parsing
Cc:     Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211213112757.2612-4-bp@alien8.de>
References: <20211213112757.2612-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163957394846.23020.4896066797095894706.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2f5b3514c33fecad4003ce0f22ca9691492d310b
Gitweb:        https://git.kernel.org/tip/2f5b3514c33fecad4003ce0f22ca9691492d310b
Author:        Mike Rapoport <rppt@kernel.org>
AuthorDate:    Mon, 13 Dec 2021 12:27:57 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 15 Dec 2021 14:07:54 +01:00

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

See also https://lore.kernel.org/r/e8dd8993c38702ee6dd73b3c11f158617e665607.camel@intel.com

  [ bp: Turn into a proper patch. ]

Signed-off-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
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
