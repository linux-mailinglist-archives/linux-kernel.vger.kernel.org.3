Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533E25691A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiGFSXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiGFSXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:23:07 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F087929C89
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:23:06 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id r138so11653237qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pai9znSdO+fwy4aj7J/mMLYj56s01kumpPyW+l50h6M=;
        b=ELJYXJ/V7ZHpOqKh9DKvzDBB//zFWkfsQlSz2x6A4lbIPATB+g8WQbNx21wAXqFptx
         +pWZOrA8a7c6NEIaKcfVgwqPvsmIsz+nch4BbsI3i2mdulvUYtfb0FqIuR5tdi0ZP1cc
         Ptb/bWg+KM/1EtR2x90ZTMhJy4yqG5k/y8X5FRDPtp6ed/nZtMBMgh/uCdoYjs1J9d6/
         CB3bXdmqoZHuDoN9h2PFrqFQTV4i9GbrNPEOcsEYuTTBi4aaDcmygaO0Z9Rc1ZB7fY1H
         z1ZTaEWxj2dWhaTkIM6n0lDpsmhKfvCH0nNI2o5xyhw+Lu+/A842bAqxCFl17OKwqJep
         n4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pai9znSdO+fwy4aj7J/mMLYj56s01kumpPyW+l50h6M=;
        b=BuXcrm/ak+rik62pTZT42hZ7LKUmsFxqW518QcAWpc1izRmap6VtNLkWOjBD74IaE0
         2RgLDrEBMMWwTF3Cw49fC4uYU/YCtT7+5CkVNTZU2z5+QQUmE1+b3tEsW12qMdDgENHF
         jeRHAoj0Dj/n78IFia/MlkIpax2NizuHkooQSMYFlQEtSLzoUAzlwlKxnf9vlCF4FAk5
         dnZdBK6ImfDhTR149OuadNwNgbu+eUfPicXhZv3CuoaCRCzgTYt2NEYopFsNgcYxuify
         8vFRhAledRWdMFwKFvu0Eq8HbvoYrfW5TzQlI2YTOSRd02v92YwaqFcqTMX+WmJXvut6
         N3bg==
X-Gm-Message-State: AJIora+mtTUHkUfW+jxSdFivHtrciOZDD0jSLqTpbzhJoqfl+ByiQKA3
        qmq1+RgankR2LLVAIrUvMXupIRnAENaZ1g==
X-Google-Smtp-Source: AGRyM1tOPXpgnvuNb3qc1kcKGwUSQiO9Xfku/hquZpKix0xs64NrKVUjMPXrJB7H1GnHP2AzMAXVHg==
X-Received: by 2002:a05:620a:8018:b0:6af:1fee:41ac with SMTP id ee24-20020a05620a801800b006af1fee41acmr27768228qkb.476.1657131785889;
        Wed, 06 Jul 2022 11:23:05 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id c190-20020ae9edc7000000b006a743b360bcsm28998990qkg.136.2022.07.06.11.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:23:05 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 4/5] cpumask: add cpumask_nth_{,and,andnot}
Date:   Wed,  6 Jul 2022 11:22:59 -0700
Message-Id: <20220706182300.70862-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706182300.70862-1-yury.norov@gmail.com>
References: <20220706182300.70862-1-yury.norov@gmail.com>
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

Add cpumask_nth_{,and,andnot} as wrappers around corresponding
find functions, and use it in cpumask_local_spread().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 44 +++++++++++++++++++++++++++++++++++++++++
 lib/cpumask.c           | 26 +++++++++++-------------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 0738a6c9be40..8cf460368fca 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -379,6 +379,50 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 }
 #endif /* SMP */
 
+/**
+ * cpumask_nth - get the first cpu in a cpumask
+ * @srcp: the cpumask pointer
+ * @cpu: the N'th cpu to find, starting from 1
+ *
+ * Returns >= nr_cpu_ids if such cpu doesn't exist.
+ */
+static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
+{
+	return find_nth_bit(cpumask_bits(srcp), nr_cpumask_bits, cpumask_check(cpu));
+}
+
+/**
+ * cpumask_nth_and - get the first cpu in 2 cpumasks
+ * @srcp1: the cpumask pointer
+ * @srcp2: the cpumask pointer
+ * @cpu: the N'th cpu to find, starting from 1
+ *
+ * Returns >= nr_cpu_ids if such cpu doesn't exist.
+ */
+static inline
+unsigned int cpumask_nth_and(unsigned int cpu, const struct cpumask *srcp1,
+							const struct cpumask *srcp2)
+{
+	return find_nth_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
+				nr_cpumask_bits, cpumask_check(cpu));
+}
+
+/**
+ * cpumask_nth_andnot - get the first cpu set in 1st cpumask, and clear in 2nd.
+ * @srcp1: the cpumask pointer
+ * @srcp2: the cpumask pointer
+ * @cpu: the N'th cpu to find, starting from 1
+ *
+ * Returns >= nr_cpu_ids if such cpu doesn't exist.
+ */
+static inline
+unsigned int cpumask_nth_andnot(unsigned int cpu, const struct cpumask *srcp1,
+							const struct cpumask *srcp2)
+{
+	return find_nth_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
+				nr_cpumask_bits, cpumask_check(cpu));
+}
+
 #define CPU_BITS_NONE						\
 {								\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-1] = 0UL			\
diff --git a/lib/cpumask.c b/lib/cpumask.c
index f0ae119be8c4..56aeb9c9d702 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -128,23 +128,19 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
 	i %= num_online_cpus();
 
 	if (node == NUMA_NO_NODE) {
-		for_each_cpu(cpu, cpu_online_mask)
-			if (i-- == 0)
-				return cpu;
+		cpu = cpumask_nth(i + 1, cpu_online_mask);
+		if (cpu < nr_cpu_ids)
+			return cpu;
 	} else {
 		/* NUMA first. */
-		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
-			if (i-- == 0)
-				return cpu;
-
-		for_each_cpu(cpu, cpu_online_mask) {
-			/* Skip NUMA nodes, done above. */
-			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
-				continue;
-
-			if (i-- == 0)
-				return cpu;
-		}
+		cpu = cpumask_nth_and(i + 1, cpu_online_mask, cpumask_of_node(node));
+		if (cpu < nr_cpu_ids)
+			return cpu;
+
+		/* Skip NUMA nodes, done above. */
+		cpu = cpumask_nth_andnot(i + 1, cpu_online_mask, cpumask_of_node(node));
+		if (cpu < nr_cpu_ids)
+			return cpu;
 	}
 	BUG();
 }
-- 
2.34.1

