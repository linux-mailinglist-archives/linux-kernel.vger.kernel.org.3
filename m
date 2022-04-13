Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA92C4FFC15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiDMRLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiDMRLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:11:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D1FEA6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:09:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q3so2927526wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCLiXto+N+uwNvwTzKfo+TPPGQjP4GFjpgB4ZdDzCwA=;
        b=MkZiwQvVjG36q8ePnIhm0w66YSzngKvc5oJJvnJmsCef4T9vJ6aWRANmip/0NJLen6
         Aia72rjrqEleWdmX6pp3m/yfvg73D3lay36uWX/HHWfiSGnP+w8muJCzanM0t1Qh3jXZ
         B7t3CTpV0YGIj9DrkuSuoRO0bE8j0ISFDKY2BTME0vbFx7WaCjTtyA86PjVSCxdzkgsz
         9OhxuHhJ4K0VnzzNd8GGbWSycQfaVMqKzkVa5HH8lzy3QWHJijb997UNs4tHZkCg28gm
         gsiRN9GK5c5CV84U6usdPEGTUBYyFth1FY3xE7NHbPPRnFHJG03oKTQZoRA7eUea2rnF
         YxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCLiXto+N+uwNvwTzKfo+TPPGQjP4GFjpgB4ZdDzCwA=;
        b=RzboyY1gHV6P3J6NZfiinbqLYulnosnK/p7bmjRpqNxRWEj3/od0hXmUc6bIC2+EyO
         72sHlRLZL5TJWqNyY7StrHxoRm4yPePfkBbKpcrQvxv7Hvlou/Tvx/KrV0t1gS0Dej4Y
         8JbFVN76nhJmvnMm36HHXaVfK32wEMQdXX44rbdrAwcYkol02zx03b+H/89wJahBZSlZ
         xwOcJZJdLJq31B2B6ulM24TE+a6rUOqNz/PELgZIwU65Djaor0+TeykTuXLhHqcaKv6S
         wIiY9VQ646lvSc3gOu6b6JZxBzWuQT48UqWtaa+c6phRyCwyrGbKDZHhaR82zoEFdY21
         YBTg==
X-Gm-Message-State: AOAM531T+XWWHWCnHtgX37/l5c1eYih+Db+EkATQi1/JlT65vOoA2sae
        EICQvSNy1bcvmNCLuC51jKADMq84qSjxiPO+9zja7w==
X-Google-Smtp-Source: ABdhPJyli41f+i1rwTLIV2MJwxxgzzWw7Zz26GHsP9cvbLAt8rnThx1uAQV/lOxtF/JQ0NQPCAtI5c8ohWYReiCK+hU=
X-Received: by 2002:a5d:6241:0:b0:207:ac0e:3549 with SMTP id
 m1-20020a5d6241000000b00207ac0e3549mr9032063wrv.343.1649869767586; Wed, 13
 Apr 2022 10:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220304083329.GC20556@xsang-OptiPlex-9020> <CAP-5=fVz=arWo19PQR_4UKY_PyywyXoyp+MUnfAJxCFZy5rhWg@mail.gmail.com>
 <20220413070529.GA1320@linux.intel.com> <CAP-5=fXGqODZYGu781qjEEVtGFpCQJ=dCXi5shYOAbBSt5wQkw@mail.gmail.com>
 <85eed89f-e4a8-2887-a0b3-579704304357@linux.intel.com>
In-Reply-To: <85eed89f-e4a8-2887-a0b3-579704304357@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 Apr 2022 10:09:15 -0700
Message-ID: <CAP-5=fXj+WT3ExNo-fL4d9b_Wm5swnKaCWd67rU85Q=QFg5KUw@mail.gmail.com>
Subject: Re: [LKP] Re: [perf vendor events] 3f5f0df7bf: perf-sanity-tests.perf_all_metrics_test.fail
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Carel Si <beibei.si@intel.com>, acme@redhat.com,
        alexander.shishkin@linux.intel.com, alexandre.torgue@foss.st.com,
        ak@linux.intel.com, mingo@redhat.com, james.clark@arm.com,
        jolsa@kernel.org, john.garry@huawei.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, namhyung@kernel.org,
        peterz@infradead.org, eranian@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, lkp@lists.01.org,
        lkp@intel.com
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

On Wed, Apr 13, 2022 at 9:37 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 4/13/2022 12:03 PM, Ian Rogers wrote:
> > 3) Weak group doesn't fall back to no group:
>
> That's because the group validation code doesn't take pinned events,
> such as the NMI watchdog, into account.
>
> I proposed a kernel patch to fix it, but it's rejected. It should be
> hard to find a generic way to fix it from the kernel side.
> https://lore.kernel.org/lkml/1565977750-76693-1-git-send-email-kan.liang@linux.intel.com/
>
> Maybe we can workaround it from the perf tool side?
> For example, for each weak group with cycles event and NMI watchdog is
> enabled, add an extra cycles event when opening the group. If the open
> fails with the extra cycles event, fall back to no group. After the
> extra cycles event check, remove the extra cycles.
>
> What do you think?

Thanks Kan, it is a shame the kernel support is lacking here. I'm not
sure what you are proposing for the perf tool to do. So:

> for each weak group with cycles event and NMI watchdog

Okay, let's try Branching_Overhead as mentioned in this report - but
the event is CPU_CLK_UNHALTED.THREAD here :-/

> add an extra cycles event when opening the group

So the perf_event_open doesn't fail here for me:
$ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,BR_INST_RETIRED.CONDITIONAL,CPU_CLK_UNHALTED.THREAD},cycles'
-a sleep 1

 Performance counter stats for 'system wide':

     <not counted>      BR_INST_RETIRED.NEAR_CALL
               (0.00%)
     <not counted>      BR_INST_RETIRED.NEAR_TAKEN
                (0.00%)
     <not counted>      BR_INST_RETIRED.NOT_TAKEN
               (0.00%)
     <not counted>      BR_INST_RETIRED.CONDITIONAL
                 (0.00%)
     <not counted>      CPU_CLK_UNHALTED.THREAD
               (0.00%)
     4,071,908,022      cycles
               (49.97%)

       0.998134717 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
echo 0 > /proc/sys/kernel/nmi_watchdog
perf stat ...
echo 1 > /proc/sys/kernel/nmi_watchdog
The events in group usually have to be from the same PMU. Try
reorganizing the group.

I'm not sure what the cycles event is achieving here, but it seems the
behavior will need a kernel change. I think I'm misunderstanding your
proposal :-)

Thanks,
Ian

> Thanks,
> Kan
> > $ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,BR_INST_RETIRED.CONDITIONAL,CPU_CLK_UNHALTED.THREAD}:W'
> > -a sleep 1
> >
> >   Performance counter stats for 'system wide':
> >
> >       <not counted>      BR_INST_RETIRED.NEAR_CALL
> >                 (0.00%)
> >       <not counted>      BR_INST_RETIRED.NEAR_TAKEN
> >                  (0.00%)
> >       <not counted>      BR_INST_RETIRED.NOT_TAKEN
> >                 (0.00%)
> >       <not counted>      BR_INST_RETIRED.CONDITIONAL
> >                   (0.00%)
> >       <not counted>      CPU_CLK_UNHALTED.THREAD
> >                 (0.00%)
> >
> >         1.001690318 seconds time elapsed
> >
> > Some events weren't counted. Try disabling the NMI watchdog:
> > echo 0 > /proc/sys/kernel/nmi_watchdog
> > perf stat ...
> > echo 1 > /proc/sys/kernel/nmi_watchdog
