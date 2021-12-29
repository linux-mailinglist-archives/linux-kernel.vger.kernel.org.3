Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77D24812F7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhL2M5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:57:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37196 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbhL2M5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:57:06 -0500
Date:   Wed, 29 Dec 2021 12:57:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640782625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HeKjxypRjQVj0YfMTfvkq5lcRc9uJj9O16NmBzUCGg=;
        b=s7z+fj+9eFiBZvSiEpQFpcFPwytNdR1bQcuGDajysk//27dgIrKDqWfkUHsCULzS9JGbZk
        zwv0NsSyEHrrpBgdB/c35qGzB7VvGAAoj5Sv4ZzugKtZnjMEsEj3SrCXuLzCVOy2lQwUIQ
        66V3PxSZeT1AiQpH4rkUPPsQhtjgd8QdVC5DB0/IXxvIGMOQUwDFrhrLr0nXgZ2/SBwCtF
        sNmsDMorRHx6xzmowyPhEe1oT09/qemu2ZOjxMCIyvGxcgi0JnDe4fstkclgkoonJYboxv
        TLfWm7vsMKXaJkGzM36l8qKfFnMMBbrmQpKO1/R9s3iZgmLZbv1KEiJxs6CjgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640782625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HeKjxypRjQVj0YfMTfvkq5lcRc9uJj9O16NmBzUCGg=;
        b=eAhGA7YtuuqR3M24bRvbDfqP6WaQubVw2NSMphY/yahuNXVbX9R4s8YB4xVgdHzTD9Qljp
        dOGvE8LboB14EqBA==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/lib: Add fast-short-rep-movs check to
 copy_user_enhanced_fast_string()
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211216172431.1396371-1-tony.luck@intel.com>
References: <20211216172431.1396371-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <164078262396.16921.15044282056397514448.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     244122b4d2e5221e6abd6e21d6a58170104db781
Gitweb:        https://git.kernel.org/tip/244122b4d2e5221e6abd6e21d6a58170104db781
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 16 Dec 2021 09:24:31 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 29 Dec 2021 13:46:02 +01:00

x86/lib: Add fast-short-rep-movs check to copy_user_enhanced_fast_string()

Commit

  f444a5ff95dc ("x86/cpufeatures: Add support for fast short REP; MOVSB")

fixed memmove() with an ALTERNATIVE that will use REP MOVSB for all
string lengths.

copy_user_enhanced_fast_string() has a similar run time check to avoid
using REP MOVSB for copies less that 64 bytes.

Add an ALTERNATIVE to patch out the short length check and always use
REP MOVSB on X86_FEATURE_FSRM CPUs.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211216172431.1396371-1-tony.luck@intel.com
---
 arch/x86/lib/copy_user_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 2797e63..1c429f0 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -200,8 +200,8 @@ EXPORT_SYMBOL(copy_user_generic_string)
  */
 SYM_FUNC_START(copy_user_enhanced_fast_string)
 	ASM_STAC
-	cmpl $64,%edx
-	jb .L_copy_short_string	/* less then 64 bytes, avoid the costly 'rep' */
+	/* CPUs without FSRM should avoid rep movsb for short copies */
+	ALTERNATIVE "cmpl $64, %edx; jb .L_copy_short_string", "", X86_FEATURE_FSRM
 	movl %edx,%ecx
 1:	rep
 	movsb
