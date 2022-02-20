Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418C44BD25B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 23:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbiBTWoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 17:44:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbiBTWoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 17:44:06 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD70338B7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 14:43:44 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vz16so28500953ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 14:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n9crBYb57d1azHAL1ikRm0A47D2RTNJcSC8BWr8rPVU=;
        b=YryqbrIZeQR7sxpZ5Euib3gH348PG0wFjSba/saHS87EN0nkRmZcnHxP/QR6x6H2UG
         Z4J2vOctcwyGd9GqDM3BFwSpm3S2x8ayBOEIwRVeaIN/6mb2/bX20Xdi6geyavvDSoLp
         hZqe8TOCL3zjeQzKkt9fzwLD1RB39DIGxN503+9xjOMRgnyFXI5W3QAQXMxFQWOVQ5Rv
         1wpG2Ld94Z96fyJzNiyeULxFmMnleaA2qy41ot9ch7uH1ZFKDaMHIUddpGx8mHfFPccu
         501buL6VxuX82Xin35TYVj1WENnMUifODuvHVHDy9xAeirgACTewahcW2wjze56s0d5p
         pYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n9crBYb57d1azHAL1ikRm0A47D2RTNJcSC8BWr8rPVU=;
        b=eVfXyBKIWt9PWEjqggnjhzXcscQJITo6x7UP8k/J50hnCUPBVT5KbkOelbWwPaarbS
         z6I6/B3ufRjfLP+kpbwDMvxdFmLIMN8z93cooUzX95ztDm+Sdl9gFIPHAL1qFF9iZmlY
         Iz6s8iWeu4dz1GkuGD0vWAcw8M0vLe7/iSWp5+BulAJyqGKDJfFKRLLbhP4GVkhUWMK+
         ixy0UPeV+3QVcrm2f+XL+FkAG2q8wSYnHODKIb33yaDhwZOhP9pxkStDQYBq4KpNQpim
         MNMNsNPxBd/OVsXlb/LxRdcnt8ywCG6IoJIt8FL4tnKymZew6EVgvE8du8ALfzNNL+We
         w9LA==
X-Gm-Message-State: AOAM533I4sMXMQEQZ7JmWQ1R6tgFyQ1UQuJkxhj2ZdiS8aHMvDhbVHAw
        +blzfW4sbGFS8k6/0XlXRcM=
X-Google-Smtp-Source: ABdhPJzbcePFSreGjkEwbaHDexFK/22DSAuYcSJUygQzWFXE4V6XBhOrsnLWrUmCsZvI/Sd5zROwJw==
X-Received: by 2002:a17:906:af68:b0:6cd:7896:15e with SMTP id os8-20020a170906af6800b006cd7896015emr13960547ejb.420.1645397022789;
        Sun, 20 Feb 2022 14:43:42 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id gq1sm4558283ejb.58.2022.02.20.14.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 14:43:42 -0800 (PST)
Date:   Sun, 20 Feb 2022 23:43:40 +0100
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
Subject: Re: [PATCH core] perf data: Adding error message if
 perf_data__create_dir fails
Message-ID: <YhLEHCttvXmRu78G@krava>
References: <20220218152341.5197-1-alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218152341.5197-1-alexey.v.bayduraev@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 06:23:40PM +0300, Alexey Bayduraev wrote:
> There is no notification about data directory creation failure. Add it.
> 
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
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

errno will be misleading in here, because perf_data__create_dir
calls other syscalls on error path

jirka

>  			return ret;
> +		}
>  		for (i = 0; i < evlist->core.nr_mmaps; i++) {
>  			if (evlist->mmap)
>  				evlist->mmap[i].file = &rec->data.dir.files[i];
> -- 
> 2.19.0
> 
