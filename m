Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25D5508F89
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381526AbiDTSh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346657AbiDTShW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:37:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF131A3AF;
        Wed, 20 Apr 2022 11:34:34 -0700 (PDT)
Date:   Wed, 20 Apr 2022 18:34:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650479671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSQwku7fHMIX99eDuCSbHU9mlnIu7T5dqWh4l9yXphQ=;
        b=wLfKt2cufvERQUsFsF5tmslUjRv9AptNkl/Rf9OOwVeJFbKoNWKryYqs167mXqt5NgcGUe
        8ieJZj95+e6lqh115OgdZz7e6KsnCenXzTyAx3kV59jU9II2XbeyLG4xpDz+LHZ8kcZ9nm
        rpbss3+eoIF0WioxsGE4hw8LaLX84wXK5skTpbDyH/hiMeD5np64NfxSrl69Nu1uj4Nkol
        fCrtshG+D4iz9FVU8peaZ1Rx04+sCLOo5/fSrK17hfE2pgSAnR9MRX2jLi9clVNwjDmbuP
        o4vNKb52w16jKHqFyw+rPOzmuD0TN9jaCrNQ8QvLma0dYhYCWwFfc4csyzxG1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650479671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSQwku7fHMIX99eDuCSbHU9mlnIu7T5dqWh4l9yXphQ=;
        b=oWKlS4gRnJU8FnGpSgI1Q9ERyJbXPbh/qpd2kjDU4zGc8mcfSP81R1HEUg81PDU0mjDYe6
        vk8+NYfa6IbHk4CA==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/boot: Put globals that are accessed early into the
 .data section
Cc:     Borislav Petkov <bp@suse.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Michael Roth <michael.roth@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220420152613.145077-1-michael.roth@amd.com>
References: <20220420152613.145077-1-michael.roth@amd.com>
MIME-Version: 1.0
Message-ID: <165047967038.4207.4753476733569506937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     6044d159b5d826259a7397d42fa3ad0bfc4dbd13
Gitweb:        https://git.kernel.org/tip/6044d159b5d826259a7397d42fa3ad0bfc4dbd13
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Wed, 20 Apr 2022 10:26:13 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Apr 2022 20:10:54 +02:00

x86/boot: Put globals that are accessed early into the .data section

The helpers in arch/x86/boot/compressed/efi.c might be used during
early boot to access the EFI system/config tables, and in some cases
these EFI helpers might attempt to print debug/error messages, before
console_init() has been called.

__putstr() checks some variables to avoid printing anything before
the console has been initialized, but this isn't enough since those
variables live in .bss, which may not have been cleared yet. This can
lead to a triple-fault occurring, primarily when booting in legacy/CSM
mode (where EFI helpers will attempt to print some debug messages).

Fix this by declaring these globals in .data section instead so there
is no dependency on .bss being cleared before accessing them.

Fixes: c01fce9cef849 ("x86/compressed: Add SEV-SNP feature detection/setup")
Reported-by: Borislav Petkov <bp@suse.de>
Suggested-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220420152613.145077-1-michael.roth@amd.com
---
 arch/x86/boot/compressed/early_serial_console.c | 3 ++-
 arch/x86/boot/compressed/misc.c                 | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/early_serial_console.c b/arch/x86/boot/compressed/early_serial_console.c
index 261e81f..70a8d17 100644
--- a/arch/x86/boot/compressed/early_serial_console.c
+++ b/arch/x86/boot/compressed/early_serial_console.c
@@ -1,5 +1,6 @@
 #include "misc.h"
 
-int early_serial_base;
+/* This might be accessed before .bss is cleared, so use .data instead. */
+int early_serial_base __section(".data");
 
 #include "../early_serial_console.c"
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 1cdcaf3..ca6820f 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -53,7 +53,10 @@ memptr free_mem_end_ptr;
 
 static char *vidmem;
 static int vidport;
-static int lines, cols;
+
+/* These might be accessed before .bss is cleared, so use .data instead. */
+static int lines __section(".data");
+static int cols __section(".data");
 
 #ifdef CONFIG_KERNEL_GZIP
 #include "../../../../lib/decompress_inflate.c"
