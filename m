Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9271B4A51FD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiAaWEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiAaWEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:04:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71984C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:04:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E35C6158E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 22:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249B3C340ED;
        Mon, 31 Jan 2022 22:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643666671;
        bh=tvLgNQ6TBPQG7rUN144K4nZLEXhaScnW/q6CkLhzGl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vO8nSlkRxcIv32InjQfabIsqKLZeu4VXpRTi/JYHbssYg1U4dY8IUvVvdFcQhSwZY
         QMrxigU5wfNGnEPybVdcaCjRZ1WsZ0ZBoqO7v3uEbz9Z4/SzSlvvRzQlSKtIOH25/3
         YeK7LoVXP2GLfTGSssw0BWfkm64ccBxpPW+hwb7C8xuELKOIfs/MZ4ePMelxM4ewtF
         R6pp0jXALbIy0OUGmAg9OCYD6ZzC38ohrEY8dN5V5LCXyTjb2s7sJn3aHcCZ390CQG
         KAlrpKNf69Bm1sCjyVF4JmdSLSM3fMKXjD6VsYrp96IAifVIgGVHKT+g/HfSYQHXYn
         RkUjLKMrWPfIQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9ACD140466; Mon, 31 Jan 2022 19:04:29 -0300 (-03)
Date:   Mon, 31 Jan 2022 19:04:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v13 01/16] perf record: Introduce thread affinity and
 mmap masks
Message-ID: <Yfhc7eAwASCfeM+r@kernel.org>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <9042bf7daf988e17e17e6acbf5d29590bde869cd.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <YfhN7kTLECDwgPLh@kernel.org>
 <YfhcoBf1RPLfqUXO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfhcoBf1RPLfqUXO@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 31, 2022 at 07:03:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 31, 2022 at 06:00:31PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jan 17, 2022 at 09:34:21PM +0300, Alexey Bayduraev escreveu:
> > > Introduce affinity and mmap thread masks. Thread affinity mask
> > > defines CPUs that a thread is allowed to run on. Thread maps
> > > mask defines mmap data buffers the thread serves to stream
> > > profiling data from.
> > > 
> > > Acked-by: Andi Kleen <ak@linux.intel.com>
> > > Acked-by: Namhyung Kim <namhyung@gmail.com>
> > > Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> > > Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> > > Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> > 
> > Some simplifications I added here while reviewing this patchkit:
> > 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 41998f2140cd5119..53b88c8600624237 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -2213,35 +2213,33 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
> >  
> >  static int record__mmap_cpu_mask_alloc(struct mmap_cpu_mask *mask, int nr_bits)
> >  {
> > -	mask->nbits = nr_bits;
> >  	mask->bits = bitmap_zalloc(mask->nbits);
> >  	if (!mask->bits)
> >  		return -ENOMEM;
> >  
> > +	mask->nbits = nr_bits;
> >  	return 0;
> 
> 
> Interesting, building it at this point in the patchkit didn't uncover
> the bug I introduced, only later when this gets used I got the compiler
> error and applied this on top:
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 53b88c8600624237..6b0e506df20c002a 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2213,7 +2213,7 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
>  
>  static int record__mmap_cpu_mask_alloc(struct mmap_cpu_mask *mask, int nr_bits)
>  {
> -	mask->bits = bitmap_zalloc(mask->nbits);
> +	mask->bits = bitmap_zalloc(nbits);

Make that nr_bits, sigh :-\

>  	if (!mask->bits)
>  		return -ENOMEM;
>  
> 
> >  }
> >  
> >  static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
> >  {
> >  	bitmap_free(mask->bits);
> > +	mask->bits = NULL;
> >  	mask->nbits = 0;
> >  }
> >  
> >  static int record__thread_mask_alloc(struct thread_mask *mask, int nr_bits)
> >  {
> > -	int ret;
> > +	int ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);
> >  
> > -	ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);
> >  	if (ret) {
> >  		mask->affinity.bits = NULL;
> >  		return ret;
> >  	}
> >  
> >  	ret = record__mmap_cpu_mask_alloc(&mask->affinity, nr_bits);
> > -	if (ret) {
> > +	if (ret)
> >  		record__mmap_cpu_mask_free(&mask->maps);
> > -		mask->maps.bits = NULL;
> > -	}
> >  
> >  	return ret;
> >  }
> > @@ -2733,18 +2731,14 @@ struct option *record_options = __record_options;
> >  
> >  static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
> >  {
> > -	int c;
> > -
> > -	for (c = 0; c < cpus->nr; c++)
> > +	for (int c = 0; c < cpus->nr; c++)
> >  		set_bit(cpus->map[c].cpu, mask->bits);
> >  }
> >  
> >  static void record__free_thread_masks(struct record *rec, int nr_threads)
> >  {
> > -	int t;
> > -
> >  	if (rec->thread_masks)
> > -		for (t = 0; t < nr_threads; t++)
> > +		for (int t = 0; t < nr_threads; t++)
> >  			record__thread_mask_free(&rec->thread_masks[t]);
> >  
> >  	zfree(&rec->thread_masks);
> > @@ -2752,7 +2746,7 @@ static void record__free_thread_masks(struct record *rec, int nr_threads)
> >  
> >  static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
> >  {
> > -	int t, ret;
> > +	int ret;
> >  
> >  	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
> >  	if (!rec->thread_masks) {
> > @@ -2760,7 +2754,7 @@ static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr
> >  		return -ENOMEM;
> >  	}
> >  
> > -	for (t = 0; t < nr_threads; t++) {
> > +	for (int t = 0; t < nr_threads; t++) {
> >  		ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
> >  		if (ret) {
> >  			pr_err("Failed to allocate thread masks[%d]\n", t);
> > @@ -2778,9 +2772,7 @@ static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr
> >  
> >  static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
> >  {
> > -	int ret;
> > -
> > -	ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu().cpu);
> > +	int ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu().cpu);
> >  	if (ret)
> >  		return ret;
> >  
> > 
> > 
> > > ---
> > >  tools/perf/builtin-record.c | 123 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 123 insertions(+)
> > > 
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > index bb716c953d02..41998f2140cd 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -87,6 +87,11 @@ struct switch_output {
> > >  	int		 cur_file;
> > >  };
> > >  
> > > +struct thread_mask {
> > > +	struct mmap_cpu_mask	maps;
> > > +	struct mmap_cpu_mask	affinity;
> > > +};
> > > +
> > >  struct record {
> > >  	struct perf_tool	tool;
> > >  	struct record_opts	opts;
> > > @@ -112,6 +117,8 @@ struct record {
> > >  	struct mmap_cpu_mask	affinity_mask;
> > >  	unsigned long		output_max_size;	/* = 0: unlimited */
> > >  	struct perf_debuginfod	debuginfod;
> > > +	int			nr_threads;
> > > +	struct thread_mask	*thread_masks;
> > >  };
> > >  
> > >  static volatile int done;
> > > @@ -2204,6 +2211,47 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
> > >  	return 0;
> > >  }
> > >  
> > > +static int record__mmap_cpu_mask_alloc(struct mmap_cpu_mask *mask, int nr_bits)
> > > +{
> > > +	mask->nbits = nr_bits;
> > > +	mask->bits = bitmap_zalloc(mask->nbits);
> > > +	if (!mask->bits)
> > > +		return -ENOMEM;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
> > > +{
> > > +	bitmap_free(mask->bits);
> > > +	mask->nbits = 0;
> > > +}
> > > +
> > > +static int record__thread_mask_alloc(struct thread_mask *mask, int nr_bits)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);
> > > +	if (ret) {
> > > +		mask->affinity.bits = NULL;
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = record__mmap_cpu_mask_alloc(&mask->affinity, nr_bits);
> > > +	if (ret) {
> > > +		record__mmap_cpu_mask_free(&mask->maps);
> > > +		mask->maps.bits = NULL;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void record__thread_mask_free(struct thread_mask *mask)
> > > +{
> > > +	record__mmap_cpu_mask_free(&mask->maps);
> > > +	record__mmap_cpu_mask_free(&mask->affinity);
> > > +}
> > > +
> > >  static int parse_output_max_size(const struct option *opt,
> > >  				 const char *str, int unset)
> > >  {
> > > @@ -2683,6 +2731,73 @@ static struct option __record_options[] = {
> > >  
> > >  struct option *record_options = __record_options;
> > >  
> > > +static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
> > > +{
> > > +	int c;
> > > +
> > > +	for (c = 0; c < cpus->nr; c++)
> > > +		set_bit(cpus->map[c].cpu, mask->bits);
> > > +}
> > > +
> > > +static void record__free_thread_masks(struct record *rec, int nr_threads)
> > > +{
> > > +	int t;
> > > +
> > > +	if (rec->thread_masks)
> > > +		for (t = 0; t < nr_threads; t++)
> > > +			record__thread_mask_free(&rec->thread_masks[t]);
> > > +
> > > +	zfree(&rec->thread_masks);
> > > +}
> > > +
> > > +static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
> > > +{
> > > +	int t, ret;
> > > +
> > > +	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
> > > +	if (!rec->thread_masks) {
> > > +		pr_err("Failed to allocate thread masks\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	for (t = 0; t < nr_threads; t++) {
> > > +		ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
> > > +		if (ret) {
> > > +			pr_err("Failed to allocate thread masks[%d]\n", t);
> > > +			goto out_free;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +out_free:
> > > +	record__free_thread_masks(rec, nr_threads);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu().cpu);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
> > > +
> > > +	rec->nr_threads = 1;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int record__init_thread_masks(struct record *rec)
> > > +{
> > > +	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
> > > +
> > > +	return record__init_thread_default_masks(rec, cpus);
> > > +}
> > > +
> > >  int cmd_record(int argc, const char **argv)
> > >  {
> > >  	int err;
> > > @@ -2948,6 +3063,12 @@ int cmd_record(int argc, const char **argv)
> > >  		goto out;
> > >  	}
> > >  
> > > +	err = record__init_thread_masks(rec);
> > > +	if (err) {
> > > +		pr_err("Failed to initialize parallel data streaming masks\n");
> > > +		goto out;
> > > +	}
> > > +
> > >  	if (rec->opts.nr_cblocks > nr_cblocks_max)
> > >  		rec->opts.nr_cblocks = nr_cblocks_max;
> > >  	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
> > > @@ -2966,6 +3087,8 @@ int cmd_record(int argc, const char **argv)
> > >  	symbol__exit();
> > >  	auxtrace_record__free(rec->itr);
> > >  out_opts:
> > > +	record__free_thread_masks(rec, rec->nr_threads);
> > > +	rec->nr_threads = 0;
> > >  	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
> > >  	return err;
> > >  }
> > > -- 
> > > 2.19.0
> > 
> > -- 
> > 
> > - Arnaldo
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
