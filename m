Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAF34C5A28
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 10:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiB0JYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 04:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiB0JYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:24:07 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1F013E8F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 01:23:30 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id p8so8441702pfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 01:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=YKnxtZE2J4v12iS0fkHm9fdiEXM2m35F8Fk6VzqHDJs=;
        b=gsFQBqioXHjAw6hD6Yd7BIthDv0o6558Jjlxjdj60UHr/TUw5mbmVDNW3Mw4mfLBqJ
         y18TDRuBREtjEciK7pvIJk+Yml0exrMOuIfFfSGsRBS+kO5NQ3bLZGXbwIRKKX9yezdw
         vtInvg6o/fRAGW9EWIg42jh/4u0Oh1R+AQwYlFa6K6rTTc5I9KGnXseZqdTm5iLCam4O
         hhtPsxlQFlhr5MYHGq90OLuZG+6dQtA8oLuXPZps1CdB3WSZIuye4w7Hu27jYq/4Q0X1
         ikiQUqdnK6BgGLuP7/XO07U9YE1oM8VlBgzcm6Ou2/fMdpgodE1Z8/1/qvdHX78t5YLe
         eX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=YKnxtZE2J4v12iS0fkHm9fdiEXM2m35F8Fk6VzqHDJs=;
        b=Ia25TCA0GPYVHbqwybSKPxv7RsCs7JdL6BXnzWKZNgTO5cfOxXcFecCIYnevtGIMm4
         atPYVRoIo2yAQjMhkba1lTgzxswz7n/L5s/3HFF8GOIJ7SLHYEKXYyvDeq+ZsdtzDPGB
         Kdb843KRNdXZpVxf/8kdso+/rWvNKpJEjam9vpodclPlqKKEcjJ9ucT7M6/AvtY6nnOg
         Pg0Euk3uYzFatlnlPkyrfj1cjtUShhWYpatj0QytSSc0gHKoOqrJgTYGWirnfQq91ZU8
         dUIRzivC7wez1MvlQ972ds/8PIRIGIGrqmR88bjqzTvWak3h+QBM/UFH9A2yqDkp2Nq8
         h92Q==
X-Gm-Message-State: AOAM531j2l/TyHhH1rz8S5B6Mb8IZcDFWvPCWuo5JbZ0+k9fHxelYSKk
        5YOEtWyBxokAt8Y+0rriGM0=
X-Google-Smtp-Source: ABdhPJzMawut+N0Hibcl7C82p1CHJqf3vz7xVupBicFzhSKFRDvmHb0hc3h1/wky4JSeuPTlAy9Mrw==
X-Received: by 2002:a05:6a00:24ca:b0:4e1:cb76:32da with SMTP id d10-20020a056a0024ca00b004e1cb7632damr15794574pfv.81.1645953810461;
        Sun, 27 Feb 2022 01:23:30 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id e14-20020a056a001a8e00b004e136d54a15sm9584444pfv.105.2022.02.27.01.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 01:23:30 -0800 (PST)
Date:   Sun, 27 Feb 2022 09:23:22 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Zqiang <qiang.zhang@windriver.com>
Subject: [PATCH v2] lib/stackdepot: Use page allocator if both slab and
 memblock is unavailable
Message-ID: <YhtDCoHWsF11rwze@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhrrM7NTYXG5JluY@ip-172-31-19-208.ap-northeast-1.compute.internal>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 2dba5eb1c73b ("lib/stackdepot: allow optional init and
stack_table allocation by kvmalloc()"), stack_depot_init() is called
later if CONFIG_STACKDEPOT_ALWAYS_INIT=n to remove unnecessary memory
usage. It allocates stack_table using memblock_alloc() or kvmalloc()
depending on availability of slab allocator.

But when stack_depot_init() is called while creating boot slab caches,
both slab allocator and memblock is not available. So kernel crashes.
Allocate stack_table from page allocator when both slab allocator and
memblock is unavailable.

Limit size of stack_table when using page allocator because vmalloc()
is also unavailable in kmem_cache_init(). It must not be larger than
(PAGE_SIZE << (MAX_ORDER - 1)).

This patch was tested on both CONFIG_STACKDEPOT_ALWAYS_INIT=y and n.

[ lkp@intel.com: Fix W=1 build warning ]

Fixes: 2dba5eb1c73b ("lib/stackdepot: allow optional init and stack_table allocation by kvmalloc()")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 lib/stackdepot.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index bf5ba9af0500..a96f8fd78c42 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -73,6 +73,14 @@ static int next_slab_inited;
 static size_t depot_offset;
 static DEFINE_RAW_SPINLOCK(depot_lock);
 
+static size_t stack_hash_size = (1 << CONFIG_STACK_HASH_ORDER);
+static inline size_t stack_hash_mask(void)
+{
+	return stack_hash_size - 1;
+}
+
+#define STACK_HASH_SEED 0x9747b28c
+
 static bool init_stack_slab(void **prealloc)
 {
 	if (!*prealloc)
@@ -142,10 +150,6 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	return stack;
 }
 
-#define STACK_HASH_SIZE (1L << CONFIG_STACK_HASH_ORDER)
-#define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
-#define STACK_HASH_SEED 0x9747b28c
-
 static bool stack_depot_disable;
 static struct stack_record **stack_table;
 
@@ -172,18 +176,28 @@ __ref int stack_depot_init(void)
 
 	mutex_lock(&stack_depot_init_mutex);
 	if (!stack_depot_disable && !stack_table) {
-		size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
+		size_t size = (stack_hash_size * sizeof(struct stack_record *));
 		int i;
 
 		if (slab_is_available()) {
 			pr_info("Stack Depot allocating hash table with kvmalloc\n");
 			stack_table = kvmalloc(size, GFP_KERNEL);
+		} else if (totalram_pages() > 0) {
+			/* Reduce size because vmalloc may be unavailable */
+			size = min_t(size_t, size, PAGE_SIZE << (MAX_ORDER - 1));
+			stack_hash_size = size / sizeof(struct stack_record *);
+
+			pr_info("Stack Depot allocating hash table with __get_free_pages\n");
+			stack_table = (struct stack_record **)
+				      __get_free_pages(GFP_KERNEL, get_order(size));
 		} else {
 			pr_info("Stack Depot allocating hash table with memblock_alloc\n");
 			stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
 		}
+
 		if (stack_table) {
-			for (i = 0; i < STACK_HASH_SIZE;  i++)
+			pr_info("Stack Depot hash table size=%zu\n", stack_hash_size);
+			for (i = 0; i < stack_hash_size;  i++)
 				stack_table[i] = NULL;
 		} else {
 			pr_err("Stack Depot hash table allocation failed, disabling\n");
@@ -363,7 +377,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		goto fast_exit;
 
 	hash = hash_stack(entries, nr_entries);
-	bucket = &stack_table[hash & STACK_HASH_MASK];
+	bucket = &stack_table[hash & stack_hash_mask()];
 
 	/*
 	 * Fast path: look the stack trace up without locking.
-- 
2.33.1
