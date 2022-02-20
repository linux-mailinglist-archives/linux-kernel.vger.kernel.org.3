Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563364BD260
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 23:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbiBTWqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 17:46:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245209AbiBTWqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 17:46:42 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D23031DF2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 14:46:20 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p14so28310195ejf.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 14:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=quD5U0AaB7dwoV+0MYVxL3iSYkmAfbQXI74kd2LRgxs=;
        b=FJh2EnQb6wIBt+GjM+HhsEm/C3WIeRZPNBslUNVSFk4JszVoR7o5PmtLVr6wXgUGZc
         KlKLAX1aYkH7zSMxAva6h6rHy3Hms28iAftln6wGI+iH/snTZCWROADWkW3F+THSo9/B
         zsteKt30WbSI2IJpMVjVFY0KdYvsO0hKL3XdsfxUhROQS7NPZa86mBETWzoPUO2rkiNI
         ps4IFfO1c98UNuuWiknNP7oxXVL8IbP6NIFuX9gpPoduvQvxg9WYFUPvsI3fpBpnR4py
         R6jt44G5X/esdU1X+Mx6sTEphesFPgcQCv1N1DKZbYP7LeIVrLmzSq/RklTiGHxhX2Im
         LOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=quD5U0AaB7dwoV+0MYVxL3iSYkmAfbQXI74kd2LRgxs=;
        b=Q170F1+EsS5hRfrLNwyUmHAXefXzqVCtWunSELLgt7TH8bwv38xhKI8ZAqHqUlnefc
         vURZf9aGhfIIBz6pYj4TUDEUDg4BUPBmLpDh71/PgOt2tSm47n/QeInmbuAej8bk8LoS
         dPsICPWAzYbJ8ClepBqSxhU6cOs5hSLe2T8YAMeb9XUbToG0Lwwr50U3eGE4AHD/oGDd
         vBZV2i0QAASxAQQJ6f3D4s+vdTJoOuUm1nt6TeDvWYl0o/JmBQF1Ql9EoOV9cIDISsp8
         D8b8YsPCyYUzmoac+8fKfGapvrINaBApvMyGzZVhO4PoLMUsRFMFXVprjb9CmHzivrPG
         32kg==
X-Gm-Message-State: AOAM531exmX47t4r5Gu/rikPuNiBHUdn46TMyEd651SugAcxE1xcvlOZ
        G/JkzWMvDX823Mv68mprPe6cO+OHWEDBwQ==
X-Google-Smtp-Source: ABdhPJzf5hTI3uxg0mxe1d7k2S7AH1KqRNbELuZvPcb8keE1RRfeoR5o6n/QmXYgr8DVH3a+WC4+YA==
X-Received: by 2002:a17:906:6b87:b0:6ce:537b:53bb with SMTP id l7-20020a1709066b8700b006ce537b53bbmr13487662ejr.51.1645397178683;
        Sun, 20 Feb 2022 14:46:18 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id f22sm8027349edf.95.2022.02.20.14.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 14:46:18 -0800 (PST)
Date:   Sun, 20 Feb 2022 23:46:15 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH urgent] perf data: Fix double free in perf_session__delete
Message-ID: <YhLEt8IJcgKofO6f@krava>
References: <20220218152341.5197-1-alexey.v.bayduraev@linux.intel.com>
 <20220218152341.5197-2-alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218152341.5197-2-alexey.v.bayduraev@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 06:23:41PM +0300, Alexey Bayduraev wrote:
> When perf_data__create_dir fails, it calls close_dir, but
> perf_session__delete also calls close_dir and since dir.version and
> dir.nr was initialized by perf_data__create_dir, a double free occurs.
> This patch moves the initialization of dir.version and dir.nr after
> successful initialization of dir.files, that prevents double freeing.
> This behavior is already implemented in perf_data__open_dir.
> 
> Fixes: 145520631130bd64 ("perf data: Add perf_data__(create_dir|close_dir) functions")
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/data.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
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
> 
