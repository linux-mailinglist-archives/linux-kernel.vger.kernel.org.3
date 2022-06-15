Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC6054D175
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346668AbiFOTRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350435AbiFOTRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:17:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59661114
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:17:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so1630380wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WokeiGFGpeZIK2Bw3DWQuKUULhCXjqLrynqg7U/lT60=;
        b=SR8MV78tyhTMqw+44nI1gbqZe6tkNSi0Rj7xc12dy+aizdKo3M5SAdht6mLxut5shN
         yx4N0cCwcXfCJ2W9DeH4ssJk+4gaeSzqg4GjzBg3eBikbvCDLQip6xFEb1q6wpps5oyC
         pvJw/tFvV2byPErT+TjA0SB3wbN0HTwTMhaOjSO9kQurO/JeIaUTCHr6cyzVMttjW4+a
         0WOci7LewHadYExXZp28c0T0MmPQnP6YXMEY9iuTf6QF8eCzETrwZ//jWdwItKsHGMLI
         sFAc3eMHO1whjw6ocS6rCUqlbWo6hGqBCcmfSXAO97qKq2V+nDC+bfioo46K+clSCKL8
         QuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WokeiGFGpeZIK2Bw3DWQuKUULhCXjqLrynqg7U/lT60=;
        b=fC71w8j2uNdkeWPQo91Lx3u0oaCak/7C8Gp1nsyuC3/hwLpIT2fLlPlSCdiCqDSVjx
         voZc51oCtCMDZfNzjxw0ECiGevpX2Xx30yBNP1HAvxjrdsc3IFZJy/iXH3fa4ZUehMif
         2hlc3fsvBUViDgEg4lKT6kOvPkApIVcFGvu4RQmFcOsp1UaOOIdpF8ipAMaYJ2+TNDxt
         9ZXMyX3ou5BN6UuXNI01bTN6CCxENDLHJ0qGdj75XvRzDcCFXRAT1GfoMPK2NFocB2Wi
         xzFhaimF9F8wGnezC8pOPxBLCuuYzD/rkO6VrtuSkxMZcOnFGuU+dAXrakouyBYgEvZa
         SEaQ==
X-Gm-Message-State: AOAM5314qXSkMVpLcUb30JlTXcZg4/tTGx14FkFRBUSmX+kiedpOc5Fa
        iHHWjNSuayVxRellogdiffeXeFCGiECLRLJmyt1a8g==
X-Google-Smtp-Source: ABdhPJworp9viXk/WHpCD25DR2nT7xNLuW+tVK3iCexh5gH5SOr+pUYNSn3Nx4OlVezubrtNQXnSxfYBfOgGsx/+yZQ=
X-Received: by 2002:a05:600c:19cb:b0:397:51db:446f with SMTP id
 u11-20020a05600c19cb00b0039751db446fmr11655881wmq.182.1655320647665; Wed, 15
 Jun 2022 12:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220615060354.1763693-1-irogers@google.com> <11db049c-c288-71c2-de37-545fd695d486@linux.intel.com>
In-Reply-To: <11db049c-c288-71c2-de37-545fd695d486@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jun 2022 12:17:15 -0700
Message-ID: <CAP-5=fVAUGMENJhD9d7VA9TbO1JOLJhisDPymJZgW0zr7WDXNA@mail.gmail.com>
Subject: Re: [PATCH] perf io: Make open and read calls more robust
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Lexi Shao <shaolexi@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:47 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 6/14/2022 11:03 PM, Ian Rogers wrote:
> > Wrap open and read calls with TEMP_FAILURE_RETRY in case a signal
> > causes the syscall to need to restart.
>
>
> Why not just use SA_RESTART on the signals?

As explained to Adrian, existing code is EINTR tolerant, some of the
code is in libraries and for portability shouldn't assume SA_RESTART.

Thanks,
Ian

>
> -Andi
>
