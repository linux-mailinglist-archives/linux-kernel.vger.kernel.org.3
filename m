Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596354FB4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbiDKH2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbiDKH2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:28:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BD03A71F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:25:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s10so5589358plg.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bh2DzyN58v9sjiKDaPQqaLzWWkYE7+ay/uZ6IfCvCxQ=;
        b=nOWJnwIlswvCbzCOlCXxNOcBrWbKLNT64P909otnZtJ7LJ6EhnAKunQIn0+eSfZNAu
         7dRlwFzq84Fi4wbJVVKUoUpvUZjsUXD5Oc2xo5/58d/2TcSzuVHC4FyORaGXmYqZrRBP
         3e1CTcRSFBQA5TpR0fOe64ny9MRHY+oXpBdxSL0t4A+DSCFczdjwNKRWTEyKNOKem+Ti
         zXqMn1CKHCa02LCXvJNGsDSDkk/QPottZWg+RbkZEBj7r0//A8RnqoicDU2FWgNCBxEi
         4J2amMOV5+XxrwhITqROjMPz9HvjBlMNHMNQZnLOpQyvG958bNnQaSMMJbovG97IpMXE
         WyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bh2DzyN58v9sjiKDaPQqaLzWWkYE7+ay/uZ6IfCvCxQ=;
        b=xIHZP3n3M3t3Aa7JL2OglcTyEsURfMa7DTbK9pV06L6VO48Dk9eUW3xVvkTpewXcTd
         2hk1axTjmF+caoVsKPHPR0gg69eEJ7NQniFI23293QZetFMfNNMqQShkSSSPne5YB6YU
         RX/DdndTvaOlBvOuPkiOFiIsBD+1Bx3kJKsAuZ0fJonppOMByhw0YS27LVUwTGAx9sqS
         GuzU8HI2vw2DzAfqgGseD5b36Xomy/OKLKsPoSIsjjjR707diPbJdtv4M9/wu/pFXhRh
         GTjTHilV9TL931OIql7ckx5o+4UWPguhVVCWl8NSHH9oFpDcuLwsaqevSsaJEsmt9NKG
         QaOQ==
X-Gm-Message-State: AOAM532EF4RmYTSTfgo+psKlRTvKXD+zP+347Gk2JlPdOftndCQTMOI7
        XXyA4YpVrRBv1cdwlwZj+Q==
X-Google-Smtp-Source: ABdhPJzd2DwMb8CiNDtt27JzEGa23aU8WaY1BEHvp7t0AkiNpPxQqrjGQMeKP/+7CEwBU/KkipvddA==
X-Received: by 2002:a17:90a:da02:b0:1bf:3919:f2a with SMTP id e2-20020a17090ada0200b001bf39190f2amr35483524pjv.208.1649661941617;
        Mon, 11 Apr 2022 00:25:41 -0700 (PDT)
Received: from localhost.localdomain ([121.165.123.189])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm33708527pfv.123.2022.04.11.00.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 00:25:41 -0700 (PDT)
From:   JaeSang Yoo <js.yoo.5b@gmail.com>
X-Google-Original-From: JaeSang Yoo <jsyoo5b@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Ohhoon Kwon <ohkwon1043@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>,
        Christoph Lameter <clameter@sgi.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: remove unused parameter in setup_object*()
Date:   Mon, 11 Apr 2022 16:25:34 +0900
Message-Id: <20220411072534.3372768-1-jsyoo5b@gmail.com>
X-Mailer: git-send-email 2.25.1
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

setup_object_debug() and setup_object() has unused parameter, "struct
slab *slab". Remove it.

By the commit 3ec0974210fe ("SLUB: Simplify debug code"),
setup_object_debug() were introduced to refactor previous code blocks
in the setup_object(). Previous code used SlabDebug() to init_object()
and init_tracking(). As the SlabDebug() takes "struct page *page" as
argument, the setup_object_debug() checks flag of "struct kmem_cache *s"
which doesn't require "struct page *page".
As the struct page were changed into struct slab by commit bb192ed9aa719
("mm/slub: Convert most struct page to struct slab by spatch"), but it's
still unused parameter.

Suggested-by: Ohhoon Kwon <ohkwon1043@gmail.com>
Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>
---
 mm/slub.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9fe000fd19ca..273bbba74ca1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1264,8 +1264,7 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
 }
 
 /* Object debug checks for alloc/free paths */
-static void setup_object_debug(struct kmem_cache *s, struct slab *slab,
-								void *object)
+static void setup_object_debug(struct kmem_cache *s, void *object)
 {
 	if (!kmem_cache_debug_flags(s, SLAB_STORE_USER|SLAB_RED_ZONE|__OBJECT_POISON))
 		return;
@@ -1631,8 +1630,7 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 	return flags | slub_debug_local;
 }
 #else /* !CONFIG_SLUB_DEBUG */
-static inline void setup_object_debug(struct kmem_cache *s,
-			struct slab *slab, void *object) {}
+static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
 static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 
@@ -1775,10 +1773,9 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 	return *head != NULL;
 }
 
-static void *setup_object(struct kmem_cache *s, struct slab *slab,
-				void *object)
+static void *setup_object(struct kmem_cache *s, void *object)
 {
-	setup_object_debug(s, slab, object);
+	setup_object_debug(s, object);
 	object = kasan_init_slab_obj(s, object);
 	if (unlikely(s->ctor)) {
 		kasan_unpoison_object_data(s, object);
@@ -1897,13 +1894,13 @@ static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 	/* First entry is used as the base of the freelist */
 	cur = next_freelist_entry(s, slab, &pos, start, page_limit,
 				freelist_count);
-	cur = setup_object(s, slab, cur);
+	cur = setup_object(s, cur);
 	slab->freelist = cur;
 
 	for (idx = 1; idx < slab->objects; idx++) {
 		next = next_freelist_entry(s, slab, &pos, start, page_limit,
 			freelist_count);
-		next = setup_object(s, slab, next);
+		next = setup_object(s, next);
 		set_freepointer(s, cur, next);
 		cur = next;
 	}
@@ -1974,11 +1971,11 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 	if (!shuffle) {
 		start = fixup_red_left(s, start);
-		start = setup_object(s, slab, start);
+		start = setup_object(s, start);
 		slab->freelist = start;
 		for (idx = 0, p = start; idx < slab->objects - 1; idx++) {
 			next = p + s->size;
-			next = setup_object(s, slab, next);
+			next = setup_object(s, next);
 			set_freepointer(s, p, next);
 			p = next;
 		}
-- 
2.25.1

