Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A1C5A8841
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiHaVmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiHaVmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:42:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E5196742
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:42:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t5so15392782pjs.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NjRf8u0mv8cKmfOvGyjwyOrZtUjHTYSkAjDvlc9u+is=;
        b=YX4XnAZSJXkF5SYuEfT3jHkdzOmE23LlWh6dZ/ZRleW7y77ngN7nIKtUC9g1YoiDLV
         hZ6Nufm3YYWjgCe/3astrxymHmJHucLvSBliARFA+a+lrwwWtVrV61Rn435PtCJOt182
         TyeSB9ND6qkGhboFhboiRuHNHPRfZUHSz2s5y3CrUqNy6/Inll2JYbiNXWbp/Z9wQ8ln
         BJYXkDdCHzc7rxlp9WJBDBeNep0UM2fR80L4TYcgUR1vPAmRYD14LjID+yq3mEc84Isu
         jiFoXDn1sCk48Uzh/yYYmG6zkmHByAqB1xTvnhnvxVEq2TXG2zS6Vda5nKWr0HQvjWC9
         9H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NjRf8u0mv8cKmfOvGyjwyOrZtUjHTYSkAjDvlc9u+is=;
        b=2aBLsza4XlZoEIb0tbQ32AsyfDoqkkQNwXRltK7cEMd+SJIYb6vDRGm1NLSpTG2kMz
         LYtWLq0BRO/hlS2ZxLCztGWuMimHRaZSStym4ydsWjwlbEhuRmVyGTTl3NwOCOhLK9qU
         uHNAq6oZL9A65J4UzFSjYbki1yvN2cAdVL5kN6DrsluaQ18w7tXLTvxtYPi5X8ZBNqwj
         VzwrVPz7gPaxuQMQugYAdAOchia26CFlrxTFyeznEHJWWvb77a6apJb2thTyZE1/ai17
         25HtUBbf2mvW0xTNci0ur7fl89z2d+uJpGi0oNjlD4bag/fjqFsFu+IYvR9WfFco061Z
         c9mQ==
X-Gm-Message-State: ACgBeo3POFqk3AX1hlIv5jvV6jy/rROVwJ2AFJJeQgbF6N2AkCqKDObr
        Hy9rfq/Z2H7gsOUOGjnwq2YSuVC6x5ghEypbAhI=
X-Google-Smtp-Source: AA6agR5NjvFV+cbhRtZDeg48AkDYYDIq/0bwkPcwCkqMtNBBOCGP27YnSD+rCJ6IvL/JOkr2wrckQgFsFdtUTYhTlL4=
X-Received: by 2002:a17:903:32d0:b0:174:ce51:223f with SMTP id
 i16-20020a17090332d000b00174ce51223fmr16296481plr.117.1661982142031; Wed, 31
 Aug 2022 14:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220831083024.37138-1-david@redhat.com> <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <4845ae71-b7dd-1707-ebc3-2eb3521e7fa0@redhat.com> <CAHbLzkoMMWAgai2bvgu7y5EAcKOhhx3gK+OA4v2+kOHBW4cauw@mail.gmail.com>
 <ab41f458-eb0f-5edb-ccab-643bf00d5110@redhat.com> <CAHbLzkpFqSBTv3HVye4UCKj93NPW8VRqCGZO1p5hk_wfNA_GtQ@mail.gmail.com>
 <94c3217d-df73-2b6b-21f0-95baf117c584@redhat.com> <CAHbLzkp+HNmz7hGS5uDrfDDW0HpSj5Z+xmmkRbwvgn1qYk8Btg@mail.gmail.com>
 <f69772bf-1f42-fd0a-f23a-ed933888adc8@nvidia.com>
In-Reply-To: <f69772bf-1f42-fd0a-f23a-ed933888adc8@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 31 Aug 2022 14:42:09 -0700
Message-ID: <CAHbLzkrM-977rN1J4ppdr7ocMd91ngs=eHJX_h0uX+k-efXHxw@mail.gmail.com>
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 1:59 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 8/31/22 12:43, Yang Shi wrote:
> >>> It looks powerpc does issue IPI for pmd flush. But arm64 doesn't IIRC.
> >>>
> >>> So maybe we should implement pmdp_collapse_flush() for those arches to
> >>> issue IPI.
> >>
> >> ... or find another way to detect and handle this in GUP-fast?
> >>
> >> Not sure if, for handling PMDs, it could be sufficient to propagate the
> >> pmdp pointer + value and double check that the values didn't change.
> >
> > Should work too, right before pinning the page.
> >
> > pmdp_collapse_flush() is actually just called by khugepaged, so arch
> > specific implementation should not be a problem and we avoid making
> > gup fast more complicated.
> >
>
> And just to pile on, about that gup fast complexity: depending upon IPIs
> added a lot of complexity, not just because of the IPI dependency, but
> more importantly because only some arches even *have* IPIs. So an
> entirely different set of reasoning has to be used *in addition* to
> working through the IPI story. And sure enough, we can see the fallout:
> you are uncovering lots of half-correct comments in that area.
>
> So getting rid of the dependency on IPIs in gup fast would go a long way
> to simplifying it, and maybe even improving overall CPU load (insert
> some hand-wavy notes here about IPIs being worse than things like RCU).
>
> But the real win is in the complexity reduction in gup fast.

Thanks, John. Yeah, I still had some wrong impressions about how to
serialize against fast GUP. If you guys thought fixing the problem in
gup code is the preferred way, I won't insist on arch-specific
pmdp_collapse_flush().

>
>
> thanks,
>
> --
> John Hubbard
> NVIDIA
