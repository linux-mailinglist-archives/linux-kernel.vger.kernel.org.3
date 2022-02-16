Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A06D4B8724
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiBPLw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:52:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiBPLwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:52:54 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DF018404B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:37 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id om7so2161633pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=165dLhQ7hyh1L/DjdfIFCITpDk7lPjHyUo7YV5H1F1Y=;
        b=yS5Od63QJjgrf2sJM68+B+Eq/OWFlIDeRLQ9OZM5Dr7wRL1cF4uw+9WbmrG0CDmp4k
         HpKT78ZM9yqU0d1nofwrowKJGJUI99ewSbmK2iODzD3qk9DsIpkJXDnMAiJ+QnsgXj44
         BFGAIxgqj0DpYxrj3e7+SLoTV3VvSMBxx0v2pBNZaEP4yxWAv6il6R2abz4ZU2f6Ek4b
         dX1cXNZjDFgo0TXtQiwZeTNNF2sJSRr1Z1Dy7+2pUui2jZxsX1F+XcRd5kjthUVup2jm
         oyIyXbTn5pyP2r/LxGjk6PRqXUCwx5c07AKz9lv2Oqmo1oV10fS/02XtXG1p6U7zLQmE
         N5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=165dLhQ7hyh1L/DjdfIFCITpDk7lPjHyUo7YV5H1F1Y=;
        b=8OnSSKNAT5yar3UGeb7KXgzyZcXlatHcF+LVRGlUdET30pbdh8sV24XOK2j5ZVusPJ
         eC7UXDRQz1NlEAo91Ij90Iaozqh0SozvuEgJK4j5aWx0vjZGoA6izsGJR7wVyA5Hwa/V
         +aNLOjQlCTk+6KkY4z0EIi9i/N9xYfcxTvoObUmdtZsDuIQUxhZv75AFd3fIsgxXE5jb
         n+fcuPmKpsnJR9qtRCxC6JqUYIhYW4KZSr1JfCtMzGSVhvqFmQ7fisNwAFKTmYRp3+cP
         fU7EPzwucP9m5B2DhvuqWp5p6BB6eRX/ks5J0qP9sCwCTAZxZmsLHBJ2keQL3Pg4/t20
         htmQ==
X-Gm-Message-State: AOAM532XHLO0LCgTykrOBqDIVSJwnYEXtFS9SsNb3J611fsZ0wPfA7QX
        e/edDzZckSZNwZ0t4iNxihyg4A==
X-Google-Smtp-Source: ABdhPJwAJOwLAtA5/2JhCA4A3zJUOykMJidUQdD198hj5IxFHa45Xeu8iRkX8Z8y9nx9M87a9h0OJQ==
X-Received: by 2002:a17:902:ab52:b0:14d:7ce1:8d66 with SMTP id ij18-20020a170902ab5200b0014d7ce18d66mr2249555plb.88.1645012357348;
        Wed, 16 Feb 2022 03:52:37 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id m16sm14790221pfc.156.2022.02.16.03.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:52:37 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 06/12] mm: thp: make split queue lock safe when LRU pages are reparented
Date:   Wed, 16 Feb 2022 19:51:26 +0800
Message-Id: <20220216115132.52602-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220216115132.52602-1-songmuchun@bytedance.com>
References: <20220216115132.52602-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the lruvec lock, we use the same approach to make the split
queue lock safe when LRU pages are reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a227731988b3..b8c6e766c91c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -535,9 +535,22 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
 {
 	struct deferred_split *queue;
 
+	rcu_read_lock();
+retry:
 	queue = folio_split_queue(folio);
 	spin_lock(&queue->split_queue_lock);
 
+	if (unlikely(split_queue_memcg(queue) != folio_memcg(folio))) {
+		spin_unlock(&queue->split_queue_lock);
+		goto retry;
+	}
+
+	/*
+	 * Preemption is disabled in the internal of spin_lock, which can serve
+	 * as RCU read-side critical sections.
+	 */
+	rcu_read_unlock();
+
 	return queue;
 }
 
@@ -546,9 +559,19 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
 {
 	struct deferred_split *queue;
 
+	rcu_read_lock();
+retry:
 	queue = folio_split_queue(folio);
 	spin_lock_irqsave(&queue->split_queue_lock, *flags);
 
+	if (unlikely(split_queue_memcg(queue) != folio_memcg(folio))) {
+		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
+		goto retry;
+	}
+
+	/* See the comments in folio_split_queue_lock(). */
+	rcu_read_unlock();
+
 	return queue;
 }
 
-- 
2.11.0

