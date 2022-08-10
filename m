Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF34558F30D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiHJT3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiHJT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69CC872ECC
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660159788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REi4WFzUXH4cvrULW2JJO2oNqRO+KWBZyDWvXG7zfjU=;
        b=SgjmLMtaVqPBdGibMO9dkVaXv9O0rbhXkpSWTx5zFAyqk8uJtvvbeUcy9omKlVmJL29B4d
        2X5w5PjMBs+2u6USjiDxEePP1Yx4v60ujr5DMGq1wsN2AipTA6Wf1oofnFnhSxO/Axu0j/
        MEeL/ghtixeIRU7gY6oRhD+GR0NUpXc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-flY5UmdYNNOX4QBOxYb-vg-1; Wed, 10 Aug 2022 15:29:47 -0400
X-MC-Unique: flY5UmdYNNOX4QBOxYb-vg-1
Received: by mail-il1-f200.google.com with SMTP id e2-20020a056e020b2200b002e1a5b67e29so913753ilu.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=REi4WFzUXH4cvrULW2JJO2oNqRO+KWBZyDWvXG7zfjU=;
        b=Prefgzmf95N2HGjbJyaDLWVIDl6jbcm7qqOKeiVrVPxYk+TcadKuz3yPttTrgX+Le7
         Kb8HaLM1x03GupWMeGyLNm4uYLSCVNolK109JVcHuU7+roHMRXuW8fGErHR4k7Z4utGm
         e14TRCQVgbj45nClbIFoG30RnknYkEIoGKLckSKFdUFkzgff7tHobB3vNQKgrt96cFJD
         udUSeKwocq0HqrfGuNAZXmiqlc9h/ZwLGKnZDzuBbAy/q7y622LYXgK+B7Z+PQCnrUgx
         yQFz/wIWve+COWOb5iNEIGgW8mmgqY1OaTZMpRLUaaRxRxE3FACah14b/SP6CsaS8xpZ
         qPvA==
X-Gm-Message-State: ACgBeo3TTeNXu4IlYzeSguCOH24pAFt06T2xuxFRNacY7tLAvD2VW4WX
        Hy5wuF7zjHIeISaknLa3QA11y1ch0P1p8LmB07C4BTnW3KsPiGwW33Xbhm/T7ZOn4DeKEO6bVBs
        0iuZ4uKHFmwMRIayySCDW/k2z
X-Received: by 2002:a92:8748:0:b0:2d9:3f81:d0b7 with SMTP id d8-20020a928748000000b002d93f81d0b7mr12999649ilm.310.1660159786660;
        Wed, 10 Aug 2022 12:29:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6lyhiM/KFasf0ntmXLik3ApRZzHCPXsjVFzomhiVrqgorAqjUEu74Pv3h3d46ay5fyMx+G9Q==
X-Received: by 2002:a92:8748:0:b0:2d9:3f81:d0b7 with SMTP id d8-20020a928748000000b002d93f81d0b7mr12999641ilm.310.1660159786473;
        Wed, 10 Aug 2022 12:29:46 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id m64-20020a6b3f43000000b0067cb742ad4csm2686268ioa.23.2022.08.10.12.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 12:29:45 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:29:44 -0400
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
Message-ID: <YvQHKCylnFjgkFtw@xz-m1.local>
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-3-david@redhat.com>
 <Yu1dkZeBwv0SUQMq@xz-m1.local>
 <4f644ac5-c40b-32d4-3234-c1dac3d09f83@redhat.com>
 <YvE0OwsyQEL3K5Hm@xz-m1.local>
 <8b317ac7-f80e-4aab-4ad1-4e19a1a0740f@redhat.com>
 <YvFwU4e3WOSRseh6@xz-m1.local>
 <YvGJQaYeT9Y8PlDX@xz-m1.local>
 <12c65d91-5fc0-cb2e-c415-2b3447960b43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12c65d91-5fc0-cb2e-c415-2b3447960b43@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 11:37:13AM +0200, David Hildenbrand wrote:
> On 09.08.22 00:08, Peter Xu wrote:
> > On Mon, Aug 08, 2022 at 04:21:39PM -0400, Peter Xu wrote:
> >> On Mon, Aug 08, 2022 at 06:25:21PM +0200, David Hildenbrand wrote:
> >>>>> Relying on VM_SHARED to detect MAP_PRIVATE vs. MAP_SHARED is
> >>>>> unfortunately wrong.
> >>>>>
> >>>>> If you're curious, take a look at f83a275dbc5c ("mm: account for
> >>>>> MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs")
> >>>>> and mmap() code.
> >>>>>
> >>>>> Long story short: if the file is read-only, we only have VM_MAYSHARE but
> >>>>> not VM_SHARED (and consequently also not VM_MAYWRITE).
> >>>>
> >>>> To ask in another way: if file is RO but mapped RW (mmap() will have
> >>>> VM_SHARED cleared but VM_MAYSHARE set), then if we check VM_MAYSHARE here
> >>>> won't we grant write bit errornously while we shouldn't? As the user
> >>>> doesn't really have write permission to the file.
> >>>
> >>> Thus the VM_WRITE check. :)
> >>>
> >>> I wonder if we should just do it cleanly and introduce the maybe_mkwrite
> >>> semantics here as well. Then there is no need for additional VM_WRITE
> >>> checks and hugetlb will work just like !hugetlb.
> >>
> >> Hmm yeah I think the VM_MAYSHARE check is correct, since we'll need to fail
> >> the cases where MAYSHARE && !SHARE - we used to silently let it pass.
> > 
> > Sorry I think this is a wrong statement I made..  IIUC we'll fail correctly
> > with/without the patch on any write to hugetlb RO regions.
> > 
> > Then I just don't see a difference on checking VM_SHARED or VM_MAYSHARE
> > here, it's just that VM_MAYSHARE check should work too like VM_SHARED so I
> > don't see a problem.
> > 
> > It also means I can't think of any valid case of having VM_WRITE when
> > reaching here, then the WARN_ON_ONCE() is okay but maybe also redundant.
> > Using maybe_mkwrite() seems misleading to me if FOLL_FORCE not ready for
> > hugetlbfs after all.
> > 
> 
> The main reason we'd have it would be to scream out lout and fail
> gracefully if someone would -- for example -- use it for something like
> FOLL_FORCE.

Having that WARN_ON_ONCE() is okay to me, but just to double check we're on
the same page: why there's concern on using FOLL_FORCE? IIUC we're talking
about shared mappings here, then no FOLL_FORCE possible at all?  IOW,
"!is_cow_mapping()" should fail in check_vma_flags() already.

The other thing is I'm wondering whether patch 2 should be postponed anyway
so that we can wait for a full resolution of the problem from Mike.

Thanks,

-- 
Peter Xu

