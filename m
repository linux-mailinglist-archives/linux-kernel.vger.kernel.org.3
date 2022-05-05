Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B6451B833
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245273AbiEEGwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbiEEGwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:52:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604F21FA7C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 23:48:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p12so2960785pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 23:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZV+Ja+Gjo1y5MTQG69wFb+r8JKmUtK4HnaqQsncUWMs=;
        b=cB22BeNOddpZtIMXGrGVUQYuBQHcTiJ5jPRZYmkVRrgGhzOUBdnTVM4YaoCihZlfKU
         ZrV8m04VQQwxbTyGChLW4qaRTAWAQaRSA0Su5gBCSoIwSXUp5WILWppOOfe56MY4bx0S
         LbOl87PzKF86xD+WPfZ9Dmf+9niWbsXoQZhNJtQ01RPVgwIyjvjkKV8+7hbDlnWoKRws
         Xs0LmWOM1twaDaHwORg9NcseG9dymMwivmgYBx6kC3bluPlvDJodhAdGHpTaP0IEqjTB
         qhq7Puhnt/Yi/PxpQXU6h2ay1f29YLr7ogvKPIp//P/CDN2FT4AuyLMU1MQHCKG9sthA
         6oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZV+Ja+Gjo1y5MTQG69wFb+r8JKmUtK4HnaqQsncUWMs=;
        b=i/pBhkeEX+nawjb9jQ4Frmw9GtvIchDzX0ltsHX5Zrubt1CzN1yJX6Ypeaeu/x/ezx
         lSfSfAomRRBHBXL9hrVdMqaMl8ByxRDAgRUNaiwcDDcZoJMvkMo5w0pBLpczAS+cphCt
         od+AjWeHzJh4iwjw68heVKOsyKArBzXXdV+aB7BHGm/fIpjxGt3HZmhSJusHc4aD3TKw
         XCk5YBEYOeCAqCjA8Lsj4yQ0Eh5btqz2vpMrPsozjNAJ9toD5XolWXqG4TmB8b9mBs2D
         9zqppFz0l3AutjteGJqmELMy0RWQmhQJxH86vzyndOztO4TKL6OIIKyReyRvDdGOc6hp
         R+yg==
X-Gm-Message-State: AOAM532z7ymTaT3cpkJLNcWPlhXP4qlr1pBTsjFTLfjCBALZ52f56Dfs
        D4WkCV4qWgF6CpDY/UUwbkU=
X-Google-Smtp-Source: ABdhPJxuBZXn592UMcBRFN/HRz1xjjWTl7dGVUaEYcIUVZQfLN3z206B2OpmliYgpIZP4Y2t2rnhjg==
X-Received: by 2002:a05:6a00:1590:b0:50d:f473:c346 with SMTP id u16-20020a056a00159000b0050df473c346mr16017357pfk.27.1651733312876;
        Wed, 04 May 2022 23:48:32 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8435:b3e7:62fc:4dfa])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b0015e8d4eb1casm693010plg.20.2022.05.04.23.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 23:48:32 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 4 May 2022 23:48:30 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Message-ID: <YnNzPlehofB57XXU@google.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
 <YnAhaRNjmIhtGUjk@google.com>
 <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
 <YnFJss0doXGCmq3w@google.com>
 <da07530d-92ad-7aef-2f2b-d115f878ef76@redhat.com>
 <YnMC1jFoPvNLWqnG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnMC1jFoPvNLWqnG@google.com>
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

On Wed, May 04, 2022 at 03:48:54PM -0700, Minchan Kim wrote:
> On Tue, May 03, 2022 at 06:02:33PM +0200, David Hildenbrand wrote:
> > On 03.05.22 17:26, Minchan Kim wrote:
> > > On Tue, May 03, 2022 at 03:15:24AM +0200, David Hildenbrand wrote:
> > >>
> > >>>>>> However, I assume we have the same issue right now already with
> > >>>> ZONE_MOVABLE and MIGRATE_CMA when trying to pin a page residing on these
> > >>>
> > >>> ZONE_MOVALBE is also changed dynamically?
> > >>>
> > >>
> > >> Sorry, with "same issue" I meant failing to pin if having to migrate and
> > >> the page is temporarily unmovable.
> > >>
> > >>>> there are temporarily unmovable and we fail to migrate. But it would now
> > >>>> apply even without ZONE_MOVABLE or MIGRATE_CMA. Hm...
> > >>>
> > >>> Didn't parse your last mention.
> > >>
> > >> On a system that neither uses ZONE_MOVABLE nor MIGRATE_CMA we might have
> > >> to migrate now when pinning.
> > > 
> > > I don't understand your point. My problem is pin_user_pages with
> > > FOLL_LONGTERM. It shouldn't pin a page from ZONE_MOVABLE and cma area
> > > without migrating page out of movable zone or CMA area.
> > > That's why try_grab_folio checks whether target page stays in those
> > > movable areas. However, to check CMA area, is_migrate_cma_page is
> > > racy so the FOLL_LONGTERM flag semantic is broken right now.
> > > 
> > > Do you see any problem of the fix?
> > 
> > My point is that you might decide to migrate a page because you stumble
> > over MIGRATE_ISOLATE, although there is no need to reject long-term
> > pinning and to trigger page migration.
> > 
> > Assume a system without ZONE_MOVABLE and without MIGRATE_CMA. Assume
> > someone reserves gigantic pages (alloc_contig_range()) and you have
> > concurrent long-term pinning on a page that is no MIGRATE_ISOLATE.
> > 
> > GUP would see MIGRATE_ISOLATE and would reject pinning. The page has to
> > be migrated, which can fail if the page is temporarily unmovable.
> 
> A dump question since I'm not familiar with hugetlb.
> 
> Is above reasonable scenario?
> 
> The gigantic page is about to be created using alloc_contig_range so
> they has MIGRATE_ISOLATE as temporal state. It means no one uses the
> page yet so I guess the page is not mapped at userspace but other is
> trying to access the page using pin_user_pages?
> 

Too dump question. Never mind.
Posted v2 - https://lore.kernel.org/all/20220505064429.2818496-1-minchan@kernel.org/T/#u

Thanks.
