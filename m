Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3EA54E781
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiFPQn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiFPQnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:43:52 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF57C27FE4;
        Thu, 16 Jun 2022 09:43:47 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-100eb6f7782so2563569fac.2;
        Thu, 16 Jun 2022 09:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCKsj+St5eBkoPclTa2En9zfCgN8+cKxVUt9jp6Eju0=;
        b=rSfU7+dQ9rIHicdVKszqZ7j6R+G26ovDu4S8kimJkxQ7hm6Ps8Fv41T8UMNkqyRFpl
         hFUnbBrs95lolYV7X/d8jyyJC51X9eilAc28jCsZpcttsWni2BCZLqtOui/mw7i1A8t3
         I0Kj0PP2k6CYkI4x5f8nhQOV1JetEUcRRw4dExD8UZ1szXwc8lkt8yrZMUPhjBRjfChv
         nR6ND2lCh0F7FjVeiR9BX6MfELoHotlyAvBiEqkKTW+YH5DdiWVZacPJ9PVruLfGFVJv
         z4ZAFdYCuxFVjQUlxxHGjJlDo5cdXWGA2t75SeeRD5uGutkEr0MWj9xQ+lxL7NChIK0B
         EGzQ==
X-Gm-Message-State: AJIora8pZpVjxw0lkKmDm1zI5LKXfZvGlo6PRarC9dBqeVGdAjC/ljTl
        GClAgHNBSvg3pqKWzFQHpEalFFtaKTbaq+MtDIg=
X-Google-Smtp-Source: AGRyM1uiNilmgCkMLL3RIor+VnxuOx5WmIHieZHnw8pepHrqFELZ71BJIxi2vOS4y2KJKXCtTI32mAsPpi55aT8WPvI=
X-Received: by 2002:a05:6870:4585:b0:fb:5105:76b8 with SMTP id
 y5-20020a056870458500b000fb510576b8mr3109112oao.92.1655397827074; Thu, 16 Jun
 2022 09:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220615190735.1298213-1-namhyung@kernel.org> <9242ecfa-36ab-c425-999c-fad44056223b@arm.com>
In-Reply-To: <9242ecfa-36ab-c425-999c-fad44056223b@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 16 Jun 2022 09:43:36 -0700
Message-ID: <CAM9d7cg6xE0YcTt3YGPsCkTzRXZZjDQm2We2v+O7tgj-E=djoQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add ARM SPE system wide test
To:     German Gomez <german.gomez@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 16, 2022 at 3:12 AM German Gomez <german.gomez@arm.com> wrote:
>
> Thanks for the patch, Namhyung
>
> On 15/06/2022 20:07, Namhyung Kim wrote:
> > In the past it had a problem not setting the pid/tid on the sample
> > correctly when system-wide mode is used.  Although it's fixed now it'd
> > be nice if we have a test case for it.
> >
> > Cc: German Gomez <german.gomez@arm.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/shell/test_arm_spe.sh | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
> > index e59044edc406..b9c588ae393b 100755
> > --- a/tools/perf/tests/shell/test_arm_spe.sh
> > +++ b/tools/perf/tests/shell/test_arm_spe.sh
> > @@ -23,6 +23,7 @@ glb_err=0
> >  cleanup_files()
> >  {
> >       rm -f ${perfdata}
> > +     rm -f ${perfdata}.old
> >       exit $glb_err
> >  }
> >
> > @@ -85,5 +86,19 @@ arm_spe_snapshot_test() {
> >       arm_spe_report "SPE snapshot testing" $err
> >  }
> >
> > +arm_spe_system_wide_test() {
> > +     echo "Recording trace with system-wide mode $perfdata"
> > +     perf record -o ${perfdata} -e arm_spe// -a \
> > +             -- dd if=/dev/zero of=/dev/null count=100000 > /dev/null 2>&1
> > +
>
> Should we skip if we don't have privileges for CPU tracing? (attached diff)

Oh, you're right.  I'll squash it to the patch.

Thanks,
Namhyung


>
> > +     perf_script_samples dd &&
> > +     perf_report_samples dd
> > +
> > +     err=$?
> > +     arm_spe_report "SPE system-wide testing" $err
> > +}
> > +
> >  arm_spe_snapshot_test
> > +arm_spe_system_wide_test
> > +
> >  exit $glb_err
