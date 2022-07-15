Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B9E576936
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiGOVxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiGOVxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:53:04 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68DC52892
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:53:03 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id v185so4870154ioe.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tq5T3aH18KnHOG72zuFgKU+kvEBn0xsRwjcVrUNzXPc=;
        b=kpnS48iXxVRPMnN9timMPz1YcAqK7sQR5vKUyTIVmSF2HCBnNnwxuXtRY5kP1Mr9uN
         pBLgRD2xlhOJLI2bBFwfynh3wX7U6pePqASPAVrrd+Dd7cw1ss+ZM6AjOAFKJfcDCGlt
         ZZ3jmzQ2gntorFxnrmrs2vaip715/znwpnoLM5s4F7PKSXpLQECBuPt2p5hbw6k5u5jN
         AEx8l0WyCc7aZkVs6E5v9h4rpy1jpPSItZMC6omaEP5m5kYKji5tJow3cXxaLEqoTEiv
         chY8p1b2D9oG9b7SasaYR1zcJId6ESs2zU4Jad+Hx6cZN72M5oSHncR48j+uJ707MylT
         PeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tq5T3aH18KnHOG72zuFgKU+kvEBn0xsRwjcVrUNzXPc=;
        b=49cVTS8Fr/Iw0uUlIWUGm5chKi3zLq39YggtdHUF2VBOBhhQU5DfgOj2KFi7JGOzkF
         yyBkV8avEEeXwqLC1YnaIU+FXTTYtv4WfDTLZw8GnHWSjwcxj+V4yZ0TQhDduP5hiQjn
         v6tqKkZWD+mn9I+29t+FmHkfzND+7QtocS3fvBC2Tv++3Rrx4PjHEQ1NWvmLcHPb+lB8
         kQFBfidnzQfGgTu7JAotSEbNHG9q4DheK1jO+8qmulFTxkWD962GKTBzbR3sE4JTZAob
         TMXJkoAnBc5ehoCtjqDXjLZd8RWo1V+6M4l+6j9Lvw9k4jtvX7hUiw2aGsoZ4s1/W/bl
         dqLw==
X-Gm-Message-State: AJIora8e0TFMmerwz3CPCNaUP8Q8RSPlZGUcrsJBh7fQ9PSMSIWtFsQB
        gDCXS61rO7csc5yFqYicaumi0Vizih/r92teJzdvYg==
X-Google-Smtp-Source: AGRyM1uhhCzQinLMz5gfmHvSM5a+94JvLfRe69XlKsDnfHY2Igqe/+evNBmvJopUGiGSFLQMdFoV+riJ4CQxVb/QfGI=
X-Received: by 2002:a02:942c:0:b0:33f:5256:b4f5 with SMTP id
 a41-20020a02942c000000b0033f5256b4f5mr8675096jai.52.1657921983015; Fri, 15
 Jul 2022 14:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-8-jthoughton@google.com> <YsyzGMS+MS0kZoP8@monkey>
 <Ys1B+fXo2uSPd46B@work-vm> <YtGXTlyRs3oVVPA5@xz-m1.local>
In-Reply-To: <YtGXTlyRs3oVVPA5@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 15 Jul 2022 14:52:27 -0700
Message-ID: <CAJHvVci+vBRnSNBnBC5tNKtesf0m5XQ943fWw9M+MRj7o7VDrQ@mail.gmail.com>
Subject: Re: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
To:     Peter Xu <peterx@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
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

On Fri, Jul 15, 2022 at 9:35 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Jul 12, 2022 at 10:42:17AM +0100, Dr. David Alan Gilbert wrote:
> > * Mike Kravetz (mike.kravetz@oracle.com) wrote:
> > > On 06/24/22 17:36, James Houghton wrote:
> > > > After high-granularity mapping, page table entries for HugeTLB pages can
> > > > be of any size/type. (For example, we can have a 1G page mapped with a
> > > > mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
> > > > PTE after we have done a page table walk.
> > >
> > > This has been rolling around in my head.
> > >
> > > Will this first use case (live migration) actually make use of this
> > > 'mixed mapping' model where hugetlb pages could be mapped at the PUD,
> > > PMD and PTE level all within the same vma?  I only understand the use
> > > case from a high level.  But, it seems that we would want to only want
> > > to migrate PTE (or PMD) sized pages and not necessarily a mix.
> >
> > I suspect we would pick one size and use that size for all transfers
> > when in postcopy; not sure if there are any side cases though.

Sorry for chiming in late. At least from my perspective being able to
do multiple sizes is a nice to have optmization.

As talked about above, imagine a guest VM backed by 1G hugetlb pages.
We're going along doing demand paging at 4K; because we want each
request to complete as quickly as possible, we want very small
granularity.

Guest access in terms of "physical" memory address is basically
random. So, actually filling in all 262k 4K PTEs making up a
contiguous 1G region might take quite some time. Once we've completed
any of the various 2M contiguous regions, it would be nice to go ahead
and collapse those right away. The benefit is, the guest will see some
performance benefit from the 2G page already, without having to wait
for the full 1G page to complete. Once we do complete a 1G page, it
would be nice to collapse that one level further. If we do this, the
whole guest memory will be a mix of 1G, 2M, and 4K.

>
> Yes, I'm also curious whether the series can be much simplified if we have
> a static way to do sub-page mappings, e.g., when sub-page mapping enabled
> we always map to PAGE_SIZE only; if not we keep the old hpage size mappings
> only.
>
> > > Looking to the future when supporting memory error handling/page poisoning
> > > it seems like we would certainly want multiple size mappings.
>
> If we treat page poisoning as very rare events anyway, IMHO it'll even be
> acceptable if we always split 1G pages into 4K ones but only rule out the
> real poisoned 4K phys page.  After all IIUC the major goal is for reducing
> poisoned memory footprint.
>
> It'll be definitely nicer if we can keep 511 2M pages and 511 4K pages in
> that case so the 511 2M pages performs slightly better, but it'll be
> something extra to me.  It can always be something worked upon a simpler
> version of sub-page mapping which is only PAGE_SIZE based.
>
> Thanks,
>
> --
> Peter Xu
>
