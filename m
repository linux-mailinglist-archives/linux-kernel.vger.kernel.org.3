Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C848B8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244299AbiAKUrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:47:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34878 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240166AbiAKUrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:47:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F03B616B2;
        Tue, 11 Jan 2022 20:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D183CC36AE3;
        Tue, 11 Jan 2022 20:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934035;
        bh=+c9k+0bBSI9xHBs8z7/fubykKwBCZwU5h6VZvwPC3g0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fiSSSp+ArvfmByS5aoQPs5RPd4FIoeUJ5xd7PGRE1nbZCKEDfNmqNmPZf2j5bFtrm
         fpGmcKHQije5VN/n0QAj1fZHKgKJzGZv8fzXDRtpLqV2+g0+NogbcCf7BM/9l5U9lH
         HDSEQwTX5Eiqd5kiCM//m/8aNTbSxiU2IsKEz6ckcHO4tQknKTqMuNgEofjk1plzC6
         hAPOozidvbT+bOzGKZm+YWUlelVKSL7kMMyVjb1d9BtNCrtoMRujb7c4PebgHVNWG2
         pAi+9/Vc1uAxPzRG1FN4afnLXU2NrvcTShL6zC1wm1Dtc8Am7TrzsbsL8LF68/hrag
         fS3SW9JiPU23Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2368C40714; Tue, 11 Jan 2022 17:47:11 -0300 (-03)
Date:   Tue, 11 Jan 2022 17:47:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
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
Subject: Re: [PATCH v4 48/48] perf cpumap: Give CPUs their own type.
Message-ID: <Yd3sz/P3UXae7xxx@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-49-irogers@google.com>
 <YdyOFd8JJHbm1W+m@kernel.org>
 <CAP-5=fWZWMweYhWvv1vr6quZe=ZJrhF_WEXqbELVitzofBcQrA@mail.gmail.com>
 <Yd3iBvVim1vB81pM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yd3iBvVim1vB81pM@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 11, 2022 at 05:01:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jan 11, 2022 at 11:16:16AM -0800, Ian Rogers escreveu:
> > On Mon, Jan 10, 2022 at 11:50 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > > Em Tue, Jan 04, 2022 at 10:13:51PM -0800, Ian Rogers escreveu:
> > > > A common problem is confusing CPU map indices with the CPU, by wrapping
> > > > the CPU with a struct then this is avoided. This approach is similar to
> > > > atomic_t.
> > >
> > > This one needed this to build with BUILD_BPF_SKEL=1, please check, I'll
> > > soon push this to tmp.perf/perf_cpu so that you can take a look and test
> > > it.

> > Thanks Arnaldo, I did eye-ball one issue where cpu_map__default_new's
> > behavior would be impacted (nr would be 1 rather than nr_cpus). The
> > fix is:
> > 
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -18,7 +18,7 @@ static struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
> >         if (!cpus)
> >                 return NULL;
> > 
> > -       cpus->nr = 1;
> > +       cpus->nr = nr_cpus;
> >         refcount_set(&cpus->refcnt, 1);
> >         return cpus;
> >  }
> 
> > Could you add that into this patch as well?
> 
> Sure.
> 
> I´m now running perf-test after each of those csets, so far so good.

This is what I'm running now after doing a 'git rebase -i
start-of-your-patchkit' with all set to 'edit'.

Will take a while :-)

# cat ~/bin/perf-test-build
#!/bin/bash

while true ; do
	rm -rf /tmp/build/perf ; sudo -u acme mkdir /tmp/build/perf
	sudo -u acme make -k BUILD_BPF_SKEL=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin || exit 1
	cd ..
	perf test || exit 2
	cd -
	sudo -u acme git rebase --continue || exit 0
done

- Arnaldo
