Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92CB57F1CA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 23:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbiGWVpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 17:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiGWVpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 17:45:44 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B7BE00D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 14:45:43 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id mh14so5859124qvb.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zanwdLBSKuenMXk1so8se+lxPJyj0nx7EB+yjkrFe/o=;
        b=ABNOp66/VYqY3jEnDnPLBaq4zdHPZUVCkl0bi9IJa0l5O05esh6ZD2a+M0yUsRyvcS
         q4dQO17dfGLRqTb+USaB0J563S0jDgXnQyFIO5MCxeczAamedeigG2esjotGwsqb0nvO
         mYoSosW0y4MYPVZcPibUs2kiBTZxJradjkE53hCV1GKudTxmzBPVgg9YExVuiqUdHZvK
         pcTkzxMvT7Us4EmuxjMLSXIgou+3FVHM6pxeGcEmJ6ODIvHArn/LcP4YTKfeYfzfS1x8
         bN2p1/757yWPV4RxsncxhrCMhRWSvGWzWkrfro319eMpCTCd01Q+vgukchYJe8fnLZ1S
         Y4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zanwdLBSKuenMXk1so8se+lxPJyj0nx7EB+yjkrFe/o=;
        b=lnBqI3hex1qVL0o3bai8GkA1IjBYykH2Gyj2hSmm4XOz2xjGyKV+GhAmDaVsnu42Th
         V1oQXm76cXzL+OUQnZOiAq8zrUEZVdHAUcvtSmahD2rAUGrCyuFFKcDKIeVQJZH+MQEW
         BHBZLsnzUBZvmu/qnwyg/8n94zroQLuy1RwGcPIj4CJ2XU9irPywLJ9tcXNgI9SK+Qra
         M6dNLxXrYaT9ldtnM8h0wwfpdu1QQe18TCJHi1+mkfTR+kAZJzqJEzo6aknTLn7b6/KU
         usSISJ2gspQFIi1LFx613VI/scaO63fJ+kuVjT+rHDS1SlPSqCddKrkCrzuzHvOb/h16
         Rk8Q==
X-Gm-Message-State: AJIora+EydQNVHIIcm16Iae7WVCe/++GMhc29wnfCd3STPzJdvhgmYJH
        x0eEnIcl5rTIPUC9eKRJAYtFFEyAksI=
X-Google-Smtp-Source: AGRyM1uZ9CfS62x2yNvwqVuhLpykjeNvaVrfvSyWvrEv07t7Q+Cd7x1Q9jl/zvE9BFVSeON+yeRzYw==
X-Received: by 2002:a0c:c506:0:b0:470:8e86:de0 with SMTP id x6-20020a0cc506000000b004708e860de0mr4943625qvi.104.1658612742153;
        Sat, 23 Jul 2022 14:45:42 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:6235:40e3:a1d2:6281])
        by smtp.gmail.com with ESMTPSA id n14-20020a05622a040e00b0031b18d29864sm5228665qtx.64.2022.07.23.14.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 14:45:41 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [RESEND PATCH 2/2] lib/nodemask: inline next_node_in() and node_random()
Date:   Sat, 23 Jul 2022 14:45:37 -0700
Message-Id: <20220723214537.2054208-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220723214537.2054208-1-yury.norov@gmail.com>
References: <20220723214537.2054208-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions are pretty thin wrappers around find_bit engine, and
keeping them in c-file prevents compiler from small_const_nbits()
optimization, which must take place for all systems with MAX_NUMNODES
less than BITS_PER_LONG (default is 16 for me).

Moving them to header file doesn't blow up the kernel size:
add/remove: 1/2 grow/shrink: 9/5 up/down: 968/-88 (880)

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

