Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D0658F359
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiHJTwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJTwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44BBB8C00E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660161162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w05t+rLGLxKHngeNj1Dk/emo7DjYevCR6PViqoPcu98=;
        b=RPKKYsT3iZwVQgFMJKXUcXNsd/QH25o0jtuDhTGiucKeKs10wj7eLHlatmX8Cd2ZZuc6Ha
        xEervzTDpwiCDtZ/2l8FNbXx5Fy5sRdezNEDsJxKbF4ZLvwIhQCUyERk3iuMMqQoK/8Uzm
        aojz8mYH/ZxJoAiekDLMI85mS7aSrCs=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-_12d-q5TP9yCCWKn0Xlz8A-1; Wed, 10 Aug 2022 15:52:41 -0400
X-MC-Unique: _12d-q5TP9yCCWKn0Xlz8A-1
Received: by mail-il1-f199.google.com with SMTP id 15-20020a056e0220cf00b002e1d24dcb7cso829518ilq.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=w05t+rLGLxKHngeNj1Dk/emo7DjYevCR6PViqoPcu98=;
        b=U9wCElWmfhv7m68ZZLp9kHGCOwIyz8qT5f0AdVNmh9WCoJisZZxWmx8omjYkjNQNAf
         xrak8oxkDNbkdrmq0NN2ULUTvQh9kCR7GUGny8AQcFUAYmvHxRm3TPg6t7WmxVgpFGS1
         zcDTSGE3k2MhgBOd5WLEHZl6PLIi7hCLL19yrXQNQPPewZRT0C/EblBXWR/UZTKDz6Po
         CvWnDkPAXp8Pz5tUpmQYXBRsflG9QhMhN1VhWrkcUPu528Uy4s99WFIHxgxtZaiyYFdm
         MR61ZreW+PorVTzmPorh77N+4b2uoPoQyviztp8Wxw9ynTwprhZrp6r4eKWVhIs80MIM
         yBVg==
X-Gm-Message-State: ACgBeo2bT8oiffda/gMwnhje24+ND/+Z2XHRzv7NPDVpB3fW66AUf7ru
        MVJTJomTalEOtX5vecyQA+CU1Qo5YpZqhCehe1buzFv78UAkEo4iRkb6RxUDQvTPCx+vfW6YJU0
        Kky/SUJPplZegkvIyU/xQIouA
X-Received: by 2002:a5d:9d9e:0:b0:67c:2675:50a with SMTP id ay30-20020a5d9d9e000000b0067c2675050amr12220052iob.184.1660161160416;
        Wed, 10 Aug 2022 12:52:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4E1ySyuz/xm3IUeQGZWCYW0/w8nq9zXzROPbsMRuRJzvlRvQXA+i6JOt8Th+E/1MwIlG0UHA==
X-Received: by 2002:a5d:9d9e:0:b0:67c:2675:50a with SMTP id ay30-20020a5d9d9e000000b0067c2675050amr12220047iob.184.1660161160187;
        Wed, 10 Aug 2022 12:52:40 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id s24-20020a02cf38000000b0034339c2dd5fsm1464329jar.91.2022.08.10.12.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 12:52:39 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:52:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared
 mappings
Message-ID: <YvQMhonK5cC4MXiQ@xz-m1.local>
References: <20220805110329.80540-3-david@redhat.com>
 <Yu1dkZeBwv0SUQMq@xz-m1.local>
 <4f644ac5-c40b-32d4-3234-c1dac3d09f83@redhat.com>
 <YvE0OwsyQEL3K5Hm@xz-m1.local>
 <8b317ac7-f80e-4aab-4ad1-4e19a1a0740f@redhat.com>
 <YvFwU4e3WOSRseh6@xz-m1.local>
 <YvGJQaYeT9Y8PlDX@xz-m1.local>
 <12c65d91-5fc0-cb2e-c415-2b3447960b43@redhat.com>
 <YvQHKCylnFjgkFtw@xz-m1.local>
 <b3efd062-1548-cf80-dd1c-21f144887b9b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3efd062-1548-cf80-dd1c-21f144887b9b@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 09:40:11PM +0200, David Hildenbrand wrote:
> On 10.08.22 21:29, Peter Xu wrote:
> > On Wed, Aug 10, 2022 at 11:37:13AM +0200, David Hildenbrand wrote:
> >> On 09.08.22 00:08, Peter Xu wrote:
> >>> On Mon, Aug 08, 2022 at 04:21:39PM -0400, Peter Xu wrote:
> >>>> On Mon, Aug 08, 2022 at 06:25:21PM +0200, David Hildenbrand wrote:
> >>>>>>> Relying on VM_SHARED to detect MAP_PRIVATE vs. MAP_SHARED is
> >>>>>>> unfortunately wrong.
> >>>>>>>
> >>>>>>> If you're curious, take a look at f83a275dbc5c ("mm: account for
> >>>>>>> MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs")
> >>>>>>> and mmap() code.
> >>>>>>>
> >>>>>>> Long story short: if the file is read-only, we only have VM_MAYSHARE but
> >>>>>>> not VM_SHARED (and consequently also not VM_MAYWRITE).
> >>>>>>
> >>>>>> To ask in another way: if file is RO but mapped RW (mmap() will have
> >>>>>> VM_SHARED cleared but VM_MAYSHARE set), then if we check VM_MAYSHARE here
> >>>>>> won't we grant write bit errornously while we shouldn't? As the user
> >>>>>> doesn't really have write permission to the file.
> >>>>>
> >>>>> Thus the VM_WRITE check. :)
> >>>>>
> >>>>> I wonder if we should just do it cleanly and introduce the maybe_mkwrite
> >>>>> semantics here as well. Then there is no need for additional VM_WRITE
> >>>>> checks and hugetlb will work just like !hugetlb.
> >>>>
> >>>> Hmm yeah I think the VM_MAYSHARE check is correct, since we'll need to fail
> >>>> the cases where MAYSHARE && !SHARE - we used to silently let it pass.
> >>>
> >>> Sorry I think this is a wrong statement I made..  IIUC we'll fail correctly
> >>> with/without the patch on any write to hugetlb RO regions.
> >>>
> >>> Then I just don't see a difference on checking VM_SHARED or VM_MAYSHARE
> >>> here, it's just that VM_MAYSHARE check should work too like VM_SHARED so I
> >>> don't see a problem.
> >>>
> >>> It also means I can't think of any valid case of having VM_WRITE when
> >>> reaching here, then the WARN_ON_ONCE() is okay but maybe also redundant.
> >>> Using maybe_mkwrite() seems misleading to me if FOLL_FORCE not ready for
> >>> hugetlbfs after all.
> >>>
> >>
> >> The main reason we'd have it would be to scream out lout and fail
> >> gracefully if someone would -- for example -- use it for something like
> >> FOLL_FORCE.
> > 
> > Having that WARN_ON_ONCE() is okay to me, but just to double check we're on
> > the same page: why there's concern on using FOLL_FORCE? IIUC we're talking
> > about shared mappings here, then no FOLL_FORCE possible at all?  IOW,
> > "!is_cow_mapping()" should fail in check_vma_flags() already.
> 
> This code path also covers the anon case.

But this specific warning is under the VM_MAYSHARE if clause just added in
this patch?

My understanding is any FOLL_FORCE will always constantly fail before this
patch, and it should keep failing as usual and I don't see any case it'll
be failing at the warn_on_once here.

So again, I'm fine with having the warning, but I just want to make sure
what you want to capture is what you expected..

> > 
> > The other thing is I'm wondering whether patch 2 should be postponed anyway
> > so that we can wait for a full resolution of the problem from Mike.
> 
> To make the code more robust and avoid any other such surprises I prefer
> to have this in rather earlier than later.
> 
> As the commit says "Let's add a safety net ..."

Sure, no strong opinion.  I'll leave that to Mike.  Thanks,

-- 
Peter Xu

