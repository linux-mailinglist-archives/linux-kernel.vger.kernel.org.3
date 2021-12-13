Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88BA472B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbhLML2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbhLML2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:28:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14628C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 03:28:02 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E8BC1EC054F;
        Mon, 13 Dec 2021 12:28:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639394880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zvq+iuXs8lIFhddRqKkphqajuGv+Wb9UvUgh6rYtibA=;
        b=mepNFZkEBPrDJ1HaWVLSNu8HW7wN3OYD3WKDAkCp34pJ5dc3/MODzX/jSVEJNNlPfxlKOj
        t598KjK4doVKU7eQdqcqdauet2UnTZ8TW9zwmkqoF1MJmc798Mes69Lcb2n3nHoGs/su0k
        YVSdAwcHkA9EeoaqYY9Wr/6UYM85uiQ=
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        John Dorminy <jdorminy@redhat.com>, anjaneya.chagam@intel.com,
        dan.j.williams@intel.com, Hugh Dickins <hughd@google.com>,
        "Patrick J. Volkerding" <volkerdi@gmail.com>
Subject: [PATCH 3/3] x86/boot: Move EFI range reservation after cmdline parsing
Date:   Mon, 13 Dec 2021 12:27:57 +0100
Message-Id: <20211213112757.2612-4-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211213112757.2612-1-bp@alien8.de>
References: <YbcTgQdTpJAHAZw4@zn.tnic>
 <20211213112757.2612-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@kernel.org>

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

 [ bp: Productize into a proper patch. ]

Signed-off-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/e8dd8993c38702ee6dd73b3c11f158617e665607.camel@intel.com
---
 arch/x86/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 49b596db5631..e04f5e6eb33f 100644
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
-- 
2.29.2

