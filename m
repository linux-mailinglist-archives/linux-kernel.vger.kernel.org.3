Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA07249838B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243205AbiAXPaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:30:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57190 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbiAXPaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:30:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 397C16148F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42797C340E5;
        Mon, 24 Jan 2022 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643038221;
        bh=imIbdS9bZRqwq9tKxxFNiH/5EeT1Jb7ncT1Gvs01f+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsyMrwPYNdLkHkGLRNMnOV+H1I/ga9IHmIv25OSKDYYd+qhlq7Mq2gZ4hrbvwMFJD
         KNgJ6xY1Rkzs7UEym/C0f3SroHl+9xrFPt761pxJDj4REId3D+oDe5/Nt/W94tKjDA
         26zssgpMb+NfkB0GcF1ZvCvGmC7nAqey2gQ7DEG/hH8+XkVptzu2kPzb0OgKYzxxgN
         MRUz8OAlRTsGs23h1NZKj73oikpdWuPMfp9uogOM3JDolVeOHKndSM/iUQ9zbbiMFO
         egnjS7rFG0VTEdKwD3/lPSaFIg8ei5xo3stPylunFVTEOaf0qZpdMFTTUi/Tqi6oqK
         7v6XYeXgZFw1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2637040C99; Mon, 24 Jan 2022 12:28:18 -0300 (-03)
Date:   Mon, 24 Jan 2022 12:28:18 -0300
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
Subject: Re: [PATCH v13 11/16] perf record: Introduce data transferred and
 compressed stats
Message-ID: <Ye7FkknVAUJjM+oV@kernel.org>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <b5d598034c507dfb7544d2125500280b7d434764.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5d598034c507dfb7544d2125500280b7d434764.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 17, 2022 at 09:34:31PM +0300, Alexey Bayduraev escreveu:
> Introduce bytes_transferred and bytes_compressed stats so they
> would capture statistics for the related data buffer transfers.
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 7d0338b5a0e3..0f8488d12f44 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -111,6 +111,8 @@ struct record_thread {
>  	unsigned long long	samples;
>  	unsigned long		waking;
>  	u64			bytes_written;
> +	u64			bytes_transferred;
> +	u64			bytes_compressed;
>  };
>  
>  static __thread struct record_thread *thread;
> @@ -1407,8 +1409,13 @@ static size_t zstd_compress(struct perf_session *session, struct mmap *map,
>  	compressed = zstd_compress_stream_to_records(zstd_data, dst, dst_size, src, src_size,
>  						     max_record_size, process_comp_header);
>  
> -	session->bytes_transferred += src_size;
> -	session->bytes_compressed  += compressed;
> +	if (map && map->file) {
> +		thread->bytes_transferred += src_size;
> +		thread->bytes_compressed  += compressed;
> +	} else {
> +		session->bytes_transferred += src_size;
> +		session->bytes_compressed  += compressed;
> +	}
>  
>  	return compressed;
>  }
> @@ -2098,8 +2105,20 @@ static int record__stop_threads(struct record *rec)
>  	for (t = 1; t < rec->nr_threads; t++)
>  		record__terminate_thread(&thread_data[t]);
>  
> -	for (t = 0; t < rec->nr_threads; t++)
> +	for (t = 0; t < rec->nr_threads; t++) {
>  		rec->samples += thread_data[t].samples;
> +		if (!record__threads_enabled(rec))
> +			continue;
> +		rec->session->bytes_transferred += thread_data[t].bytes_transferred;
> +		rec->session->bytes_compressed += thread_data[t].bytes_compressed;
> +		pr_debug("threads[%d]: samples=%lld, wakes=%ld, ", thread_data[t].tid,
> +			 thread_data[t].samples, thread_data[t].waking);
> +		if (thread_data[t].bytes_transferred && thread_data[t].bytes_compressed)
> +			pr_debug("trasferred=%ld, compressed=%ld\n",
> +				 thread_data[t].bytes_transferred, thread_data[t].bytes_compressed);
> +		else
> +			pr_debug("written=%ld\n", thread_data[t].bytes_written);

In file included from builtin-record.c:22:
builtin-record.c: In function 'record__stop_threads':
builtin-record.c:2138:13: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
 2138 |    pr_debug("trasferred=%ld, compressed=%ld\n",
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/debug.h:18:21: note: in definition of macro 'pr_fmt'
   18 | #define pr_fmt(fmt) fmt
      |                     ^~~
builtin-record.c:2138:4: note: in expansion of macro 'pr_debug'
 2138 |    pr_debug("trasferred=%ld, compressed=%ld\n",
      |    ^~~~~~~~
builtin-record.c:2138:27: note: format string is defined here
 2138 |    pr_debug("trasferred=%ld, compressed=%ld\n",
      |                         ~~^
      |                           |
      |                           long int
      |                         %lld
In file included from builtin-record.c:22:
builtin-record.c:2138:13: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
 2138 |    pr_debug("trasferred=%ld, compressed=%ld\n",
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/debug.h:18:21: note: in definition of macro 'pr_fmt'
   18 | #define pr_fmt(fmt) fmt
      |                     ^~~
builtin-record.c:2138:4: note: in expansion of macro 'pr_debug'
 2138 |    pr_debug("trasferred=%ld, compressed=%ld\n",
      |    ^~~~~~~~
  LINK    /tmp/build/perf/libtraceevent.a
builtin-record.c:2138:43: note: format string is defined here
 2138 |    pr_debug("trasferred=%ld, compressed=%ld\n",
      |                                         ~~^
      |                                           |
      |                                           long int
      |                                         %lld
In file included from builtin-record.c:22:
builtin-record.c:2141:13: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
 2141 |    pr_debug("written=%ld\n", thread_data[t].bytes_written);
      |             ^~~~~~~~~~~~~~~
util/debug.h:18:21: note: in definition of macro 'pr_fmt'
   18 | #define pr_fmt(fmt) fmt
      |                     ^~~
builtin-record.c:2141:4: note: in expansion of macro 'pr_debug'
 2141 |    pr_debug("written=%ld\n", thread_data[t].bytes_written);
      |    ^~~~~~~~
builtin-record.c:2141:24: note: format string is defined here
 2141 |    pr_debug("written=%ld\n", thread_data[t].bytes_written);
      |                      ~~^
      |                        |
      |                        long int
      |                      %lld

Fixed with the following patch, no need to resend, I'll fix several
other similar issues and put the result in a tmp.perf/thread branch
while I review/test it.

- Arnaldo

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0f8488d12f446b84..d19d0639c3f1abc0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2114,10 +2114,10 @@ static int record__stop_threads(struct record *rec)
 		pr_debug("threads[%d]: samples=%lld, wakes=%ld, ", thread_data[t].tid,
 			 thread_data[t].samples, thread_data[t].waking);
 		if (thread_data[t].bytes_transferred && thread_data[t].bytes_compressed)
-			pr_debug("trasferred=%ld, compressed=%ld\n",
+			pr_debug("transferred=%" PRIu64 ", compressed=%" PRIu64 "\n",
 				 thread_data[t].bytes_transferred, thread_data[t].bytes_compressed);
 		else
-			pr_debug("written=%ld\n", thread_data[t].bytes_written);
+			pr_debug("written=%" PRIu64 "\n", thread_data[t].bytes_written);
 	}
 
 	return 0;
