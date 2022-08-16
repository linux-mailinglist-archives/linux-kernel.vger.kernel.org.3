Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6034959637C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiHPUDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbiHPUDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCAE61726;
        Tue, 16 Aug 2022 13:03:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 008A960D30;
        Tue, 16 Aug 2022 20:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3612BC433C1;
        Tue, 16 Aug 2022 20:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660680199;
        bh=LQFoXT2HLF1Tpycwucq2SVhDf8r7squq8N/cdxF+OzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeUWW+EdntwkNJ5LDynz5RjWctc37bpL3sPbHOjUPhiBLuWhPojbArR2/NquDlxHM
         IIEfgV4xDptjF9fnwK9NRqJUxHVZHqo8VhDvxMoN7CdMAJZsqagdPYH8S5sgik+BA9
         8CL7k0sOOlraYs4A3BoNL81ReVOijASYM6sqvz1Q7Vf1zsTcvXH1Pn9D2843s9+sp0
         cmsyNcZ6XafIx0KWH+ouoK6n8KIijR/CDyv52ywJRJNsFuWsKuuKtJermuDLG8wAK4
         MgDjYwumuTtYcMFwl2qDx1lhwnCUqXFlLgMDshj43ALTTL8kamnYz+P3EJ2MEZ6Xun
         om3dr7W4lb3+Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ABBF04035A; Tue, 16 Aug 2022 17:03:16 -0300 (-03)
Date:   Tue, 16 Aug 2022 17:03:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] tools lib perf: Handle read format in
 perf_evsel__read()
Message-ID: <Yvv4BBZhxpLfaMs7@kernel.org>
References: <20220815190106.1293082-1-namhyung@kernel.org>
 <20220815190106.1293082-3-namhyung@kernel.org>
 <YvuZWAzsBVo/l9sf@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvuZWAzsBVo/l9sf@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 16, 2022 at 03:19:20PM +0200, Jiri Olsa escreveu:
> On Mon, Aug 15, 2022 at 12:01:04PM -0700, Namhyung Kim wrote:
> > The perf_counts_values should be increased to read the new lost data.
> > Also adjust values after read according the read format.
> > 
> > This supports PERF_FORMAT_GROUP which has a different data format but
> > it's only available for leader events.  Currently it doesn't have an API
> > to read sibling (member) events in the group.  But users may read the
> > sibling event directly.
> > 
> > Also reading from mmap would be disabled when the read format has ID or
> > LOST bit as it's not exposed via mmap.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/lib/perf/evsel.c              | 72 +++++++++++++++++++++++++++++
> >  tools/lib/perf/include/perf/event.h |  3 +-
> >  tools/lib/perf/include/perf/evsel.h |  4 +-
> >  3 files changed, 77 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > index 952f3520d5c2..fc23670231cb 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -305,6 +305,9 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
> >  	if (read_format & PERF_FORMAT_ID)
> >  		entry += sizeof(u64);
> >  
> > +	if (read_format & PERF_FORMAT_LOST)
> > +		entry += sizeof(u64);
> > +
> >  	if (read_format & PERF_FORMAT_GROUP) {
> >  		nr = evsel->nr_members;
> >  		size += sizeof(u64);
> > @@ -314,24 +317,93 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
> >  	return size;
> >  }
> >  
> > +/* This only reads values for the leader */
> > +static int perf_evsel__read_group(struct perf_evsel *evsel, int cpu_map_idx,
> > +				  int thread, struct perf_counts_values *count)
> > +{
> > +	size_t size = perf_evsel__read_size(evsel);
> > +	int *fd = FD(evsel, cpu_map_idx, thread);
> > +	u64 read_format = evsel->attr.read_format;
> > +	u64 *data;
> > +	int idx = 1;
> > +
> > +	if (fd == NULL || *fd < 0)
> > +		return -EINVAL;
> > +
> > +	data = calloc(1, size);
> > +	if (data == NULL)
> > +		return -ENOMEM;
> > +
> > +	if (readn(*fd, data, size) <= 0) {
> > +		free(data);
> > +		return -errno;
> > +	}
> 
> could you please put in here some comment that this is intentionaly
> reading only the leader or better yet rename the function? I was lost
> before I got to read the changelog ;-)
> 
> > +
> > +	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
> > +		count->ena = data[idx++];
> > +	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
> > +		count->run = data[idx++];
> > +
> > +	/* value is always available */
> > +	count->val = data[idx++];
> > +	if (read_format & PERF_FORMAT_ID)
> > +		count->id = data[idx++];
> > +	if (read_format & PERF_FORMAT_LOST)
> > +		count->lost = data[idx++];
> > +
> > +	free(data);
> > +	return 0;
> > +}
> > +
> > +/*
> > + * The perf read format is very flexible.  It needs to set the proper
> > + * values according to the read format.
> > + */
> > +static void perf_evsel__adjust_values(struct perf_evsel *evsel,
> > +				      struct perf_counts_values *count)
> > +{
> > +	u64 read_format = evsel->attr.read_format;
> > +
> > +	if (!(read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)) {
> > +		memmove(&count->values[2], &count->values[1], 24);
> > +		count->ena = 0;
> > +	}
> > +
> > +	if (!(read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)) {
> > +		memmove(&count->values[3], &count->values[2], 16);
> > +		count->run = 0;
> > +	}
> > +
> > +	if (!(read_format & PERF_FORMAT_ID)) {
> > +		memmove(&count->values[4], &count->values[3], 8);
> > +		count->id = 0;
> > +	}
> > +}
> 
> 
> could we do this the same way we read group counters.. like make read
> into local buffer and initialize perf_counts_values values based on
> format, something like:
> 
>         readn(fd, data ...
> 
>         if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
>                 count->ena = data[idx++];
>         if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
>                 count->run = data[idx++];
> 
>         /* value is always available */
>         count->val = data[idx++];
>         if (read_format & PERF_FORMAT_ID)
>                 count->id = data[idx++];
>         if (read_format & PERF_FORMAT_LOST)
>                 count->lost = data[idx++];

I see this now, so I'll wait for Namhyung to react to your comments,
while keeping it in my local tree just to have it build tested.

- Arnaldo
 
> 
> and perhaps we should cancel that perf_counts_values's union and keep
> only 'val/ena/run...' fields?
> 
> jirka

-- 

- Arnaldo
