Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B7252AD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiEQVWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiEQVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:22:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84C23ED05
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:22:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so97357pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Owv008S1mnLnQx4FX8fpU4Ogq2/9KsKFYrwKU2ohc0s=;
        b=io8GOq5QwWCqnCuLT+1nCJ9FopsU1HXbidc5NhnARs0p4FdzVHHJjf7h5IWdN1NrGG
         2srzB5atQM7bC4NRoPB7tLzpBr7ViHb4eWTOKYiM0AMI7P82TIPu3TVy3S+z0QpNtfmx
         NxVstHKxZO/S10C8ezhDcUJSbQNoSbB1V/dCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Owv008S1mnLnQx4FX8fpU4Ogq2/9KsKFYrwKU2ohc0s=;
        b=qjIIk1xH3GIxbKP+S3bpRd/rSxClJB90fnB4dt/Nu5jcY92nFOAIfoclQSJLOxi3Nk
         eRBgCBGdF/BhI76DWtnNWY7GHyr3Lt9N42edY3Ad4dAGM5mJxeAYqCtWfmZdRSwy13D5
         j+5ErEe3tA2yErgh2lq0tTPfLR1ciSJXiSVAyRhtQL+nbwlBmNaJ+bHW/1jXBWHh+2Kq
         0eGXklVrhNWEqEqA6L3eqwDFkr6EV9gFj1C7P8UYcn8tkjDI1bQwW63v5Nw0Hz6TN3vc
         RCP6TxStsXy9A6bc5/rfsymieqVPa5iNv5HTCqwvH+ULxqEQIkcfhe+3u9pmKpYiBLx7
         RmAA==
X-Gm-Message-State: AOAM53016LBmxoFEDCD+qtUpSUZk+4Yu6WtY6JHNwVhxGlOCpf6A41tz
        Ko2UVIr7eSfZFtZ+Q5NsO/stXg==
X-Google-Smtp-Source: ABdhPJzdVTqM1irj9jTRkg3UyFQYPFRlJ8NhW8Dng3RLH2PK0kV++JassBwnFUKB5cLTQVVx/JoWSA==
X-Received: by 2002:a17:902:f605:b0:14d:9e11:c864 with SMTP id n5-20020a170902f60500b0014d9e11c864mr24456412plg.54.1652822557207;
        Tue, 17 May 2022 14:22:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d1-20020a62f801000000b0050dd876f5f8sm203763pfh.49.2022.05.17.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:22:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2] nodemask: Fix return values to be unsigned
Date:   Tue, 17 May 2022 14:22:34 -0700
Message-Id: <20220517212234.868181-3-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517212234.868181-1-keescook@chromium.org>
References: <20220517212234.868181-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7372; h=from:subject; bh=LEXAUG9zqc/TgnUiqrSc+AaEdVOWiNU6eYa3b0/wsVQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihBIZQvrvPnNWKFXJhk3vDVY5ef5M4Ty5pllPp/kU O1NFf5WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoQSGQAKCRCJcvTf3G3AJqWpD/ 9IKqaBhfkWChgQnMTwGTrA5vz+0196CCmM7qEcpJMTFbysQyFUXOAixfSMt2bE1z5i3KcLCAqUVJfo g+C/1KrRv7V7JltQueFM9plElJ2agTQWaq7uatZlQ8O6pgaVNXurxhR/lmtuCSC2Xr8RlsHZVO4s5b VoJei7eGkws+kTPox+v9EybInB+l1wRcPDdG/3UCsQYEL9io0wS3uxDZqltEUuy/JbCv4UGV4eADu2 pJsWW5sBlRa7HMtF2gxLz9xQVG+kC3u275KD7bGs39VjmtYsQgY+qvqL9gHItsLITTmADYE1up1tqv BF47ajG70QdTFC5LuOyIvHpPOmHDSP8TjFJlMeUP6j85PezSZ91lpe8dzkxjxdG0gPK8K8Y3tewpJt 4RGMkuxaPtURmqDFORkUfcs3bflNSJxuAE34csEuu6fugToMmJvzMSIMXalkA2YuMghHVkv9/9zNNC BqsgiEAJdZVJkwt8FYILZQch54SAjT4qWhinaJpz8ICU6mOeeGAG0T+qHyByPNHsCUxUJw7OriNKH5 Cy26o/ZD+jVkf11B2skTjJ3sR6+UkJ20MXBQQk5XSWIsMl4iAELTo4IuSziANCN4H0GX9QppJM2fvm u0l5nWtY0wzZKYGA0VJxvIQzuFftwmn+icIvNibyfxbr1lE98coCTr0rde6w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nodemask routines had mixed return values that provided potentially
signed return values that could never happen. This was leading to the
compiler getting confusing about the range of possible return values
(it was thinking things could be negative where they could not be). Fix
all the nodemask routines that should be returning unsigned
(or bool) values. Silences:

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
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/nodemask.h | 38 +++++++++++++++++++-------------------
 lib/nodemask.c           |  2 +-
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 567c3ddba2c4..2c39663c3407 100644
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
diff --git a/lib/nodemask.c b/lib/nodemask.c
index 3aa454c54c0d..a334cf722189 100644
--- a/lib/nodemask.c
+++ b/lib/nodemask.c
@@ -3,7 +3,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 
-int __next_node_in(int node, const nodemask_t *srcp)
+unsigned int __next_node_in(int node, const nodemask_t *srcp)
 {
 	int ret = __next_node(node, srcp);
 
-- 
2.32.0

