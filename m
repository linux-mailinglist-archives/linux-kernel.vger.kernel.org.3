Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427F45691A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiGFSXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiGFSXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:23:09 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9A62A428
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:23:07 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l14so19446401qtx.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hhqdc2x+kkGFSuuHDeERWD84qOn+LrQwMR/CrzMYCA=;
        b=ncJa0bbsY+ADs51/B7IPMBI5jZWHnw1auM0/zB0TVloBNSAhkr+fEWFFYikqeSmgJS
         5STn7hps64Hfd8wMGa2yVr0H8MOUMs/lePVZx9gaXvgN8YKgP4rMFqOjN5bEUrX2xRYD
         p+7aDMLStNe/af2b4loTfOCSYfQH+i9l3xQUj3PDb73qQqoAbh7LHYrIEbL8wYkIBXuf
         9UGhQUCdjLimslM/24w24qs4ONlci3+PpnQB9oX0a1AGpQtGU9BYZXExgwjUzGat3IFn
         W+ydV+JCcWKndye8Ie2Yxb6csdupMh6OJ+Dm50tynm/1iqplz9ljRpkVTZmBoo/O1tH4
         pHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hhqdc2x+kkGFSuuHDeERWD84qOn+LrQwMR/CrzMYCA=;
        b=ASJdiIWYxwZqlIZFjz0GBddWwu9BeoNiZTXI2NK6pqEdBiG/46VRB6HgDzYgBe1c7r
         iFHXq1ExQagyltya1MR8uMZ0YtcayO64upwXGMsx58q8RrXnHEmjLMhr18pMi187QBJV
         3s+I1v4pomDzHB2N9gEMl78gdA5X9dVrOPktIbjE3kOb+1ZZmL1cDd3Dl4VeTrxY781J
         ZNXceeIH0r7BRCGNnapAnhQixuDjz87pInLGUYa/bTPaJRRmqRy+yk8WwYPcfEhBnUXW
         7CkpGtBgvoGScrD/LvOFXJ9epaPtex1WYRsaavEUUmtiixXmgCBrUvoN++NfjaCMNtof
         +NOw==
X-Gm-Message-State: AJIora/DO7+6eiYFF+GQ5FWWuRrfs8en/7cY3ns0POb0FegjOgeIccNt
        8MiqBSud0oAOnOK2xT1X8O6za/f+ixXROg==
X-Google-Smtp-Source: AGRyM1v6owxWrcp9XaQYZwsUgPkipgCazU6XPpChMM/D/s0UTByGci2ze0poMpZmFKcFgOHaGy8iRQ==
X-Received: by 2002:ac8:5bd4:0:b0:31a:faa2:f639 with SMTP id b20-20020ac85bd4000000b0031afaa2f639mr33715592qtb.487.1657131786757;
        Wed, 06 Jul 2022 11:23:06 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006a6a5d1e240sm33304238qko.34.2022.07.06.11.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:23:06 -0700 (PDT)
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
Date:   Wed,  6 Jul 2022 11:23:00 -0700
Message-Id: <20220706182300.70862-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706182300.70862-1-yury.norov@gmail.com>
References: <20220706182300.70862-1-yury.norov@gmail.com>
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
index f808826509e5..314dd1054246 100644
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
+		bit = find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_int() % w + 1);
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
-		bit = find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_int() % w + 1);
-	return bit;
-}
-#endif
-- 
2.34.1

