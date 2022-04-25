Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2491050EC56
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiDYXBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiDYXBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:01:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788293A5F5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:58:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u6-20020a17090a1f0600b001d86bd69427so767062pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/I7oaQmzvZvVLsaaj3AYps814z1htG5kX5EnwlbSP44=;
        b=RviRw+YceB7Rg0blJFW8YvIVKwTDqm1qJuVwiHNXPeIr0r53aLUL9STDSq8ck0GOO/
         KG9sk+owSOOf+daD4KNmj99m91Feb2diJ6VP1QH2g2QL/o19QIoLgA7QKvPqzaDz4bNv
         6ZH6LQ8Ueklr5M+iHrjRP2+J4HVNfaRemwp4Z23NanMXK87Nkd2KkkLfS9vyBuwIc3Ox
         2gGO0goYLRUnrx8doguglL1Uqlddi8IxSv0B4yOv+hexy0kWl9cHWCXTT4DJ6TkZYmw9
         NOrkKG1jCvOcIxCHK8k4hq6LYyEtZ4jqfNMy4Vx0QR6MnzjFEiUeCLrczPv6Uv/50zUz
         xnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/I7oaQmzvZvVLsaaj3AYps814z1htG5kX5EnwlbSP44=;
        b=M9/SbsD/M6vn5DhfbEkWmBjyN0BkI21zkmNS3OcjOC9+Kj1iNgzWHUE4xlDFplH+kJ
         OPsUU2mwA3zA2tJDmAbCxFvV3TCDDBoVUb9KlteQPmfbGw7DgS+RDbziIq+gmPV8MWp4
         64NqUoMF9dSlnfOu2Yj+OyEWG6rsm8QkB7CeA0qhe3vxYmEYJve87e7JHOXTTWfUU8hc
         f9JQUbQVpFdARR7GwIWPeGCrzkDr2uCaVAxS7BvvIiJ2R3VqGTYgQdbeCAvJPgQ+7/Ds
         a9f9InKGG1j4ju+Nh7rhpm7Km48atT07Eq3SZb6Nc9kcxlqF9ErS/UJi25EwatSoQKgF
         6rYw==
X-Gm-Message-State: AOAM531Wvc5FPlEjOSKT0v8psLFcFIVWpm2afnSQ/5GxciXyI7A8i2C+
        Vcy69vv7sa1j3UK6mTqCs0qQFCEr7L4=
X-Google-Smtp-Source: ABdhPJyCbn+0oNbCmdUD9RQa98a4NgJ97TLtDUYmc+7Shrbbk6/niJItR5fzXqzBIwnDoWdBPMXXUw==
X-Received: by 2002:a17:90a:550e:b0:1cd:e722:8b82 with SMTP id b14-20020a17090a550e00b001cde7228b82mr34310226pji.223.1650927515892;
        Mon, 25 Apr 2022 15:58:35 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:d773:e034:d79d:ca70])
        by smtp.gmail.com with ESMTPSA id w129-20020a628287000000b0050d4246fbedsm4090549pfd.187.2022.04.25.15.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 15:58:35 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 25 Apr 2022 15:58:33 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 0/6] Drain remote per-cpu directly
Message-ID: <YmcnmZBtZEgJrrUv@google.com>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420095906.27349-1-mgorman@techsingularity.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:59:00AM +0100, Mel Gorman wrote:
> This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> per-cpu lists drain support" -- avoid interference of a high priority
> task due to a workqueue item draining per-cpu page lists. While many
> workloads can tolerate a brief interruption, it may be cause a real-time
> task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> the draining in non-deterministic.

Yeah, the non-deterministic is a problem. I saw the kworker-based draining
takes 100+ms(up to 300ms observed) sometimes in alloc_contig_range if CPUs
are heavily loaded.

I am not sure Nicolas already observed. it's not only problem of
per_cpu_pages but it is also lru_pvecs (pagevec) draining.
Do we need to introduce similar(allow remote drainning with spin_lock)
solution for pagevec?

> 
> Currently an IRQ-safe local_lock protects the page allocator per-cpu lists.
> The local_lock on its own prevents migration and the IRQ disabling protects
> from corruption due to an interrupt arriving while a page allocation is
> in progress. The locking is inherently unsafe for remote access unless
> the CPU is hot-removed.
> 
> This series adjusts the locking. A spin-lock is added to struct
> per_cpu_pages to protect the list contents while local_lock_irq continues
> to prevent migration and IRQ reentry. This allows a remote CPU to safely
> drain a remote per-cpu list.
> 
> This series is a partial series. Follow-on work would allow the
> local_irq_save to be converted to a local_irq to avoid IRQs being
> disabled/enabled in most cases. However, there are enough corner cases
> that it deserves a series on its own separated by one kernel release and
> the priority right now is to avoid interference of high priority tasks.
> 
> Patch 1 is a cosmetic patch to clarify when page->lru is storing buddy pages
> 	and when it is storing per-cpu pages.
> 
> Patch 2 shrinks per_cpu_pages to make room for a spin lock. Strictly speaking
> 	this is not necessary but it avoids per_cpu_pages consuming another
> 	cache line.
> 
> Patch 3 is a preparation patch to avoid code duplication.
> 
> Patch 4 is a simple micro-optimisation that improves code flow necessary for
> 	a later patch to avoid code duplication.
> 
> Patch 5 uses a spin_lock to protect the per_cpu_pages contents while still
> 	relying on local_lock to prevent migration, stabilise the pcp
> 	lookup and prevent IRQ reentrancy.
> 
> Patch 6 remote drains per-cpu pages directly instead of using a workqueue.
> 
>  include/linux/mm_types.h |   5 +
>  include/linux/mmzone.h   |  12 +-
>  mm/page_alloc.c          | 333 ++++++++++++++++++++++++---------------
>  3 files changed, 222 insertions(+), 128 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
