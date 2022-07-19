Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93E757A6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbiGSTFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiGSTFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:05:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0152C105;
        Tue, 19 Jul 2022 12:05:20 -0700 (PDT)
Date:   Tue, 19 Jul 2022 19:05:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658257518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ur+bosjTdvrAmhdhVF8+GUTIU+bcYGG9cbu/MPrynHM=;
        b=2Z9BS3jGsAJffUxlpwc0qXZZ/acGveFsHjgCpnFezQD0QQ7mGwpmPQ1k4ZU7LP2KY7Z/xw
        GLwdSVBzSNq0B/gOZe3/FYJT+zHQd8xZcnQHdafmZONEV8GSti9YprUI+wgaa7n9NZcwVf
        8Ozs2ks7EI4yD/P2MPkJT/N3VQO74tyxurbH26doOB2c7pDQtGvDXuzaIeG1MsJWwNL6Uy
        n0BRP1K7zZ2eTgV9ZkSTn4T4N+BRn6DkSTpfyWftHK6OklbDH3Fthx0gQVzWtCwMRACRe4
        Y2WxSpHlVrxxKKq536xKZquXV+9mCS2FIvYAB1xkjyC4Y3m41cHxh20xiElUbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658257518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ur+bosjTdvrAmhdhVF8+GUTIU+bcYGG9cbu/MPrynHM=;
        b=1/6hfCzq//LpESTB5RzwemFKhADx7+VRmzJkXcjais0rwN8kTiHsY0wslifYHHeW54ET5g
        WwTmvK16WYkAl8Dw==
From:   "tip-bot2 for Paolo Bonzini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Use MSR_IA32_MISC_ENABLE constants
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220719174714.2410374-1-pbonzini@redhat.com>
References: <20220719174714.2410374-1-pbonzini@redhat.com>
MIME-Version: 1.0
Message-ID: <165825751659.15455.988965721431093614.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     3f2adf00f52b5f2e9e9f23bb5c77608fc9ee297c
Gitweb:        https://git.kernel.org/tip/3f2adf00f52b5f2e9e9f23bb5c77608fc9ee297c
Author:        Paolo Bonzini <pbonzini@redhat.com>
AuthorDate:    Tue, 19 Jul 2022 13:47:14 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 19 Jul 2022 20:53:10 +02:00

x86/cpu: Use MSR_IA32_MISC_ENABLE constants

Instead of the magic numbers 1<<11 and 1<<12 use the constants
from msr-index.h.  This makes it obvious where those bits
of MSR_IA32_MISC_ENABLE are consumed (and in fact that Linux
consumes them at all) to simple minds that grep for
MSR_IA32_MISC_ENABLE_.*_UNAVAIL.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220719174714.2410374-1-pbonzini@redhat.com
---
 arch/x86/kernel/cpu/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43..a00dd3e 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -647,9 +647,9 @@ static void init_intel(struct cpuinfo_x86 *c)
 		unsigned int l1, l2;
 
 		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
-		if (!(l1 & (1<<11)))
+		if (!(l1 & MSR_IA32_MISC_ENABLE_BTS_UNAVAIL))
 			set_cpu_cap(c, X86_FEATURE_BTS);
-		if (!(l1 & (1<<12)))
+		if (!(l1 & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL))
 			set_cpu_cap(c, X86_FEATURE_PEBS);
 	}
 
