Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8F456BDAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiGHPwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238687AbiGHPwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:52:24 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C0374358
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:52:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q7so4050254lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ig0fLrjOD+WwRJX7jkWejWy3+d6k4pKBLJTMMKQa5iw=;
        b=Mqyh4QjFFCuoyNFr0CN3GLBew8pB06B9rmKexH6PXBNdnsPjA5Md58/XIpQPVB/SNx
         Fdg8T4Ihda5R1AerM47HKWqBiOFLE8uPspnFzm+sW8yi7Ohju85s8b7XnBWV0CHYkWUC
         48mFRh6Ylo+QzrkP4bYNWMtxoR3Ao8BN4JbJKfy8P0TgVyJUqoX+wX1i7U0gDsQt5w00
         n6vsEzz7vAVsXrPjUbIBtNB+N5rdmQt3277QmVWNukYdf5ZT/tPO1sUDJzL2oM3okjyQ
         FV4gg0QAMhTV3U3YiD9rXSbc9NVfTiYmcX6Nc+slay1zNuSVWQs6lf2ecXGwhwCJTuIa
         pXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ig0fLrjOD+WwRJX7jkWejWy3+d6k4pKBLJTMMKQa5iw=;
        b=bwWQ5imt4SlM2iXItBfDTSYd7QsDb+8wDU3MWVXAReLv++lPtowuqSQ7iDbTMQDlTg
         bVk+HiPab0o9WhWxIml1ozT8oaLXiv0OTp2uPwHjfaMpMJXVKbg1fRDk8GE8zQRBct+n
         pjqUyYpDePtfHPkcuMTxbOFvzuieAHOWTfgou3iY38wr35ODuaCm6y6diQNSNHC1PbMo
         kjsycQ6EvbfJe12p/qJMdvRjWxvd7b+Fo3KtqscrN6M2J6q9RB2T8Xv+kFPfyEPEMa71
         rp4l8kqt+8wxooQydZ5BBhrsA5PQTWOY1ns0nXawyAJWpognHkpkWP+uNQjdLWPbaaHa
         4Sjw==
X-Gm-Message-State: AJIora+mNX6Wn2K0UKdnHw6q99RWTN8XVZj3UyhAcg+Dm6ESpOXbW/jy
        KD3aJlfS2/y8NymSmz9RX1am7lVezS/WIrIEeQZZJQ==
X-Google-Smtp-Source: AGRyM1ugMc7DOpiIBjn/5wZrEmy+dmJqdHB2WXpFBf34um1n4FQVNb4QbC6I50CLT1WURSb9AoEHk6VCeeVSYQgB6NM=
X-Received: by 2002:a2e:7006:0:b0:25c:3f3c:c6dc with SMTP id
 l6-20020a2e7006000000b0025c3f3cc6dcmr2272781ljc.469.1657295541820; Fri, 08
 Jul 2022 08:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-11-jthoughton@google.com> <CAHS8izNO+4Nzg=rgr1R027i2Evo-UKiFEK1gQcMHtF8uxcHzeQ@mail.gmail.com>
In-Reply-To: <CAHS8izNO+4Nzg=rgr1R027i2Evo-UKiFEK1gQcMHtF8uxcHzeQ@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Fri, 8 Jul 2022 08:52:10 -0700
Message-ID: <CADrL8HWuDZKf+9ERzNGNqneEdotSnKHf7cqZs0enVJj30gOULw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/26] hugetlb: add for_each_hgm_shift
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Tue, Jun 28, 2022 at 2:58 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
> >
> > This is a helper macro to loop through all the usable page sizes for a
> > high-granularity-enabled HugeTLB VMA. Given the VMA's hstate, it will
> > loop, in descending order, through the page sizes that HugeTLB supports
> > for this architecture; it always includes PAGE_SIZE.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  mm/hugetlb.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 8b10b941458d..557b0afdb503 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6989,6 +6989,16 @@ bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> >         /* All shared VMAs have HGM enabled. */
> >         return vma->vm_flags & VM_SHARED;
> >  }
> > +static unsigned int __shift_for_hstate(struct hstate *h)
> > +{
> > +       if (h >= &hstates[hugetlb_max_hstate])
> > +               return PAGE_SHIFT;
>
> h > &hstates[hugetlb_max_hstate] means that h is out of bounds, no? am
> I missing something here?

Yeah, it goes out of bounds intentionally. Maybe I should have called
this out. We need for_each_hgm_shift to include PAGE_SHIFT, and there
is no hstate for it. So to handle it, we iterate past the end of the
hstate array, and when we are past the end, we return PAGE_SHIFT and
stop iterating further. This is admittedly kind of gross; if you have
other suggestions for a way to get a clean `for_each_hgm_shift` macro
like this, I'm all ears. :)

>
> So is this intending to do:
>
> if (h == hstates[hugetlb_max_hstate]
>     return PAGE_SHIFT;
>
> ? If so, could we write it as so?

Yeah, this works. I'll write it this way instead. If that condition is
true, `h` is out of bounds (`hugetlb_max_hstate` is past the end, not
the index for the final element). I guess `hugetlb_max_hstate` is a
bit of a misnomer.

>
> I'm also wondering why __shift_for_hstate(hstate[hugetlb_max_hstate])
> == PAGE_SHIFT? Isn't the last hstate the smallest hstate which should
> be 2MB on x86? Shouldn't this return PMD_SHIFT in that case?

`huge_page_shift(hstate[hugetlb_max_hstate-1])` is PMD_SHIFT on x86.
Actually reading `hstate[hugetlb_max_hstate]` would be bad, which is
why `__shift_for_hstate` exists: to return PAGE_SIZE when we would
otherwise attempt to compute
`huge_page_shift(hstate[hugetlb_max_hstate])`.

>
> > +       return huge_page_shift(h);
> > +}
> > +#define for_each_hgm_shift(hstate, tmp_h, shift) \
> > +       for ((tmp_h) = hstate; (shift) = __shift_for_hstate(tmp_h), \
> > +                              (tmp_h) <= &hstates[hugetlb_max_hstate]; \

Note the <= here. If we wanted to always remain inbounds here, we'd
want < instead. But we don't have an hstate for PAGE_SIZE.

> > +                              (tmp_h)++)
> >  #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> >
> >  /*
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
