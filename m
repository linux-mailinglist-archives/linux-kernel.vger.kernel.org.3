Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E722C4A51EE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiAaV5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiAaV4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:56:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA88C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:56:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C4F8ECE16B0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5412C340E8;
        Mon, 31 Jan 2022 21:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643666197;
        bh=fNjP8t8IBPKAyOf9ib85b9Df/Qt+zaNdYUrlhsIAJhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUVHoSSHYRBm5Zgb54B9KrqXdnGD1sZY/re2bTMa2GWlVtLGbxrudZpHkx014b4vG
         Gj8v7qj6BDdtYZOkop2QMBrjm8++vKhhgyvM7dxKqjfq31TC6TH/zx1LFmmrUUR7bJ
         JeD+Nyncgii5Mu8n1mr62Hc4UXHitGajsFkkOWQN/Nk01guhV0YnZGyh/woczQBc8R
         7BiclQxnt+87c/cVOMC1Ypp3HeAR4M8CpQhDwk11Oz5/KkEd2GgTbWYIhk/oz1f3AI
         BZ0bgFswBLs7K9nwfBkSAxOxqmwgy/8NGAqAp8zFiN8bsQUJRNXd5v8BKo13NNlgDM
         PphogOu5cSu+w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0298140466; Mon, 31 Jan 2022 18:56:33 -0300 (-03)
Date:   Mon, 31 Jan 2022 18:56:33 -0300
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
Subject: Re: [PATCH v13 10/16] perf record: Introduce compressor at mmap
 buffer object
Message-ID: <YfhbEd/QYIZzsgw2@kernel.org>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <80edc286cf6543139a7d5a91217605123aa0b50d.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80edc286cf6543139a7d5a91217605123aa0b50d.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 17, 2022 at 09:34:30PM +0300, Alexey Bayduraev escreveu:
> Introduce compressor object into mmap object so it could be used to
> pack the data stream from the corresponding kernel data buffer.
> Initialize and make use of the introduced per mmap compressor.
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 18 +++++++++++-------
>  tools/perf/util/mmap.c      | 10 ++++++++++
>  tools/perf/util/mmap.h      |  2 ++
>  3 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 50981bbc98bb..7d0338b5a0e3 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -246,8 +246,8 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  
>  static int record__aio_enabled(struct record *rec);
>  static int record__comp_enabled(struct record *rec);
> -static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
> -			    void *src, size_t src_size);
> +static size_t zstd_compress(struct perf_session *session, struct mmap *map,
> +			    void *dst, size_t dst_size, void *src, size_t src_size);
>  
>  #ifdef HAVE_AIO_SUPPORT
>  static int record__aio_write(struct aiocb *cblock, int trace_fd,
> @@ -381,7 +381,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
>  	 */
>  
>  	if (record__comp_enabled(aio->rec)) {
> -		size = zstd_compress(aio->rec->session, aio->data + aio->size,
> +		size = zstd_compress(aio->rec->session, NULL, aio->data + aio->size,
>  				     mmap__mmap_len(map) - aio->size,
>  				     buf, size);
>  	} else {
> @@ -608,7 +608,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  	struct record *rec = to;
>  
>  	if (record__comp_enabled(rec)) {
> -		size = zstd_compress(rec->session, map->data, mmap__mmap_len(map), bf, size);
> +		size = zstd_compress(rec->session, map, map->data, mmap__mmap_len(map), bf, size);
>  		bf   = map->data;
>  	}
>  
> @@ -1394,13 +1394,17 @@ static size_t process_comp_header(void *record, size_t increment)
>  	return size;
>  }
>  
> -static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
> -			    void *src, size_t src_size)
> +static size_t zstd_compress(struct perf_session *session, struct mmap *map,
> +			    void *dst, size_t dst_size, void *src, size_t src_size)
>  {
>  	size_t compressed;
>  	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed) - 1;
> +	struct zstd_data *zstd_data = &session->zstd_data;
>  
> -	compressed = zstd_compress_stream_to_records(&session->zstd_data, dst, dst_size, src, src_size,
> +	if (map && map->file)
> +		zstd_data = &map->zstd_data;
> +
> +	compressed = zstd_compress_stream_to_records(zstd_data, dst, dst_size, src, src_size,
>  						     max_record_size, process_comp_header);
>  
>  	session->bytes_transferred += src_size;
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 12261ed8c15b..8bf97d9b8424 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -230,6 +230,10 @@ void mmap__munmap(struct mmap *map)
>  {
>  	bitmap_free(map->affinity_mask.bits);
>  
> +#ifndef PYTHON_PERF
> +	zstd_fini(&map->zstd_data);
> +#endif
> +

Exposing this build detail in the main source code seems ugly, casual
readers will scratch their heads trying to figure this out, so either
we should have this behind some macro that hides these deps on a header
file or add a comment stating why this is needed.
	

>  	perf_mmap__aio_munmap(map);
>  	if (map->data != NULL) {
>  		munmap(map->data, mmap__mmap_len(map));
> @@ -292,6 +296,12 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu
>  	map->core.flush = mp->flush;
>  
>  	map->comp_level = mp->comp_level;
> +#ifndef PYTHON_PERF
> +	if (zstd_init(&map->zstd_data, map->comp_level)) {
> +		pr_debug2("failed to init mmap commpressor, error %d\n", errno);
> +		return -1;
> +	}
> +#endif
>  
>  	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
>  		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index 62f38d7977bb..cd8b0777473b 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -15,6 +15,7 @@
>  #endif
>  #include "auxtrace.h"
>  #include "event.h"
> +#include "util/compress.h"
>  
>  struct aiocb;
>  
> @@ -46,6 +47,7 @@ struct mmap {
>  	void		*data;
>  	int		comp_level;
>  	struct perf_data_file *file;
> +	struct zstd_data      zstd_data;
>  };
>  
>  struct mmap_params {
> -- 
> 2.19.0

-- 

- Arnaldo
