Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D165633C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbiGAMyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbiGAMyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:54:40 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EA13AA6E;
        Fri,  1 Jul 2022 05:54:39 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g14so317143qto.9;
        Fri, 01 Jul 2022 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JCJEdfzYxuANLNWAxL8CQ7FpG0f6ZAq5X4D5qi7db0c=;
        b=ookWblnG18DUulKFRrux/M2omlEfLyyUcepuZnHv4ZaA1RBHkzX+bnWjddFRVYrGqW
         MZK3N6pQJ+6xAKJnSgmW2LyplfSQHvIKMQFTtXWVg5XwyxKw0BUV+064ooiigTWFTQM3
         oRjpThV6MgTWGHYTkIsd347Nm4AugejfecG4jQi3rx9RxD3Gv93MikthDtQMo5P22QoV
         aNX9/wgVJX7yI+/KAm8xGXjPjzNlYfKCKED+nNW8Hdgp607nMK6Xh1D8dVUV25sNNnr3
         HAl4/p/qRptBefuSAQQ7YWgZkQK47yR/xtzFtfxk1KXe7aowBiZV7dy//1nGwbflyE6Y
         Qu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JCJEdfzYxuANLNWAxL8CQ7FpG0f6ZAq5X4D5qi7db0c=;
        b=JFCVjFslZ6gd9i3Uaq4ySdnAEjWm1VCXiJO+ls8vhqpfk0p7WIplcrkAmQ+OqMIirg
         ciRGV9hPflvyEScm5UefHEGVH56AotgBXwffWoqHcqZOhg/2I0R7SXSrYSPym4QXgDv8
         vifv3xuDB6SVPoV5Sz0SghxoMJWsdgUpsX3m0qgvMuzY/db6ND764/xS6QxBdFFatL4O
         Ze+/Rea2ih7ePFMZZNg2XvPUbuZMkuah9pML5r6GAOS9h6RxAffrvxLngBfF2DSUgx2W
         Cc6Cxbmd2+UtsaAzkDe+OB2gKgYK3+EWUc38SC9jVHkrfgMWrQLYjktQcbx/wya2Ce3o
         s2sw==
X-Gm-Message-State: AJIora9vP4aosR9nCWuMIdx6gvy1vlPwmO9wF6i8FFtK75oPf3x+d97i
        nV5k2buTHcbon6vExUY9cXaingrDUgE=
X-Google-Smtp-Source: AGRyM1uv2u+hxNkph56Thb2L3PJG6Sax4s9QHwbWNS6xD+og2wEgeS7yy6MYcj8u15wxE3ny3uoT6w==
X-Received: by 2002:a05:622a:54b:b0:305:31e4:51fa with SMTP id m11-20020a05622a054b00b0030531e451famr12451035qtx.165.1656680078441;
        Fri, 01 Jul 2022 05:54:38 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:f902:9816:653f:2f66])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a448500b006a6d4261f40sm1088206qkp.111.2022.07.01.05.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:54:38 -0700 (PDT)
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
Subject: [PATCH 4/8] cpumask: change return types to bool where appropriate
Date:   Fri,  1 Jul 2022 05:54:26 -0700
Message-Id: <20220701125430.2907638-5-yury.norov@gmail.com>
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

Some cpumask functions have integer return types where return values
are naturally booleans.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index fe29ac7cc469..b54e27d9da6b 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -372,9 +372,9 @@ static __always_inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
  * @cpu: cpu number (< nr_cpu_ids)
  * @cpumask: the cpumask pointer
  *
- * Returns 1 if @cpu is set in @cpumask, else returns 0
+ * Returns true if @cpu is set in @cpumask, else returns false
  */
-static __always_inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
+static __always_inline bool cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
 {
 	return test_bit(cpumask_check(cpu), cpumask_bits((cpumask)));
 }
@@ -384,11 +384,11 @@ static __always_inline int cpumask_test_cpu(int cpu, const struct cpumask *cpuma
  * @cpu: cpu number (< nr_cpu_ids)
  * @cpumask: the cpumask pointer
  *
- * Returns 1 if @cpu is set in old bitmap of @cpumask, else returns 0
+ * Returns true if @cpu is set in old bitmap of @cpumask, else returns false
  *
  * test_and_set_bit wrapper for cpumasks.
  */
-static __always_inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
+static __always_inline bool cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_set_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
@@ -398,11 +398,11 @@ static __always_inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpu
  * @cpu: cpu number (< nr_cpu_ids)
  * @cpumask: the cpumask pointer
  *
- * Returns 1 if @cpu is set in old bitmap of @cpumask, else returns 0
+ * Returns true if @cpu is set in old bitmap of @cpumask, else returns false
  *
  * test_and_clear_bit wrapper for cpumasks.
  */
-static __always_inline int cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
+static __always_inline bool cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_clear_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
@@ -431,9 +431,9 @@ static inline void cpumask_clear(struct cpumask *dstp)
  * @src1p: the first input
  * @src2p: the second input
  *
- * If *@dstp is empty, returns 0, else returns 1
+ * If *@dstp is empty, returns false, else returns true
  */
-static inline int cpumask_and(struct cpumask *dstp,
+static inline bool cpumask_and(struct cpumask *dstp,
 			       const struct cpumask *src1p,
 			       const struct cpumask *src2p)
 {
@@ -474,9 +474,9 @@ static inline void cpumask_xor(struct cpumask *dstp,
  * @src1p: the first input
  * @src2p: the second input
  *
- * If *@dstp is empty, returns 0, else returns 1
+ * If *@dstp is empty, returns false, else returns true
  */
-static inline int cpumask_andnot(struct cpumask *dstp,
+static inline bool cpumask_andnot(struct cpumask *dstp,
 				  const struct cpumask *src1p,
 				  const struct cpumask *src2p)
 {
@@ -539,9 +539,9 @@ static inline bool cpumask_intersects(const struct cpumask *src1p,
  * @src1p: the first input
  * @src2p: the second input
  *
- * Returns 1 if *@src1p is a subset of *@src2p, else returns 0
+ * Returns true if *@src1p is a subset of *@src2p, else returns false
  */
-static inline int cpumask_subset(const struct cpumask *src1p,
+static inline bool cpumask_subset(const struct cpumask *src1p,
 				 const struct cpumask *src2p)
 {
 	return bitmap_subset(cpumask_bits(src1p), cpumask_bits(src2p),
-- 
2.34.1

