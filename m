Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D6548A257
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbiAJWFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345177AbiAJWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:05:01 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F6BC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:05:00 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id j1so9787202iob.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZF1CJQBzh/80v0BtRZispFGHTetfiJtaTzECzTUh4ls=;
        b=dx0D386bXH4QfkdfHO50yb/ut/bhAD5N6GmCuKkMh4mmQQbt9bw3Ok/yfATHoc+iQI
         qAeFeHqFnnPW4sGu8eYXyyD9lU3rQ7rcd72g2G4L1gxA/PhC1T8w5gwMsm4VLr4UZJCn
         j7pYB7yDIldEzkB7XE3UPev7QKCCceR1V7oIsEu0s7T8aKqjJDkc+nEue19/Q4IRcGBp
         eWinzrVVnAoWsRrtgxPJi5QLe9blKyBY9ylmdPHxkdIyszk1rHTvVVmHq0O2epJSIcC3
         Xdftd7hExeHdJjDYgmeifiP8P+lBocrEIQ8Hi8kLOEzuC0HrpmIVkAHu86Fx3sjCo+64
         VxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZF1CJQBzh/80v0BtRZispFGHTetfiJtaTzECzTUh4ls=;
        b=zKfTY0DdsZ9/jKTw5jywvyvUNiOeT4HALx9UqZs+0vhcJW4+NzHmuAajuunDDxc6oi
         YiokjzJx/yIAmeeRNj99yScjtziUg0LzirK/tBC2Rq77k4LpxPCXYbw9VLps/rWuikqq
         jDFK/HghsrZSuFB8YNcCgSitQWB3Qg+HRcsB6d37KWuVHR6VkZuZBl/TD9ebhXk06ECa
         Eucxq4dVWg6rBUk51z8aAJtjxqd4U11jDBwyTDqmpNuzeybkSnLNtqOab4bStqLmqPrG
         BQNDjeih9ClhK7wxTOKTi44yD069gDrc+ZEZNmw5MV+d08tXqQIAxsDz6wyVF6Hh1AWJ
         Lhjw==
X-Gm-Message-State: AOAM5308T3ZmyEutiBXpdwh06aa72YLXun9V2H5CeTWP6GJV7LpZ2g4L
        d6evvlh8WR+ATyZ3itBt8JFAiw==
X-Google-Smtp-Source: ABdhPJziaqAPZyGTfrPdWvsoPVFD8RNO6WlMKxKetxjQmQbenL9eNyAzlV+ZGAmku4iALDqt7TKy8Q==
X-Received: by 2002:a6b:8f0b:: with SMTP id r11mr875799iod.20.1641852299693;
        Mon, 10 Jan 2022 14:04:59 -0800 (PST)
Received: from google.com ([2620:15c:183:200:d17d:9fe6:6a18:f270])
        by smtp.gmail.com with ESMTPSA id f1sm4986646iow.33.2022.01.10.14.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:04:59 -0800 (PST)
Date:   Mon, 10 Jan 2022 15:04:54 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Message-ID: <YdythmxHpSksJiXs@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <YdSuSHa/Vjl6bPkg@google.com>
 <YdgKClGAuHlkzVbQ@dhcp22.suse.cz>
 <YdiKVJlClB3h1Kmg@google.com>
 <YdxTR4+FL08XyFuO@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdxTR4+FL08XyFuO@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:39:51PM +0100, Michal Hocko wrote:
> On Fri 07-01-22 11:45:40, Yu Zhao wrote:
> [...]
> > Next, I argue that the benefits of this patchset outweigh its risks,
> > because, drawing from my past experience,
> > 1. There have been many larger and/or riskier patchsets taken; I'll
> >    assemble a list if you disagree.
> 
> No question about that. Changes in the reclaim path are paved with
> failures and reverts and fine tuning on top of existing fine tuning.
> The difference from your patchset is that they tend to be much much
> smaller and go incremental and therefore easier to review.

No argument here.

> >    And this patchset is fully guarded
> >    by #ifdef; Linus has also assessed on this point.
> 
> I appreciate you made the new behavior an opt-in and therefore existing
> workloads are less likely to regress. I do not think ifdefs help
> all that much, though, because a) realistically the config will
> likely be enabled for most distribution kernels

There is also a runtime kill switch.

> b) the parallel
> reclaim implementation adds a maintenance overhead regardless of those
> ifdef. The later point is especially worrying because the memory reclaim
> is a complex and hard to review beast already. Any future changes would
> need to consider both reclaim algorithms of course.

A perfectly legitimate concern.

If this patchset is taken:
1. There will be refactoring that makes the long-term maintenance as
   affordable as possible, i.e., similar to the SL.B model, but can
   also make runtime switch.
2. There will also be optimizations for mmu notifier (KVM), THP, etc.
3. Most importantly, Google will be committing more resource on this.
   And that's why we need to hear a decision -- our resource planning
   depends on it.

> Hence I argue we really need a wider consensus this is the right
> direction we want to pursue.

We've been doing our best to get this consensus -- we invited all
the stakeholders to meetings a long time ago -- but unfortunately we
couldn't move the needle.

I agree consensus is important. But, IMO, progress is even more
important. And personally, I'd rather try something wrong than do
nothing.

> > 2. There have been none that came with the testing/benchmarking
> >    coverage as this one did. Please point me to some if I'm mistaken,
> >    and I'll gladly match them.
> 
> I do appreciate your numbers but you should realize that this is an area
> that is really hard to get any conclusive testing for.

Fully agreed. That's why we started a new initiative, and we hope more
people will following these practices:
1. All results in this area should be reported with at least standard
   deviations, or preferably confidence intervals.
2. Real applications should be benchmarked (with synthetic load
   generator), not just synthetic benchmarks (not real applications).
3. A wide range of devices should be covered, i.e., servers, desktops,
   laptops and phones.

I'm very confident to say our benchmark reports were hold to the
highest standards. We have worked with MariaDB (company), EnterpriseDB
(Postgres), Redis (company), etc. on these reports. They have copies
of these reports (PDF version):
https://linux-mm.googlesource.com/benchmarks/

We welcome any expert in those applications to examine our reports,
and we'll be happy to run any other benchmarks or same benchmarks with
different configurations that anybody thinks it's important and we've
missed.

> We keep learning
> about fallouts on workloads we haven't really anticipated or where the
> runtime effects happen to disagree with our intuition. So while those
> numbers are nice there are other important aspects to consider like the
> maintenance cost for example.

I assume we agree this is not an easy decision. Can I also assume we
agree that this decision should be make within a reasonable time frame?

> > The numbers might not materialize in the real world; the code is not
> > perfect; and many other risks... But all the top eight open source
> > memory hogs were covered, which is unprecedented; memcached and fio
> > showed significant improvements and it only takes a few commands to
> > see for yourselves.
> > 
> > Regarding the acks and the reviewed-bys, I certainly can ask people
> > who have reaped the benefits of this patchset to do them, if it's
> > required. But I see less fun in that. I prefer to provide empirical
> > evidence and convince people who are on the other side of the aisle.
> 
> I like to hear from users who benefit from your work and that certainly
> gives more credit to it. But it will be the MM community to maintain the
> code and address future issues.

I'll ask downstream kernel maintainers (from different distros) that
have taken this patchset to ACK.

I'll ask credible testers who are professionals, researchers,
contributors to other subsystems to provide Test-by's. There are many
other individual testers I may not be able to acknowledge their
efforts, e.g., my coworker just sent this to me:

   Using that v5 for some time and confirm that difference under heavy
   load and memory pressure is significant."
https://www.phoronix.com/forums/forum/software/general-linux-open-source/1301258-mglru-is-a-very-enticing-enhancement-for-linux-in-2022#post1301275

I'll leave the reviews in your capable hands. As I said, I prefer to
convince people with empirical evidence.

> We do not have a dedicated maintainer for the memory reclaim but
> certainly there are people who have helped shaping the existing code and
> have learned a lot from the past issues - like Johannes, Rik, Mel just
> to name few. If I were you I would be really looking into finding an
> agreement with them. I myself can help you with memcg and oom side of
> the things (we already have discussions about those).

Unfortunately people have different priorities. As I said, we tried
to get all the stakeholders in the same (conference) room so that we
can make some good progress. But we failed.

Rest assured, we'll keep trying. But please understand we need to do
cost control and therefore we can't keep investing in this effort
forever. So I think it's not unreasonable, after I've addressed all
pending comments, to ask for some clear instructions from the
leadership:
    Yes
    No
    Or something specific

Thanks!
