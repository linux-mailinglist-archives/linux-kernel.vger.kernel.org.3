Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B11513F38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353442AbiD1Xxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353427AbiD1Xxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:53:36 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839062F3BF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:50:20 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id v4so8609238ljd.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUjBUCzeqZKhIWOyMkHvOLbfBtVZqVfOxb5rIGsiSW8=;
        b=t8mLtVv0eOz5KcTUcsrdktjYH1bdgNWWyUARNzYbqQp505GEYbYALaDe8VJqSKd6hu
         w1cUcG194OKKbbKk8dtji6PHWkr5ffGoF4qDh1AAfGICyZ2GwnJr1T37SpUzQW1dfDVb
         IETK3t7PWFZ0D3JJ8HQHapN0EaH8HmvQ87XZWXskVBCbrZc2BsMWjBN4Dl9G2jd0z1hv
         +Mh9LvpGKkQWb+BoHaomOwhLHiC3RSU5LXwJnAdoEs66RdYA3zsriLNHDhW6ziJ48/yU
         nJ68m1qRTt3QtwNa1Lio4Aio52/ZVljtXxhHSjWfobc/opkkfxuXb7rBPy1TO7/FvD0k
         To9Q==
X-Gm-Message-State: AOAM531QAB1BoP2UHfdc/bzX4jwTreuYxpgGzd+3z4uAD8N01IOyYnLE
        XS9d7h8JtFtZL/HNPqpxcnOX6gqb6w1VRY3SEYF9vMvp
X-Google-Smtp-Source: ABdhPJydsD6t3NSfOwuXfCnF9DIF6qIXUSN49rbNOkoz39MmXNMyt7R2R2niDMzc154F22NGB1e5CHQPTwgSRa8lkjM=
X-Received: by 2002:a2e:1613:0:b0:24f:2ee0:351a with SMTP id
 w19-20020a2e1613000000b0024f2ee0351amr4859409ljd.180.1651189818699; Thu, 28
 Apr 2022 16:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220422162402.147958-1-adrian.hunter@intel.com>
 <20220422162402.147958-3-adrian.hunter@intel.com> <CAM9d7cgbxC_vF2A2JtnOV-we7kO1qB9W5g_X4-zAEyR=vF6AcA@mail.gmail.com>
 <7a8447da-9a3f-da37-93de-dacab5b79211@intel.com>
In-Reply-To: <7a8447da-9a3f-da37-93de-dacab5b79211@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 28 Apr 2022 16:50:07 -0700
Message-ID: <CAM9d7chraAh6LS-RrQLA++gbAchcnEfBEQhEzCFTGOMmuLhHFg@mail.gmail.com>
Subject: Re: [PATCH RFC 02/21] libperf evsel: Add perf_evsel__enable_thread()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 9:15 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 28/04/22 00:48, Namhyung Kim wrote:
> > Hi Adrian,
> >
> > On Fri, Apr 22, 2022 at 9:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> Add perf_evsel__enable_thread() as a counterpart to
> >> perf_evsel__enable_cpu(), to enable all events for a thread.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  tools/lib/perf/evsel.c              | 10 ++++++++++
> >>  tools/lib/perf/include/perf/evsel.h |  1 +
> >>  2 files changed, 11 insertions(+)
> >>
> >> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> >> index 20ae9f5f8b30..2a1f07f877be 100644
> >> --- a/tools/lib/perf/evsel.c
> >> +++ b/tools/lib/perf/evsel.c
> >> @@ -360,6 +360,16 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
> >>         return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
> >>  }
> >>
> >> +int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
> >> +{
> >> +       int err = 0;
> >> +       int i;
> >> +
> >> +       for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> >> +               err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i, thread);
> >
> > You might want to break the loop when it fails.
>
> Thanks for looking at this.  It should break because of " && !err".

Oh, I missed that part, sorry!

Thanks,
Namhyung
