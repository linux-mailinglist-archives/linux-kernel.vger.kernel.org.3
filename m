Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F244CCDEE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiCDGgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbiCDGgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:36:19 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C124B18F226
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:34:55 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so546029pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 22:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PgzWIJiGbElIzAA/+g3O4R+XIWRWlKNYEXwjILpxSlg=;
        b=VcsP531XOAZHoSzYutr+YrhPB/02f1REI7a2paVkswi+VQ1RJWPGg8afSzCgogHzyW
         dOUmDbKrKlQ2pIGPipEijTjuCJ2N6uNcjHbyMswPnO5gSGm6KKC8lgnMd5CDOze45fm6
         ox2otFm8rAec4bBP8ZSzRbgS3yv+isnJSeAwbZSwGe0Xkpa/AIWIQs8BoVspdQDH/ejc
         RRFaT/TeqUqitkGA1WFWDZ75k4/o1UNUPoYyOumZB47EYuTWitcDPlm20xlJHkYfJCpF
         UAvLaQjJ1EFDEDIzDPfSx00I4XvsOPzMJ4rQuu9LeeLw8WyY2JgBU6nlJxw2wLfrXsCY
         DdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PgzWIJiGbElIzAA/+g3O4R+XIWRWlKNYEXwjILpxSlg=;
        b=Xj7FTaJC07cVddU5dswXuBgerXmqWRnKSAf2GlJzBmknMC0pYEaMRyr70mcvWW/QeP
         zoYhszVC/fs7221dw5xpU+JXcqCaiF4HfgQG5AQe4nsGrcfB0giivGpgjX8gADjj6ldf
         G3VTHgGBqgGHTCE8mVaoQGvPmwS1tgAV9BhfHZDetR2fIsvqmCWTHDQ/B8oYbrd3H6Do
         rneuaxqdgPQX75dvMtg3QvahHAVFGfDQvs82LZIuZ3riC+w1fRNy+m+4C7gcV6PyDBjs
         WcSBJIGMdFJJhkVzS54TfTa4T3/9naXm/Q9Ax0cddT3/HdBPMDL+flyANGJTSRw+xC5s
         3IHQ==
X-Gm-Message-State: AOAM531mjlqVwQaCnvHDUj9RK+snT5bPzmAk/VMyb+aE3qzdF0pM40Iy
        To6SAi2TD269eFQll8eObeo=
X-Google-Smtp-Source: ABdhPJxUr2XDiJRBOKg+kXq0iUgKNnV8N4aWOKmy0bwGTHBAdBDB2wi3hQmPcbrds4di6UaI00Dbuw==
X-Received: by 2002:a17:902:c401:b0:14f:b686:e6ff with SMTP id k1-20020a170902c40100b0014fb686e6ffmr15079443plk.45.1646375695469;
        Thu, 03 Mar 2022 22:34:55 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b004e0f420dd90sm4900007pfu.40.2022.03.03.22.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 22:34:55 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com
Subject: [PATCH v2 5/5] mm/slub: refactor deactivate_slab()
Date:   Fri,  4 Mar 2022 06:34:27 +0000
Message-Id: <20220304063427.372145-6-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220304063427.372145-1-42.hyeyoo@gmail.com>
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
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

Simplify deactivate_slab() by unlocking n->list_lock and retrying
cmpxchg_double() when cmpxchg_double() fails, and perform
add_{partial,full} only when it succeed.

Releasing and taking n->list_lock again here is not harmful as SLUB
avoids deactivating slabs as much as possible.

[ vbabka@suse.cz: perform add_{partial,full} when cmpxchg_double()
  succeed. ]

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 81 ++++++++++++++++++++++---------------------------------
 1 file changed, 32 insertions(+), 49 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f9ae983a3dc6..c1a693ec5874 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2344,8 +2344,8 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 {
 	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE };
 	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
-	int lock = 0, free_delta = 0;
-	enum slab_modes l = M_NONE, m = M_NONE;
+	int free_delta = 0;
+	enum slab_modes mode = M_NONE;
 	void *nextfree, *freelist_iter, *freelist_tail;
 	int tail = DEACTIVATE_TO_HEAD;
 	unsigned long flags = 0;
@@ -2387,14 +2387,10 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 	 * Ensure that the slab is unfrozen while the list presence
 	 * reflects the actual number of objects during unfreeze.
 	 *
-	 * We setup the list membership and then perform a cmpxchg
-	 * with the count. If there is a mismatch then the slab
-	 * is not unfrozen but the slab is on the wrong list.
-	 *
-	 * Then we restart the process which may have to remove
-	 * the slab from the list that we just put it on again
-	 * because the number of objects in the slab may have
-	 * changed.
+	 * We first perform cmpxchg holding lock and insert to list
+	 * when it succeed. If there is mismatch then slub is not
+	 * unfrozen and number of objects in the slab may have changed.
+	 * Then release lock and retry cmpxchg again.
 	 */
 redo:
 
@@ -2414,57 +2410,44 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 	new.frozen = 0;
 
 	if (!new.inuse && n->nr_partial >= s->min_partial)
-		m = M_FREE;
+		mode = M_FREE;
 	else if (new.freelist) {
-		m = M_PARTIAL;
-		if (!lock) {
-			lock = 1;
-			/*
-			 * Taking the spinlock removes the possibility that
-			 * acquire_slab() will see a slab that is frozen
-			 */
-			spin_lock_irqsave(&n->list_lock, flags);
-		}
-	} else {
-		m = M_FULL;
-		if (kmem_cache_debug_flags(s, SLAB_STORE_USER) && !lock) {
-			lock = 1;
-			/*
-			 * This also ensures that the scanning of full
-			 * slabs from diagnostic functions will not see
-			 * any frozen slabs.
-			 */
-			spin_lock_irqsave(&n->list_lock, flags);
-		}
+		mode = M_PARTIAL;
+		/*
+		 * Taking the spinlock removes the possibility that
+		 * acquire_slab() will see a slab that is frozen
+		 */
+		spin_lock_irqsave(&n->list_lock, flags);
+	} else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
+		mode = M_FULL;
+		/*
+		 * This also ensures that the scanning of full
+		 * slabs from diagnostic functions will not see
+		 * any frozen slabs.
+		 */
+		spin_lock_irqsave(&n->list_lock, flags);
 	}
 
-	if (l != m) {
-		if (l == M_PARTIAL)
-			remove_partial(n, slab);
-		else if (l == M_FULL)
-			remove_full(s, n, slab);
-
-		if (m == M_PARTIAL)
-			add_partial(n, slab, tail);
-		else if (m == M_FULL)
-			add_full(s, n, slab);
-	}
 
-	l = m;
 	if (!cmpxchg_double_slab(s, slab,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
-				"unfreezing slab"))
+				"unfreezing slab")) {
+		if (mode == M_PARTIAL || mode == M_FULL)
+			spin_unlock_irqrestore(&n->list_lock, flags);
 		goto redo;
+	}
 
-	if (lock)
-		spin_unlock_irqrestore(&n->list_lock, flags);
 
-	if (m == M_PARTIAL)
+	if (mode == M_PARTIAL) {
+		add_partial(n, slab, tail);
+		spin_unlock_irqrestore(&n->list_lock, flags);
 		stat(s, tail);
-	else if (m == M_FULL)
+	} else if (mode == M_FULL) {
+		add_full(s, n, slab);
+		spin_unlock_irqrestore(&n->list_lock, flags);
 		stat(s, DEACTIVATE_FULL);
-	else if (m == M_FREE) {
+	} else if (mode == M_FREE) {
 		stat(s, DEACTIVATE_EMPTY);
 		discard_slab(s, slab);
 		stat(s, FREE_SLAB);
-- 
2.33.1

