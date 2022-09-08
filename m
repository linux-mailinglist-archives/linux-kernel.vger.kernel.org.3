Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C4D5B153C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiIHG7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiIHG7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:59:45 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3C6B1E2;
        Wed,  7 Sep 2022 23:59:39 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1278a61bd57so23465634fac.7;
        Wed, 07 Sep 2022 23:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PL5sFutse4CuxEfTtpSy/YygDoAtPS3qoXDa8gawEm8=;
        b=AJ5hPhg4/qg9iMKZvpW+NcKUjXT5JPU4T1ss3T+By2VzK3BP+PbWt4JwaP8Lmhkbb0
         pqG4CedSfKj1SyXpCA2vFjsYvZIF0j5iCzKdULZJkZBQACvoKM+2YFKOpiKb0LoRw5ml
         AUPIJckFHSjANi/cPYL8GUfrLHUlveNx9KR1MDwxyOLuk3BOSM5rYMVZX4mM2CdnDZRk
         NYjO5zN2t07DHnlrDju9FDKwJJuwb6EKT6GImR1uIxQ0EtBOlXzQwkcr4HG3l8KC8oCj
         z2z30S0C/PvSH6xTOMeA+Bvc1/DeQHIxDUpiwNyJfcZ+toMuEOSBgahMg9YysOeq4iE3
         fsRw==
X-Gm-Message-State: ACgBeo3f3dBjQiFipb6MWEI53vYZACDEBB24RHyMg81wxX+cf9faO2nA
        kf8VTLwMIBHWNU8lOB6OGNpp9uL4UvW8SH3JD2Q=
X-Google-Smtp-Source: AA6agR77tCrqb7/HX1SoQqqTfvx/HEve3UlERGZqx3jX1p5BWKbmxqvSBEnIV9yuTVXek2CF/RW9hkoJYJqdEhlzt5c=
X-Received: by 2002:a05:6808:302a:b0:345:ec04:8f11 with SMTP id
 ay42-20020a056808302a00b00345ec048f11mr851693oib.5.1662620378888; Wed, 07 Sep
 2022 23:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220908014854.151203-1-yangjihong1@huawei.com>
In-Reply-To: <20220908014854.151203-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Sep 2022 23:59:27 -0700
Message-ID: <CAM9d7ciPd4vf3v1rdOD43vR-bh0pjj1LCcrMVTLfH6Fcxx_Dsw@mail.gmail.com>
Subject: Re: [PATCH] perf lock: Remove redundant word 'contention' in help message
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hello,

On Wed, Sep 7, 2022 at 6:52 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Before:
>   # perf lock -h
>
>    Usage: perf lock [<options>] {record|report|script|info|contention|contention}
>
>       -D, --dump-raw-trace  dump raw trace in ASCII
>       -f, --force           don't complain, do it
>       -i, --input <file>    input file name
>       -v, --verbose         be more verbose (show symbol address, etc)
>           --kallsyms <file>
>                             kallsyms pathname
>           --vmlinux <file>  vmlinux pathname
>
> After:
>   # perf lock -h
>
>    Usage: perf lock [<options>] {record|report|script|info|contention}
>
>       -D, --dump-raw-trace  dump raw trace in ASCII
>       -f, --force           don't complain, do it
>       -i, --input <file>    input file name
>       -v, --verbose         be more verbose (show symbol address, etc)
>           --kallsyms <file>
>                             kallsyms pathname
>           --vmlinux <file>  vmlinux pathname
>
> Fixes: 528b9cab3b81 ("perf lock: Add 'contention' subcommand")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks for the fix!

Namhyung


> ---
>  tools/perf/builtin-lock.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index dd11d3471baf..ea40ae52cd2c 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1874,8 +1874,7 @@ int cmd_lock(int argc, const char **argv)
>                 NULL
>         };
>         const char *const lock_subcommands[] = { "record", "report", "script",
> -                                                "info", "contention",
> -                                                "contention", NULL };
> +                                                "info", "contention", NULL };
>         const char *lock_usage[] = {
>                 NULL,
>                 NULL
> --
> 2.30.GIT
>
