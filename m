Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35958596CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiHQKTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbiHQKTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:19:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAB36CD2B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a8so12074744pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ga89EBm/M0pSIGR8VO7j68eF/ZO7QJRQA6L4btLKSFg=;
        b=QvUbGhywEPeBhwJmjbmSzIFybywy0vyCr2SJpbyRtQyIAz/VHy0E9scAmI4tj9TDt1
         7CCk4lbN/5d6jWw7cwcGb8PBl3ye5q15nhrzA5sqxvDUGMSFqVg7NYHiX3XBRAni81eB
         auRwaRmIuJf7ov23ZgTvUnKbzv3DtzTYDWOO4ADxnf805wypIVs5TPMc3HWNxAfQge4u
         Tg6TyCAaDMi3EWtSGO6vJy/T3OsHv9bFnT5fSSzBnJsGjmYouddxdZ11fsxvo7fUAqG1
         9FcIao+/tb8ciwjz9SJKcMtwT9GpZ1eH3PJdTUfkmGedsuJqSgTl3kHnOfOaXBbqmEkk
         cGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ga89EBm/M0pSIGR8VO7j68eF/ZO7QJRQA6L4btLKSFg=;
        b=v40tC+QLEL/+myw/lCuvYQRXb+bTtpHn2FO5y+QIjuEstVu5zU5AFOXDMfjzJNFlyK
         /YLgb1aCpJPhnhvfA8lScqPTU7hjQL0h8mafjziRxUReltG2oCkc8yLW/F2yxz1pAK5G
         78iM+VlG+tnA4Sg15keK+euY2uh/HWWxSbKGMVw/3PrI+ipI+vckgyjnYx5Sijnvhnfl
         rPGigyKF1hPRtEkSKMG30ZW/5D9R4oOC2f9C21iYjFDl6sn5BtCPjM74iSNxlh+RrGhn
         LAlR4odo3ue39Sx9N3Ptd7PdQ1qT4vOSIwufrGsU40XGE4pX2jxGkKw2hR+VasChQGyQ
         mDuQ==
X-Gm-Message-State: ACgBeo3dhZ/CiGSP2TiqamU2EqVcB5Fjs7GujeyeTh/s9APoIv+plWD8
        FaiATimG0SK6nfNPVEPFWHo=
X-Google-Smtp-Source: AA6agR7bPV9zEhLcxPDQaHMgtadEN07BrNJzVtA2QjN0NjCwWz3hrowIypljfqszymfPovsGjThBlg==
X-Received: by 2002:a17:902:9307:b0:170:d739:a3cf with SMTP id bc7-20020a170902930700b00170d739a3cfmr26025458plb.127.1660731540819;
        Wed, 17 Aug 2022 03:19:00 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:18:59 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/17] mm/slab_common: cleanup kmalloc_track_caller()
Date:   Wed, 17 Aug 2022 19:18:13 +0900
Message-Id: <20220817101826.236819-5-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817101826.236819-1-42.hyeyoo@gmail.com>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make kmalloc_track_caller() wrapper of kmalloc_node_track_caller().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 17 ++++++++---------
 mm/slab.c            |  6 ------
 mm/slob.c            |  6 ------
 mm/slub.c            | 22 ----------------------
 4 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 4754c834b0e3..a0e57df3d5a4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -651,6 +651,12 @@ static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flag
 	return kmalloc_array(n, size, flags | __GFP_ZERO);
 }
 
+void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
+				  unsigned long caller) __alloc_size(1);
+#define kmalloc_node_track_caller(size, flags, node) \
+	__kmalloc_node_track_caller(size, flags, node, \
+				    _RET_IP_)
+
 /*
  * kmalloc_track_caller is a special version of kmalloc that records the
  * calling function of the routine calling it for slab leak tracking instead
@@ -659,9 +665,9 @@ static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flag
  * allocator where we care about the real place the memory allocation
  * request comes from.
  */
-extern void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller);
 #define kmalloc_track_caller(size, flags) \
-	__kmalloc_track_caller(size, flags, _RET_IP_)
+	__kmalloc_node_track_caller(size, flags, \
+				    NUMA_NO_NODE, _RET_IP_)
 
 static inline __alloc_size(1, 2) void *kmalloc_array_node(size_t n, size_t size, gfp_t flags,
 							  int node)
@@ -680,13 +686,6 @@ static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t
 	return kmalloc_array_node(n, size, flags | __GFP_ZERO, node);
 }
 
-
-extern void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
-					 unsigned long caller) __alloc_size(1);
-#define kmalloc_node_track_caller(size, flags, node) \
-	__kmalloc_node_track_caller(size, flags, node, \
-			_RET_IP_)
-
 /*
  * Shortcuts
  */
diff --git a/mm/slab.c b/mm/slab.c
index 0acd65358c83..611e630ff860 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3665,12 +3665,6 @@ void *__kmalloc(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(__kmalloc);
 
-void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller)
-{
-	return __do_kmalloc(size, flags, caller);
-}
-EXPORT_SYMBOL(__kmalloc_track_caller);
-
 /**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
diff --git a/mm/slob.c b/mm/slob.c
index 74d850967213..96b08acd72ce 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -530,12 +530,6 @@ void *__kmalloc(size_t size, gfp_t gfp)
 }
 EXPORT_SYMBOL(__kmalloc);
 
-void *__kmalloc_track_caller(size_t size, gfp_t gfp, unsigned long caller)
-{
-	return __do_kmalloc_node(size, gfp, NUMA_NO_NODE, caller);
-}
-EXPORT_SYMBOL(__kmalloc_track_caller);
-
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfp,
 					int node, unsigned long caller)
 {
diff --git a/mm/slub.c b/mm/slub.c
index b29b3c9d3175..c82a4062f730 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4904,28 +4904,6 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	return 0;
 }
 
-void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
-{
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large(size, gfpflags);
-
-	s = kmalloc_slab(size, gfpflags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = slab_alloc(s, NULL, gfpflags, caller, size);
-
-	/* Honor the call site pointer we received. */
-	trace_kmalloc(caller, ret, s, size, s->size, gfpflags);
-
-	return ret;
-}
-EXPORT_SYMBOL(__kmalloc_track_caller);
-
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 					int node, unsigned long caller)
 {
-- 
2.32.0

