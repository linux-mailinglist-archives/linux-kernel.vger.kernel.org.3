Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8824E5A86CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiHaTeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiHaTeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:34:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE6CE97E1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:34:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v5so8846852plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=62QFhQr6T6C7Uzxmu2f6DFJ53invGibIkOgnEF0w9j8=;
        b=QYOlLhfOjozgTvDXoCLG1/6hR8h5FU0lC6xF9i14v/hIQqRISEBBO9by+CXUNjWfcO
         h8RHWf5EK47xQniu//4ipT+DsI880Tm1TXxTfa72Vs8n1uL3DpQKnQGy44fI/MgafwXE
         aQOGwskAEnpV5nwo04nFZ+0XxczT0ehnN1jQ5YsRePySwBune4t4XOQEGofAMzBB5+8G
         DcrOOsAJH6+kehaClBpEj76s19xxqO10rXz//ta4v4vi3IRNKEC3mqQB69byxOuZTGuI
         EENk2cnoO1WhUifWWQZRLROzxajOvHmO0tCSpgs53Uc0yYx9PYWBYp+uxg+m/T30XD2N
         ssmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=62QFhQr6T6C7Uzxmu2f6DFJ53invGibIkOgnEF0w9j8=;
        b=5gVTOa0ZWJ5kXuUPCrfM1jWrrYxmIT5jifpicDsBVXMX9OmsIpCxXum8RXOSYl6TFm
         n5OPenZqRxOVDezAqDZEx0lfM8Hv2hGOztWQ+cTBZt9UVbNxv613yxQPTVKgWszUzp9X
         a7OAajgIFaBPdCYdB3QIt8GiiD12KQDVt0wmcGgsDL8vufYnxCnUKiGtU/mxTU15p3yG
         gEruT7TgG0gLvt7CthFptzjgdUT+k32+k18YZbcyimlP+M5I8xmqOpQd6K0dSxovcOl2
         zz84Kne6AGQ1Pme5VUiACK4CitLW+xdS+YhILzRBAHZV/cQC6B7WfrlQwQwKuzklJqFp
         CORw==
X-Gm-Message-State: ACgBeo2KGUUvHC14GTYxzRC4Iy7TgdSf+z69ZpuH6NPtBFOjDOwflu7z
        a5UYGvaMA7yS/AJYQK2tnXSoFq403a9b4SWtfPo=
X-Google-Smtp-Source: AA6agR5ez8Cp6iPT1GBGjr2gTSClklB5WWWNwunHMnskYb3QnFlZ6RA5eppLgiqw9MHml11fMvv374OyUmbO1W2pVRM=
X-Received: by 2002:a17:90b:1b49:b0:1fd:dccc:91f7 with SMTP id
 nv9-20020a17090b1b4900b001fddccc91f7mr4730514pjb.200.1661974460638; Wed, 31
 Aug 2022 12:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220831083024.37138-1-david@redhat.com> <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <4845ae71-b7dd-1707-ebc3-2eb3521e7fa0@redhat.com> <CAHbLzkoMMWAgai2bvgu7y5EAcKOhhx3gK+OA4v2+kOHBW4cauw@mail.gmail.com>
 <ab41f458-eb0f-5edb-ccab-643bf00d5110@redhat.com>
In-Reply-To: <ab41f458-eb0f-5edb-ccab-643bf00d5110@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 31 Aug 2022 12:34:08 -0700
Message-ID: <CAHbLzkpFqSBTv3HVye4UCKj93NPW8VRqCGZO1p5hk_wfNA_GtQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
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

On Wed, Aug 31, 2022 at 12:15 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 31.08.22 21:08, Yang Shi wrote:
> > On Wed, Aug 31, 2022 at 11:29 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 31.08.22 19:55, Yang Shi wrote:
> >>> On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
> >>>>
> >>>> The comment is stale, because a TLB flush is no longer sufficient and
> >>>> required to synchronize against concurrent GUP-fast. This used to be true
> >>>> in the past, whereby a TLB flush would have implied an IPI on architectures
> >>>> that support GUP-fast, resulting in GUP-fast that disables local interrupts
> >>>> from completing before completing the flush.
> >>>
> >>> Hmm... it seems there might be problem for THP collapse IIUC. THP
> >>> collapse clears and flushes pmd before doing anything on pte and
> >>> relies on interrupt disable of fast GUP to serialize against fast GUP.
> >>> But if TLB flush is no longer sufficient, then we may run into the
> >>> below race IIUC:
> >>>
> >>>          CPU A                                                CPU B
> >>> THP collapse                                             fast GUP
> >>>
> >>> gup_pmd_range() <-- see valid pmd
> >>>
> >>> gup_pte_range() <-- work on pte
> >>> clear pmd and flush TLB
> >>> __collapse_huge_page_isolate()
> >>>     isolate page <-- before GUP bump refcount
> >>>
> >>>    pin the page
> >>> __collapse_huge_page_copy()
> >>>     copy data to huge page
> >>>     clear pte (don't flush TLB)
> >>> Install huge pmd for huge page
> >>>
> >>> return the obsolete page
> >>
> >> Hm, the is_refcount_suitable() check runs while the PTE hasn't been
> >> cleared yet. And we don't check if the PMD changed once we're in
> >> gup_pte_range().
> >
> > Yes
> >
> >>
> >> The comment most certainly should be stale as well -- unless there is
> >> some kind of an implicit IPI broadcast being done.
> >>
> >> 2667f50e8b81 mentions: "The RCU page table free logic coupled with an
> >> IPI broadcast on THP split (which is a rare event), allows one to
> >> protect a page table walker by merely disabling the interrupts during
> >> the walk."
> >>
> >> I'm not able to quickly locate that IPI broadcast -- maybe there is one
> >> being done here (in collapse) as well?
> >
> > The TLB flush may call IPI. I'm supposed it is arch dependent, right?
> > Some do use IPI, some may not.
>
> Right, and the whole idea of the RCU GUP-fast was to support
> architectures that don't do it. x86-64 does it. IIRC, powerpc doesn't do
> it -- but maybe it does so for PMDs?

It looks powerpc does issue IPI for pmd flush. But arm64 doesn't IIRC.

So maybe we should implement pmdp_collapse_flush() for those arches to
issue IPI.

>
> --
> Thanks,
>
> David / dhildenb
>
