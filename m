Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2634AD35C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349400AbiBHI1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349399AbiBHI1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:27:08 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526B5C03FEC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:27:07 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id b5so6962436ile.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=44T1HlXr7BuKORnt0ndhEiJslHbwl0ICNg4Sr/XHz9A=;
        b=Fzfpbyn7+b2s9yL3hUzIjl5MZBYGazEFVmXaeDrjIUeTtnDQ1OKoJyGAaKMtxyGBdd
         4S1ZxZrFHWKucVy3EVDiDlCD+GukmMqNELhAsJoSpYETtgs71v/eSRy8upPtMCw5WldL
         rt3deAo5QqvbMpsGjjXyu9cBWMJifParnnXDYP56kPIXheap/MgjK8ZH/RdsMKPQB6HC
         /BvTqTkhEd0OAYRI5Tu6cBy5LEC/2CU7nzKqW6W6PwC2DiTRG+wyIF6qCI+23T5iXNEO
         Jhi9jsf0AnZsftBtRnyi8NbBzkMyzYKHVPnZxJUTiWpmI67LrnD/P7YMneI+Z6FVVvSh
         9Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=44T1HlXr7BuKORnt0ndhEiJslHbwl0ICNg4Sr/XHz9A=;
        b=47qTvX8MI8yvYzCd/zK8DpToiH0JKvUT7hBTJr5w/2G+3J2ixnz5Z5OyceQsJX+Ue6
         m2X+iOlDKmnSxP3qBmhK1zvrYQRhkuIXvEsd/FSOlQH2L0WnTHiYA3rAoQBGk/swZJJt
         d5q9cnjrQ3ZfqlabER5dYqaFO0Yxu7fyDGdlbNNlJkffl8Ucy7VOPtdFi8b7j2r5I17v
         v9sBqzZ86sx5fSgXCJ5k0Au0RJ+LeA7eQsWBCQ055iguNoQZ7sCfMdJmql+w4g5Ri7Iu
         Ka2oamtaIfkHBNZVx5X2RYtEPvq6WrIh3c0kghqOr2epsISpTY9SiMG4eTdHckqrnk2i
         /sVQ==
X-Gm-Message-State: AOAM531QKKrmsm0YCw292viLrUo1uO3wNVi479O+GklT6e+RBoP6FCY/
        yXjTyYFuI/TuVB50KHQTHrQ8jg==
X-Google-Smtp-Source: ABdhPJxhgIu0UmLk8Z4r1+xA9jtb+cGWoKPZ+ozf9Iro3uQDBVD7tgKvOm4k7ftLHpOu/qObU3L4GQ==
X-Received: by 2002:a05:6e02:20c9:: with SMTP id 9mr1689066ilq.267.1644308826595;
        Tue, 08 Feb 2022 00:27:06 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5f31:19c3:21f5:7300])
        by smtp.gmail.com with ESMTPSA id e17sm6912666ilm.67.2022.02.08.00.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:27:06 -0800 (PST)
Date:   Tue, 8 Feb 2022 01:27:01 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 02/12] mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
Message-ID: <YgIpVegaNgaD2NNE@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-3-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208081902.3550911-3-yuzhao@google.com>
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

On Tue, Feb 08, 2022 at 01:18:52AM -0700, Yu Zhao wrote:
> Some architectures support the accessed bit in non-leaf PMD entries,
> e.g., x86 sets the accessed bit in a non-leaf PMD entry when using it
> as part of linear address translation [1]. Page table walkers that
> clear the accessed bit may use this capability to reduce their search
> space.
> 
> Note that:
> 1. Although an inline function is preferable, this capability is added
>    as a configuration option for the consistency with the existing
>    macros.
> 2. Due to the little interest in other varieties, this capability was
>    only tested on Intel and AMD CPUs.

Clarified ARCH_HAS_NONLEAF_PMD_YOUNG for x86 as requested here:
https://lore.kernel.org/linux-mm/CAHk-=wgvOqj6LUhNp8V5ddT8eZyYdFDzMZE73KgPggOnc28VWg@mail.gmail.com/

<snipped>

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9f5bd41bf660..e787b7fc75be 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -85,6 +85,7 @@ config X86
>  	select ARCH_HAS_PMEM_API		if X86_64
>  	select ARCH_HAS_PTE_DEVMAP		if X86_64
>  	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_NONLEAF_PMD_YOUNG

And enabled it for both 32-bit and 64-bit.

<snipped>
