Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4653997D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348412AbiEaW3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiEaW27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:28:59 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1559D4F1;
        Tue, 31 May 2022 15:28:59 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id r206so292123oib.8;
        Tue, 31 May 2022 15:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfymB8KAQ+Zl5PoZYuqQLPBgrCOtDUvUXsEYVsIlQ58=;
        b=2LoFmw4MNvjYLJFC4ohipRtTzX6D8pFOLCDPT+zNI9SvX4XwL37p1tz/j/ndU9nkYp
         6amquKW28oe1w2lYk7Gatahcnp0t+71sTyjJqL2Me+yMKfGp/1MgftaE+YHkE6EdABi3
         pOZ4KyOOBRza2LyAjN7Jbc0efGxay0zN7sRAUsQ/QRfGhg8Byif78hWveokOL6I9vbdJ
         ONpUC5NRWfvuu35pJgFQ4G82AlTc7m/lEnexG1F7TJ1DpMTTMIBQHo6uyBpqw2GzOt+X
         HMEBGDrCjeEhzLsOusqmwtd0knAW2UZtpxuI9fVMTYziNN6Tig0ZIzCRXh1xDSDfb8cf
         nETQ==
X-Gm-Message-State: AOAM5306WbXWWWuW7RT2IL2cQrGYFzMlc8abYCL6lb80T5GBh+YE6HHg
        DMP2xkCRH0gMIeKh2hAN8ildAQBfFw2Yfbk/9PU=
X-Google-Smtp-Source: ABdhPJzTqu0gyPGknMUQkh8R5tilqESCLhH1OOW85Db2VuLYyg8UO1lll35gMUDz0B2TNr8tiepKTS6bOVvSJNvD6b4=
X-Received: by 2002:a05:6808:16ac:b0:2f9:52e5:da90 with SMTP id
 bb44-20020a05680816ac00b002f952e5da90mr13678259oib.5.1654036138375; Tue, 31
 May 2022 15:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220530084253.750190-1-leo.yan@linaro.org>
In-Reply-To: <20220530084253.750190-1-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 31 May 2022 15:28:47 -0700
Message-ID: <CAM9d7chw2Vv5D18rOBqDdBPydKpv_c9F1MC+ynAXzS3MG-Fz=A@mail.gmail.com>
Subject: Re: [PATCH] perf c2c: Fix sorting in percent_rmt_hitm_cmp()
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
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

On Mon, May 30, 2022 at 1:43 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> The function percent_rmt_hitm_cmp() wrongly uses local HITMs for
> sorting remote HITMs.
>
> Since this function is to sort cache lines for remote HITMs, this patch
> changes to use 'rmt_hitm' field for correct sorting.
>
> Fixes: 9cb3500afc09 ("perf c2c report: Add hitm/store percent related sort keys")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-c2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c8230c48125f..e8280973d7b8 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -928,8 +928,8 @@ percent_rmt_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>         double per_left;
>         double per_right;
>
> -       per_left  = PERCENT(left, lcl_hitm);
> -       per_right = PERCENT(right, lcl_hitm);
> +       per_left  = PERCENT(left, rmt_hitm);
> +       per_right = PERCENT(right, rmt_hitm);
>
>         return per_left - per_right;
>  }
> --
> 2.25.1
>
