Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250E9585547
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbiG2TDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbiG2TCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:02:54 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC9488E24;
        Fri, 29 Jul 2022 12:02:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9DB8F318B5E;
        Fri, 29 Jul 2022 15:02:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id y4PqTlgBnJHS; Fri, 29 Jul 2022 15:02:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C4461319089;
        Fri, 29 Jul 2022 15:02:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C4461319089
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121364;
        bh=wX+6cXKANeTzmsi6b1Rv2x8YVliOIgrKgheBkN7FLYs=;
        h=From:To:Date:Message-Id;
        b=kRucnBt9zeu06kROqMnvMcC1bVK0f06QFXBmnLTF4HaUNlwLqMqNHFr7p9CLVzN0j
         OelIf3hawqxn0HNh9pXY6Hn/a5wbG6FHZXD/mCqS8g1w9Zi62PhaR6C4N8RA+sAEV7
         p160MWsNY9sYuWUqu9XFSytU95Cq6oyPkktedVbElcqPcrXTBsvvZ8D+DLv2YlCWBZ
         IO9GeM8FixRvrXTM1Y3wJdkVP5Fon6PKTxB3dIf+hrlHSGf/PYDaZhiXrDT4Oj6TM2
         0INjMlcLUWM20IVNBV9CBHsuh7YfNtxrHLIDGHmJbKUrytQ3rLJzqVGGHHE0h9dv4P
         QDu6wJBLzQg0Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9IxLtaW2HgUY; Fri, 29 Jul 2022 15:02:44 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 2906C318A6B;
        Fri, 29 Jul 2022 15:02:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 08/23] cpumask: implement cpumask_{first,next}_{zero,one}_and_zero
Date:   Fri, 29 Jul 2022 15:02:10 -0400
Message-Id: <20220729190225.12726-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
References: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow finding the first or next bit within two input cpumasks which is
either:

- both zero and zero,
- respectively one and zero.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/cpumask.h | 86 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index fe29ac7cc469..0f5c3e47423f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -134,6 +134,18 @@ static inline unsigned int cpumask_first_and(const struct cpumask *srcp1,
 	return 0;
 }
 
+static inline unsigned int cpumask_first_one_and_zero(const struct cpumask *srcp1,
+					     const struct cpumask *srcp2)
+{
+	return 0;
+}
+
+static inline unsigned int cpumask_first_zero_and_zero(const struct cpumask *srcp1,
+					     const struct cpumask *srcp2)
+{
+	return 0;
+}
+
 static inline unsigned int cpumask_last(const struct cpumask *srcp)
 {
 	return 0;
@@ -157,6 +169,20 @@ static inline unsigned int cpumask_next_and(int n,
 	return n+1;
 }
 
+static inline unsigned int cpumask_next_one_and_zero(int n,
+					     const struct cpumask *srcp1,
+					     const struct cpumask *srcp2)
+{
+	return n+1;
+}
+
+static inline unsigned int cpumask_next_zero_and_zero(int n,
+					     const struct cpumask *srcp1,
+					     const struct cpumask *srcp2)
+{
+	return n+1;
+}
+
 static inline unsigned int cpumask_next_wrap(int n, const struct cpumask *mask,
 					     int start, bool wrap)
 {
@@ -230,6 +256,32 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
 	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
 }
 
+/**
+ * cpumask_first_one_and_zero - return the first cpu from *srcp1 & ~*srcp2
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_first_one_and_zero(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	return find_first_one_and_zero_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
+}
+
+/**
+ * cpumask_first_zero_and_zero - return the first cpu from ~*srcp1 & ~*srcp2
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_first_zero_and_zero(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	return find_first_zero_and_zero_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
+}
+
 /**
  * cpumask_last - get the last CPU in a cpumask
  * @srcp:	- the cpumask pointer
@@ -258,6 +310,40 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
 }
 
+/**
+ * cpumask_next_one_and_zero - return the next cpu from *srcp1 & ~*srcp2
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_next_one_and_zero(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_one_and_zero_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
+}
+
+/**
+ * cpumask_next_zero_and_zero - return the next cpu from ~*srcp1 & ~*srcp2
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_next_zero_and_zero(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_zero_and_zero_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
+}
+
 int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
 int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
-- 
2.17.1

