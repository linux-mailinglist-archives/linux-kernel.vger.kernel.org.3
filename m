Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D8853564A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348637AbiEZXFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbiEZXFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:05:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B941758C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 16:05:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso3632657wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+I9hUAJO0j4a5c/GJGmruQaMqz4ZWAD5gZXhmzliwZk=;
        b=J8QrwSxUZ0Y7ODCts54yutQBOc73SmK5IYpXH3ICitGPXNDjHRlGpHmDf8l3SuhXKz
         SN7RxuVMpmhvcJsEqXfH3Uv0hdEaAi3AU8Nd+ilR8AGPFH2zRUnDJgFqNb/jYdNacU8q
         GpjrJ3nJL6NN2XdQHIljDtvJ62Shi4brLJOGCA5dk39AcJRYM1YINhrM7BxjOxpbyZfr
         LzXVH4kEq7JsaEqgR19tVJvGUnCYDIkHgX5no7h4kWGG14DxfW3Ust4DXew3aNK3zqgd
         u8U1ZS6Qs7azv+Qv3ErS74Bj4F7Yd26BKzsh+rtaCWpzgH5LbKD4LzcDw5Q8CFCno5gm
         DcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+I9hUAJO0j4a5c/GJGmruQaMqz4ZWAD5gZXhmzliwZk=;
        b=FUj6TTA6AziDn42yHnu8OkJGZoUSaz278d5nOkMGugp7C/ZQYSpp6zL9uwDbh+U6J7
         7sgKKdCPWPSpfVH3CUBbjMmhq478BLGA7NslUBNC9lgfqoNJ8ZnVvXOyT+8IcCY5l3Sh
         Qe99bGic+GZPWTadtOEMzC87G2OLzZccQwhpZW2FAg6341lpmVg5LXtjERjHxMqOC0BQ
         M7WKUTE4q7rVICIPa+0ezcHx9FPf/x2WczVRIP6uuo1rfI19qXxD3qw9dGkcacg56re/
         47dVT0+oo+pTIE6ViVzRw0dCbajvagWhm9teGwlLvDk/k3ieqi/Q1nBQP54v3tKW+puv
         zkHA==
X-Gm-Message-State: AOAM532hC2uSqddx5NEI2qk8VuQ5NAN4LOhxiB9xWUQbVy0qqTqRdZ3g
        j1qpwbK5sOpfaB0hZw85W+l/ErknQFQ2TJkSHOhFGg==
X-Google-Smtp-Source: ABdhPJwO46jPvSXUkurSbGSLyLEeo/2C/lV3l3eEc34OFVXrkgIBRP8Z90Nn6u2PSBqrAbkfg9eKLzMeBT4jF7iuRws=
X-Received: by 2002:a7b:c015:0:b0:397:3685:5148 with SMTP id
 c21-20020a7bc015000000b0039736855148mr4290330wmb.174.1653606320753; Thu, 26
 May 2022 16:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220526213136.193404-1-namhyung@kernel.org>
In-Reply-To: <20220526213136.193404-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 26 May 2022 16:05:07 -0700
Message-ID: <CAP-5=fXk35KSaNOSsymx=2=Yw5CG7=Rr3X0aRCFaTggfhts7dA@mail.gmail.com>
Subject: Re: [PATCH] perf lock: Change to synthesize task events
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Thu, May 26, 2022 at 2:31 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> With -t/--threads option, it needs to display task names so synthesize
> task related events at the beginning.
>
> Fixes: 7c3bcbdf449f ("perf lock: Add -t/--thread option for report")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index b1200b7340a6..23a33ac15e68 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1083,7 +1083,7 @@ static int __cmd_report(bool display_info)
>  static int __cmd_record(int argc, const char **argv)
>  {
>         const char *record_args[] = {
> -               "record", "-R", "-m", "1024", "-c", "1", "--synth", "no",
> +               "record", "-R", "-m", "1024", "-c", "1", "--synth", "task",
>         };
>         unsigned int rec_argc, i, j, ret;
>         const char **rec_argv;
> --
> 2.36.1.124.g0e6072fb45-goog
>
