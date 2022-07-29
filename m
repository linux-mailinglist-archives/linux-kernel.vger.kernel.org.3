Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C9D584C46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiG2HBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiG2HBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:01:38 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBC31F2E7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:01:37 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 67461302C2C;
        Fri, 29 Jul 2022 09:01:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1659078092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AofRFvzX6xW4zBEewbV9wBpxI70PpBinQrOT+pLLHig=;
        b=sgBGRwmVFj9IOMiSTaYFCZoV2K7sXRT/IaivywWU7b2NQ2GQADLol+aZCQs2vopn0Fk5jP
        BZMks8Tyamw++HXSdG42HgXAEzkZMAfPtYIM2d6ydNBQI5NCiVL/ozRnEuMSDqCwTFiozo
        rBEWRmjQQr+wCJC0kwOJXXqOA5a1qv6vqVCLlznXuzVsQXLUgOY06f0g/kNSegGJrtQ264
        sWtSY32o9jqlGYkhgQCR4cWfQoXJLaBiQ0cxbDQS+dufV7RYDboxvtt+EzsBxN1WWVGYN0
        fD1cUwh/fjACjHU6BfXLIaIscTdAMFbE8lbj4sbtUg4xm+yC9xxR7STVpJOE8g==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v5 1/5] x86/cacheinfo: move shared cache map definitions
Date:   Fri, 29 Jul 2022 09:01:18 +0200
Message-Id: <3181e52cb86b57f3a98dec4aaab8935f14b683a1.1659077534.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659077534.git.sander@svanheule.net>
References: <cover.1659077534.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maps to keep track of shared caches between CPUs on SMP systems are
declared in asm/smp.h, among them specifically cpu_llc_shared_map.  These
maps are externally defined in cpu/smpboot.c.  The latter is only compiled
on CONFIG_SMP=y, which means the declared extern symbols from asm/smp.h do
not have a corresponding definition on uniprocessor builds.

The inline cpu_llc_shared_mask() function from asm/smp.h refers to the map
declaration mentioned above.  This function is referenced in cacheinfo.c
inside for_each_cpu() loop macros, to provide cpumask for the loop.  On
uniprocessor builds, the symbol for the cpu_llc_shared_map does not exist.
However, the current implementation of for_each_cpu() also (wrongly)
ignores the provided mask.

By sheer luck, the compiler thus optimises out this unused reference to
cpu_llc_shared_map, and the linker therefore does not require the
cpu_llc_shared_mask to actually exist on uniprocessor builds.  Only on SMP
bulids does smpboot.o exist to provide the required symbols.

To no longer rely on compiler optimisations for successful uniprocessor
builds, move the definitions of cpu_llc_shared_map and cpu_l2c_shared_map
from smpboot.c to cacheinfo.c.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marco Elver <elver@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
Changes since v3:
- New patch

 arch/x86/kernel/cpu/cacheinfo.c | 6 ++++++
 arch/x86/kernel/smpboot.c       | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index fe98a1465be6..66556833d7af 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -29,6 +29,12 @@
 #define LVL_3		4
 #define LVL_TRACE	5
 
+/* Shared last level cache maps */
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
+
+/* Shared L2 cache maps */
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
+
 struct _cache_table {
 	unsigned char descriptor;
 	char cache_type;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5e7f9532a10d..f24227bc3220 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -95,10 +95,6 @@ EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 
-DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
-
-DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
-
 /* Per CPU bogomips and other parameters */
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
-- 
2.37.1

