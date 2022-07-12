Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5441571B78
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiGLNj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiGLNjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:39:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B43B5D29
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:39:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c15so2446448pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GSCdzrG/hG5dXXM78OyhYj2dNDOwSiS9CiVXPuQBexc=;
        b=LSTVZAHfNUMVWow5R6+aLV7Og05WP08vNp+X1p1NTHhlYv2oyWpjSx/nvgBcRI0zvw
         YbSVAnS/ogdSUOeZG56fFF4jvbabU7vhupE1oM3cxJQ17pQhUSwtAeRBPM/SXb4ND1t2
         2Sd99chJJOUXg4ZAiYhl56bLrhWtmxSy++fCRax+3fHBTdv72DE7NnYSQviJPpcaTUcz
         IZe/E0NIfYAfl0jzeg17+8hgIQ92bjiXqpS/0YQR4facTTZPIO4Ftzuk4M4JCJen6PMe
         CTygIUm9W/0OlEIoEdIEgVPtxQcZLd5oJEm/gqsYX+0GWj7AkWBMo1SNmpc1z91o4qJ9
         RSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GSCdzrG/hG5dXXM78OyhYj2dNDOwSiS9CiVXPuQBexc=;
        b=RwaaD7c61XZZhNum0I2qaJdrKQL7eBnx++wKDmBM2jCa0o1tywIJ8TV9Ii17yRh4Dl
         0AXbWD16m3hY59kLTxbiXDbWRPvWa8sOrfdt0qMBejg0T3Hixyr1c0nqeCq+9PLIxPIc
         rmcJxukHTJOLyjvOgzBmaYIF7ZZRYWkQpmP9UCeJ0ELsDdGUDcF9DhR2o9ixA44LOGlP
         Fxdek5KPSd+aIhksnnjJy/o9KLScHIUu79v0ejYN+6BjHZ6BF+hNYHt6phjyPI3omEHu
         vjNl28kLchb4uA5Gja44b3E+ZqOvjdhYlL7VDPzXGRk3Cf1SXjY8TufEFPP9bI+k8oOB
         dd3A==
X-Gm-Message-State: AJIora/W14hCfddcgT3GEpPpZ1a44KZ7nuQ7MyYC6VmaKU0tsVplIJs7
        zA1eu07RXDhAQRwjgz68rRI=
X-Google-Smtp-Source: AGRyM1tR+Dra7PTDlJiULAt8/wFsye/iHU0JtuXduu4TSjMjAram+B9ATptMXy1oMKjLZ4Gsd8CfhQ==
X-Received: by 2002:a17:902:7582:b0:16a:307a:5965 with SMTP id j2-20020a170902758200b0016a307a5965mr23812640pll.159.1657633192640;
        Tue, 12 Jul 2022 06:39:52 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:39:51 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 00/15] common kmalloc v3
Date:   Tue, 12 Jul 2022 13:39:30 +0000
Message-Id: <20220712133946.307181-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This is v3 of common kmalloc series.

This series generalize most of kmalloc functions and move its
implementation into mm/slab_common.c.

I believe this series give better maintainability of code for SLAB and SLUB.
Please consider applying.

This series is based on slab/for-next and also available at
https://github.com/hygoni/linux/tree/slab-common-v3r0

Any feedbacks/reviews will be appreciated.

v2->v3:
	- Now this series does not unify tracepoints between kmalloc and
	  kmem_cache_alloc(). And does not print its name.
	  Instead, it implements common alloc/free function without
	  tracepoint.
	
	- Dropped UMA version of tracepoints and removed _node suffix
	  for NUMA version. (Vlastimil Babka)

	- Split kmem_alloc event class and defined kmem_cache_alloc and
	  kmalloc events using TRACE_EVENT() macro. And avoided
	  dereferencing fields of struct kmem_cache when not using
	  tracepoints. (Vlastimil Babka) 

	- Dropped patches cleaning up kmalloc() to avoid increasing size of
	  kernel image. (Joe Perches)

	- Tried to avoid affecting inlined kmalloc calls
	  and kmem_cache_alloc varients.
	
	- Fixed uninitialized variable bug in SLAB with NUMA.

	- Fixed an issue printing useless caller in
	  kmalloc_node_track_caller() when it calls kmalloc_large_node().

	- call WARN_ON() when __ksize() returns zero. (Christoph Lameter)

	- Adjusted feedbacks from Vlastimil Babka.
	  (Coding Style, patch organization, etc.)

Thank you all for feedback :)

===== sequence of patches =====

patch 1-2 make slab_alloc_node() available for non-NUMA
configurations for generalization.

patch 3-5 remove duplicate code in common kmalloc functions.

patch 6-10 move implementation of kmalloc_large{,_node}()
to slab_common.c and make SLAB pass requests larger than
order-1 page to page allocator. (like SLUB)

patch 11-12 generalize most of kmalloc functions.

patch 13 drops kmem_alloc event class and rename
kmem_alloc_node to kmem_alloc. and remove _node suffix
for its events.

patch 14 drop kmem_alloc event class and then define
kmalloc and kmem_cache_alloc events using TRACE_EVENT() macro.
It also avoids dereferencing fields when not using tracepoints.

patch 15-16 are small improvements of __ksize(). They are
not part of generalization but depends on this series.

  mm/slab: move NUMA-related code to __do_cache_alloc()
  mm/slab: cleanup slab_alloc() and slab_alloc_node()
  mm/slab_common: remove CONFIG_NUMA ifdefs for common kmalloc functions
  mm/slab_common: cleanup kmalloc_track_caller()
  mm/sl[au]b: factor out __do_kmalloc_node()
  mm/sl[auo]b: fold kmalloc_order_trace() into kmalloc_large()
  mm/slub: move kmalloc_large_node() to slab_common.c
  mm/slab_common: kmalloc_node: pass large requests to page allocator
  mm/slab_common: cleanup kmalloc_large()
  mm/slab: kmalloc: pass requests larger than order-1 page to page
    allocator
  mm/sl[au]b: introduce common alloc/free functions without tracepoint
  mm/sl[au]b: generalize kmalloc subsystem
  mm/slab_common: unify NUMA and UMA version of tracepoints
  mm/slab_common: drop kmem_alloc & avoid dereferencing fields when not
    using
  mm/sl[auo]b: move definition of __ksize() to mm/slab.h
  mm/sl[au]b: check if large object is valid in __ksize()

 include/linux/slab.h        | 117 +++++----------
 include/trace/events/kmem.h |  68 +++------
 mm/slab.c                   | 290 ++++++++++--------------------------
 mm/slab.h                   |  11 ++
 mm/slab_common.c            | 176 +++++++++++++++++++---
 mm/slob.c                   |  28 +---
 mm/slub.c                   | 218 +++------------------------
 7 files changed, 320 insertions(+), 588 deletions(-)

-- 
2.34.1

