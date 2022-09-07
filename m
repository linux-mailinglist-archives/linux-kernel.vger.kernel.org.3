Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18B5B0B9C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiIGRkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIGRkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:40:16 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3273D599;
        Wed,  7 Sep 2022 10:40:15 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1225219ee46so37924377fac.2;
        Wed, 07 Sep 2022 10:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+gVScQXzAqu1X/yvBboZKpd5faWe8XGejd9XaZgKwNE=;
        b=gcpHcTZx/uP8/dtJfZHZZPw2XbUOyQMEluote8/rLLGqeTe+2k+Xuo2R823y3Vh37Q
         iwJ4uJ7mQWnC9FHQgit/6y4y/q0HSETlEKd5kTfjhOvQUS2Mu62RzJRBVT/M9UYzR038
         TM/oYdR5rjhPY3kBkiLgudp0KzQxG/YO7Zu3cAlRQcMviUV+LYswJgAaAqstgTU4cMU5
         Tbc5hja3d2G4E34XdZ5ILtzGbJQVZf7NslHmkfvvA3Y5rmwE+u+6iWzkdSmPxzWMWhup
         7QKC6yPFUIS4g0RyENG7spQ/cA5W+5ZaPD3P6AiaDkEMIqTsUq5UuYEid8Klw73GQCsw
         mXUw==
X-Gm-Message-State: ACgBeo1QOo/sGuwaxHr38f12mGHlRnrWc/G6npknsYp9C5tGw0rO43wG
        KpsWpGA0FTvCtkozBbuLCHPZ+wAClvIapMAHq/E=
X-Google-Smtp-Source: AA6agR4B5R+jFbC2nM0t6sVnfjDaKxy2xrSLzk+D8IvSa8y1WTjdSFkgsm6+p/hDlzFvyNEGfdYLEQB3d1MUlm94N+s=
X-Received: by 2002:a05:6870:a184:b0:116:bd39:7f94 with SMTP id
 a4-20020a056870a18400b00116bd397f94mr15313977oaf.5.1662572414992; Wed, 07 Sep
 2022 10:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220907064645.1197894-1-namhyung@kernel.org> <20220907064645.1197894-3-namhyung@kernel.org>
 <a2d9f1f2-cf8b-4ef6-7114-52e5bdf22e70@intel.com> <0deaaf68-c92c-0fbc-4c5f-4078d4f1f15a@intel.com>
In-Reply-To: <0deaaf68-c92c-0fbc-4c5f-4078d4f1f15a@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Sep 2022 10:40:04 -0700
Message-ID: <CAM9d7cjT_eAA4tqDPHTZQYYn7UemJqPbKUUkc8ceyvuQhfD-dw@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf test: Use a test program in perf record tests
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 6:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 7/09/22 16:16, Adrian Hunter wrote:
> > On 7/09/22 09:46, Namhyung Kim wrote:
> >>    if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p \
> >> -    -c 1000 --per-thread true 2> /dev/null \
> >> +    -c 1000 --per-thread ${testopt} ${testprog} 2> /dev/null \
> >>      | perf script -F ip,sym,iregs -i - 2> /dev/null \
> >
> > With the kernel patch:
> >
> > https://lore.kernel.org/lkml/20220711180706.3418612-1-kan.liang@linux.intel.com/
> >
> > I get:
> >
> > Samples for 'dummy:HG' event do not have IREGS attribute set. Cannot print 'iregs' field.
>
> We seem to need:

Yeah, I think we have a discussion already.

Thanks,
Namhyung


>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 13580a9c50b8d..959291903936a 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -411,7 +411,7 @@ static int evsel__do_check_stype(struct evsel *evsel, u64 sample_type, const cha
>        int type = output_type(attr->type);
>        const char *evname;
>
> -       if (attr->sample_type & sample_type)
> +       if (evsel__is_dummy_event(evsel) || attr->sample_type & sample_type)
>                return 0;
>
>        if (output[type].user_set_fields & field) {
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
