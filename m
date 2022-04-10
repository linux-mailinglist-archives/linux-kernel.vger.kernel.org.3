Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5411F4FAEDF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbiDJQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243582AbiDJQ1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:27:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D46B3703D
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:25:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id j17so11086948pfi.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vgYau9yYdCljtzTr6MtTaLrwj9ih04H5dgCFTrcTCP8=;
        b=fX1sS2gnm4hZVr3Zi9jdGyuK9CNudj1DjNK9yC6AZfhipZ1VR/Bug89B/knheOPpDW
         RpPj3tBxndzn+vXz4WYx/gkXCAFvaCv9u58Ze1f0r2QV+tnw4vPGfBNlA0OnKxUP+r2p
         qFwaPxbnKy1+UNG20+h8M9a72TinACBrFadtamkkuKzko3d25F0pHaOWmWLOOqtR0mMG
         +Am4TSO1a/pTJR9ODfxMZIwjPzmwWcZwHc7vP1lR/ALCAraOLYiu+UPOgItfaJxKl+K/
         MlKcNEEzoQuann4OT8f+GffsS+KEqxyOK3AAWrl4QwNA408txVvrtt6kFNpZHstatv/i
         x4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vgYau9yYdCljtzTr6MtTaLrwj9ih04H5dgCFTrcTCP8=;
        b=pbnubqycT5vsbnvmImkCzfMlH4WyoaKJYmSSzbitn7kZFW8pZI/0iIQtzMSaJ0bm3k
         cyIjkBHVL5+Lo3ojE8DFTP10coHuisnnWnmqoa1IzeGlQ2GLy9FLupVlw36QXks9R7ls
         HT96eQKpMmIw+ZFnojB3ko+iJKr1d9ClH7ILgPgBksBsmv7EtTG/YLoYq+JRmLLYICQd
         uEwZqsEqJ8DjMKZHXglJHJaUYSsf8C3q+GyKwLe9QMqJiEAwhlmqxB7QkCqL79qHruCq
         gIOITYzLTNBmvMso6ZYu/O66hO1WPHuEI/S51tfz0j7Wz7KqnOLvC/TXNS07JZzQPCXB
         GEYw==
X-Gm-Message-State: AOAM5303NvJPrcDtDkiB1YTLlVjH7AdnIDqvZRyF+vLeYlQCisCfxEvy
        jyP1g9qusUBpj2ViOTtr+KQ=
X-Google-Smtp-Source: ABdhPJyGKIG19qwgzjrGkKmRYgZwFdkyBzYaBwHyyuWiqSh8PSL0BT4GZDXOrZ2ZaPPwmfMUtvYH5A==
X-Received: by 2002:a63:2266:0:b0:39c:f643:ee69 with SMTP id t38-20020a632266000000b0039cf643ee69mr10466052pgm.288.1649607919633;
        Sun, 10 Apr 2022 09:25:19 -0700 (PDT)
Received: from localhost.localdomain ([210.100.217.177])
        by smtp.gmail.com with ESMTPSA id n19-20020a62e513000000b005048eef5827sm13386553pff.142.2022.04.10.09.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 09:25:19 -0700 (PDT)
From:   Ohhoon Kwon <ohkwon1043@gmail.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/slab_common: move dma-kmalloc caches creation into new_kmalloc_cache()
Date:   Mon, 11 Apr 2022 01:25:11 +0900
Message-Id: <20220410162511.656541-1-ohkwon1043@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four types of kmalloc_caches: KMALLOC_NORMAL, KMALLOC_CGROUP,
KMALLOC_RECLAIM, and KMALLOC_DMA. While the first three types are
created using new_kmalloc_cache(), KMALLOC_DMA caches are created in a
separate logic. Let KMALLOC_DMA caches be also created using
new_kmalloc_cache(), to enhance readability.

Historically, there were only KMALLOC_NORMAL caches and KMALLOC_DMA
caches in the first place, and they were initialized in two separate
logics. However, when KMALLOC_RECLAIM was introduced in v4.20 via
commit 1291523f2c1d ("mm, slab/slub: introduce kmalloc-reclaimable
caches") and KMALLOC_CGROUP was introduced in v5.14 via
commit 494c1dfe855e ("mm: memcg/slab: create a new set of kmalloc-cg-<n>
caches"), their creations were merged with KMALLOC_NORMAL's only.
KMALLOC_DMA creation logic should be merged with them, too.

By merging KMALLOC_DMA initialization with other types, the following
two changes might occur:
1. The order dma-kmalloc-<n> caches added in slab_cache list may be
sorted by size. i.e. the order they appear in /proc/slabinfo may change
as well.
2. slab_state will be set to UP after KMALLOC_DMA is created.
In case of slub, freelist randomization is dependent on slab_state>=UP,
and therefore KMALLOC_DMA cache's freelist will not be randomized in
creation, but will be deferred to init_freelist_randomization().

Co-developed-by: JaeSang Yoo <jsyoo5b@gmail.com>
Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>
Signed-off-by: Ohhoon Kwon <ohkwon1043@gmail.com>
---
 mm/slab_common.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6ee64d6208b3..a959d247c27b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -849,6 +849,8 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 			return;
 		}
 		flags |= SLAB_ACCOUNT;
+	} else if (IS_ENABLED(CONFIG_ZONE_DMA) && (type == KMALLOC_DMA)) {
+		flags |= SLAB_CACHE_DMA;
 	}
 
 	kmalloc_caches[type][idx] = create_kmalloc_cache(
@@ -877,7 +879,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	/*
 	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
 	 */
-	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
+	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
 		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
 			if (!kmalloc_caches[type][i])
 				new_kmalloc_cache(i, type, flags);
@@ -898,20 +900,6 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 
 	/* Kmalloc array is now usable */
 	slab_state = UP;
-
-#ifdef CONFIG_ZONE_DMA
-	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
-		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
-
-		if (s) {
-			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
-				kmalloc_info[i].name[KMALLOC_DMA],
-				kmalloc_info[i].size,
-				SLAB_CACHE_DMA | flags, 0,
-				kmalloc_info[i].size);
-		}
-	}
-#endif
 }
 #endif /* !CONFIG_SLOB */
 
-- 
2.25.1

