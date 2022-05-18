Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D1252B5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiERJHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiERJHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:07:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ABB111BA6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:07:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d15so2475875lfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcrsvOrOm+mRa378F80R7USaGzcRNkSgm1WTWIJU7Qs=;
        b=dOowfJdUkCgdm+X0sjpkSjkrWinBHywOfRCJNbbQg4ZKVRGegBTMgRLgdR+HsHFGKZ
         r4xFbL1vipCRMWGmh9nB0S8FKnGjgZbtewcVMVPp2bWC2O5toghr+ux4gKsXPzoghRsL
         WUOnQv3yOcw7YQOVrDk5ku5tDcNRyvk2u7JzYf93lhPHoYGlKPeYZMMpRm5144bV2zcT
         WKvj/zSILDcgH344tlgTJ/s606MgwrrA+qjyxf8zFhmnLzroOMdt5L3scY4FFq/gcHxV
         O3nplaMJWPnZBHVE3SMXQM6BNUvxKU0DNP0ZV6fdaX6iLjwlISaAEUpqQ6h78DIHQUHc
         rK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcrsvOrOm+mRa378F80R7USaGzcRNkSgm1WTWIJU7Qs=;
        b=yROmjkG2C80i0VBQ/DrAiFuf6iDlkMkWEdpTNhko0eaokQY/LDL+iuBUJUWnj6v9Wj
         8CafjokjQyEEJS4pMdkq3/78yJoDEMrviTKB46Rs2GOyrtMgT0VrWMBLIGsvoXOSdr1y
         73R/hzQYdQb5idxhf9ugLJAJcVhC07tm2930UAE14HAw8P9i2x1+2VUD0aL3UvSI+Y0g
         QP6o/scqFnalzbvuvms6fB+Q3PtB8R9W5yzfTe9AAOpad1DVT1GIsCf4NXf1ReeT9+Yj
         3purFGMjBZet8FZ1gyp5c0ViBB33AO6k6oh9maN/w0HDsbiuv1g9AaTlGobpLTEGKtVX
         ipQg==
X-Gm-Message-State: AOAM532LHQPCw+/r9TZB/C8bqcwu3OkJCQtPeMST78mEGdp0TczWRWaG
        4htUo6LfZuFtrowuqSoQNNrvyIQLWWjPyvLHToWS6Q==
X-Google-Smtp-Source: ABdhPJzAelqtBPGCxXlfVN3acRhTDjVF3HlQ8kO0+AOIyERK7gjO1Z1UPKDGisPXmDCihnikdsCzfF2/c2VeEisQqRI=
X-Received: by 2002:a05:6512:168d:b0:471:6cb9:c20f with SMTP id
 bu13-20020a056512168d00b004716cb9c20fmr19895367lfb.229.1652864854579; Wed, 18
 May 2022 02:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220308205000.27646-1-mike.leach@linaro.org> <20220308205000.27646-9-mike.leach@linaro.org>
 <71c11820-433d-755d-0eb4-797313d693f9@huawei.com>
In-Reply-To: <71c11820-433d-755d-0eb4-797313d693f9@huawei.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 18 May 2022 10:07:23 +0100
Message-ID: <CAJ9a7ViS-nxhmzRs6LwHSqPzHSo11inZ+066aKe116ESr6ufvw@mail.gmail.com>
Subject: Re: [PATCH 08/10] coresight: Remove legacy Trace ID allocation mechanism
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, 17 May 2022 at 04:56, liuqi (BA) <liuqi115@huawei.com> wrote:
>
> Hi Mike,
>
> On 2022/3/9 4:49, Mike Leach wrote:
> > This static 'cpu * 2 + seed' was outdated and broken for systems with high
> > core counts (>46).
> >
> > This has been replaced by a dynamic allocation system.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   include/linux/coresight-pmu.h | 12 ------------
> >   1 file changed, 12 deletions(-)
>
> Seems coresight_get_trace_id() in tools/include/linux/coresight-pmu.h
> need to be deleted too.
>
> Thanks,
> Qi
>

Agreed - I'll sort it for the next release.

Thanks

Mike

> >
> > diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> > index 4ac5c081af93..bb4eb4de3c77 100644
> > --- a/include/linux/coresight-pmu.h
> > +++ b/include/linux/coresight-pmu.h
> > @@ -8,7 +8,6 @@
> >   #define _LINUX_CORESIGHT_PMU_H
> >
> >   #define CORESIGHT_ETM_PMU_NAME "cs_etm"
> > -#define CORESIGHT_ETM_PMU_SEED  0x10
> >
> >   /*
> >    * Below are the definition of bit offsets for perf option, and works as
> > @@ -32,15 +31,4 @@
> >   #define ETM4_CFG_BIT_RETSTK 12
> >   #define ETM4_CFG_BIT_VMID_OPT       15
> >
> > -static inline int coresight_get_trace_id(int cpu)
> > -{
> > -     /*
> > -      * A trace ID of value 0 is invalid, so let's start at some
> > -      * random value that fits in 7 bits and go from there.  Since
> > -      * the common convention is to have data trace IDs be I(N) + 1,
> > -      * set instruction trace IDs as a function of the CPU number.
> > -      */
> > -     return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
> > -}
> > -
> >   #endif
> >
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
