Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BBC4D2525
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiCIBF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCIBFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:05:09 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8643D136858
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:42:54 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z15so835257pfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9mwhzMPXsuBhWeNQaY1yLcs8fwNMTqk4ERNtUz41w0=;
        b=BDABS9uVQcFS/djzmKr84X48kvQ7FDJAHE5GyVdrdiXPfTAYC3kgAFEzfvB6h5+7Ne
         DKI04IYSdFHK205mfzwOunyx4PHkbqy5VyoQ+nymhIwFfW7fLx6kcpzrepYQtmDNfncI
         YRhh6zrCf45T/6Th5xWqyvHHaC1k7FaJUXexXtRN4AiXd2xH+N4D4P3m+p/ADG+Xg6ve
         AFjeP6Jm272NK/5u/t9B1O8Qh2xSavwE4p9U+Dr8Oiwr+ilU5lrCUw3f+pMoIIM882Va
         O0xSq8iwXs3eCyKaIJHJymhVdMnlCnaqFoNkx7QlKg6nFd850+5Z0Y1pVrPq8DGUnblw
         V87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9mwhzMPXsuBhWeNQaY1yLcs8fwNMTqk4ERNtUz41w0=;
        b=xXG4fbamR0X0V++pZvMLr9ud9LNeoACyb2KMoydq6l834wa9g1j1SKXPGxzOQTMfNE
         H9jHjdMid4xC6wARxfp0uIBEhmSc0w2ie6UHyDOhzCfLyS73LK2xwpbNHBQuk5myQFoo
         TuYOxQazOTMtf05nMAXGftdxpIIewAwvYeudar08L2toie7YQ3aCzCG0KIDWTSLgXHRV
         TU5XHWczJdWR1/5F9tKWI81AKb2a2Tyu51yTwZ74g/Tw3f8faI8KlM30D7rhCnNafoFb
         i4CIWPebu/2CMVRhjjzmU9ZffBWszBJYma1oEKDHVxGNTmWw8rPoBLXU6/CQ3vAxLeL9
         U0bA==
X-Gm-Message-State: AOAM533ESYdLXc8wGGQ/pGXsg1Wu8OPLAm7VXB/wcVmbobbggSx7MOp5
        NJlEK2w2kPqw9Fa9IQN23w17cJ4pdw2IbtbrGDgItJx+0BkN+JNv
X-Google-Smtp-Source: ABdhPJyBAfeSZLyjOQmRLVwYDPtCASEbExuTxYgwggPQnIDguzuOxXWN2t0qp9chTtu67kkdtr9sUGRdA8hf3NSsJIk=
X-Received: by 2002:a1f:314b:0:b0:331:fff6:a89e with SMTP id
 x72-20020a1f314b000000b00331fff6a89emr8182208vkx.26.1646784902851; Tue, 08
 Mar 2022 16:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20220308234723.3834941-1-yuzhao@google.com> <CAHk-=wi5wg=72exwHODJdVtAfqa1e85dGfjGftuhHQ5Z4v-DNA@mail.gmail.com>
In-Reply-To: <CAHk-=wi5wg=72exwHODJdVtAfqa1e85dGfjGftuhHQ5Z4v-DNA@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 8 Mar 2022 17:14:51 -0700
Message-ID: <CAOUHufYFDawK6vmkQ16EQm7FSHresViifnxW2yj_RDuMSjJPjg@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] Multi-Gen LRU Framework
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Mar 8, 2022 at 5:07 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Mar 8, 2022 at 3:48 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > The current page reclaim is too expensive in terms of CPU usage and it
> > often makes poor choices about what to evict. This patchset offers an
> > alternative solution that is performant, versatile and
> > straightforward.
>
> So apart from my complaints about asking users config questions that
> simply should not be asked, I really think this just needs to start
> getting merged.
>
> We've seen several numbers on the upsides, and I don't think we'll see
> any of the downsides until we try it. And I don't think there is any
> question that we _shouldn't_ try it, given the numbers posted.
>
> But yeah, I certainly _hope_ that all the benchmarking has been done
> with a unified set of config values, and it's not some kind of bogus
> "cherry-picked config values for this particular machine" kind of
> benchmarking that has been done.
>
> Because that isn't valid benchmarking - comparing some "tuned for this
> paeticular machine or load" setup to a default one is just not worth
> even setting numbers to, and debases the whole value of posting
> results.

All benchmarks were done with the default config values. I'm removing
those config options now.

This sounds self-serving: our data centers want them, so I had to try.
