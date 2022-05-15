Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C58527A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 00:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiEOWDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 18:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiEOWDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 18:03:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2F21AF1D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 15:03:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g17so48752wrb.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6KgFIoTEDTwhwOLvn3saZMZ1rCqGrc7yPCbdnB9MBs=;
        b=rxWuw3gsSpLnyReYLTqvIojrR5M5FFUxltFJYlGP6aG0BMxQzpZ9tAsa4Bw3mJcM/F
         /4qODSr6hkpf7u7Nq4+S4wBx+7MbaMHQuIZYQB6Ycz1lBY2kMPcbLWmVgTCfbIScYo1L
         L2ZQ1prdq6t7b7kKB3k7Si9VbsZ0Tszg8n5PiTTxsbHgeXz3jcs+DB2GLFYYFh93Fvkn
         Ry1wlfKYY/rqeB/jgDKFfovmS4x4hRXR0E743NFpqu08fq7JdnYiayCSR24KS5TfFfk7
         OW7VV4xvCJClPv6DU4jvPBfIuqqpVIZqE6mwK5wVVEuVn2EHNyN1fk83W082O/9mjiXl
         WoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6KgFIoTEDTwhwOLvn3saZMZ1rCqGrc7yPCbdnB9MBs=;
        b=HVPBdx1ItoOpLItvP9xtjgB8R4VdVdNHFvbZSm68AzMb+3m8zOMa1cIbfYjnJtA3EO
         KtevpWaNFgc2YJFNRVijioRZ54p5gvqraoOQPJ71Pltvy7Y35ggvJMXIb2ald4il29Cs
         1dFbGlEYYYuP+QDgN9EmbzQxrxZe5mrDENm1mAHqi8QvWK26Xy9XEq2LGTxghXFql29d
         fIXn27ZEx5H9aly/hwbh3lLE47QoZzrLJQBhQ8WFTF4ztKJ3SJzIi/pOKTC9CsEEL/tM
         NInbAxiJLZjyQugCVx4u4jKgIlmjsOF8glogvkyVvRhWqYi7ExSZVgDH+MDi3lQ47ocu
         9AdA==
X-Gm-Message-State: AOAM5301RNMclmeVdR3G4cYm+5ooz+icwFQATj1Bd1XSoL5QQsnEwAhp
        AEsxQ4mcv7SsxUZlcGkH9NpxYSVk/DQLNLwsDqaz4A==
X-Google-Smtp-Source: ABdhPJw4xLXXetOisRxdasD+cuGFxF1LTeEJIEa5INKvIQ2jB3bPcwQcMF7ABTxmqZkwmXY/nJ5GwpqcBvnVx0Cx7Bo=
X-Received: by 2002:a5d:448d:0:b0:20d:744:7663 with SMTP id
 j13-20020a5d448d000000b0020d07447663mr2894602wrq.654.1652652209822; Sun, 15
 May 2022 15:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <YnqJwMfi/bcDmN4H@kernel.org> <b1081013-2cd9-f223-8125-d7e51d784f90@huawei.com>
 <eec03f0d-d491-511c-d9b0-694c6d527b38@arm.com> <1062b28d-9c7b-89fb-d3bf-519f84029b96@huawei.com>
In-Reply-To: <1062b28d-9c7b-89fb-d3bf-519f84029b96@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 15 May 2022 15:03:17 -0700
Message-ID: <CAP-5=fWYU1hzhGTc6q_u9r82g+rbn18+-i9o0W8sUVyk+t694w@mail.gmail.com>
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     John Garry <john.garry@huawei.com>
Cc:     Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 8:53 AM John Garry <john.garry@huawei.com> wrote:
>
> On 12/05/2022 14:01, Nick Forrington wrote:
> > On 10/05/2022 16:55, John Garry wrote:
> >> On 10/05/2022 16:50, Arnaldo Carvalho de Melo wrote:
> >>> Em Tue, May 10, 2022 at 11:47:38AM +0100, Nick Forrington escreveu:
> >>>> Add Performance Monitoring Unit event data for the Arm CPUs listed
> >>>> below.
> >>>>
> >>>> Changesets are dependent due to incremental updates to the common
> >>>> events
> >>>> file and mapfile.csv.
> >>>>
> >>>> Data is sourced fromhttps://github.com/ARM-software/data
> >>> Waiting for reviews to merge this.
> >>>
> >>
> >> I'll have a closer look this week
>
> Generally this looks ok:
>
> Reviewed-by: John Garry <john.garry@huawei.com>
>
> If you are feeling particularly helpful then you can add support for any
> events missing to pre-existing core support, like a57-a72.
>
> Thanks,
> john

I'll raise John's "ok" and say this looks great! :-D Some thoughts:

The mapfile.csv cpuid values don't directly align with:
https://github.com/ARM-software/data/blob/master/cpus.json
but this definitely looks deliberate.

The new events lack the PMU "Unit" value. The current perf json is
pretty free form and leads to problems if two PMUs are present.
Context is here:
https://lore.kernel.org/lkml/CAP-5=fWRRZsyJZ-gky-FOFz79zW_3r78d_0APpj5sf66HqTpLw@mail.gmail.com/

My idea to rationalize this is to mirror what is already done in
sysfs, that is the event data is specific to a PMU. As a lot of "Unit"
values are missing from events on x86 a reasonable guess if the "Unit"
is missing is to use "cpu". Poking a Google Pixel 4a, I see that all
PMU data is in "armv8_pmuv3". So for ARM I could guess this is always
the case, ie all events should belong to armv8_pmuv3. This may not be
right and could lead to confusion like an event BR_COND_MIS_PRED
having an alias of "armv8_pmuv3/BR_COND_MIS_PRED/" but it really
should have some other PMU name in there. I just raise this in case
there is a fix for this we could incorporate into this patch series,
maybe "armv8_pmuv3" is always the PMU and my life is easy.

Thanks,
Ian
