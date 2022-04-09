Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5086B4FA945
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbiDIPcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiDIPc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:32:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC531871E;
        Sat,  9 Apr 2022 08:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9EB5B80838;
        Sat,  9 Apr 2022 15:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBC6C385A0;
        Sat,  9 Apr 2022 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649518216;
        bh=JAqlXVdZJztkSgd8T3D4490wXB3jyzqvmtcAl+l1zYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwdLeAJ9F0hvIej0ugMw1iqgbnUTF86DwLsO+uQjGaG/soq5+3N1dxYP48zBXVltV
         vDcYKwxHsOlQ15EUCyhgEOwWgCOotBzrC9UhEv79VeNVKO+oPsIsF13u9V+fUKwzAl
         VpsQR+lqk0eF1XC/AMpThkkCkyXRyUlwb652Bs/5x9RA0tO7fMR5GeVQufyWRJ5kLJ
         qvlMeex5CHfbv4Q/uxIGwTqAWCdgXz+rfgb5YFteUBP54tkE5eVc+basJLZa2IMIZO
         MyRKM/ni37NBp98JOizHlyZQTPzoJvYyYL6f1/MUyxd8BWVRFozguCwk6O+Y5/NGr3
         7h9sojUgje/9g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DB77740407; Sat,  9 Apr 2022 12:30:13 -0300 (-03)
Date:   Sat, 9 Apr 2022 12:30:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Denis Nikitin <denik@chromium.org>,
        linux-perf-users@vger.kernel.org, jolsa@kernel.org,
        alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        james.clark@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf session: Remap buf if there is no space for event
Message-ID: <YlGmhS5O4VZEn4wV@kernel.org>
References: <20220330031130.2152327-1-denik@chromium.org>
 <YkWUK+1padnj2JB4@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkWUK+1padnj2JB4@krava>
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

Em Thu, Mar 31, 2022 at 01:44:43PM +0200, Jiri Olsa escreveu:
> On Tue, Mar 29, 2022 at 08:11:30PM -0700, Denis Nikitin wrote:
> > If a perf event doesn't fit into remaining buffer space return NULL to
> > remap buf and fetch the event again.
> > Keep the logic to error out on inadequate input from fuzzing.
> > 
> > This fixes perf failing on ChromeOS (with 32b userspace):
> > 
> >   $ perf report -v -i perf.data
> >   ...
> >   prefetch_event: head=0x1fffff8 event->header_size=0x30, mmap_size=0x2000000: fuzzed or compressed perf.data?
> >   Error:
> >   failed to process sample
> > 
> > Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
> > Signed-off-by: Denis Nikitin <denik@chromium.org>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/session.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 3b8dfe603e50..45a30040ec8d 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -2095,6 +2095,7 @@ prefetch_event(char *buf, u64 head, size_t mmap_size,
> >  	       bool needs_swap, union perf_event *error)
> >  {
> >  	union perf_event *event;
> > +	u16 event_size;
> >  
> >  	/*
> >  	 * Ensure we have enough space remaining to read
> > @@ -2107,15 +2108,23 @@ prefetch_event(char *buf, u64 head, size_t mmap_size,
> >  	if (needs_swap)
> >  		perf_event_header__bswap(&event->header);
> >  
> > -	if (head + event->header.size <= mmap_size)
> > +	event_size = event->header.size;
> > +	if (head + event_size <= mmap_size)
> >  		return event;
> >  
> >  	/* We're not fetching the event so swap back again */
> >  	if (needs_swap)
> >  		perf_event_header__bswap(&event->header);
> >  
> > -	pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx:"
> > -		 " fuzzed or compressed perf.data?\n",__func__, head, event->header.size, mmap_size);
> > +	/* Check if the event fits into the next mmapped buf. */
> > +	if (event_size <= mmap_size - head % page_size) {
> > +		/* Remap buf and fetch again. */
> > +		return NULL;
> > +	}
> > +
> > +	/* Invalid input. Event size should never exceed mmap_size. */
> > +	pr_debug("%s: head=%#" PRIx64 " event->header.size=%#x, mmap_size=%#zx:"
> > +		 " fuzzed or compressed perf.data?\n", __func__, head, event_size, mmap_size);
> >  
> >  	return error;
> >  }
> > -- 
> > 2.35.1.1021.g381101b075-goog
> > 

-- 

- Arnaldo
