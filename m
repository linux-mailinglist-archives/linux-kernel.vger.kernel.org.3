Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1A545242
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245017AbiFIQrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiFIQrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815DF49CB3;
        Thu,  9 Jun 2022 09:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1925B61435;
        Thu,  9 Jun 2022 16:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52379C34114;
        Thu,  9 Jun 2022 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654793237;
        bh=s4GLJNpauazSdGeRzSiiqXD67ISwLtFoXrDb8QBEiMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqoABzLdEYKkh97/nR9klaMMn+3WiQdRQB5QNMuK18IPM46UPINIzZtLWZutVe1AV
         QJe7MODAATf9BtaOWX2DqDvM68+VAAmmhYxrps0db5OGS6SJCfjuLLSyHEFL4syc2C
         QxhkNDjWzn1GKG5nRWEwfqUpz84CroFfO4oznG0JTSN6zGFrzu/YaWt7dkMh4YP+zu
         AQr98HnxyZjkAU1B0UF4wiV3y8e5Itk3e4ma0PoftGvoOKI7w5DE+hNpyTYIyOPT7f
         meeVp3UGqoSDl6E2A+g0zxKPqRcZdvqqKe4t7R8kQtfN3C7NWLcvdvE/fQuNRpWk37
         4yh6BY5aixxOQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 14ED94096F; Thu,  9 Jun 2022 13:47:15 -0300 (-03)
Date:   Thu, 9 Jun 2022 13:47:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/4] libperf evsel: Open shouldn't leak fd on failure
Message-ID: <YqIkEzCqgygb6F3f@kernel.org>
References: <20220608224353.1176079-1-irogers@google.com>
 <20220608224353.1176079-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608224353.1176079-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 08, 2022 at 03:43:50PM -0700, Ian Rogers escreveu:
> If the perf_event_open fails the fd is opened but the fd is only freed
> by closing (not by delete). Typically when an open fails you don't call
> close and so this results in a memory leak. To avoid this, add a close
> when open fails.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/evsel.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index c1d58673f6ef..952f3520d5c2 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -149,23 +149,30 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
>  			int fd, group_fd, *evsel_fd;
>  
>  			evsel_fd = FD(evsel, idx, thread);
> -			if (evsel_fd == NULL)
> -				return -EINVAL;
> +			if (evsel_fd == NULL) {
> +				err = -EINVAL;
> +				goto out;
> +			}
>  
>  			err = get_group_fd(evsel, idx, thread, &group_fd);
>  			if (err < 0)
> -				return err;
> +				goto out;
>  
>  			fd = sys_perf_event_open(&evsel->attr,
>  						 threads->map[thread].pid,
>  						 cpu, group_fd, 0);
>  
> -			if (fd < 0)
> -				return -errno;
> +			if (fd < 0) {
> +				err = -errno;
> +				goto out;
> +			}
>  
>  			*evsel_fd = fd;
>  		}
>  	}
> +out:
> +	if (err)
> +		perf_evsel__close(evsel);
>  
>  	return err;
>  }
> -- 
> 2.36.1.255.ge46751e96f-goog

-- 

- Arnaldo
