Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1D1467CAC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382379AbhLCRlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382337AbhLCRln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:41:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB94C061751;
        Fri,  3 Dec 2021 09:38:19 -0800 (PST)
Date:   Fri, 03 Dec 2021 17:38:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638553098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kAinEr2Au+1Kz7PDGSNF3yA+aR9CHz51n14+dszkWwg=;
        b=UFkfLlVK4WO+pDxzifhxQuQ/yJ0OjK7eCjBR6exjH9CE5dNOxqAa+w1zVtRcoyybXMzgoi
        LL9TGg3sxoe/EzBs8BpFM0qEaWGltdMyT3rloo9qm+7R2Aa0sbAHPROl4+/TFXb08x9dHx
        tb78nEW3Qghf8GhSuDs1wb6oiNpBxOLPdKm/KdI4buGgom0+AuDM+GY99uOpvAbciol+Ou
        +tpYIK/dmPLGB4gZTef/USXM11hZb/7TsJ31GGApRid77Z4djcvVECqlOXwk5IKyi/LhKU
        S6k6BxntQFXzsKHf36FyTSGjCzJpiHpivWHteDerErsQfvo17xd9kW7zn2EGZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638553098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kAinEr2Au+1Kz7PDGSNF3yA+aR9CHz51n14+dszkWwg=;
        b=lIoXkz69jM2RhTyyAZk8QxOxE/NLYY+Hq2jX6XniMSemsVTLNqq4IjGknLPd9Y3a3JPjsw
        JGvIQYl7lXSe5SDQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Add missing <asm/cpufeatures.h> dependency to
 <asm/page_64.h>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163855309686.11128.8994895456821800765.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     e1cd82a339024beda8439fb2e20718363ee989a8
Gitweb:        https://git.kernel.org/tip/e1cd82a339024beda8439fb2e20718363ee989a8
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 16 Nov 2021 06:13:05 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 03 Dec 2021 09:30:45 -08:00

x86/mm: Add missing <asm/cpufeatures.h> dependency to <asm/page_64.h>

In the following commit:

  025768a966a3 x86/cpu: Use alternative to generate the TASK_SIZE_MAX constant

... we added the new task_size_max() inline, which uses X86_FEATURE_LA57,
but doesn't include <asm/cpufeatures.h> which defines the constant.

Due to the way alternatives macros work currently this doesn't get reported as an
immediate build error, only as a link error, if a .c file happens to include
<asm/page.h> first:

   > ld: kernel/fork.o:(.altinstructions+0x98): undefined reference to `X86_FEATURE_LA57'

In the current upstream kernel no .c file includes <asm/page.h> before including
some other header that includes <asm/cpufeatures.h>, which is why this dependency
bug went unnoticed.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/page_64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 4bde0dc..e9c8629 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -5,6 +5,7 @@
 #include <asm/page_64_types.h>
 
 #ifndef __ASSEMBLY__
+#include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
 /* duplicated to the one in bootmem.h */
