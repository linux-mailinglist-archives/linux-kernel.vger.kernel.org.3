Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA7F49CAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbiAZNah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbiAZNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:30:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A36C06173B;
        Wed, 26 Jan 2022 05:30:30 -0800 (PST)
Date:   Wed, 26 Jan 2022 13:30:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643203828;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szHkPXjHnhgkdFcM9yC3gEge6ubgcyYjma/Ws+m7Kt4=;
        b=pbK5j5ZAeh4XG0Oaw6z3tgzmEMxD+r4PIt5SLYj/e4Q9Ez48+dg8hFX2ArCkdb6q3eH8vg
        Bupd5/Y2F8+KiMbFjkK8+SxALw/K5JJG365GeQh2EqsBPcmrjT6vGVixjFP++3sivb6tPz
        0MrShsyKWK275yPhxj+vwBhTFpW3H9kW++vn92A14yKJN6uuJuLIXrr1U1fJ0AxqO0KPnh
        8I9mAWWHw7dOo67BqoLllICW5CfdyjXz1N4qX46SLsU0o0+YmJNpdIVQXj4HVSuntWICih
        I7nAqp4WIePrKFi3Mq9bNjzePHDn7NZkzquMQXWxYa8xAiL0yLijl+0cwNxySQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643203828;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szHkPXjHnhgkdFcM9yC3gEge6ubgcyYjma/Ws+m7Kt4=;
        b=sFCxN5Z11KSHYb1upl0vTNmoVAdg0OKn2cfm9skwy6YycLpnxSUhfww4P33+Oc5uIecMH8
        jjGifv+vr4OOwmDA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cpumask: Always inline helpers which use bit
 manipulation functions
Cc:     Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220113155357.4706-3-bp@alien8.de>
References: <20220113155357.4706-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164320382704.16921.650711607573571350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1dc01abad6544cb9d884071b626b706e37aa9601
Gitweb:        https://git.kernel.org/tip/1dc01abad6544cb9d884071b626b706e37aa9601
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 13 Jan 2022 16:53:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 25 Jan 2022 22:30:28 +01:00

cpumask: Always inline helpers which use bit manipulation functions

Former are always inlined so do that for the latter too, for
consistency.

Size impact is a whopping 5 bytes increase! :-)

   text    data     bss     dec     hex filename
22350551        8213184 1917164 32480899        1ef9e83 vmlinux.x86-64.defconfig.before
22350556        8213152 1917164 32480872        1ef9e68 vmlinux.x86-64.defconfig.after

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20220113155357.4706-3-bp@alien8.de
---
 include/linux/cpumask.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 64dae70..6b06c69 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -341,12 +341,12 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool 
  * @cpu: cpu number (< nr_cpu_ids)
  * @dstp: the cpumask pointer
  */
-static inline void cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
+static __always_inline void cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
 {
 	set_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
 
-static inline void __cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
+static __always_inline void __cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
 {
 	__set_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
@@ -357,12 +357,12 @@ static inline void __cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
  * @cpu: cpu number (< nr_cpu_ids)
  * @dstp: the cpumask pointer
  */
-static inline void cpumask_clear_cpu(int cpu, struct cpumask *dstp)
+static __always_inline void cpumask_clear_cpu(int cpu, struct cpumask *dstp)
 {
 	clear_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
 
-static inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
+static __always_inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
 {
 	__clear_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
@@ -374,7 +374,7 @@ static inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
  *
  * Returns 1 if @cpu is set in @cpumask, else returns 0
  */
-static inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
+static __always_inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
 {
 	return test_bit(cpumask_check(cpu), cpumask_bits((cpumask)));
 }
@@ -388,7 +388,7 @@ static inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
  *
  * test_and_set_bit wrapper for cpumasks.
  */
-static inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
+static __always_inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_set_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
@@ -402,7 +402,7 @@ static inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
  *
  * test_and_clear_bit wrapper for cpumasks.
  */
-static inline int cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
+static __always_inline int cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_clear_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
