Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89AB5A5260
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiH2Q6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiH2Q5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:57:53 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8189A994
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:57:52 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id m5so6501955qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hvI2niVAJoh8fUEWHOj2VZhpKK/Cae+ERjbEGQgj2F0=;
        b=gVN4m3vzK5CCR0qPbV8PX246fCclVzWSB3Ccu4giC6PqzaJkt8gmrEMqT9q5/RoAGR
         TeTCJG3JX5vrchahPvBTzFTuKmJQ4tNLJsQF8sHCCKUGLtreGy7mYeJPyBF8EVDpFmZq
         jEHvzwOmCwKW21eJdBHA+XxcIXOsiDpK1NvxtmU9kvPI+Jy9s02M4pGeSateSLOkA7kn
         Fdj6/0tjhmI1RSskJNjmqjyeT8ApSoy+THP7ysi41fCMRqAe99Ci/n2UNDSOqDQeqWlX
         WrH6g2wwNvAKOTGlCAKQUTJcQ4//9WlV9pJ2nv1Qrf7QPHGRSwgnf6kGCztG9v8v7pJY
         h2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hvI2niVAJoh8fUEWHOj2VZhpKK/Cae+ERjbEGQgj2F0=;
        b=qN/mb4Mye93DLLq+VjsQca7CQzfhBImAkE104j3cONjPp6BWTfwJ1iFzY0VbNfNL7y
         zkxf0/BABmyaF3L6fzdEj7J8joHARX65mTaTplKIPPbxqKzHVN1r5sLeh0Kt0g+ace4p
         /NLm8w4P6lSPe4wbd/G/MznEC2GLHSWUu32pffc1ObXlzu4G5wZgXBCwg1bvJdaWvWK3
         mbUO8QE5H7JbLf0MGvHj1xhIsIrm95k0+F4NQcdPjpNhFse45EiWiWiocf7GYF/4g0xl
         5TGUeEBShaBI1udE3DR4HIxCxBZaPkyu9D2gWfHDAZ030ta8Pby+RNlTPdsoYIkcKJK9
         QSUg==
X-Gm-Message-State: ACgBeo38J2HAQjM0O/Airpv839l61HA7FCEG16NveI5ON2I8SMKHKF9J
        EZ2jv1fNp8i9i1QKiv8TO+PNqwW4/Xs=
X-Google-Smtp-Source: AA6agR7D5NX+4JNVsTlQTiGX3lGmlai40N4SbIGYPtOQ8DkSFYmt/Abs5KTNL2OrN8ta9XEvelUnTQ==
X-Received: by 2002:a05:620a:170c:b0:6bb:208c:d276 with SMTP id az12-20020a05620a170c00b006bb208cd276mr9037223qkb.539.1661792271700;
        Mon, 29 Aug 2022 09:57:51 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:5d44:81a:c7bc:27d1])
        by smtp.gmail.com with ESMTPSA id bj4-20020a05620a190400b006b5c061844fsm6305404qkb.49.2022.08.29.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:57:51 -0700 (PDT)
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
Subject: [PATCH 1/4] smp: add set_nr_cpu_ids()
Date:   Mon, 29 Aug 2022 09:57:45 -0700
Message-Id: <20220829165748.1008477-2-yury.norov@gmail.com>
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

In preparation for support of compile-time nr_cpu_ids, add a setter for
the variable.

This is a no-op for all arches.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/loongarch/kernel/setup.c | 2 +-
 arch/mips/kernel/setup.c      | 2 +-
 arch/x86/kernel/smpboot.c     | 4 ++--
 arch/x86/xen/smp_pv.c         | 2 +-
 include/linux/smp.h           | 5 +++++
 kernel/smp.c                  | 4 ++--
 6 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 8f5c2f9a1a83..18a81edd3ac5 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -346,7 +346,7 @@ static void __init prefill_possible_map(void)
 	for (; i < NR_CPUS; i++)
 		set_cpu_possible(i, false);
 
-	nr_cpu_ids = possible;
+	set_nr_cpu_ids(possible);
 }
 #endif
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2ca156a5b231..e8a0759cb4d0 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -750,7 +750,7 @@ static void __init prefill_possible_map(void)
 	for (; i < NR_CPUS; i++)
 		set_cpu_possible(i, false);
 
-	nr_cpu_ids = possible;
+	set_nr_cpu_ids(possible);
 }
 #else
 static inline void prefill_possible_map(void) {}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f24227bc3220..3f3ea0287f69 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1316,7 +1316,7 @@ static void __init smp_sanity_check(void)
 			nr++;
 		}
 
-		nr_cpu_ids = 8;
+		set_nr_cpu_ids(8);
 	}
 #endif
 
@@ -1569,7 +1569,7 @@ __init void prefill_possible_map(void)
 		possible = i;
 	}
 
-	nr_cpu_ids = possible;
+	set_nr_cpu_ids(possible);
 
 	pr_info("Allowing %d CPUs, %d hotplug CPUs\n",
 		possible, max_t(int, possible - num_processors, 0));
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index ba7af2eca755..480be82e9b7b 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -179,7 +179,7 @@ static void __init _get_smp_config(unsigned int early)
 	 * hypercall to expand the max number of VCPUs an already
 	 * running guest has. So cap it up to X. */
 	if (subtract)
-		nr_cpu_ids = nr_cpu_ids - subtract;
+		set_nr_cpu_ids(nr_cpu_ids - subtract);
 #endif
 
 }
diff --git a/include/linux/smp.h b/include/linux/smp.h
index a80ab58ae3f1..c9e7a9abef2f 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -181,6 +181,11 @@ static inline int get_boot_cpu_id(void)
 	return __boot_cpu_id;
 }
 
+static inline void set_nr_cpu_ids(unsigned int nr)
+{
+	nr_cpu_ids = nr;
+}
+
 #else /* !SMP */
 
 static inline void smp_send_stop(void) { }
diff --git a/kernel/smp.c b/kernel/smp.c
index 650810a6f29b..27d4ed0aee55 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1070,7 +1070,7 @@ static int __init nrcpus(char *str)
 	int nr_cpus;
 
 	if (get_option(&str, &nr_cpus) && nr_cpus > 0 && nr_cpus < nr_cpu_ids)
-		nr_cpu_ids = nr_cpus;
+		set_nr_cpu_ids(nr_cpus);
 
 	return 0;
 }
@@ -1095,7 +1095,7 @@ EXPORT_SYMBOL(nr_cpu_ids);
 /* An arch may set nr_cpu_ids earlier if needed, so this would be redundant */
 void __init setup_nr_cpu_ids(void)
 {
-	nr_cpu_ids = find_last_bit(cpumask_bits(cpu_possible_mask),NR_CPUS) + 1;
+	set_nr_cpu_ids(find_last_bit(cpumask_bits(cpu_possible_mask), NR_CPUS) + 1);
 }
 
 /* Called by boot processor to activate the rest. */
-- 
2.34.1

