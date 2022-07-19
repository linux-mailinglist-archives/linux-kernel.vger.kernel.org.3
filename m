Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64735578F97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbiGSBKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiGSBKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:10:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DC333E27
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:10:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk26so19416866wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mF76Jxym5POPpvrVHlvQluQ/3ArQVFJV4oLbUeOUdyk=;
        b=oyu+jr+H1Gzb1ozjNbKR4TfuCEgyu2nID6ao2L85c63c75yXvNAOj1jAAIJrt7ATEz
         f3jGdoyO+igU9a0FH+7LadwoRC5QSaEtYshuxYrHRFd9MVJgwJpjM/WncagyCFot8Vlf
         5Tj5EUj5BN92fssH1pg4psybTX53y/IRorka2A49CKbOKZggdKjmB5q13OWsN4FaaIga
         33Os+kedW/CT99NGRVliE+WL18w52QSb8A5oR8kpULOgIjptu2+Wm6HZUxWrh4ozpzal
         m/1ocFAko8TM1tRy/63zGoLJIe9nl2wJclcGM/pRU31bQxDj3NM9TKFyt4JEeO2q9jIo
         5t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mF76Jxym5POPpvrVHlvQluQ/3ArQVFJV4oLbUeOUdyk=;
        b=33P5j06FZd33fSonJObO+9Po64E4T3BGRb8kFiW1wL6EBxrEU3wRvZ3rpRm/Put/pi
         KxsLalWYWgOz3RLdi85ciQOSv9yZaU/XzAkGvxYkKPX1ZmgQRIsgnajf+TUHcxmfqfox
         r90pJcWWcp67z8zeySUVd4dl+49xb2NlIiyg843XKe7PZ2dgkzDUsdcFpmTA3MRubyW5
         xAEb4DgBaJS4B9nAkXCTG8q/kUt1lKQnCtQ/POWOpmP+qGYo2ozUWUxW5GtoflpDj0sc
         ka4zytcE1IpV9kPNfPl+zt+IL00N70PQVAq2A8MIQ7/sJF5jE1k58w5HVgGG1WiLj/zU
         cubg==
X-Gm-Message-State: AJIora9roxFiY61pzZ66FIa+5NOXJrvmaHZH6Q/KkHT4ywv63XqLm+Lt
        vkfQ5i9zlbTaqGJxAbcF05RmYOAkFbxeDQpkhojyDSMIZbaQ4w==
X-Google-Smtp-Source: AGRyM1tOWzDpLlZq6Gf6S9nRMfEEOvc3xh8P08oLOi4FgjA8NALe2OMj7Yen+pp0gkMIQ4Ynh0VpvGPGnvLqfyRMQb4=
X-Received: by 2002:a05:6000:8e:b0:21d:7e97:67ed with SMTP id
 m14-20020a056000008e00b0021d7e9767edmr23920104wrx.343.1658193036525; Mon, 18
 Jul 2022 18:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220712112824.28770-1-adrian.hunter@intel.com> <20220712112824.28770-2-adrian.hunter@intel.com>
In-Reply-To: <20220712112824.28770-2-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 18 Jul 2022 18:10:24 -0700
Message-ID: <CAP-5=fUaDsuYxQRkqWFThX3Su2me-caXxdQqJd0WH-dx-yRaug@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf parse-events: Fix segfault when event parser
 gets an error
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 4:28 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> parse_events() is often called with parse_events_error set to NULL.
> Make parse_events_error__handle() not segfault in that case.
>
> Fixes: 43eb05d06679 ("perf tests: Support 'Track with sched_switch' test for hybrid")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/parse-events.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 7ed235740431..700c95eafd62 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2391,9 +2391,12 @@ void parse_events_error__exit(struct parse_events_error *err)
>  void parse_events_error__handle(struct parse_events_error *err, int idx,
>                                 char *str, char *help)
>  {
> -       if (WARN(!str, "WARNING: failed to provide error string\n")) {
> -               free(help);
> -               return;
> +       if (WARN(!str, "WARNING: failed to provide error string\n"))
> +               goto out_free;
> +       if (!err) {
> +               /* Assume caller does not want message printed */
> +               pr_debug("event syntax error: %s\n", str);
> +               goto out_free;


It feels like a simpler invariant (as done elsewhere) to have the
caller always pass err and then in the caller to call
parse_events_error__exit. Any reason for behavior change?

Thanks,
Ian

>         }
>         switch (err->num_errors) {
>         case 0:
> @@ -2419,6 +2422,11 @@ void parse_events_error__handle(struct parse_events_error *err, int idx,
>                 break;
>         }
>         err->num_errors++;
> +       return;
> +
> +out_free:
> +       free(str);
> +       free(help);
>  }
>
>  #define MAX_WIDTH 1000
> --
> 2.25.1
>
