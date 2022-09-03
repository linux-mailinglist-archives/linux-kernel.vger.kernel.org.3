Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F65ABF3B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 16:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiICOIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 10:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiICOIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 10:08:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F625C9EE;
        Sat,  3 Sep 2022 07:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5EACB801B8;
        Sat,  3 Sep 2022 14:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E00C433D6;
        Sat,  3 Sep 2022 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662214111;
        bh=RcY6pfyqSpiTwcrwiHlvE793ReDC3aOUyFtm10pHOLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+t3kgWGYC5mZYYxv4X5fJKA/DGF81AZcbeh4Rav+Rzt7W4jLZOxBNEO/x8yrT76V
         7e8HOs3SRbuVCBGVmGIyCNh47envrimRSNAUhYFRK3q9lTxOzJHSHRpBdWHXO1oC8t
         445L7OIQJZZY5FiT2ep2Y3odjtzO+RW6mXRIslJy5UZAzi1o4t3q21EdC1e8nZJwbP
         kX+AUzjeAAa5jyu9Kwl0DPA56eq0Ud/Ssk2W7DZlmfNnQb7lKSEgeGfy7pHYqJrtVI
         INiJJTBJRUkeHRqkJKKBSB796GOp8G+38+Wa9/EH1Yugv0eGsjrd+jFazOqVw3Rv4m
         QndV+Ey2Erv8g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AE6AC404A1; Sat,  3 Sep 2022 11:08:27 -0300 (-03)
Date:   Sat, 3 Sep 2022 11:08:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     =?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: perf top -p broken for multithreaded processes since 5.19
Message-ID: <YxNf2/H5Iyz5M8sn@kernel.org>
References: <10137382.nUPlyArG6x@mintaka.ncbr.muni.cz>
 <2fd9b620-e9a8-9cd9-1b4a-6b13d829b2ae@intel.com>
 <YxJW19MwaMOb8D30@kernel.org>
 <ca905aa0-9d7b-d6d8-c789-2bd22057619b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca905aa0-9d7b-d6d8-c789-2bd22057619b@intel.com>
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

Em Sat, Sep 03, 2022 at 10:14:25AM +0300, Adrian Hunter escreveu:
> On 2/09/22 22:17, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Sep 02, 2022 at 05:50:22PM +0300, Adrian Hunter escreveu:
> >> On 2/09/22 17:46, Tomáš Trnka wrote:
> >>> Hello,
> >>>
> >>> A bug in perf v5.19 and newer completely breaks monitoring multithreaded
> >>> processes using "perf top -p". The tool fails to start with "Failed to mmap
> >>> with 22 (Invalid argument)". It still seems to work fine on single-threaded
> >>> processes. "perf record" is also unaffected.
> >>
> >> It has been reported here:
> >>
> >> 	https://bugzilla.kernel.org/show_bug.cgi?id=216441
> > 
> > If I do:
> > 
> > ⬢[acme@toolbox perf-urgent]$ git log -2
> > commit dfeb0bc60782471c293938e71b1a1117cfac2cb3 (HEAD -> perf/urgent)
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Fri Sep 2 16:15:39 2022 -0300
> > 
> >     Revert "libperf evlist: Check nr_mmaps is correct"
> > 
> >     This reverts commit 4ce47d842d4c16c07b135b8a7975b8f0672bcc0e.
> > 
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > commit 78cd283f6b8ab701cb35eafd5af8140560a88f16
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Fri Sep 2 16:13:41 2022 -0300
> > 
> >     Revert "libperf evlist: Allow mixing per-thread and per-cpu mmaps"
> > 
> >     This reverts commit ae4f8ae16a07896403c90305d4b9be27f657c1fc.
> > 
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ⬢[acme@toolbox perf-urgent]$
> > 
> > It works again, Tomáš can you please try doing this to see if this works
> > for you?
> > 
> 
> This is the fix I have so far.  I would like to test it some more though.

Ok, so I'll leave it for the next pull req, possibly after Linux
Plumbers.

What do you think about reverting those two patches for v6.0 and then
add this for v6.1?

- Arnaldo
 
> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Sat, 3 Sep 2022 10:05:08 +0300
> Subject: [PATCH] libperf evlist: Fix per-thread mmaps for multi-threaded
>  targets
> 
> Offending commit did not consider the different set-output rules for
> per-thread mmaps i.e. in the per-thread case set-output is used for
> mmaps of the same thread not the same cpu.
> 
> This was not immediately noticed because it only happens with
> multi-threaded targets and we do not have a test for that yet.
> 
> Fixes: ae4f8ae16a07 ("libperf evlist: Allow mixing per-thread and per-cpu mmaps")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/evlist.c | 49 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index e6c98a6e3908e..24280c887520c 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -486,6 +486,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  			if (ops->idx)
>  				ops->idx(evlist, evsel, mp, idx);
>  
> +			pr_debug("idx %d: mmapping fd %d\n", idx, *output);
>  			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
>  				return -1;
>  
> @@ -494,6 +495,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  			if (!idx)
>  				perf_evlist__set_mmap_first(evlist, map, overwrite);
>  		} else {
> +			pr_debug("idx %d: set output fd %d -> %d\n", idx, fd, *output);
>  			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
>  				return -1;
>  
> @@ -519,6 +521,47 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  	return 0;
>  }
>  
> +static int
> +mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
> +		struct perf_mmap_param *mp)
> +{
> +	int nr_threads = perf_thread_map__nr(evlist->threads);
> +	int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
> +	int cpu, thread, idx = 0;
> +	int nr_mmaps = 0;
> +
> +	pr_debug("%s: nr cpu values (may include -1) %d nr threads %d\n", __func__, nr_cpus, nr_threads);
> +
> +	/* per-thread mmaps */
> +	for (thread = 0; thread < nr_threads; thread++, idx++) {
> +		int output = -1;
> +		int output_overwrite = -1;
> +
> +		if (mmap_per_evsel(evlist, ops, idx, mp, 0, thread, &output,
> +				   &output_overwrite, &nr_mmaps))
> +			goto out_unmap;
> +	}
> +
> +	/* system-wide mmaps i.e. per-cpu */
> +	for (cpu = 1; cpu < nr_cpus; cpu++, idx ++) {
> +		int output = -1;
> +		int output_overwrite = -1;
> +
> +		if (mmap_per_evsel(evlist, ops, idx, mp, cpu, 0, &output,
> +				   &output_overwrite, &nr_mmaps))
> +			goto out_unmap;
> +	}
> +
> +	if (nr_mmaps != evlist->nr_mmaps)
> +		pr_err("Miscounted nr_mmaps %d vs %d\n", nr_mmaps, evlist->nr_mmaps);
> +
> +	return 0;
> +
> +out_unmap:
> +	perf_evlist__munmap(evlist);
> +	return -1;
> +}
> +
>  static int
>  mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  	     struct perf_mmap_param *mp)
> @@ -528,6 +571,8 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  	int nr_mmaps = 0;
>  	int cpu, thread;
>  
> +	pr_debug("%s: nr cpu values %d nr threads %d\n", __func__, nr_cpus, nr_threads);
> +
>  	for (cpu = 0; cpu < nr_cpus; cpu++) {
>  		int output = -1;
>  		int output_overwrite = -1;
> @@ -569,6 +614,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>  			  struct perf_evlist_mmap_ops *ops,
>  			  struct perf_mmap_param *mp)
>  {
> +	const struct perf_cpu_map *cpus = evlist->all_cpus;
>  	struct perf_evsel *evsel;
>  
>  	if (!ops || !ops->get || !ops->mmap)
> @@ -588,6 +634,9 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>  	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
>  		return -ENOMEM;
>  
> +	if (perf_cpu_map__empty(cpus))
> +		return mmap_per_thread(evlist, ops, mp);
> +
>  	return mmap_per_cpu(evlist, ops, mp);
>  }
>  
> -- 
> 2.34.1
> 
> 

-- 

- Arnaldo
