Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3178250195C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbiDNRCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242764AbiDNRCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:02:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F6AF8EE0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:36:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p18so6866365wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96fPVlK1lXCKBQ9aNMxEudacOmbrFnF0Sxztpz1AWoU=;
        b=EPw8JEdoNFQdsqEx7a7hmQ08Cs1rfhEj7w+ySyqPbuSO1S5mV8ukQraAaasWq0v8lP
         aK08wFxpPBwxUi4O0pBmL0nfnE0a7gF/xgbNGXth5IyIZsSjIKeoGCSJRLduP8XsPCIc
         4O1ogodaUb4b0xhYtL+g0KDF7i0524YPvQlsAyEwx94+s/Oscu49ssE9Y6v3DDZUa4Ht
         bMz6qLb9SDffuASIalPuP0vz6nQwNWCFz/c4giXJHUucdlEimILTHs81OzCe0VZDKeRN
         osMIY9ybQ0ZOW02ob9V7BN8eFJVLHPu2+EsjP/idFrcz+wQga4AF5TW9oUWOcQdTCejq
         loPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96fPVlK1lXCKBQ9aNMxEudacOmbrFnF0Sxztpz1AWoU=;
        b=ErOiMEq67iPd3WoD4jxRqZZ7gFKBeKY5E8185t8rcpYRtd8U300CkS4PtGkVovqJDc
         Bujbq4xLL/JRhLv6he3pAUFrpTzuZY9a2QqAX1BZGT2SrxeigzjXCYGHvTfiqxh6KEJG
         ATp7xP0YBba0lA9bxpRKxiH5UOs/8UKXHx7nG/0eB5j9M1izNDi9iMMdYas2T3bO7PKY
         hxwO0HNHMNU/Rz1NVXGsHW3bmP/N809gQKvuV+LdxoIS9636C3g0Z+w41RvJe/alB4LC
         eaUIFvE+iShZlnh47P0ytsRfytmP4uomilWVB/7M1YW1V/EMvIN0h1k1Xek2fD1INmlA
         j0nw==
X-Gm-Message-State: AOAM531FLg1Dmpi9rZTpXJ7TwF+EnbXoE5gAZVnoRYh/4VU6xaPArxPs
        1tQ4KMO1z++qp3hXj6iUj2+C7O62BTGrXQgbmaO8JA==
X-Google-Smtp-Source: ABdhPJxEk+6D4NBT2CYxRaGZ7sXfhIacfcv8utIq7A/mgOQxSO2+t7qGxwQcsrTbLSwHEmAgkbMvs8agbLDYyVZAt0Y=
X-Received: by 2002:a5d:6350:0:b0:207:98d5:9bcf with SMTP id
 b16-20020a5d6350000000b0020798d59bcfmr2735752wrw.40.1649954204199; Thu, 14
 Apr 2022 09:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com> <20220413210503.3256922-3-irogers@google.com>
 <368c5b92-f035-41cc-96a8-4908f1325462@linux.intel.com>
In-Reply-To: <368c5b92-f035-41cc-96a8-4908f1325462@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 Apr 2022 09:36:31 -0700
Message-ID: <CAP-5=fWpECOtC8jc6up4LRFon1v0DBN1Y6LJsimEtuPfXcvJuA@mail.gmail.com>
Subject: Re: [PATCH 03/14] perf vendor events intel: Add sapphirerapids events
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Thu, Apr 14, 2022 at 8:03 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 4/13/2022 5:04 PM, Ian Rogers wrote:
> > Events were generated from 01.org using:
> > https://github.com/intel/event-converter-for-linux-perf
> >
> > Signed-off-by: Ian Rogers<irogers@google.com>
> > ---
> >   tools/perf/pmu-events/arch/x86/mapfile.csv    |    1 +
> >   .../arch/x86/sapphirerapids/cache.json        | 1083 ++++++++++++++
> >   .../x86/sapphirerapids/floating-point.json    |  218 +++
> >   .../arch/x86/sapphirerapids/frontend.json     |  471 ++++++
> >   .../arch/x86/sapphirerapids/memory.json       |  415 ++++++
> >   .../arch/x86/sapphirerapids/other.json        |  329 +++++
> >   .../arch/x86/sapphirerapids/pipeline.json     | 1271 +++++++++++++++++
> >   .../x86/sapphirerapids/virtual-memory.json    |  225 +++
>
> Thank you very much Ian for the patches. They all looks good to me.
>
>      Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> BTW: I think the uncore events for SPR are also published in 01.org.
> Do you have plan to add them later?

Thanks Kan, we need to add the csv file to the github project to make
this work. I can make a basic one if that works?

Thanks,
Ian

> Thanks,
> Kan
