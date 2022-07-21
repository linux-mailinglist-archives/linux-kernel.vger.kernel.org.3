Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A02557D45B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiGUTpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiGUTpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:45:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F70B1E6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:45:11 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w2so3055366ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWzcp1Z8HWXlZGBmd2SY3dRRfAqxHf8nagIP1lsSW5w=;
        b=GfvL2JFNB8yDOfrBzXPR28ePl1mIvysTBOgaKcjnGva2ZTymhmVH+3mZDIioZs5lAz
         ERjUW3sMTOYwCNHAp73jtQ3XmGcQ7PWTNHkwwhll77e/9uFc3rhIc7vnZLzass58FLiR
         /okJG5sVVAthcVmBD9xoLnJLj/WpWqPKr6BiB1nwz6JG2skQR1BPkGKiSs0d8fO2EEYW
         TMbSh4Nrx7DZ95TYYIjXRcebiQCguVpTU/h1LY2hwiDNIUp4EF+lJXAGeQ2H+gYvwFhy
         b4WbAq2uLtd0DWU9bueYB7oj4pPk7msqqTh2/EjsE4U9CNUKEBMdqkM9Rulr4M+RoQwE
         gfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWzcp1Z8HWXlZGBmd2SY3dRRfAqxHf8nagIP1lsSW5w=;
        b=0fR+RPe4MA2Xd1TqXajqnsowEXlYhREVdqWZ/W22XVhaCABoew7YbUZeEvJLOmU9ZC
         +ljUmQPJGcq04SwEGvxb8pG3D+ok4TE4ydh7YkzeTvFspQCUS/ztZsslpEMBgDzCgvh6
         e9vxQdlqjSBYWG2jVb2wpjkEYIaJY2uhIZvUNLFMTCeXEh5/wKCe6GEXksa2Q/T2wtPm
         DYq3lak6EC0/delUdi9eQQa+Pe5nIVuUpH7Gg9wLdyxEn7ynu/T9JgEqiM8BNZMGIAeD
         396lXuCQlltLZ9NMr/FJ8C/gzsPvSSPj8hh+g9k9M0pV4X4qmtuvAm31H8NgTp/MtXXG
         JqzA==
X-Gm-Message-State: AJIora8EKu0rZmo+xCusisy/b0Xjl2HMKyvCt6F3Be16sXjsmNYzCSu9
        qLEFZVDp72XIE8UPQ+eF8xMaMQF24pOaOFmtKkMeYA==
X-Google-Smtp-Source: AGRyM1u61sG92A3BoKVniDwQ4OfheO2BicDYZUFekdY25+Rm80SbqovMIgW9EWNRVmdUb7Zo5joN9hVOgLAkovEoeHE=
X-Received: by 2002:a2e:b011:0:b0:25d:6208:77b1 with SMTP id
 y17-20020a2eb011000000b0025d620877b1mr19085765ljk.469.1658432709589; Thu, 21
 Jul 2022 12:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-21-jthoughton@google.com> <YtGUARcBHxLU0axU@xz-m1.local>
 <CADrL8HXYab_VJS=Y0h2OSiCrj2pYbDJME2P=Tsn9jcDRbcqR1g@mail.gmail.com>
 <YtGh46Jr0EGpqW7s@xz-m1.local> <CADrL8HX1YbDArmPsGUH+7b6dNxDa3Xo+fd5npGgz=RFehSw6iA@mail.gmail.com>
 <YtmkX73/wzptkZbu@xz-m1.local>
In-Reply-To: <YtmkX73/wzptkZbu@xz-m1.local>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 21 Jul 2022 12:44:58 -0700
Message-ID: <CADrL8HVDtnDg0M4C4A7LN2dmnT2bMXSjJadE=guKFniK_EPdkQ@mail.gmail.com>
Subject: Re: [RFC PATCH 20/26] hugetlb: add support for high-granularity UFFDIO_CONTINUE
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 12:09 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jul 20, 2022 at 01:58:06PM -0700, James Houghton wrote:
> > > > > > @@ -335,12 +337,16 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> > > > > >       copied = 0;
> > > > > >       page = NULL;
> > > > > >       vma_hpagesize = vma_kernel_pagesize(dst_vma);
> > > > > > +     if (use_hgm)
> > > > > > +             vma_altpagesize = PAGE_SIZE;
> > > > >
> > > > > Do we need to check the "len" to know whether we should use sub-page
> > > > > mapping or original hpage size?  E.g. any old UFFDIO_CONTINUE code will
> > > > > still want the old behavior I think.
> > > >
> > > > I think that's a fair point; however, if we enable HGM and the address
> > > > and len happen to be hstate-aligned
> > >
> > > The address can, but len (note! not "end" here) cannot?
> >
> > They both (dst_start and len) need to be hpage-aligned, otherwise we
> > won't be able to install hstate-sized PTEs. Like if we're installing
> > 4K at the beginning of a 1G hpage, we can't install a PUD, because we
> > only want to install that 4K.
>
> I'm still confused...
>
> Shouldn't one of the major goals of sub-page mapping is to grant user the
> capability to do UFFDIO_CONTINUE with len<hpagesize (so we install pages in
> sub-page level)?  If so, why len needs to be always hpagesize aligned?

Sorry I misunderstood what you were asking. We allow both to be
PAGE_SIZE-aligned. :) That is indeed the goal of HGM.

If dst_start and len were both hpage-aligned, then we *could* set
`use_hgm = false`, and everything would still work. That's what I
thought you were asking about. I don't see any reason to do this
though, as `use_hgm = true` will only grant additional functionality,
and `use_hgm = false` would only -- at best -- be a minor performance
optimization in this case.

- James

>
> --
> Peter Xu
>
