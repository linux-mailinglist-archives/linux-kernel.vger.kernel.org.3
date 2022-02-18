Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EBC4BB958
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiBRMjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:39:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiBRMje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:39:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE0129A545
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:39:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5191361F7C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E30C340E9;
        Fri, 18 Feb 2022 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645187956;
        bh=qHo65HwDG+mU8Tt9U4kRIsnLeY0N9I8w58mBY4WGkv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyWp+KBXIpnavPKW7B5sricRFuxXTZGKK8esBbwSIv7atqD9bv18uIqSc/hYr4cHa
         TT2v1yBOgfvC9CHCPY136XKC6DuytmaOeEVEo2DwTgiu7onlHdcF6XSIw2aEr+4CzW
         aJHkKNRZkqPyXrobyFCfiTQ2TVbCNuHGMqEnK/zqqwjIS7i0AtOkT3Fw7+ynPhtVzs
         lBwWfpMsIMAP7NnWkqb9992rC3YHzQNITr02Jypi/DpEEDOT0ARcZwJkWpHkOpHu3Y
         y4WDTTLai392zI3ykP9s3DwdLcWFLPe8qMcU7kMeuL1lZsHb+9W6AVe3a7NqlFwOco
         p3FSpWLpnqffg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CF4B8400FE; Fri, 18 Feb 2022 09:39:13 -0300 (-03)
Date:   Fri, 18 Feb 2022 09:39:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH] perf data: Fix double free in perf_session__delete
Message-ID: <Yg+TcWkRDowtQfqO@kernel.org>
References: <20220218113008.24416-1-alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218113008.24416-1-alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 18, 2022 at 02:30:08PM +0300, Alexey Bayduraev escreveu:
> When perf_data__create_dir fails, it calls close_dir, but
> perf_session__delete also calls close_dir and since dir.version and
> dir.nr was initialized by perf_data__create_dir, a double free occurs.
> This patch moves the initialization of dir.version and dir.nr after
> successful initialization of dir.files, that prevents double freeing.
> This behavior is already implemented in perf_data__open_dir. The patch
> also adds a missing error message in case data directory creation fails.

Is this for perf/urgent or for perf/core? Probably perf/core as that
record__threads_enabled(rec) call hints.

Please state for which branch the patch should be applied, something
like;

[PATCH next] perf data: Fix double free in perf_session__delete()

Or:

[PATCH urgent] perf data: Fix double free in perf_session__delete()

- Arnaldo
 
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 4 +++-
>  tools/perf/util/data.c      | 7 +++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 0bc6529814b2..0306d5911de2 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1186,8 +1186,10 @@ static int record__mmap_evlist(struct record *rec,
>  
>  	if (record__threads_enabled(rec)) {
>  		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
> -		if (ret)
> +		if (ret) {
> +			pr_err("Failed to create data directory: %s\n", strerror(errno));
>  			return ret;
> +		}
>  		for (i = 0; i < evlist->core.nr_mmaps; i++) {
>  			if (evlist->mmap)
>  				evlist->mmap[i].file = &rec->data.dir.files[i];
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index f5d260b1df4d..15a4547d608e 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -44,10 +44,6 @@ int perf_data__create_dir(struct perf_data *data, int nr)
>  	if (!files)
>  		return -ENOMEM;
>  
> -	data->dir.version = PERF_DIR_VERSION;
> -	data->dir.files   = files;
> -	data->dir.nr      = nr;
> -
>  	for (i = 0; i < nr; i++) {
>  		struct perf_data_file *file = &files[i];
>  
> @@ -62,6 +58,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
>  		file->fd = ret;
>  	}
>  
> +	data->dir.version = PERF_DIR_VERSION;
> +	data->dir.files   = files;
> +	data->dir.nr      = nr;
>  	return 0;
>  
>  out_err:
> -- 
> 2.19.0

-- 

- Arnaldo
