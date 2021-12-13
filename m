Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F014728DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhLMKPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbhLMKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB6EC09CE5E;
        Mon, 13 Dec 2021 01:50:13 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389012;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZWMZ7JplY4kWLlNXgiZeHtjs/oEl3R/rFUKSRPEGcT0=;
        b=p1Z8b+6O+Em6ssQfMXpi6vT07O4IpLVmzndjRaik59MzP6tKG+N3blnJrbvy5aSx+R1YIj
        cO7IlUlMygvRVzEwKjUGwYAPOn6q38kytrMPFkNWMKcbby0t5K+CwFaBkaVRn85BChm+Gg
        QV2kPlG0SRncRqnBhZw8UH3guDZX2RdKR1+0a5nq0Ic+3EJvZ29d8OXDEE/XtVTa1ZOax0
        bf/POAr5fhNC6x+HE1Ef6B8CgIegR1QrhA2KR3BK9C3GubMRvWa8ik3IYoLKmwKrXUchO2
        DZJkoOTBNbt97SMp0oT+KiJe85FuQCA8QjqyptZz5PFmdf1p5dn/6VLSYxopgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389012;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZWMZ7JplY4kWLlNXgiZeHtjs/oEl3R/rFUKSRPEGcT0=;
        b=hPCSUk+RCdj2QW3uV4VBnQdDlzVEDatESwuK11AkdSV+o65/lbpJAnlADXy7V2LVRRV9JX
        eZq0jpHU7W4tdwDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/usercopy_32: Simplify __copy_user_intel_nocache()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101326.021517780@infradead.org>
References: <20211110101326.021517780@infradead.org>
MIME-Version: 1.0
Message-ID: <163938901130.23020.8791511563118836366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     13e4bf1bddcb65dd028aaa492789e8d61efaafa1
Gitweb:        https://git.kernel.org/tip/13e4bf1bddcb65dd028aaa492789e8d61efaafa1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:50 +01:00

x86/usercopy_32: Simplify __copy_user_intel_nocache()

Have an exception jump to a .fixup to only immediately jump out is
daft, jump to the right place in one go.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101326.021517780@infradead.org
---
 arch/x86/lib/usercopy_32.c | 40 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index 962006b..1eb1506 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -256,28 +256,28 @@ static unsigned long __copy_user_intel_nocache(void *to,
 	       "8:\n"
 	       ".section .fixup,\"ax\"\n"
 	       "9:      lea 0(%%eax,%0,4),%0\n"
-	       "16:     jmp 8b\n"
+	       "        jmp 8b\n"
 	       ".previous\n"
-	       _ASM_EXTABLE_UA(0b, 16b)
-	       _ASM_EXTABLE_UA(1b, 16b)
-	       _ASM_EXTABLE_UA(2b, 16b)
-	       _ASM_EXTABLE_UA(21b, 16b)
-	       _ASM_EXTABLE_UA(3b, 16b)
-	       _ASM_EXTABLE_UA(31b, 16b)
-	       _ASM_EXTABLE_UA(4b, 16b)
-	       _ASM_EXTABLE_UA(41b, 16b)
-	       _ASM_EXTABLE_UA(10b, 16b)
-	       _ASM_EXTABLE_UA(51b, 16b)
-	       _ASM_EXTABLE_UA(11b, 16b)
-	       _ASM_EXTABLE_UA(61b, 16b)
-	       _ASM_EXTABLE_UA(12b, 16b)
-	       _ASM_EXTABLE_UA(71b, 16b)
-	       _ASM_EXTABLE_UA(13b, 16b)
-	       _ASM_EXTABLE_UA(81b, 16b)
-	       _ASM_EXTABLE_UA(14b, 16b)
-	       _ASM_EXTABLE_UA(91b, 16b)
+	       _ASM_EXTABLE_UA(0b, 8b)
+	       _ASM_EXTABLE_UA(1b, 8b)
+	       _ASM_EXTABLE_UA(2b, 8b)
+	       _ASM_EXTABLE_UA(21b, 8b)
+	       _ASM_EXTABLE_UA(3b, 8b)
+	       _ASM_EXTABLE_UA(31b, 8b)
+	       _ASM_EXTABLE_UA(4b, 8b)
+	       _ASM_EXTABLE_UA(41b, 8b)
+	       _ASM_EXTABLE_UA(10b, 8b)
+	       _ASM_EXTABLE_UA(51b, 8b)
+	       _ASM_EXTABLE_UA(11b, 8b)
+	       _ASM_EXTABLE_UA(61b, 8b)
+	       _ASM_EXTABLE_UA(12b, 8b)
+	       _ASM_EXTABLE_UA(71b, 8b)
+	       _ASM_EXTABLE_UA(13b, 8b)
+	       _ASM_EXTABLE_UA(81b, 8b)
+	       _ASM_EXTABLE_UA(14b, 8b)
+	       _ASM_EXTABLE_UA(91b, 8b)
 	       _ASM_EXTABLE_UA(6b, 9b)
-	       _ASM_EXTABLE_UA(7b, 16b)
+	       _ASM_EXTABLE_UA(7b, 8b)
 	       : "=&c"(size), "=&D" (d0), "=&S" (d1)
 	       :  "1"(to), "2"(from), "0"(size)
 	       : "eax", "edx", "memory");
