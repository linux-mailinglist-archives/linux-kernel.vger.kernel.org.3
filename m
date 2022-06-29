Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BBE560B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiF2VOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiF2VOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:14:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA60D3E0E7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:14:10 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 9so16485427pgd.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uh5xB0eDoFAz75o4tEx7nxB4dG+eqxB73XoQEAhQu6A=;
        b=crIQSuiZpHpWVDRlRRZXxBzT9JT3p3a8YFeHlfLQBrFx8IG/tKYIGd07JELJEaGSRS
         KuT+mw7ONtKjF604oFmyEMQ6ReoHe4i4Ka8QFTFNyTt62BgSipnUTrJyAa6QG16BCTAD
         ShCdyTQ0brFHFSbCVtx/Crx4cLKrJpRzfz5dm42Yqr5oFA1K2rdv4PZ1cSj0O6pyUsnK
         gSkXccS2D6HUAJK1lXJ9PXQAj+WEFGG+IvPFdzmkhNm7iC3CmrCYC/udS7ZKCmFiQdoB
         amvNhT5D0VjI9PetR3eUtS+LYOSzKnTAKp2BNOfuWmmp6Y4gQXIg2Wznw8pX89ijySk5
         ALxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uh5xB0eDoFAz75o4tEx7nxB4dG+eqxB73XoQEAhQu6A=;
        b=ew4xo0SiKRjs0Iy1Eat+ONtBcfUabJotKjC13pgxGt3beQO7q2JPQ6vvsoZ3/f4Sn4
         FAL60BhLWNb2/Zsq0WBmpyDCUeIOLoluf/PZyepRSrapUgYreu0YzPfmT0a8yIw5cJcw
         kaQoKKW6UqXpnEFsAHG+J8xY5bOHOas+jS4dPFlWi5JjltcAxUg1RQPWEJuD8pVM6iXQ
         i43ZGqMmL9RVPHVaa/rqAbDxgqAlbtnRRnS5M8QQpBKmw5tdG1TwhuZldwiir2F/L+b4
         sLr2yVayqXg5BE5XsPgDOhmjumC+J7JHhO+LVuKqPevo3zuw9CUDtUq7Dws+EMfF5f7i
         PSmA==
X-Gm-Message-State: AJIora/sO09GLIsRHDd6YdretZOPhgznDTZ7goyjkaVfjWvfuevETsFU
        slHtkp00mjMCno0Ro4pCoDrN2FD7FfSOg1+gcB7gew==
X-Google-Smtp-Source: AGRyM1uYeRRrdzUbp+gG7X9xLJ2MtyiEEEaMkRn8o4AAmM6FY0HO4D109cCv1EAmZY9enbk7JlwYwjzbLJq2JUwnKNM=
X-Received: by 2002:a63:5d21:0:b0:40d:d9fd:7254 with SMTP id
 r33-20020a635d21000000b0040dd9fd7254mr4593326pgb.353.1656537250098; Wed, 29
 Jun 2022 14:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-3-jthoughton@google.com> <Yrn6DfTINknKNS04@monkey>
 <CADrL8HUD14o6XybhYDdozAUkJ4Zt6nE8=dm-_osKg2CmvOFzHg@mail.gmail.com>
 <YrvzlTU2z8/IrEuK@FVFYT0MHHV2J.usts.net> <Yry+uxxA2/wsK8G9@monkey>
In-Reply-To: <Yry+uxxA2/wsK8G9@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 29 Jun 2022 14:13:58 -0700
Message-ID: <CADrL8HVEKzUf2LYL2SeUS7fiHOPtvVJseZKqJpyqt9jBAKuO6g@mail.gmail.com>
Subject: Re: [RFC PATCH 02/26] hugetlb: sort hstates in hugetlb_init_hstates
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 2:06 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 06/29/22 14:39, Muchun Song wrote:
> > On Tue, Jun 28, 2022 at 08:40:27AM -0700, James Houghton wrote:
> > > On Mon, Jun 27, 2022 at 11:42 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > >
> > > > On 06/24/22 17:36, James Houghton wrote:
> > > > > When using HugeTLB high-granularity mapping, we need to go through the
> > > > > supported hugepage sizes in decreasing order so that we pick the largest
> > > > > size that works. Consider the case where we're faulting in a 1G hugepage
> > > > > for the first time: we want hugetlb_fault/hugetlb_no_page to map it with
> > > > > a PUD. By going through the sizes in decreasing order, we will find that
> > > > > PUD_SIZE works before finding out that PMD_SIZE or PAGE_SIZE work too.
> > > > >
> > > >
> > > > This may/will cause problems for gigantic hugetlb pages allocated at boot
> > > > time.  See alloc_bootmem_huge_page() where a pointer to the associated hstate
> > > > is encoded within the allocated hugetlb page.  These pages are added to
> > > > hugetlb pools by the routine gather_bootmem_prealloc() which uses the saved
> > > > hstate to add prep the gigantic page and add to the correct pool.  Currently,
> > > > gather_bootmem_prealloc is called after hugetlb_init_hstates.  So, changing
> > > > hstate order will cause errors.
> > > >
> > > > I do not see any reason why we could not call gather_bootmem_prealloc before
> > > > hugetlb_init_hstates to avoid this issue.
> > >
> > > Thanks for catching this, Mike. Your suggestion certainly seems to
> > > work, but it also seems kind of error prone. I'll have to look at the
> > > code more closely, but maybe it would be better if I just maintained a
> > > separate `struct hstate *sorted_hstate_ptrs[]`, where the original
> >
> > I don't think this is a good idea.  If you really rely on the order of
> > the initialization in this patch.  The easier solution is changing
> > huge_bootmem_page->hstate to huge_bootmem_page->hugepagesz. Then we
> > can use size_to_hstate(huge_bootmem_page->hugepagesz) in
> > gather_bootmem_prealloc().
> >
>
> That is a much better solution.  Thanks Muchun!

Indeed. Thank you, Muchun. :)

>
> --
> Mike Kravetz
