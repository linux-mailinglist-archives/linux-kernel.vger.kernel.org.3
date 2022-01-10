Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DE9489FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242534AbiAJSxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:53:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:33890 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbiAJSxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:53:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5159CCE16C4;
        Mon, 10 Jan 2022 18:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA0CC36AE3;
        Mon, 10 Jan 2022 18:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641840827;
        bh=u6uaLdOge181QgZ/WBbSjT4alS+LdP4sDloYENcqsnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLUoK6Em10PO+uF0VZvOZcLRrNS2V7xbv+Y6DUmP7cxExszqYfEKe7/eRYvl9Mijg
         dvlf+bUpKSimfPwvgQ/qyxiGog2Y6xJt9LZfJ1aoU8UAVxIis0FeJZphjj4cIxg5H4
         7sjR9Kk14EdunSP2Au51ZORxJV9MyFOuENkfHFlaKoXXhXvl3BvvkFkzuE6cOaaNgl
         Ptj4PUY72DmFFgWnAHC8Cui1oeHiPev1H87Hd/G5SLllHbeTzYm3CTG1+3qspApZoG
         8VFOPtLbw/957MugwQ2QQ+YkRWr5i//PGtBgJRIP1Rqcxad8UQTwQrcLE/m8jk0L6O
         WCFVdih47ch7Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E624140B92; Mon, 10 Jan 2022 15:53:45 -0300 (-03)
Date:   Mon, 10 Jan 2022 15:53:45 -0300
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
Message-ID: <YdyAuTeFjF8n8lyv@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-3-irogers@google.com>
 <57ab982e-ecc1-3f49-c580-0a251e29698b@huawei.com>
 <CAP-5=fWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA@mail.gmail.com>
 <YdyAWxprUpsySNqo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdyAWxprUpsySNqo@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 10, 2022 at 03:52:11PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 10, 2022 at 09:36:49AM -0800, Ian Rogers escreveu:
> > On Mon, Jan 10, 2022 at 9:10 AM John Garry <john.garry@huawei.com> wrote:
> > >
> > > On 05/01/2022 06:13, Ian Rogers wrote:
> > > >
> > > > +struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> > > > +                                    void *data)
> > > > +{
> > > > +     if (idx < 0 || idx > map->nr)
> > > > +             return cpu_map__empty_aggr_cpu_id();
> > > > +
> > > > +     return cpu_map__get_socket_aggr_by_cpu(map->map[idx], data);
> > > > +}
> > > > +
> > >
> > >
> > > This is later deleted in the series. Can the series be reworked so that
> > > we don't add stuff and then later delete it? One reason for that
> > > approach is that we don't spend time reviewing something which will be
> > > deleted, especially in such a big series...
> > 
> > Hi John,
> > 
> > I think you are asking to squash:
> > https://lore.kernel.org/lkml/20220105061351.120843-8-irogers@google.com/
> > into this change. There are other  similar related changes that may
> > also be squashed. The changes are trying to introduce a new API and
> > then add changes to switch over to using it. This is with a view to
> > making bisection easier, have each change only do 1 thing and so on. I
> > believe the format of the patches is house style, but it is fine to
> > squash changes together too. Having sent patches to Arnaldo and having
> > had them split I'm reluctant to do a v5 with them squashed without him
> > expressing a preference.
> 
> Right, sometimes this is needed, I'm getting the patchkit now to test
> build it in my containers and will go patch by patch reviewing.

Good start:

⬢[acme@toolbox perf]$ b4 am -ctsl --cc-trailers CAP-5=fWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA@mail.gmail.com
Looking up https://lore.kernel.org/r/CAP-5%3DfWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA%40mail.gmail.com
Grabbing thread from lore.kernel.org/all/CAP-5%3DfWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA%40mail.gmail.com/t.mbox.gz
Checking for newer revisions on https://lore.kernel.org/all/
Analyzing 58 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v4 1/48] libperf: Add comments to perf_cpu_map.
    + Reviewed-by: John Garry <john.garry@huawei.com>
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    + Link: https://lore.kernel.org/r/20220105061351.120843-2-irogers@google.com
<BIG SNIP>
Cover: ./v4_20220104_irogers_refactor_perf_cpumap.cover
 Link: https://lore.kernel.org/r/20220105061351.120843-1-irogers@google.com
 Base: applies clean to current tree
       git checkout -b v4_20220104_irogers_google_com HEAD
       git am ./v4_20220104_irogers_refactor_perf_cpumap.mbx

:-)

- Arnaldo
