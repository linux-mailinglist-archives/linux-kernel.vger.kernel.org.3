Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC794ECF9D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351604AbiC3W3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiC3W3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:29:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94D1574BF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:27:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k21so38285048lfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JgqxlWLyHstIckSDKjjoCouLEg7amiGpRRymZFR/zA=;
        b=Zh/xT7nLqNtODeuyx1eQC7EpPmZIj3FiqNlPnzXjYLYHJ+k4IHf5mbNqoul5HPReqR
         /V095x+Kk7ugjydArPyEOMrUwWT7GYESSfSWWIVaRi8gGRjjNBB/EUy8l6WeyXS2y1/J
         KNqB8W1MvIyho5mpJTPY6X6jtugnj84PJNP5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JgqxlWLyHstIckSDKjjoCouLEg7amiGpRRymZFR/zA=;
        b=losgg+QQmj1Uj5XBrgdLhNxDTVHHi2x06+K21WtYGw5ScfLWnTKAXRwMImMOmDYvpV
         f03kdyvAESkE9nWGWsVX1IGMkW0a9eUR/Tpyx3IDiLuUFNSBoOze92NDXNd0pE2PHYD/
         GUGRZtYJOPdl1EH5xuXeYY+Jjjqc22zpiDQG9M0g9hKqOFrqIoV1J7+NWV+7R/UZ2vPU
         +dVwIeJN3E2v2JUeNtp0gq/yNKdIyzbwQAZGzH95qis8bDqfVwRcvjCkCtvqHXsANqmR
         3p6KnHSt2UaOM4CM+Nncsq5N4V780uVYd4cTfOxzkesOwm+WvlfnyQgvEGlXbESAnola
         kJTw==
X-Gm-Message-State: AOAM532FA+zTBr7+L+58egnsSMF0rh74tz1iwN4KUa6QTGGqOo1DKjb+
        SMFzZ/sfSaDBHKC0NejgIkqtmAeQb324iwFR
X-Google-Smtp-Source: ABdhPJx15JrjPx5kBe1x8DYRyVEFpTrOE0tYv4oa4lSuH3Oggp5LNVIbpyLA4zvznR+xANZOUmEfTQ==
X-Received: by 2002:a05:6512:1398:b0:448:bda0:99f2 with SMTP id p24-20020a056512139800b00448bda099f2mr8369784lfa.681.1648679243940;
        Wed, 30 Mar 2022 15:27:23 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k18-20020a192d12000000b0044a5ddcf5fcsm2414179lfj.226.2022.03.30.15.27.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 15:27:21 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v12so16914234ljd.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:27:21 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr8732207lja.443.1648679241112; Wed, 30
 Mar 2022 15:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220330221238.396357-1-zi.yan@sent.com>
In-Reply-To: <20220330221238.396357-1-zi.yan@sent.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Mar 2022 15:27:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wji_AmYygZMTsPMdJ7XksMt7kOur8oDfDdniBRMjm4VkQ@mail.gmail.com>
Message-ID: <CAHk-=wji_AmYygZMTsPMdJ7XksMt7kOur8oDfDdniBRMjm4VkQ@mail.gmail.com>
Subject: Re: [PATCH] mm: page_alloc: validate buddy before check its migratetype.
To:     Zi Yan <ziy@nvidia.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 3:12 PM Zi Yan <zi.yan@sent.com> wrote:
>
> Whenever a buddy page is found, page_is_buddy() should be called to
> check its validity. Add the missing check during pageblock merge check.

Applied.

>                 buddy_pfn = __find_buddy_pfn(pfn, order);
>                 buddy = page + (buddy_pfn - pfn);
> +
> +               if (!page_is_buddy(page, buddy, order))
> +                       goto done_merging;

I wonder if that sequence shouldn't be made some helper function.

Also, looking around, I will note that unset_migratetype_isolate() in
mm/page_isolation.c is missing that "page_is_buddy()" check.

I _think_ it's probably ok because we checked

        if (PageBuddy(page)) {

on the (original, non-puddy) page, and then we only use the buddy page
pointer for that

                   if (!is_migrate_isolate_page(buddy)) {

and it's been like that for a _loong_ time.

But honestly, it feels like we would be better off with always having
the page_is_buddy() check anyway.

Or is there some reason why we don't want it here?

             Linus
