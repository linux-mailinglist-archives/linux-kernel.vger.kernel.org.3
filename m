Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE17F489FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242510AbiAJSwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242078AbiAJSwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:52:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8EC06173F;
        Mon, 10 Jan 2022 10:52:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52D22612C3;
        Mon, 10 Jan 2022 18:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91680C36AE9;
        Mon, 10 Jan 2022 18:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641840733;
        bh=ugqSPIF8K4VUyc1yLrYk37FCTxg9K+XwiPzUpm7HVTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lHPdJysUXFzcYAUcr+1rYMIcKOBI4FevYMvVWOazbI/2lfXWBKnB1wgKUrPBH0V5C
         Sr0qMP6SWnTTGCSTsPyeBEB4gCtwvp35WRt7ODbaqyNhU7QOw4NpM7ChK30o5BKC9U
         5t2z/JuoW9M8yHT3Xq6r0G5SDeCNUGxMfY+AVRKaU5uGmb7YXCND5qDsCPN6agmz80
         1ehxZhBA0OuOAX5XjE5xbN6QMxfhgD8VAKfB1rXYkdpY4onwQFLP4kc5BPtSh0AkQv
         nr+cTiPLCtxmhEy9GTXOP+Meb6fQd+ORw+RLPj97HVwKVzOI+37UeGxLyVND8LswpP
         MdOffFpOO4Mfg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B44B440B92; Mon, 10 Jan 2022 15:52:11 -0300 (-03)
Date:   Mon, 10 Jan 2022 15:52:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Subject: Re: [PATCH v4 02/48] perf stat: Add aggr creators that are passed a
 cpu.
Message-ID: <YdyAWxprUpsySNqo@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-3-irogers@google.com>
 <57ab982e-ecc1-3f49-c580-0a251e29698b@huawei.com>
 <CAP-5=fWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 10, 2022 at 09:36:49AM -0800, Ian Rogers escreveu:
> On Mon, Jan 10, 2022 at 9:10 AM John Garry <john.garry@huawei.com> wrote:
> >
> > On 05/01/2022 06:13, Ian Rogers wrote:
> > >
> > > +struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> > > +                                    void *data)
> > > +{
> > > +     if (idx < 0 || idx > map->nr)
> > > +             return cpu_map__empty_aggr_cpu_id();
> > > +
> > > +     return cpu_map__get_socket_aggr_by_cpu(map->map[idx], data);
> > > +}
> > > +
> >
> >
> > This is later deleted in the series. Can the series be reworked so that
> > we don't add stuff and then later delete it? One reason for that
> > approach is that we don't spend time reviewing something which will be
> > deleted, especially in such a big series...
> 
> Hi John,
> 
> I think you are asking to squash:
> https://lore.kernel.org/lkml/20220105061351.120843-8-irogers@google.com/
> into this change. There are other  similar related changes that may
> also be squashed. The changes are trying to introduce a new API and
> then add changes to switch over to using it. This is with a view to
> making bisection easier, have each change only do 1 thing and so on. I
> believe the format of the patches is house style, but it is fine to
> squash changes together too. Having sent patches to Arnaldo and having
> had them split I'm reluctant to do a v5 with them squashed without him
> expressing a preference.

Right, sometimes this is needed, I'm getting the patchkit now to test
build it in my containers and will go patch by patch reviewing.

- Arnaldo
 
> Thanks,
> Ian
> 
> > If it really makes sense to do it this way then fine.
> >
> > Thanks,
> > John

-- 

- Arnaldo
