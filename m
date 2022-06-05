Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C0D53DC96
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbiFEPZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbiFEPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:25:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B654B2715E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 08:25:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id n28so15785753edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3oII5rEfZoXf7U4b6hs9rpi5sWM6BBnmpd30r2QEOU=;
        b=PyvPxjctikeWzSfNKXCBFIPiHQj342ETF+dWPSJtdTYhGlMch8kZDbkzZkAyX1rhHD
         vZ401ub/slIA5YG7R+7EGL6JtPXUmSKeBnMSlw5PZx16vAcARgASoY3pVP9iaOnNox3G
         5K+FGbP7qHXBGFM25b//KOjJyLZEDACKFxUT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3oII5rEfZoXf7U4b6hs9rpi5sWM6BBnmpd30r2QEOU=;
        b=HMLE7VRtnd/6YBDJeg1LnelMeUspdQWDLN31uPcbjByHnHdKRXCebLVppUOT+Zdp+5
         aiUr+o38SLmN8GU5ha4PEOFyrLJjNOkUuHFfQutZX62DtBKZb611o8RDHNDu8IvSGMKg
         r+JtuwXAx55AxjkpSCWvrRhtBauoR99lVTfGSK0Z2VNG0Zr7tzFn6CpoOPhsjCDWwA7J
         VgqlfNrg1o+sv8FBdQ6win5SstDiq6Y9dcZlkDOyMKCMEGaMTwT9vuUwvyo/gHu9PDWw
         KIoRVy2PzBVefC+s54nJSSwVzi1XVteSi7V9k7dX4o0iAeN/ya52BWcixjHtvHD/XKya
         LKKA==
X-Gm-Message-State: AOAM531ulFGqbxRhLzELJK9F0wv99FQ3J6rtwnsG//sNOaHeAaZrN3V/
        iYtO8PXG2VXoXyA6K9sdi09kKWP1qvUS/Q==
X-Google-Smtp-Source: ABdhPJzO8PurCrRxgpc214KmxgqXebuHnZN2GlgM5MuV0uMe12+HNCSkaguDfuGB/Kq9xPEFTfDOvw==
X-Received: by 2002:a05:6402:42d4:b0:416:5cac:a9a0 with SMTP id i20-20020a05640242d400b004165caca9a0mr21618319edc.86.1654442746342;
        Sun, 05 Jun 2022 08:25:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402125500b0042dddaa8af3sm7051499edw.37.2022.06.05.08.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 08:25:45 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org
Subject: [PATCH 2/3] mm/slab: delete cache_alloc_debugcheck_before()
Date:   Sun,  5 Jun 2022 17:25:38 +0200
Message-Id: <20220605152539.3196045-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220605152539.3196045-1-daniel.vetter@ffwll.ch>
References: <20220605152539.3196045-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It only does a might_sleep_if(GFP_RECLAIM) check, which is already
covered by the might_alloc() in slab_pre_alloc_hook(). And all callers
of cache_alloc_debugcheck_before() call that beforehand already.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org
---
 mm/slab.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index b04e40078bdf..75779ac5f5ba 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2973,12 +2973,6 @@ static void *cache_alloc_refill(struct kmem_cache *cachep, gfp_t flags)
 	return ac->entry[--ac->avail];
 }
 
-static inline void cache_alloc_debugcheck_before(struct kmem_cache *cachep,
-						gfp_t flags)
-{
-	might_sleep_if(gfpflags_allow_blocking(flags));
-}
-
 #if DEBUG
 static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
 				gfp_t flags, void *objp, unsigned long caller)
@@ -3219,7 +3213,6 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
 	if (unlikely(ptr))
 		goto out_hooks;
 
-	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
 
 	if (nodeid == NUMA_NO_NODE)
@@ -3304,7 +3297,6 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
 	if (unlikely(objp))
 		goto out;
 
-	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
 	objp = __do_cache_alloc(cachep, flags);
 	local_irq_restore(save_flags);
@@ -3541,8 +3533,6 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	if (!s)
 		return 0;
 
-	cache_alloc_debugcheck_before(s, flags);
-
 	local_irq_disable();
 	for (i = 0; i < size; i++) {
 		void *objp = kfence_alloc(s, s->object_size, flags) ?: __do_cache_alloc(s, flags);
-- 
2.36.0

