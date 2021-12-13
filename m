Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5E24727EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbhLMKGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbhLMKBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:01:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AF5C09B133
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:49:09 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso13593927wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcSDirnuruPYtCN32bQ78CUK9bGGfX21Psk5mubRymc=;
        b=rx86q3KyeOaDPbmRyuxzvLBUSlHYCv4JC/1G0pwjzcdS1VIR3XaYXGb5cFsnaZK2ZX
         V7+w9fU2jsxuiU79JaVhajtALFAB/FyHQKiogR2VH+nlh9VzJI8jua/mcgGx2TmFL4i8
         mPLsdrQVtk0HaW45aCnIzH8X2N9RHvTcBMDINJJENW+Z6YCsfZiTjH3OPjaFCkRrryTc
         LcA+rCiUYLBZYbE7KqXnx7rQTdDyllJLKIymh0EUSBLHGPoDH5NCpNPuf1hbwceKDydx
         4opHq2T1wUhJY7PPo3wROeBOC0TZZDKeCb3GnZ+nzc+hcChIfTzw88EVO1zcXB18j77c
         yGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcSDirnuruPYtCN32bQ78CUK9bGGfX21Psk5mubRymc=;
        b=Y61GM8wqPeDw4fJ0ex0Ezc8rHNrXIipsSOxe/ZF1oy+csWHPPBSFSV/lrG0aD1xICo
         8hSo/cjI5IylmxaFvKlCkM9/axG5RUj7PQ9HpAewZ8vMlU9g5sB2NWfiSYd6BQAla61h
         wdpWLsxZsahnn3f7W6AdzyxoLUkuRtv13H85XeFyj4MiRdLGq7by0M2RN0IM2oHHEK5d
         JEQSCVCIldCviC+Djw6x6v3+c+6eLOiEOe3CAkbuaeQBu4UCdN3DhejVMeADg9tzDVNh
         CdnfybTsg2jh4RpwopYw5UaZ7a7T3eb/uu3X+R0Liz6aOpvmV2q4t1l6Eo1HWa6EhMuH
         UoKA==
X-Gm-Message-State: AOAM530s1vxzJvbR+CSpmsc4VIuMXgHY6Fn0UiXDnKAAKyQs3lK2bI4O
        lt7/YaCpfjkzvwWZ4vjB87xcNS/7YG78sijr/ZYLaw==
X-Google-Smtp-Source: ABdhPJwGPvf897zKrfEaiVQJPiIpbfihpMX+HCalDhTRUPfCDbostdOtET6QWAEYoG0Z+/501Ad5gXEmSDuLKQR2nzs=
X-Received: by 2002:a1c:a5c3:: with SMTP id o186mr36876304wme.63.1639388947467;
 Mon, 13 Dec 2021 01:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20211208160907.749482-1-james.clark@arm.com> <20211208160907.749482-2-james.clark@arm.com>
 <b52ef2f3-9e30-59a6-2aea-e46c93915868@arm.com> <b61ef2e3-e573-4867-af5d-fd5fabece4b1@arm.com>
 <20211210172220.GA1238770@p14s>
In-Reply-To: <20211210172220.GA1238770@p14s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 13 Dec 2021 09:48:55 +0000
Message-ID: <CAJ9a7VgBxO0-R4jX6+-Vu10DtcsOeMiq9YrPkEEFQ=6ixNXXVQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] coresight: Fail to open with return stacks if they
 are unavailable
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     James Clark <James.Clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

A couple of points - relating mainly to docs:

1. Activating branch broadcast overrides any setting of return stack.
As a minimum there needs to be a documentation update to reflect this
-Setting both options is not prohibited in hardware - and in the case
where we can use branch broadcast over a range both are then relevant.

2. A documented note to reflect that choosing this option will result
in a significant increase in the amount of trace generated - possible
danger of overflows, or less actual instructions covered. In addition
perhaps documents could reflect the intended use-case for this option,
given the disadvantages.

3. Has this been tested in a situation where it will be of use?
Testing against static code images will show the same decoded trace
output as not using branch broadcast. (although the packet dumps will
show additional output)

Given a primary use is for situations where code is patched or
dynamically altered at runtime - then this can affect the full decode
output. If the code is being patched to only alter the branch
addresses then decode should work against static images.
If, however, we are tracing code that adds in new branches, on top of
NOPs for example, then the decoding against the original static image
will be wrong, as the image will have the NOPs, rather than the branch
instructions so the apparent location of E atoms will be in a
different position to the actual code. Is there anything in perf that
will ensure that the patched code is presented to the decoder?

If there are potential decode issues - these too need documenting.

Other than the documents and testing,  I cannot see any issues with
this patch set in terms of setting and enabling the option.

Regards

Mike


On Fri, 10 Dec 2021 at 17:22, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Hi James,
>
> On Thu, Dec 09, 2021 at 11:13:55AM +0000, James Clark wrote:
> >
> >
> > On 09/12/2021 11:00, Suzuki K Poulose wrote:
> > > On 08/12/2021 16:09, James Clark wrote:
> > >> Maintain consistency with the other options by failing to open when they
> > >> aren't supported. For example ETM_OPT_TS, ETM_OPT_CTXTID2 and the newly
> > >> added ETM_OPT_BRANCH_BROADCAST all return with -EINVAL if they are
> > >> requested but not supported by hardware.
> > >>
> > >> The consequence of not doing this is that the user may not be
> > >> aware that they are not enabling the feature as it is silently disabled.
> > >>
> > >> Signed-off-by: James Clark <james.clark@arm.com>
> > >> ---
> > >>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++----
> > >>   1 file changed, 9 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > >> index d2bafb50c66a..0a9bb943a5e5 100644
> > >> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > >> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > >> @@ -674,10 +674,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
> > >>       }
> > >>         /* return stack - enable if selected and supported */
> > >> -    if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
> > >> -        /* bit[12], Return stack enable bit */
> > >> -        config->cfg |= BIT(12);
> > >> -
> > >> +    if (attr->config & BIT(ETM_OPT_RETSTK)) {
> > >> +        if (!drvdata->retstack) {
> > >> +            ret = -EINVAL;
> > >> +            goto out;
> > >> +        } else {
> > >> +            /* bit[12], Return stack enable bit */
> > >> +            config->cfg |= BIT(12);
> > >> +        }
> > >
> > > nit: While at this, please could you change the hard coded value
> > > to ETM4_CFG_BIT_RETSTK ?
> > >
> > I started changing them all because I had trouble searching for bits by name but then
> > I thought it would snowball into a bigger change so I undid it.
> >
> > I think I'll just go and do it now if it's an issue here.
>
> I can apply this set right away and you send another patch to fix all hard coded
> bitfields or you can send another revision with all 4 patches included in it
> (bitfields fix plus these 3).  Just let me know what you want to do.  And next
> time please add a cover letter.
>
> Thanks,
> Mathieu
>
> >
> > > Otherwise, looks good to me
> > >
> > > Suzuki



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
