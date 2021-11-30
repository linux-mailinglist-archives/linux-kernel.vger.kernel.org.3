Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF6346379D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbhK3Oy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:54:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57940 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242896AbhK3Ox0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:53:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55A98CE1A5E;
        Tue, 30 Nov 2021 14:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A54BC53FD0;
        Tue, 30 Nov 2021 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638283804;
        bh=HE2oOh39yQJe14YTlEp9AbmC1U5Mk6YUUJMA2GaCuS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxU7M1ihXn0ifIMt4wcUTYI9XK3AUWlleOmrC/9NE3DBSZj0V9PpkCArhlFmT+Oqj
         SCW5jYPbQToje7FMzAxkhxDsZQldk+nX4eVggy3aCTGlKudRMDzlpgf4Mz708pglZI
         qrwS8E1nLNruZQtgWSByVIS37DP5PQqHb1LHnkTgR1ohG/MLB8q9ku5KoM2TjEteSk
         qQFvm2reuIebnqYlgj4R4R6NvsO8cmp4Bng5MZHQtZiH9qeYJrBRt+4RGV1cVMAngJ
         4+X2CFbsiun+6kv1g1+KPORW83+Bh9Vp42zJ/3aAa1SyN4/Ayti2GmrV5ft/ktsLHX
         R2PbpttWOLCqg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F33540002; Tue, 30 Nov 2021 11:50:01 -0300 (-03)
Date:   Tue, 30 Nov 2021 11:50:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH] perf test: Reset shadow counts before loading
Message-ID: <YaY6GXquDQoviL66@kernel.org>
References: <20211128085810.4027314-1-irogers@google.com>
 <YaOuadwZWje6HeTg@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaOuadwZWje6HeTg@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Nov 28, 2021 at 05:29:29PM +0100, Jiri Olsa escreveu:
> On Sun, Nov 28, 2021 at 12:58:10AM -0800, Ian Rogers wrote:
> > Otherwise load counting is an average. Without this change
> > duration_time in test_memory_bandwidth will alter its value if an
> > earlier test contains duration_time.
> > 
> > This patch fixes an issue that's introduced in the proposed patch:
> > https://lore.kernel.org/lkml/20211124015226.3317994-1-irogers@google.com/
> > in perf test "Parse and process metrics".
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> jirka
> 
> > ---
> >  tools/perf/tests/parse-metric.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> > index 574b7e4efd3a..07b6f4ec024f 100644
> > --- a/tools/perf/tests/parse-metric.c
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -109,6 +109,7 @@ static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
> >  	struct evsel *evsel;
> >  	u64 count;
> >  
> > +	perf_stat__reset_shadow_stats();
> >  	evlist__for_each_entry(evlist, evsel) {
> >  		count = find_value(evsel->name, vals);
> >  		perf_stat__update_shadow_stats(evsel, count, 0, st);
> > -- 
> > 2.34.0.rc2.393.gf8c9666880-goog
> > 

-- 

- Arnaldo
