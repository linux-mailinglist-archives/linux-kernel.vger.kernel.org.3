Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60DD46D137
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhLHKrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:47:48 -0500
Received: from foss.arm.com ([217.140.110.172]:56698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhLHKrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:47:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 076BEED1;
        Wed,  8 Dec 2021 02:44:11 -0800 (PST)
Received: from [10.57.83.109] (unknown [10.57.83.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA73D3F5A1;
        Wed,  8 Dec 2021 02:44:08 -0800 (PST)
Subject: Re: [PATCH] perf dlfilter: Drop unused variable
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211123211821.132924-1-carnil@debian.org>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <5603b487-3e42-cfbd-200b-250c46dc0bc6@arm.com>
Date:   Wed, 8 Dec 2021 10:44:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123211821.132924-1-carnil@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/11/2021 21:18, Salvatore Bonaccorso wrote:
> Compiling tools/perf/dlfilters/dlfilter-test-api-v0.c result in:
>
> 	checking for stdlib.h... dlfilters/dlfilter-test-api-v0.c: In function ‘filter_event’:
> 	dlfilters/dlfilter-test-api-v0.c:311:29: warning: unused variable ‘d’ [-Wunused-variable]
> 	  311 |         struct filter_data *d = data;
> 	      |

Did you get this warning when issuing "make"? From my side, it generated
this gcc command so I didn't get it (make DEBUG=1):

  gcc -c -Iinclude  -o dlfilters/dlfilter-test-api-v0.o -fpic dlfilters/dlfilter-test-api-v0.c

Reviewed-by: German Gomez <german.gomez@arm.com>

Thanks,
German

>
> So remove the  variable now.
>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>  tools/perf/dlfilters/dlfilter-test-api-v0.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/dlfilters/dlfilter-test-api-v0.c
> index 7565a1852c74..b17eb52a0694 100644
> --- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
> +++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
> @@ -308,8 +308,6 @@ int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, vo
>  
>  int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
>  {
> -	struct filter_data *d = data;
> -
>  	pr_debug("%s API\n", __func__);
>  
>  	return do_checks(data, sample, ctx, false);
