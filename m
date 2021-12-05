Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F63E468BB2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbhLEPSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:18:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235545AbhLEPSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638717285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=joPJgIm/F8/yiPc8EAqqySP9NdZaVX+Y4x3TttFkyTc=;
        b=goDQYCJPE614sXCRuwMxRkfgLabjBHmAUJkNQZ1iVb+mpBvcGrOwlh64mlvT41gO9e1ePN
        1C5hd1hSaKzbx+xbaiqRZlXOovnQKtjE/nmJku2ZqKjjiPUKjEhdeG65dBhmxQe3rArglF
        zLvQv25tFDJ12rRNZ/d7PXnQgaYTOW4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-506-KVJBUbTrPPyKEUMzh-3Kiw-1; Sun, 05 Dec 2021 10:14:44 -0500
X-MC-Unique: KVJBUbTrPPyKEUMzh-3Kiw-1
Received: by mail-wm1-f72.google.com with SMTP id a85-20020a1c7f58000000b0033ddc0eacc8so6589170wmd.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 07:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=joPJgIm/F8/yiPc8EAqqySP9NdZaVX+Y4x3TttFkyTc=;
        b=4kLfoUHjNVMYq2EfRLjEclP7vuQZwANxRZ5fugFgMDl3u4LWBWbflKDgrgS3gbwf4j
         t1qaez1dnkT13VLV5a6JwMI1DKP0XVLH7bU2S0VEpXUQKqBlDWn05ltDMah1v39idPlQ
         Wwp014GEy0utR3ocxvZBoktZf7w8EmfhtTC8qYsra3p0AnHVPGFS3pFA7U1zeUe6XSgt
         kLPU0T5NwY3ci66asd8k6Mo4DAmpQMXAHlGXJL7eIXGkS2ML35/e5SA182NpK9I3XrEQ
         vCZNb/LcSOFb/ZVeJdELqmrbTg9AQVVihjbYnlv8JlNdZaAQWJXo2IB9l2uSEAyNrSbW
         TItw==
X-Gm-Message-State: AOAM531tB/ZZtJaDR20BkwBBJmwhhMz2A4yHVIAnPwntV2Reg4o7Y10h
        jolgI6fOciwuMgfW5hfkPCybDBRe7ZmsHOMtlmwvYJFu4BAyqWs96GuEFJOUazmzhC7SNTdq0nJ
        uGfWfYkLtRA71S1VTkD9Lkx5f
X-Received: by 2002:adf:9bc4:: with SMTP id e4mr36774797wrc.476.1638717283065;
        Sun, 05 Dec 2021 07:14:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZhESgI3lblRRwa2+T+65NwbWeswH3xgModxpoYMGObm7MRAb4ncz9wY5IqP1Pqsgeio/j6Q==
X-Received: by 2002:adf:9bc4:: with SMTP id e4mr36774765wrc.476.1638717282904;
        Sun, 05 Dec 2021 07:14:42 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id j40sm8614238wms.16.2021.12.05.07.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:14:42 -0800 (PST)
Date:   Sun, 5 Dec 2021 16:14:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v12 08/16] perf record: Introduce data file at mmap
 buffer object
Message-ID: <YazXYN9r68M/RH9T@krava>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
 <06c298ce2f2f05964fb507524e1eb7080d57da4b.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c298ce2f2f05964fb507524e1eb7080d57da4b.1637675515.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 05:08:04PM +0300, Alexey Bayduraev wrote:

SNIP

> +static int record__threads_enabled(struct record *rec)
> +{
> +	return rec->opts.threads_spec;
> +}
> +
>  static bool switch_output_signal(struct record *rec)
>  {
>  	return rec->switch_output.signal &&
> @@ -197,12 +202,16 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  {
>  	struct perf_data_file *file = &rec->session->data->file;
>  
> +	if (map && map->file)
> +		file = map->file;
> +
>  	if (perf_data_file__write(file, bf, size) < 0) {
>  		pr_err("failed to write perf data, error: %m\n");
>  		return -1;
>  	}
>  
> -	rec->bytes_written += size;
> +	if (!(map && map->file))
> +		rec->bytes_written += size;

why is this incremented under that condition?

>  
>  	if (record__output_max_size_exceeded(rec) && !done) {
>  		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
> @@ -1102,7 +1111,7 @@ static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
>  static int record__mmap_evlist(struct record *rec,
>  			       struct evlist *evlist)
>  {

SNIP

> @@ -1574,6 +1601,7 @@ static void record__init_features(struct record *rec)
>  static void
>  record__finish_output(struct record *rec)
>  {
> +	int i;
>  	struct perf_data *data = &rec->data;
>  	int fd = perf_data__fd(data);
>  
> @@ -1582,8 +1610,14 @@ record__finish_output(struct record *rec)
>  
>  	rec->session->header.data_size += rec->bytes_written;
>  	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
> +	if (record__threads_enabled(rec)) {
> +		for (i = 0; i < data->dir.nr; i++)
> +			data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
> +	}
>  
>  	if (!rec->no_buildid) {
> +		/* this will be recalculated during process_buildids() */
> +		rec->samples = 0;
>  		process_buildids(rec);
>  
>  		if (rec->buildid_all)
> @@ -2490,8 +2524,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		status = err;
>  
>  	record__synthesize(rec, true);
> -	/* this will be recalculated during process_buildids() */
> -	rec->samples = 0;

hm, why is this removed?

jirka

>  
>  	if (!err) {
>  		if (!rec->timestamp_filename) {
> @@ -3312,7 +3344,7 @@ int cmd_record(int argc, const char **argv)
>  		goto out_opts;
>  	}
>  
> -	if (rec->opts.kcore)
> +	if (rec->opts.kcore || record__threads_enabled(rec))
>  		rec->data.is_dir = true;
>  
>  	if (rec->opts.comp_level != 0) {
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index 8e259b9610f8..a3370a8bf307 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -44,6 +44,7 @@ struct mmap {
>  	struct mmap_cpu_mask	affinity_mask;
>  	void		*data;
>  	int		comp_level;
> +	struct perf_data_file *file;
>  };
>  
>  struct mmap_params {
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index ef6c2715fdd9..ad08c092f3dd 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -78,6 +78,7 @@ struct record_opts {
>  	int	      ctl_fd_ack;
>  	bool	      ctl_fd_close;
>  	int	      synth;
> +	int	      threads_spec;
>  };
>  
>  extern const char * const *record_usage;
> -- 
> 2.19.0
> 

