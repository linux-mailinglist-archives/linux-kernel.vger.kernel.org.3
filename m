Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533F65761C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiGOMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiGOMfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F222D21E39
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657888545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ro2NciNh0l2a2KGra8NnYM6QqqFGpQ5zDOerKhdfnFA=;
        b=W0lO90UU71ni0HHJ0sTw5g4onH6UTrA4DmQyFThV1rRgJQfC5YNOLQ3WtLqfSLZzZ67k1A
        lY8ZPIpSnRoIH0uvkOsUNANGberYoyjBG+rn9ZTMa4oKWLp7nAG0uvBOmn/ajs9qUBxdsi
        HuvRgzUXFuIA68nvv1ruUu41/xFTI4c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-Dd7qnDRAMwmVd9SrXxdXTA-1; Fri, 15 Jul 2022 08:35:44 -0400
X-MC-Unique: Dd7qnDRAMwmVd9SrXxdXTA-1
Received: by mail-qt1-f200.google.com with SMTP id x16-20020ac85f10000000b0031d3262f264so3564107qta.22
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ro2NciNh0l2a2KGra8NnYM6QqqFGpQ5zDOerKhdfnFA=;
        b=gMGQaGJkKqQKqPcbQ0isaHeZ+GvDo8CX2BcxbICZL23qv8Mnhn4cpYyrMra4UmNpXj
         su2TVgrPVZcypU2Z9uIRGdTfZ2i6zV8J6rOmEA+z/5TfHXLCBKB4YwaCo9sn7uwus9uR
         ZQ54DsKza8oVsob4pMMuRJivX/NcAtLp8dwtkoPeSE1sia3Rw6IPim+nEDd8ekonUSOl
         qcWZ1Idz/O6J302h/iDz3UtUniTax4LCr/AWzHQ8ODhWmN0NZTbOTMAlRS9RxBrLd5YA
         bD0vPYER9n1QcJJq0sztp3jvJXYJzbaDxG4o0A5IbX06xHEBsCHsrYcXjCqT7HVgiINr
         MfYA==
X-Gm-Message-State: AJIora9YLyP+Z6s6yhjO1uKmpRFEtnNlvnZvVBzCBGNIdifC7zAQ3bPB
        vQcOFpr2LqHJXYs9lfmfSQm8pO79lP530tR+LZZqgjqAeQEmeYy0iHKwTKA+rCq49E/aFgtpnLN
        rcdltTw2a3HIKU5kRRk8Ec0op
X-Received: by 2002:a05:620a:4109:b0:6b5:8d6b:b7c with SMTP id j9-20020a05620a410900b006b58d6b0b7cmr9224651qko.332.1657888544195;
        Fri, 15 Jul 2022 05:35:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1spK6/uz57yWcF55O/lDRPZLbFzVOsGODVEoMir0ru9TtNxLDqgBwpTT/iUJ46os09EYfMezA==
X-Received: by 2002:a05:620a:4109:b0:6b5:8d6b:b7c with SMTP id j9-20020a05620a410900b006b58d6b0b7cmr9224634qko.332.1657888543967;
        Fri, 15 Jul 2022 05:35:43 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id r5-20020ac85c85000000b0031ec83851ccsm2492486qta.38.2022.07.15.05.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 05:35:43 -0700 (PDT)
Date:   Fri, 15 Jul 2022 08:35:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-ID: <YtFfHU3fb/ncCG6O@xz-m1.local>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
 <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com>
 <YtA7svbn4MtuT7qJ@xz-m1.local>
 <402ae708-4c86-8feb-75c4-9339e1deac3b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <402ae708-4c86-8feb-75c4-9339e1deac3b@huawei.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 11:56:40AM +0800, Miaohe Lin wrote:
> On 2022/7/14 23:52, Peter Xu wrote:
> > On Thu, Jul 14, 2022 at 05:59:53PM +0800, Miaohe Lin wrote:
> >> On 2022/7/14 1:23, Andrew Morton wrote:
> >>> On Tue, 12 Jul 2022 21:05:42 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>>
> >>>> In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
> >>>> cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
> >>>> for them mistakenly because they're not vm_shared. This will corrupt the
> >>>> page->mapping used by page cache code.
> >>>
> >>> Well that sounds bad.  And theories on why this has gone unnoticed for
> >>> over a year?  I assume this doesn't have coverage in our selftests?
> >>
> >> As discussed in another thread, when minor fault handling is proposed, only
> >> VM_SHARED vma is expected to be supported. And the test case is also missing.
> > 
> > Yes, after this patch applied it'll be great to have the test case covering
> > private mappings too.
> > 
> > It's just that it'll be a bit more than setting test_uffdio_minor=1 for
> > "hugetlb" test.  In hugetlb_allocate_area() we'll need to setup the alias
> > too for !shared case, it'll be a bit challenging since currently we're
> > using anonymous hugetlb mappings for private tests, and I'm not sure
> > whether we'll need the hugetlb path back just like what we have with
> > "hugetlb_shared" tests.
> 
> I'm afraid not. When minor fault handling is proposed, only VM_SHARED vma is
> expected to be supported. It seems it's hard to image how one might benefit
> from using it with a private mapping. But I'm not sure as I'm still a layman
> in userfaultfd now. Any further suggestions?

IIUC so far we all think it's not required to limit it to shared mappings
only?  The effort is mostly the same.

My suggestion is above - we could enable the kselftest for it, but I don't
strongly ask for that too because I don't know any real use of it, it'll
still be good to have it though for completeness.  It's just that we may
need to change some code back in 9ae8f2b849f79 on using fd-based memory, or
I don't know how to create the alias mapping properly.

Thanks,

-- 
Peter Xu

