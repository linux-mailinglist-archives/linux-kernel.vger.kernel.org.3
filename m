Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B8F5542A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349552AbiFVGW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348993AbiFVGWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:22:25 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A802F384
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:22:24 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id b4so4326148vkh.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XkLitP86rtDsNGNbm0pYZThHpLJXqkixx7LWXPpMas=;
        b=lV/C6bX6AorIyXEwUKhCPN4hfwYvOVc72nXEWyA16PukyWkFG0DvFmv6UUjVbQa/n/
         dBlQDAmwYcrP/bm5/Wyv7Vc9yoWw7v9Jm8SmGzSZOxcvCsDQEsxZlgnA1KhvecIkHvfv
         eoumq5reiZ6xTrsecj3D52UwphTC1hXbBTZt59ANbHd4hM0Et/l4TSagGnh2Hlm/TLT9
         sfZMYu0v1Kg/89RnQMWTNQYbk0Fk/GyUkSkoBEHLUFrMTWuM8dTFyhbbzKumcNAhg0po
         yH2nrG2A3dViKLmvyjsyNWXYWYSnOZ7y8VnP9qV0zyM8vGffeqVrbN7/D1bybfeAzNYa
         OtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XkLitP86rtDsNGNbm0pYZThHpLJXqkixx7LWXPpMas=;
        b=fj77FdIjo3tlJ8nJfyYFTJ6U/1JBCb1adX8eV5LtSubw76fBAYIhYCJRDpco4+Xo4O
         OeCDwYFgFu1dVQL6ubqIo6pLA9JcEgL18+whjixgW7owZIjO+LTXrnnTukqQXCOpgH8k
         iwk+r0456/on4qQLiPzhx6yR0KbqGdYANamwissyldXRbSMRtmAb7NgKiJbF7kOpFWNd
         ZpWy1kqcb3d08kY5XNdcOw3rrdf/RMETqxPQ263Jqz7xJE4XwAq8Bt31jUb6S8Fr4Y68
         Yj3xNQMljeLwol91ec7PHeSbKmMIyjyhAyu/epK3krqPUwJt47cnLOsoDfyjms0dI0yL
         VU/A==
X-Gm-Message-State: AJIora/Zcn8kb1S6tDBJqn8EpdrDOLa/EOxoJT3F/brAoJ4lORR6Zn94
        jG/CSsJQNq4kK4V1/Uif2s7WWCLzSo9tq2SCR+qfFw==
X-Google-Smtp-Source: AGRyM1uGOkTBGY7ctKwH9tj7aqZUuj0ObZQ8AcIdtefS/K84QQ9iakI+N0KjfrqW0Z/yfLxJn1WX37eYGSmcYBCl/qs=
X-Received: by 2002:a05:6122:1479:b0:36c:502b:fdda with SMTP id
 r25-20020a056122147900b0036c502bfddamr4569701vkp.14.1655878943347; Tue, 21
 Jun 2022 23:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220614071650.206064-1-yuzhao@google.com>
In-Reply-To: <20220614071650.206064-1-yuzhao@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 22 Jun 2022 00:21:47 -0600
Message-ID: <CAOUHufbuqGJJ1pUJuYW8h6uB5+KpNSJotEd_WSzF5AK-S_6PoA@mail.gmail.com>
Subject: Re: [PATCH v12 00/14] Multi-Gen LRU Framework
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 1:17 AM Yu Zhao <yuzhao@google.com> wrote:
>
> What's new
> ==========
> 1. Fixed a bug (using pmd_addr_end() when __PAGETABLE_PMD_FOLDED)
>    reported by:
>    Thomas Graichen <thomas.graichen@googlemail.com>
>    https://forum.armbian.com/topic/20018-mglru-patches-to-bring-down-kswapd-cpu-usage/
> 2. Retested on v5.19-rc1 and rebased to v5.19-rc2.
> 3. Nits.
>
> TLDR
> ====
> The current page reclaim is too expensive in terms of CPU usage and it
> often makes poor choices about what to evict. This patchset offers an
> alternative solution that is performant, versatile and
> straightforward.

I don't see any action items left for me. Are we good for the next merge window?
