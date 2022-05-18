Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225152C4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbiERUwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242828AbiERUwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:52:31 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E809737A7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:52:29 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h186so3205560pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqON4Iq1Vc0Hor92F448uKvyKCeniEjRqspyRbzgt/4=;
        b=YaOYezo2s4lDHb/ClK3ZD5e8w7/qqG4uYKvT57wjGAy+7Iq3N6M5l0ZMoGMqsuOVr/
         ecRpAE5VR1W2i0ozMPY5zVfAChNPm2P5liwzCN2IEy5k15rAu9xKEBA+0N9UWXgAXxm1
         2qEReDvm75j5uFlDJYiUhneBgHrj4DB3NaVCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqON4Iq1Vc0Hor92F448uKvyKCeniEjRqspyRbzgt/4=;
        b=Hr2eTx1rTYKDQdEbu4Lo8phFPLlfMJAKsPVHojBidy8Qtf0DGdWkkgFfDK7xE26rz1
         KtLfyFdsbVrk4HkBxYBQiogJgIcA2hWjONNvemJQaUCxtwl0nA6T49DAcjGCcCNdQukE
         lp+MJah68L9QIKy+Cc0oOdQWtSGlrV2/G3YOLAWNA8VXmsskm2AFvCuyXBqTaxNdaTM+
         bp37BXJljO6aRB/IHI27RdiTRCYsP5Cc06Kslh0JN/2AAg+heu4kHRL5mgHgSxAZLBhz
         Y5yj0z7N4HAq/Sau8imDvKI2p6EprTAP7rcbC1dyVUJTDt46uLV5hpYnOc8m0csSK99a
         WY9A==
X-Gm-Message-State: AOAM531pxtgwmHtKNF7elfRi3IDj5pBdNw27uIJroOe51rrR/lU9KOle
        yGK77XFlPnt6qDEbwl/4U5BnFQ==
X-Google-Smtp-Source: ABdhPJy99b2nCQcf/Rn/E751eQ2GqsaZNhUWEL3oOMJLbREMpaEeKdpqMS2HrIyrRH5GwQ2UDTxg7g==
X-Received: by 2002:a63:3d0b:0:b0:37f:ef34:1431 with SMTP id k11-20020a633d0b000000b0037fef341431mr1037400pga.547.1652907149442;
        Wed, 18 May 2022 13:52:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b0016194c1df58sm2216695plh.105.2022.05.18.13.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:52:29 -0700 (PDT)
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
Subject: [PATCH v3 2/2] nodemask: Fix return values to be unsigned
Date:   Wed, 18 May 2022 13:52:23 -0700
Message-Id: <20220518205223.2908736-3-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220518205223.2908736-1-keescook@chromium.org>
References: <20220518205223.2908736-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7479; h=from:subject; bh=jKwSPhAGMa32xncMSUgCGkJEItBxEQ3ifQ4V40DS0JM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihVyH/p0tJo8ozHWap+tEIfvqFepS6dbK2O5B/nZy jiaIkq2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoVchwAKCRCJcvTf3G3AJiO/EA CiNbQ6XNyjv0nmoPdeojaAeXfm4j/X94zgOa4dguipKDNdKEFEUuIdf1KqR+MlEaU3zlRYmol/J28I D8uClxUdIJezGL5VfkQ8lZBqoXdVVnkono18PhbtqUO3diMG4if6m8N4WalQrNqg3HzqE5ASP+JAHK 2oYHXRCCCZX0C8XKo5Eqo84VAmQ3clu6kvy2nvu1MM6OZp519DQIhZSMydrqQCmpeVXyynNKqtxtLO bPS4YHLinmYa/Vpb8lmcIdbktOkwCiXoJRYHuD8+00fIA8mKAvRccEYj/X/0M22JMUYzh+uF5sAa0H QFnVm/FBDhLaD0u+3LVjVEdaXHtBJynJhwAWt5iV4+SB05xuYVrr/53Su/I79QlpgnsRiY5BLQOo1F QNqe6O+/NtYg0ctEqneLFCqvjyRlzF+wON7HfyCPcQtE1pnkbBfwu9u1Brz/Q/gE3A6nzqsUTJAYWT bhOZ5/mIF3fDNC2h9ItEwgk2/N6ad3rMYGI3ffhKLIMiC3nWb3mA8PsXfmRW4IWtNs1ep2w5o9k5q0 JZE1cTImcx7Q8hF6dxKYjLWR/pwl2kThx+PHsgWktTdTO5NYb1i7E58DrmteFRDB/DlMmNGAklV9Rx CjQuWVpjzVYL/4ceTGX6IUkfhBMisAQl/reccS5EPJuTPLJ6gcxGEC7akEog==
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
 lib/nodemask.c           |  4 ++--
 2 files changed, 21 insertions(+), 21 deletions(-)

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
index 3aa454c54c0d..e22647f5181b 100644
--- a/lib/nodemask.c
+++ b/lib/nodemask.c
@@ -3,9 +3,9 @@
 #include <linux/module.h>
 #include <linux/random.h>
 
-int __next_node_in(int node, const nodemask_t *srcp)
+unsigned int __next_node_in(int node, const nodemask_t *srcp)
 {
-	int ret = __next_node(node, srcp);
+	unsigned int ret = __next_node(node, srcp);
 
 	if (ret == MAX_NUMNODES)
 		ret = __first_node(srcp);
-- 
2.32.0

