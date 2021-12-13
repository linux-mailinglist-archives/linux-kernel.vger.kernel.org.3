Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F71A473264
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbhLMQz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbhLMQzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:55:19 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C770C061751
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:55:19 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id k26so15433038pfp.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=OAELoUPn0e2UKy8uB4Ti8gblSsVQK9d5ZuUx6hxXNe2aY1+nJvPQBx4biB9bBPZ/1N
         Znx8nGswBi+htCmHDpp9a2fArHekN2A34lmat1UQvgcd054EdoejPvEWisrtLN3h4zC4
         pyx39jjWwZjeQ9VPcA5poM8QuShRcVYBsktRMgfnOEneByMg4YAaMDE/OPM4hcgUkxkk
         P/6ZRxBdCO3BaShHZaxNg1c6nrM7aUit6zUy8c6Z9B3MToxohP8mWF/jqr8j0F4UgSHn
         mAmBaQBdNAGqOQtc2YW0o49lxGoxSbWVtJt8vvalTfQEiQrPFZT8XNAtyMh9tYhUYCbb
         nLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=iUGxZ1bWCphZu1vC+rR8LJu+sKC+jcqFLz1aL8mGQLB58E+KJ7HpuAgQHzHy3EzWji
         irV3yut1O/7Z3wohzl8LEd+mGAu49yqB2S+hE0SHKlsGLMkF4r3LpmyrOb0O1xiWNALi
         JcUVeR0iwQ+cEknxQhOlgXmAg9LcgsGOr68pHAGpTBIXe3xYjCzWlnwzuXpqIUma6BoZ
         Nwe7GFcr7mCHCXm/E9kOrFJ+gC5wfoEhj90/k0yjpTHm37JDn6Lktht67dWBskK0PbvI
         tNfETRuty/5e7sdWkZhofV/CaSQHu5+JO5p9/WYypOZwUAufe9qWWLjx4qvR2lr9Lxht
         uivg==
X-Gm-Message-State: AOAM531Nu3Vg6SOAnp+PdO8KY6Yk16EMqGmTyl8UmdD2HG9dgrja2Crh
        xEuQG1GcSsQXs4Q5Dt4F5QnDxQ==
X-Google-Smtp-Source: ABdhPJzXKwhC//GX3betZXEuq2b5HgiXhLkYxb4+lBxmqy5uPKQWgZeojFHIFGpOxgz84RfZYBU1qw==
X-Received: by 2002:a62:7952:0:b0:4ac:9a13:5563 with SMTP id u79-20020a627952000000b004ac9a135563mr35004435pfc.17.1639414519090;
        Mon, 13 Dec 2021 08:55:19 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n11sm10430992pgp.15.2021.12.13.08.55.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:55:18 -0800 (PST)
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
Subject: [PATCH v4 07/17] mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
Date:   Tue, 14 Dec 2021 00:53:32 +0800
Message-Id: <20211213165342.74704-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211213165342.74704-1-songmuchun@bytedance.com>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like inode cache, the dentry will also be added to its memcg list_lru.
So replace kmem_cache_alloc() with kmem_cache_alloc_lru() to allocate
dentry.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/dcache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cf871a81f4fd..36d4806d7284 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1741,7 +1741,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	char *dname;
 	int err;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL);
+	dentry = kmem_cache_alloc_lru(dentry_cache, &sb->s_dentry_lru,
+				      GFP_KERNEL);
 	if (!dentry)
 		return NULL;
 
-- 
2.11.0

