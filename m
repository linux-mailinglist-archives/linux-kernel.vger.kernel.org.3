Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3964A951F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356585AbiBDIab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:30:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42776 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235995AbiBDIa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:30:27 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 971ED1EC06AC;
        Fri,  4 Feb 2022 09:30:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643963426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uUxrRkm5Pxwz9YvTSj144qOQmRMXo8XRT92N+FuPrgQ=;
        b=I9fl7uBhSnCB+uuUXwI9B/lfErkhzXNkW+vyVDhziUHJozeIzwjCV6K4h9TA5Tz+1hUNcf
        rADB6BMXu55cq7z+ECnfZGQunzy30sQXAfNxyusSRxeaGIB5XDawMRQfwdKjO17LPunkGE
        RHADnTQlub42GvXxYgz7oz+fBtthV8E=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] cpumask: Add a x86-specific cpumask_clear_cpu() helper
Date:   Fri,  4 Feb 2022 09:30:13 +0100
Message-Id: <20220204083015.17317-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220204083015.17317-1-bp@alien8.de>
References: <20220204083015.17317-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Add a x86-specific cpumask_clear_cpu() helper which will be used in
places where the explicit KASAN-instrumentation in the *_bit() helpers
is unwanted.

Also, always inline two more cpumask generic helpers.

allyesconfig:

   text    data     bss     dec     hex filename
190553143       159425889       32076404        382055436       16c5b40c vmlinux.before
190551812       159424945       32076404        382053161       16c5ab29 vmlinux.after

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cpumask.h | 10 ++++++++++
 include/linux/cpumask.h        |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpumask.h b/arch/x86/include/asm/cpumask.h
index 3afa990d756b..c5aed9e9226c 100644
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
index 6b06c698cd2a..fe29ac7cc469 100644
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
-- 
2.29.2

