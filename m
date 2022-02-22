Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996F84C0453
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiBVWGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiBVWGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:06:32 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DDA9F6E6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:06:06 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c6so37426862edk.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=76vFD4OD4/7oEWipI8bhqBmcZHwT22GZhcefwg8RsXc=;
        b=BcQxzMOE8NUWdJ8RPriqAGhUdsHOzTKeYQaKjtxf81RPkct99AMXV6WsPdVnfB3wc+
         krsEIcbIsqQoi7EVfxjJYi1PCeNpD9Ec6aDms1PpiXNk+vXpQldaEN6XLhE0lZ7pY/0R
         mxa5tyZe7rhwbLVIjkkYITjUzGF05cwfWNEJnZAnB3HIS0T6vgGaVe2T8shOjXELnGav
         98SccuDkmf+v7lXwlM9MyDeXNv0OMweCLWuHs0Wt2dCuJu5mk+asjb3r/CBz7+TRB6Ct
         HoirBR5uqeAeP8u9RnyEdshNjNugrbHhv7RxzKpC/7FiO/kW5kFMT1rY50rNwtjQjBlz
         INEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=76vFD4OD4/7oEWipI8bhqBmcZHwT22GZhcefwg8RsXc=;
        b=F03ps/kl96YLxSsTValqo7OSKOq+1aK8ugXVZdqpycgUezhcYj/bIDC7UTFw6Ui6HR
         ws7RycDE0iAnHTj+cmZN0wmjgP6phR0IUfE439jXg0e8qSnTqXFR331j8wvamdBI6X4V
         CNEOsNQgqWZh4BWqbQ0K5lyOQmOkOzZZak15fT8AaZ3cgm4d8UEHWJZSRMDeC37iiTeO
         YDmuwISddETqvb+wFxkjfmbpBY23q/OTY/+DzKGwl91v7TNKa0L0JyWQ1pNpAGTENB9t
         gk7//jl5CpFov2D6u47zCyUuIbc8m6q0M9vadDxGcrQ3h6aCjmFTjRoXAI1VWVqen9id
         bbqA==
X-Gm-Message-State: AOAM5334/XHP+gIrl2ZcrE0YxiQy4bs806NiVm6iR9v/v+PZFgoFFG54
        SNL0l89hfXdPn63jtpo2k95x2lLgwFtAtA==
X-Google-Smtp-Source: ABdhPJy38U8KwOQHlcC7JDR7tzi4PgyBP1zD2kf4OvgsJh0/DpiWrod4cVt28+5CQfIbRg1qHzVucg==
X-Received: by 2002:a05:6402:1d50:b0:413:d20:8ec7 with SMTP id dz16-20020a0564021d5000b004130d208ec7mr10521592edb.334.1645567565279;
        Tue, 22 Feb 2022 14:06:05 -0800 (PST)
Received: from krava ([83.240.63.118])
        by smtp.gmail.com with ESMTPSA id g8sm6804729ejt.26.2022.02.22.14.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:06:04 -0800 (PST)
Date:   Tue, 22 Feb 2022 23:06:02 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH core v2] perf data: Adding error message if
 perf_data__create_dir fails
Message-ID: <YhVeSsxjpALcANeX@krava>
References: <20220222091417.11020-1-alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222091417.11020-1-alexey.v.bayduraev@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 12:14:17PM +0300, Alexey Bayduraev wrote:
> Adding proper return codes for all cases of data directory creation
> failure and adding error message output based on these codes.
> 
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-record.c | 4 +++-
>  tools/perf/util/data.c      | 8 ++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 0bc6529814b2..0b4abed555d8 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1186,8 +1186,10 @@ static int record__mmap_evlist(struct record *rec,
>  
>  	if (record__threads_enabled(rec)) {
>  		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
> -		if (ret)
> +		if (ret) {
> +			pr_err("Failed to create data directory: %s\n", strerror(-ret));
>  			return ret;
> +		}
>  		for (i = 0; i < evlist->core.nr_mmaps; i++) {
>  			if (evlist->mmap)
>  				evlist->mmap[i].file = &rec->data.dir.files[i];
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index f5d260b1df4d..dc5d82ea1c30 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -52,12 +52,16 @@ int perf_data__create_dir(struct perf_data *data, int nr)
>  		struct perf_data_file *file = &files[i];
>  
>  		ret = asprintf(&file->path, "%s/data.%d", data->path, i);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			ret = -ENOMEM;
>  			goto out_err;
> +		}
>  
>  		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			ret = -errno;
>  			goto out_err;
> +		}
>  
>  		file->fd = ret;
>  	}
> -- 
> 2.19.0
> 
