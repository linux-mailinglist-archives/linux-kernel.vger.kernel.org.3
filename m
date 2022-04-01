Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C358E4EF9DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351072AbiDASbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346187AbiDASb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:31:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0383D1DD3CB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:29:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y36so3573315lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXfQ41dnhqNPjhOF8sHal/04DrHuUCqWMTWlvhP7LiU=;
        b=Qlup9MiUqO50pzpeRX9BgIkFwhHgGMk8YdYuHW3pr/xdHWcu2gYZ6uNq3SftLfpWtk
         YmVbqj3LeRampNeEKP8nsaTHHB4JhkT+GFRMYUoGqwIYF2kDcqpEUzEPt3Ob6mdcM1mc
         or2YNbFkWbHP3PCuHqUWhM+qri+7bdQcouFuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXfQ41dnhqNPjhOF8sHal/04DrHuUCqWMTWlvhP7LiU=;
        b=1Z/c42kKLzK9CJx/wSsCIvyCk1S7xz4m1qt9tkQtqstmDzXfuWnaEGYTmUbbhhL787
         VlXO2bf4otIE3SzFrQ0KnQDm/PF26NeOL3xTRaCexmAND8vpOgfOMu8POEii3Tk1UGMe
         MF7TpA6cXZaX3tKszwZxPfk6JBhObSFdN0lsgqvkqaFh2nqY2EYAIXojTwWesiloOQF2
         8C0tkW6ge2+v+ndp7V4d6QbCRuIqTYzDeGYknqTN0bWonW94MFr/TB/oyh7Gu+8bRXhV
         3mAtC++C7O67CWNk2nvnhFMDKt+NcakFyuNesOXxMVhm7qUSBtbgAbJYDWh1ITy+JZOK
         jrAg==
X-Gm-Message-State: AOAM530FGp6ea1zS4gCeA4C5XWkwaMOpeI6R4KnHaLC3vnCLKtITU2/x
        FaFlaZyQvRaM620PLdyqAxs4ZLO55KyRGr5apis=
X-Google-Smtp-Source: ABdhPJwri1Qe28IjKkrnJVHDLhTd+j2zUt36zgCm8xPp8QZWpptkSQ3E+ScvtNP21N9MvrVXUUal9A==
X-Received: by 2002:ac2:4194:0:b0:442:ed9e:4a25 with SMTP id z20-20020ac24194000000b00442ed9e4a25mr14194062lfh.629.1648837776972;
        Fri, 01 Apr 2022 11:29:36 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id x18-20020a2e7c12000000b0024afe607a74sm262519ljc.30.2022.04.01.11.29.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 11:29:34 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id d5so6402617lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:29:34 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr14383562lfh.687.1648837773772; Fri, 01
 Apr 2022 11:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220401181109.1477354-1-zi.yan@sent.com> <20220401181109.1477354-2-zi.yan@sent.com>
In-Reply-To: <20220401181109.1477354-2-zi.yan@sent.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Apr 2022 11:29:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifQimj2d6npq-wCi5onYPjzQg4vyO4tFcPJJZr268cRw@mail.gmail.com>
Message-ID: <CAHk-=wifQimj2d6npq-wCi5onYPjzQg4vyO4tFcPJJZr268cRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: wrap __find_buddy_pfn() with a necessary buddy
 page validation.
To:     Zi Yan <ziy@nvidia.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, Apr 1, 2022 at 11:11 AM Zi Yan <zi.yan@sent.com> wrote:
>
> Whenever the buddy of a page is found from __find_buddy_pfn(),
> page_is_buddy() should be used to check its validity. Add a helper
> function find_buddy_page_pfn() to find the buddy page and do the check
> together.

Well, this certainly looks nicer, except now:

> +extern struct page *find_buddy_page_pfn(struct page *page, unsigned int order);

that 'pfn' no longer makes sense in the name, and

> @@ -1075,11 +1118,11 @@ static inline void __free_one_page(struct page *page,
>                                                                 migratetype);
>                         return;
>                 }
> -               buddy_pfn = __find_buddy_pfn(pfn, order);
> -               buddy = page + (buddy_pfn - pfn);
>
> -               if (!page_is_buddy(page, buddy, order))
> +               buddy = find_buddy_page_pfn(page, order);
> +               if (!buddy)
>                         goto done_merging;
> +               buddy_pfn = page_to_pfn(buddy);

This case now does two "page_to_pfn()" calls (one inside
find_buddy_page_pfn(), and one explicitly on the buddy).

And those page_to_pfn() things can actually be fairly expensive. It
*looks* like just a subtraction, but it's a pointer subtraction that
can end up generating a divide by a non-power-of-two size.

NORMALLY we try very hard to make 'sizeof struct page' be exactly 8
words, but I do not believe this is actually guaranteed.

And yeah, the divide-by-a-constant can be turned into a multiply, but
even that is not necessarily always cheap.

Now, two out of three use-cases didn't actually want the buddy_pfn(),
but this one use-case does look like it might be performance-critical
and a problem.

                 Linus
