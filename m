Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD94B5A82A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiHaQD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiHaQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:03:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC2B14F4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:02:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so2167843wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1bB7tQtCppbl15pSiTQsgDbN8ntnJOFVfGoL4e77fQM=;
        b=MlISibdNRllyuJ2XZ0NiDnL5OA7Oxj3FtEBi7U3GDrhDg3Tg7juqQpBFWGw3TXRBSr
         +NbervZgo2ypCctTi9mHrQINXCWoKyrSvxM9P5fUBo8E2i8U0xVwtsPubRQixRq252TD
         vqi051fEgRvSsSeoR1DmtRNvyWYRGFjSUQUNouI5cxXw8BvzTY4D4AugObg4tJnVxYXW
         AXV23giSr6I+gnZ2AyU6tX+GFw6M25+WFpGRaxpLgB2GS84fjxIhC7NU5I3JspWVghpx
         JViNTMHE8WFO/bgnGuj/TYMnOz1BRcAQWX2Sxvf1nBmWu1032C9u7k3IzplCJscd0/vC
         zR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1bB7tQtCppbl15pSiTQsgDbN8ntnJOFVfGoL4e77fQM=;
        b=PHCIl1AiJwBSBEZQJ3hyTLaOKxktaZ85lFIQrzcbjneiswJjsTydVbuWbbopup9/L9
         Mrj47ZYs4GceGmzLo8IjWURSzsGTBkdagf0aokmt7HxCkD7eQ8DTiZ5E0JFyvHTzp7Zy
         wotF1cTNUB8oPtCvdCY0CauhIsL9o90k6FBtwQg5oWKM6oea9A3bT7bjdk5yy7KSsD3Y
         5U59tbngvpLb8lgx/MrULadHfdBe9kPhCn3F17BRmwe9zb5ddqsmakCSFCl9WQY2CAuo
         s39ef7/tpsTdGxcHkmekpmELbbF9ry+y3gBAAjRwtldaxPQjKf7e8yuvz3oJ473mkP1X
         qXBA==
X-Gm-Message-State: ACgBeo2xGRSmauQTtJJvnVADxu0QS6R5VW2iqtKg2Poqaugl0hflGxkt
        zyEV5uhYnYbHuaS4tmX3x9GAsZmtu26TcExL81MRvQ==
X-Google-Smtp-Source: AA6agR6WdXjH4ZbfUSKI+Ue/geK+PwtjHMwxl+GrSrxpX7Jk4KDVoHR8IIJumtHTPQSrrU97y4H3qhEaOM4OMWlmugU=
X-Received: by 2002:a05:600c:1d89:b0:3a5:c1db:21c6 with SMTP id
 p9-20020a05600c1d8900b003a5c1db21c6mr2337210wms.174.1661961778110; Wed, 31
 Aug 2022 09:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220831124041.219925-1-jolsa@kernel.org>
In-Reply-To: <20220831124041.219925-1-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 31 Aug 2022 09:02:46 -0700
Message-ID: <CAP-5=fX-=ph8g3VKbQXSRT8SiOZ3XqQLd3T9-ZTNZ5L+ye5L-A@mail.gmail.com>
Subject: Re: [PATCH] perf script: Skip dummy event attr check
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hongtao Yu <hoy@fb.com>, Namhyung Kim <namhyung@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 5:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Hongtao Yu reported problem when displaying uregs in perf script
> for system wide perf.data:
>
>   # perf script -F uregs | head -10
>   Samples for 'dummy:HG' event do not have UREGS attribute set. Cannot print 'uregs' field.
>
> The problem is the extra dummy event added for system wide,
> which does not have proper sample_type setup.
>
> Skipping attr check completely for dummy event as suggested
> by Namhyung, because it does not have any samples anyway.
>
> Reported-by: Hongtao Yu <hoy@fb.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-script.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 13580a9c50b8..304d234d8e84 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -566,6 +566,8 @@ static struct evsel *find_first_output_type(struct evlist *evlist,
>         struct evsel *evsel;
>
>         evlist__for_each_entry(evlist, evsel) {
> +               if (evsel__is_dummy_event(evsel))
> +                       continue;
>                 if (output_type(evsel->core.attr.type) == (int)type)
>                         return evsel;
>         }
> --
> 2.37.2
>
