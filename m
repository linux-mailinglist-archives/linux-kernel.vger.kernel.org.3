Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8B5633CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiGAMy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiGAMyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:54:41 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B833A720;
        Fri,  1 Jul 2022 05:54:40 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id n10so1719714qkn.10;
        Fri, 01 Jul 2022 05:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dALoUA4TxajQrqRALn6VbZI9jeqizcyFDqXo6cANVYg=;
        b=fLsxEHYqlZGYXvAnn65jdSw7P2u6uw3w6pwoF8d4eIU+BYP/+k+0yfKYWdeL9ocAVK
         T42XW4e174CunC/AhJUMA0kZMfvpVuU2qFbWFpGT8siUOx4oyaxTCefTmHXmCAq8wUUS
         nqZhALiNdWIX6AXvXrhkr1PDcQ6RS6rRmX9GKtVp5GNBJCPRoeYwbhqtl1IxhCsCb7FW
         0Ohn/XpktZ0TaKIdsYX38JyoIuM5ibGA8267lVtHDhHZc+yN7cWyfZK2D2+PW0CkL+NW
         W9tyGeaPtGBs9doohBhPzmjFE/rjLvqftcA9dnlDovwVXSMOEmPt0ghXus+nW+tjpcl8
         JCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dALoUA4TxajQrqRALn6VbZI9jeqizcyFDqXo6cANVYg=;
        b=GkLCkXF2qVzItBhYLnHcxe55e1MFxiPkAlLxCVX5GUT37Xw2c9yfLFaqUckIPjNfqh
         BLKK9UjfwqFJ/JkF2G5LpxzYKo67fba+mhSzmGITzN5SaJSWgIRl0BY6GrjLQhQScqsQ
         XIaL9lf3oKZhDjI27iDbKcInGyMUtQWhlTUWlHlhADdwEmXpRDzoFSAtjyYDmhrwux49
         hrZT4h5PIx/ZNopv7MEiS9UnAuOLGlYZmEX/QVjOuKUD6sE+2ZKInD05K6ggoGZnPorz
         tce9RQd+QMs41BCiBFTQZ8mf8sN9dPGjo15gsZoDdE8VGfz1jVz4PV2As+xQuA9WT4bS
         dPgg==
X-Gm-Message-State: AJIora9K20A2Belh7ZzK2nOlmox4iCFGrcKlKDkY874MMQ0h7R2n4/pa
        mVED8p80b8RE4FetTKPS642D2XXbmWs=
X-Google-Smtp-Source: AGRyM1umJBMsQT8dcVWHPG2fYnWNUoEty93L5a2a9n7i9NhpB8s8LMJLTYWhNi8UYMZ7/bD5TFG5vg==
X-Received: by 2002:a05:620a:1e3:b0:6af:504d:c1f2 with SMTP id x3-20020a05620a01e300b006af504dc1f2mr10470131qkn.34.1656680079339;
        Fri, 01 Jul 2022 05:54:39 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:f902:9816:653f:2f66])
        by smtp.gmail.com with ESMTPSA id he18-20020a05622a601200b00317c38c8606sm8999322qtb.20.2022.07.01.05.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:54:39 -0700 (PDT)
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
Subject: [PATCH 5/8] lib/cpumask: change return types to unsigned where appropriate
Date:   Fri,  1 Jul 2022 05:54:27 -0700
Message-Id: <20220701125430.2907638-6-yury.norov@gmail.com>
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

Switch return types to unsigned int where return values cannot be negative.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 14 +++++++-------
 lib/cpumask.c           | 18 +++++++++---------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index b54e27d9da6b..760022bcb925 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -176,12 +176,12 @@ static inline unsigned int cpumask_local_spread(unsigned int i, int node)
 	return 0;
 }
 
-static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
+static inline unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
 					     const struct cpumask *src2p) {
 	return cpumask_first_and(src1p, src2p);
 }
 
-static inline int cpumask_any_distribute(const struct cpumask *srcp)
+static inline unsigned int cpumask_any_distribute(const struct cpumask *srcp)
 {
 	return cpumask_first(srcp);
 }
@@ -258,12 +258,12 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
 }
 
-int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
-int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
+unsigned int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
+unsigned int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
-int cpumask_any_and_distribute(const struct cpumask *src1p,
+unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
-int cpumask_any_distribute(const struct cpumask *srcp);
+unsigned int cpumask_any_distribute(const struct cpumask *srcp);
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
@@ -289,7 +289,7 @@ int cpumask_any_distribute(const struct cpumask *srcp);
 		(cpu) = cpumask_next_zero((cpu), (mask)),	\
 		(cpu) < nr_cpu_ids;)
 
-extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
+unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
 
 /**
  * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a specified location
diff --git a/lib/cpumask.c b/lib/cpumask.c
index a971a82d2f43..da68f6bbde44 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -31,7 +31,7 @@ EXPORT_SYMBOL(cpumask_next);
  *
  * Returns >= nr_cpu_ids if no further cpus set in both.
  */
-int cpumask_next_and(int n, const struct cpumask *src1p,
+unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 		     const struct cpumask *src2p)
 {
 	/* -1 is a legal arg here. */
@@ -50,7 +50,7 @@ EXPORT_SYMBOL(cpumask_next_and);
  * Often used to find any cpu but smp_processor_id() in a mask.
  * Returns >= nr_cpu_ids if no cpus set.
  */
-int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
+unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 {
 	unsigned int i;
 
@@ -74,9 +74,9 @@ EXPORT_SYMBOL(cpumask_any_but);
  * Note: the @wrap argument is required for the start condition when
  * we cannot assume @start is set in @mask.
  */
-int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
+unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
 {
-	int next;
+	unsigned int next;
 
 again:
 	next = cpumask_next(n, mask);
@@ -205,7 +205,7 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
  */
 unsigned int cpumask_local_spread(unsigned int i, int node)
 {
-	int cpu;
+	unsigned int cpu;
 
 	/* Wrap: we always want a cpu. */
 	i %= num_online_cpus();
@@ -243,10 +243,10 @@ static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
  *
  * Returns >= nr_cpu_ids if the intersection is empty.
  */
-int cpumask_any_and_distribute(const struct cpumask *src1p,
+unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p)
 {
-	int next, prev;
+	unsigned int next, prev;
 
 	/* NOTE: our first selection will skip 0. */
 	prev = __this_cpu_read(distribute_cpu_mask_prev);
@@ -262,9 +262,9 @@ int cpumask_any_and_distribute(const struct cpumask *src1p,
 }
 EXPORT_SYMBOL(cpumask_any_and_distribute);
 
-int cpumask_any_distribute(const struct cpumask *srcp)
+unsigned int cpumask_any_distribute(const struct cpumask *srcp)
 {
-	int next, prev;
+	unsigned int next, prev;
 
 	/* NOTE: our first selection will skip 0. */
 	prev = __this_cpu_read(distribute_cpu_mask_prev);
-- 
2.34.1

