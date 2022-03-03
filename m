Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A1D4CC846
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiCCVod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiCCVoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:44:32 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7785FDF49C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:43:45 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id bc10so5847732qtb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 13:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hTwwN6PiJVHaKqnPKPesjc7eXIn2FCgdMkVnCPREWLc=;
        b=bq6u4nU32h9czB4hqHrURQXbdgy/m7NrxkgoFp2Hqjia8te+uATT004m1EnZOopthW
         GaTmCBg8Xik6cbS1qGfn/dB5PE1l8OmlWNnFC1WEwdu0EKjaFsGPZd5uUw034wyTvgh/
         O6UrmV5s5rdSOlBF+7Wz3yOiFHWzI6DVlAOh19zoSm/F9UD9jwpnv80X/k6AqicljJB2
         h0KU8+QZaCRLxl78mf3LXT1f8fVPzTtYE2OiNQrWkE8P3qCE0pkNleQB8vD6O55BKalo
         wmrD51eJCZvV/qXZBBG09fPPU9Az1vVhsH5OdNVrecuZhj6Ft3kRYHUEoaxiOa4TtXIS
         TFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hTwwN6PiJVHaKqnPKPesjc7eXIn2FCgdMkVnCPREWLc=;
        b=olasp8c2z1ZKMlAWqaRJ7meqtSK0balzbQzNNSCoRCvFCma3k4EZRdYLp0f+5km2ip
         etHnymzCquGBW1NBF9L+v2CZ/wUP+TNp2Ku3EpBZl7bRinuNpxhjL0Q4CPL358ICOE+4
         s5AlKtDPCT5i+SLtmdikccKcW0y1gIyLZ/KZ3rAzeG09QXgG+RujROBU4i0Z+FERIHL0
         s4AhAg+BpEFOdWWCP4kKo8zzTd+Z8iEH7RQVdBGsNoMeb+bMpZ9KwV2mx6zJQWX3tWEB
         YgQMfTSmZUWd9IJxTJ0d7zrcVP6S837a1Jx9RRysaqvO32FgFmaS1yyk71Atfd9b4KiN
         vRww==
X-Gm-Message-State: AOAM532y4GUrbXxQ9crhmNBEd54x9yTCkZZVTDy0bRGzSrctqiG8NC2T
        2d4wT3rRotwid2Vh6xjhizSZhQ==
X-Google-Smtp-Source: ABdhPJzFu79fPe/pA+ZUmBn0NTH8kz6UBe2UfFjuH7s7jtI5XJqDyMox+AgQF9nHb+vLn+ADauoR2g==
X-Received: by 2002:ac8:7c4b:0:b0:2dc:a139:52c7 with SMTP id o11-20020ac87c4b000000b002dca13952c7mr29178649qtv.188.1646343824657;
        Thu, 03 Mar 2022 13:43:44 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id c6-20020ac87d86000000b002ddd9f33ed1sm2376259qtd.44.2022.03.03.13.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 13:43:43 -0800 (PST)
Date:   Thu, 3 Mar 2022 16:43:43 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
Message-ID: <YiE2jz6dHzVU7awj@cmpxchg.org>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-5-yuzhao@google.com>
 <YgV4lZXc6+jhUdsR@cmpxchg.org>
 <Ygt1qaQM5YobEZK9@google.com>
 <Ygwg9NXzQ+6U3RON@cmpxchg.org>
 <YhNJ4LVWpmZgLh4I@google.com>
 <YiDe6DcLGEfTTKD5@cmpxchg.org>
 <CAOUHufYSAUT+t3bTUoNwXTpYPKX0N437m_WQoT79gzWYgnLY9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufYSAUT+t3bTUoNwXTpYPKX0N437m_WQoT79gzWYgnLY9A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 12:26:45PM -0700, Yu Zhao wrote:
> On Thu, Mar 3, 2022 at 8:29 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Mon, Feb 21, 2022 at 01:14:24AM -0700, Yu Zhao wrote:
> > > On Tue, Feb 15, 2022 at 04:53:56PM -0500, Johannes Weiner wrote:
> > > > On Tue, Feb 15, 2022 at 02:43:05AM -0700, Yu Zhao wrote:
> > > > > On Thu, Feb 10, 2022 at 03:41:57PM -0500, Johannes Weiner wrote:
> > > > > > You can drop the memcg parameter and use lruvec_memcg().
> > > > >
> > > > > lruvec_memcg() isn't available yet when pgdat_init_internals() calls
> > > > > this function because mem_cgroup_disabled() is initialized afterward.
> > > >
> > > > Good catch. That'll container_of() into garbage. However, we have to
> > > > assume that somebody's going to try that simplification again, so we
> > > > should set up the code now to prevent issues.
> > > >
> > > > cgroup_disable parsing is self-contained, so we can pull it ahead in
> > > > the init sequence. How about this?
> > > >
> > > > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > > > index 9d05c3ca2d5e..b544d768edc8 100644
> > > > --- a/kernel/cgroup/cgroup.c
> > > > +++ b/kernel/cgroup/cgroup.c
> > > > @@ -6464,9 +6464,9 @@ static int __init cgroup_disable(char *str)
> > > >                     break;
> > > >             }
> > > >     }
> > > > -   return 1;
> > > > +   return 0;
> > > >  }
> > > > -__setup("cgroup_disable=", cgroup_disable);
> > > > +early_param("cgroup_disable", cgroup_disable);
> > >
> > > I think early_param() is still after pgdat_init_internals(), no?
> >
> > It's called twice for some reason, but AFAICS the first one is always
> > called before pgdat_init_internals():
> >
> > start_kernel()
> >   setup_arch()
> >     parse_early_param()
> >     x86_init.paging.pagetable_init();
> >       paging_init()
> >         zone_sizes_init()
> >           free_area_init()
> >             free_area_init_node()
> >               free_area_init_core()
> >                 pgdat_init_internals()
> >   parse_early_param()
> >
> > It's the same/similar for arm, sparc and mips.
> 
> Thanks for checking. But I'd rather live with an additional parameter
> than risk breaking some archs.

As per above, somebody is going to try to make that simplification
again in the future. It doesn't make a lot of sense to have a reviewer
trip over it, have a discussion about just how subtle this dependency
is, and then still leave it in for others. parse_early_param() is
documented to be called by arch code early on, there isn't a good
reason to mistrust our own codebase like that. And special-casing this
situation just complicates maintainability and hackability.

Please just fix the ordering and use lruvec_memcg(), thanks.
