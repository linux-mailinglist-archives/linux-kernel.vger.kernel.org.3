Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675E74B3AFA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 12:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiBMK76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 05:59:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiBMK74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 05:59:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5825E74F;
        Sun, 13 Feb 2022 02:59:51 -0800 (PST)
Date:   Sun, 13 Feb 2022 10:59:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644749988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkyQjo0ugeftPsZyQjLZirnYBh2nhZlLJr53w+AvS3k=;
        b=AM8xTou4Gmszu2WpoBrDFRpmA3tKx1SXU0XtJlmz3YiSmYjsNsEp6aA3lRgKpkIjw4LpwE
        XQ7ukXenXWadTI3lM7uQH8mKl9Ldj1a5Nt4p/5susL+F29S5HMlKj/wIQsxeioBnki/tCl
        8Y3zlESMClNgkYrm61AwyQb5jrOTyUjoxzCwcsqnFcmFyCvADjFrNU/99MNGOCWBEbYikP
        21J4OoJVrnqi+PT3HkxhHiyX94H818FX7BP07YVVIQfrTNJthOGIDxgrimjYDF73N33ZYT
        p0TTuoofEbTDAp03v3Y7+GWEXfAD7FTGyEy0l7DH1edftP7NEANNl3WwQ+Utfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644749988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkyQjo0ugeftPsZyQjLZirnYBh2nhZlLJr53w+AvS3k=;
        b=gJrjxMb++vuI3tvdaX7j9Yhj+fSOapDDh8Wa2FHar/AMKJvHZkeP3Zc9KjKM7KBughtSaS
        LpETmv9Irm2hFoBQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cpumask: Add a x86-specific cpumask_clear_cpu() helper
Cc:     Borislav Petkov <bp@suse.de>, Marco Elver <elver@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220204083015.17317-2-bp@alien8.de>
References: <20220204083015.17317-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164474998765.16921.8420399786345053314.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f5c54f77b07b278cfde4a654e111c39996ac8b5b
Gitweb:        https://git.kernel.org/tip/f5c54f77b07b278cfde4a654e111c39996ac8b5b
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 04 Feb 2022 09:30:13 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 12 Feb 2022 18:20:05 +01:00

cpumask: Add a x86-specific cpumask_clear_cpu() helper

Add a x86-specific cpumask_clear_cpu() helper which will be used in
places where the explicit KASAN-instrumentation in the *_bit() helpers
is unwanted.

Also, always inline two more cpumask generic helpers.

allyesconfig:

     text    data     bss     dec     hex filename
  190553143       159425889       32076404        382055436       16c5b40c vmlinux.before
  190551812       159424945       32076404        382053161       16c5ab29 vmlinux.after

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20220204083015.17317-2-bp@alien8.de
---
 arch/x86/include/asm/cpumask.h | 10 ++++++++++
 include/linux/cpumask.h        |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpumask.h b/arch/x86/include/asm/cpumask.h
index 3afa990..c5aed9e 100644
--- a/arch/x86/include/asm/cpumask.h
+++ b/arch/x86/include/asm/cpumask.h
@@ -20,11 +20,21 @@ static __always_inline bool arch_cpu_online(int cpu)
 {
 	return arch_test_bit(cpu, cpumask_bits(cpu_online_mask));
 }
+
+static __always_inline void arch_cpumask_clear_cpu(int cpu, struct cpumask *dstp)
+{
+	arch_clear_bit(cpumask_check(cpu), cpumask_bits(dstp));
+}
 #else
 static __always_inline bool arch_cpu_online(int cpu)
 {
 	return cpu == 0;
 }
+
+static __always_inline void arch_cpumask_clear_cpu(int cpu, struct cpumask *dstp)
+{
+	return;
+}
 #endif
 
 #define arch_cpu_is_offline(cpu)	unlikely(!arch_cpu_online(cpu))
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 6b06c69..fe29ac7 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -102,7 +102,7 @@ extern atomic_t __num_online_cpus;
 
 extern cpumask_t cpus_booted_once_mask;
 
-static inline void cpu_max_bits_warn(unsigned int cpu, unsigned int bits)
+static __always_inline void cpu_max_bits_warn(unsigned int cpu, unsigned int bits)
 {
 #ifdef CONFIG_DEBUG_PER_CPU_MAPS
 	WARN_ON_ONCE(cpu >= bits);
@@ -110,7 +110,7 @@ static inline void cpu_max_bits_warn(unsigned int cpu, unsigned int bits)
 }
 
 /* verify cpu argument to cpumask_* operators */
-static inline unsigned int cpumask_check(unsigned int cpu)
+static __always_inline unsigned int cpumask_check(unsigned int cpu)
 {
 	cpu_max_bits_warn(cpu, nr_cpumask_bits);
 	return cpu;
