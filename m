Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A112256BDCB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiGHPj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbiGHPj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:39:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F31FCF8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:39:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so1306593wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 08:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AAkCMAVRf/IwKZSA0BbN8FSNnPqg+F4/qwr/P+jS6Dc=;
        b=qPAd7gLXdY2AXYJcZ98rIrWY3PxawQwig2bvtzZd/W1Os38w3n2D2BpG/CIlcDdIuG
         YFXLLXJ9kT1lRVkS7OT58WLQzyvC/+wQrzhdDytp0CSbmz/zVTVSRBtIkbFbphuvSK9z
         R8WPvaXKDg8j8depN4ngOd0v2fxMAvwOZNhZpS/2Y0mgDUI0EkBiHiIAoeVwLgR9hagT
         dtLUVd9WWi0UKsu0YqRDjDiFjAmHKhLq0/NR/PSZ9isnKlRQYU+LEDGDEyoXAMg/4UH+
         NjYHiS8Q1kHjM0SF6ReKgzRqCyPpPFnlSdyvwOMRbs6Y2+q2eeqW2t3thaL3yisjjurr
         3vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AAkCMAVRf/IwKZSA0BbN8FSNnPqg+F4/qwr/P+jS6Dc=;
        b=yXX+gjVVTCV0Tw6eM4EBCdZ2dL2FnWdYct//YKLxO8LHSXrzntkWyxNXil8sCzhPbi
         6NmygC06/+iCChfJyKrqGSdohCbo3FyuVAXT1/yH+XxDOHSyzNVRAngZ1qk7FuHMQv4r
         IKsZdM+ka+6Cgdow7uhj/+eljN+62BKbnOP1WZ0seIwULS7B1jDq3NXOr0EMxkRsr/DM
         5BE8cEbfmk1O8n6KTEJZIuxvokf5W/3dJjpNaHMMctWHsObRg2dOxAkm7V/Ibn1ZuXrD
         bjR6bKW2CTf0JO7iUuR+KCl0XdsRoBN1sLIEGWQafs34Gq5xKof4NRKBXCcmcho/PErY
         IdiQ==
X-Gm-Message-State: AJIora9PWFhNTgy1lO7ud6uJ+51yWZR1zanyU45MmYQcPmCyNgrf1BeE
        EOrY4IHV7ftU5JNicar1X28+rgaPpO3CxUWNL4/myA==
X-Google-Smtp-Source: AGRyM1t0iOAGdxPYDSXzho77NeviEc/Zuny8DDJjbAnkwE5ltk9p1KK/FNOEoXQJxAyQLN11jIEj67Y/ZdU5vMR+TVA=
X-Received: by 2002:a05:600c:4e8f:b0:3a1:8b21:ebbc with SMTP id
 f15-20020a05600c4e8f00b003a18b21ebbcmr424005wmq.149.1657294764353; Fri, 08
 Jul 2022 08:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220707201213.331663-1-irogers@google.com> <20220707201213.331663-3-irogers@google.com>
 <0bc35725-43eb-271c-d66e-ca11e5001794@linux.ibm.com>
In-Reply-To: <0bc35725-43eb-271c-d66e-ca11e5001794@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 8 Jul 2022 08:39:11 -0700
Message-ID: <CAP-5=fWAy-agZ=21_uzOWJfD9Da6XVJ05spoXQ8XTLQiE1LmLA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] perf test: Json format checking
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jul 8, 2022 at 1:31 AM Thomas Richter <tmricht@linux.ibm.com> wrote=
:
>
> On 7/7/22 22:12, Ian Rogers wrote:
> > From: Claire Jensen <cjense@google.com>
> >
> > Add field checking tests for perf stat JSON output.
> > Sanity checks the expected number of fields are present, that the
> > expected keys are present and they have the correct values.
> >
> > Signed-off-by: Claire Jensen <cjense@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../tests/shell/lib/perf_json_output_lint.py  |  95 +++++++++++
> >  tools/perf/tests/shell/stat+json_output.sh    | 147 ++++++++++++++++++
> >  2 files changed, 242 insertions(+)
> >  create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
> >  create mode 100755 tools/perf/tests/shell/stat+json_output.sh
> >
> ....
> I wonder if it is really necessary to have a python file to post process =
the
> perf stat output?
>
> With
> commit 7473ee56dbc9 ("perf test: Add checking for perf stat CSV output.")
> the same approach was done which led to issues on s390 and required an ad=
ditional
> patch to fix this:
> commit ec906102e5b7 ("perf test: Fix "perf stat CSV output linter" test o=
n s390").
>
> I wonder if you can do the perf stat output checking using bash/linux too=
ls as it
> was done in commit ec906102e5b7. This would make maintenance much easier.
>
> Just me 2 cents...

Hi Thomas,

In this case using python avoids writing a JSON decoder, which would
be harder to do in bash although there is perhaps a linter or some
such we could use. That'd wind up being another dependency :-/

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
