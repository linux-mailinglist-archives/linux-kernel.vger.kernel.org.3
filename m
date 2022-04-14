Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6662850090D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbiDNJAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241300AbiDNJAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:00:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A6692A9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:57:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 12so4100181pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvUcfGV0AI5Z5Ok9/naO7LBjVi2omORuN4/12C7DmHE=;
        b=JR2RAEmge/keIR/Ml2wlBOCVlLAFG6iue7Hc3B84gbF39ETD8Z6w5ipfhgjcI5pt7n
         3JnqtA6jCC1bW0jZPfN623VDrHkCImpoQypj/WGex6PSaxrG78yJ+B0oaSeDTcxiPJNp
         6+7kCsCgADfNs8lZ7ExcafvNtMW+mL8Sxp0dfM5e+MAOc5Dugo3w+JoIdZeUc9/ctGFJ
         /DOI7zCm0yXvjyIIriUxmTSBHhaO2uTX3GLvTBIH6SYDd6L6Tr/DK4za39KscI7iwIRS
         ZAV5k+h52w0ZHukEJP+LOLZNUzhayIx+qoSZpg21P01X01Yt7gTi3+tFVmTG+mUm99mi
         SVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvUcfGV0AI5Z5Ok9/naO7LBjVi2omORuN4/12C7DmHE=;
        b=DzjTzL5wXfzUUZSERtd5lNjLNqjpNvsFzH/3LfjI1H4U5WctE1rXwXGApEb1P14emb
         ufZgZIIdj7aU5tw94r4YZF5SzaXqi6kyliUywQeInGRq+HiauDZ59C5G6Yx00TKPTEvr
         wFYw6c/Qaze83L7X30CFIN9JCqz2U/uLMyc2J+7KUh9oWZvXJRL+xuAyARRSukY0Xtn6
         EcVJf4FiuApI1ntLBz+SN/SZsPkCioECiD+YyuUa31OtLewj78Yl3xFgcsic6ihAp1gO
         WnnSOR4HAmJPXx/fNVmz0Q742SiVbya39Fr2YxYJBMbLbA7y1yhcMy06ByIBEPvvjYyg
         piVw==
X-Gm-Message-State: AOAM530+UoeHonAoFb/K+aeXQ51aFZigS/qbR9i6/2cJuTK/2Z26+8AQ
        h9vEsS0JXXeok51FFSQJgb4=
X-Google-Smtp-Source: ABdhPJyizoPS3uBWKhkZvBXCVjTSS1AwqRPB39uv9wUmFhns1Opl4pKj6mE0GhOs94q49W+tXxsj1Q==
X-Received: by 2002:a17:902:b495:b0:158:8318:4cf9 with SMTP id y21-20020a170902b49500b0015883184cf9mr13576324plr.33.1649926658591;
        Thu, 14 Apr 2022 01:57:38 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:57:36 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/23] common kmalloc for SLUB and SLAB v2
Date:   Thu, 14 Apr 2022 17:57:04 +0900
Message-Id: <20220414085727.643099-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
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

Changes since v1:
- The code is basically same, but split some patches to make it
easier to review.
- Adjusted comments and added Reviewed-by from Vlastimil. Thanks!

Hello, this series is cleanup of kmalloc code. After this series,
kmalloc subsystem is perfectly generalized on SLAB and SLUB.

This series is not small, but each patch is easy to review and
I bet you will like this :)

Many thanks to Matthew, Marco, Vlastimil who gave comments
in previous series.

Any feedbacks will be appreciated.
Thanks!

======== series description =======

patch 1-2 make slab_alloc_node() in SLAB available for non-NUMA
configurations for further cleanup.

patch 3-12 remove duplicate code in common kmalloc functions.

patch 13 makes SLAB pass requests larger than order-1 page to page
allocator. This is useful for further generalization.

patch 14-16 unify tracepoints. after them, we use only
kmem_cache_alloc and kmem_cache_free tracepoints in slab allocators.

patch 17-18 generalize whole kmalloc subsystem on SLAB/SLUB.

patch 19-20 factor out common code of __kmalloc_node()
and __kmalloc_node_track_caller().

patch 21 removes now unnecessary kmem_cache_alloc_node_trace().

patch 22-23 is small improvements of __ksize(). They are not part of
generalization but depends on this series.

Hyeonggon Yoo (23):
  mm/slab: move NUMA-related code to __do_cache_alloc()
  mm/slab: cleanup slab_alloc() and slab_alloc_node()
  mm/slab_common: remove CONFIG_NUMA ifdefs for common kmalloc functions
  mm/slab_common: cleanup kmalloc_track_caller()
  mm/slab_common: cleanup __kmalloc()
  mm/sl[auo]b: fold kmalloc_order_trace() into kmalloc_large()
  mm/slub: move kmalloc_large_node() to slab_common.c
  mm/slab_common: make kmalloc_large_node() consistent with
    kmalloc_large()
  mm/slab_common: cleanup kmalloc_large()
  mm/slab_common: cleanup kmem_cache_alloc{,node,lru}
  mm/slab_common: kmalloc_node: pass large requests to page allocator
  mm/slab_common: cleanup kmalloc()
  mm/slab: kmalloc: pass requests larger than order-1 page to page
    allocator
  mm/slab_common: print cache name in tracepoints
  mm/slab_common: use same tracepoint in kmalloc and normal caches
  mm/slab_common: rename tracepoint
  mm/slab_common: implement __kmem_cache_free()
  mm/sl[au]b: generalize kmalloc subsystem
  mm/slab_common: add kasan_kmalloc() in __kmalloc_node_track_caller()
  mm/slab_common: factor out __do_kmalloc_node()
  mm/sl[au]b: remove kmem_cache_alloc_node_trace()
  mm/sl[auo]b: move definition of __ksize() to mm/slab.h
  mm/sl[au]b: check if large object is valid in __ksize()

 include/linux/slab.h        | 245 ++++++++++++-------------
 include/trace/events/kmem.h | 109 ++---------
 mm/slab.c                   | 354 ++++++------------------------------
 mm/slab.h                   |   9 +
 mm/slab_common.c            | 146 ++++++++++++---
 mm/slob.c                   |  78 +++-----
 mm/slub.c                   | 264 ++-------------------------
 7 files changed, 350 insertions(+), 855 deletions(-)

-- 
2.32.0

