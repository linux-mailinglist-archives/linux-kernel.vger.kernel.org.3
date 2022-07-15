Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC3F57690B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiGOVjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiGOVjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:39:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC3A45F74
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:39:49 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id u6so4872640iop.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uc9JvdGtnz1cDXKpEDUcIxRWMtP2VMyjnf747zqikT8=;
        b=IJ2Q+vAcfQe9RtZffLh4MCy7kJfCZmgPGturk9SuapdVnvK2bDmK6MJJxytIcIgDbX
         3+fQ04LCQS6ZVbpSOdlTBQg9Kw8KSVVZgV4a1G6OqoDFcMv7ocgmeigy2qIYASFqmJcf
         JRafmCUDHDp7WRDTAoJmqlfE1rsIr2PvE8TcxPtJirJnMkcUV5Mq67xJY2PjHiT+mwM0
         fMXT/WYl9hmU4W6mT/1fhIRdPAZ9kc1F7G2eL2uzmehQWIKIciAKG4zzFVj621a8WOEe
         CUdNbsaxRAJP7j7qt8gpQdEG+z8hrvm799iBGjiccZgoZEJ0dZAzAYFPtQPdHN9v6+cC
         eE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uc9JvdGtnz1cDXKpEDUcIxRWMtP2VMyjnf747zqikT8=;
        b=a6PfPf0aMahSi1TSWcCmVBWB0m6uPF++ENlmtwrgzYuopTJlpsisocIXsjyqMnKRRE
         2JnMhINUvDmgkzj+qxLtOtimSGddo+vqvEU9u5YEskYJ797QrRPzTQQzpA/4ZnEHl0i9
         MOpaPFl+UP6sIeMok50ZaANxbUu+BnbMfeOff+ioZlGtAZljg78qRcgyB/I9WlHORORq
         iFDUyTg3z76wMwku3xKc42z0WLfzduz3rLVNnlYq7foIaCB26DS1U/sKvGmmRFY+ulyw
         MWjSxo1VMuGPQNgstuYR1zcSZhJfjjY65EKm6Yww/P2DHCvZmcWMAkUpJmDIPGJ2d8co
         tdTg==
X-Gm-Message-State: AJIora9e9iCM9lLu3LHQZ2IDqDaTR3W98VsF5f41wc5C7r2xv+TpoSrA
        fiRPQB0L6/20pKtVXW/gv7V+NIgHYecKnnIskZf1JQ==
X-Google-Smtp-Source: AGRyM1tx9DmhVc6Le8ZEuPg6+4G/yQrWP+fnjYsp11lPImuBLrU6K1uGKVrIc7EmFI04BGNaPnRmiVG/oX22EU/qt2s=
X-Received: by 2002:a05:6602:1644:b0:678:8ba4:8df6 with SMTP id
 y4-20020a056602164400b006788ba48df6mr7849416iow.138.1657921188370; Fri, 15
 Jul 2022 14:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-20-jthoughton@google.com> <Ysy1EySRmjxl2TmQ@monkey>
 <CADrL8HVimb9qx8fjhgFMfj2hWwD3+6_ZY7W=gHbf6as6qbiLYQ@mail.gmail.com> <Ys24P1ODVr+3/P0p@monkey>
In-Reply-To: <Ys24P1ODVr+3/P0p@monkey>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 15 Jul 2022 14:39:12 -0700
Message-ID: <CAJHvVcivDwscFMt68PZOtkejPxCKKOuJUuOffr289YocpWkh3A@mail.gmail.com>
Subject: Re: [RFC PATCH 19/26] hugetlb: add HGM support for copy_hugetlb_page_range
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jul 12, 2022 at 11:07 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 07/12/22 10:19, James Houghton wrote:
> > On Mon, Jul 11, 2022 at 4:41 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > >
> > > On 06/24/22 17:36, James Houghton wrote:
> > > > This allows fork() to work with high-granularity mappings. The page
> > > > table structure is copied such that partially mapped regions will remain
> > > > partially mapped in the same way for the new process.
> > > >
> > > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > > ---
> > > >  mm/hugetlb.c | 74 +++++++++++++++++++++++++++++++++++++++++-----------
> > > >  1 file changed, 59 insertions(+), 15 deletions(-)
> > >
> > > FYI -
> > > With https://lore.kernel.org/linux-mm/20220621235620.291305-5-mike.kravetz@oracle.com/
> > > copy_hugetlb_page_range() should never be called for shared mappings.
> > > Since HGM only works on shared mappings, code in this patch will never
> > > be executed.
> > >
> > > I have a TODO to remove shared mapping support from copy_hugetlb_page_range.
> >
> > Thanks Mike. If I understand things correctly, it seems like I don't
> > have to do anything to support fork() then; we just don't copy the
> > page table structure from the old VMA to the new one.
>
> Yes, for now.  We will not copy the page tables for shared mappings.
> When adding support for private mapping, we will need to handle the
> HGM case.
>
> >                                                       That is, as
> > opposed to having the same bits of the old VMA being mapped in the new
> > one, the new VMA will have an empty page table. This would slightly
> > change how userfaultfd's behavior on the new VMA, but that seems fine
> > to me.
>
> Right.  Since the 'mapping size information' is essentially carried in
> the page tables, it will be lost if page tables are not copied.
>
> Not sure if anyone would depend on that behavior.
>
> Axel, this may also impact minor fault processing.  Any concerns?
> Patch is sitting in Andrew's tree for next merge window.

Sorry for the slow response, just catching up a bit here. :)

If I understand correctly, let's say we have a process where some
hugetlb pages are fully mapped (pages are in page cache, page table
entries exist). Once we fork(), we in the future won't copy the page
table entries, but I assume we do setup the underlying pages for CoW
still. So I guess this means in the old process no fault would happen
if the memory was touched, but in the forked process it would generate
a minor fault?

To me that seems fine. When userspace gets a minor fault it's always
fine for it to just say "don't care, just UFFDIO_CONTINUE, no work
needed". For VM migration I don't think it's unreasonable to expect
userspace to remember whether or not the page is clean (it already
does this anyway) and whether or not a fork (without exec) had
happened. It seems to me it should work fine.

> --
> Mike Kravetz
