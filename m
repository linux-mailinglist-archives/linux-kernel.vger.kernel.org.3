Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2A44F7377
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiDGD0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiDGD0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:26:38 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC5733E0C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:24:39 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id r1so2427756vsi.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 20:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXDoG2g2jwih4Ta9g6SsrLn0dnPRuy1eOEj+ZKrL1z0=;
        b=Z4BeYKfpWPYRzcHAxen+yREF0lc1qo4VdR5KzsT0cfZjxxnF1Z29F5RCDuxxSTp5uQ
         3RyRHjpSt4YcVLD6TTcb7BEFmkw/QbX2ZMf489+9mEySejhjZGdwbnGGgplOd1jwH+fd
         wIp7/NnZ9iyfV5j9Mq+A9ogFhxQT2hNGFnmDCuJTTATa2JWvEosbVebQDLu/9M3mH2XW
         EfBL5zM1kvN0s/DNhKM51dS5e80jIrpf1M9D+zYru8BHaXbVc8fxuZLQSXaTtT8ag9FT
         omstZc/WVRk+I7i/H6VlTT7Kx7M5pC8YnQF+pdTgN4k7RfHsB1J9gKWIlL2GkN+9o5wL
         mgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXDoG2g2jwih4Ta9g6SsrLn0dnPRuy1eOEj+ZKrL1z0=;
        b=L5pHm6emfiwHH7qaj7ORAzk67BQq9hJsKJdRbwa2o0/Trub/A90bZGtR27UsAW7/je
         qPxgXh7qx+wIh0dwdbsmfmMphqAzDVM1RdED7MCcYeqwPwekjISOZltMfXBGmoRrF+Lo
         daqoQFfMZz81gLAVZK0qt3mszJg3UgEaPY2SSKfJYbc4mzT3eL8qufIniHS9xfnZw2/a
         qcyomYn/d2F/BAkMGe0fnC2V/suTAzyfUAvMNACbmyvVje9z19DtzTiDR4MbBm7ZcHgo
         qjQ7qC1MSWtg9b0gT7/3fXA1j3gr7uJBMDqbT+idLk6KeQtf8YiLL9VBf8AuBALg3yDk
         YfTQ==
X-Gm-Message-State: AOAM530ThEZz0npip5ULPSLShH6Jcp5fZ28KCW+hl2d5YJNENQRdEjJV
        T/T558ioVcRxdS79y6p/HQoKziobqj3ly0pcgDhxpg==
X-Google-Smtp-Source: ABdhPJwrQQIytIzXL/+SDkqLEJGG+5KzqTudCk9LM36GaMAN5lfZyghvmm3JxJvTyb4WWqBgS87nhXIBfGcmOQSDBs8=
X-Received: by 2002:a05:6102:5cc:b0:320:9bd2:3823 with SMTP id
 v12-20020a05610205cc00b003209bd23823mr3900955vsf.81.1649301878415; Wed, 06
 Apr 2022 20:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com>
In-Reply-To: <20220407031525.2368067-1-yuzhao@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 6 Apr 2022 21:24:27 -0600
Message-ID: <CAOUHufZ8x5B-e+Wwgrh+qWryf8dAbfMWVEE0s-AfwZ-H7DouQg@mail.gmail.com>
Subject: Re: [PATCH v10 00/14] Multi-Gen LRU Framework
To:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 9:15 PM Yu Zhao <yuzhao@google.com> wrote:
>
> TLDR
> ====
> The current page reclaim is too expensive in terms of CPU usage and it
> often makes poor choices about what to evict. This patchset offers an
> alternative solution that is performant, versatile and
> straightforward.

<snipped>

> Summery
> =======
> The facts are:
> 1. The independent lab results and the real-world applications
>    indicate substantial improvements; there are no known regressions.
> 2. Thrashing prevention, working set estimation and proactive reclaim
>    work out of the box; there are no equivalent solutions.
> 3. There is a lot of new code; nobody has demonstrated smaller changes
>    with similar effects.
>
> Our options, accordingly, are:
> 1. Given the amount of evidence, the reported improvements will likely
>    materialize for a wide range of workloads.
> 2. Gauging the interest from the past discussions [22][23][24], the
>    new features will likely be put to use for both personal computers
>    and data centers.
> 3. Based on Google's track record, the new code will likely be well
>    maintained in the long term. It'd be more difficult if not
>    impossible to achieve similar effects on top of the current
>    active/inactive LRU.

Hi Stephen,

Can you please include this patchset in linux-next? Git repo for you to fetch:

https://linux-mm.googlesource.com/mglru for-linux-next

My goal is to get additional test coverage before I send a pull
request for 5.19 to Linus.

I've explored all avenues, but ultimately I've failed to rally
substantial support from the MM stakeholders [1]. There are no pending
technical issues against this patchset [2]. What is more concerning
are the fundamental disagreements on priorities, methodologies, etc.
that are not specific to this patchset and have been hindering our
progress as a collective. (Cheers to the mutual dissatisfaction.)

While we plan to discuss those issues during the LSFMM next month, it
doesn't seem reasonable to leave this patchset hanging in the air,
since it has reached its maturity a while ago and there are strong
demands from downstream kernels as well as a large user base. Thus I
sent that pull request to Linus a couple of weeks ago, implying that
he would have to make the final decision soon.

I hope this gives enough background about what's been going on with
this patchset. If you decide to take it and it causes you any
troubles, please feel free to yell at me.

Thanks!

[1] https://lore.kernel.org/r/20220104202227.2903605-1-yuzhao@google.com/
[2] https://lore.kernel.org/r/20220326010003.3155137-1-yuzhao@google.com/
