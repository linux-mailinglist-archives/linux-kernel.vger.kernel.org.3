Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F74539A00
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348660AbiEaXSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbiEaXSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:18:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4849B712C9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:18:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e2so48062wrc.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRyMk+Q6nFripHUkwYzBEVo5OLNNL8RHhRGhadNuFAU=;
        b=ZGBDa3EuRBaYGJ4gg1MjnYswFFIWvsWMvvcw+7tZ5KlNyVMsdA4tLBTaRWZRXVoB5t
         3WeyHiTygg2bxxV214rs0c9sd6ioAqIc5eVfhUMSOW5gFmE4V2RuYX5RHdQB4dTj6WqW
         zDJ0tzn/AP+W7gs2iyYGYmclYf/E+N26CF1FQm4Ztrl36IuhzwV8FLrN4T67Yc4v8prx
         xYeaKoKQaq7Ps8dz2cQ0lGKf12xnxror+nmhZ1h2vjtyV5SdPdDxPmV1r8rjT9xZOFWx
         RVaU+o5gQO229dvOp+ec3Uu0XdiXSb0aK0+Ts+C8RsWwfxvBH1LpZ9J9l6w+ACWP+rpf
         HNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRyMk+Q6nFripHUkwYzBEVo5OLNNL8RHhRGhadNuFAU=;
        b=lnXzbQXbhjzp6KM7c8rOf44DAKj9zHwzPvrEsNzgv+VWyJztXUyFp5jdNK0TzbXz1Q
         uBVKZgeQmIfHHN5XvwXaAy7N09z/o7s+jx2eJdgSE5N/JliBDKgD2owHLb17daLPWLo0
         i6wLKW+vAEPe+aFm1qeHgnnDgTFDuGTiJPWWayTkR5tk1LMweBlMLzBE8SxuV1oP88mL
         CIB/UBao+YH+onPwB/2J4YQZOmGs7d5r0kleqBFlggGnlJX7F1mrnFZkWMlDDZLw3UiM
         JA96ENvKxq7WzlJcNJBsu73AydB/RouBVz2TxLFcDy0VRdy/LVszEXk3pltN3IZ7owi4
         q2qw==
X-Gm-Message-State: AOAM531UQV/M8JKVkBimKaS2eHSb+6D82AiBYdr+MMN6XnQI+vyWNV+K
        38/eRSJK+L2rsk2K2lB2UW6F1MHkHRGafXogSoA+VQ==
X-Google-Smtp-Source: ABdhPJx7J+5sVQEHLn65AdSYxEgsPuV+2WTc6LjsDQQLhS5QnnY/r+H2A4YaE2NX1JvdlPqLOjXF7fnw9q1YvmU19XY=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr52723432wri.343.1654039118562; Tue, 31
 May 2022 16:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220525053814.3265216-1-irogers@google.com> <20220525053814.3265216-3-irogers@google.com>
 <CAM9d7cgA4fr3G7wjpaTKyEPF1JuAsQO-Ucoe9Ahd56KMz5RNBw@mail.gmail.com> <CAP-5=fXcskdtN_dz5jcVywq8S1=pC5TdEN25LcEXzd0Gyk+o+w@mail.gmail.com>
In-Reply-To: <CAP-5=fXcskdtN_dz5jcVywq8S1=pC5TdEN25LcEXzd0Gyk+o+w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 31 May 2022 16:18:26 -0700
Message-ID: <CAP-5=fXu5rSV6C=WCs3bkCuaXknoKZv6o0O5gGAJKeLcAFuVcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] perf stat: Add JSON output option
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Claire Jensen <clairej735@gmail.com>,
        Stephane Eranian <eranian@google.com>
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

On Tue, May 31, 2022 at 4:13 PM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, May 31, 2022 at 3:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Tue, May 24, 2022 at 10:38 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > From: Claire Jensen <cjense@google.com>
> > >
> > > CSV output is tricky to format and column layout changes are susceptible
> > > to breaking parsers. New JSON-formatted output has variable names to
> > > identify fields that are consistent and informative, making
> > > the output parseable.
> > >
> > > CSV output example:
> > >
> > > 1.20,msec,task-clock:u,1204272,100.00,0.697,CPUs utilized
> > > 0,,context-switches:u,1204272,100.00,0.000,/sec
> > > 0,,cpu-migrations:u,1204272,100.00,0.000,/sec
> > > 70,,page-faults:u,1204272,100.00,58.126,K/sec
> > >
> > > JSON output example:
> > >
> > > {"counter-value" : "3805.723968", "unit" : "msec", "event" :
> > > "cpu-clock", "event-runtime" : 3805731510100.00, "pcnt-running"
> > > : 100.00, "metric-value" : 4.007571, "metric-unit" : "CPUs utilized"}
> > > {"counter-value" : "6166.000000", "unit" : "", "event" :
> > > "context-switches", "event-runtime" : 3805723045100.00, "pcnt-running"
> > > : 100.00, "metric-value" : 1.620191, "metric-unit" : "K/sec"}
> > > {"counter-value" : "466.000000", "unit" : "", "event" :
> > > "cpu-migrations", "event-runtime" : 3805727613100.00, "pcnt-running"
> > > : 100.00, "metric-value" : 122.447136, "metric-unit" : "/sec"}
> > > {"counter-value" : "208.000000", "unit" : "", "event" :
> > > "page-faults", "event-runtime" : 3805726799100.00, "pcnt-running"
> > > : 100.00, "metric-value" : 54.654516, "metric-unit" : "/sec"}
> > >
> > > Also added documentation for JSON option.
> > > There is some tidy up of CSV code including a potential memory over run
> > > in the os.nfields set up. To facilitate this an AGGR_MAX value is added.
> > >
> > > Signed-off-by: Claire Jensen <cjense@google.com>
> >
> > Your sign-off as well?
>
> Doh:
> Signed-off-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian

Actually, this was fixed in V5:
https://lore.kernel.org/lkml/20220526224515.4088240-1-irogers@google.com/

Thanks,
Ian

> > Anyway, I think there are places to clean up this part of code
> > more but that's not a part of the work.  Maybe I need to find
> > some time to do that later.
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks,
> > Namhyung
