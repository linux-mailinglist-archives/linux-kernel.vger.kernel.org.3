Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F300A5234B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244190AbiEKNv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbiEKNvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:51:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A76F38
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:51:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k2so3106671wrd.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/fOcrZZUcmh5mqkQ0xhNdrjRyLvkxvBijB4Co29OaA=;
        b=eWpvmm8nTNmezqjSaRFWnvip2x3d5DxnHqGvOIUljx8Jy6SQVavMXugmtwNNhfWkUv
         FpP1Y8b/GiLgfC6DThIGtJ6aH7E5m7gJJA1E3jO6tS5V+m6JGg8dcysecRsMrT7/J8pC
         k1MCcN+M3dSMkggl4Pz3alt0nRClV+kiWbTmI7xKpexBpZseNotBoJpySUAJ8KRd6KGg
         6t7m+jNQGvGitOOWyeaLMbstCZtPdHNnBCvosp8PuMh+LxqnIkRNySBJzFVgNVT+KFwk
         RAOp1GBYpuC6oBV9wFifmz2WRjc4JpFmVvj9VR4FQ8gyfXkQEc4Qn/o9cvrXMbVH/ODN
         pD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/fOcrZZUcmh5mqkQ0xhNdrjRyLvkxvBijB4Co29OaA=;
        b=UkCQi23jBjsrCO+16sqb8E5AW6Ka2PjagKSpLwL1a8HhHBttSTKV36q/s9Ov4Izf1p
         gISEp2Ah3acK5jCVmp5zaeVEprJwS8WxpbglvSCqSI3tBqT1JepJKYElhkdbLIypO/EW
         Lqj19PidSjX2t4KggmnC1O7UWe51tvrzdBR5zIbh0SZDnQsIsBoit1eSKheCqiSyH32N
         YoMSoLJv1k6dbpp9OcfLDjU/WOf+JUpSQJ57/y7O5JN3c8OZ93n5pf7CMOaPhL/27umA
         xChc/Fl8XNbQ2T+K7oLsn1Sz9B5NftUgAlYLMkXIAGNcol0k42oRJlrMCJyEkyFZTUCo
         LErA==
X-Gm-Message-State: AOAM533F/nsQOcCbqS/R5zlcXy9FFixxooVQcMEkdYVFqAof5G0E+kRd
        yu9WE4JGvan9n/DdHt7gH0rxq4jLyT4hHqRR1wW64A==
X-Google-Smtp-Source: ABdhPJzv3SW5s3y10HDMfCOw3Hp7XbPNRrhqe0ZKmIoLMqb7I4GfSVmBOpBfNQC3HiMb7+YS8i2tqFHvZYWDI6205Gc=
X-Received: by 2002:a05:6000:1f1b:b0:20c:9ea8:b650 with SMTP id
 bv27-20020a0560001f1b00b0020c9ea8b650mr22571279wrb.300.1652277074370; Wed, 11
 May 2022 06:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220511070133.710721-1-irogers@google.com> <20220511073501.GW76023@worktop.programming.kicks-ass.net>
In-Reply-To: <20220511073501.GW76023@worktop.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 11 May 2022 06:50:59 -0700
Message-ID: <CAP-5=fVoZSusNWfpYDpHvbxF=J0-a2jF+TpxEYLxmtWx6QFZ7A@mail.gmail.com>
Subject: Re: [PATCH 0/7] Rewrite jevents program in python
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 11, 2022 at 12:01:26AM -0700, Ian Rogers wrote:
>
> > The changes here switch from jevents.c to a rewrite in python called
> > jevents.py. This means there is a build time dependency on python, but
> > such a dependency already exists for asciidoc (used to generate perf's
> > man pages).
>
> You mean just building perf (not the docs) will now require snake stuff?
>
> That's very tedious :/ I don't typically have snakes on my machines.

Hi Peter,

You're right that after these changes python is a build requirement
for jevents. We could keep the C code around for the case that python
isn't there, but I want to do things like remove the string
relocations, sort the events by name so we don't linearly search, etc.
which would be a massive chore to keep alive on the C side. An
alternative would be to have an empty pmu-events.c file that is used
for this case. If you wanted to keep things in C and have jevents like
event names, you could use the empty version and link in libpfm4.

Thanks,
Ian
