Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD0A54F456
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiFQJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379158AbiFQJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:33:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992ED14D16
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:32:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n1so4748591wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8tIgYOlZc8Rzi7NZd/7vIlN3v4vuKLtpWjp+gizjnUo=;
        b=BIPKJRz2rAgQ3hGlRvZ28nEo/aUj9+1o6GWTY/64grnXsxmViDPi6Com+hzHxX5/Jh
         B7kpYLXz8dkHnEpJP5zkzfODHJl4XIVh+nfzCN/V41TdJdBjcbnhgDTlbS55VhvyT66Q
         SjHDYGzwHiysN1MtrhavU3Hj4nzPwBT2LCqIJ2rz2Sv5RKp2BvedfqtptWiOg9J5iJNv
         aj7NK2kITY6vXAdgJ3SDKiCXL8XduLXGIisM7wERU3ew0SKN2FsiybWsg35kGybYyYb9
         uz4FF31sHCUkhRn3ybD9HQKOwLC0CyfgepAtHEUolbgwwVVNWBHH6PeGD99OqnNUvne9
         /lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8tIgYOlZc8Rzi7NZd/7vIlN3v4vuKLtpWjp+gizjnUo=;
        b=Ef9MTfEQmIAiqxZSJhWs3K270D8IdjtwH2IdUwb5Nydv2d2P6c1WKRLXmYGTB09Gtk
         Q99oHWngs0suObhLiCTLKpWUPl6kk/XkwP2FZf+xELsJlcg91a1n6L/BfksjNFeJxklP
         kD3YIqLEny3G0H+xebJRjKqz+4BCkqn1okvC6duHZ/WIAUg5IGIh/s8yRywg3oBzJcMy
         XtP2EI0cND0FxbSJR95UdMBH99XVulEl9d0kdcgcaMbQe4YfXX87QIAk9iR95j1z/eg+
         8DtGMzZ4sLFcOUhmvAoNF6uxytaM8cTQ1T0LLJ5TL0flZ4MOhzIVr1EQZ4FJS+4lVdrA
         b0Jw==
X-Gm-Message-State: AJIora9J8QcVUl9xdYJ80HA4G/+20NeDgK8CYYdd29ddEESbHcX0ubT2
        ENMJQzwkrAmrTOhBQyguucM5bw==
X-Google-Smtp-Source: AGRyM1uuX6yRpdsRGrc/cEf+GA/AgIK1eRU1mxlEephkaKaBGXLt8qlxCrX03Tkps4hDjU4jhAKvAg==
X-Received: by 2002:a05:6000:2ab:b0:211:7fef:7730 with SMTP id l11-20020a05600002ab00b002117fef7730mr8132727wry.533.1655458377918;
        Fri, 17 Jun 2022 02:32:57 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:17af:cc9a:8d7c:f5cd])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b0039c8d181ac6sm9266582wmq.26.2022.06.17.02.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 02:32:57 -0700 (PDT)
Date:   Fri, 17 Jun 2022 11:32:50 +0200
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 00/32] kasan: switch tag-based modes to stack ring from
 per-object metadata
Message-ID: <YqxKQpjJMwUCpbTt@elver.google.com>
References: <cover.1655150842.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1655150842.git.andreyknvl@google.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
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

On Mon, Jun 13, 2022 at 10:13PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> This series makes the tag-based KASAN modes use a ring buffer for storing
> stack depot handles for alloc/free stack traces for slab objects instead
> of per-object metadata. This ring buffer is referred to as the stack ring.
> 
> On each alloc/free of a slab object, the tagged address of the object and
> the current stack trace are recorded in the stack ring.
> 
> On each bug report, if the accessed address belongs to a slab object, the
> stack ring is scanned for matching entries. The newest entries are used to
> print the alloc/free stack traces in the report: one entry for alloc and
> one for free.
> 
> The ring buffer is lock-free.
> 
> The advantages of this approach over storing stack trace handles in
> per-object metadata with the tag-based KASAN modes:
> 
> - Allows to find relevant stack traces for use-after-free bugs without
>   using quarantine for freed memory. (Currently, if the object was
>   reallocated multiple times, the report contains the latest alloc/free
>   stack traces, not necessarily the ones relevant to the buggy allocation.)
> - Allows to better identify and mark use-after-free bugs, effectively
>   making the CONFIG_KASAN_TAGS_IDENTIFY functionality always-on.
> - Has fixed memory overhead.
> 
> The disadvantage:
> 
> - If the affected object was allocated/freed long before the bug happened
>   and the stack trace events were purged from the stack ring, the report
>   will have no stack traces.

Do you have statistics on how how likely this is? Maybe through
identifying what the average lifetime of an entry in the stack ring is?

How bad is this for very long lived objects (e.g. pagecache)?

> Discussion
> ==========
> 
> The current implementation of the stack ring uses a single ring buffer for
> the whole kernel. This might lead to contention due to atomic accesses to
> the ring buffer index on multicore systems.
> 
> It is unclear to me whether the performance impact from this contention
> is significant compared to the slowdown introduced by collecting stack
> traces.

I agree, but once stack trace collection becomes faster (per your future
plans below), this might need to be revisited.

> While these patches are being reviewed, I will do some tests on the arm64
> hardware that I have. However, I do not have a large multicore arm64
> system to do proper measurements.
> 
> A considered alternative is to keep a separate ring buffer for each CPU
> and then iterate over all of them when printing a bug report. This approach
> requires somehow figuring out which of the stack rings has the freshest
> stack traces for an object if multiple stack rings have them.
> 
> Further plans
> =============
> 
> This series is a part of an effort to make KASAN stack trace collection
> suitable for production. This requires stack trace collection to be fast
> and memory-bounded.
> 
> The planned steps are:
> 
> 1. Speed up stack trace collection (potentially, by using SCS;
>    patches on-hold until steps #2 and #3 are completed).
> 2. Keep stack trace handles in the stack ring (this series).
> 3. Add a memory-bounded mode to stack depot or provide an alternative
>    memory-bounded stack storage.
> 4. Potentially, implement stack trace collection sampling to minimize
>    the performance impact.
> 
> Thanks!
> 
> Andrey Konovalov (32):
>   kasan: check KASAN_NO_FREE_META in __kasan_metadata_size
>   kasan: rename kasan_set_*_info to kasan_save_*_info
>   kasan: move is_kmalloc check out of save_alloc_info
>   kasan: split save_alloc_info implementations
>   kasan: drop CONFIG_KASAN_TAGS_IDENTIFY
>   kasan: introduce kasan_print_aux_stacks
>   kasan: introduce kasan_get_alloc_track
>   kasan: introduce kasan_init_object_meta
>   kasan: clear metadata functions for tag-based modes
>   kasan: move kasan_get_*_meta to generic.c
>   kasan: introduce kasan_requires_meta
>   kasan: introduce kasan_init_cache_meta
>   kasan: drop CONFIG_KASAN_GENERIC check from kasan_init_cache_meta
>   kasan: only define kasan_metadata_size for Generic mode
>   kasan: only define kasan_never_merge for Generic mode
>   kasan: only define metadata offsets for Generic mode
>   kasan: only define metadata structs for Generic mode
>   kasan: only define kasan_cache_create for Generic mode
>   kasan: pass tagged pointers to kasan_save_alloc/free_info
>   kasan: move kasan_get_alloc/free_track definitions
>   kasan: simplify invalid-free reporting
>   kasan: cosmetic changes in report.c
>   kasan: use kasan_addr_to_slab in print_address_description
>   kasan: move kasan_addr_to_slab to common.c
>   kasan: make kasan_addr_to_page static
>   kasan: simplify print_report
>   kasan: introduce complete_report_info
>   kasan: fill in cache and object in complete_report_info
>   kasan: rework function arguments in report.c
>   kasan: introduce kasan_complete_mode_report_info
>   kasan: implement stack ring for tag-based modes
>   kasan: better identify bug types for tag-based modes

Let me go and review the patches now.

Thanks,
-- Marco
