Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB2E5633CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiGAMzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbiGAMyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:54:41 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1C63AA6E;
        Fri,  1 Jul 2022 05:54:40 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g14so317196qto.9;
        Fri, 01 Jul 2022 05:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmLdladheqxAWwfcqAo0zECfXUO+llLx3LkvFH+700E=;
        b=Yk+/uLtYXUwgn0wFnU+xBwbbd3TV73jozv6kkTCTPvnSU9wbfdn60UbySuTSzEnlro
         OFkfibFSzHxte2aNxRaTB4TAFPYFvgl2SO8cegFcl0yTUgA4NOjqmhZQDwqkpglxQE4E
         EDkQELLxqbSTr1l3tptyPi1u1KXl3+n4nt5EvNzr7Fel2D1S6yqNVMbhuQ5VI5f0fwyQ
         yDK/6Rzu9EAz4D/X8McX3fiBEh6f6NfyPWW97wLZssbppvSs9DIilPK4/adUVClpALkj
         7KF0kU2JesgZU0jpoSRIxaGW5Ygz8MSH42mPif+ahyF2X8YO9PAyEJz82S9F9t0ziyVA
         1mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmLdladheqxAWwfcqAo0zECfXUO+llLx3LkvFH+700E=;
        b=TtqkHVykuJ0HKm//3oOVtJQel97SXBi9B6NEXhvtWYYMbcSh9V38loGLc41exqeJ63
         IgSBRg/tlJYAGocAKiUkNjtWtxmMDiwRQHqhqEbtUj6tJiAbqDtPnhVDkDMF9vlJX4XT
         /utKqYv5sZFf2rn3szVanoBbbCuyxLCtFctKm0TZWYzVh+HRCk1S065/TXK1iQSfVrE5
         LFLWx3gnZarbFXwzusvnJDuXoxsygMd0Z4vJi9qZVMkkW4UOmBxSY15fpf4OJqN6jWOk
         bxrOqnxtc4HZoUdNDQNRHO50qoHf0vGs2NVxfUMypoMZhpvYDEYyY018ErHXXkD22ZWL
         j7ZA==
X-Gm-Message-State: AJIora9TuvtPM7LHdhabzMl/RKo/04tE6OiV/KdoopZMrI4Z5HIKuhwA
        8XcFMB/KLs0thfeuP0TfFF2YWsHN9k4=
X-Google-Smtp-Source: AGRyM1vO/ADr3cD/se1PN5gtMxssiVvttv4kkUOmlPTTOpQ+ZzknMS4C2otZaWPxwqIx7qTrO6XQgA==
X-Received: by 2002:ac8:5b88:0:b0:305:340b:6f14 with SMTP id a8-20020ac85b88000000b00305340b6f14mr12235034qta.344.1656680080278;
        Fri, 01 Jul 2022 05:54:40 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:f902:9816:653f:2f66])
        by smtp.gmail.com with ESMTPSA id v2-20020a05622a130200b00304e47b9602sm15875188qtk.9.2022.07.01.05.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:54:40 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 6/8] lib/cpumask: move trivial wrappers around find_bit to the header
Date:   Fri,  1 Jul 2022 05:54:28 -0700
Message-Id: <20220701125430.2907638-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701125430.2907638-1-yury.norov@gmail.com>
References: <20220701125430.2907638-1-yury.norov@gmail.com>
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

To avoid circular dependencies, cpumask keeps simple (almost) one-line
wrappers around find_bit() in a c-file.

Commit 47d8c15615c0a2 ("include: move find.h from asm_generic to linux")
moved find.h header out of asm_generic include path, and it helped to fix
many circular dependencies, including some in cpumask.h.

This patch moves those one-liners to header files.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 57 ++++++++++++++++++++++++++++++++++++++---
 lib/cpumask.c           | 55 ---------------------------------------
 2 files changed, 54 insertions(+), 58 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 760022bcb925..ea3de2c2c180 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -241,7 +241,21 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
 	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
-unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);
+/**
+ * cpumask_next - get the next cpu in a cpumask
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @srcp: the cpumask pointer
+ *
+ * Returns >= nr_cpu_ids if no further cpus set.
+ */
+static inline
+unsigned int cpumask_next(int n, const struct cpumask *srcp)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_bit(cpumask_bits(srcp), nr_cpumask_bits, n + 1);
+}
 
 /**
  * cpumask_next_zero - get the next unset cpu in a cpumask
@@ -258,8 +272,25 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
 }
 
-unsigned int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
-unsigned int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
+/**
+ * cpumask_next_and - get the next cpu in *src1p & *src2p
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first cpumask pointer
+ * @src2p: the second cpumask pointer
+ *
+ * Returns >= nr_cpu_ids if no further cpus set in both.
+ */
+static inline
+unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
+		     const struct cpumask *src2p)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_and_bit(cpumask_bits(src1p), cpumask_bits(src2p),
+		nr_cpumask_bits, n + 1);
+}
+
 unsigned int cpumask_local_spread(unsigned int i, int node);
 unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
@@ -324,6 +355,26 @@ unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, boo
 	for ((cpu) = -1;						\
 		(cpu) = cpumask_next_and((cpu), (mask1), (mask2)),	\
 		(cpu) < nr_cpu_ids;)
+
+/**
+ * cpumask_any_but - return a "random" in a cpumask, but not this one.
+ * @mask: the cpumask to search
+ * @cpu: the cpu to ignore.
+ *
+ * Often used to find any cpu but smp_processor_id() in a mask.
+ * Returns >= nr_cpu_ids if no cpus set.
+ */
+static inline
+unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
+{
+	unsigned int i;
+
+	cpumask_check(cpu);
+	for_each_cpu(i, mask)
+		if (i != cpu)
+			break;
+	return i;
+}
 #endif /* SMP */
 
 #define CPU_BITS_NONE						\
diff --git a/lib/cpumask.c b/lib/cpumask.c
index da68f6bbde44..cb7262ff8633 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -7,61 +7,6 @@
 #include <linux/memblock.h>
 #include <linux/numa.h>
 
-/**
- * cpumask_next - get the next cpu in a cpumask
- * @n: the cpu prior to the place to search (ie. return will be > @n)
- * @srcp: the cpumask pointer
- *
- * Returns >= nr_cpu_ids if no further cpus set.
- */
-unsigned int cpumask_next(int n, const struct cpumask *srcp)
-{
-	/* -1 is a legal arg here. */
-	if (n != -1)
-		cpumask_check(n);
-	return find_next_bit(cpumask_bits(srcp), nr_cpumask_bits, n + 1);
-}
-EXPORT_SYMBOL(cpumask_next);
-
-/**
- * cpumask_next_and - get the next cpu in *src1p & *src2p
- * @n: the cpu prior to the place to search (ie. return will be > @n)
- * @src1p: the first cpumask pointer
- * @src2p: the second cpumask pointer
- *
- * Returns >= nr_cpu_ids if no further cpus set in both.
- */
-unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
-		     const struct cpumask *src2p)
-{
-	/* -1 is a legal arg here. */
-	if (n != -1)
-		cpumask_check(n);
-	return find_next_and_bit(cpumask_bits(src1p), cpumask_bits(src2p),
-		nr_cpumask_bits, n + 1);
-}
-EXPORT_SYMBOL(cpumask_next_and);
-
-/**
- * cpumask_any_but - return a "random" in a cpumask, but not this one.
- * @mask: the cpumask to search
- * @cpu: the cpu to ignore.
- *
- * Often used to find any cpu but smp_processor_id() in a mask.
- * Returns >= nr_cpu_ids if no cpus set.
- */
-unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
-{
-	unsigned int i;
-
-	cpumask_check(cpu);
-	for_each_cpu(i, mask)
-		if (i != cpu)
-			break;
-	return i;
-}
-EXPORT_SYMBOL(cpumask_any_but);
-
 /**
  * cpumask_next_wrap - helper to implement for_each_cpu_wrap
  * @n: the cpu prior to the place to search
-- 
2.34.1

