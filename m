Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532C34F91B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiDHJPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiDHJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:11:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAFF1753A8;
        Fri,  8 Apr 2022 02:08:55 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408934;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIxpx+4TyRv71Ngg3lyErZ/A8WnAGpmdf7oTeMXQZx0=;
        b=c5niv6owwSj3DnxoxGejK3d1HdLPpLj7jzYTAY/zQSCHkcFtfwe/yQOFNK1HOKxG5kB3a1
        tDs//wW98JcyKVtc9MiA5F2/07bTvadgdTEIO1KZfkFql69PJ3+Y8M0QSce07e70utMJLX
        7yrpvEHGsZDH/I+RZ/xSB2Iwb/FS2f5hrvSqfZvnGQ7c9K9rxM1T0s/fYy9bFQdfjFgSCq
        QhV8xVWvz8gdyrRj9dWO7yyuudz6IUa3kgv/kKyIgk+km4W8r22zHuJNf7al+R8XD7ko5I
        mmgocaF2zMJ5z6Ud5HlTsEdg0B1Y5QHoqxs7IaTmaiq82dIbZA2B2yWFdtpWfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408934;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIxpx+4TyRv71Ngg3lyErZ/A8WnAGpmdf7oTeMXQZx0=;
        b=DynIhOUvskv0sv4YUthc1Ai0lvhPM0FqMjLwqBD5652hlHIaqq/b01NjV+QQ2K1ZaOhYAc
        c5HhOf9O0/oxP0Cg==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] KVM: x86: Move lookup of indexed CPUID leafs to helper
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Venu Busireddy <venu.busireddy@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-31-brijesh.singh@amd.com>
References: <20220307213356.2797205-31-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940893321.389.1933444875252437895.tip-bot2@tip-bot2>
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

Commit-ID:     b66370db9a90b3fa4c4a1a732af3e7e38d6d4c7c
Gitweb:        https://git.kernel.org/tip/b66370db9a90b3fa4c4a1a732af3e7e38d6d4c7c
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:10 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 16:47:11 +02:00

KVM: x86: Move lookup of indexed CPUID leafs to helper

Determining which CPUID leafs have significant ECX/index values is
also needed by guest kernel code when doing SEV-SNP-validated CPUID
lookups. Move this to common code to keep future updates in sync.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Link: https://lore.kernel.org/r/20220307213356.2797205-31-brijesh.singh@amd.com
---
 arch/x86/include/asm/cpuid.h | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.c         | 19 ++-----------------
 2 files changed, 36 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
new file mode 100644
index 0000000..70b2db1
--- /dev/null
+++ b/arch/x86/include/asm/cpuid.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CPUID-related helpers/definitions
+ *
+ * Derived from arch/x86/kvm/cpuid.c
+ */
+
+#ifndef _ASM_X86_CPUID_H
+#define _ASM_X86_CPUID_H
+
+static __always_inline bool cpuid_function_is_indexed(u32 function)
+{
+	switch (function) {
+	case 4:
+	case 7:
+	case 0xb:
+	case 0xd:
+	case 0xf:
+	case 0x10:
+	case 0x12:
+	case 0x14:
+	case 0x17:
+	case 0x18:
+	case 0x1d:
+	case 0x1e:
+	case 0x1f:
+	case 0x8000001d:
+		return true;
+	}
+
+	return false;
+}
+
+#endif /* _ASM_X86_CPUID_H */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index b24ca7f..4b62d80 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -19,6 +19,7 @@
 #include <asm/user.h>
 #include <asm/fpu/xstate.h>
 #include <asm/sgx.h>
+#include <asm/cpuid.h>
 #include "cpuid.h"
 #include "lapic.h"
 #include "mmu.h"
@@ -744,24 +745,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
 	cpuid_count(entry->function, entry->index,
 		    &entry->eax, &entry->ebx, &entry->ecx, &entry->edx);
 
-	switch (function) {
-	case 4:
-	case 7:
-	case 0xb:
-	case 0xd:
-	case 0xf:
-	case 0x10:
-	case 0x12:
-	case 0x14:
-	case 0x17:
-	case 0x18:
-	case 0x1d:
-	case 0x1e:
-	case 0x1f:
-	case 0x8000001d:
+	if (cpuid_function_is_indexed(function))
 		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-		break;
-	}
 
 	return entry;
 }
