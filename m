Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CA64849FE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiADVkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiADVkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:40:18 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E1C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 13:40:18 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m21so154898364edc.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 13:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJ+v55yUFiLI/4g7mFYq1QZLgbrpUXzZ9wJ+9sDmYqY=;
        b=dshp9e3zGhy1oAbNcYfkNWToEIOghrWZ0wBynLm22Q25H7Twu0+1Vn2n4vbi7LXHG7
         yzTSzC+9R9UVB6CXb1YasX8uRVerZbDEuDYu5lMPCZFXFJw8bany1Esz2QXiOcdcWYmU
         3/R0fH5lIcn9lDrWfU7WvV2t0+2TPrylTlYIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJ+v55yUFiLI/4g7mFYq1QZLgbrpUXzZ9wJ+9sDmYqY=;
        b=tI3QyVUHQgSnBbDWJPrPJy1Jo8+CAlIpEynhqF9j6nPxORBl86lXzzaqrqWHYFCR23
         Hp8UZ2HVSlHvfKc9ZXJXqhT6+ImNnQjrBE+uifG7lvXFCT280v/Ippk2o4CpgPCpebVI
         lX0qR+1uoLYZxR+vtrjhfQLqObS0WQk/lzH0qmbbZUDVOCk+MjNj6hGLfFPdZQPrhOEa
         oALC2ffBPGlx2Y9y0vTpdO4lw8Nx0pVkVtfB7dDmmumo8oMAXR3yPTUc4grdSBaR+UTe
         jad1CjaWCY6IvbwGUBIKlY7l5IUivfSMxqoDiiuk08vVhMOV8hC4ZqvdC9KnKKglaWuU
         IZ/A==
X-Gm-Message-State: AOAM531LFy0M2A1zDbW9d1YghsXryRclF8NLY308MPuGqW1N+JfMSIsY
        /7nv4qQEiDp6+DOdylGyEAIazhF8ujiy05ANIwc=
X-Google-Smtp-Source: ABdhPJwsSa9ack5YBdUFRg1qQGpl/Xs3+mPOct2Dj1gNmXVwjLlvAqIoE4ULYQGkHCM0cDvuN+ImAg==
X-Received: by 2002:aa7:d5c5:: with SMTP id d5mr50820664eds.251.1641332416991;
        Tue, 04 Jan 2022 13:40:16 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id ck14sm15145054edb.5.2022.01.04.13.40.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 13:40:16 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso512014wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 13:40:16 -0800 (PST)
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr243370wmq.152.1641332405774;
 Tue, 04 Jan 2022 13:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com> <20220104202227.2903605-10-yuzhao@google.com>
In-Reply-To: <20220104202227.2903605-10-yuzhao@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jan 2022 13:39:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjc3vpQfSTzJ8DwCVfmj6Mhq16d375cMPOgFB5A1EL2tw@mail.gmail.com>
Message-ID: <CAHk-=wjc3vpQfSTzJ8DwCVfmj6Mhq16d375cMPOgFB5A1EL2tw@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] mm: multigenerational lru: Kconfig
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, page-reclaim@google.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 12:23 PM Yu Zhao <yuzhao@google.com> wrote:
>
> Add configuration options for the multigenerational lru.
>         def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
>
> +config NR_LRU_GENS
> +       int "Max number of generations"
> +       depends on LRU_GEN
> +       range 4 31
> +       default 4
> +       help
> +         This option uses order_base_2(N+1) bits in page flags.
> +
> +         Do not configure more generations than you plan to use. They have a
> +         per-memcg and per-node memory overhead.
> +
> +config TIERS_PER_GEN
> +       int "Number of tiers per generation"
> +       depends on LRU_GEN
> +       range 2 5
> +       default 4
> +       help
> +         This option uses N-2 bits in page flags.
> +
> +         Larger values generally provide better protection for page cache when
> +         under heavy buffered I/O workloads.

These are not appropriate questions to ask users.

No user has any idea what the answer should be. And no, we don't add
"benchmark tuning Kconfig questions" to the kernel. We leave those
kinds of games to companies that need to fake their benchmark numbers.

If *you* can't give a good number for these config options, then no
user or distro can either.

So just pick a number, and stand by it.

Don't do this kind of "I don't know what the right number is, so I'll
just push the blame on the user".

                Linus
