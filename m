Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5E529870
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbiEQDyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiEQDyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:54:15 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF892ED75
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:54:14 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v10so15856059pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7ON3dfhZgko2AZ4EgHw2Wyao1PAn7jk90C3io9zD5A=;
        b=BPD7MyRIaH44Tz+RAfaMB0MP2twGOxtnYDELlbq+6jtDJUhlMy7opg98oSSYF/g9BI
         AihIHCyUHb51+q2Olhejv0r170tTsEFMjnIGYULmVrrHaKjxUoV0EzFOskxNfSn03p2o
         2m/aDwza8LN5fwrkG/f/+baS/sk4ETBvE7zss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7ON3dfhZgko2AZ4EgHw2Wyao1PAn7jk90C3io9zD5A=;
        b=a/36MVgeUHqyjaGz1PjAGZsgzSKj0LJzWz6qNut2+VEpa2UhbavRBPkeJ1pOiHdAVZ
         URgG7gk51qtu6SoBNi4H6pfbLnrWveb4IDRlS+4wB4njgIX63hfN+dTLIJ9F89PbCCdX
         vr+18MLISflTJO6wk2BKRViO5GK0dF0iIQJDGGwSRv6PQ0YUWqTaFKEG92AIEkvPoxsv
         r7wi+LOHtImv9Yi8s38HxinMBh/j82kgJvmLmuVlDZwSnWqigU9Yl8skxkPHv9svFDyE
         gf8GRNfB9hzfVy5YRAPyx7N6aJSPNMJcVyBsoTn4/iatfGccxtNGgRzVY6cPJjBoffcX
         4zgg==
X-Gm-Message-State: AOAM530HjmS6n6lAZbnK2gGI/Pp9FRaV7DYWHHUHXRfz7iMukJJhpGek
        q4PN3RJ3H7DJuxOazpXSAiQNFA==
X-Google-Smtp-Source: ABdhPJxmAkgUHi75MvycJwImQ2HeVYekF9oagiC3KGYNbMJww7QsqJ7dK4hxYIXTzKGJZdKiMvCBvA==
X-Received: by 2002:a63:1d6:0:b0:3c1:732a:3855 with SMTP id 205-20020a6301d6000000b003c1732a3855mr17599663pgb.571.1652759654091;
        Mon, 16 May 2022 20:54:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bd34-20020a056a0027a200b0050dc7628141sm7646287pfb.27.2022.05.16.20.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:54:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] bitmap: Fix return values to be unsigned
Date:   Mon, 16 May 2022 20:54:11 -0700
Message-Id: <20220517035411.31144-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12151; h=from:subject; bh=HUHhrsgpeceUbU0b8HbzkW5Bx6TKv4a1jUlPTqXrEQg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBigxxiogUGsF02+LyIM5kvdycPIxhU288ZNcFXs/lV 8VuW9kyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoMcYgAKCRCJcvTf3G3AJreGEA CwRjZWUvlQ72ylS0YkLEz6tuYkc0MlhpocfOSVGxsPVBnpeT7+0S+PC9U6GpH30mscLoUzVAtBfBND QqdYTsuX+Ar8b06DFU++OGoCfLHLyk/KvbDwEdv08wBQAJ6fy9bzDK3E3kJmYHIb9NSuW1gdsiuBjj dAATJ9I4BbDBFi2QSovVg0IexwLR2Mke8cRatf3gwf2m3bx38x09Nl7/XWz7od1Iw2Wg3mqzSjDoiO FGssQgWQJye473Bkm6S8b+Z3yQGdiKRUWPwlCL1fcIkfyAN0gxwH4p4gz9B21gy4YKTvq5or2E42zA XpNSXY95CSiVvymtVkW9gIKahGC4DH7DrkG/cJxLNXiPnr9yFsWzH4maeW5LVUQh9JkUSUdDhpVx8p 5WkgMEJLJtG8CXz+mw5yC2eakcHz96tHG9rrDs/WDYf+Yy6ytkh3kkekPZ4UXtLQ2P69x/4DG+A4Ew A9L7jmUn/NoGFh4KeeL1ffLOgVgcgZdcOhXfENpGx1JzU6aG19MFJRKCzp/Q/kkl/YaWsiuWR/I6Hg ULjVTK5wtp+D4jlN0meREuJkQDzyFy14/xJSIA71vXd5TjGSg+gAMJSg0Ub6ibffcYoNvD9TA5Xw84 7maoVygZRKbrD5afk72wSlgez4q69NQ/cpXOYWu1xlDmqkp9ICVWOsEyK+SQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both nodemask and bitmap routines had mixed return values that provided
potentially signed results that could never happen. This was leading to
the compiler getting confusing about the range of possible return values
(it was thinking things could be negative where they could not be). Fix
all the nodemask and bitmap routines that should be returning unsigned
(or bool) values. Silences GCC 12 warnings:

 mm/swapfile.c: In function ‘setup_swap_info’:
 mm/swapfile.c:2291:47: error: array subscript -1 is below array bounds of ‘struct plist_node[]’ [-Werror=array-bounds]
  2291 |                                 p->avail_lists[i].prio = 1;
       |                                 ~~~~~~~~~~~~~~^~~
 In file included from mm/swapfile.c:16:
 ./include/linux/swap.h:292:27: note: while referencing ‘avail_lists’
   292 |         struct plist_node avail_lists[]; /*
       |                           ^~~~~~~~~~~

Reported-by: Christophe de Dinechin <dinechin@redhat.com>
Link: https://lore.kernel.org/lkml/20220414150855.2407137-3-dinechin@redhat.com/
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/bitmap.h   | 14 +++++++-------
 include/linux/nodemask.h | 42 ++++++++++++++++++++--------------------
 lib/bitmap.c             | 28 +++++++++++++--------------
 lib/nodemask.c           |  6 +++---
 4 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7dba0847510c..381735c2f2f1 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -132,8 +132,8 @@ unsigned long *devm_bitmap_zalloc(struct device *dev,
  * lib/bitmap.c provides these functions:
  */
 
-int __bitmap_equal(const unsigned long *bitmap1,
-		   const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_equal(const unsigned long *bitmap1,
+		    const unsigned long *bitmap2, unsigned int nbits);
 bool __pure __bitmap_or_equal(const unsigned long *src1,
 			      const unsigned long *src2,
 			      const unsigned long *src3,
@@ -157,10 +157,10 @@ int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 void __bitmap_replace(unsigned long *dst,
 		      const unsigned long *old, const unsigned long *new,
 		      const unsigned long *mask, unsigned int nbits);
-int __bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int nbits);
-int __bitmap_subset(const unsigned long *bitmap1,
-		    const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_intersects(const unsigned long *bitmap1,
+			 const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int nbits);
 int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
 void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
@@ -331,7 +331,7 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
 
-static inline int bitmap_equal(const unsigned long *src1,
+static inline bool bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 567c3ddba2c4..6f89a39c1e9b 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -42,11 +42,11 @@
  * void nodes_shift_right(dst, src, n)	Shift right
  * void nodes_shift_left(dst, src, n)	Shift left
  *
- * int first_node(mask)			Number lowest set bit, or MAX_NUMNODES
- * int next_node(node, mask)		Next node past 'node', or MAX_NUMNODES
- * int next_node_in(node, mask)		Next node past 'node', or wrap to first,
+ * unsigned int first_node(mask)	Number lowest set bit, or MAX_NUMNODES
+ * unsigend int next_node(node, mask)	Next node past 'node', or MAX_NUMNODES
+ * unsigned int next_node_in(node, mask) Next node past 'node', or wrap to first,
  *					or MAX_NUMNODES
- * int first_unset_node(mask)		First node not set in mask, or 
+ * unsigned int first_unset_node(mask)	First node not set in mask, or
  *					MAX_NUMNODES
  *
  * nodemask_t nodemask_of_node(node)	Return nodemask with bit 'node' set
@@ -153,7 +153,7 @@ static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
 
 #define node_test_and_set(node, nodemask) \
 			__node_test_and_set((node), &(nodemask))
-static inline int __node_test_and_set(int node, nodemask_t *addr)
+static inline bool __node_test_and_set(int node, nodemask_t *addr)
 {
 	return test_and_set_bit(node, addr->bits);
 }
@@ -200,7 +200,7 @@ static inline void __nodes_complement(nodemask_t *dstp,
 
 #define nodes_equal(src1, src2) \
 			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
-static inline int __nodes_equal(const nodemask_t *src1p,
+static inline bool __nodes_equal(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_equal(src1p->bits, src2p->bits, nbits);
@@ -208,7 +208,7 @@ static inline int __nodes_equal(const nodemask_t *src1p,
 
 #define nodes_intersects(src1, src2) \
 			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
-static inline int __nodes_intersects(const nodemask_t *src1p,
+static inline bool __nodes_intersects(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
@@ -216,20 +216,20 @@ static inline int __nodes_intersects(const nodemask_t *src1p,
 
 #define nodes_subset(src1, src2) \
 			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
-static inline int __nodes_subset(const nodemask_t *src1p,
+static inline bool __nodes_subset(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_subset(src1p->bits, src2p->bits, nbits);
 }
 
 #define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
-static inline int __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
+static inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_empty(srcp->bits, nbits);
 }
 
 #define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
-static inline int __nodes_full(const nodemask_t *srcp, unsigned int nbits)
+static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_full(srcp->bits, nbits);
 }
@@ -260,15 +260,15 @@ static inline void __nodes_shift_left(nodemask_t *dstp,
           > MAX_NUMNODES, then the silly min_ts could be dropped. */
 
 #define first_node(src) __first_node(&(src))
-static inline int __first_node(const nodemask_t *srcp)
+static inline unsigned int __first_node(const nodemask_t *srcp)
 {
-	return min_t(int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
+	return min_t(unsigned int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
 }
 
 #define next_node(n, src) __next_node((n), &(src))
-static inline int __next_node(int n, const nodemask_t *srcp)
+static inline unsigned int __next_node(int n, const nodemask_t *srcp)
 {
-	return min_t(int,MAX_NUMNODES,find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
+	return min_t(unsigned int, MAX_NUMNODES, find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
 }
 
 /*
@@ -276,7 +276,7 @@ static inline int __next_node(int n, const nodemask_t *srcp)
  * the first node in src if needed.  Returns MAX_NUMNODES if src is empty.
  */
 #define next_node_in(n, src) __next_node_in((n), &(src))
-int __next_node_in(int node, const nodemask_t *srcp);
+unsigned int __next_node_in(int node, const nodemask_t *srcp);
 
 static inline void init_nodemask_of_node(nodemask_t *mask, int node)
 {
@@ -296,9 +296,9 @@ static inline void init_nodemask_of_node(nodemask_t *mask, int node)
 })
 
 #define first_unset_node(mask) __first_unset_node(&(mask))
-static inline int __first_unset_node(const nodemask_t *maskp)
+static inline unsigned int __first_unset_node(const nodemask_t *maskp)
 {
-	return min_t(int,MAX_NUMNODES,
+	return min_t(unsigned int, MAX_NUMNODES,
 			find_first_zero_bit(maskp->bits, MAX_NUMNODES));
 }
 
@@ -436,11 +436,11 @@ static inline int num_node_state(enum node_states state)
 
 #define first_online_node	first_node(node_states[N_ONLINE])
 #define first_memory_node	first_node(node_states[N_MEMORY])
-static inline int next_online_node(int nid)
+static inline unsigned int next_online_node(int nid)
 {
 	return next_node(nid, node_states[N_ONLINE]);
 }
-static inline int next_memory_node(int nid)
+static inline unsigned int next_memory_node(int nid)
 {
 	return next_node(nid, node_states[N_MEMORY]);
 }
@@ -495,9 +495,9 @@ static inline int num_node_state(enum node_states state)
 #endif
 
 #if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
-extern int node_random(const nodemask_t *maskp);
+extern unsigned int node_random(const nodemask_t *maskp);
 #else
-static inline int node_random(const nodemask_t *mask)
+static inline unsigned int node_random(const nodemask_t *mask)
 {
 	return 0;
 }
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 0d5c2ece0bcb..b57dafe13eec 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -45,19 +45,19 @@
  * for the best explanations of this ordering.
  */
 
-int __bitmap_equal(const unsigned long *bitmap1,
+bool __bitmap_equal(const unsigned long *bitmap1,
 		const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] != bitmap2[k])
-			return 0;
+			return false;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] ^ bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 0;
+			return false;
 
-	return 1;
+	return true;
 }
 EXPORT_SYMBOL(__bitmap_equal);
 
@@ -303,33 +303,33 @@ void __bitmap_replace(unsigned long *dst,
 }
 EXPORT_SYMBOL(__bitmap_replace);
 
-int __bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int bits)
+bool __bitmap_intersects(const unsigned long *bitmap1,
+			 const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] & bitmap2[k])
-			return 1;
+			return true;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 1;
-	return 0;
+			return true;
+	return false;
 }
 EXPORT_SYMBOL(__bitmap_intersects);
 
-int __bitmap_subset(const unsigned long *bitmap1,
-		    const unsigned long *bitmap2, unsigned int bits)
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] & ~bitmap2[k])
-			return 0;
+			return false;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] & ~bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 0;
-	return 1;
+			return false;
+	return true;
 }
 EXPORT_SYMBOL(__bitmap_subset);
 
diff --git a/lib/nodemask.c b/lib/nodemask.c
index 3aa454c54c0d..6bac975fad7e 100644
--- a/lib/nodemask.c
+++ b/lib/nodemask.c
@@ -3,7 +3,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 
-int __next_node_in(int node, const nodemask_t *srcp)
+unsigned int __next_node_in(int node, const nodemask_t *srcp)
 {
 	int ret = __next_node(node, srcp);
 
@@ -18,9 +18,9 @@ EXPORT_SYMBOL(__next_node_in);
  * Return the bit number of a random bit set in the nodemask.
  * (returns NUMA_NO_NODE if nodemask is empty)
  */
-int node_random(const nodemask_t *maskp)
+unsigned int node_random(const nodemask_t *maskp)
 {
-	int w, bit = NUMA_NO_NODE;
+	unsigned int w, bit = NUMA_NO_NODE;
 
 	w = nodes_weight(*maskp);
 	if (w)
-- 
2.32.0

