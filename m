Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2595A5265
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiH2Q6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiH2Q6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:58:01 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA109A9AE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:57:55 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id s22so4003468qkj.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=phNzhxWfsmUQ2u7NLzuDZu8A19if4dC4wAlhFRDjgx4=;
        b=pNuX9maN4/h701mSr5cZiAKMg+Y4R+518jxFEZ4jK4aoEPcgsuA6dS++6Grn3kF54E
         no/uVarUCSOjLouaLxW2XWKCTgmRcD7UKehC6mu96BXhsbhP7wcCM3IYEUmyoN7Zyiqx
         3EKE92GPYujfZGVu3GqCypXcofzIXNOJ1XIDxi5tecVDWmNDICrgjCfZVPRvK4LMoYeY
         LPbzmjdY8EqQUykP7iyotqfGeTThhAIVPJLCrJD8Nq/BPfJTDsZMCk6EMeSsCgOQzpfN
         SEQPDDu6vBwnZs4SMLcjWz3bv206+4//w7uX9cTVsuMqSrs4/9hkm61+4hfOVriARlJE
         UO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=phNzhxWfsmUQ2u7NLzuDZu8A19if4dC4wAlhFRDjgx4=;
        b=cyQNXwa9ccqJKfdjGyMOCRFHE921KQSJ+8dzg/nfoYjhyj13P7hN2wCuoN6LT6XHjO
         +iM1HSd0caaKLLmsQAgRWw85mDFkLnzeDzvCBWm/xPAPeuii9BWk+5nRKAxG6AQ6IkRA
         PhicTjvefShqNv/RYYGwdpTfm+Hm8fe1YYuQTW3liahTTz57KuBAhYDS6Ay5NKPkZBEU
         XVmn4vjve6n7ia9A4IN+i6b3hwEFeZrG7xUbsaP9xOUtYrNnVgbdmUNHAEyKun5rFyzd
         JA9y+QZwixVnv5wEoq2erxDorT099tMKdoFKLKWxLrka1rTDiHl2y8eV08azXaKLcEji
         Gdmw==
X-Gm-Message-State: ACgBeo0k9iZQTG3f/c+baEME16Ej7Fga0/aeOenNMpjD7VKOC6lUrYM3
        5mT2gwHIt3xVS/WA8/czGrA6jJy603E=
X-Google-Smtp-Source: AA6agR4wZ0WnSV9MSswRQWWLaVE/5Zq5kAuCMk60jvZ6+eIlb5ARgxFruBm0Y870qguCzIrKfYgufA==
X-Received: by 2002:a05:620a:29c3:b0:6bb:33ac:9130 with SMTP id s3-20020a05620a29c300b006bb33ac9130mr9458644qkp.701.1661792274783;
        Mon, 29 Aug 2022 09:57:54 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:5d44:81a:c7bc:27d1])
        by smtp.gmail.com with ESMTPSA id l7-20020a05620a28c700b006a793bde241sm6119716qkp.63.2022.08.29.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:57:54 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4/4] lib/cpumask: add FORCE_NR_CPUS config option
Date:   Mon, 29 Aug 2022 09:57:48 -0700
Message-Id: <20220829165748.1008477-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829165748.1008477-1-yury.norov@gmail.com>
References: <20220829165748.1008477-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of cpumasks is hard-limited by compile-time parameter NR_CPUS,
but defined at boot-time when kernel parses ACPI/DT tables, and stored in
nr_cpu_ids. In many practical cases, number of CPUs for a target is known
at compile time, and can be provided with NR_CPUS.

In that case, compiler may be instructed to rely on NR_CPUS as on actual
number of CPUs, not an upper limit. It allows to optimize many cpumask
routines and significantly shrink size of the kernel image.

This patch adds FORCE_NR_CPUS option to teach the compiler to rely on
NR_CPUS and enable corresponding optimizations.

If FORCE_NR_CPUS=y, kernel will not set nr_cpu_ids at boot, but only check
that the actual number of possible CPUs is equal to NR_CPUS, and WARN if
that doesn't hold.

The new option is especially useful in embedded applications because
kernel configurations are unique for each SoC, the number of CPUs is
constant and known well, and memory limitations are typically harder.

For my 4-CPU ARM64 build with NR_CPUS=4, FORCE_NR_CPUS=y saves 46KB:
  add/remove: 3/4 grow/shrink: 46/729 up/down: 652/-46952 (-46300)

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h |  4 ++--
 include/linux/smp.h     |  4 ++++
 kernel/smp.c            |  2 ++
 lib/Kconfig             | 10 ++++++++++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index b7b863cf8831..702c05329853 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -35,8 +35,8 @@ typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
  */
 #define cpumask_pr_args(maskp)		nr_cpu_ids, cpumask_bits(maskp)
 
-#if NR_CPUS == 1
-#define nr_cpu_ids		1U
+#if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
+#define nr_cpu_ids ((unsigned int)NR_CPUS)
 #else
 extern unsigned int nr_cpu_ids;
 #endif
diff --git a/include/linux/smp.h b/include/linux/smp.h
index c9e7a9abef2f..e9e74e08c886 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -183,7 +183,11 @@ static inline int get_boot_cpu_id(void)
 
 static inline void set_nr_cpu_ids(unsigned int nr)
 {
+#ifdef CONFIG_FORCE_NR_CPUS
+	WARN_ON(nr_cpu_ids != nr);
+#else
 	nr_cpu_ids = nr;
+#endif
 }
 
 #else /* !SMP */
diff --git a/kernel/smp.c b/kernel/smp.c
index 27d4ed0aee55..9cd1d02221ba 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1088,9 +1088,11 @@ static int __init maxcpus(char *str)
 
 early_param("maxcpus", maxcpus);
 
+#ifndef CONFIG_FORCE_NR_CPUS
 /* Setup number of possible processor ids */
 unsigned int nr_cpu_ids __read_mostly = NR_CPUS;
 EXPORT_SYMBOL(nr_cpu_ids);
+#endif
 
 /* An arch may set nr_cpu_ids earlier if needed, so this would be redundant */
 void __init setup_nr_cpu_ids(void)
diff --git a/lib/Kconfig b/lib/Kconfig
index dc1ab2ed1dc6..5de23382e5f3 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -527,6 +527,16 @@ config CPUMASK_OFFSTACK
 	  them on the stack.  This is a bit more expensive, but avoids
 	  stack overflow.
 
+config FORCE_NR_CPUS
+       bool "NR_CPUS is set to an actual number of CPUs"
+       depends on SMP
+       default n
+       help
+         Say Yes if you have NR_CPUS set to an actual number of possible
+         CPUs in your system, not to a default value. This forces the core
+         code to rely on compile-time value and optimize kernel routines
+         better.
+
 config CPU_RMAP
 	bool
 	depends on SMP
-- 
2.34.1

