Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC53563CA8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 01:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiGAXGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 19:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiGAXGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 19:06:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BC36EEB1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 16:06:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k7so5107406wrc.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1B1PddGTFrs/U46LbISSKfXwRw3hwTHsrh1nOCkyZGM=;
        b=MwtHdmBTB8lfuO9wkWlKJj+Br1ms52PTcDsN5cQeoaOAaeGV/UAB0QIPKCip8L4RZ3
         8PjN+g1lN9q2ztsjpR02DmhQrMqjZHFKGMA/5pzC4AQmBr/bhXt5eXvKOKx2jjZrF1bx
         G9CrxAbgZ/cYYKbj09GnMy3FW/YCOVcomc9tev0xOnaM7mUcQ9pnhb+0LrI59v1UmIMp
         bie8l/RVReNL7eNCq98z5OlBA15gHQSrF6BuSGBzy8BmUnDirhFokX4LaaFNbD94NStm
         M6999INanbFvt1UuzaJMfZqiCh/wHiUEnyF0d73SvwvL13jwVQBJ42lINdUoUZWZwDV1
         l3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1B1PddGTFrs/U46LbISSKfXwRw3hwTHsrh1nOCkyZGM=;
        b=T/ATxfog3z4wnAiG+qfk3lNGw2EVmUn8E8NVYc/zoMpOGi2HB+aXGvYUvoXYUANgTO
         9r2rRCHBpFaCqsgneriIXVNNUMVNy/lgVOtDwocdS2BRngEQenksx8zksbqacXZdd3Oc
         RggJraxeWeNa384CzA4jANkFxU0LrDqCN/Gmb9YW8KycMoWVrXwPNvxjWqxaB2CUcRsZ
         Y/gMIrtmKXLWtuBDg5FQh14Avi9eQyI9rbkhR1ipQtgSUjk+/Da2cQMMnwNGU6fBS+PB
         jPLjQMARB9yTvSvHhJ2FfgHdOvc7l0vp8JtCJX2rcSJ2iqBbVZHuEpTemZ2dfH6FCgoF
         kAJQ==
X-Gm-Message-State: AJIora+OLG1fCJgUulApNjiZ8C9u/KRCrNDRMTxvuLUUtyADwpevDQCX
        RANT82dTw381WozjCG95dWQUw+ym8sCqFQLD7gbO4g==
X-Google-Smtp-Source: AGRyM1tWpZix666JECrwCJowa6y3s9TWdxowxhr3qwkxiglqa7ZfYZIXog7jepaIxJ46KpT5De9W/q/nnphGp8jK8DA=
X-Received: by 2002:a5d:5983:0:b0:21b:b7cb:f84e with SMTP id
 n3-20020a5d5983000000b0021bb7cbf84emr16345581wri.654.1656716796220; Fri, 01
 Jul 2022 16:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220701205458.985106-1-namhyung@kernel.org> <20220701205458.985106-2-namhyung@kernel.org>
In-Reply-To: <20220701205458.985106-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 1 Jul 2022 16:06:24 -0700
Message-ID: <CAP-5=fVwkXcKopw--chdtjsX1D0MnXOXYjqgi-xx0_Zxk6bC=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tools: Ignore dead threads during event synthesis
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

On Fri, Jul 1, 2022 at 1:55 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> When it synthesize various task events, it scans the list of task
> first and then accesses later.  There's a window threads can die
> between the two and proc entries may not be available.
>
> Instead of bailing out, we can ignore that thread and move on.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/synthetic-events.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index a068f42833c3..84d17bd4efae 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -767,11 +767,12 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>                 if (*end)
>                         continue;
>
> -               rc = -1;
> +               /* some threads may exit just after scan, ignore it */
>                 if (perf_event__prepare_comm(comm_event, pid, _pid, machine,
>                                              &tgid, &ppid, &kernel_thread) != 0)
> -                       break;
> +                       continue;
>
> +               rc = -1;
>                 if (perf_event__synthesize_fork(tool, fork_event, _pid, tgid,
>                                                 ppid, process, machine) < 0)
>                         break;
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
