Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A42B53AAA0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355934AbiFAQAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355958AbiFAQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:00:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DEA502F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:00:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r129so1228048wmr.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilg3wcyDSklsbMz1TOa+dWOz/hKRqF3HJGEzPGq8bYo=;
        b=HOiMEkgpdNnA+ZD3OrPYUyF8xH4aDp15CJPEqDtp+QJBleiSHldAWCZ1yslxpKWG3z
         88CSduSitINIy/SYSYDuptvzaIO0R+DO8yflCUQIFJ2aV3hFP82hglfJJ0uGv/ath+gX
         Gcj+4yGLmw4rJX9bsqx1RiGGc9XITbD64hw1JaRKnWDMyxBSNq2tRw1RIgIiuSeNdcnO
         rbQ9y8V4pJQYkkCij4XJA+OY7Pu+WhpHATj4mhveiz1daZUvwHuqumns5q/8PdYw5JYc
         Z+mvcdWXFRWnQ08VGqdNY8gFP0sUQpJ4TioLukq6jIu5e03eO0qc21xf4IU88bhB9jiz
         00TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilg3wcyDSklsbMz1TOa+dWOz/hKRqF3HJGEzPGq8bYo=;
        b=xCAAn1uUVkKIZlfVm4iuj+YOc6wrzrX62WtqZGOld3qJzb/7thBXqcc2NXUtMYe7dr
         GB8wOlA5aGnqHBJT25Qw1Ok72ZqSHJbiHwG3aKHAhppZ2ThIs+LoPF5+uqmFG1MtafzP
         jD5STCqAgKptx+FpBDT6trrSU92EG2598q2erl5wFVhF7GKyT0+YRskLfKN3kx5YQYZD
         KfVOR0AoZmg5nvJbrWxHp20ZRmKl3pbB7mypxpAFdHy/eavc/ywiSasEyACvBYEu7imd
         8TD+uCRY+g+Qmn6pKRmSEacOo3kmVx41rCrn8MKP0Ujd+L3JnkdwTCyeEX0fkY+pPBpd
         teMQ==
X-Gm-Message-State: AOAM531UahSRWp3kmSZMSteQ2sdF5TFmpwpJzFyKJK0PuNuOei4x7uis
        SKNlHdbNrvzB+x1bt+jFTg8ec36nGXKMnNXzoFqM1A==
X-Google-Smtp-Source: ABdhPJwkqbqV0lH2o1ExtTdCA3sCWX+p1zKDtordwsnzyOYY3zAENjHRD7FY4ca6ZZrOHJYjnLZwxgjmf7cj18e5/T0=
X-Received: by 2002:a05:600c:19cb:b0:397:51db:446f with SMTP id
 u11-20020a05600c19cb00b0039751db446fmr29353291wmq.182.1654099223774; Wed, 01
 Jun 2022 09:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220601152544.1842447-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220601152544.1842447-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 1 Jun 2022 09:00:10 -0700
Message-ID: <CAP-5=fWTKLFuuDL6uCn1y3DrmDnq8zvReTpjZL+dW+eRQ8=MtQ@mail.gmail.com>
Subject: Re: [PATCH] perf evlist: Extend arch_evsel__must_be_in_group to
 support hybrid systems
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
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

On Wed, Jun 1, 2022 at 8:25 AM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> For the hybrid system, the "slots" event changes to "cpu_core/slots/", need
> extend API arch_evsel__must_be_in_group() to support hybrid systems.
>
> In the origin code, for hybrid system event "cpu_core/slots/", the output
> of the API arch_evsel__must_be_in_group() is "false" (in fact,it should be
> "true"). Currently only one API evsel__remove_from_group() calls it. In
> evsel__remove_from_group(), it adds the second condition to check, so the
> output of evsel__remove_from_group() still is correct. That's the reason
> why there isn't an instant error. I'd like to fix the issue found in API
> arch_evsel__must_be_in_group() in case someone else using the function in
> the other place.
>
> Fixes: d98079c05b5a ("perf evlist: Keep topdown counters in weak group")
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/evsel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index 88306183d629..ff4561b7b600 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -57,6 +57,6 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>                 return false;
>
>         return evsel->name &&
> -               (!strcasecmp(evsel->name, "slots") ||
> +               (strcasestr(evsel->name, "slots") ||
>                  strcasestr(evsel->name, "topdown"));
>  }
> --
> 2.25.1
>
