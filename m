Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A1D4726DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhLMJzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:55:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33732 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbhLMJuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:50:22 -0500
Date:   Mon, 13 Dec 2021 09:50:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muxITCF8UmwZWcVI0WD+vUdfcJcTRPzIViAxQ8AncJY=;
        b=44i+ud28UJj/6TEF72VR7NreF+QoLVBm6QR21Q+6J60v9bew+E9zrqWg1By4U3A4iXMtUY
        QHqTHpHXv24uGCrU9QllO9bMazjuboPyNwQAgAxDTEWvz5v75+srmHuP2QTwznUUamTM5+
        ptMIN9VpA2L2b+eqUjKktV5q/k8dpbF17wsZM+CZozxbY27ioS5MCL2XmY/kZhfz0/rTbW
        HPTKPLGFvF7OYXdbuIB60US22QHoFczIHPMHE6bWYB8bP0g3BOQIn/xhItlk3tVRaWscK7
        LnWflwZ143IFMCrh1QaYoJxmqlzML8hwstMzaFx9MNcElaYppy+kn/3d7Xw+8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muxITCF8UmwZWcVI0WD+vUdfcJcTRPzIViAxQ8AncJY=;
        b=UKXBNNS4sFs18RnNp1O+mKxyZeo0u11vNGu9ib4ZneEdXiR9MVRTIDqTNhXj5Y5dsRR3NU
        98Zy8dkpYdb7eqAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/xen: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.545019822@infradead.org>
References: <20211110101325.545019822@infradead.org>
MIME-Version: 1.0
Message-ID: <163938901734.23020.15497457389902062668.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e2b48e43284c0916ebf8e4240199b9d9747e337a
Gitweb:        https://git.kernel.org/tip/e2b48e43284c0916ebf8e4240199b9d9747e337a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:48 +01:00

x86/xen: Remove .fixup usage

Employ the fancy new EX_TYPE_IMM_REG to store -EFAULT in the return
register and use this to remove some Xen .fixup usage.

All callers of these functions only test for 0 return, so the actual
return value change from -1 to -EFAULT is immaterial.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101325.545019822@infradead.org
---
 arch/x86/include/asm/xen/page.h | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
index 1a162e5..e989bc2 100644
--- a/arch/x86/include/asm/xen/page.h
+++ b/arch/x86/include/asm/xen/page.h
@@ -96,11 +96,7 @@ static inline int xen_safe_write_ulong(unsigned long *addr, unsigned long val)
 
 	asm volatile("1: mov %[val], %[ptr]\n"
 		     "2:\n"
-		     ".section .fixup, \"ax\"\n"
-		     "3: sub $1, %[ret]\n"
-		     "   jmp 2b\n"
-		     ".previous\n"
-		     _ASM_EXTABLE(1b, 3b)
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %[ret])
 		     : [ret] "+r" (ret), [ptr] "=m" (*addr)
 		     : [val] "r" (val));
 
@@ -110,16 +106,12 @@ static inline int xen_safe_write_ulong(unsigned long *addr, unsigned long val)
 static inline int xen_safe_read_ulong(const unsigned long *addr,
 				      unsigned long *val)
 {
-	int ret = 0;
 	unsigned long rval = ~0ul;
+	int ret = 0;
 
 	asm volatile("1: mov %[ptr], %[rval]\n"
 		     "2:\n"
-		     ".section .fixup, \"ax\"\n"
-		     "3: sub $1, %[ret]\n"
-		     "   jmp 2b\n"
-		     ".previous\n"
-		     _ASM_EXTABLE(1b, 3b)
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %[ret])
 		     : [ret] "+r" (ret), [rval] "+r" (rval)
 		     : [ptr] "m" (*addr));
 	*val = rval;
