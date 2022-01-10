Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DFF48A2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbiAJWWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbiAJWWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:22:48 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09BDC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:22:47 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id j1so9852313iob.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GECtgr52QV1EPTta/2B2UmimcgBEplWvMNOTcq1vS+M=;
        b=kgBQtrZHWwIJdlu/GkbHgK1ITF4NgJgumTL1y0OAA50GernivyX0Y8EwcW4XnAr4zE
         93KmJk3auGzU+hGxD3/n96RpUJd1YpdXahQfojM6x9eiGh08s+LWGKC5RnKBb6i3weHq
         XxGBBzKmIOs6VNQpTFXJzb8Uhpfh7ZXi1CB1G7tZUZmAYuh3VXyaTiSC3nAjgLDRaSZN
         lLfw7s7gpjfHLNcdAe+P8/Y1jES6fXACoHZC36+Y5dBptSc7BxfST5xy6nMBhl59Wzvp
         QeyDDXvXgsgnotzda2gTd36lv28MWf1kyitrQOQPlrao+EhLSGYbmkG9tYsgcoXwQtNV
         Rb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GECtgr52QV1EPTta/2B2UmimcgBEplWvMNOTcq1vS+M=;
        b=RtMT8bDMjtEJGCYKsXBRQsa6sNuvF52nVktlgOWu75OlaEgaYIQgSAj+ygJxaQefTa
         LabAixawNE6wnrH59NyCddGllf+HKLSQ4oeBvesUvAick+ftexIbjojeomiOnWGUOyBp
         1GeEYQu9PjSFb+ZArL8GJdV/MrOzcv0mMbOUI7ZlEjpGG6kbjrxMtKcjpX3W7qbw4Ptz
         MXCFPVP+8T/3vwd1iy7bUK6Vn+0SXKu2FA+piSigg5p8bMns3NSKwdl8owNIVxfbfo7Q
         bg2jFprAAcGwwfRHz7Iv0HmTx85Lu+f3AwRXNldUROEY9CA09uhD/amntpsWBY/xX+01
         nxZg==
X-Gm-Message-State: AOAM533CaeQsjPa/PQVsXH26CVNhYtZmQnWo7A1J6WhG5IjDjtB/UQ2N
        KQefIkerjGxi1wAAGsFQAQIKIShBaEgDuamf34blyQ==
X-Google-Smtp-Source: ABdhPJyISpavZ8R66rZeWCAR7t9VhZ6UHzPHo8uijxDXyTrjndiRPXu1rvhqDAUd/s9WRwwU9PbbkBJWrszWNNvd70w=
X-Received: by 2002:a02:294b:: with SMTP id p72mr927296jap.263.1641853367120;
 Mon, 10 Jan 2022 14:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com> <20220105061351.120843-5-irogers@google.com>
 <0e26524c-9f4c-b351-2498-0a56bc86b4ee@huawei.com>
In-Reply-To: <0e26524c-9f4c-b351-2498-0a56bc86b4ee@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jan 2022 14:22:34 -0800
Message-ID: <CAP-5=fWU+JBpqpE0ujGfs5TmnY9mv5CWNdMc=X_zKe79GTvPfw@mail.gmail.com>
Subject: Re: [PATCH v4 04/48] perf stat: Switch aggregation to use for_each loop
To:     John Garry <john.garry@huawei.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 10:51 AM John Garry <john.garry@huawei.com> wrote:
>
> On 05/01/2022 06:13, Ian Rogers wrote:
> > +     cpus = evsel__cpus(evsel);
> > +     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
>
> It seems a common pattern to evaluate cpus and use in
> perf_cpu_map__for_each_cpu() - is it possible to make a macro to accept
> evsel and create cpus, like perf_evsel__for_each_cpu()?

It's possible, I'm not sure it is saving much and it is common to also
want to iterate the cpumap of the evlist.

Thanks,
Ian

> > +             if (cpu_map__compare_aggr_cpu_id(config->aggr_get_id(config, cpus, idx),
> > +                                              id))
> > +                     return cpu;
> >       }
> >       return 0;
>
