Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5444BC19E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbiBRVQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:16:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbiBRVQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:16:09 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D75923F0B8;
        Fri, 18 Feb 2022 13:15:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 540153BAC13;
        Fri, 18 Feb 2022 16:06:47 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 16lt4ka0EUcY; Fri, 18 Feb 2022 16:06:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 712053BAB16;
        Fri, 18 Feb 2022 16:06:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 712053BAB16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1645218405;
        bh=ONVniBRsB7JS6D+0uBffC8B0zXbx6+sORFJs6B80S7c=;
        h=From:To:Date:Message-Id;
        b=aQPfd7sWnh9LtxZOD2RPxPRmfb1YbWQurkDTElRbuFYspiJ0q8FkcB01cR9hCF8Kj
         i9PEDX9MCqrteNePWIJjuao335e3VUc7ApuYnxg33RcT1iqfydEtjaLUwh5oomWD3s
         ETjEgL/U2EKWEJWe66aYQIN0wtZ8RcXRqgobj8Kc5RsjErEGN4NWLcIz4FfwbY/shA
         MMC1PArRY5geDNJIncv3ncRn8JZw12cRUGNe9KGXZCvuGgv5apD5rqtgTR6BintHXX
         DX5o3xPLppbQxxUBgSg1z+sSQbt8jfgnngfuIqSBNrdVULa77P8FavuAVKSF5Y2fAd
         2uV4q6Vxa98tQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C7c68gXqvGRd; Fri, 18 Feb 2022 16:06:45 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 4AE423BA5F1;
        Fri, 18 Feb 2022 16:06:44 -0500 (EST)
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
Subject: [RFC PATCH v2 08/11] cpumask: implement cpumask_{first,next}_{zero,one}_and_zero
Date:   Fri, 18 Feb 2022 16:06:30 -0500
Message-Id: <20220218210633.23345-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
References: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 include/linux/cpumask.h | 94 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 64dae70d31f5..040476134557 100644
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
@@ -230,6 +256,36 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
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
+unsigned int cpumask_first_one_and_zero(const struct cpumask *srcp1,
+					const struct cpumask *srcp2)
+{
+	return find_first_one_and_zero_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
+					   nr_cpumask_bits);
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
+unsigned int cpumask_first_zero_and_zero(const struct cpumask *srcp1,
+					 const struct cpumask *srcp2)
+{
+	return find_first_zero_and_zero_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
+					    nr_cpumask_bits);
+}
+
 /**
  * cpumask_last - get the last CPU in a cpumask
  * @srcp:	- the cpumask pointer
@@ -258,6 +314,44 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
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
+unsigned int cpumask_next_one_and_zero(int n, const struct cpumask *srcp1,
+				       const struct cpumask *srcp2)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_one_and_zero_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
+					  nr_cpumask_bits, n+1);
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
+unsigned int cpumask_next_zero_and_zero(int n, const struct cpumask *srcp1,
+					const struct cpumask *srcp2)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_zero_and_zero_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
+					   nr_cpumask_bits, n+1);
+}
+
 int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
 int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
-- 
2.17.1

