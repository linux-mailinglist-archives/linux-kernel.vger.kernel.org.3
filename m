Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D02D4A3980
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 21:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356195AbiA3UvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 15:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356209AbiA3UvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 15:51:01 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0C5C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 12:51:01 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f8so10325147pgf.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 12:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=h/cECQtg8Pw42Cg8cQsPRdyEcNVz1JX9ppZ0jmJVNMk=;
        b=EHTJS8+k2oaZV3vVFaJi4iJnm0zTSudXRujif1Kg4Tp24zztawm4YKkJNwtJ7gfazF
         5K+1rmI0TVvt0DGZ6YBUEIG12v8eHqBV1UsbO/LzbaLa0eM39ts+ZyGBl34z5d5QgniJ
         1hpersz5zRY4G+y4q2ekP/+rdom2g3zfRXtMgj/RM2b37DddUCoONkB5e6GM8zQl0BOV
         DBCqtTfm0eQnE9ZOasZIqc/u30BO5tZzfiNBs4PyK0h2pzdnv2ptr4d7tKwa+t1q/p6W
         msJ1N0brQOFLJF6BoGEzsZwT1Kz6peBfXtDcoDEqFr20lzOI5N330P5Zsq1VrDex68Tf
         I2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=h/cECQtg8Pw42Cg8cQsPRdyEcNVz1JX9ppZ0jmJVNMk=;
        b=O9MpljHtyAwmeo8Ox5vekQ+aSIG2129yCvcxySPG1aH1SeOzu/YUKGhFvZJchcRAFW
         j7Uvna4wxBuxz7ZtbO1ng9LfI2Xb1TQ66xJhH7ReyOSkkP2EDgtfqJb5utzp0V/Wm09K
         EJUUrnl11ZS0WKAnKleRU7qmOPajzcPAO55SyPa1rfDP2g3XP3YbzfbUZzyFIo+5dWx3
         LSyYoM11SZrIWz9WlvXdt8wSt+m/E+Ca1xye+qJENNlKPFlCPnYEv35evr0guSJavxpi
         AkWJafw5bfpIxv7llbNLa2jEo9MVCQVFW+KdyiqAJ3d1CmqyrJGp25fS1tgiNjjif0d9
         0Zrg==
X-Gm-Message-State: AOAM533uQU15NjCSVs9YlowWTtw/tdhRXFzWXojMcJ+u4cY2aPmMb8fr
        FDgkmiIzoPnLZACpiDepCqfezg==
X-Google-Smtp-Source: ABdhPJzs5QT4hSyiXDW0w+kuEtJ2YnOPY8LVhV+3eFUUrhxXSy0lp/IasnFuWgxFPg5FekD3jRe0aA==
X-Received: by 2002:a05:6a00:2490:: with SMTP id c16mr17989852pfv.36.1643575860942;
        Sun, 30 Jan 2022 12:51:00 -0800 (PST)
Received: from [2620:15c:29:204:2b97:ce13:593d:973d] ([2620:15c:29:204:2b97:ce13:593d:973d])
        by smtp.gmail.com with ESMTPSA id q2sm873311pfj.94.2022.01.30.12.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 12:51:00 -0800 (PST)
Date:   Sun, 30 Jan 2022 12:51:00 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Waiman Long <longman@redhat.com>
cc:     Mike Rapoport <rppt@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
In-Reply-To: <82c99093-e44b-7fac-14ab-9e8392d107ea@redhat.com>
Message-ID: <973ec252-5297-ef24-411-31f24b353fb3@google.com>
References: <20220129205315.478628-1-longman@redhat.com> <20220129205315.478628-4-longman@redhat.com> <YfYxJR7ugv83ywAb@kernel.org> <82c99093-e44b-7fac-14ab-9e8392d107ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022, Waiman Long wrote:

> On 1/30/22 01:33, Mike Rapoport wrote:
> > On Sat, Jan 29, 2022 at 03:53:15PM -0500, Waiman Long wrote:
> > > It was found that a number of offlined memcgs were not freed because
> > > they were pinned by some charged pages that were present. Even "echo
> > > 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
> > > offlined but not freed memcgs tend to increase in number over time with
> > > the side effect that percpu memory consumption as shown in /proc/meminfo
> > > also increases over time.
> > > 
> > > In order to find out more information about those pages that pin
> > > offlined memcgs, the page_owner feature is extended to dump memory
> > > cgroup information especially whether the cgroup is offlined or not.
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > ---
> > >   mm/page_owner.c | 31 +++++++++++++++++++++++++++++++
> > >   1 file changed, 31 insertions(+)
> > > 
> > > diff --git a/mm/page_owner.c b/mm/page_owner.c
> > > index 28dac73e0542..8dc5cd0fa227 100644
> > > --- a/mm/page_owner.c
> > > +++ b/mm/page_owner.c
> > > @@ -10,6 +10,7 @@
> > >   #include <linux/migrate.h>
> > >   #include <linux/stackdepot.h>
> > >   #include <linux/seq_file.h>
> > > +#include <linux/memcontrol.h>
> > >   #include <linux/sched/clock.h>
> > >     #include "internal.h"
> > > @@ -331,6 +332,7 @@ print_page_owner(char __user *buf, size_t count,
> > > unsigned long pfn,
> > >   		depot_stack_handle_t handle)
> > >   {
> > >   	int ret, pageblock_mt, page_mt;
> > > +	unsigned long __maybe_unused memcg_data;
> > >   	char *kbuf;
> > >     	count = min_t(size_t, count, PAGE_SIZE);
> > > @@ -365,6 +367,35 @@ print_page_owner(char __user *buf, size_t count,
> > > unsigned long pfn,
> > >   			migrate_reason_names[page_owner->last_migrate_reason]);
> > >   	}
> > >   +#ifdef CONFIG_MEMCG
> > Can we put all this along with the declaration of memcg_data in a helper
> > function please?
> > 
> Sure. Will post another version with that change.
> 

That would certainly make it much cleaner.  After that's done (and perhaps 
addressing my nit comment in the first patch), feel free to add

	Acked-by: David Rientjes <rientjes@google.com>

to all three patches.

Thanks!
