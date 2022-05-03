Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61BC518AED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbiECRYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiECRYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:24:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E781EEDA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:20:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so2587737pjf.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ffQfmOldbylSricKvp2FO9bq39SOCqrZpm2Itq8wUo=;
        b=M7B0o8W/jBNdraa+HXpW0N4QP8EtbIBaksGkOthoczQIFOAPvH0cZQ3wa74CYSAHxr
         c4r3CDqe/NImzllgLfLNzhZBFnch8yvVpT1GOvMqIwulyqJtDeqQNDJI+a6YfvvF/Itx
         wpLDh8h2WNW7g4zGpkNFssI8Vhnd01s30Yvya/5BsvhPKqpacMgnfeONFopG+cbvsBwN
         fg4VWW3mDk+eA+ViUd0SWSxe4W+r0pYh/p5R5PVJyUazTbm9zQcLyP1UTS2hNkKa4RMo
         55x6mmBxfBNSA37fxraR4r1hgOXCrL8VywDk0O0qt6xhQ4+JXw3rmAIGEC7cQv84ros1
         FUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9ffQfmOldbylSricKvp2FO9bq39SOCqrZpm2Itq8wUo=;
        b=tJaaUKraL0D7Evga6RUptVTTeBRlmPL6njlo3/gZZxt3DTw8V9UPh8lc70XmQOjMzD
         +sViqXfdMAQrF9nWuNt1a13FFeVYyd2TL40Lun9zcNCzWBehBgKV8/3BfQnzKxUc8DD0
         LvuJF6+JqoGXpGcxL5YjYC9To849KpR+Pe7zCyTnC0Gomadzczaj2waBxhNedFmVJ4uG
         kfEg6YDoGvdzS290HkNcRW3u2UMQgRCVynYPlscc7XRCcJMzg3MUxziN1ymAW2cgIw2h
         4MTqS7E+aViW3e2opEgoTLuXqWvd4HptMNcRGTxbdtUhxL+mSeOCAFkLrXN8GIvoMk9p
         BSRQ==
X-Gm-Message-State: AOAM533pCd6G6KlfVVhBSW3tHShKUNVB2c8QCc0edfVCGu0BzL5KWKmk
        SkB7fUwcFQSQuSBtLz0zu8s=
X-Google-Smtp-Source: ABdhPJw9lGhOZEQ8zJlMbQe4HzmueOo9dbUNl5+pYhpmljJJw9niSLnfsjUgHueVB9u/CuMNSpEVEA==
X-Received: by 2002:a17:902:a501:b0:153:f956:29f0 with SMTP id s1-20020a170902a50100b00153f95629f0mr17761940plq.120.1651598440701;
        Tue, 03 May 2022 10:20:40 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8998:54e:9def:1e7c])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090a558300b001d5f22845bdsm1967254pji.1.2022.05.03.10.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:20:40 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 3 May 2022 10:20:38 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Message-ID: <YnFkZmvW2thpIn8o@google.com>
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

Why is the page temporarily unmovable? The GUP didn't increase the
refcount in the case. If it's not migrabtable, that's not a fault
from the GUP but someone is already holding the temporal refcount.
It's not the scope this patchset would try to solve it.

> 
> See my point? We will try migrating in cases where we don't have to

Still not clear for me what you are concerning.

> migrate. I think what we would want to do is always reject pinning a CMA
> page, independent of the isolation status. but we don't have that

Always reject pinning a CMA page if it is *FOLL_LONGTERM*

> information available.

page && (MIGRATE_CMA | MIGRATE_ISOLATE) && gup_flags is not enough
for it?

> 
> I raised in the past that we should look into preserving the migration
> type and turning MIGRATE_ISOLATE essentially into an additional flag.
> 
> 
> So I guess this patch is the right thing to do for now, but I wanted to
> spell out the implications.

I want but still don't understand what you want to write further
about the implication parts. If you make more clear, I am happy to
include it.

> 
> > 
> > A thing to get some attention is whether we need READ_ONCE or not
> > for the local variable mt.
> > 
> 
> Hmm good point. Staring at __get_pfnblock_flags_mask(), I don't think
> there is anything stopping the compiler from re-reading the value. But
> we don't care if we're reading MIGRATE_CMA or MIGRATE_ISOLATE, not
> something in between.

How about this?

     CPU A                                                      CPU B

is_pinnable_page
  ..
  ..                                                set_pageblock_migratetype(MIGRATE_ISOLATE)
  mt == MIGRATE_CMA
    get_pageblock_miratetype(page)
        returns MIGRATE_ISOLATE
  mt == MIGRATE_ISOLATE                             set_pageblock_migratetype(MIGRATE_CMA)
    get_pageblock_miratetype(page)
        returns MIGRATE_CMA
 
So both conditions fails to detect it.

