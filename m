Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E693537937
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiE3KjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiE3Kiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:38:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F395D6B640;
        Mon, 30 May 2022 03:38:52 -0700 (PDT)
Date:   Mon, 30 May 2022 10:38:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653907131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTeQ6fnREq4qXDwHFkrj17z198VHA7y3Wn11fc0EtNg=;
        b=HbB8J7GaecFhS3TbiYK/iZW3z3OePZ/ACh8U+eDL4GO5lo/mwlrkQO/EVKIFc1u3AGd1cA
        S5LBPbJQdUVN9+pGd9EfLeYiAsKYGQT5uULuqru32bmuZUpnjRoHxFrGEl2Qi1OReLI3Bm
        CgyHcsNMM0sBF0TlWzv19Yvh7dzbq9GS/E8j302c/RXcLsPUYH/n306M8Hop5jyg1MmyxP
        Iu+xr6pooNXUT6qH988P7oCjUn7KEJEZhR32bxVReY4aiSAuk9IYxeV4ZlwV1UCBjez/lQ
        R8NmGuU6Ad10G6FWF6nGSBSmoh3YrHuIW12qqvcOKPan3tVmQ5/vBqZEqD2r3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653907131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTeQ6fnREq4qXDwHFkrj17z198VHA7y3Wn11fc0EtNg=;
        b=Pv2VjKmjh1eOKbgK9a1yXi+V65X3s4ZDGBrFiXsTnepHG1ACrauyRfIl7LuA6RsFkF1K3E
        SFTdU9Nqy4+Co5AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86/cpu: Elide KCSAN for cpu_has() and friends
Cc:     kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220502111216.290518605@infradead.org>
References: <20220502111216.290518605@infradead.org>
MIME-Version: 1.0
Message-ID: <165390713059.4207.4023459267386713267.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     a6a5eb269f6f3a2fe392f725a8d9052190c731e2
Gitweb:        https://git.kernel.org/tip/a6a5eb269f6f3a2fe392f725a8d9052190c731e2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 02 May 2022 12:15:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 May 2022 12:34:43 +02:00

x86/cpu: Elide KCSAN for cpu_has() and friends

As x86 uses the <asm-generic/bitops/instrumented-*.h> headers, the
regular forms of all bitops are instrumented with explicit calls to
KASAN and KCSAN checks. As these are explicit calls, these are not
suppressed by the noinstr function attribute.

This can result in calls to those check functions in noinstr code, which
objtool warns about:

vmlinux.o: warning: objtool: enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x28: call to __kcsan_check_access() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x24: call to __kcsan_check_access() leaves .noinstr.text section
vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section

Prevent this by using the arch_*() bitops, which are the underlying
bitops without explciit instrumentation.

[null: Changelog]
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220502111216.290518605@infradead.org
---
 arch/x86/include/asm/cpufeature.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 66d3e3b..ea34cc3 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -54,7 +54,7 @@ extern const char * const x86_power_flags[32];
 extern const char * const x86_bug_flags[NBUGINTS*32];
 
 #define test_cpu_cap(c, bit)						\
-	 test_bit(bit, (unsigned long *)((c)->x86_capability))
+	 arch_test_bit(bit, (unsigned long *)((c)->x86_capability))
 
 /*
  * There are 32 bits/features in each mask word.  The high bits
