Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBCC489E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiAJRhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiAJRhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:37:03 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B5BC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:37:03 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q5so18515412ioj.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VImuVeKyRKEKIzJHdDEJK8/BDOKoujNaHyjbgkuipso=;
        b=CdE7JZ2/5Ere61vOTLWnM5csvBvNZpoVLTe/f18kLT9JxyZ/oaWs+EGM3QoPDPdsot
         neGrENj/ANDKvii0964XyLQ52HMiUTIdQ71LhGsDyd2lg2KzZwTsVnXwHFvF9/eNKAsq
         23h/mr4FUUsi9uPO98CzTQ4JX27e7r66gk2FKlk8tG66paNmk+oqyEKcaFffO17tC7bj
         llHmFHiC4wiS19wmXXcY4Y1sxMZO9iFvJQu2XfUYgVCcw2TSDR6Ilbe6sS1AqXpigTJe
         ruIHEKACS7JiYEkpb1cre5TLkN4YPVKG6LrPNkompNKHASaXot+OaORd8sJhRIYD7a4R
         owBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VImuVeKyRKEKIzJHdDEJK8/BDOKoujNaHyjbgkuipso=;
        b=ccvWRCibMQUIY8pyALjpTDvLgLoI71X2USxTEsx4BjZDTz0sBnVVY6OmfxHQCEKjKm
         T+a6CdUvYD8tH1vdzb66uRt1/QSRfb3+f8v9/pJrdmE+L2Umoi4KQctXQbe9tV5P6OBt
         Oxvfufgyyk5upbesbhAwnEnYHzyrku0z1I6XUvSgN3BjAei91q+JrR17rt8bJ3bksfh9
         6vywUivXzTITOay4tgZZGbpl/EpqJDrHTIbAk3hKqytQEZ8p4g+9/7zTogxCatafhHND
         JkHmmS2iGnBreSS7OdawTeas6ECz/Bp74KER/xlkJLqoyu/17lygwUOiV2GKVR8swp9d
         poUw==
X-Gm-Message-State: AOAM532DaB3vd0KvkRkA6w96FxczD+VkfiCvBYUiBy8X0PU6vnlaDqTg
        2EvYyEHMrxYAdr5IaG2jvveJiiY+wnMWOfoMsGevcA==
X-Google-Smtp-Source: ABdhPJxg2hEa5KXe+r8QHR6UBQw+N6eJmP9azYBsNVCf8V7WsDYkQiX+5fZwdfHJ4PLbBwybl/oBmmZCFYqYFiYYopQ=
X-Received: by 2002:a05:6602:2b8b:: with SMTP id r11mr325003iov.97.1641836222188;
 Mon, 10 Jan 2022 09:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com> <20220105061351.120843-3-irogers@google.com>
 <57ab982e-ecc1-3f49-c580-0a251e29698b@huawei.com>
In-Reply-To: <57ab982e-ecc1-3f49-c580-0a251e29698b@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jan 2022 09:36:49 -0800
Message-ID: <CAP-5=fWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA@mail.gmail.com>
Subject: Re: [PATCH v4 02/48] perf stat: Add aggr creators that are passed a cpu.
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

On Mon, Jan 10, 2022 at 9:10 AM John Garry <john.garry@huawei.com> wrote:
>
> On 05/01/2022 06:13, Ian Rogers wrote:
> >
> > +struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> > +                                    void *data)
> > +{
> > +     if (idx < 0 || idx > map->nr)
> > +             return cpu_map__empty_aggr_cpu_id();
> > +
> > +     return cpu_map__get_socket_aggr_by_cpu(map->map[idx], data);
> > +}
> > +
>
>
> This is later deleted in the series. Can the series be reworked so that
> we don't add stuff and then later delete it? One reason for that
> approach is that we don't spend time reviewing something which will be
> deleted, especially in such a big series...

Hi John,

I think you are asking to squash:
https://lore.kernel.org/lkml/20220105061351.120843-8-irogers@google.com/
into this change. There are other  similar related changes that may
also be squashed. The changes are trying to introduce a new API and
then add changes to switch over to using it. This is with a view to
making bisection easier, have each change only do 1 thing and so on. I
believe the format of the patches is house style, but it is fine to
squash changes together too. Having sent patches to Arnaldo and having
had them split I'm reluctant to do a v5 with them squashed without him
expressing a preference.

Thanks,
Ian

> If it really makes sense to do it this way then fine.
>
> Thanks,
> John
