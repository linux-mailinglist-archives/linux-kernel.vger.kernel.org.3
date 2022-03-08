Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50F64D166C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346510AbiCHLnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346502AbiCHLnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:43:14 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E982C122
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso2160506pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUjyQO1QWOZK6I3n0yaGiQcdv54drlHJV5uk7w/YBv4=;
        b=AG0c0/5hAmXhvYYF4A05TJlfV2jBRnVhCvQolU4TWj5Ee4FJJqWj7yDX0kSgDpnPqF
         ZjPXygYCM4M4UeA8/ErrCOnXT+qoZQWdo8lYGfqZXWaLg37ogHF5WhMv36XKl4pxmgRy
         9wehxLGeOUsYg2/MHesSCC2ZopWoPq60u8L4iD7E3PRlNOyIwggggPjAnbgWSPHYMv95
         PBugSVdsmlzkIx6QARvnFFJuDQaidQ9KgCY8nUaNHZgIF+2mIA8pF0sP9rT1//RIPj7c
         qPDhErzyK5zkKAALRknZP2Oc4We4gDjGHMZBLMtmfbNRbuz/8Sl+h714bv4dEUgZLNZL
         f9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUjyQO1QWOZK6I3n0yaGiQcdv54drlHJV5uk7w/YBv4=;
        b=H6VioIQFmZ8u4pRgu5B72K2I4kNZdrSUfz2XwodfyjwZbKQck99nvvCjrhMbdtzyyF
         EO81gYhbBVmSFBTRFb56RJWd+ipWzxrqnZurpaKObvvKXumyJ4UO36g+opW/VxfJscvd
         WUD+pHxdt8qCQnXgKZErahfsIXMrIqBuy3lEv6e7mqvgfK1BnKc/SNI+YQY55tVZ7QQD
         gBSYbUczh4Xawp0ZcDwXeVqi8lzyHpqFPQj9GCLtAg3XUsgPjxUZXCf5qQm4p+8dHLJy
         rPw95QmSGkFaGLX+vjP9/GyX6sCGzeqXvKJuOuBur+XwjAaLKhuFSHHCvTbb4RTZrgiC
         58Fg==
X-Gm-Message-State: AOAM531pdKcP2ljsohTk4UGvwVoIssXKUNP0qicFPEJMcB9Og9JjxMcy
        U4q0EJ6G6zk82BmKiIC9Rkc=
X-Google-Smtp-Source: ABdhPJy/vjn08ZDcWASQhRetQX28DFSULO9BILKHMosppf0to/aF3AVlOJ+RxJv5Qd671iukFwwpXw==
X-Received: by 2002:a17:902:f643:b0:14d:7b8f:14b3 with SMTP id m3-20020a170902f64300b0014d7b8f14b3mr16890881plg.19.1646739737550;
        Tue, 08 Mar 2022 03:42:17 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:17 -0800 (PST)
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
Subject: [RFC PATCH v1 00/15] common kmalloc subsystem on SLAB/SLUB
Date:   Tue,  8 Mar 2022 11:41:27 +0000
Message-Id: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
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

Hello, this series is cleanup of slab common code.

After this series, kmalloc subsystem is perfectly generalized
between SLAB and SLUB.

This series is not small, and some of review and discussion may be needed.
But I bet you will like this! :D

Many thanks to Matthew, Marco, Vlastimil who gave comments
in previous series.

Any feedbacks will be appreciated.
Thanks!

========= series description ==========

patch 1 makes slab_alloc_node() in SLAB available for non-NUMA
configurations for further cleanup.

patch 2-8 are cleanup of unnecessary CONFIG_TRACING/NUMA ifdefs and
duplicate code. (and small optimization of kmalloc_node())

patch 9 makes SLAB pass requests larger than order-1 page to page
allocator. This is useful for further generalization.

patch 10-11 are cleanup of tracepoints. Currently there are five
trace points in slab: kmalloc, kmalloc_node, kmem_cache_alloc,
kmem_cahce_alloc_node, kmem_cache_free, kfree.

patch 10-11 make tracepoints print cache name and convert every
tracepoint to kmem_cache_alloc_node and kmem_cache_free.

patch 12 generalizes whole kmalloc subsystem on SLAB and SLUB.

patch 13 removes kmem_cache_alloc_node() that became useless
after patch 12.

patch 14-15 are small improvements of __ksize().

Hyeonggon Yoo (15):
  mm/slab: cleanup slab_alloc() and slab_alloc_node()
  mm/sl[auo]b: remove CONFIG_NUMA ifdefs for common functions
  mm/sl[au]b: remove CONFIG_TRACING ifdefs for tracing functions
  mm/sl[auo]b: fold kmalloc_order() into kmalloc_large()
  mm/slub: move kmalloc_large_node() to slab_common.c
  mm/slab_common: cleanup kmalloc_large()
  mm/sl[au]b: kmalloc_node: pass large requests to page allocator
  mm/sl[auo]b: cleanup kmalloc()
  mm/slab: kmalloc: pass requests larger than order-1 page to page
    allocator
  mm/sl[auo]b: print cache name in tracepoints
  mm/sl[auo]b: use same tracepoint in kmalloc and normal caches
  mm/sl[au]b: generalize kmalloc subsystem
  mm/sl[au]b: remove kmem_cache_alloc_node_trace()
  mm/sl[auo]b: move definition of __ksize() to mm/slab.h
  mm/sl[au]b: check if large object is valid in __ksize()

 include/linux/slab.h        | 252 +++++++++++---------------
 include/trace/events/kmem.h | 107 ++---------
 mm/slab.c                   | 347 ++++++++----------------------------
 mm/slab.h                   |   9 +
 mm/slab_common.c            | 128 ++++++++++---
 mm/slob.c                   |  69 +++----
 mm/slub.c                   | 237 ++----------------------
 7 files changed, 346 insertions(+), 803 deletions(-)

-- 
2.33.1

