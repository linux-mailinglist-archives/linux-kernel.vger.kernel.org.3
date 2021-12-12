Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C9F471B02
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 15:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhLLOze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 09:55:34 -0500
Received: from foss.arm.com ([217.140.110.172]:32992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhLLOze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 09:55:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E3EC106F;
        Sun, 12 Dec 2021 06:55:33 -0800 (PST)
Received: from [192.168.0.5] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BE8B3F793;
        Sun, 12 Dec 2021 06:55:30 -0800 (PST)
Subject: Re: [PATCH] perf stat: Fix NULL vs IS_ERR() checking in check_per_pkg
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211212042325.9751-1-linmq006@gmail.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <864ad02d-6afe-791c-f742-56582b633482@arm.com>
Date:   Sun, 12 Dec 2021 14:55:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211212042325.9751-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

On 12/12/2021 04:23, Miaoqian Lin wrote:
> The hashmap__new() function does not return NULL on errors. It returns
> ERR_PTR(-ENOMEM). Using IS_ERR() to check the return value
> to fix this.
>
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  tools/perf/util/stat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 09ea334586f2..a77052680087 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -311,8 +311,8 @@ static int check_per_pkg(struct evsel *counter,
>  
>  	if (!mask) {
>  		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
> -		if (!mask)
> -			return -ENOMEM;
> +		if (IS_ERR(mask))
> +			return PTR_ERR(mask);

I see that callers to "ids__new" are also missing these checks. Did you
consider patching those also?

Thanks,
German

>  
>  		counter->per_pkg_mask = mask;
>  	}
