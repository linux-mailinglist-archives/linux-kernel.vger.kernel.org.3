Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA54639B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbhK3PVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:21:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40258 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243848AbhK3PUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:20:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7658B81A23;
        Tue, 30 Nov 2021 15:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABB5C53FC7;
        Tue, 30 Nov 2021 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638285401;
        bh=tmCIJXhsQSYZuiSF05bSR0dpSBbVRu8wuc+GEoqjBB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoCCkC5yJ7E6dAyx3V0w81P8exBIFXK0ru97Z8fAg+nTW8Wx1GmJvx7WfmcL2XTwS
         pEJDFkdj/cWat22rwrM4Q3DCrLTQADq5DtGpY14PnTqkvCiVYNfpupnsTgjyybWjvJ
         tGWKAh/3etl5qCqFUEXoDA3B3sQCb8FDu9TGkCIOGDPMc5OrKv4uyPYe1oATS3zWYi
         i0NA8JExuq9RQsMliCcSe/goB2mqOBRLtImjJpGsObP8EOeb+Ib36P/JiKColBW3/Y
         Z7j7caiB812t9NOHVLZ6O7ZEwZqjwVYrgiqxjaQj99Y24P3Kq9T3PJqeWeHe0qaPqJ
         QPxq0Yz4bu+Ww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0551540002; Tue, 30 Nov 2021 12:16:38 -0300 (-03)
Date:   Tue, 30 Nov 2021 12:16:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Enable ignore_missing_thread for trace
Message-ID: <YaZAVjjPmAApJOG9@kernel.org>
References: <20211123074018.11406-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123074018.11406-1-ligang.bdlg@bytedance.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 23, 2021 at 03:40:17PM +0800, Gang Li escreveu:
> perf already support ignore_missing_thread for -u/-p, but not yet
> applied to `perf trace`. This patch enable ignore_missing_thread
> for `perf trace`.
> 
> ref:
> Link: http://lkml.kernel.org/r/1481538943-21874-6-git-send-email-jolsa@kernel.org
> Link: http://lkml.kernel.org/r/1513148513-6974-1-git-send-email-zhangmengting@huawei.com
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
>  tools/perf/builtin-trace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 0b52e08e558e..94d62a92f1a1 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3950,6 +3950,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  		evlist__add(evlist, pgfault_min);
>  	}
>  
> +	/* Enable ignoring missing threads when -u/-p option is defined. */
> +	trace->opts.ignore_missing_thread = trace->opts.target.uid != UINT_MAX || trace->opts.target.pid;
> +
>  	if (trace->sched &&
>  	    evlist__add_newtp(evlist, "sched", "sched_stat_runtime", trace__sched_stat_runtime))
>  		goto out_error_sched_stat_runtime;

Thanks, applied.

- Arnaldo

