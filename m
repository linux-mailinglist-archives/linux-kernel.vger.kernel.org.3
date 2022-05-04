Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30451B240
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358974AbiEDWwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346758AbiEDWwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:52:34 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0453725
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:48:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id i62so2275612pgd.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZnQ5ikT44+7odGEG8SdbWqmU1OTX8BzekKD4PQr+Puk=;
        b=YVQPAOzNbsOpq7m5CxZJNHAgUk61rTKfTMUGx6l6FXMk0lF0h5ZduEHqRDO+xSY0iO
         hGqOARfpVOCexrIdOevgyb6k4Dw3TMKuqor5xvyUl9RzFuBknVAvewIi/eqelLh89cyn
         pXKmfJSPQCqyoJFOoe1IEAjS2O7rVabVRSS3Ermw/8YD2u0ggcjbUiF20/XUcjuu80VN
         xQwgVSc+cMCGAeZtCeybv3vnPpUaI9vZw6mkXQSJ9YJQLqpAVqTq+HXxIqYUYTkWVq/d
         I0DNZ0IMA67pTuuoRiPdqAU3o9VsMxRF5tLozra/GKehy1rLGp2U1fw1wfy2Zr0dbwJF
         Rqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZnQ5ikT44+7odGEG8SdbWqmU1OTX8BzekKD4PQr+Puk=;
        b=yvFn4wS8PSQYY7ewBOAVTs92xVq1nN4XwQHeeW3Mg6OXCUj9aaVoSEgG41we2oNKF+
         j02Bn0t5X7Oijn3bXpYIsM3R6exzbfDk/RnyMFrFWcLt+IkD/5neZuic5chJlxuGtq0f
         kwo563sWKetTuvWMThHcoAqFHjQtiiO/w/PK3jMT0TLME+3bT02iiBT6eLU9cjSGqJPP
         wIQfa+WeFNfDvZBV8UHP3ChQLpkBveEfcUq/vpikdyu/LVwtxh/0lWV9B7hDa7SNPgLp
         N6/MBuZMRVdZcb6O8TWH8LtK1h7ZwQe374N2552FJWHrLGkmIQTwkgJbLJmG3VLrSPjJ
         Q45Q==
X-Gm-Message-State: AOAM530uiRGCR7GwZdoYqI3sYRaXeCUrf/aRs+NnYUlU+T2E6obdCx+K
        dtoF6CCwqu5fwhHl1rGYRXo=
X-Google-Smtp-Source: ABdhPJy6VLPLgrv4Si23S39l/X8cU/8ncNW25MkQg9xRHmAUA/DfYINs+YbdkPGp5EvqcRRpuBYsTA==
X-Received: by 2002:a05:6a00:216c:b0:50d:f917:b502 with SMTP id r12-20020a056a00216c00b0050df917b502mr13966998pff.60.1651704536797;
        Wed, 04 May 2022 15:48:56 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8435:b3e7:62fc:4dfa])
        by smtp.gmail.com with ESMTPSA id v12-20020a65568c000000b003c2f9540127sm2839509pgs.93.2022.05.04.15.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 15:48:56 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 4 May 2022 15:48:54 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Message-ID: <YnMC1jFoPvNLWqnG@google.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
 <YnAhaRNjmIhtGUjk@google.com>
 <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
 <YnFJss0doXGCmq3w@google.com>
 <da07530d-92ad-7aef-2f2b-d115f878ef76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da07530d-92ad-7aef-2f2b-d115f878ef76@redhat.com>
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

On Tue, May 03, 2022 at 06:02:33PM +0200, David Hildenbrand wrote:
> On 03.05.22 17:26, Minchan Kim wrote:
> > On Tue, May 03, 2022 at 03:15:24AM +0200, David Hildenbrand wrote:
> >>
> >>>>>> However, I assume we have the same issue right now already with
> >>>> ZONE_MOVABLE and MIGRATE_CMA when trying to pin a page residing on these
> >>>
> >>> ZONE_MOVALBE is also changed dynamically?
> >>>
> >>
> >> Sorry, with "same issue" I meant failing to pin if having to migrate and
> >> the page is temporarily unmovable.
> >>
> >>>> there are temporarily unmovable and we fail to migrate. But it would now
> >>>> apply even without ZONE_MOVABLE or MIGRATE_CMA. Hm...
> >>>
> >>> Didn't parse your last mention.
> >>
> >> On a system that neither uses ZONE_MOVABLE nor MIGRATE_CMA we might have
> >> to migrate now when pinning.
> > 
> > I don't understand your point. My problem is pin_user_pages with
> > FOLL_LONGTERM. It shouldn't pin a page from ZONE_MOVABLE and cma area
> > without migrating page out of movable zone or CMA area.
> > That's why try_grab_folio checks whether target page stays in those
> > movable areas. However, to check CMA area, is_migrate_cma_page is
> > racy so the FOLL_LONGTERM flag semantic is broken right now.
> > 
> > Do you see any problem of the fix?
> 
> My point is that you might decide to migrate a page because you stumble
> over MIGRATE_ISOLATE, although there is no need to reject long-term
> pinning and to trigger page migration.
> 
> Assume a system without ZONE_MOVABLE and without MIGRATE_CMA. Assume
> someone reserves gigantic pages (alloc_contig_range()) and you have
> concurrent long-term pinning on a page that is no MIGRATE_ISOLATE.
> 
> GUP would see MIGRATE_ISOLATE and would reject pinning. The page has to
> be migrated, which can fail if the page is temporarily unmovable.

A dump question since I'm not familiar with hugetlb.

Is above reasonable scenario?

The gigantic page is about to be created using alloc_contig_range so
they has MIGRATE_ISOLATE as temporal state. It means no one uses the
page yet so I guess the page is not mapped at userspace but other is
trying to access the page using pin_user_pages?

> 
> See my point? We will try migrating in cases where we don't have to
> migrate. I think what we would want to do is always reject pinning a CMA
> page, independent of the isolation status. but we don't have that
> information available.
> 
> I raised in the past that we should look into preserving the migration
> type and turning MIGRATE_ISOLATE essentially into an additional flag.
> 
> 
> So I guess this patch is the right thing to do for now, but I wanted to
> spell out the implications.


