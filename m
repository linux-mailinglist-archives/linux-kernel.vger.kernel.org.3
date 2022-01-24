Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E0449850A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbiAXQmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241174AbiAXQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:42:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19838C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:42:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 939766104F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D004EC340E5;
        Mon, 24 Jan 2022 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643042522;
        bh=yToCtP1DwHyWLCVgbj3vG9Ean9EZBDLjsYvmycPPUTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LszlyFoM5z3ooARQUNpD6cf7lKe/84UjAPNJGnMY+3DnFKzQDKXCn2JHKC5wlp5vM
         HonFcrLEXXgFKNsu6m6zJjC+Fvvp6cEifmbRLmQwZQlM1AnzkXWGllbnKab8bbzfcY
         4/Kfwt69NVI1Fx5u8LSyEtIBXMN4Wljdru5EkNzxhQjJMP5m9DQtE5UshJhM01Hb9+
         pP3Euc9ceq0KVgthQIGajjbaQNLIHzxxy22S8b2/w1E4YcTl55dZVGLTUOz22eO1G5
         OW1IZILKfrQMgX8cr1AMw57A65MfNciTw5xky234+pCbff98AsjCv8YWszAanx986N
         2C+T7pK6P+QWQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8F56440C99; Mon, 24 Jan 2022 13:39:59 -0300 (-03)
Date:   Mon, 24 Jan 2022 13:39:59 -0300
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
Message-ID: <Ye7WX9L7rbn5HicP@kernel.org>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <b5d598034c507dfb7544d2125500280b7d434764.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <Ye7FkknVAUJjM+oV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye7FkknVAUJjM+oV@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 24, 2022 at 12:28:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> builtin-record.c:2141:4: note: in expansion of macro 'pr_debug'
>  2141 |    pr_debug("written=%ld\n", thread_data[t].bytes_written);
>       |    ^~~~~~~~
> builtin-record.c:2141:24: note: format string is defined here
>  2141 |    pr_debug("written=%ld\n", thread_data[t].bytes_written);
>       |                      ~~^
>       |                        |
>       |                        long int
>       |                      %lld
> 
> Fixed with the following patch, no need to resend, I'll fix several
> other similar issues and put the result in a tmp.perf/thread branch
> while I review/test it.

Did it, with the fix it builds in all containers, now to test it and
review patch by patch one more time.

[acme@quaco perf]$ git push acme.korg perf/core:tmp.perf/threaded
Enumerating objects: 134, done.
Counting objects: 100% (134/134), done.
Delta compression using up to 8 threads
Compressing objects: 100% (55/55), done.
Writing objects: 100% (108/108), 23.64 KiB | 4.73 MiB/s, done.
Total 108 (delta 105), reused 55 (delta 53), pack-reused 0
remote: Resolving deltas: 100% (105/105), completed with 25 local objects.
remote: Recorded in the transparency log
remote:  manifest: updated /pub/scm/linux/kernel/git/acme/linux.git
remote: Done in 0.06s
remote: Notifying frontends: dfw ams sin
To gitolite.kernel.org:/pub/scm/linux/kernel/git/acme/linux.git
 * [new branch]                        perf/core -> tmp.perf/threaded
[acme@quaco perf]$

- Arnaldo

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 0f8488d12f446b84..d19d0639c3f1abc0 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2114,10 +2114,10 @@ static int record__stop_threads(struct record *rec)
>  		pr_debug("threads[%d]: samples=%lld, wakes=%ld, ", thread_data[t].tid,
>  			 thread_data[t].samples, thread_data[t].waking);
>  		if (thread_data[t].bytes_transferred && thread_data[t].bytes_compressed)
> -			pr_debug("trasferred=%ld, compressed=%ld\n",
> +			pr_debug("transferred=%" PRIu64 ", compressed=%" PRIu64 "\n",
>  				 thread_data[t].bytes_transferred, thread_data[t].bytes_compressed);
>  		else
> -			pr_debug("written=%ld\n", thread_data[t].bytes_written);
> +			pr_debug("written=%" PRIu64 "\n", thread_data[t].bytes_written);
>  	}
>  
>  	return 0;

-- 

- Arnaldo
