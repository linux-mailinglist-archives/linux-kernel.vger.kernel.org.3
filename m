Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BAB4D05C3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbiCGR4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbiCGR4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:56:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD0990278;
        Mon,  7 Mar 2022 09:55:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A5A6B8166D;
        Mon,  7 Mar 2022 17:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABFCC340E9;
        Mon,  7 Mar 2022 17:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646675745;
        bh=XO3bnEiXx2AK1tV25481oizUAmIkV4mdmJSlm+qfhiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7902SwpBaZPMSr94um8+n3bwsC/Bs/KzHx+plOYERkKUm2bDbac2Kt8sZOwNENKr
         6EgldiYxwLEhFFpBbd7zzzMQLaI6tVZKOXvj9ijr2KKZoGYTMEESw1mDAocvn7ZXjz
         rrtSwg8hbOFcksWh+CaLYFwraMmY0KprJZTfhvQ235WYBGptePMVQLI+fnE/+P+3rI
         9mTFsbjkllSgH6Ka1RAfvblgSo/oS2owcNjQSDvqyp5vDj08ZbbKFU98se+3jgJ0Eg
         +yL/87UvaZF833G1XkQ8NtQ/5iC7mqrmL6fY9InCIwn8JCFjKpuv3jY57SJ/p2Qu+m
         4SXuVfxauylSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2DD8403C8; Mon,  7 Mar 2022 14:55:42 -0300 (-03)
Date:   Mon, 7 Mar 2022 14:55:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf tools: fix array_size.cocci warning
Message-ID: <YiZHHs/UlL/zE/jh@kernel.org>
References: <20220307034008.4024-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307034008.4024-1-guozhengkui@vivo.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 07, 2022 at 11:39:59AM +0800, Guo Zhengkui escreveu:
> Fix the following coccicheck warning:
> tools/perf/util/trace-event-parse.c:209:35-36: WARNING: Use ARRAY_SIZE
> 
> ARRAY_SIZE(arr) is a macro provided in tools/include/linux/kernel.h,
> which not only measures the size of the array, but also makes sure
> that `arr` is really an array.

Thanks, applied.
 
> It has been tested with gcc (Debian 8.3.0-6) 8.3.0.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  tools/perf/util/trace-event-parse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
> index 9634f0ae57be..c9c83a40647c 100644
> --- a/tools/perf/util/trace-event-parse.c
> +++ b/tools/perf/util/trace-event-parse.c
> @@ -206,7 +206,7 @@ unsigned long long eval_flag(const char *flag)
>  	if (isdigit(flag[0]))
>  		return strtoull(flag, NULL, 0);
>  
> -	for (i = 0; i < (int)(sizeof(flags)/sizeof(flags[0])); i++)
> +	for (i = 0; i < (int)(ARRAY_SIZE(flags)); i++)
>  		if (strcmp(flags[i].name, flag) == 0)
>  			return flags[i].value;
>  
> -- 
> 2.20.1

-- 

- Arnaldo
