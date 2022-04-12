Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180054FCC63
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245558AbiDLCTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244856AbiDLCTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:19:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3EA33E12;
        Mon, 11 Apr 2022 19:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A7E2B81A03;
        Tue, 12 Apr 2022 02:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBF0C385A9;
        Tue, 12 Apr 2022 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649729808;
        bh=vnuU0Vf5uUFZG5hzr0+pY/uKtAP80ZJBw7evrhTy9Ww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GMRsVBfP5Tznj8S0EBzpLTJ7kD4d1BJImxQDaroOwYYzhRccW5wXVfJ8vrSq5EvuE
         xs4wOEgfHdMOAImk859vK8lLKcW73v6C28jJARbn8SgTBM3smEZPoyKAs57ItPWna+
         1n6Q1bPX3uNaxHA2GQBvc0bv7AXEJpuBZVVo6J1Q=
Date:   Mon, 11 Apr 2022 19:16:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?ISO-8859-1?Q? "Holger_Hoffst=E4tte" ?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 14/14] mm: multi-gen LRU: design doc
Message-Id: <20220411191645.91078752f29b82aea7ee508c@linux-foundation.org>
In-Reply-To: <20220407031525.2368067-15-yuzhao@google.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-15-yuzhao@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Apr 2022 21:15:26 -0600 Yu Zhao <yuzhao@google.com> wrote:

> Add a design doc.
> 
>
> ...
>
> +Design overview
> +===============
> +Objectives
> +----------
> +The design objectives are:
> +
> +* Good representation of access recency
> +* Try to profit from spatial locality
> +* Fast paths to make obvious choices
> +* Simple self-correcting heuristics
> +
> +The representation of access recency is at the core of all LRU
> +implementations. In the multi-gen LRU, each generation represents a
> +group of pages with similar access recency. Generations establish a
> +common frame of reference and therefore help make better choices,
> +e.g., between different memcgs on a computer or different computers in
> +a data center (for job scheduling).

Does MGLRU have any special treatment for used-once pages?

> +Exploiting spatial locality improves efficiency when gathering the
> +accessed bit. A rmap walk targets a single page and does not try to
> +profit from discovering a young PTE. A page table walk can sweep all
> +the young PTEs in an address space, but the address space can be too
> +large to make a profit. The key is to optimize both methods and use
> +them in combination.
> +
> +Fast paths reduce code complexity and runtime overhead. Unmapped pages
> +do not require TLB flushes; clean pages do not require writeback.
> +These facts are only helpful when other conditions, e.g., access
> +recency, are similar. With generations as a common frame of reference,
> +additional factors stand out. But obvious choices might not be good
> +choices; thus self-correction is required.
> +
> +The benefits of simple self-correcting heuristics are self-evident.
> +Again, with generations as a common frame of reference, this becomes
> +attainable. Specifically, pages in the same generation can be
> +categorized based on additional factors, and a feedback loop can
> +statistically compare the refault percentages across those categories
> +and infer which of them are better choices.
> +
> +Assumptions
> +-----------
> +The protection of hot pages and the selection of cold pages are based
> +on page access channels and patterns. There are two access channels:
> +
> +* Accesses through page tables
> +* Accesses through file descriptors
> +
> +The protection of the former channel is by design stronger because:
> +
> +1. The uncertainty in determining the access patterns of the former
> +   channel is higher due to the approximation of the accessed bit.
> +2. The cost of evicting the former channel is higher due to the TLB
> +   flushes required and the likelihood of encountering the dirty bit.
> +3. The penalty of underprotecting the former channel is higher because
> +   applications usually do not prepare themselves for major page
> +   faults like they do for blocked I/O. E.g., GUI applications
> +   commonly use dedicated I/O threads to avoid blocking the rendering
> +   threads.
> +
> +There are also two access patterns:
> +
> +* Accesses exhibiting temporal locality
> +* Accesses not exhibiting temporal locality
> +
> +For the reasons listed above, the former channel is assumed to follow
> +the former pattern unless ``VM_SEQ_READ`` or ``VM_RAND_READ`` is
> +present, and the latter channel is assumed to follow the latter
> +pattern unless outlying refaults have been observed.

What about MADV_SEQUENTIAL?    Or did we propogate that into the fd?

> +Workflow overview
> +=================
> +Evictable pages are divided into multiple generations for each
> +``lruvec``. The youngest generation number is stored in
> +``lrugen->max_seq`` for both anon and file types as they are aged on
> +an equal footing. The oldest generation numbers are stored in
> +``lrugen->min_seq[]`` separately for anon and file types as clean file
> +pages can be evicted regardless of swap constraints. These three
> +variables are monotonically increasing.
> +
>
> ...
>
> +Summary
> +-------
> +The multi-gen LRU can be disassembled into the following parts:
> +
> +* Generations
> +* Page table walks
> +* Rmap walks
> +* Bloom filters
> +* The PID controller
> +
> +The aging and the eviction is a producer-consumer model; specifically,
> +the latter drives the former by the sliding window over generations.
> +Within the aging, rmap walks drive page table walks by inserting hot
> +densely populated page tables to the Bloom filters. Within the
> +eviction, the PID controller uses refaults as the feedback to select
> +types to evict and tiers to protect.

It's cool to see a PID controller in there.

How do we know that it converges well, that it doesn't exhibit instability, etc?

