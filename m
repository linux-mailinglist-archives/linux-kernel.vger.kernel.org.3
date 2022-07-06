Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42E85690EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiGFRnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbiGFRnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:43:04 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2E42A27B;
        Wed,  6 Jul 2022 10:43:02 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id n10so11572014qkn.10;
        Wed, 06 Jul 2022 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dALoUA4TxajQrqRALn6VbZI9jeqizcyFDqXo6cANVYg=;
        b=nyC2+Sd3jhh/LEdWlSwYv/Wi4xBn2p0D6oGj4gyhLtswzAziH455Bo9wgTrHjKchaV
         CgUOBfvEIp05FREyeEJMqK5TnX3mvRi6YSZnByT/LapbrtBBCTloUMHia4TbdAzGAGGH
         yY1KGijCX0HOQO/4Fwk0fjkWegstt6IE3XkXQbCLYVn+Fhs3HUBfRuSjlDJWq7bBd1FO
         MyD9Gvd/RAl4BUcDs/vKsJGcH5CMvMnBRnNZLsbxy5ZsmvDEmVUou6TFYWQuwlwqmDWf
         XQFta9TFMS1sbaW+k3Fb4Zoa0W/mQbOCznzdToKyxHsXU+B5RB7a6dgcM8Q8VepDZxAo
         6lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dALoUA4TxajQrqRALn6VbZI9jeqizcyFDqXo6cANVYg=;
        b=qBUHOetWn9doC5NI0W1B1p1G3N/pgMsfWpdVwI8GdkLH3Zql1E2xFr+hITrEjIeZ8V
         n6TogJSRbsIia8N9EBxuWBFabLqD91X6NR2TCbXwb9cF9SgE0NxrUuEvTwbP6fG7XCJ4
         zerzg4W3TYPr2+w+yCFNhygnDP2f5K1NrMO6tEx5z2RaiJlqnuuVVfwIxt60ixcNd+4N
         RQLQyyKdcnAtmG0fCOPhPYcgXb2J6ZgLdgiSiAfSY1/CdOx9SEKraZLY6emHsLUXx3bH
         kqfopoKMvleX/d9S9IhMun/tTq8qPZ1i5tdSN1HjIBjV3e2fmfN/rnHnWmOuGJDpTMxz
         +9bQ==
X-Gm-Message-State: AJIora+3nulDQgEq1iEZWa2GS92cQTYWSfGDiCxw2t83Rjc+MuaOtr0N
        FImzWCV8To/9dV45j1/97ynug/toN7S0ZQ==
X-Google-Smtp-Source: AGRyM1uJ3hnFVUVKR+5A0tRR91nKmtjdOKPHZTHRMDZPsx7tXoYTXb9HZejmviIagEKCPhwWCBzbHg==
X-Received: by 2002:a37:644b:0:b0:6af:3529:2bb8 with SMTP id y72-20020a37644b000000b006af35292bb8mr27450858qkb.341.1657129381738;
        Wed, 06 Jul 2022 10:43:01 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id v38-20020a05622a18a600b0031a84ecd4d1sm20818859qtc.95.2022.07.06.10.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:43:01 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
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
Subject: [PATCH 05/10] lib/cpumask: change return types to unsigned where appropriate
Date:   Wed,  6 Jul 2022 10:42:48 -0700
Message-Id: <20220706174253.4175492-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706174253.4175492-1-yury.norov@gmail.com>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
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

