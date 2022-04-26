Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0950F8E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345082AbiDZJmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347547AbiDZJYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:24:09 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521C61A5809
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:55:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g3so14920677pgg.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lOo0L794BWkmgoUAfFFja7lP5ln4effh0J1pKS9JIe8=;
        b=Oz/O5YqdhSiccdxQnKXdl92bbBnGi2QG57Ydixn9DIGzWjyg46FMF4y8jZV3vMjrvb
         RU92LcOdnJh0PSlC2jRgWMAIdapIAtSfO/VAaHjx+Wz7hN9iMmx5FRy39aTl1g98YOY+
         pHvHA0KcI+ZOl8bkABfJi1raJzG3+UGJVrddENYPrw/vw/krFxUOnULJrHMApCXdnBjd
         A8sr1jlJaY8lwj8vqxd/pAy3HF7kGtcXGrlc3jBIY4tXYyXqMmAZoIBmwX0O7+wJ1kF5
         LyJUMX0GCIKDHC5b3TGqgtKy4UEMQipwniv3ra0G1I7EsNcr+UuilfsmL0ds+Z8iyptz
         QaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lOo0L794BWkmgoUAfFFja7lP5ln4effh0J1pKS9JIe8=;
        b=WGP24b0GQjCvv8M1xGYWJS7+BoT4IXdRTXTOBcdHBOtCev53ZB9hZP5FLhTUlKNxMa
         xKs1EsuodTJJderBa6IZIzHJ5U2kTHayyVP7I6+N6i1BComBt44bxLv3BpiJSR/BaczT
         nN6BpE4PZigz9OYnke6fp4mIAJMhSAdzyCa+0eQryiwms5CRyLybmnW1F5srohklyBz+
         iA/pziqBl10HJLjc5omxGzbWF1cmWMNqBiOjKF64oTGKE9uXXC8ld9IYOHnwVIfWO20s
         wbs6HfgOLu7W0e/0eECtKHmxo/eZ3Jp9tT6HF0ShJxKc/i40MiYakjr5jK46lZBJC+l1
         mNYQ==
X-Gm-Message-State: AOAM530TipEv9z7ICcW1RN5a2qPsYT3eDv8xz2FGT5byiNiceyoETyBV
        jzI3wlhVQ4CBJBge/IOilX4=
X-Google-Smtp-Source: ABdhPJwQhfzD+OhQDXxPEvP1sDbC33kcc4vuFOQHUI1tB7I8vWYKQ2aVV6Lo3DGGltzvfMrfSFlPew==
X-Received: by 2002:a65:5a02:0:b0:39d:9d69:25fe with SMTP id y2-20020a655a02000000b0039d9d6925femr18843708pgs.140.1650963299743;
        Tue, 26 Apr 2022 01:54:59 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id o4-20020a625a04000000b004fdf5419e41sm14354794pfb.36.2022.04.26.01.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 01:54:57 -0700 (PDT)
Date:   Tue, 26 Apr 2022 17:54:49 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 0/3] Prototype for direct map awareness in page
 allocator
Message-ID: <YmezWeMZSRNRfXyG@hyeyoo>
References: <20220127085608.306306-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085608.306306-1-rppt@kernel.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 10:56:05AM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> This is a second attempt to make page allocator aware of the direct map
> layout and allow grouping of the pages that must be mapped at PTE level in
> the direct map.
>

Hello mike, It may be a silly question...

Looking at implementation of set_memory*(), they only split
PMD/PUD-sized entries. But why not _merge_ them when all entries
have same permissions after changing permission of an entry?

I think grouping __GFP_UNMAPPED allocations would help reducing
direct map fragmentation, but IMHO merging split entries seems better
to be done in those helpers than in page allocator.

For example:
	1) set_memory_ro() splits 1 RW PMD entry into 511 RW PTE
	entries and 1 RO PTE entry.

	2) before freeing the pages, we call set_memory_rw() and we have
	512 RW PTE entries. Then we can merge it to 1 RW PMD entry.

	3) after 2) we can do same thing about PMD-sized entries
	and merge them into 1 PUD entry if 512 PMD entries have
	same permissions.

[...]

> Mike Rapoport (3):
>   mm/page_alloc: introduce __GFP_UNMAPPED and MIGRATE_UNMAPPED
>   mm/secretmem: use __GFP_UNMAPPED to allocate pages
>   EXPERIMENTAL: x86/module: use __GFP_UNMAPPED in module_alloc
> 
>  arch/Kconfig                   |   7 ++
>  arch/x86/Kconfig               |   1 +
>  arch/x86/kernel/module.c       |   2 +-
>  include/linux/gfp.h            |  13 +++-
>  include/linux/mmzone.h         |  11 +++
>  include/trace/events/mmflags.h |   3 +-
>  mm/internal.h                  |   2 +-
>  mm/page_alloc.c                | 129 ++++++++++++++++++++++++++++++++-
>  mm/secretmem.c                 |   8 +-
>  9 files changed, 162 insertions(+), 14 deletions(-)
> 
> 
> base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
> -- 
> 2.34.1
> 

-- 
Thanks,
Hyeonggon
