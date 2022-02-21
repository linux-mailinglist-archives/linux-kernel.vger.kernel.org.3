Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636E24BEACE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiBUS2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:28:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiBUS0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:26:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD977C7D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:24:33 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p15so35309670ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VrJahzZJ/M1x1jlKCya/AAr+tVg0X5cYEeiwY9y7oXw=;
        b=qnOqGiaChnG940C+mXX+rqoKTtx/ZMYCjlcLfjZ6RW+CRW5Zf2MmiSQUtQR6OduRuQ
         ut2YxNw024KMpK8H2Wm9+PRRrZmlte3Xuc2NemvqdLvAjERKIqw6cqU9/U1weZn0d4iA
         KHtLQn85kQt51KZYF3Gtgkvj8b01K+o2uiA4BuDpuwIIWd1zyUI/EZ+HHxOUoCipUahY
         gPV449t2bucHBkj+iPzoFIXuOee74A8cT5Q+Et+a7rbVlY2SirZfrs7DcCz/TlRk9Sxf
         GDWVU73VUGoZYkBllBYBEBrhj6k83R38kgm2UkCgZM1/TWRVOvc87MniiRRKr6jZjY81
         8gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VrJahzZJ/M1x1jlKCya/AAr+tVg0X5cYEeiwY9y7oXw=;
        b=bOTHRh01OecLhkUhefwP5A/76J16aJxsrZ6Sktdnb6oeLUNhAAcOVonyo4hBICIdCk
         4Hj9Q9QFThVwT/7YIU2uEypP7+W1+if5JSSC0/csi8WVTC9W6tkVluI8ueRsve3ONxgS
         sj2pEjBtDJZ/FVKktY8zE6Vx1pYUYKAzs/8lnMit4DbJI8mL4AsDJT9NTnY2cYerPJkT
         70BMF8gMDuLXz4Sn1I9/mHQqqhJsp6KsC+OBSuqOV0Pi0H0aX2H7IOWLdlXPNlKdj2r3
         LqwD22c4NIn9skBQ2CGk2h0JwCJq5Vq8w9B7SQJYHVJNocWPcEx5nakUlmHNorAPdZhB
         6b+g==
X-Gm-Message-State: AOAM532hfI9B3SYYd1+7hmfGmJQE6QG5P97447wuuhs37DuilAIVvG8a
        PEwfW/kuqrGxQ8qnxw0LYGLfBa0aCQQsMw==
X-Google-Smtp-Source: ABdhPJwrco5rvnrea2wm51FpkRbG+pj00GDNzUojXDuXcdeMT7F6tysHbzvaz0t807k7a6ANgZujpg==
X-Received: by 2002:a17:906:3a41:b0:6ce:374d:adfa with SMTP id a1-20020a1709063a4100b006ce374dadfamr16941562ejf.199.1645467872286;
        Mon, 21 Feb 2022 10:24:32 -0800 (PST)
Received: from krava ([2a00:102a:500a:4c07:3c4e:83d8:8cd9:974f])
        by smtp.gmail.com with ESMTPSA id h7sm9097346ede.66.2022.02.21.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:24:31 -0800 (PST)
Date:   Mon, 21 Feb 2022 19:24:28 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
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
Message-ID: <YhPY3B3QumIZWukQ@krava>
References: <20220218152341.5197-1-alexey.v.bayduraev@linux.intel.com>
 <YhLEHCttvXmRu78G@krava>
 <60253e6d-e8c5-550e-73b5-40720114c2a4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60253e6d-e8c5-550e-73b5-40720114c2a4@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:24:28PM +0300, Bayduraev, Alexey V wrote:
> On 21.02.2022 1:43, Jiri Olsa wrote:
> > On Fri, Feb 18, 2022 at 06:23:40PM +0300, Alexey Bayduraev wrote:
> >> There is no notification about data directory creation failure. Add it.
> >>
> >> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> >> ---
> >>  tools/perf/builtin-record.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> >> index 0bc6529814b2..0306d5911de2 100644
> >> --- a/tools/perf/builtin-record.c
> >> +++ b/tools/perf/builtin-record.c
> >> @@ -1186,8 +1186,10 @@ static int record__mmap_evlist(struct record *rec,
> >>  
> >>  	if (record__threads_enabled(rec)) {
> >>  		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
> >> -		if (ret)
> >> +		if (ret) {
> >> +			pr_err("Failed to create data directory: %s\n", strerror(errno));
> > 
> > errno will be misleading in here, because perf_data__create_dir
> > calls other syscalls on error path
> 
> Mostly I want to output something like:
> 
>   Failed to create data dir: Too many open files
> 
> This will trigger the user to increase the open files limit.
> Would it be better to place such message to perf_data__create_dir after 
> open() syscall?

how about something like below (with your change)

jirka


---
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 15a4547d608e..d3382098d6f9 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -52,8 +52,10 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 			goto out_err;
 
 		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
-		if (ret < 0)
+		if (ret < 0) {
+			ret = -errno;
 			goto out_err;
+		}
 
 		file->fd = ret;
 	}
