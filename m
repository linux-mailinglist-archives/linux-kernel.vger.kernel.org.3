Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC924FEB49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiDLXsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiDLXr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:47:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC73DEB2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:38:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j17so428780pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MN0KLt5utuSN7YPPe/RQoqZU5F9l+RATon8sXwZ2y5w=;
        b=mdoXyJVzAvazeUqmdgjYlBUswr1qDbZbdPS3o59IAbiF2I+379unMu5yVplVH4k/GG
         B8cHWZAc2gf7Q+sGQnzyoBXkFjlV81u3WcvjuYibX4hdJaa69QG1qbOe17MaqGj70xp8
         8HY95CQLZNY2VI8AB+GUv/7MNBdNuT4iYc0civR4f3kfeczHZcQCl4hyoS3K9qhs8DYa
         T1br6dmAAB9goe9EnDWNq7WtAZJdyTVh1vWK6dCKQ45/6hxxOBQ2n5eRA/qbgovD/9JF
         IE8yxjWwpxIyjSdXIXUCXUZAI8/OBqoXSWYFcuiMJKrcWRERo7o0eeK+g5wma0jI1mFu
         mzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=MN0KLt5utuSN7YPPe/RQoqZU5F9l+RATon8sXwZ2y5w=;
        b=ZOTl9IBBJbhcvAAf15TtXBXvzVF4d7RyD7Hu8iDNElTiaD7iZgj5zROaxuLdCWiRXU
         W+FE/ikp7JVaifAmGbrbMaKVtumME3IcY3Nhw1BqjOf2vO20gFS9KMdw8ITuUVmEySg5
         hj+O7OYRdAfbiC+9BI/obk991rTfDFMMTnG83sVu0qQPe2/r3jloDjx2neYMm88oeg9w
         TQz81spR3Fo+mmnF2aCQpKC/LYe6482x8DGc6fmTfKgCTe3VL+gGtWAMbkwxBKoGH/Oy
         KCW7qM+IPEpSQ2oBSeJm4ib2APhXslm+DbXZf9N8BifVP/xD9BhMy/nCnNbGYHV/4dem
         g3+g==
X-Gm-Message-State: AOAM5309V3Fa93RDpV08pBXxIZ8B/7vcw1lEq7bET24V73qfpjzY57df
        qrnzpRAHomDLbqme6/47y+EQcg==
X-Google-Smtp-Source: ABdhPJyAnwlsQIgtopXxAYoBqqshq0c3q/h/noRnBGj+R/Iybto8sISq2ZZp61XWr4dN4QPH22aqrw==
X-Received: by 2002:a65:6c0b:0:b0:39d:8c30:4bb9 with SMTP id y11-20020a656c0b000000b0039d8c304bb9mr5496654pgu.411.1649806702606;
        Tue, 12 Apr 2022 16:38:22 -0700 (PDT)
Received: from [2620:15c:29:204:1a89:45ec:16da:55dc] ([2620:15c:29:204:1a89:45ec:16da:55dc])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00234c00b00505deacf78dsm4890816pfj.149.2022.04.12.16.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 16:38:22 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:38:21 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Ohhoon Kwon <ohkwon1043@gmail.com>
cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/slab_common: move dma-kmalloc caches creation into
 new_kmalloc_cache()
In-Reply-To: <20220410162511.656541-1-ohkwon1043@gmail.com>
Message-ID: <a5ecc7df-8f72-8d73-87e0-659e15dbe62d@google.com>
References: <20220410162511.656541-1-ohkwon1043@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022, Ohhoon Kwon wrote:

> There are four types of kmalloc_caches: KMALLOC_NORMAL, KMALLOC_CGROUP,
> KMALLOC_RECLAIM, and KMALLOC_DMA. While the first three types are
> created using new_kmalloc_cache(), KMALLOC_DMA caches are created in a
> separate logic. Let KMALLOC_DMA caches be also created using
> new_kmalloc_cache(), to enhance readability.
> 
> Historically, there were only KMALLOC_NORMAL caches and KMALLOC_DMA
> caches in the first place, and they were initialized in two separate
> logics. However, when KMALLOC_RECLAIM was introduced in v4.20 via
> commit 1291523f2c1d ("mm, slab/slub: introduce kmalloc-reclaimable
> caches") and KMALLOC_CGROUP was introduced in v5.14 via
> commit 494c1dfe855e ("mm: memcg/slab: create a new set of kmalloc-cg-<n>
> caches"), their creations were merged with KMALLOC_NORMAL's only.
> KMALLOC_DMA creation logic should be merged with them, too.
> 
> By merging KMALLOC_DMA initialization with other types, the following
> two changes might occur:
> 1. The order dma-kmalloc-<n> caches added in slab_cache list may be
> sorted by size. i.e. the order they appear in /proc/slabinfo may change
> as well.
> 2. slab_state will be set to UP after KMALLOC_DMA is created.
> In case of slub, freelist randomization is dependent on slab_state>=UP,
> and therefore KMALLOC_DMA cache's freelist will not be randomized in
> creation, but will be deferred to init_freelist_randomization().
> 
> Co-developed-by: JaeSang Yoo <jsyoo5b@gmail.com>
> Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>
> Signed-off-by: Ohhoon Kwon <ohkwon1043@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
