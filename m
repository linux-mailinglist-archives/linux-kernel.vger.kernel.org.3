Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CEA51C612
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382676AbiEERbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382672AbiEERbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:31:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265825D193
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:28:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so4563423pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xg/pm+e2Qt3mW+QrtQns7UgBoy/9i7r00873gorg2Lw=;
        b=YMcAIbYYOrww25piOSwixN5vCkxSnL8MnbZmG99Fhk8Q8HuBkPu1RILxtkjPNXCwKb
         dvdqbUVWQGPcDp9qK1CgDCXfWngmIyER8PAmsmlAhAP25rUHZwW8lhMPJZd1f3lLDzvp
         4W5eUoIgUAaJCVvS33M8J4MwoVeXg4XbZjst68r4DWZcimbG61pUuypzbz0ymVT15Xxb
         E2NVpVTTdL+Fo4rPVusgcglmsReFPM9RXqhp+CrtAvGWiagEO9fRHVtKF534l9tL+Ewn
         BgpXLahsZlo0ELUC21cMdn6EHVG7aF+bjQAmRj4vpaNs+qQ8qwiLMuiF+qw+QW92urZU
         9cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xg/pm+e2Qt3mW+QrtQns7UgBoy/9i7r00873gorg2Lw=;
        b=tOe11E+vxiYK9c5DLNO2fWTJIpCMNSSRf7WRWWBdPim4AgtxaU0+hRW7JP6i95qWxQ
         RyR36IyNJpkhVmFCwu7vYwqWxo+30guoDlwmQgO4C3f0fC4aYKcxCcsgrc4KkQ7VyCd0
         XnJkeZEBFnzA4CxImdlRh0WdQLa2zRDYQ1qi62s8lT7WSuqyvsCaM2nUp1RTRhqvrizU
         ybj5Hon3/hIkDGUYWdzwfkOaBIcYNqrJ3pokUdif28lE36WXN+/JD1Csv1Qb5GGgfCcQ
         hB4dfztrq6xWhWqumIR3yVjY6WtlsNMwZZTsGUNI4mnnn3cchERW+WAZTpEi1neJSgNP
         5DTg==
X-Gm-Message-State: AOAM531OfdslxXePyDD1vTyb+nqGMr3jQ78DvSImijpj5nsu8RNgJLj4
        X81pq7zOEJ/WnD8CiaWINVS+FcJbP9Q=
X-Google-Smtp-Source: ABdhPJzPmexJWSCp3MSWPnY62KxjIUNCMkeN7mpSQusr4t0Lyx/bohCN2cfp04dRQHYHi6kLqODjtw==
X-Received: by 2002:a17:90b:3b81:b0:1dc:32ac:a66b with SMTP id pc1-20020a17090b3b8100b001dc32aca66bmr7398553pjb.49.1651771679500;
        Thu, 05 May 2022 10:27:59 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:1c0c:8050:e4d3:12f5])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902b20200b0015e8d4eb1c0sm1822492plr.10.2022.05.05.10.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 10:27:59 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 5 May 2022 10:27:57 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Message-ID: <YnQJHRsheGGZG7Fy@google.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
 <YnAhaRNjmIhtGUjk@google.com>
 <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
 <YnFJss0doXGCmq3w@google.com>
 <da07530d-92ad-7aef-2f2b-d115f878ef76@redhat.com>
 <YnMC1jFoPvNLWqnG@google.com>
 <YnNzPlehofB57XXU@google.com>
 <dd4588a4-c1ca-481c-ac33-06abef6cf70a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4588a4-c1ca-481c-ac33-06abef6cf70a@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 10:00:07AM -0700, Mike Kravetz wrote:
> On 5/4/22 23:48, Minchan Kim wrote:
> > On Wed, May 04, 2022 at 03:48:54PM -0700, Minchan Kim wrote:
> >> On Tue, May 03, 2022 at 06:02:33PM +0200, David Hildenbrand wrote:
> >>> On 03.05.22 17:26, Minchan Kim wrote:
> >>>> On Tue, May 03, 2022 at 03:15:24AM +0200, David Hildenbrand wrote:
> >>>>>
> >>>>>>>>> However, I assume we have the same issue right now already with
> >>>>>>> ZONE_MOVABLE and MIGRATE_CMA when trying to pin a page residing on these
> >>>>>>
> >>>>>> ZONE_MOVALBE is also changed dynamically?
> >>>>>>
> >>>>>
> >>>>> Sorry, with "same issue" I meant failing to pin if having to migrate and
> >>>>> the page is temporarily unmovable.
> >>>>>
> >>>>>>> there are temporarily unmovable and we fail to migrate. But it would now
> >>>>>>> apply even without ZONE_MOVABLE or MIGRATE_CMA. Hm...
> >>>>>>
> >>>>>> Didn't parse your last mention.
> >>>>>
> >>>>> On a system that neither uses ZONE_MOVABLE nor MIGRATE_CMA we might have
> >>>>> to migrate now when pinning.
> >>>>
> >>>> I don't understand your point. My problem is pin_user_pages with
> >>>> FOLL_LONGTERM. It shouldn't pin a page from ZONE_MOVABLE and cma area
> >>>> without migrating page out of movable zone or CMA area.
> >>>> That's why try_grab_folio checks whether target page stays in those
> >>>> movable areas. However, to check CMA area, is_migrate_cma_page is
> >>>> racy so the FOLL_LONGTERM flag semantic is broken right now.
> >>>>
> >>>> Do you see any problem of the fix?
> >>>
> >>> My point is that you might decide to migrate a page because you stumble
> >>> over MIGRATE_ISOLATE, although there is no need to reject long-term
> >>> pinning and to trigger page migration.
> >>>
> >>> Assume a system without ZONE_MOVABLE and without MIGRATE_CMA. Assume
> >>> someone reserves gigantic pages (alloc_contig_range()) and you have
> >>> concurrent long-term pinning on a page that is no MIGRATE_ISOLATE.
> >>>
> >>> GUP would see MIGRATE_ISOLATE and would reject pinning. The page has to
> >>> be migrated, which can fail if the page is temporarily unmovable.
> >>
> >> A dump question since I'm not familiar with hugetlb.
> >>
> >> Is above reasonable scenario?
> >>
> >> The gigantic page is about to be created using alloc_contig_range so
> >> they has MIGRATE_ISOLATE as temporal state. It means no one uses the
> >> page yet so I guess the page is not mapped at userspace but other is
> >> trying to access the page using pin_user_pages?
> >>
> > 
> > Too dump question. Never mind.
> > Posted v2 - https://lore.kernel.org/all/20220505064429.2818496-1-minchan@kernel.org/T/#u
> > 
> 
> Well your question mentioned hugetlb so my mail filters caught it :)
> 
> Your question caused me to think of the following.  No need for any immediate
> change: I think.  Just wanted to share.
> 
> Suppose someone has reserved CMA for gigantic hugetlb allocations.  And,
> suppose FOLL_LONGTERM is attempted on such a page (it would be in use).  The
> desired action would be to migrate the page out of CMA.  Correct?
> 
> Gigantic pages can only be migrated IF there is another (already allocated)
> gigantic page available.  The routine to try and allocate a page 'on the fly'
> for migration will fail if passed a gigantic size.  There 'might' be a free
> pre-allocated gigantic page.  However, if the user set up CMA reserves for
> gigantic page allocations it is likely the free gigantic page is also in CMA.
> Therefore, it can not be used for this migration.  So, unless my reasoning
> is wrong, FOLL_LONGTERM would almost always fail for gigantic pages in CMA.

FOLL_LONGTERM on CMA-backed gigantic page would already fail, Thanks for sharing!

Anyway, David's concern was non-CMA-backed gigantic page. The alloc_contig_range 
with MIGRATE_ISOLATE runs with concurrent FOLL_LONGTERM pinning, which could
trigger page migration we didn't have before so it might increase FOLL_LONGTERM
GUP failure rate.
