Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8405ADBB4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 01:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiIEXIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 19:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiIEXIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:08:38 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E038169F4C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 16:08:25 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id w4so3159613qvp.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WHXMwpMSBlWycN6d/vhs25RqbJ8DeUhQOZSip6Rd89Q=;
        b=UN3+8xu9H0+JeCy05eXfJIGoKXTGUl6QMvOPpJyfPBAkQuQrgIzn6kY1dVop8tSVIF
         ToHjyfc/q9bCilDsW8Bv7v5QTT64fG7jPnRboICcpTmd3fQTsBw4Z5nyF+Em12GUxXH9
         bDnNIWh772WfCN6z/gAkS0yINk0DyIBGbFevqdBDae9nX/4xVbffhAdezGpVVSikl2mc
         4veipSnCWXdYPsNEbDSgZtVG7EwCm+5Xk9QbVN4DAUGR3UtOb0mx29DwnJlOL6u2ZVx/
         QTd+qsNPhOF/+SI8zAbBiYQEFvARf9EiktESqTfSaKfouBFY1NnUBXEMe9G9alfSqwbo
         XINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WHXMwpMSBlWycN6d/vhs25RqbJ8DeUhQOZSip6Rd89Q=;
        b=cYbeIAPVTpAMxhuiuPPvWoSEBSwwHgYeGE40U3D8ZNIkGwZ1nl/hYBpUhJ9e9sZgGk
         3MMne4OjJcOn7Ibn7SAhPnHciTTfUTTTwrF9WA4+gvp9YYssVw33G7NFKdLJCNsi7Ne3
         bzQUiXaRHdq+dANhNI4Wk6wIqT6KpIeRqrnE3JAlzUL7NW4WnBbmzjP1gMi51Z2hOVyx
         FqQa7qnWacHX1OyaIY86a7pVscEAlGOdZyi2XBykRdAmVAlQCqsJXj8r1hKunOmaXSp9
         WNM/VUs6ya5FwTLgg/EkG7DnBkZsT81FWveRmghRi6mcF8SFIaXri7wabw7uJiIswnV1
         9OrQ==
X-Gm-Message-State: ACgBeo3wy/cOIwmEejxFFcjJSLORY8UwVqtMOUMVhZvRrYLZnQcoOlU6
        LOlBHw/oT+TgI+JJtO+Hh4mNJ5dDT0I=
X-Google-Smtp-Source: AA6agR4R5334toZfMm5VhkdPkNnIK+OTRsIlblI87A0MwX0R0LWen3GYa5a4aoBGFsqF75HbYkS3Aw==
X-Received: by 2002:a05:6214:242a:b0:4aa:9c94:5d9a with SMTP id gy10-20020a056214242a00b004aa9c945d9amr1761590qvb.64.1662419304878;
        Mon, 05 Sep 2022 16:08:24 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:dde1:6b3e:62e9:1461])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a166300b006b5c061844fsm8916160qko.49.2022.09.05.16.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 16:08:24 -0700 (PDT)
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
Subject: [PATCH v2 2/5] smp: add set_nr_cpu_ids()
Date:   Mon,  5 Sep 2022 16:08:17 -0700
Message-Id: <20220905230820.3295223-3-yury.norov@gmail.com>
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

In preparation to support compile-time nr_cpu_ids, add a setter for
the variable.

This is a no-op for all arches.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/loongarch/kernel/setup.c | 2 +-
 arch/mips/kernel/setup.c      | 2 +-
 arch/x86/kernel/smpboot.c     | 4 ++--
 arch/x86/xen/smp_pv.c         | 2 +-
 include/linux/cpumask.h       | 5 +++++
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
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bd047864c7ac..0588bfe350d4 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -39,6 +39,11 @@ typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
 #define nr_cpu_ids		1U
 #else
 extern unsigned int nr_cpu_ids;
+
+static inline void set_nr_cpu_ids(unsigned int nr)
+{
+	nr_cpu_ids = nr;
+}
 #endif
 
 #ifdef CONFIG_CPUMASK_OFFSTACK
diff --git a/kernel/smp.c b/kernel/smp.c
index e971c9626a1b..150310a0947a 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1070,7 +1070,7 @@ static int __init nrcpus(char *str)
 	int nr_cpus;
 
 	if (get_option(&str, &nr_cpus) && nr_cpus > 0 && nr_cpus < nr_cpu_ids)
-		nr_cpu_ids = nr_cpus;
+		set_nr_cpu_ids(nr_cpus);
 
 	return 0;
 }
@@ -1097,7 +1097,7 @@ EXPORT_SYMBOL(nr_cpu_ids);
 /* An arch may set nr_cpu_ids earlier if needed, so this would be redundant */
 void __init setup_nr_cpu_ids(void)
 {
-	nr_cpu_ids = find_last_bit(cpumask_bits(cpu_possible_mask),NR_CPUS) + 1;
+	set_nr_cpu_ids(find_last_bit(cpumask_bits(cpu_possible_mask), NR_CPUS) + 1);
 }
 
 /* Called by boot processor to activate the rest. */
-- 
2.34.1

