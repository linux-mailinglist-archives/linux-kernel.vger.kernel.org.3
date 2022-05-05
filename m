Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8257551CCD6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386845AbiEEXqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242876AbiEEXqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:46:05 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A787E40A0C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:42:24 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id y74so5676028vsy.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qtkb0e6uGUM2SGve2cKv/HyseuNRJkAPF55/G6VWHmQ=;
        b=LqTR7EZs8SYW2MglBEfIHbxgxU0DaL+3X+2l4txxOoBmb2e9NE3gJ78AshjB0Zi0cK
         TEn19+EKNuD3Zim+lXfbISHWL6g6PHg64oFBWLWvGSKIjpLwvI1KzfPzaiJ1/6nB0rXq
         gk9nnlhr7jILmxQiG/CYQmEnTQiUFcRuMA+TVRWh8gPwQ7ioOXDrJgu3EXPQaIM4F/tj
         Of7LZpFcacwbA+wfuLUiDi5iKcYMd3bUnBBt6v9JtWPZZkxUnvZQZLTang/tsZaRs9yj
         /CJ13vaFGphTn7g3GhAZsMIyc000J1EwAiIR3oxf7KK0P39VOOsznoT93O1k3kjAjW30
         SokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qtkb0e6uGUM2SGve2cKv/HyseuNRJkAPF55/G6VWHmQ=;
        b=WNLDFmQkr+FgSi7EnJLjFGjdeF+03CvmNGQpSjaq43SvmCUfzz/TMAuFMjcTF/eCGW
         bPVys2jDUQVx4Z8LO0yk8xIIfWVR6PTeaa6pgGuiiJoyuBOFp/PN2UhHQ/LhQ0fkBodV
         fS+txgzKlf+134sQl/uxvROPgMffYqcz5y9ebqilwLkNFjXVY9N5tZC7ikChN/1Gd2sd
         yjogIrs+LL/WPB5XuEm5JNsPHOOMCl27lXR2sn0YGjLzfzLNf+xgpICYRlzP8+Y0YleQ
         lXkXXYFy2H0tQbs30VFKxEs34ARO03vFS+h/VAWZGrYrAD8bsVj1p7oGjJSBnlovTKxy
         Ylzg==
X-Gm-Message-State: AOAM532Li0k38KygmL8Yif+ZuFdKiF8UXremipSlNvm7lzXzg0FJFjcI
        bUB3n5Xdtlf9bRoWBmapDnlLd6s3+p0YkNnnVPSSrQ==
X-Google-Smtp-Source: ABdhPJy3H8oVxQ9yUTc5ep9BgNcPaqLqiGXi5fALMGzHVp8cSrK8ak9ZQozgRM+bE0DqvD6XAg05+xN2oj9xbRw77+k=
X-Received: by 2002:a05:6102:244d:b0:32c:dfc4:d818 with SMTP id
 g13-20020a056102244d00b0032cdfc4d818mr196414vss.74.1651794143652; Thu, 05 May
 2022 16:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-13-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-13-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 16:42:11 -0700
Message-ID: <CAP-5=fV_haf+YLa0FZ5PVs+RFLA=LVvZauUbdJC4HT9bjcoFqQ@mail.gmail.com>
Subject: Re: [PATCH V1 12/23] perf evlist: Factor out evlist__dummy_event()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
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

On Thu, May 5, 2022 at 9:57 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Factor out evlist__dummy_event() so it can be reused.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evlist.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 25eae096bdac..78c47cbafbc2 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -242,14 +242,20 @@ int __evlist__add_default(struct evlist *evlist, bool precise)
>         return 0;
>  }
>
> -int evlist__add_dummy(struct evlist *evlist)
> +static struct evsel *evlist__dummy_event(struct evlist *evlist)
>  {
>         struct perf_event_attr attr = {
>                 .type   = PERF_TYPE_SOFTWARE,
>                 .config = PERF_COUNT_SW_DUMMY,
>                 .size   = sizeof(attr), /* to capture ABI version */
>         };
> -       struct evsel *evsel = evsel__new_idx(&attr, evlist->core.nr_entries);
> +
> +       return evsel__new_idx(&attr, evlist->core.nr_entries);
> +}
> +
> +int evlist__add_dummy(struct evlist *evlist)
> +{
> +       struct evsel *evsel = evlist__dummy_event(evlist);
>
>         if (evsel == NULL)
>                 return -ENOMEM;
> --
> 2.25.1
>
