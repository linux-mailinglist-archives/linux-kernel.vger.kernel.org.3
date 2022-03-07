Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22944CF2C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiCGHmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbiCGHmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:42:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F9A3968C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:41:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso13346676pjo.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 23:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZGMJZ/gEuZAOoC4B+YmBrsXSs5tkxREQEs5olVeuJaw=;
        b=eNjzzbpeQLIHlMcaIfbd03vqkymRW54NmATbFQGI0ZOTyDPJdiACVVdKNEi1YC2iBx
         Kos1SPh67kgKR1PTCYPNoIpha5uq8aC0hWlgiDLlJRj5G3fj8thV6sgleQRaXU2y+fkg
         xlTUb6Se1WzzCia6dF+zHVlk15DzrQ85QqhH3edD/tb3yg/J12FPzt/cx9lpC/H57CjS
         y4jrpgwed4+dyGsIc35Soi6JEBEdBlxNF1sx9pImqtJnr6Sr3ug99Wj3HMPOmy8pVAzs
         pVYUS496lotEZ2NIqOl7SJivDgCUqAKPU4+N97Jrsfv4GaAgErxfDWt7yBp86Qztrl4k
         vNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGMJZ/gEuZAOoC4B+YmBrsXSs5tkxREQEs5olVeuJaw=;
        b=UzIwL7E4kdhwtQ7KB8k4cOXPDPYXs/MeaVjtDCVtCTbcUL3q70zZJb98cOf3vNWwUm
         p4P6q0CDGeZdR2/lq4kLZ00apC5Eo9ya28ZdrvG8RM3Al8ys9DynHZLNVgEY44cbTVCS
         71u6tl69BSwi2rtxeMFXUMcVmnAMlErosWTnGmulCIX8yuNm796DXUuVyvZ1eUoqjGh4
         pb/ojWX3LYeONyJzJn27DNaI5JCyQvsDSMMXrWJy16H2efViUXkft5c/zh6ISBqldZd/
         BDZI8EUXFvnxC3QzKBa4/S+oFiJQk6CD00gFqi+bDcIIoB97so7OsQoYUixRQTs0VkzB
         44cg==
X-Gm-Message-State: AOAM530jpVbIB6jPiW+5Kz2/MjuW9Z1vBEF6zCeb0iI1aGQKGfs83GGd
        kIuFNRjcQMyyduCrKjG1sDA=
X-Google-Smtp-Source: ABdhPJwaQxVqrVx8gsxT5/Suk/f0ODcodwq9e9CauZGzxkmOIohCLXMIb+Gr/YK3xnaDruiSupmM8A==
X-Received: by 2002:a17:90b:3e88:b0:1bf:3bd0:4b5f with SMTP id rj8-20020a17090b3e8800b001bf3bd04b5fmr11096426pjb.106.1646638881181;
        Sun, 06 Mar 2022 23:41:21 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id p10-20020a637f4a000000b00373a2760775sm10878743pgn.2.2022.03.06.23.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 23:41:20 -0800 (PST)
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
Subject: [PATCH v3 2/2] mm/slub: refactor deactivate_slab()
Date:   Mon,  7 Mar 2022 07:40:56 +0000
Message-Id: <20220307074057.902222-3-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220307074057.902222-1-42.hyeyoo@gmail.com>
References: <20220307074057.902222-1-42.hyeyoo@gmail.com>
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
  succeed.

  count deactivating full slabs even if debugging flag is not set. ]

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 91 +++++++++++++++++++++++--------------------------------
 1 file changed, 38 insertions(+), 53 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1ce09b0347ad..f0cb9d0443ac 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2348,10 +2348,10 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
 static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 			    void *freelist)
 {
-	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE };
+	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE, M_FULL_NOLIST };
 	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
-	int lock = 0, free_delta = 0;
-	enum slab_modes l = M_NONE, m = M_NONE;
+	int free_delta = 0;
+	enum slab_modes mode = M_NONE;
 	void *nextfree, *freelist_iter, *freelist_tail;
 	int tail = DEACTIVATE_TO_HEAD;
 	unsigned long flags = 0;
@@ -2393,14 +2393,10 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
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
+	 * when it succeed. If there is mismatch then the slab is not
+	 * unfrozen and number of objects in the slab may have changed.
+	 * Then release lock and retry cmpxchg again.
 	 */
 redo:
 
@@ -2420,61 +2416,50 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
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
-	}
-
-	if (l != m) {
-		if (l == M_PARTIAL)
-			remove_partial(n, slab);
-		else if (l == M_FULL)
-			remove_full(s, n, slab);
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
+	} else
+		mode = M_FULL_NOLIST;
 
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
-		stat(s, DEACTIVATE_FULL);
-	else if (m == M_FREE) {
+	} else if (mode == M_FREE) {
 		stat(s, DEACTIVATE_EMPTY);
 		discard_slab(s, slab);
 		stat(s, FREE_SLAB);
-	}
+	} else if (mode == M_FULL) {
+		add_full(s, n, slab);
+		spin_unlock_irqrestore(&n->list_lock, flags);
+		stat(s, DEACTIVATE_FULL);
+	} else if (mode == M_FULL_NOLIST)
+		stat(s, DEACTIVATE_FULL);
 }
 
 #ifdef CONFIG_SLUB_CPU_PARTIAL
-- 
2.33.1

