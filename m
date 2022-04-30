Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987A7515A3B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 06:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbiD3EEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 00:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbiD3ED5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 00:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F2B6186D9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 21:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651291223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sKB6FlYNwY4+wlgwk3rv/2ltFqVWdp3lmtPGlyyyGGo=;
        b=ETSEpC1Grbg5pv+cyJS2gGr2EuAsb+K4EJsx/8DzCLJCuwNqkThpERRqUH/5miiW/I0yDn
        WsA7Ikn8+A8aGqnzzldBqkbe3epsP4d0b06AlhKAmm4i2Y83vYC0pwwgVxX/byPwVZhJW1
        P6CPSOc+fDUG6lcg0MJNqLwECbz60Io=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-r9D6Y8RMNt2K4ubyC_VmbA-1; Sat, 30 Apr 2022 00:00:21 -0400
X-MC-Unique: r9D6Y8RMNt2K4ubyC_VmbA-1
Received: by mail-wr1-f72.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so3702517wra.15
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 21:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKB6FlYNwY4+wlgwk3rv/2ltFqVWdp3lmtPGlyyyGGo=;
        b=rELpax+fIf/ZBMR6YcvcdDTrzPGPSWDZPXl2gWv3kX3+4nhaEq7CC7v3sZCjXqYj6l
         vYudaiECgBaE2hiqh66QPXE322Zm1HRlN60RWcYc/+ZvK3hSQzNsCLi8xDWBtP/VROFI
         HvduYU07xM7b3i9ZhSqghXm48mbU0/VjtCD9Y1syEo1F19eeHPKRwkQWEDcmISYFpV10
         6c4VuulAHCQEzRf7dy8WJf69uVPwPWw4PZdVa6GXKX5c5ZrdEIJwkHsLI7+LBewUbiO+
         lCzf83QJI1ZY4lg/BBNo8u5jqgAu8j2d2IRrjnTXqBL7KL7ZX4Ugs93ZGFKPntmfUxwQ
         JMUw==
X-Gm-Message-State: AOAM530766dBbVCQ9XYJwukh4Fu2IGSYcK8CQdvPUaTdoC+HKOhXd7Np
        DSOoJAfOcFvK5DQZA03FvwOeh/WtUSu4DoxHBZ7QXzXweguEHA5RQ0RSl+T2dDlvlAWdwtliaEI
        xuadd4ASRKKGapl4pgJQCrDxUd9UxD8pi0eKMnz6u
X-Received: by 2002:adf:ee81:0:b0:206:1b32:d6f2 with SMTP id b1-20020adfee81000000b002061b32d6f2mr1559773wro.144.1651291219821;
        Fri, 29 Apr 2022 21:00:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyLeeVtNgwwU9RGNYZQkn5+DYkg+QFnnf5jW3HF7IgxWHGisBGg3RhxLrXZWdxkQaYbA/ce/QbaCUurXmPnwo=
X-Received: by 2002:adf:ee81:0:b0:206:1b32:d6f2 with SMTP id
 b1-20020adfee81000000b002061b32d6f2mr1559762wro.144.1651291219592; Fri, 29
 Apr 2022 21:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
In-Reply-To: <20220421234837.3629927-1-kent.overstreet@gmail.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Sat, 30 Apr 2022 12:00:08 +0800
Message-ID: <CALu+AoSP8QASexVOsJqbiqNH-HcdcJHjBd-=t1EJZ7sPUVTK=w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Printbufs & shrinker OOM reporting
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kent,
On Fri, 22 Apr 2022 at 07:56, Kent Overstreet <kent.overstreet@gmail.com> wrote:
>
> Debugging OOMs has been one of my sources of frustration, so this patch series
> is an attempt to do something about it.
>
> The first patch in the series is something I've been slowly evolving in bcachefs
> for years: simple heap allocated strings meant for appending to and building up
> structured log/error messages. They make it easy and straightforward to write
> pretty-printers for everything, which in turn makes good logging and error
> messages something that just happens naturally.
>
> We want it here because that means the reporting I'm adding to shrinkers can be
> used by both OOM reporting, and for the sysfs (or is it debugfs now) interface
> that Roman is adding.
>

I added the kexec list in cc.  It seems like a nice enhancement to oom
reporting.
I suspect kdump tooling need changes to retrieve the kmsg log from
vmcore, could you confirm it?  For example makedumpfile, crash, and
kexec-tools (its vmcore-dmesg tool).


> This patch series also:
>  - adds OOM reporting on shrinkers, reporting on top 10 shrinkers (in sorted
>    order!)
>  - changes slab reporting to be always-on, also reporting top 10 slabs in sorted
>    order
>  - starts centralizing OOM reporting in mm/show_mem.c
>
> The last patch in the series is only a demonstration of how to implement the
> shrinker .to_text() method, since bcachefs isn't upstream yet.
>
> Kent Overstreet (4):
>   lib/printbuf: New data structure for heap-allocated strings
>   mm: Add a .to_text() method for shrinkers
>   mm: Centralize & improve oom reporting in show_mem.c
>   bcachefs: shrinker.to_text() methods
>
>  fs/bcachefs/btree_cache.c     |  18 ++-
>  fs/bcachefs/btree_key_cache.c |  18 ++-
>  include/linux/printbuf.h      | 140 ++++++++++++++++++
>  include/linux/shrinker.h      |   5 +
>  lib/Makefile                  |   4 +-
>  lib/printbuf.c                | 271 ++++++++++++++++++++++++++++++++++
>  mm/Makefile                   |   2 +-
>  mm/oom_kill.c                 |  23 ---
>  {lib => mm}/show_mem.c        |  14 ++
>  mm/slab.h                     |   6 +-
>  mm/slab_common.c              |  53 ++++++-
>  mm/vmscan.c                   |  75 ++++++++++
>  12 files changed, 587 insertions(+), 42 deletions(-)
>  create mode 100644 include/linux/printbuf.h
>  create mode 100644 lib/printbuf.c
>  rename {lib => mm}/show_mem.c (78%)
>
> --
> 2.35.2
>

Thanks
Dave

