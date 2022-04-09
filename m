Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF4D4FA69E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbiDIJzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbiDIJzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:55:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2FE3BF93
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 02:53:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b2-20020a17090a010200b001cb0c78db57so8702591pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LiEuvQ5837dDmV9cuDnpaWOy1YwYONvco8pKO+KyVCQ=;
        b=isJJzeLplSA+L7hyoKEBdm+ep2qRvqauWtx77pn/yqE45M/5afiG7DdAfeE1wXvkP0
         bqrXC4Sz27Kyn90kCkEPvfAaHjfkf6rF6RofPrjnAE83r9vryvcro6m7EJeZb0q8Ib5B
         E+peQkyTLCyrxiNYTPyy0Aj5Zd3wQBE1aSt6ckMAe605OvUrV7MEcZW2HncYJF7EsK5e
         E8HEpKFsBfGqRgxyPaxQm0LCo3S2+Mm1GmVeOtFrmxUxFtpaeIyvjeKCzBxIGgXwQk1A
         Q3LEQ/FSyxr/i9Dru/Qikse5I4taMGVNCgIuxh82fqAo92fPkWru4H55jeVUOxpTyiGe
         9KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LiEuvQ5837dDmV9cuDnpaWOy1YwYONvco8pKO+KyVCQ=;
        b=pvoVTn10t8pc8FerD+pN2OwtDjWXewzaj4V7njb1BsjqLF5tvHMJv+axT6iBBTfROC
         IPaaQlzCDZDdJgxn8sPwvOI2Yy+viD5EPI/f/YCUzJZ4LZDZKqMMVjaQRJGSS9koPgyC
         DuUJ2PBisg70VvGHW1v8WtIZYDDGxHE1NP3pdOcu4MTfw62DQh5JS6yfVgqV8Rw1JE4v
         6+kGamr5LqMKb2EYd9EFuvNtc6SYex2ET+zhxrBFC30QfW5nMFQeVnCL1YOQ4qE/qJDi
         ucG3wQCjfDnhro9bdcisgHnmWPoFvTfNOtKaK07o2aSF1AOw5TBwFGMOfcyX4XHXuTRO
         4Q5Q==
X-Gm-Message-State: AOAM530rnWdDLU1WT1y/WSYf+O4agE1o2Y/0MlDMxtcUWUfK7TdPrOZ+
        sPzgQ0KshFTEmR/x5hziM94=
X-Google-Smtp-Source: ABdhPJyfohctX+WKiL65gQ2lsudjB43W0uSz+T6jsLtKeBg9FgIlPUxoPcOJKhAEt83x8Fidvj2d2w==
X-Received: by 2002:a17:902:8ec8:b0:154:5ecb:eb05 with SMTP id x8-20020a1709028ec800b001545ecbeb05mr23225582plo.56.1649497993193;
        Sat, 09 Apr 2022 02:53:13 -0700 (PDT)
Received: from localhost.localdomain ([210.100.217.177])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7982d000000b004fb199b9c7dsm29684865pfl.119.2022.04.09.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:53:12 -0700 (PDT)
From:   Ohhoon Kwon <ohkwon1043@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiyoup Kim <lakroforce@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>
Subject: [PATCH] mm/slab_common: move dma-kmalloc caches creation into new_kmalloc_cache()
Date:   Sat,  9 Apr 2022 18:53:05 +0900
Message-Id: <20220409095305.586412-1-ohkwon1043@gmail.com>
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
 mm/slab_common.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6ee64d6208b3..eb95512de983 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -849,6 +849,10 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 			return;
 		}
 		flags |= SLAB_ACCOUNT;
+#ifdef CONFIG_ZONE_DMA
+	} else if (type == KMALLOC_DMA) {
+		flags |= SLAB_CACHE_DMA;
+#endif
 	}
 
 	kmalloc_caches[type][idx] = create_kmalloc_cache(
@@ -877,7 +881,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	/*
 	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
 	 */
-	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
+	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
 		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
 			if (!kmalloc_caches[type][i])
 				new_kmalloc_cache(i, type, flags);
@@ -898,20 +902,6 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 
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

