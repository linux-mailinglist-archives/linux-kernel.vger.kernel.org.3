Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EAC463938
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244759AbhK3PIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245239AbhK3PDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:03:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D03C061756;
        Tue, 30 Nov 2021 07:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EB52B81A23;
        Tue, 30 Nov 2021 15:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EB3C53FCD;
        Tue, 30 Nov 2021 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638284411;
        bh=BQwhEyj52pS1l1fg+KPjQveNu4vJG6JkJekPivvjPDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s52V/VC1pce7mMpz9z5kuG60j9699IWN0FXqKNyuaiyrO4f0PacSSWYUm3WXiDycR
         4czsmyi7J9tWYNsOTb4560WhtKRyYUNLC6+yvCAyfIRHpM6rLQ7l8/QeOM+6UY0h0J
         umKrTS5O/aBCHmiBP5Qr35nFu71VbxyTi3K/JHP6GnjwEYUdRL3qcdQiv6pA30jxp/
         TPTYva+DS5zzkuTlaRlDkvIuPxYfEBld9X52VkLBcIZ7LW9Gt8TGWAPMKhKI/iNCZB
         KGq5FRU7+ooGb2XC6Pt3oEnk0x54KxH1TZH6VqymlgK2vnlRBUS11nYgxYP3qKGsvz
         POUu9A+MoywOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF02840002; Tue, 30 Nov 2021 12:00:08 -0300 (-03)
Date:   Tue, 30 Nov 2021 12:00:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf map: Fix namespace memory leak
Message-ID: <YaY8eBB+PnklIxZA@kernel.org>
References: <20211118193714.2293728-1-irogers@google.com>
 <YaOi6pYqoc3boYX/@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaOi6pYqoc3boYX/@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Nov 28, 2021 at 04:40:26PM +0100, Jiri Olsa escreveu:
> On Thu, Nov 18, 2021 at 11:37:14AM -0800, Ian Rogers wrote:
> > This leak was happening reliably with test "Lookup mmap thread" with
> > stack traces like:
> > 
> > Direct leak of 5504 byte(s) in 172 object(s) allocated from:
> >     #0 0x7f4685e47987 in __interceptor_calloc
> >     #1 0x56063b974c2a in nsinfo__new util/namespaces.c:142
> >     #2 0x56063b9781ff in thread__new util/thread.c:70
> >     #3 0x56063b944953 in ____machine__findnew_thread util/machine.c:543
> >     #4 0x56063b944ac6 in __machine__findnew_thread util/machine.c:574
> >     #5 0x56063b944b36 in machine__findnew_thread util/machine.c:584
> >     #6 0x56063b94c892 in machine__process_fork_event util/machine.c:1954
> >     #7 0x56063b94cc1f in machine__process_event util/machine.c:2019
> >     #8 0x56063b894f18 in perf_event__process util/event.c:567
> >     #9 0x56063ba17951 in perf_tool__process_synth_event util/synthetic-events.c:65
> >     #10 0x56063ba19086 in perf_event__synthesize_fork util/synthetic-events.c:287
> >     #11 0x56063ba1c39d in __event__synthesize_thread util/synthetic-events.c:775
> >     #12 0x56063ba1cf6f in __perf_event__synthesize_threads util/synthetic-events.c:929
> >     #13 0x56063ba1d4ab in perf_event__synthesize_threads util/synthetic-events.c:1000
> >     #14 0x56063b821a3d in synth_all tests/mmap-thread-lookup.c:136
> >     #15 0x56063b821c86 in mmap_events tests/mmap-thread-lookup.c:174
> >     #16 0x56063b8221b7 in test__mmap_thread_lookup tests/mmap-thread-lookup.c:230
> > 
> > The dso->nsinfo is overwritten, but without a nsinfo__put this can leak
> > the overwritten nsinfo.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> nice catch!
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

This one is tricky, I have to retrieve the details from last time this
surfaced, but try:

# perf top -F 10000

leave it for a while and press 'q':

perf: /home/acme/git/perf/tools/include/linux/refcount.h:131: refcount_sub_and_test: Assertion `!(new > val)' failed.
                                                                                                                     Aborted (core dumped)

I reproduced the above assertion a few times, now I'm not being able,
probably some namespace related activity took place when it hit.

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/map.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index 8af693d9678c..ceed8f407bc0 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -192,6 +192,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> >  			if (!(prot & PROT_EXEC))
> >  				dso__set_loaded(dso);
> >  		}
> > +		nsinfo__put(dso->nsinfo);
> >  		dso->nsinfo = nsi;
> >  
> >  		if (build_id__is_defined(bid))
> > -- 
> > 2.34.0.rc2.393.gf8c9666880-goog
> > 

-- 

- Arnaldo
