Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721924643F4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345790AbhLAAgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:36:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37018 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345744AbhLAAgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:36:25 -0500
Date:   Wed, 01 Dec 2021 00:33:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638318783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rezJIXcD/bfCi74XzQZQj0U0qRybCQo491/BBzNqnj8=;
        b=2QXb9qOlyp4NEMi8Y1O6UjLAijytKz18H159rubRJK5bcTR1flsOoQnqBGf2L6UsokOace
        jAt2+i0yVs/dm2sFW9YJj9egXUOtzGRYsNgHkz3iKMtYRlK25ma01hG+gZ6Um0wrr40rAu
        tUhrNe7JcS3YMI5wmXsKlvMppsF4j+PmMl/nFkkFLII1+n013xnIRHHSIDc5aEh8/3oNpi
        98A4RNrhocXzRjIAYcTVTxPhYu+mzhZecO8vxpBdBLo42cA6DOzDRYKzRm+RbzB5rZ4rd8
        RG0x2Kjw23MNWzaSIyI3f3EgDJeTjp/ba7bda/GyapWImABJr7MwtUGALPYVOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638318783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rezJIXcD/bfCi74XzQZQj0U0qRybCQo491/BBzNqnj8=;
        b=JxywvDMW2JTOBct2r3p6eHiDE1jMHbRDaner2GTJmNE/vMpPwkVZdydrxLMBbhXUPLPQP/
        eWeuJiAL2mlCzVAg==
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/csum: Fix initial seed for odd buffers
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211125141817.3541501-1-eric.dumazet@gmail.com>
References: <20211125141817.3541501-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Message-ID: <163831878239.11128.3793034988701149763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2a144bcd661c4f0a503e03f9280e88854ac0bb37
Gitweb:        https://git.kernel.org/tip/2a144bcd661c4f0a503e03f9280e88854ac0bb37
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Thu, 25 Nov 2021 06:18:17 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 30 Nov 2021 16:26:03 -08:00

x86/csum: Fix initial seed for odd buffers

When I folded do_csum() into csum_partial(), I missed that we
had to swap odd/even bytes from @sum argument.

This is because this swap will happen again at the end of the function.

[A, B, C, D] -> [B, A, D, C]

As far as Internet checksums (rfc 1071) are concerned, we can instead
rotate the whole 32bit value by 8 (or 24)

-> [D, A, B, C]

Note that I played with the idea of replacing this final swapping:

    result = from32to16(result);
    result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);

With:

    result = ror32(result, 8);

But while the generated code was definitely better for the odd case,
run time cost for the more likely even case was not better for gcc.

gcc is replacing a well predicted conditional branch
with a cmov instruction after a ror instruction which adds
a cost canceling the cmov gain.

Many thanks to Noah Goldstein for reporting this issue.

[ dhansen: * spelling: swaping => swapping
	   * updated Fixes commit  ]

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: d31c3c683ee6 ("x86/csum: Rewrite/optimize csum_partial()")
Reported-by: Noah Goldstein <goldstein.w.n@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20211125141817.3541501-1-eric.dumazet@gmail.com
---
 arch/x86/lib/csum-partial_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 1eb8f2d..40b527b 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -41,6 +41,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 	if (unlikely(odd)) {
 		if (unlikely(len == 0))
 			return sum;
+		temp64 = ror32((__force u32)sum, 8);
 		temp64 += (*(unsigned char *)buff << 8);
 		len--;
 		buff++;
