Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE15B0BEC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiIGR7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiIGR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:59:11 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A097B3B01
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:59:10 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1279948d93dso18143915fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GbavFTFU4L0uXKtn6YhdGKJMfAL+BfJ4k47UZk2Az6g=;
        b=IlLIYkwsQSXv0AnV7ChONxbWajZZBoadsdHGfKcJY7u0kC7pJHy6HBlTAJ3mW3vSae
         kJXtlHh4Q+Cnhqq+eQOY4z8k0yOmyjznJOICb1hEmcCp7CilgwK3EsuTwfIbK13W3THU
         sde2BVOWhHozvxIYH2SqDc42Ur/hoT1Gix6+163ksVUvbCp5cDJZSZ3vNEbqUVUXM4p2
         Bf1fOw0z5TISLs6dgWKSdi4s7KUOWalE1hK0d0HUu8Yg99Z8ZQlMUfKSXMxh7PWDJpZI
         em2TfpdrtcPbcYpbQHxWRSLBpD4eFzLSfB/q4TOfCrQTWe+lYRLNK/vjfdaoVKYrYrtJ
         VjmA==
X-Gm-Message-State: ACgBeo2b1lE34VXd66BuMizAdpp1uYs8lA2Y6LuvPDReocs5uBvol3Lm
        wCOG7YwlrOYCKHplXBRh7QgbiCOrRtPADo8w7k4=
X-Google-Smtp-Source: AA6agR7VAHqZCVKFOxiwEHpIgCRC1OAL6UqMkGpwlIOrEsoOdz2T0XYcQejSAXl6eZoryX0aHsjupjDaTRMWC781/xA=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr2506109oab.92.1662573549274; Wed, 07
 Sep 2022 10:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220907162458.72817-1-adrian.hunter@intel.com>
In-Reply-To: <20220907162458.72817-1-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Sep 2022 10:58:58 -0700
Message-ID: <CAM9d7cj=yyfmCRfEVvp7kCHRE8cTEkRFf_unThde2kNoo-x+GA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix synthesis failure warnings
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 9:25 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Some calls to synthesis functions set err < 0 but only warn about the
> failure and continue.  However they do not set err back to zero, relying
> on subsequent code to do that.
>
> That changed with the introduction of option --synth. When --synth=no
> subsequent functions that set err back to zero are not called.
>
> Fix by setting err = 0 in those cases.
>
> Example:
>
>  Before:
>
>    $ perf record --no-bpf-event --synth=all -o /tmp/huh uname
>    Couldn't synthesize bpf events.
>    Linux
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.014 MB /tmp/huh (7 samples) ]
>    $ perf record --no-bpf-event --synth=no -o /tmp/huh uname
>    Couldn't synthesize bpf events.
>
>  After:
>
>    $ perf record --no-bpf-event --synth=no -o /tmp/huh uname
>    Couldn't synthesize bpf events.
>    Linux
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.014 MB /tmp/huh (7 samples) ]
>
> Fixes: 41b740b6e8a9 ("perf record: Add --synth option")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-record.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index bce8c941d558..7713246a393f 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1974,14 +1974,18 @@ static int record__synthesize(struct record *rec, bool tail)
>
>         err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
>                                                 machine, opts);
> -       if (err < 0)
> +       if (err < 0) {
>                 pr_warning("Couldn't synthesize bpf events.\n");
> +               err = 0;
> +       }
>
>         if (rec->opts.synth & PERF_SYNTH_CGROUP) {
>                 err = perf_event__synthesize_cgroups(tool, process_synthesized_event,
>                                                      machine);
> -               if (err < 0)
> +               if (err < 0) {
>                         pr_warning("Couldn't synthesize cgroup events.\n");
> +                       err = 0;
> +               }
>         }
>
>         if (rec->opts.nr_threads_synthesize > 1) {
> --
> 2.25.1
>
