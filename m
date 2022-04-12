Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1500E4FEB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiDLXa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiDLX3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:29:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F151689C6;
        Tue, 12 Apr 2022 15:31:20 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h11so122132ljb.2;
        Tue, 12 Apr 2022 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ek4T6vnTw/2O/5QQJAOuKhoFnn5jZ3f6le2GCuIyXjk=;
        b=j6KGdkSl3cIn6bacAOdblh5T3zZZ6ohSSFnHENHTtg+M+ODqT1XRwevMtoa3zrWn1y
         pvNl7Z6nb/KDqvLRe3LdEbVvYHvFWKqv9EZpR6fXH7/8nzLypBD8Z7IbeyKNMGZCQmsM
         CYECVsfrY2Xta7NqYI6DMpQSQTof2D8DX7As48EytCsZfDKFRg3Tmi99MlrJGI1AvlRp
         Wko4sfZgBiSAUoIuNMg1h872IlvkFhxI1z0UKjQm13AEafz/Y2FHKRoWSGoWYPEQRj6J
         rS3EQgLdWTZbk+R4ieRoM2yNOQuc6NG3W+FFQPym1Of0xcgwzqT5ce2EgKp/23SBfN2o
         GI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ek4T6vnTw/2O/5QQJAOuKhoFnn5jZ3f6le2GCuIyXjk=;
        b=OKQy8OKyOwJEpTuJEJJwOIhZspmx3DbdZ3b+Rbqzw4hhLPjScvchrzhAcIVnjFw0rS
         CaBnpEPoQIBzZUXDSW2aJMc1mWyT/ychIXke4mgfI4o4AuLTTJ09deymjRgW+/GeybT5
         ebALDz5pmqY4VGy9y1hXb2LfCy6jxPqOXbMkKxAJvd8sd0yyQ0NNdny9jK3vnvtfXLXc
         oasFk5ooLUavQWPkQrSX3LheeUc1AcxRi6LPLBKzFIE7Wm43m1AUuKRX2rNThaQO0Fxf
         7o/CU9ZTONnKYSiCj751Sxd2oTjPm4+3H20+CdEq78p11m0zxtTd9V5y6HT62Vn1CY7q
         Si5g==
X-Gm-Message-State: AOAM531/bE2bL3LWh1GfTe/ZFStB1eJZ+9j6JYAZEf35nbgVhJpC4WZw
        rEatZLQalVGk8QH07NyA7uP7fty6TlrR/yUEdCk=
X-Google-Smtp-Source: ABdhPJwuJ2RMINhAb80dMlHreZNjXIcoSfhZZXEJkIWiUrkditbyn7wUmHib1CO/+UlJR8jIrT3RnZnUgj9D6zq+aiw=
X-Received: by 2002:a2e:bc08:0:b0:24b:c0f6:b271 with SMTP id
 b8-20020a2ebc08000000b0024bc0f6b271mr3078247ljf.180.1649802678777; Tue, 12
 Apr 2022 15:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <69656438-8b9a-000b-0702-02dc480639f9@linux.intel.com>
 <20220407085721.3289414-1-florian.fischer@muhq.space> <20220407085721.3289414-3-florian.fischer@muhq.space>
 <CAP-5=fWC5e9PTs9PVttVDdNbCzYQVeqyuf95q181Vkg4NqJxqg@mail.gmail.com>
 <20220410164136.bxqtpbrmfbqxdx4n@pasture> <CAP-5=fXuR2tK_4FDnRA88a9wQkndbqyeN6G2muppaMhV5mAQ=A@mail.gmail.com>
In-Reply-To: <CAP-5=fXuR2tK_4FDnRA88a9wQkndbqyeN6G2muppaMhV5mAQ=A@mail.gmail.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 12 Apr 2022 15:31:07 -0700
Message-ID: <CAM9d7ci2vKMXopBwnWxebzkqsz+ySvhqqFb6_rkk=XE1fd1RnQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf stat: add rusage utime and stime events
To:     Ian Rogers <irogers@google.com>
Cc:     Florian Fischer <florian.fischer@muhq.space>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Florian Schmaus <flow@cs.fau.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 12, 2022 at 2:36 AM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Apr 10, 2022 at 9:41 AM Florian Fischer
> <florian.fischer@muhq.space> wrote:
> >
> > > > This patch adds two new tool internal events 'rusage_user_time'
> > > > and 'rusage_system_time' as well as their aliases 'ru_utime' and
> > > > 'ru_stime', similarly to the already present 'duration_time' event.
> > > >
> > > > Both events use the already collected rusage information obtained by wait4
> > > > and tracked in the global ru_stats.
> > > >
> > > > Examples presenting cache-misses and rusage information in both human and
> > > > machine-readable form:
> > > >
> > > > $ ./perf stat -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time .
> > > >
> > > >  Performance counter stats for 'grep -q -r duration_time .':
> > > >
> > > >         67,422,542 ns   duration_time:u
> > > >         50,517,000 ns   ru_utime:u
> > > >         16,839,000 ns   ru_stime:u
> > > >             30,937      cache-misses:u
> > > >
> > > >        0.067422542 seconds time elapsed
> > > >
> > > >        0.050517000 seconds user
> > > >        0.016839000 seconds sys
> > > >
> > > > $ ./perf stat -x, -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time .
> > > > 72134524,ns,duration_time:u,72134524,100.00,,
> > > > 65225000,ns,ru_utime:u,65225000,100.00,,
> > > > 6865000,ns,ru_stime:u,6865000,100.00,,
> > > > 38705,,cache-misses:u,71189328,100.00,,
> > >
> > > This is really nice. For metric code we currently handle duration_time
> > > in a special way, for example:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/metricgroup.c?h=perf/core#n745
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/metricgroup.c?h=perf/core#n1131
> > > We will need to do something similar with these tool events, but I'm
> > > happy that it can be follow-up work.
> > >
> > > I'm not a huge fan of the names ru_utime and ru_stime, two thoughts
> > > here we could do duration_time:u and duration_time:k but I don't think
> > > that really makes sense. My preference would be to just call ru_utime
> > > user_time and ru_stime system_time.
> >
> > I considered ru_{u,s}_time only as aliases because those are the field names in
> > the rusage struct filled by wait4 and are probably known by perf users.
> > The "official" names are currently rusage_{user,system}_time.
> > I could change them to only {user,system}_time because those names are more in line
> > with the already present duration_time and are independent of the rusage
> > implementation detail.
> >
> > What do you think of?
>
> I like user_time and system_time, short and to the point [1] while
> satisfying being intention-revealing. The aliases, ru_utime and
> ru_stime, are fine but a bit of an acronym soup. They mean we need to
> special case more names in the metric code. I don't know how others
> feel but I'd stick to just user_time and system_time.

Maybe I missed something but could we just use cpu/task-clock?
I'm not sure the rusage-base events work for cpu events and for
existing tasks.

Thanks,
Namhyung
