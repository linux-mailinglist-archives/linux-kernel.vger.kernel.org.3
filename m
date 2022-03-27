Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343494E85E8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 07:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiC0FVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 01:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiC0FV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 01:21:26 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C1B1D0D3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 22:19:47 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c2so9724544pga.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 22:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjAjApw5OmSknfrnxGEwevfGU2mFpTwiMRTXvU9CZ2U=;
        b=wBkFbXGMET0gE47K/TSFH9UuQfvLUwNBZdLSiqEWnESv1luqGTYjTde2w9BVYFtu0X
         UCauf6MGpfAFDUFFCZwVl2MlL3Vwe5axNiwZFUCq1DFJ8od7ZT8iuIzBWTmmBqUEPbJa
         2iGj07rGHmzXcYAyVfO2jcERGzKat2XWz4N+quZ/AI4x5mUWY3LIhpJROZLsLjYHO/aO
         QCfuIkz6YAllOHDGUBj/u7cXtMtZrPsXwfrD60+vjfbGttYX9LSffkfnrfmwwnIVaASt
         rQpxqgWlSDEoclf7TLF+0BJB3/G8LIJl6WW+Yyzz4wHi4/nFX6d4sr2RojTfwP5FNVxy
         OXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjAjApw5OmSknfrnxGEwevfGU2mFpTwiMRTXvU9CZ2U=;
        b=afHY3cvoFoiZ1i1jJP6BoR6wsNU1MDgBnj9COhA2FHJpumKaFoHaYgIi+X3zLxY5h0
         vt7fBtiTteWv/y0eFO7RV/pz45fENi/q9cXw6sqWudGj6cnDuyrmtN1U4EsEzsYs78WB
         C5S3wf4Aqjh/HBJK6CGxWTG65ovuHdITvYAXZoVlBz5jvgmdIqv0o+51dOiQGdhaeTE8
         F/KxOHK+x6VpypKBaXuAvKnCh9CaIGJaJIMUj2mweC/7mtEG37bjkh6KeRGd035fY56P
         XapZvIZ7qRsPCE8ixazVP2d4OLI45y+XQTJEktJFJ6tL9eqflgE1F/94kbfhtjHE8sAT
         GBqg==
X-Gm-Message-State: AOAM5334XyQUK2kCA7N3FrvBBjnrUUXy8131qlBT+KW72M5fFBq6ghRx
        ENCDyhyS3UE4/uhJ6TSgb3XsNA==
X-Google-Smtp-Source: ABdhPJzY53+MiMZ7oUkfYyICVhIUmUhH6YNa1A7t1v9zaZB+lsmZbngkcXass1+xHl+FsgDVtW0DIg==
X-Received: by 2002:a05:6a00:1a91:b0:4fa:b21d:2ce with SMTP id e17-20020a056a001a9100b004fab21d02cemr17887607pfv.75.1648358387326;
        Sat, 26 Mar 2022 22:19:47 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id m18-20020a056a00081200b004faeae3a291sm11115940pfk.26.2022.03.26.22.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 22:19:47 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     torvalds@linux-foundation.org, glider@google.com, elver@google.com,
        dvyukov@google.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/2] mm: kfence: fix objcgs vector allocation
Date:   Sun, 27 Mar 2022 13:18:53 +0800
Message-Id: <20220327051853.57647-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220327051853.57647-1-songmuchun@bytedance.com>
References: <20220327051853.57647-1-songmuchun@bytedance.com>
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

If the kfence object is allocated to be used for objects vector, then
this slot of the pool eventually being occupied permanently since
the vector is never freed.  The solutions could be 1) freeing vector
when the kfence object is freed or 2) allocating all vectors statically.
Since the memory consumption of object vectors is low, it is better to
chose 2) to fix the issue and it is also can reduce overhead of vectors
allocating in the future.

Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/kfence/core.c   | 3 +++
 mm/kfence/kfence.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 13128fa13062..9976b3f0d097 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -579,9 +579,11 @@ static bool __init kfence_init_pool(void)
 	}
 
 	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+		struct slab *slab = virt_to_slab(addr);
 		struct kfence_metadata *meta = &kfence_metadata[i];
 
 		/* Initialize metadata. */
+		slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
 		INIT_LIST_HEAD(&meta->list);
 		raw_spin_lock_init(&meta->lock);
 		meta->state = KFENCE_OBJECT_UNUSED;
@@ -938,6 +940,7 @@ void __kfence_free(void *addr)
 {
 	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
 
+	KFENCE_WARN_ON(meta->objcg);
 	/*
 	 * If the objects of the cache are SLAB_TYPESAFE_BY_RCU, defer freeing
 	 * the object, as the object page may be recycled for other-typed
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 2a2d5de9d379..6f0e1aece3f8 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -89,6 +89,7 @@ struct kfence_metadata {
 	struct kfence_track free_track;
 	/* For updating alloc_covered on frees. */
 	u32 alloc_stack_hash;
+	struct obj_cgroup *objcg;
 };
 
 extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
-- 
2.11.0

