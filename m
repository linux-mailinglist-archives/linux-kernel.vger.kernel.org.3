Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE4E56D40D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiGKErq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiGKErV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:47:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D5760CF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:47:20 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b2so523872qkk.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=INvUTYu9dairWJ/J98PrS85b9AuqfQWZLIuDZmgdIug=;
        b=YaKowwfmmEcDAw8khKC4VVPEog0/+uU4H8CAy1j0FgHqSR9O2QCzFFd5uEf13z5XIo
         3m2TviDjmax/vb/ztAi1FDg4qTC9UlSaU0JCb+1vwxCBCHttWpfh2xCsgiRlMHywfw2j
         DWQrvlrQ151l7EhmHKdqTjPwSh6xCBm7C0S2cSX7aXY/nHMEFPB68ry2YhV0QhYXsq38
         hdyBAduJHpfO0SpgX7Ro53uItDqvLACOrCGWAjmH1EmgPSo9g1afCaNTqbzleXBUqqjQ
         VL0nEIsG36DdajEO67uDK6aKGLYfDENjGJGR3tyUC0laHGfzYc+0pJ1IiKmHCCNb3skV
         KYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=INvUTYu9dairWJ/J98PrS85b9AuqfQWZLIuDZmgdIug=;
        b=feER4AHfHTNCEtLzg02VzEIejk4fT35ezjitp+RyJZCM3VU80W3tdB61hPX2hoOYMK
         nuw+cbg88Ygh1znyr+2eqgPseKG+ZsIJTl2+nWhDxmuKYmMUS0h0wqE3/yMvh4pTmVl1
         at2ITSpSjuSVmBo6ulzXyl5t4Ycha7HpvgXGsrSJzewEiWbfJ/jjphx65vKNkEiAME4b
         gJANak1pCVMTT0Jr0URUgPYQ3GzmQdlaiWi2uV7dhY8xtTziVaFGIuG4Go8GcARrx00M
         MhJwCe4qIfWQDe0ch9mZKtT6qWmfr6kgzRGZl5Mjn3N43boUmLxiPsLAFd23hKP46oif
         Z5HQ==
X-Gm-Message-State: AJIora/UyBBBqQy/GCVULBeABuwyrNQDEh49WAIImzNLC3810LuxPjmP
        8vKRKwEP4Fjw+q2GQoA+uEMm8LofbQvq3A==
X-Google-Smtp-Source: AGRyM1uhBWsCKUmq9aDc1F1otrdss8jIzZiRjquWwL0Ewzd4Viza65MG7AjCdPZ5uUgUUBzgQluFxA==
X-Received: by 2002:a05:620a:1e5:b0:6b5:55d5:5ce3 with SMTP id x5-20020a05620a01e500b006b555d55ce3mr10018006qkn.640.1657514839230;
        Sun, 10 Jul 2022 21:47:19 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:a22e:180:f963:1eff])
        by smtp.gmail.com with ESMTPSA id f20-20020a05620a409400b006b5840f3eefsm2475579qko.130.2022.07.10.21.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 21:47:18 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 5/5] lib/nodemask: inline next_node_in() and node_random()
Date:   Sun, 10 Jul 2022 21:47:11 -0700
Message-Id: <20220711044711.466822-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711044711.466822-1-yury.norov@gmail.com>
References: <20220711044711.466822-1-yury.norov@gmail.com>
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

The functions are pretty thin wrappers around find_bit engine, and
keeping them in c-file prevents compiler from small_const_nbits()
optimization, which must take place for all systems with MAX_NUMNODES
less than BITS_PER_LONG (default is 16 for me).

Moving them in header file doesn't blow up the kernel size:
add/remove: 1/2 grow/shrink: 9/5 up/down: 968/-88 (880)

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS              |  1 -
 include/linux/nodemask.h | 27 ++++++++++++++++++++++-----
 lib/Makefile             |  2 +-
 lib/nodemask.c           | 30 ------------------------------
 4 files changed, 23 insertions(+), 37 deletions(-)
 delete mode 100644 lib/nodemask.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c0b8f28aa25..19c8d0ef1177 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3540,7 +3540,6 @@ F:	lib/bitmap.c
 F:	lib/cpumask.c
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
-F:	lib/nodemask.c
 F:	lib/test_bitmap.c
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/find.h
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 0f233b76c9ce..48ebe4007955 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -94,6 +94,7 @@
 #include <linux/bitmap.h>
 #include <linux/minmax.h>
 #include <linux/numa.h>
+#include <linux/random.h>
 
 typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
 extern nodemask_t _unused_nodemask_arg_;
@@ -276,7 +277,14 @@ static inline unsigned int __next_node(int n, const nodemask_t *srcp)
  * the first node in src if needed.  Returns MAX_NUMNODES if src is empty.
  */
 #define next_node_in(n, src) __next_node_in((n), &(src))
-unsigned int __next_node_in(int node, const nodemask_t *srcp);
+static inline unsigned int __next_node_in(int node, const nodemask_t *srcp)
+{
+	unsigned int ret = __next_node(node, srcp);
+
+	if (ret == MAX_NUMNODES)
+		ret = __first_node(srcp);
+	return ret;
+}
 
 static inline void init_nodemask_of_node(nodemask_t *mask, int node)
 {
@@ -493,14 +501,23 @@ static inline int num_node_state(enum node_states state)
 
 #endif
 
+/*
+ * Return the bit number of a random bit set in the nodemask.
+ * (returns NUMA_NO_NODE if nodemask is empty)
+ */
+static inline int node_random(const nodemask_t *maskp)
+{
 #if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
-extern int node_random(const nodemask_t *maskp);
+	int w, bit = NUMA_NO_NODE;
+
+	w = nodes_weight(*maskp);
+	if (w)
+		bit = find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_int() % w);
+	return bit;
 #else
-static inline int node_random(const nodemask_t *mask)
-{
 	return 0;
-}
 #endif
+}
 
 #define node_online_map 	node_states[N_ONLINE]
 #define node_possible_map 	node_states[N_POSSIBLE]
diff --git a/lib/Makefile b/lib/Makefile
index f99bf61f8bbc..731cea0342d1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -33,7 +33,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
-	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
+	 nmi_backtrace.o win_minmax.o memcat_p.o \
 	 buildid.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
diff --git a/lib/nodemask.c b/lib/nodemask.c
deleted file mode 100644
index 7dad4ce8ff59..000000000000
--- a/lib/nodemask.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/nodemask.h>
-#include <linux/module.h>
-#include <linux/random.h>
-
-unsigned int __next_node_in(int node, const nodemask_t *srcp)
-{
-	unsigned int ret = __next_node(node, srcp);
-
-	if (ret == MAX_NUMNODES)
-		ret = __first_node(srcp);
-	return ret;
-}
-EXPORT_SYMBOL(__next_node_in);
-
-#ifdef CONFIG_NUMA
-/*
- * Return the bit number of a random bit set in the nodemask.
- * (returns NUMA_NO_NODE if nodemask is empty)
- */
-int node_random(const nodemask_t *maskp)
-{
-	int w, bit = NUMA_NO_NODE;
-
-	w = nodes_weight(*maskp);
-	if (w)
-		bit = find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_int() % w);
-	return bit;
-}
-#endif
-- 
2.34.1

