Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36004F91E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiDHJRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiDHJMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD3D24BD52;
        Fri,  8 Apr 2022 02:09:17 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZp3DFyUl6wOs7StHaj5old/wdmCSVIRiMeVsd6IyEI=;
        b=Y0CL0SNp09RHIZLsJql/PjqJOzq1RAtUscHN8XAs2uggOKCSoJ2yjB3UoXWRxgN/kFmFdW
        9vD1lAYluUZLe28GPFSxiO7cc/7E3Yty4iE5H20NzcG16e69kBcK1odZdgvT7AuXnQHS0N
        yA4V0mkDrPVevY5IZmRmnKbtK1l79PwyzEALbpfww8M/CCa16tjqXRdfcHEMkRfDMNabmD
        4UEtcx3U1iabOeQu8KAx07SoMbUHe+mqGegD23y8RiGnAnLXvot7SM0I3Ft4llV57vu/m8
        cD5T4r51DqW2WmkEkIf747fMcHbGWwSeBQDZCRlvvSHdCIQw/2QRaCU03WbgeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZp3DFyUl6wOs7StHaj5old/wdmCSVIRiMeVsd6IyEI=;
        b=sojZxL9mGEvMTB4JRkXi4STnQQ4/e+A1zW9Y7lfmNzn9KAJa4kft4lLwm02CXpip05ZziM
        3ZDirlyiRyLoGjAQ==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/boot: Introduce helpers for MSR reads/writes
Cc:     Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-6-brijesh.singh@amd.com>
References: <20220307213356.2797205-6-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940895518.389.9359948563702984420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     176db622573f028f85221873ea4577e096785315
Gitweb:        https://git.kernel.org/tip/176db622573f028f85221873ea4577e096785315
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:09:59 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 12:59:17 +02:00

x86/boot: Introduce helpers for MSR reads/writes

The current set of helpers used throughout the run-time kernel have
dependencies on code/facilities outside of the boot kernel, so there
are a number of call-sites throughout the boot kernel where inline
assembly is used instead. More will be added with subsequent patches
that add support for SEV-SNP, so take the opportunity to provide a basic
set of helpers that can be used by the boot kernel to reduce reliance on
inline assembly.

Use boot_* prefix so that it's clear these are helpers specific to the
boot kernel to avoid any confusion with the various other MSR read/write
helpers.

  [ bp: Disambiguate parameter names and trim comment. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-6-brijesh.singh@amd.com
---
 arch/x86/boot/msr.h               | 26 ++++++++++++++++++++++++++
 arch/x86/include/asm/msr.h        | 11 +----------
 arch/x86/include/asm/shared/msr.h | 15 +++++++++++++++
 3 files changed, 42 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/boot/msr.h
 create mode 100644 arch/x86/include/asm/shared/msr.h

diff --git a/arch/x86/boot/msr.h b/arch/x86/boot/msr.h
new file mode 100644
index 0000000..aed66f7
--- /dev/null
+++ b/arch/x86/boot/msr.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Helpers/definitions related to MSR access.
+ */
+
+#ifndef BOOT_MSR_H
+#define BOOT_MSR_H
+
+#include <asm/shared/msr.h>
+
+/*
+ * The kernel proper already defines rdmsr()/wrmsr(), but they are not for the
+ * boot kernel since they rely on tracepoint/exception handling infrastructure
+ * that's not available here.
+ */
+static inline void boot_rdmsr(unsigned int reg, struct msr *m)
+{
+	asm volatile("rdmsr" : "=a" (m->l), "=d" (m->h) : "c" (reg));
+}
+
+static inline void boot_wrmsr(unsigned int reg, const struct msr *m)
+{
+	asm volatile("wrmsr" : : "c" (reg), "a"(m->l), "d" (m->h) : "memory");
+}
+
+#endif /* BOOT_MSR_H */
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index d42e6c6..65ec196 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -10,16 +10,7 @@
 #include <asm/errno.h>
 #include <asm/cpumask.h>
 #include <uapi/asm/msr.h>
-
-struct msr {
-	union {
-		struct {
-			u32 l;
-			u32 h;
-		};
-		u64 q;
-	};
-};
+#include <asm/shared/msr.h>
 
 struct msr_info {
 	u32 msr_no;
diff --git a/arch/x86/include/asm/shared/msr.h b/arch/x86/include/asm/shared/msr.h
new file mode 100644
index 0000000..1e6ec10
--- /dev/null
+++ b/arch/x86/include/asm/shared/msr.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SHARED_MSR_H
+#define _ASM_X86_SHARED_MSR_H
+
+struct msr {
+	union {
+		struct {
+			u32 l;
+			u32 h;
+		};
+		u64 q;
+	};
+};
+
+#endif /* _ASM_X86_SHARED_MSR_H */
