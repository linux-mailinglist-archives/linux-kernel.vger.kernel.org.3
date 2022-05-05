Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C337251BC92
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354617AbiEEKAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiEEKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:00:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282DB49913
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:56:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id v4so4891234ljd.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4DEU3H+LT7BYKo9sox1btQzO0smkBlR+Qye4B8ebu0=;
        b=Ks4SKxTnUKVKUwVXv/z6D06GzDmx2q3+rx//xHOeMzoAOuewAqwVt9ua6bENTrVz+R
         0JIegRcTRyiASQxRg0+uyHbQOiDNfULwFvH5tPA0VKRGpsfe5tecjoOb/Y6oILbVoBH3
         NrvWEGkrpZd2fxj68loUCGXxDwOZH0prJs4nv5Q3n623HV9JjnMcueFPUeRwP2SXkMqg
         tlD0SwMM3+X2vkQCFV2KcsjrC74qdHjgIViwO734yBdWzOzRoIzDAGpUu/iTUfkCW4QW
         eZC2sx543Goog7czQmR5IfMxfUWCki+7tIS2k+bxHfFA6L/4h7BthEETlGL9VaIMUUG0
         o1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4DEU3H+LT7BYKo9sox1btQzO0smkBlR+Qye4B8ebu0=;
        b=B6yB8Vlo1hw6Gy6MH3il5M7NUXbXpfSj+vAKAP6bEAWLQySyNda/o0/j7xYBPL8viw
         OQpxKheRlyTK0EIlf42NluJPqTHX5AoXmkBBsrUF6Zc6lEaJQdrltbfmviDHXRulhYjA
         +1mGzcl2uoVI7yKT9n56omIsOVTo0ACtBRRjFMtXgJIIRGxkU3WGjsymJp0Rm+cXXiAT
         0qcqDNG8m+ZJ0/5+5J/nGWjvzweiQuSB3PuJEP1y+AkqVRcz3svW7vdLh2rjTtOV2Gap
         ViG/Os1a9HlxBeXZYQiWB/YwizwAY9JDSxiXLSB22vc6QgC5spx2miHySXfTjORwRsh1
         xBIw==
X-Gm-Message-State: AOAM53179TjYaVddMTgaPdvhVieSJ8mIyTnQdmb35mN7pGNCplctCACl
        k11QEt2KbFxrszB5nomIHgwLt4qYlB/pPTu/xmICJQ==
X-Google-Smtp-Source: ABdhPJyppKvZANHxf8tddUkLILvHRxFY8BNe6nPqZN5wceuCAun9Tn1bbcKNTCAmougN0uypJjJfA0e0pqPz5vjCgWg=
X-Received: by 2002:a2e:93d0:0:b0:24f:255d:4bb1 with SMTP id
 p16-20020a2e93d0000000b0024f255d4bb1mr15515548ljh.525.1651744605509; Thu, 05
 May 2022 02:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220504150216.581281-1-german.gomez@arm.com>
In-Reply-To: <20220504150216.581281-1-german.gomez@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 5 May 2022 10:56:38 +0100
Message-ID: <CAJ9a7Vhrm2=1H_LLkh+j0uK8yRc7vi2yLmtDMJvVekfhvHUdPQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf cs_etm: Basic support for virtual/kernel timestamps
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Wed, 4 May 2022 at 16:02, German Gomez <german.gomez@arm.com> wrote:
>
> Hi,
>
> This change has a soft dependency on [1], but assuming the name/location
> of the new sysfs interface (ts_source) doesn't change, it should be safe
> to apply.
>
> The new 'ts_source' interface allows perf to detect if the timestamps in
> the trace correspond to the value of CNTVCT_EL0, which we can convert to
> a perf timestamp and store it in the instruction and branch samples.
>
> Due to the way the trace is compressed and decoded by OpenCSD, we only
> know the precise time of the first instruction in a range, but I think
> for now this is better than not having timestamps at all...
>

The output of OpenCSD is reflective of the architecture of the trace hardware.

Timestamps in the trace are always associated with waypoint elements -
primarily branches.
Hardware trace compression results in only these elements being
output, i.e. E / N atoms representing branches taken or not taken.
Instructions between branches have no explicit element appearing in
the trace.
The decode process implies all the instructions between these elements
to form a range of executed instructions, hence the timestamp being
associated with the first instruction in a range.
Moreover, even though we may request a high timestamp rate, output of
other trace is prioritised over timestamp trace, so there is never any
guarantee that we can force timestamps to appear at the start of every
range.

Any attempt to increase number of timestamps in a trace range would
have to be done by some software interpolation mechanism

Regards

Mike


> Thanks,
> German
>
> [1] https://lore.kernel.org/all/20220503123537.1003035-1-german.gomez@arm.com/
>
> German Gomez (4):
>   perf pmu: Add function to check if a pmu file exists
>   perf cs_etm: Keep separate symbols for ETMv4 and ETE parameters
>   perf cs_etm: Record ts_source in AUXTRACE_INFO for ETMv4 and ETE
>   perf cs_etm: Set the time field in the synthetic samples
>
>  tools/perf/arch/arm/util/cs-etm.c |  89 +++++++++++++++++++--
>  tools/perf/util/cs-etm.c          | 126 +++++++++++++++++++++++++-----
>  tools/perf/util/cs-etm.h          |  13 ++-
>  tools/perf/util/pmu.c             |  17 ++++
>  tools/perf/util/pmu.h             |   2 +
>  5 files changed, 221 insertions(+), 26 deletions(-)
>
> --
> 2.25.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
