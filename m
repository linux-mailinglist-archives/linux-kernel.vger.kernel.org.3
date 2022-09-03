Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B925ABD8A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiICGwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiICGwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:52:39 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A5EBB6A3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 23:52:38 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-33dce2d4bc8so33483387b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 23:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ReE86CAuXFmaMHJ7YOUAJHviWpFsT5ozIc0Vr/5is54=;
        b=eFWMH5qnQtV84oUmcsyzFEuWFg1a1ann3d3GfyO1fKAPei7VpCFvt3PEKfE/LWBD2/
         Pj0IwkfG+2UrAk+Zq2lM3COEfUfFcFCL7RYZ8nVuQQVQR9g4fxfif/tAASgmZvNSwy5z
         Y5sDf66a6OFuM+7OPgHzMT8Vh6WqMdzYtjmRyUVf5YOYizLf6W8vQPfS7XALBBy/W9su
         Z79aaLmYlUpfGtB+Cy1bI/PK7gDqEsmkPIwZLw3aKLtCIw/0Q98W6ps9rMgv8UCULCYK
         HJ//3s87yITwqRnqEvMGVO5eUlnL9CUtmH25yMPL+B7zcobtXx6W/ibisQxa5Qiip/0D
         5Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ReE86CAuXFmaMHJ7YOUAJHviWpFsT5ozIc0Vr/5is54=;
        b=5MUTINJY+Z4Qby5IhIbkh0HPFZU/h0h7Iij3Tnchju1Dtt1XVWVM9wNNBvPUYJFMDw
         T18yFwC9BD389JxpqophXLQf1P1kSK706pNgeumpeQc/JAq9IB8pprD8hKzSKSAHvxHc
         bSfv2cnX9STn3bQL6RHEzOkN004EyaO99by0yLiKyxVC0EW3ySbBRnd6E8k4MBLRCUE1
         uYONLss/FSU9oqa3wX6TXH+heDe7YS5heNFjIOzY7JguAvzEibu+U+fkX20hahQuxAA1
         EIAMJGsUmBGDg0jHQ6Ok10yEbYhVG6wAtY61ysiUPOQYPAh2Ag0+PowKQ52jhyiyWnxx
         fWbw==
X-Gm-Message-State: ACgBeo2XBKdhWg7zjY/Z64wvID/AW5VMVbNhv4ssqb9pKWR8bIPMquQR
        1kyVSb8P7dzZkqDR/FW/gFw9/+vA3Ydl8wuu82H0+Q==
X-Google-Smtp-Source: AA6agR5NLwbY37rIKDr5iizkgRfVc6QFlkp9VsnBMmmRAefLTFJUEUrxxvWaur/K+fvnqZ3yhMeQo3IQUNJX6X0GBnI=
X-Received: by 2002:a81:6808:0:b0:345:be:890a with SMTP id d8-20020a816808000000b0034500be890amr3134610ywc.267.1662187957704;
 Fri, 02 Sep 2022 23:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220903000210.1112014-1-namhyung@kernel.org>
In-Reply-To: <20220903000210.1112014-1-namhyung@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 3 Sep 2022 08:52:01 +0200
Message-ID: <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip sigtrap test on old kernels
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
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

On Sat, 3 Sept 2022 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
>
> If it runs on an old kernel, perf_event_open would fail because of the
> new fields sigtrap and sig_data.  Just skip the test if it failed.
>
> Cc: Marco Elver <elver@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/sigtrap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> index e32ece90e164..7057566e6ae4 100644
> --- a/tools/perf/tests/sigtrap.c
> +++ b/tools/perf/tests/sigtrap.c
> @@ -140,6 +140,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
>         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
>         if (fd < 0) {
>                 pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> +               ret = TEST_SKIP;

Wouldn't we be interested if perf_event_open() fails because it could
actually be a bug? By skipping we'll be more likely to miss the fact
there's a real problem.

That's my naive thinking at least - what do other perf tests usually
do in this case?

Thanks,
-- Marco
