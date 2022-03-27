Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0651C4E8619
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 07:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiC0FpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 01:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiC0FpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 01:45:18 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B78FDB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 22:43:40 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2e592e700acso119181557b3.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 22:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kp+n7MjmnLTJ4vOAA537LLcCjh6KRC0etIIuCa/wcqQ=;
        b=icDZzCAPN5GzbIs+eeeY5TNGBRG9fV3oU6z+g0Dshz7qXNcvNe25C09q2gQBxiVQKm
         BPvx9nsC8xFm+raqnG0tK6LL4xi/wSZ69riv36QGC9YvgpI2rEq9CqUsz7JhVmBn2gYR
         W3zAr1bQe+0ML/qTY18DiE8AK1LRW6NMRf6CXu/8ujOCOAg3851aNlzvCSF+ORKoq8Kh
         ty696EWA9jVAe8eGmqO5/uMA7L6CsQY/8BYppV4yD3ILqroCSC8AriglDCA2PuQ3Kt2k
         XCWm6/8wntsx4G9rdOE0LuUcoookkpQKFIlP+JA5xl1vcIsLErdvCsQ4ndWV7dWYwgCx
         kLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kp+n7MjmnLTJ4vOAA537LLcCjh6KRC0etIIuCa/wcqQ=;
        b=u+slCl95uEtfkSq9H36PhMjbQ0rQUTRLt62EIaG3rNPrpXsMXpROiH67hYqhnSMtG2
         ABC+B34VoMJCJbyowU9Yk01R3/qPOvVkQrSreQzQVFEXDQDXNUGYK2zunuiRGlOKVVrc
         otPR/lEEUeYc4R4pAEMkP55LT5YF23BffhRZpv+OjqdnV/DYYoYxRJEO4epXenrxUna0
         d8BwnpvCkycE5409pf9QN4ACRBGlNyIvuNxsUbV0E2UW6iT5cc6ePQi93AHu/S+NfyCK
         hG7QELpdlCBYKoCnLqyBfdTOH91AKRWmi78WQfWor+No5p0FbHk3htf40ME9B5m1+Tfg
         MoMQ==
X-Gm-Message-State: AOAM532ZUAJm/5OgaGWTATs4ybaiX3EO0yXp+aPX46DYC1S7Ciysoz6G
        9FMxd8Coz4GzHonX4T5e6hNh4c69e3+ZdgfQKCjSZw==
X-Google-Smtp-Source: ABdhPJwIvL78p8zBSpKdXW3OcMDN5VYLW8WBGkkTHwZ1qqfNPoxw6rEtsQ28DJ6Hi85h7xXmRkfj7I3ZUMylE9TN7io=
X-Received: by 2002:a81:5dd6:0:b0:2d6:3041:12e0 with SMTP id
 r205-20020a815dd6000000b002d6304112e0mr19479093ywb.331.1648359819570; Sat, 26
 Mar 2022 22:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220327051853.57647-1-songmuchun@bytedance.com> <20220327051853.57647-2-songmuchun@bytedance.com>
In-Reply-To: <20220327051853.57647-2-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 27 Mar 2022 13:43:03 +0800
Message-ID: <CAMZfGtVWa0uOKqSeuau9pCNXSQHPz5=S+yYupCUYRqhqyhod+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: kfence: fix objcgs vector allocation
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     kasan-dev@googlegroups.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 1:19 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> If the kfence object is allocated to be used for objects vector, then
> this slot of the pool eventually being occupied permanently since
> the vector is never freed.  The solutions could be 1) freeing vector
> when the kfence object is freed or 2) allocating all vectors statically.
> Since the memory consumption of object vectors is low, it is better to
> chose 2) to fix the issue and it is also can reduce overhead of vectors
> allocating in the future.
>
> Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Since it cannot be compiled successfully when !CONFIG_MEMCG
(The following patch should be applied), I'll update this in the next
version if anyone agrees with this change.

Thanks.

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 9976b3f0d097..b5c4b62b5d2c 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -583,7 +583,9 @@ static bool __init kfence_init_pool(void)
                struct kfence_metadata *meta = &kfence_metadata[i];

                /* Initialize metadata. */
+#ifdef CONFIG_MEMCG
                slab->memcg_data = (unsigned long)&meta->objcg |
MEMCG_DATA_OBJCGS;
+#endif
                INIT_LIST_HEAD(&meta->list);
                raw_spin_lock_init(&meta->lock);
                meta->state = KFENCE_OBJECT_UNUSED;
@@ -940,7 +942,9 @@ void __kfence_free(void *addr)
 {
        struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);

+#ifdef CONFIG_MEMCG
        KFENCE_WARN_ON(meta->objcg);
+#endif
        /*
         * If the objects of the cache are SLAB_TYPESAFE_BY_RCU, defer freeing
         * the object, as the object page may be recycled for other-typed
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 6f0e1aece3f8..9a6c4b1b12a8 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -89,7 +89,9 @@ struct kfence_metadata {
        struct kfence_track free_track;
        /* For updating alloc_covered on frees. */
        u32 alloc_stack_hash;
+#ifdef CONFIG_MEMCG
        struct obj_cgroup *objcg;
+#endif
 };
