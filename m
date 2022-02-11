Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8B94B29A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350152AbiBKQF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:05:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350145AbiBKQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:05:26 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD429D82
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:05:24 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id h22so5812728ejl.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=csB5DuqtfIDJ9EKSK8fiwWzQpRbB0qD6Vp/GW/qS/YQ=;
        b=grEYtNAoCYLkvBJEJgtJxnsTjxHc/cgpoV/QsJ19fyD5CPUsYizKM6gFegxVCO//Mm
         D8jAgZaBtnMbVMY7/IWuYayVDI/OH/cpqxeyW2R8ibZpnkkkzEY+zsBlgU1tLjRd8EDb
         hZlL83Q1UxrbIZHykr0xKJbiqE0qz38TTXFw6xoFzInhDy8Qe3vMx+4nSBQXPhE4oBgl
         I1hbu0VXWqMnD4IqElhASijRmdRvHCB/ZuhESFpEUu7EYyW6F+cdnY2Axi4+ElKljMSt
         zEWM6e9mBfNF/9Om96x819gasq0kLF7VNBubi3YnqQI8X+tqzsT9skc1OTJn8lYhWjTR
         gRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=csB5DuqtfIDJ9EKSK8fiwWzQpRbB0qD6Vp/GW/qS/YQ=;
        b=zMMvHIstGbIYcZpbIOGCns3ZRCXluCtgU06zg8S1P4EAKuav8nP945YP2/uFvd2EEP
         Y61tgP+U6Uvx54ji60D4HunRd9embUncXY6+tCt/re/goKBew5M6QoJaElMjme4AqB8j
         xvF3YLKyUm4a4P7FrPIs/yzPgtmAS1RNNXjJK65U9U07P3DpwHc5ilJcWXgZZGzCFMFW
         2Rj2+C7GsJD/rWLBhphIeERJ2CA0loeWqcHwqm5P4lxO/sFkChap3A9vTnNEYDXcHzaH
         bCHh+EQuxTqQOM/uqJmSO53eu7Wfff263IqotIKNeCtimOk8yG1PaHC/M6NzKPU5n9Lb
         cSxQ==
X-Gm-Message-State: AOAM532hN8RZcFuVOwn9mJzDahBzgInGJhjcbdRZqj37ud+4Aw0svOcA
        3pSyfpWWVsgvRUmdrJ9p8glPtQ==
X-Google-Smtp-Source: ABdhPJw5QT9Y+IdfGntvtWKYXBrXdelCVroLEMdDbamYIFpp+AWguR/K4n0J65D0Y0UuY+gJH2msDg==
X-Received: by 2002:a17:906:58cc:: with SMTP id e12mr2008984ejs.162.1644595523236;
        Fri, 11 Feb 2022 08:05:23 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.223])
        by smtp.gmail.com with ESMTPSA id p19sm8062729ejc.42.2022.02.11.08.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:05:22 -0800 (PST)
Date:   Sat, 12 Feb 2022 00:05:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf: cs-etm: Fix corrupt inject files when only
 last branch option is enabled
Message-ID: <20220211160516.GD475776@leoy-ThinkPad-X240s>
References: <20220210200620.1227232-1-james.clark@arm.com>
 <20220210200620.1227232-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210200620.1227232-2-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 08:06:20PM +0000, James Clark wrote:
> Perf inject with Coresight data generates files that cannot be opened
> when only the last branch option is specified:
> 
>   perf inject -i perf.data --itrace=l -o inject.data
>   perf script -i inject.data
>   0x33faa8 [0x8]: failed to process type: 9 [Bad address]
> 
> This is because cs_etm__synth_instruction_sample() is called even when
> the sample type for instructions hasn't been setup. Last branch records
> are attached to instruction samples so it doesn't make sense to generate
> them when --itrace=i isn't specified anyway.
> 
> This change disables all calls of cs_etm__synth_instruction_sample()
> unless --itrace=i is specified, resulting in a file with no samples if
> only --itrace=l is provided, rather than a bad file.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/cs-etm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 796a065a500e..8b95fb3c4d7b 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1553,6 +1553,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>  		goto swap_packet;
>  
>  	if (etmq->etm->synth_opts.last_branch &&
> +	    etmq->etm->synth_opts.instructions &&
>  	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
>  		u64 addr;
>  
> @@ -1610,6 +1611,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
>  	 * the trace.
>  	 */
>  	if (etmq->etm->synth_opts.last_branch &&
> +	    etmq->etm->synth_opts.instructions &&
>  	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
>  		u64 addr;
>  
> -- 
> 2.28.0
> 
