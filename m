Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71F150C098
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 22:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiDVUDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 16:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDVUDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 16:03:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD891E2738
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3801AB83220
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 19:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCBFC385A0;
        Fri, 22 Apr 2022 19:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650654324;
        bh=9SKM3jK2iPGEfXDhEyIE2AvKemy8k5i6L/EzzAVKkqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iF6RgM+Rv127nfGzfXZX6M6Wy79viuvggsKu3CulKDd7aDaG87zUzHfvBQoVDv2NA
         NgqdVZZv3WLjjDgHY2dyMY8qlH1RHGQyrIPJpqk37ieY8fH06CsIxljl+503o9TMDh
         E3n7U78quN8Zpw5s7VEz0vI+vDHmFZSidgZW+mtRz08adRGzbTMSsJ4GgIw5pqm8EC
         rfy7U7bUG2rkSo63A1ldtH8TwQQvs1PZI+T4LZYsAcewHcMzTlGeW8/lM8XYCJ03t+
         ddzCCqKFEFoSkpbrgoChwRqzVYSP4gwBTwXG3nQDqYzJlWBb+KuKX9AB3FquBiVx7a
         e7BDAVlNPXpKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7747B400B1; Fri, 22 Apr 2022 16:05:22 -0300 (-03)
Date:   Fri, 22 Apr 2022 16:05:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 01/21] libperf evsel: Factor out perf_evsel__ioctl()
Message-ID: <YmL8chGqV7ZDB/sZ@kernel.org>
References: <20220422162402.147958-1-adrian.hunter@intel.com>
 <20220422162402.147958-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422162402.147958-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 22, 2022 at 07:23:42PM +0300, Adrian Hunter escreveu:
> Factor out perf_evsel__ioctl() so it can be reused.

Cherry picking this one as I look at the patchset.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/evsel.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 210ea7c06ce8..20ae9f5f8b30 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -328,6 +328,17 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
>  	return 0;
>  }
>  
> +static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, void *arg,
> +			     int cpu_map_idx, int thread)
> +{
> +	int *fd = FD(evsel, cpu_map_idx, thread);
> +
> +	if (fd == NULL || *fd < 0)
> +		return -1;
> +
> +	return ioctl(*fd, ioc, arg);
> +}
> +
>  static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
>  				 int ioc,  void *arg,
>  				 int cpu_map_idx)
> @@ -335,13 +346,7 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
>  	int thread;
>  
>  	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
> -		int err;
> -		int *fd = FD(evsel, cpu_map_idx, thread);
> -
> -		if (fd == NULL || *fd < 0)
> -			return -1;
> -
> -		err = ioctl(*fd, ioc, arg);
> +		int err = perf_evsel__ioctl(evsel, ioc, arg, cpu_map_idx, thread);
>  
>  		if (err)
>  			return err;
> -- 
> 2.25.1

-- 

- Arnaldo
