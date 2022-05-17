Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5FA52AE59
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiEQW62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiEQW6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:58:22 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015C53A5E;
        Tue, 17 May 2022 15:58:21 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-f18e6ff0f6so482779fac.11;
        Tue, 17 May 2022 15:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VerKdajGLgiom5BBcxHow8XQ3WsZoMjD4MRMsB3DgA=;
        b=pHQ1W6IZkl17L9NiNJNl8Mcru2fbK8xpMKkEF9N7Z1WKG5ha9I/lcNGX/i5TpG9hUy
         4iR7jw9nLhb/w0tsPTYLHFkWINmaNZ3F74dVaaaIwV/gA6DdswHnV0dm7XNUraxzHKxk
         gzY7LijJMUVbm/DWV9bocsrLOyqIoImMlfFBEW9Tu+bx8CnhTmNeTWf+hX+lvAKx+YG8
         EUIoqboZenB7hphjOE3YmWYM2EnPVfXOb60p9xHqPsbhe8NKteahHsKTBxlg/B/EIpCf
         BzVFM3fl29UvZHP6O8OATr5yScdFwu4dJzngFuGrTE9iv14ZUS35pfPqnowcDg1/U66y
         QFCA==
X-Gm-Message-State: AOAM532qJP5F6TNGgRJR+cZuB0CFAzwm8DNM1TjKTpBJaIOe0Bl4zGPg
        rAEfXMAz5+CSB65p/mUvT0yq5YFo0KkgtIj6yQQ=
X-Google-Smtp-Source: ABdhPJwp0qfpu3x8pSF2vTWRph9seOUvT9YBdyquSufD9IMMa/IKMzSku1/kNKYUR1+ZPIocGMcQPaFptOaWFXf6dq8=
X-Received: by 2002:a05:6871:215:b0:f1:8bf5:23ab with SMTP id
 t21-20020a056871021500b000f18bf523abmr8865887oad.92.1652828300542; Tue, 17
 May 2022 15:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220507053410.3798748-1-irogers@google.com> <20220507053410.3798748-2-irogers@google.com>
 <YnkTIwiVBEGUJRKn@kernel.org> <b01a66c4-ec4d-ccb7-8ca7-130d93855177@linux.intel.com>
 <708fab8f-b5c5-8f34-4322-3e337c56b869@linux.intel.com>
In-Reply-To: <708fab8f-b5c5-8f34-4322-3e337c56b869@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 17 May 2022 15:58:09 -0700
Message-ID: <CAM9d7cgEc9o9y-fH==avzucigmMVw0AwooGw0eufb2+D568-_g@mail.gmail.com>
Subject: Re: [PATCH 1/5] Revert "perf stat: Support metrics with hybrid events"
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 10, 2022 at 2:31 AM Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
>
>
>
> On 5/10/2022 5:55 AM, Liang, Kan wrote:
> >
> >
> > On 5/9/2022 9:12 AM, Arnaldo Carvalho de Melo wrote:
> >> Em Fri, May 06, 2022 at 10:34:06PM -0700, Ian Rogers escreveu:
> >>> This reverts commit 60344f1a9a597f2e0efcd57df5dad0b42da15e21.
> >>
> >> I picked this from the cover letter and added to this revert, to justify
> >> it:
> >>
> >> "Hybrid metrics place a PMU at the end of the parse string. This is
> >> also where tool events are placed. The behavior of the parse string
> >> isn't clear and so revert the change for now."
> >>
> >
> > I think the original patch used a "#" to indicate the PMU name, which
> > can be used to distinguish between the tool events and the PMU name.
> > To be honest, I'm not sure what's unclear here. Could you please clarify?
> >
> > With this revert, the issue mentioned in the original patch must be
> > broken on ADL. I don't see a replacement fix in this patch series.
> > Could you please propose a solution for the issue to replace the #PMU
> > name solution?
> >
> > Thanks,
> > Kan
>
> I am surprised the origin patch is reverted during discussion and though
> the discussion still has no conclusion.
> Let me introduce the purpose of the origin patch.
> For a hybrid system such as ADL, if both the metrics and the formula are
> different for the different PMUs, without this patch, the metric and
> event parser should work ok, nothing should be special for the hybrid.
> In fact, both "cpu_core" and "cpu_atom" may have the same metrics--the
> same metric name, even the same formula for the metrics. For example,
> both "cpu_core" and "cpu_atom" have metrics "IpBranch" and "IPC", For
> "IpBranch", both "cpu_core" and "cpu_atom" has the same metric name and
> their formula also is the same, the event name is the same though they
> belong to different PMUs. The old metric and event parser can not handle
> this kind of metric, that's why we need this patch.
>
>      "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
>      "MetricName": "IpBranch",
>      "Unit": "cpu_core"
>
>      "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
>      "MetricName": "IpBranch",
>      "Unit": "cpu_atom"
>
>
>     "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
>     "MetricName": "IPC",
>     "Unit": "cpu_core"
>
>     "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.CORE",
>     "MetricName": "IPC",
>     "Unit": "cpu_atom"
>
> Except for the above two metrics, there are still a lot of similar
> metrics, "CPU_Utilization"...
>
> The original patch expanded the metric group string by adding
> "#PMU_name" to indicate the PMU name, which can be used to distinguish
> between the tool events and the PMU name, then the metric and event
> parser can parse the right PMU for the events.
>
> With the patch all the ADL metrics can pass, without the patch, a lot of
> metrics will fail. I don't think it's a good idea to revert it before
> the new solution is proposed.

Just an idea.  Can we add a pmu prefix when it resolves the event
for a metric if it has the "Unit"?  It seems we can support something
like "cpu_core@INST_RETIRED.ANY@" already..

Or could it be done when creating JSON files?

Thanks,
Namhyung
