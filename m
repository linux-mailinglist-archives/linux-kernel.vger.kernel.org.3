Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CAC52408D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349014AbiEKXJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244815AbiEKXI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:08:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ACD712E6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:08:58 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 31so3029709pgp.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wIweqL7nL0uGL+2TyN5HkavvrhV0GyO0vocmy92xs5M=;
        b=Ej7Rha+dCOnANbGVTVqMVC0phj6sIXfpDrEvxyVChxC6Ni1c2yEGFy0tCdvY70WFhZ
         OVfB5Pj3AkeYvFXQCx3oVSfI+tD7WdwuAfpcHLq81hgMiqJAxnxWbAZPxfF7EPRmQay1
         XXbwNJ+MopRp7S9FzXOexARBJmnGOOo3Ff8DwldilTS+8IlcqlzXm1gpm2mBUTnVgyD8
         Sg0OYJSmX9vX/K/Fk31OF3KtXKULVIKns2rig5qclWLYnk8d3WgsBHgAizWO+/oKzjUt
         RRm6xZ1pGYncpIdEY24P7MbOSw2xd0ZVkREdI4C3jORnfkyudblHpPqfgTl3jJFR/YFY
         dIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wIweqL7nL0uGL+2TyN5HkavvrhV0GyO0vocmy92xs5M=;
        b=VqxXB6Yr0zhso3sJJF7AJgtTl0jzRm8ZwIgLdSxfQkular2aStPpL7IcvO6/VpnRyS
         rgqWjJy0N5KWHTDm4nvOL3PE9oUINoSdSyChXXRfjm78kJkmBL5GLqF75Oeq9YiqOrRx
         /3m1zhsJ9mSOPvsus3m8/8jlikTFNqrZvAbPrCniA4QUyJyvEBZdTi8dJqaSXSSvCimp
         IoNHWu5UQ0cOF93g5J24CIW1p/aT/yxDnZ5U2UVoVggl8gfmc8KR3fK52ER/td0rIrJ7
         zluhs8SkaGu+3w6+Ywi8wsT0xdma87gZFDMuX6TNXuRZLbjOFy8sO4bctTc6ZzsgDyLM
         ozHA==
X-Gm-Message-State: AOAM532tiF/0bbboYzoLjxNf9upBpQucdCS98ydYfYf0555wF360DHe0
        nxLXztETg1tSSud4n1A98aw=
X-Google-Smtp-Source: ABdhPJyALO7vReOK16JWC0Y0/v1s8SdaXQPwT9Pz94WN0PbURyqZEqG/0PW/nzhbTvVZmPFwgtoSuA==
X-Received: by 2002:a05:6a00:134f:b0:50e:10e0:ef82 with SMTP id k15-20020a056a00134f00b0050e10e0ef82mr27151305pfu.45.1652310538340;
        Wed, 11 May 2022 16:08:58 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:69ef:9c87:7816:4f74])
        by smtp.gmail.com with ESMTPSA id k130-20020a628488000000b0050dc762819bsm2307925pfd.117.2022.05.11.16.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 16:08:57 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 11 May 2022 16:08:56 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <YnxCCPZUfgQNXSg6@google.com>
References: <20220510211743.95831-1-minchan@kernel.org>
 <857d21da-5de2-fa3e-b1ce-41cc1cfb0191@nvidia.com>
 <Ynr10y6pkH6WwbQo@google.com>
 <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
 <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
 <YnwupNzDNv7IbjRQ@google.com>
 <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
 <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
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

On Wed, May 11, 2022 at 03:49:06PM -0700, John Hubbard wrote:
> On 5/11/22 15:37, Minchan Kim wrote:
> > > Yes. But one thing that is still unanswered, that I think you can
> > > answer, is: even if the compiler *did* re-read the mt variable, what
> > > problems could that cause? I claim "no problems", because there is
> > > no combination of 0, _CMA, _ISOLATE, _CMA|ISOLATE that will cause
> > > problems here.
> > 
> > What scenario I am concerning with __READ_ONCE so compiler
> > inlining get_pageblock_migratetype two times are
> > 
> >          CPU 0                                                       CPU 1
> >                                                                  alloc_contig_range
> > is_pinnable_page                                                start_isolate_page_range
> >                                                                    set_pageblock_migratetype(MIGRATE_ISOLATE)
> >     if (get_pageeblock_migratetype(page) == MIGRATE_CMA)
> >         so it's false
> >                                                                  undo:
> >                                                                    set_pageblock_migratetype(MIGRATE_CMA)
> >     if (get_pageeblock_migratetype(page) == MIGRATE_ISOLATE)
> >         so it's false
> > 
> > In the end, CMA memory would be pinned by CPU 0 process
> > so CMA allocation keep failed until the process release the
> > refcount.
> > 
> 
> OK, so the code checks the wrong item each time. But the code really
> only needs to know "is either _CMA or _ISOLATE set?". And so you

Yes.

> can just sidestep the entire question by writing it like this:
> 
> int mt = get_pageblock_migratetype(page);
> 
> if (mt & (MIGRATE_ISOLATE | MIGRATE_CMA))
> 	return false;

I am confused. Isn't it same question?

                                                    set_pageblock_migratetype(MIGRATE_ISOLATE)
if (get_pageblock_migrate(page) & MIGRATE_CMA)

                                                    set_pageblock_migratetype(MIGRATE_CMA)

if (get_pageblock_migrate(page) & MIGRATE_ISOLATE)
