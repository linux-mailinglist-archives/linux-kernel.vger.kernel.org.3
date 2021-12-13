Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F41473267
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhLMQzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241144AbhLMQz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:55:29 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB57FC061751
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:55:28 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m24so11574704pls.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9BJLsBD6jksCciTZGdmyHq2qkXc8II2TIDnrT2cyiU=;
        b=aMeJCWUqgwB/GLx3pcZq15/jg3Lf0jRk7OuuhPO9oYgIGrUCzdzDWDiBYxt50oTRgp
         lbbDtY+a2UawTJJbEFKlulbVszT+RUps1lLnngd9tcyYvE8Dkmiws87N0n6kZN448/7h
         qSv2YLVDqKI+jtrAPrHfWpX6o6DwxlwmAD6o0pih9+sdUcqYmwYRTMYKyyhT5ZLZq3EH
         HUt2K2dIRxY4ECXtDfZVs9rsH0VANjkJ9+drGMABzJLc+1Un/5igcqH77/KFDnkVkYzy
         zfEj6ntvPNe7QoNPbpM+Bot/rKOqVoCp4EkHdsKBQCNCuSkGyOdLJmYN2i06IzAgdGC9
         831A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9BJLsBD6jksCciTZGdmyHq2qkXc8II2TIDnrT2cyiU=;
        b=LAdZHllwM3KK8KT87O3mbeXOgInqw2wezSmV3vzOqhSaDfRtCeIJQhYAP9h4TUspR1
         qpL00ndOAstbVfGXzDKz84np7Ptx3QyA9PbCcuOb9zEMv0qehDBvxSyL4x4pNdse7Nvk
         dUPrJDb29Y6KI7fZD9LE//hyJMIw+NtxhbbPnboicIYX1z+ZjeCN0wfzl1xG/8dZcQAf
         g9kxdRuiRGHcnDUVk2dUMBEfQPKJuhmTd51nyTAtQu0JY7EgVx5DAehte3sR5sEKIit+
         AstIdbFFcqxBpSWJxb9ZCMDu+Hs0PoWnTVqORRxTbENwqiJui3VUFfeSSBE77IBJavaT
         BdbQ==
X-Gm-Message-State: AOAM5327w/NVYcPqcZ2WMoI9N2Qth5mPTVhjfDzZpQAQht1HMUsaEA4K
        OvOL3YQbxs7SMy+YA/I4N7eLLA==
X-Google-Smtp-Source: ABdhPJziVVTUjDn5zuA9aWYbELyMi+wMe/H02qTNtNrf3sAI3hw7EJZk5HueFbWrEQJIHWfS3UhzsA==
X-Received: by 2002:a17:902:d88b:b0:142:8acf:615b with SMTP id b11-20020a170902d88b00b001428acf615bmr97819481plz.62.1639414528355;
        Mon, 13 Dec 2021 08:55:28 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n11sm10430992pgp.15.2021.12.13.08.55.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:55:28 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 08/17] xarray: use kmem_cache_alloc_lru to allocate xa_node
Date:   Tue, 14 Dec 2021 00:53:33 +0800
Message-Id: <20211213165342.74704-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211213165342.74704-1-songmuchun@bytedance.com>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workingset will add the xa_node to the shadow_nodes list. So the
allocation of xa_node should be done by kmem_cache_alloc_lru(). The
workingset can use xas_set_lru() to pass the list_lru.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/xarray.h |  9 ++++++++-
 lib/xarray.c           | 10 +++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index a91e3d90df8a..31f3e5ef3c7b 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1317,6 +1317,7 @@ struct xa_state {
 	struct xa_node *xa_node;
 	struct xa_node *xa_alloc;
 	xa_update_node_t xa_update;
+	struct list_lru *xa_lru;
 };
 
 /*
@@ -1336,7 +1337,8 @@ struct xa_state {
 	.xa_pad = 0,					\
 	.xa_node = XAS_RESTART,				\
 	.xa_alloc = NULL,				\
-	.xa_update = NULL				\
+	.xa_update = NULL,				\
+	.xa_lru = NULL,					\
 }
 
 /**
@@ -1613,6 +1615,11 @@ static inline void xas_set_update(struct xa_state *xas, xa_update_node_t update)
 	xas->xa_update = update;
 }
 
+static inline void xas_set_lru(struct xa_state *xas, struct list_lru *lru)
+{
+	xas->xa_lru = lru;
+}
+
 /**
  * xas_next_entry() - Advance iterator to next present entry.
  * @xas: XArray operation state.
diff --git a/lib/xarray.c b/lib/xarray.c
index f5d8f54907b4..e9b818abc823 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -302,7 +302,7 @@ bool xas_nomem(struct xa_state *xas, gfp_t gfp)
 	}
 	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
 		gfp |= __GFP_ACCOUNT;
-	xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+	xas->xa_alloc = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 	if (!xas->xa_alloc)
 		return false;
 	xas->xa_alloc->parent = NULL;
@@ -334,10 +334,10 @@ static bool __xas_nomem(struct xa_state *xas, gfp_t gfp)
 		gfp |= __GFP_ACCOUNT;
 	if (gfpflags_allow_blocking(gfp)) {
 		xas_unlock_type(xas, lock_type);
-		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		xas->xa_alloc = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 		xas_lock_type(xas, lock_type);
 	} else {
-		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		xas->xa_alloc = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 	}
 	if (!xas->xa_alloc)
 		return false;
@@ -371,7 +371,7 @@ static void *xas_alloc(struct xa_state *xas, unsigned int shift)
 		if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
 			gfp |= __GFP_ACCOUNT;
 
-		node = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 		if (!node) {
 			xas_set_err(xas, -ENOMEM);
 			return NULL;
@@ -1014,7 +1014,7 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		void *sibling = NULL;
 		struct xa_node *node;
 
-		node = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 		if (!node)
 			goto nomem;
 		node->array = xas->xa;
-- 
2.11.0

