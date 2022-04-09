Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95D44FA138
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbiDIB3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbiDIB30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:29:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C799101F0B;
        Fri,  8 Apr 2022 18:27:21 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TDRE3JIcr2hY/DHw9IOdrcLFKUf37UqkwqHPl09hq0Q=;
        b=ST2whTrRPmaJ8SYEZocSOTvu98KXLlXvdOPHeMgtka48R/rkB6LRXSMAI0f2Jo9rzHw7iO
        yXads78h7dRzjAE+YqLm1siDC7Y4Y30it33yPBVx71hCgN8dbKvYUyCxvjBHeddDK2pmgF
        r7HaV4ntzQ6I+7en3l6GhEDH5g3nqQIW32SmVQfTK9L5W8O95VvEPH4lJURjHArpTx/joR
        Cfr4MP0JoSHUaeirrIShI2l7bkltre8z1ALgzUwnQE5pWVjTgVc/j3u9qy30ewn9vEKx0B
        6a3GlMeAFguhOmMvqd4U1gKdancrwBws1KMVykLb4OKMhDDS8xKTf1SsXlvUGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TDRE3JIcr2hY/DHw9IOdrcLFKUf37UqkwqHPl09hq0Q=;
        b=brF7Pbjr/zLF4bazd4xiUqbYkjUlhwVbBxLIvW5MrbkW/YlDQiw/2oJICsC5CgmphYPr1O
        i2VPl07+H0uf8wBQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] ACPICA: Avoid cache flush inside virtual machines
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-30-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-30-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946763897.4207.11572808641505094885.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     e2efb6359e620521d1e13f69b2257de8ceaa9475
Gitweb:        https://git.kernel.org/tip/e2efb6359e620521d1e13f69b2257de8ceaa9475
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:38 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:54 -07:00

ACPICA: Avoid cache flush inside virtual machines

While running inside virtual machine, the kernel can bypass cache
flushing. Changing sleep state in a virtual machine doesn't affect the
host system sleep state and cannot lead to data loss.

Before entering sleep states, the ACPI code flushes caches to prevent
data loss using the WBINVD instruction.  This mechanism is required on
bare metal.

But, any use WBINVD inside of a guest is worthless.  Changing sleep
state in a virtual machine doesn't affect the host system sleep state
and cannot lead to data loss, so most hypervisors simply ignore it.
Despite this, the ACPI code calls WBINVD unconditionally anyway.
It's useless, but also normally harmless.

In TDX guests, though, WBINVD stops being harmless; it triggers a
virtualization exception (#VE).  If the ACPI cache-flushing WBINVD
were left in place, TDX guests would need handling to recover from
the exception.

Avoid using WBINVD whenever running under a hypervisor.  This both
removes the useless WBINVDs and saves TDX from implementing WBINVD
handling.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-30-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/acenv.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
index 9aff97f..d937c55 100644
--- a/arch/x86/include/asm/acenv.h
+++ b/arch/x86/include/asm/acenv.h
@@ -13,7 +13,19 @@
 
 /* Asm macros */
 
-#define ACPI_FLUSH_CPU_CACHE()	wbinvd()
+/*
+ * ACPI_FLUSH_CPU_CACHE() flushes caches on entering sleep states.
+ * It is required to prevent data loss.
+ *
+ * While running inside virtual machine, the kernel can bypass cache flushing.
+ * Changing sleep state in a virtual machine doesn't affect the host system
+ * sleep state and cannot lead to data loss.
+ */
+#define ACPI_FLUSH_CPU_CACHE()					\
+do {								\
+	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))	\
+		wbinvd();					\
+} while (0)
 
 int __acpi_acquire_global_lock(unsigned int *lock);
 int __acpi_release_global_lock(unsigned int *lock);
