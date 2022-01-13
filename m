Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02D48DB21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiAMPyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:54:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40754 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234645AbiAMPyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:54:01 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 898461EC05BF;
        Thu, 13 Jan 2022 16:53:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642089239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3WxvIM+chylBioAStDvt0vYgg3pt0TRyWRuNCOlV2U=;
        b=prjZDSlkHxF2qI5mfp/VW603jkDVJhY78j/UQOgpc8FpywBZ7D7j6mU12HlOPU4YNbqNWn
        ugpJ33X4nWaQSYvOgqEeRxONG5P615PkZP2Ank9txbQg+AMHdIyo6lyN+v9t+yhOR5DO2m
        plh6IZ+sEAWzc+02rI7L6JoWvW1GNCg=
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] cpumask: Always inline helpers which use bit manipulation functions
Date:   Thu, 13 Jan 2022 16:53:57 +0100
Message-Id: <20220113155357.4706-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220113155357.4706-1-bp@alien8.de>
References: <20220113155357.4706-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Former are always inlined so do that for the latter too, for
consistency.

Size impact is a whopping 5 bytes increase! :-)

   text    data     bss     dec     hex filename
22350551        8213184 1917164 32480899        1ef9e83 vmlinux.x86-64.defconfig.before
22350556        8213152 1917164 32480872        1ef9e68 vmlinux.x86-64.defconfig.after

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 include/linux/cpumask.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1e7399fc69c0..676ada1fbccd 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -306,12 +306,12 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
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
@@ -322,12 +322,12 @@ static inline void __cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
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
@@ -339,7 +339,7 @@ static inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
  *
  * Returns 1 if @cpu is set in @cpumask, else returns 0
  */
-static inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
+static __always_inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
 {
 	return test_bit(cpumask_check(cpu), cpumask_bits((cpumask)));
 }
@@ -353,7 +353,7 @@ static inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
  *
  * test_and_set_bit wrapper for cpumasks.
  */
-static inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
+static __always_inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_set_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
@@ -367,7 +367,7 @@ static inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
  *
  * test_and_clear_bit wrapper for cpumasks.
  */
-static inline int cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
+static __always_inline int cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_clear_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
-- 
2.29.2

