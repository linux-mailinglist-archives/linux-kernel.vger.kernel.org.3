Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8967956D409
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiGKErk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiGKErU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:47:20 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C24660CF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:47:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f12so3014886qka.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/+c9EiF9/emkxKF8PsBaxLM8SipI/6o4W1rL+EK1gU=;
        b=iVll2f8cJnDQrGa2Adcc428xEcVhjWAHcHz4MptpjtUXN7lnsvBHVwYUVrBL+lVxLp
         ioI+6DQiSLkhH7bxizmPtsxWX7bvNq831jjdTTXwQIVp3Gu0DUlB9T2vROndZgAKoXL5
         KWbHUK7jZwULl4dCf4FKU73XgOCwp+O+R3oyUtqlR3/gDoJHO7dO1Ltrt9xNNnsdkEBB
         fSc1GvTvvOMUsm8GbZQoYn84G5kFElABalMDwTMQ7fbodhc0Fw0FvKM33tZPXslgciQh
         6ImKhDSs51frYo79Nhj+NWrFBTTnRkKMRfSRxnjPI6Zshs/KYkUXPMKbUBwubKSejp6G
         bxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/+c9EiF9/emkxKF8PsBaxLM8SipI/6o4W1rL+EK1gU=;
        b=GMzV5YGdZiFV/f6gIhPfymvhBeaIbuM6NCyBxUNSN7PXqZpcEs+cAgZUu8wN42ScOl
         /ZK7WlsTUv5X/r+4QzGGiPrtNUtRr6VMM4BZsFe09Gti9lddanoBhzX43//HUxTivPwt
         YAVm5ZEs0mVbdVEiCYpeuFc4OR/fF4TVUfK3HIdkS28IxsgmsWxaGvKp6o47qyKIz1KS
         8UHAJiz59uHQ53VPPvXCiMM5UuTvzWgd5S+oeZ8Rk1hUet8GRuIvi5TDbVe1Qx38TXZ0
         lLI/m1sYax5DAbTl8DOS7/JSvIIzvjQG5oQBftPe4l43LeFMxQifu6S0V3Vi7JEB97M9
         T//w==
X-Gm-Message-State: AJIora+JJf71jEcwgpiAXPrR3y2H6WVdI7mr0fiq0UhEmw9aryZRqt2y
        UKEPbY9y9BEOChluyquHmu+JmbtlFhV9MA==
X-Google-Smtp-Source: AGRyM1vy5C+3k70AnLvG6MY8AfNBJisfqJNqFquWqUWry5GwuGQPhe1VcOtAB3dWWWo5lY1U5QWQ5g==
X-Received: by 2002:a05:620a:8018:b0:6af:1fee:41ac with SMTP id ee24-20020a05620a801800b006af1fee41acmr10105424qkb.476.1657514838130;
        Sun, 10 Jul 2022 21:47:18 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:a22e:180:f963:1eff])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006b555509398sm5455586qkn.136.2022.07.10.21.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 21:47:17 -0700 (PDT)
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
Date:   Sun, 10 Jul 2022 21:47:10 -0700
Message-Id: <20220711044711.466822-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711044711.466822-1-yury.norov@gmail.com>
References: <20220711044711.466822-1-yury.norov@gmail.com>
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
index 80627362c774..86c7e6c6e473 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -379,6 +379,50 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 }
 #endif /* SMP */
 
+/**
+ * cpumask_nth - get the first cpu in a cpumask
+ * @srcp: the cpumask pointer
+ * @cpu: the N'th cpu to find, starting from 0
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
+ * @cpu: the N'th cpu to find, starting from 0
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
+ * @cpu: the N'th cpu to find, starting from 0
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
index f0ae119be8c4..062821dbf65f 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -128,23 +128,19 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
 	i %= num_online_cpus();
 
 	if (node == NUMA_NO_NODE) {
-		for_each_cpu(cpu, cpu_online_mask)
-			if (i-- == 0)
-				return cpu;
+		cpu = cpumask_nth(i, cpu_online_mask);
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
+		cpu = cpumask_nth_and(i, cpu_online_mask, cpumask_of_node(node));
+		if (cpu < nr_cpu_ids)
+			return cpu;
+
+		/* Skip NUMA nodes, done above. */
+		cpu = cpumask_nth_andnot(i, cpu_online_mask, cpumask_of_node(node));
+		if (cpu < nr_cpu_ids)
+			return cpu;
 	}
 	BUG();
 }
-- 
2.34.1

