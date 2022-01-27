Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1134549E1AE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbiA0L4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240353AbiA0L4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:38 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8AC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:56:37 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 167191EC0567;
        Thu, 27 Jan 2022 12:56:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643284596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=coFkHbd7TpbkN5zx/69SJ60EWm4TSdseZ4D4zy9Kn2w=;
        b=huJz2Au2pCL/dZJa0Y4BpmCRiY0xw9QZLajAl/BsNXce1oeajqCX4aPyFbgujJjqAmNWIs
        0Zqh+gGsreN9pGE7KWfCjoZYXOzxhfYNaUhbf1n6DTjeLMfB3W6KX25pnTV75QV67j+fF+
        6mZ/bWGTpwjEfeONd0yYY6dGcOF1E7c=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] x86/cpu: Remove "nosep"
Date:   Thu, 27 Jan 2022 12:56:22 +0100
Message-Id: <20220127115626.14179-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220127115626.14179-1-bp@alien8.de>
References: <20220127115626.14179-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

That chicken bit was added by

  4f88651125e2 ("[PATCH] i386: allow disabling X86_FEATURE_SEP at boot")

but measuring int80 vsyscall performance on 32-bit doesn't matter
anymore.

If still needed, one can boot with

  clearcpuid=sep

to disable that feature for testing.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 arch/x86/kernel/cpu/common.c                    | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b67d0cf27997..2b35a45c2fd3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3599,8 +3599,6 @@
 
 	nosbagart	[IA-64]
 
-	nosep		[BUGS=X86-32] Disables x86 SYSENTER/SYSEXIT support.
-
 	nosgx		[X86-64,SGX] Disables Intel SGX kernel support.
 
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index aaac18d800a4..f394851db082 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -220,13 +220,6 @@ static int __init cachesize_setup(char *str)
 }
 __setup("cachesize=", cachesize_setup);
 
-static int __init x86_sep_setup(char *s)
-{
-	setup_clear_cpu_cap(X86_FEATURE_SEP);
-	return 1;
-}
-__setup("nosep", x86_sep_setup);
-
 /* Standard macro to see if a specific flag is changeable */
 static inline int flag_is_changeable_p(u32 flag)
 {
-- 
2.29.2

