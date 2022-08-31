Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87985A884E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiHaVo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiHaVox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:44:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD553270B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:44:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso539131pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WRCQZgWLTXU/lpwaQlz63bh8ZvhuW6knrkLWrQ9v+Ds=;
        b=DHX2VRhksok+uLiBnn5V9eNyQQ6MwdoobPxth/5Ok1rK0Lb3E4TIsiEGwWMxYGYSQx
         Dj8Dxjvu4F/y2801SdQtXiPkrNlyF0leyPC/W4BzZi8Zfg1KqA9jMIFPRQJ6NSQhH0si
         82PMXpVUg1TEwi58+eg/k8yoxwvaU4rCjawWNsKU5KdWNU9VwI424vkwqBQhEd7E2WhL
         UPLGytahb8T6YERt11ky+8I2I1+xEKdk69wgypF+QqLyKdukTML83N7Qa24y3ywsR4Zd
         jJ68BV04GQryJkVUgSR2vQh3eCAIuTAAtHy0UdswJ9yIf05/3LJM28UfxsnPYI0WRsgc
         yzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WRCQZgWLTXU/lpwaQlz63bh8ZvhuW6knrkLWrQ9v+Ds=;
        b=GJI7ernKfVT4e7ujji/3uiqqcCNEl39svRHekW7KQc9VaNeijoiNIfRSd3UCbtCl+v
         TSp4qBLsML0jo8hTAwaWgiRQg8K5Srx9ghBeh8MVB8Q0TwhqtZNGJwdENJ2+j+xHPWxF
         NGVnGLm1cFdshiGUbAhzx70FW1PUH3Ua5OdAXVxX09EoP4WCUsciDV/THn9DFvWdiD4N
         OgpN9foANM7l88J7Tl2idgDE5vN7Fg63AUaNibZPR69q1+DjRTsKaXjCT9Cf104CFYll
         Q8L62vWSNiboYQ+plEGLVw7XNaaQnAUzLHjLly0jqHs+sP7GF23CHSzRb5zpfzAdllMw
         2l0g==
X-Gm-Message-State: ACgBeo1+Io8YUcTHglVwFIChmlQVrQQjyE1/DpCDBzNEo+IyjQPOfm9O
        59Xtrfm3by549oUUcJA23VczP0BFJRSFM3PGDns=
X-Google-Smtp-Source: AA6agR6yLUEaa+unbuL6M919BQOAcjP+MXwl8XGRVKd+X2QiYw2s3p6yCo+0ISBgxX/ZLvYXfuU7FGSjEpnZrt00xKU=
X-Received: by 2002:a17:902:e5c3:b0:175:534:1735 with SMTP id
 u3-20020a170902e5c300b0017505341735mr11716724plf.87.1661982286512; Wed, 31
 Aug 2022 14:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220831083024.37138-1-david@redhat.com> <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <Yw+uASvgWU5+9PvI@xz-m1.local> <CAHbLzkpH=a-gbwZYfJx6qD_Rvz6AEP+xwCKDbwJRPNt9W3Anxg@mail.gmail.com>
 <Yw/N/RuCdcjlOZPS@xz-m1.local>
In-Reply-To: <Yw/N/RuCdcjlOZPS@xz-m1.local>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 31 Aug 2022 14:44:33 -0700
Message-ID: <CAHbLzkr0Qf_fbfLLhnYM6ADe7+JCyjxn71b1TvRoW6zZ6RZ1Aw@mail.gmail.com>
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
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

On Wed, Aug 31, 2022 at 2:09 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Aug 31, 2022 at 01:38:21PM -0700, Yang Shi wrote:
> > On Wed, Aug 31, 2022 at 11:52 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Wed, Aug 31, 2022 at 10:55:43AM -0700, Yang Shi wrote:
> > > > On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
> > > > >
> > > > > The comment is stale, because a TLB flush is no longer sufficient and
> > > > > required to synchronize against concurrent GUP-fast. This used to be true
> > > > > in the past, whereby a TLB flush would have implied an IPI on architectures
> > > > > that support GUP-fast, resulting in GUP-fast that disables local interrupts
> > > > > from completing before completing the flush.
> > > >
> > > > Hmm... it seems there might be problem for THP collapse IIUC. THP
> > > > collapse clears and flushes pmd before doing anything on pte and
> > > > relies on interrupt disable of fast GUP to serialize against fast GUP.
> > > > But if TLB flush is no longer sufficient, then we may run into the
> > > > below race IIUC:
> > > >
> > > >          CPU A                                                CPU B
> > > > THP collapse                                             fast GUP
> > > >
> > > > gup_pmd_range() <-- see valid pmd
> > > >
> > > > gup_pte_range() <-- work on pte
> > > > clear pmd and flush TLB
> > > > __collapse_huge_page_isolate()
> > > >     isolate page <-- before GUP bump refcount
> > > >
> > > >    pin the page
> > > > __collapse_huge_page_copy()
> > > >     copy data to huge page
> > > >     clear pte (don't flush TLB)
> > > > Install huge pmd for huge page
> > > >
> > > > return the obsolete page
> > >
> > > Maybe the pmd level tlb flush is still needed, but on pte level it's
> > > optional (where we can rely on fast-gup rechecking on the pte change)?
> >
> > Do you mean in khugepaged?
>
> What I wanted to say before was that the immediate tlb flush (after pgtable
> entry cleared) seems to be only needed by pmd level to guarantee safety
> with concurrent fast-gup, since fast-gup can detect pte change after
> pinning, and that should already guarantee safe concurrent fast-gup to me.

Yeah, so ptep_clear() is used in __collapse_huge_page_copy() instead
of clear and flush.

>
> After reading the other emails, afaiu we're on the same page.
>
> > It does TLB flush, but some arches may not use IPI.
>
> Yeah, I see that ppc book3s code has customized pmdp_collapse_flush() to
> explicit do the IPIs besides tlb flush using smp calls.
>
> I assume pmdp_collapse_flush() should always be properly implemented to
> guarantee safety against fast-gup, or I also agree it could be a bug.

This was what I thought before I saw this patch.

>
> --
> Peter Xu
>
