Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589C45ADBB6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 01:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiIEXJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 19:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiIEXIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:08:40 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B78B6A488
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 16:08:29 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id m9so4564841qvv.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=O4yRGqEn6L/4OFD6cxa3VXtqQyIbnJ79Kwqapqi4kFI=;
        b=JJwG3wZl+3v7TyUrdNN78c67d0VjSAHn0E2H2AEfKVcLs07nDDFnz0mp35a1sklXlp
         MOkYRV4lGznqDAwiJh7cvoRUpLohHpYJm/CCFvsICkN3+Uvn6Nt8OWffVyjNpAePuuJH
         +YuPNoYWEr+UN224P5VnXRpl3kEIpcgip5j1YQIFOmEYmPK15ThPo/pnMTl3QX/+/G0l
         4iKyTUZI5CQ1CRtCoQfogIP3bVTKl441e2wymERu/Cz5SvDvVpFJe+Hy+0CcRqMMvgIU
         JeOzcAhNzPyEpFIaxZLbU6oohO9b3Fy7P4piH815ZO2N6BlazgxJIVkrVf0hVXKsP6ot
         QNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=O4yRGqEn6L/4OFD6cxa3VXtqQyIbnJ79Kwqapqi4kFI=;
        b=teV3EjSYigrq8/e66Gexs5K1gpq9DgUKp3P1R9Sm3a4rJ8RX+DQxfLMBDgQeIoq/e+
         kWIh6b1YWlu8w2oDFyn0Kbw+YRJBpEe84q2IrwH3FuD21hAZfNgZDJ59CQAaCW4rAObE
         jYa0kXg/6bqYE0q3XRPWdJkHePNffOKniQ6Smw2rksHv4UYoOe60nQ1EWm8MQBDq00QT
         50H83K3ZOk3X36HuAQ9ZpBB4VO8937fC3amZbM5WSWz33cj6E+dK6YAfO3WkgKsA842a
         gP/8gSdY9/qRHuiWy8QKibqZeCmGbkOd+G1TOFwI6zDcCjgMVxsIsk3DP2biRa9pfx+X
         zHKw==
X-Gm-Message-State: ACgBeo2G6kW64+W1y7AvA4mfBjeQniCYdzMi/ycSBwdnaGWkozjDguxW
        d/fTWg77S1afM09Y8yDXGMRnxlZIA0o=
X-Google-Smtp-Source: AA6agR6dh4igMPx1JjrupJhhmgnLE84HKJdEzxqcVsLZquVcZL+yCpw3prOLIvk5CN3f5ECJecMaSw==
X-Received: by 2002:a05:6214:20a8:b0:477:1882:3e7 with SMTP id 8-20020a05621420a800b00477188203e7mr42914082qvd.44.1662419308057;
        Mon, 05 Sep 2022 16:08:28 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:dde1:6b3e:62e9:1461])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a166300b006b5c061844fsm8916289qko.49.2022.09.05.16.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 16:08:27 -0700 (PDT)
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
Subject: [PATCH v2 5/5] lib/cpumask: add FORCE_NR_CPUS config option
Date:   Mon,  5 Sep 2022 16:08:20 -0700
Message-Id: <20220905230820.3295223-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220905230820.3295223-1-yury.norov@gmail.com>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
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
 include/linux/cpumask.h | 10 +++++++---
 kernel/smp.c            |  2 +-
 lib/Kconfig             |  9 +++++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index e01fba8ecc27..0753202819e5 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -35,16 +35,20 @@ typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
  */
 #define cpumask_pr_args(maskp)		nr_cpu_ids, cpumask_bits(maskp)
 
-#if NR_CPUS == 1
-#define nr_cpu_ids		1U
+#if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
+#define nr_cpu_ids ((unsigned int)NR_CPUS)
 #else
 extern unsigned int nr_cpu_ids;
+#endif
 
 static inline void set_nr_cpu_ids(unsigned int nr)
 {
+#if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
+	WARN_ON(nr != nr_cpu_ids);
+#else
 	nr_cpu_ids = nr;
-}
 #endif
+}
 
 /* Deprecated. Always use nr_cpu_ids. */
 #define nr_cpumask_bits	nr_cpu_ids
diff --git a/kernel/smp.c b/kernel/smp.c
index 150310a0947a..661d09ae5d6a 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1088,7 +1088,7 @@ static int __init maxcpus(char *str)
 
 early_param("maxcpus", maxcpus);
 
-#if (NR_CPUS > 1)
+#if (NR_CPUS > 1) && !defined(CONFIG_FORCE_NR_CPUS)
 /* Setup number of possible processor ids */
 unsigned int nr_cpu_ids __read_mostly = NR_CPUS;
 EXPORT_SYMBOL(nr_cpu_ids);
diff --git a/lib/Kconfig b/lib/Kconfig
index dc1ab2ed1dc6..77ead982c8b9 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -527,6 +527,15 @@ config CPUMASK_OFFSTACK
 	  them on the stack.  This is a bit more expensive, but avoids
 	  stack overflow.
 
+config FORCE_NR_CPUS
+       bool "NR_CPUS is set to an actual number of CPUs"
+       depends on SMP
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

