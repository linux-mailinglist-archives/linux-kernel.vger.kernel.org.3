Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25DC536597
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354113AbiE0QAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349598AbiE0P6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:58:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB5A2870A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:57:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso2985292wmp.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+nhRSW0HB0IrL3AsaUbgyELmuQlg7AADB3tpFmkYZW4=;
        b=ODsEChw49WJ2jXA7phOq9UZH0sa+uGOmARNU0dKT8ELNxeavTeP0ERYA525+wh7RW7
         9p0HVYaFdK9NPOtwfoYX/3YxuBlVrTS/PvOIFREHdr6i3F0FZXNsx0jO1emEFXlOq8jk
         UzaGW0oM2FSWqXu3ovPYxFW396ckgz81nYoroROMlRcdxD5HFF4bvmOf1FwwjwwS9E5M
         9OWKi+EmtrlVAGJDI4ujDWdfiaOGYNygBvMJh+7eICZSsg2874r1YcHaLvmgsnell5CV
         XhDsg+s/QhI5QzdQAgcnyrDgPgAhweQ+452ZY+E8TlGN2qWg3aPW1kMEF3SuGryy6ig8
         Mrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+nhRSW0HB0IrL3AsaUbgyELmuQlg7AADB3tpFmkYZW4=;
        b=m3BS89FUvVxzbTR+o4QS6u0fj18piQq8deYKMbpHu1NukMimRvFgfZIIxX/3vGwv9G
         bo6JB3jwic7V0jU7PU+iVczoHjluibHhYdAklJczAjja4VrPQF5W8ogBRLSxuC+xLyXe
         f4+E0iTIz5N0eIYFrWBSgSnXRnpYL4XFR7xOoeRw/MoaGLFL+ZBibasPzXoR2er4Jz8w
         +/BLs7OFRhTXw/3WsXDitVi9M9GXhTkTGk1nzW/OT9vehgXjBuIr4/dKjmWXDRQjbfbo
         eg7SKUJnu/Hm71keAOyf2Orue77yuVgnH+tNmycXPBlw3wHYZ4QqVvx12LpJKwFjOQOC
         dn1A==
X-Gm-Message-State: AOAM531HiOALWJ9KvMTUghJqhyQH4uCZyxXC7eAmSn1Nib0WyxH9Ei4q
        RUtM7lXgxsiEmnurv7twyaIkfxJjFkiIOwqvOdyJOQ==
X-Google-Smtp-Source: ABdhPJxCxbqWMUiPiaxpL5cuYifbkFM3KgEr5xj/06bdSvjWoV1r4auP+JYDEsowOpR+ZxfLquMI36O6bB/NtFlBkII=
X-Received: by 2002:a05:600c:2305:b0:397:44a4:d3cb with SMTP id
 5-20020a05600c230500b0039744a4d3cbmr7538356wmo.115.1653667077089; Fri, 27 May
 2022 08:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220527040407.4193232-1-irogers@google.com> <YpCeo6APNtXvrTPJ@hirez.programming.kicks-ass.net>
 <76dce5d3-6c69-e403-c4d9-f882967a4467@linux.intel.com>
In-Reply-To: <76dce5d3-6c69-e403-c4d9-f882967a4467@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 27 May 2022 08:57:43 -0700
Message-ID: <CAP-5=fU4Anbx2R=L7VD3Pa_5e5nvkgSW2FNJg5+c5MJfcHcQgw@mail.gmail.com>
Subject: Re: [PATCH v2] perf metrics: Add literal for system TSC frequency
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Fri, May 27, 2022 at 7:54 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 5/27/2022 2:49 AM, Peter Zijlstra wrote:
> > On Thu, May 26, 2022 at 09:04:07PM -0700, Ian Rogers wrote:
> >> Such a literal is useful to calculate things like the average frequency
> >> [1]. The TSC frequency isn't exposed by sysfs although some experimental
> >> drivers look to add it [2]. This change computes the value using the
> >> frequency in /proc/cpuinfo which is accurate at least on Intel
> >> processors.
>
> It would be better to use CPUID if available which is far more accurate.
> Also I believe newer Intel CPUs drop the frequency in the brand string.

But on v1 you also said it was broken for certain architectures. The
point of the tests and warnings is to identify this case.

> BTW it also has the problem that if perf script is run on some other
> system to compute metrics it won't work.

Yep. We don't yet support recording then reporting metrics on a
different system. There would be a bunch to do to support this.

> >
> > This all seems bonghits inspired... and perf actually does expose the
> > tsc frequency. What do you think is in perf_event_mmap_page::time_* ?
>
>
> That's not really available to perf stat, which is the primary metrics user.

So we have 3 approaches:

1) read /proc/cpuinfo: pros: easy in comparison to other approaches.
cons: will break in the future, will need a cross system strategy
2) use cpuid: pros: can be made to work across systems cons: not
available for all Intel architectures
3) mmap: pros: more stable API than cpuinfo vendor string. cons: could
end up with new events purely to gather a TSC frequency and associated
complexity around permissions, etc.

I feel we can bike shed and go between the 3 approaches almost
endlessly. I'd rather get something in and iterate. How the approach
breaks can motivate the next steps and the tests added here will
capture when it does break, not just when a metric is first used. I
mentioned this on V1 and requested feedback, this is just implementing
what I said I'd do to V1.

Thanks,
Ian

> -Andi
>
>
>
