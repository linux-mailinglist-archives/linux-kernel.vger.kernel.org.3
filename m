Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D8759B788
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiHVCQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiHVCQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:16:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5B722BD9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:16:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x19so6244337pfq.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=a1gA9IAalPkJ/r41Sbu0lXlyv4sE6FWwFkcXTLlSUhQ=;
        b=f1Rj4AszKhqTPEhdKzS4a7bGXzhl4OYAwmwBWFAzl1fstspH3uQgHSN3GkYGHFJyI4
         eplR605POer+GLNLpquluEFzZK3qJekzAI4t/LFPL1g5jk+IDfuJFdN1AoEKZEOQcZ8i
         CUmbpoB/lWov7uW7y/3M54xBU5z5viFwBbJXcN7fIePWUXlkJaJAz+Elp0hqFJq5hp8w
         AHFq4TwrICRurHqhldjCSmPd7RtXt8EHYfs9MjYOjs5IpLmj2S76x6Lscenv1VkNE5Rb
         NBqYq+ANAa+5G6zUh2d6O99ZQSg8F09O0dd27mwJE7fKbLHHjjbuz4CNqbnXKP4eHrWI
         J6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=a1gA9IAalPkJ/r41Sbu0lXlyv4sE6FWwFkcXTLlSUhQ=;
        b=jiwVSAktM9zay2260nHU8nPXsBWtoTBoZYs7LVdkI8JdH4fpZOvl8FHcPuipVwvxdF
         kqq9FVFp39i00K/NW/MB0yWBv69dEPQZGUNDup/TxkUysBGmBKST/k4qKAYdxTC1caq8
         BUzOCDXmMyyV1e9hsIQscEqx243TgXv/B/BoqBvHUzGTCxQXiCRqgjkSUBDkPk0u7Ors
         FQdpnv+rGR7nFHFTulydZgdaZeVINDIqKt9Un+QUP5Yf45Ago592zjofTkLNOvOxDuM7
         J1td9S5wTqDbR4yX8/GqJ9iISGu4DqC9+v2j7Z8azNvjUbSpe88XgrsjxSCogMndI+Wn
         cLrg==
X-Gm-Message-State: ACgBeo2S1MQ+jo/3L2H29rz3Qcxt4yEvCkf5NvGREz1y2eOFF43mzDG6
        UuEcRFqD+YxS3NW8S5ErnO+9+volUg==
X-Google-Smtp-Source: AA6agR7ZwA26k/5afRUdoN/q/wA2eMJhK0L8eSeeuTTyKuF0SCN0KPGRNvuKCEpeW87yk+qbLb9bfQ==
X-Received: by 2002:a63:147:0:b0:42a:5157:c083 with SMTP id 68-20020a630147000000b0042a5157c083mr9835298pgb.269.1661134581473;
        Sun, 21 Aug 2022 19:16:21 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79723000000b005321340753fsm7312139pfg.103.2022.08.21.19.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:16:20 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC 07/10] lib/cpumask: Introduce cpumask_not_dying_but()
Date:   Mon, 22 Aug 2022 10:15:17 +0800
Message-Id: <20220822021520.6996-8-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220822021520.6996-1-kernelfans@gmail.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
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

During cpu hot-removing, the dying cpus are still in cpu_online_mask.
On the other hand, A subsystem will migrate its broker from the dying
cpu to a online cpu in its teardown cpuhp_step.

After enabling the teardown of cpus in parallel, cpu_online_mask can not
tell those dying from the real online.

Introducing a function cpumask_not_dying_but() to pick a real online
cpu.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Price <steven.price@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: linux-kernel@vger.kernel.org
---
 include/linux/cpumask.h |  3 +++
 kernel/cpu.c            |  3 +++
 lib/cpumask.c           | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 0d435d0edbcb..d2033a239a07 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -317,6 +317,9 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 	return i;
 }
 
+/* for parallel kexec reboot */
+int cpumask_not_dying_but(const struct cpumask *mask, unsigned int cpu);
+
 #define CPU_BITS_NONE						\
 {								\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-1] = 0UL			\
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 90debbe28e85..771e344f8ff9 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1282,6 +1282,9 @@ static void cpus_down_no_rollback(struct cpumask *cpus)
 	struct cpuhp_cpu_state *st;
 	unsigned int cpu;
 
+	for_each_cpu(cpu, cpus)
+		set_cpu_dying(cpu, true);
+
 	/* launch ap work one by one, but not wait for completion */
 	for_each_cpu(cpu, cpus) {
 		st = per_cpu_ptr(&cpuhp_state, cpu);
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 8baeb37e23d3..6474f07ed87a 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -7,6 +7,24 @@
 #include <linux/memblock.h>
 #include <linux/numa.h>
 
+/* Used in parallel kexec-reboot cpuhp callbacks */
+int cpumask_not_dying_but(const struct cpumask *mask,
+					   unsigned int cpu)
+{
+	unsigned int i;
+
+	if (CONFIG_SHUTDOWN_NONBOOT_CPUS) {
+		cpumask_check(cpu);
+		for_each_cpu(i, mask)
+			if (i != cpu && !cpumask_test_cpu(i, cpu_dying_mask))
+				break;
+		return i;
+	} else {
+		return cpumask_any_but(mask, cpu);
+	}
+}
+EXPORT_SYMBOL(cpumask_not_dying_but);
+
 /**
  * cpumask_next_wrap - helper to implement for_each_cpu_wrap
  * @n: the cpu prior to the place to search
-- 
2.31.1

