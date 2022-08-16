Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010C1596200
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbiHPSIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiHPSHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:07:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE885F99
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660673261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vH2jTlmzQIwOMeKUkJzPFxzEVFleWwYuNxRt4X4XvAY=;
        b=cmMQF5MV4d1o0o7Kx/cto+FCxnjN5y5SzJR+UXTMchLIrzS9WKgRjIOdMsM9S7kzSGCkBS
        0cRRt8cmORFN451TVgb0FX1O/0aC6DhBdewwexfC1TAgSXgXq4aiAuRevTyAW5/HqlW0Jj
        OE+F+4axd2QB7ACrgikbFDNgOAXYrm8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-R3ghcE0UM4Obhp3W9NjidA-1; Tue, 16 Aug 2022 14:07:40 -0400
X-MC-Unique: R3ghcE0UM4Obhp3W9NjidA-1
Received: by mail-wm1-f70.google.com with SMTP id a17-20020a05600c349100b003a545125f6eso10552983wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vH2jTlmzQIwOMeKUkJzPFxzEVFleWwYuNxRt4X4XvAY=;
        b=ebnCaflHtaFr8lmC9EDT837dRnGScu0LpReSgvx85KBr23EDUbIfbYkoXino32crYf
         vHW1oBUW+x13bYaVswcAj47FT7WQ3hOUx26W3KEkU81AEum8tRNIBazOcu+/1m2j6oSU
         bTS9pbsYQ5ikeFnMDbPchOn6824+QfcmuAmz81UEMUCTcuTcLbpvAH/BnMvgxsC9SNUB
         4U+Oa0FM1PAPS4rN+duLStKv9vPRn+YU0ga4L1oeCdW9x1JkZPFxc/iLjpMNayLx75tS
         lIso1liZ4IWBpQMmQ55NmuUFRj3b0bw5s43L2gOhYJcESjwHRhRZjeJnFgMEf2SLS+/1
         JRgg==
X-Gm-Message-State: ACgBeo0u2othLhV/dTf4kSd83Z0M3zPG5pM7kV8SlWUodX9S8G81ys9e
        1W2e995R76nqvBzhZjLqqvke/7Ck3lLtnN9jk4HAw1kEl4kOaReq5/o5DAx5JgYc9P+wD8BXmX9
        niHWgSwYLESBJTSq/lFUHgik5
X-Received: by 2002:a05:600c:4fcf:b0:3a5:b7f7:3127 with SMTP id o15-20020a05600c4fcf00b003a5b7f73127mr14638611wmq.160.1660673259512;
        Tue, 16 Aug 2022 11:07:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Ozt5n5rw1n8vb1yr16M5RH2dEqwc/tjFIJhySTHC/leYqLbNjdSwNueyR8yo+3ivUTDnsZQ==
X-Received: by 2002:a05:600c:4fcf:b0:3a5:b7f7:3127 with SMTP id o15-20020a05600c4fcf00b003a5b7f73127mr14638594wmq.160.1660673259334;
        Tue, 16 Aug 2022 11:07:39 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b003a319bd3278sm14694961wmq.40.2022.08.16.11.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:07:38 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH 2/5] cpumask: Introduce for_each_cpu_andnot()
Date:   Tue, 16 Aug 2022 19:07:24 +0100
Message-Id: <20220816180727.387807-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220816180727.387807-1-vschneid@redhat.com>
References: <20220816180727.387807-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_cpu_and() is very convenient as it saves having to allocate a
temporary cpumask to store the result of cpumask_and(). The same issue
applies to cpumask_andnot() which doesn't actually need temporary storage
for iteration purposes.

Following what has been done for for_each_cpu_and(), introduce
for_each_cpu_andnot().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/cpumask.h | 32 ++++++++++++++++++++++++++++++++
 lib/cpumask.c           | 19 +++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index fe29ac7cc469..a8b2ca160e57 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -157,6 +157,13 @@ static inline unsigned int cpumask_next_and(int n,
 	return n+1;
 }
 
+static inline unsigned int cpumask_next_andnot(int n,
+					    const struct cpumask *srcp,
+					    const struct cpumask *andp)
+{
+	return n+1;
+}
+
 static inline unsigned int cpumask_next_wrap(int n, const struct cpumask *mask,
 					     int start, bool wrap)
 {
@@ -194,6 +201,8 @@ static inline int cpumask_any_distribute(const struct cpumask *srcp)
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
 #define for_each_cpu_and(cpu, mask1, mask2)	\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask1, (void)mask2)
+#define for_each_cpu_andnot(cpu, mask1, mask2)	\
+	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask1, (void)mask2)
 #else
 /**
  * cpumask_first - get the first cpu in a cpumask
@@ -259,6 +268,9 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 }
 
 int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
+int __pure cpumask_next_andnot(int n,
+			       const struct cpumask *src1p,
+			       const struct cpumask *src2p);
 int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
@@ -324,6 +336,26 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
 	for ((cpu) = -1;						\
 		(cpu) = cpumask_next_and((cpu), (mask1), (mask2)),	\
 		(cpu) < nr_cpu_ids;)
+
+/**
+ * for_each_cpu_andnot - iterate over every cpu in one mask but not in another
+ * @cpu: the (optionally unsigned) integer iterator
+ * @mask1: the first cpumask pointer
+ * @mask2: the second cpumask pointer
+ *
+ * This saves a temporary CPU mask in many places.  It is equivalent to:
+ *	struct cpumask tmp;
+ *	cpumask_andnot(&tmp, &mask1, &mask2);
+ *	for_each_cpu(cpu, &tmp)
+ *		...
+ *
+ * After the loop, cpu is >= nr_cpu_ids.
+ */
+#define for_each_cpu_andnot(cpu, mask1, mask2)				\
+	for ((cpu) = -1;						\
+		(cpu) = cpumask_next_andnot((cpu), (mask1), (mask2)),	\
+		(cpu) < nr_cpu_ids;)
+
 #endif /* SMP */
 
 #define CPU_BITS_NONE						\
diff --git a/lib/cpumask.c b/lib/cpumask.c
index a971a82d2f43..6896ff4a08fd 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -42,6 +42,25 @@ int cpumask_next_and(int n, const struct cpumask *src1p,
 }
 EXPORT_SYMBOL(cpumask_next_and);
 
+/**
+ * cpumask_next_andnot - get the next cpu in *src1p & ~*src2p
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first cpumask pointer
+ * @src2p: the second cpumask pointer
+ *
+ * Returns >= nr_cpu_ids if no further cpus set in *src1p & ~*src2p.
+ */
+int cpumask_next_andnot(int n, const struct cpumask *src1p,
+		     const struct cpumask *src2p)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_andnot_bit(cpumask_bits(src1p), cpumask_bits(src2p),
+		nr_cpumask_bits, n + 1);
+}
+EXPORT_SYMBOL(cpumask_next_andnot);
+
 /**
  * cpumask_any_but - return a "random" in a cpumask, but not this one.
  * @mask: the cpumask to search
-- 
2.31.1

