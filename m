Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48355516AC2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356595AbiEBGLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383562AbiEBGLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:11:23 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A4E57B02;
        Sun,  1 May 2022 23:07:26 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id j4so23598740lfh.8;
        Sun, 01 May 2022 23:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/APYmYxk61kZdXntHMEICTz/dMuoCskS3mvYdYDNX0=;
        b=CneDfyv0OGkr3LedF4KXXtzgyL0BksvUhZZ1ZDEG0SVxDhUjUcVsIaxRVzOOFWR3lq
         yLKvvj6EpG5yiQQ0yrHzp6pXHVmjo/1rDLxQP9I9cZxsk6rIe3IwK75F0hbM1qHQSSJ6
         KsY/CWok/qvyDhAbmOhhyg/cfSuSdCA5dkR+j/vuX/J8r8Hax6YNVtYQZDFM79Wx1W0Q
         BC52gtWMLxkhv8Q0wMZKuqCV5elAZyRYp7zi+Bt2Od/dmEOMQaKR1UmLC/sDegEtMDFi
         zHm1n5CukttsX60HmvO2caO2MswG4SMbkzFkkwGuvt0YLkGK1N9HSYoRlSD7RB3L/jLo
         1CFg==
X-Gm-Message-State: AOAM532XXU5ang2TitASfSoX096SgjfL5pYJP3MtDGe4g7PKY/Kox+JM
        mihzw53vZzTpUn1vIV7qJmTT1gchdiZsv5od6HojBY3W
X-Google-Smtp-Source: ABdhPJzykar8cnzxKVegJteK2VScoMzQLyopyXa0r7EehaGZZadwoCcJX006pkDn+sB42e7Thl5BhEfMoXWzs1WtEto=
X-Received: by 2002:a05:6512:39d3:b0:472:4920:96d7 with SMTP id
 k19-20020a05651239d300b00472492096d7mr8236899lfu.47.1651471645095; Sun, 01
 May 2022 23:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <YlVPpVC8chepOdzJ@hirez.programming.kicks-ass.net> <20220429051441.14251-1-ravi.bangoria@amd.com>
In-Reply-To: <20220429051441.14251-1-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 1 May 2022 23:07:14 -0700
Message-ID: <CAM9d7cjksVPHYJEjqckotqzC62dBNW9frsMQaBECngMopU4znw@mail.gmail.com>
Subject: Re: [PATCH] perf/amd/ibs: Use interrupt regs ip for stack unwinding
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com,
        Stephane Eranian <eranian@google.com>
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

On Thu, Apr 28, 2022 at 10:15 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> IbsOpRip is recorded when IBS interrupt is triggered. But there is
> a skid from the time IBS interrupt gets triggered to the time the
> interrupt is presented to the core. Meanwhile processor would have
> moved ahead and thus IbsOpRip will be inconsistent with rsp and rbp
> recorded as part of the interrupt regs. This causes issues while
> unwinding stack using the ORC unwinder as it needs consistent rip,
> rsp and rbp. Fix this by using rip from interrupt regs instead of
> IbsOpRip for stack unwinding.
>
> Fixes: ee9f8fce99640 ("x86/unwind: Add the ORC unwinder")
> Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  arch/x86/events/amd/ibs.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 9739019d4b67..171941043f53 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -304,6 +304,16 @@ static int perf_ibs_init(struct perf_event *event)
>         hwc->config_base = perf_ibs->msr;
>         hwc->config = config;
>
> +       /*
> +        * rip recorded by IbsOpRip will not be consistent with rsp and rbp
> +        * recorded as part of interrupt regs. Thus we need to use rip from
> +        * interrupt regs while unwinding call stack. Setting _EARLY flag
> +        * makes sure we unwind call-stack before perf sample rip is set to
> +        * IbsOpRip.
> +        */
> +       if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> +               event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
> +
>         return 0;
>  }
>
> @@ -687,6 +697,14 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>                 data.raw = &raw;
>         }
>
> +       /*
> +        * rip recorded by IbsOpRip will not be consistent with rsp and rbp
> +        * recorded as part of interrupt regs. Thus we need to use rip from
> +        * interrupt regs while unwinding call stack.
> +        */
> +       if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> +               data.callchain = perf_callchain(event, iregs);
> +
>         throttle = perf_event_overflow(event, &data, &regs);
>  out:
>         if (throttle) {
> --
> 2.27.0
>
