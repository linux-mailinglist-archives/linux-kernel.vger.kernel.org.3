Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7C496DE1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 21:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiAVULK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 15:11:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39486 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiAVULJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:11:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B36B060EC1;
        Sat, 22 Jan 2022 20:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FA2C004E1;
        Sat, 22 Jan 2022 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642882268;
        bh=Gt3uHFlxZVnfwBNagtr2hrQwUhWaSxv7EdJXOwuAYh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnMGefAPY0jX7fMDHouwVxS2VNNXp2LVQg9DP4ut2jmJ9TRG8NoNK/Mt7RnC8z9we
         /ClVthxk4qadO/C8ZHuxZggdD6UF45ByoZSr2ib5eF5+kwwEY4XfYobYrqL3qrJQWZ
         GgGbqu1fJc47m+AUuOan8BBA22Ck5bCm4Bm1YY3n3N2Yb77Zb4M+vkBfRL58xu59+Q
         /Ldi9MnjVcE4JXaHtCv6eAk5com2Ggl/Gg35jvJ++rfN7pbfm+mmZXO0luWalUvws9
         gibbhjqeH5NuiODjwKAp5lm75kUp95nQiUFivsqPVLwaboSABMmYpO4nyf3UU6K7wt
         GMxSlmgqax7ng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 90F3A40C99; Sat, 22 Jan 2022 17:09:05 -0300 (-03)
Date:   Sat, 22 Jan 2022 17:09:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, eranian@google.com
Subject: Re: [PATCH 1/3] perf python: Fix cpu_map__item building
Message-ID: <YexkYdvGh3ASfrZ+@kernel.org>
References: <20220122045811.3402706-1-irogers@google.com>
 <20220122045811.3402706-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122045811.3402706-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 21, 2022 at 08:58:09PM -0800, Ian Rogers escreveu:
> Value should be built as an integer.
> Switch some uses of perf_cpu_map to use the library API.
> 
> Fixes: 6d18804b963b ("perf cpumap: Give CPUs their own type")
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/util/python.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index f3e5131f183c..52d8995cfd73 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -638,17 +638,17 @@ static Py_ssize_t pyrf_cpu_map__length(PyObject *obj)
>  {
>  	struct pyrf_cpu_map *pcpus = (void *)obj;
>  
> -	return pcpus->cpus->nr;
> +	return perf_cpu_map__nr(pcpus->cpus);
>  }
>  
>  static PyObject *pyrf_cpu_map__item(PyObject *obj, Py_ssize_t i)
>  {
>  	struct pyrf_cpu_map *pcpus = (void *)obj;
>  
> -	if (i >= pcpus->cpus->nr)
> +	if (i >= perf_cpu_map__nr(pcpus->cpus))
>  		return NULL;
>  
> -	return Py_BuildValue("i", pcpus->cpus->map[i]);
> +	return Py_BuildValue("i", perf_cpu_map__cpu(pcpus->cpus, i).cpu);
>  }
>  
>  static PySequenceMethods pyrf_cpu_map__sequence_methods = {
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog

-- 

- Arnaldo
