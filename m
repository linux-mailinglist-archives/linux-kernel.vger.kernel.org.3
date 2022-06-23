Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D303A557E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiFWOqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiFWOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:46:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F44578F;
        Thu, 23 Jun 2022 07:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D55A61E61;
        Thu, 23 Jun 2022 14:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E3CC3411B;
        Thu, 23 Jun 2022 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655995600;
        bh=gLtSEKNeH4ode8uSzhAq8jIlify+j9XHrfLNKbaIkxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SX/K98zneuEP7DgTVrnJMtOMTg9KJyHkEhywfbwL/OOS1m0gg7wbFGDQhyYm8VS7C
         4TFrcKLUQgc7xR/OBPZu0lJiZIKewhgDbatEv8djw9rwdHE9TCTFFbj1jiaQrhZN9i
         HwUHBZVq9ruZgxDjN52TAov+ikryhfNktgYRsUb1DdG0m0+psdvj4f+NOzyUx8jpVv
         Q7PDSs1y7T1MvfHFXhWDsunSsf687BwWswmuSPZ+Z0TKrQ6MCaKyyFgSjGcw/ejH9j
         j/meT+JZJ1ecgo5tFgTWRUFYUe7D0v6GSwtkh8jx+27lciVFsB+7o2qp5IEuhks9lO
         m9Rk9IXbZKcVw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DE1C84096F; Thu, 23 Jun 2022 11:46:36 -0300 (-03)
Date:   Thu, 23 Jun 2022 11:46:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Raul Silvera <rsilvera@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Colin Ian King <colin.king@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: Adjust perf-inject output data offset for
 backward compatibility
Message-ID: <YrR8zDls7y//T7zI@kernel.org>
References: <20220621152725.2668041-1-rsilvera@google.com>
 <b7de807d-5ec3-3d8d-59ba-4058e1193a96@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7de807d-5ec3-3d8d-59ba-4058e1193a96@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 22, 2022 at 11:36:58AM +0300, Adrian Hunter escreveu:
> On 21/06/22 18:27, Raul Silvera wrote:
> > When perf inject creates a new file, it reuses the data offset from the
> > input file. If there has been a change on the size of the header, as
> > happened in v5.12 -> v5.13, the new offsets will be wrong, resulting in
> > a corrupted output file.
> > 
> > This change adds the function perf_session__data_offset to compute the
> > data offset based on the current header size, and uses that instead of
> > the offset from the original input file.
> > 
> > Signed-off-by: Raul Silvera <rsilvera@google.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

 
> > ---
> > Changes since v1:
> >  - Use the adjusted header->data_offset in do_write_header instead of
> >    recomputing it.
> > ---
> >  tools/perf/builtin-inject.c |  2 +-
> >  tools/perf/util/header.c    | 14 ++++++++++++++
> >  tools/perf/util/header.h    |  2 ++
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index a75bf11585b5..1dfdcef36607 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -916,7 +916,7 @@ static int __cmd_inject(struct perf_inject *inject)
> >  		inject->tool.tracing_data = perf_event__repipe_tracing_data;
> >  	}
> >  
> > -	output_data_offset = session->header.data_offset;
> > +	output_data_offset = perf_session__data_offset(session->evlist);
> >  
> >  	if (inject->build_id_all) {
> >  		inject->tool.mmap	  = perf_event__repipe_buildid_mmap;
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 53332da100e8..6ad629db63b7 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -3686,6 +3686,20 @@ int perf_session__write_header(struct perf_session *session,
> >  	return perf_session__do_write_header(session, evlist, fd, at_exit, NULL);
> >  }
> >  
> > +size_t perf_session__data_offset(const struct evlist *evlist)
> > +{
> > +	struct evsel *evsel;
> > +	size_t data_offset;
> > +
> > +	data_offset = sizeof(struct perf_file_header);
> > +	evlist__for_each_entry(evlist, evsel) {
> > +		data_offset += evsel->core.ids * sizeof(u64);
> > +	}
> > +	data_offset += evlist->core.nr_entries * sizeof(struct perf_file_attr);
> > +
> > +	return data_offset;
> > +}
> > +
> >  int perf_session__inject_header(struct perf_session *session,
> >  				struct evlist *evlist,
> >  				int fd,
> > diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> > index 08563c1f1bff..56916dabce7b 100644
> > --- a/tools/perf/util/header.h
> > +++ b/tools/perf/util/header.h
> > @@ -136,6 +136,8 @@ int perf_session__inject_header(struct perf_session *session,
> >  				int fd,
> >  				struct feat_copier *fc);
> >  
> > +size_t perf_session__data_offset(const struct evlist *evlist);
> > +
> >  void perf_header__set_feat(struct perf_header *header, int feat);
> >  void perf_header__clear_feat(struct perf_header *header, int feat);
> >  bool perf_header__has_feat(const struct perf_header *header, int feat);

-- 

- Arnaldo
