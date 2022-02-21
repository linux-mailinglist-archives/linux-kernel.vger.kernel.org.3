Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABD14BDF6A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356026AbiBULSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:18:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355776AbiBULPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:22 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D992CDC0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:54:08 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z2so3934611plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNqSGZPctSWXqZ6gYN0FXGhiJj1MEcwtFP+jmJt2lAM=;
        b=RFTPXk5DrwGPw8J5yfqw2l+chmPeFSAdBQcKMCI2hS+QHbqTp47fbGdwOgCxkQjL/5
         s4KOqNYdUwQnAXGGSon/S4gwtsNgaUQm+hPClmpa6dsyOiUsk4bIbjjXDMN/Mr2LxJbF
         8iglITyjVsZYvBOGkg8UpLRM/fXaOMnQJleiLza6uMPjkMb/zZEeyzuW3RjXegMQEwQW
         5MfkgPkZqcSZ8OXKsXauuKkYUDFECPq7K/51WtVTzGXzDDDE5FHKMFo7H6Q04KmMXAxr
         TmgkL1ED1/zGJod/kfDAgFV7FFH/oMNp1EaundBNuAFgPhyWacQ4ZfNwxfK6yHdTy9nY
         vRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNqSGZPctSWXqZ6gYN0FXGhiJj1MEcwtFP+jmJt2lAM=;
        b=LMswQwoPlgv9XX47tbaBVlQkjqT6Q+yHKs8mZvK2QdKSd2aAJecqUK1BCNlaNEje9C
         he860hvRcKx/tw3Y+yKYlD2AggXayIKtuozmWzisf0tNdT36499d5R7S3D8Boeg0aQmD
         MDkY7UBKK3WuT8NRIrd9maYGRfdnUl9vQvqiqNrm7gJBk1oPjK0KkF5roAcTWWu/H6Tq
         I/hNgmS6+/9l/Gq2Ato1yPI+m3TwBr9PQidB0VNV5+PcAWlkSZ/BTzvvWS85hl0Yre4V
         Slm2/k1eSBHEZbfW1LUkMkvk94pXUl6qX3MprbbZt99u1fiVAG6eFTik8go0HhgpECgB
         J5Yg==
X-Gm-Message-State: AOAM533FhmiK8Q6p7y8JNVZHAvSTas7FukXjL/t0DSWMagB8BN01aEe8
        EsIC4L2pmVvo/jt7Wu3cRxs=
X-Google-Smtp-Source: ABdhPJywNTHU63XkzHt51xLMmCuOt0KCbfUmRMm0QdINnoAQ9l+TE+h6FliiSaxwldW7bQVaCkRlDQ==
X-Received: by 2002:a17:90a:8048:b0:1b9:55dd:b72d with SMTP id e8-20020a17090a804800b001b955ddb72dmr20733044pjw.90.1645440848421;
        Mon, 21 Feb 2022 02:54:08 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id u6sm2214725pfk.203.2022.02.21.02.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 02:54:08 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH 5/5] mm/slub: Refactor deactivate_slab()
Date:   Mon, 21 Feb 2022 10:53:36 +0000
Message-Id: <20220221105336.522086-6-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220221105336.522086-1-42.hyeyoo@gmail.com>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
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

Simply deactivate_slab() by removing variable 'lock' and replacing
'l' and 'm' with 'mode'. Instead, remove slab from list and unlock
n->list_lock when cmpxchg_double() fails, and then retry.

One slight functional change is releasing and taking n->list_lock again
when cmpxchg_double() fails. This is not harmful because SLUB avoids
deactivating slabs as much as possible.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 74 +++++++++++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a4964deccb61..2d0663befb9e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2350,8 +2350,8 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
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
@@ -2420,57 +2420,49 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
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
+		add_partial(n, slab, tail);
+	} else if (kmem_cache_debug_flags(s, SLAB_STORE_USER)) {
+		mode = M_FULL;
+		/*
+		 * This also ensures that the scanning of full
+		 * slabs from diagnostic functions will not see
+		 * any frozen slabs.
+		 */
+		spin_lock_irqsave(&n->list_lock, flags);
+		add_full(s, n, slab);
 	}
 
-	if (l != m) {
-		if (l == M_PARTIAL)
-			remove_partial(n, slab);
-		else if (l == M_FULL)
-			remove_full(s, n, slab);
 
-		if (m == M_PARTIAL)
-			add_partial(n, slab, tail);
-		else if (m == M_FULL)
-			add_full(s, n, slab);
-	}
-
-	l = m;
 	if (!cmpxchg_double_slab(s, slab,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
-				"unfreezing slab"))
+				"unfreezing slab")) {
+		if (mode == M_PARTIAL) {
+			remove_partial(n, slab);
+			spin_unlock_irqrestore(&n->list_lock, flags);
+		} else if (mode == M_FULL) {
+			remove_full(s, n, slab);
+			spin_unlock_irqrestore(&n->list_lock, flags);
+		}
 		goto redo;
+	}
 
-	if (lock)
-		spin_unlock_irqrestore(&n->list_lock, flags);
 
-	if (m == M_PARTIAL)
+	if (mode == M_PARTIAL) {
+		spin_unlock_irqrestore(&n->list_lock, flags);
 		stat(s, tail);
-	else if (m == M_FULL)
+	} else if (mode == M_FULL) {
+		spin_unlock_irqrestore(&n->list_lock, flags);
 		stat(s, DEACTIVATE_FULL);
-	else if (m == M_FREE) {
+	} else if (mode == M_FREE) {
 		stat(s, DEACTIVATE_EMPTY);
 		discard_slab(s, slab);
 		stat(s, FREE_SLAB);
-- 
2.33.1

