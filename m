Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1450C5696AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiGGAAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiGGAAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:00:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971F32D1C5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 17:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 326B761740
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96EEC3411C;
        Thu,  7 Jul 2022 00:00:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UImCQNnM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657152028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kQsp8EMtkPcQU2FTfh1hvHbXaN68lCxweHeYSEJfnYU=;
        b=UImCQNnMYLr0CrDK4EZDySpWKkSs9P1TERbqk2yZlD7R240N++JPxR2z4r4R/fJUKYqekU
        UDYQNYUwdvyOmy2voce7IdLWNAuN9kTqdJAJ4gt6W/M3/ImCJWT86EmqEjV7lRaHWIRILM
        XvCwHdrvXwCWepJ3ua/Uo93VMIfw0ww=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id feb9a2e5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 7 Jul 2022 00:00:28 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, x86@kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>
Subject: [PATCH] random: remove "nordrand" flag in favor of "random.trust_cpu"
Date:   Thu,  7 Jul 2022 02:00:21 +0200
Message-Id: <20220707000021.504308-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decision of whether or not to trust RDRAND is controlled by the
"random.trust_cpu" boot time parameter or the CONFIG_RANDOM_TRUST_CPU
compile time default. The "nordrand" flag was added during the early
days of RDRAND, when there were worries that merely using its values
could compromise the RNG. However, these days, RDRAND values are not
used directly but always go through the RNG's hash function, making
"nordrand" no longer useful.

Rather, the correct switch is "random.trust_cpu", which not only handles
the relevant trust issue directly, but also is general to multiple CPU
types, not just x86.

However, x86 RDRAND does have a history of being occassionally
problematic. Prior, when the kernel would notice something strange, it'd
warn in dmesg and suggest enabling "nordrand". We can improve on that by
making the test a little bit better and then taking the step of
automatically disabling "nordrand" if we detect it's problematic.

Also extend the basic sanity test to RDSEED in addition to RDRAND, and
disable both if either one fails.

Cc: x86@kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
This patch builds on top of v4 of "random: remove CONFIG_ARCH_RANDOM":
https://lore.kernel.org/lkml/20220706143521.459565-1-Jason@zx2c4.com/

 .../admin-guide/kernel-parameters.txt         |  5 --
 arch/x86/kernel/cpu/amd.c                     |  2 +-
 arch/x86/kernel/cpu/rdrand.c                  | 73 +++++++++----------
 3 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2522b11e593f..a1dc4dbf74f6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3733,11 +3733,6 @@
 	noreplace-smp	[X86-32,SMP] Don't replace SMP instructions
 			with UP alternatives
 
-	nordrand	[X86] Disable kernel use of the RDRAND and
-			RDSEED instructions even if they are supported
-			by the processor.  RDRAND and RDSEED are still
-			available to user space applications.
-
 	noresume	[SWSUSP] Disables resume and restores original swap
 			space.
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 0c0b09796ced..216fc2f53cbe 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -808,7 +808,7 @@ static void clear_rdrand_cpuid_bit(struct cpuinfo_x86 *c)
 		return;
 
 	/*
-	 * The nordrand option can clear X86_FEATURE_RDRAND, so check for
+	 * The self test can clear X86_FEATURE_RDRAND, so check for
 	 * RDRAND support using the CPUID function directly.
 	 */
 	if (!(cpuid_ecx(1) & BIT(30)) || rdrand_force)
diff --git a/arch/x86/kernel/cpu/rdrand.c b/arch/x86/kernel/cpu/rdrand.c
index 8f216669ecb8..6f4b196fe97d 100644
--- a/arch/x86/kernel/cpu/rdrand.c
+++ b/arch/x86/kernel/cpu/rdrand.c
@@ -11,54 +11,51 @@
 #include <asm/archrandom.h>
 #include <asm/sections.h>
 
-static int __init x86_rdrand_setup(char *s)
-{
-	setup_clear_cpu_cap(X86_FEATURE_RDRAND);
-	setup_clear_cpu_cap(X86_FEATURE_RDSEED);
-	return 1;
-}
-__setup("nordrand", x86_rdrand_setup);
-
 /*
  * RDRAND has Built-In-Self-Test (BIST) that runs on every invocation.
- * Run the instruction a few times as a sanity check.
- * If it fails, it is simple to disable RDRAND here.
+ * Run the instruction a few times as a sanity check. Also make sure
+ * it's not outputting the same value over and over, which has happened
+ * as a result of past CPU bugs.
+ *
+ * If it fails, it is simple to disable RDRAND and RDSEED here.
  */
-#define SANITY_CHECK_LOOPS 8
 
 void x86_init_rdrand(struct cpuinfo_x86 *c)
 {
-	unsigned int changed = 0;
-	unsigned long tmp, prev;
-	int i;
-
-	if (!cpu_has(c, X86_FEATURE_RDRAND))
-		return;
-
-	for (i = 0; i < SANITY_CHECK_LOOPS; i++) {
-		if (!rdrand_long(&tmp)) {
-			clear_cpu_cap(c, X86_FEATURE_RDRAND);
-			pr_warn_once("rdrand: disabled\n");
-			return;
+	enum { SAMPLES = 8, MIN_CHANGE = 5 };
+	unsigned long sample, prev;
+	bool failure = false;
+	size_t i, changed;
+
+	if (cpu_has(c, X86_FEATURE_RDRAND)) {
+		for (changed = 0, i = 0; i < SAMPLES; ++i) {
+			if (!rdrand_long(&sample)) {
+				failure = true;
+				break;
+			}
+			changed += i && sample != prev;
+			prev = sample;
 		}
+		if (changed < MIN_CHANGE)
+			failure = true;
 	}
 
-	/*
-	 * Stupid sanity-check whether RDRAND does *actually* generate
-	 * some at least random-looking data.
-	 */
-	prev = tmp;
-	for (i = 0; i < SANITY_CHECK_LOOPS; i++) {
-		if (rdrand_long(&tmp)) {
-			if (prev != tmp)
-				changed++;
-
-			prev = tmp;
+	if (cpu_has(c, X86_FEATURE_RDSEED)) {
+		for (changed = 0, i = 0; i < SAMPLES; ++i) {
+			if (!rdseed_long(&sample)) {
+				failure = true;
+				break;
+			}
+			changed += i && sample != prev;
+			prev = sample;
 		}
+		if (changed < MIN_CHANGE)
+			failure = true;
 	}
 
-	if (WARN_ON_ONCE(!changed))
-		pr_emerg(
-"RDRAND gives funky smelling output, might consider not using it by booting with \"nordrand\"");
-
+	if (failure) {
+		clear_cpu_cap(c, X86_FEATURE_RDRAND);
+		clear_cpu_cap(c, X86_FEATURE_RDSEED);
+		pr_emerg("RDRAND and RDSEED are not reliable on this platform; disabling.\n");
+	}
 }
-- 
2.35.1

