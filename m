Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E604726D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhLMJzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:55:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbhLMJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:50:16 -0500
Date:   Mon, 13 Dec 2021 09:50:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389014;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joIhesn1BSMsmTZLymmmAauf/7+y+igCxLEplbm3cX8=;
        b=qYJcpMW7nSzF+MPeAtFuqj4w29O8/XUiH3/F/MFcCSJKOZ9DZjRzYcp++KmZqAZfux6+e/
        i8O/rau/1pTWyHoFVE+aCwidZJ0MXCidNsLQWzclSqnLSACvcUnXQxDTIBApyuJQvQJ2Ti
        dFpBx4gwYWr5T6LRnldvoxEhclAxHLMGUi0ebj0mSrYZuRlyECECzW+C0BtUBcSdfXmjex
        VFqSSOW71hDk4IcmJQUH+pvhekX4z6b15svb3NoB3JJlyn26+4plHHBoAbyGoFh20NAjn+
        BVB7h8RZ1OntA67Ku8khmisros3baSPqEb4JW4Qdvp6rGloiwwtldvYCF/LvsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389014;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joIhesn1BSMsmTZLymmmAauf/7+y+igCxLEplbm3cX8=;
        b=Up28qmaS2/Wb8lbLSH4d9FIz5/XTpXxAdxRbzaFnf3TWVvoUhJAl1lfy3BSwbcLTjfngXV
        LtchHKkbmLqMYqBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/checksum_32: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.899657959@infradead.org>
References: <20211110101325.899657959@infradead.org>
MIME-Version: 1.0
Message-ID: <163938901321.23020.4539009871738355365.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     fedb24cda1ca5407e1965b261e349ea85d6c03dc
Gitweb:        https://git.kernel.org/tip/fedb24cda1ca5407e1965b261e349ea85d6c03dc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:49 +01:00

x86/checksum_32: Remove .fixup usage

Simply add EX_FLAG_CLEAR_AX to do as the .fixup used to do.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101325.899657959@infradead.org
---
 arch/x86/lib/checksum_32.S | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 929ad17..23318c3 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -260,9 +260,9 @@ unsigned int csum_partial_copy_generic (const char *src, char *dst,
  * Copy from ds while checksumming, otherwise like csum_partial
  */
 
-#define EXC(y...)			\
-	9999: y;			\
-	_ASM_EXTABLE_UA(9999b, 6001f)
+#define EXC(y...)						\
+	9999: y;						\
+	_ASM_EXTABLE_TYPE(9999b, 7f, EX_TYPE_UACCESS | EX_FLAG_CLEAR_AX)
 
 #ifndef CONFIG_X86_USE_PPRO_CHECKSUM
 
@@ -358,15 +358,6 @@ EXC(	movb %cl, (%edi)	)
 	adcl $0, %eax
 7:
 
-# Exception handler:
-.section .fixup, "ax"							
-
-6001:
-	xorl %eax, %eax
-	jmp 7b
-
-.previous
-
 	popl %ebx
 	popl %esi
 	popl %edi
@@ -439,10 +430,6 @@ EXC(	movb %dl, (%edi)         )
 6:	addl %edx, %eax
 	adcl $0, %eax
 7:
-.section .fixup, "ax"
-6001:	xorl %eax, %eax
-	jmp  7b			
-.previous				
 
 	popl %esi
 	popl %edi
