Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7574D6569
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiCKPzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350013AbiCKPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:55:22 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6972B151696
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:53:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j26so13609420wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/+HHt1c39G7ywBZBGDd9qnAziedqgoDMlKoB6IGpeA=;
        b=Nmim9p+XStxDNEaAN2FZW4KcwpMbcvvn1QwY/w4Aq1UMFUvc2CXbAeK9pAjDvTZjLr
         U2Fi3+LTIeGd1AI6eyYr/UdIJN9P4TrMddw/wo0AofryrnTNa8SP0Cu1dHkZIoC0RP8w
         ctaBGADjWmKJPz5pRxDl8kXK5zOS8CTjKfPtPLAbONBQIv+hSFeuc88KZ49pn8tGn6C/
         hVGRFNrvVcHqUGeOz6tcHkx69ycpl8HBNhoZYGNrCSIFzz2h3ksKQepD74eH04iNUy9R
         ewMueU7+0BL+LoxE98tG+eTHhCUCERkNTr5cgzJiJyDXboi/u6bpCTu+u4kAMHzSxITO
         nCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/+HHt1c39G7ywBZBGDd9qnAziedqgoDMlKoB6IGpeA=;
        b=aBENrAsmaqSAz3g/soIAzp4d0SWVzX4oSaFaEj081c96mbvJD8o8Vzd5GFfy2v42xL
         kLBa+9qHLjrFxeg7LtoR7Y0xU1dvtcU0HC7cQOPCNHXfd9+2le2DcivZK8s50o+GVjd5
         LlaQvKRMxUpFeR2GHzPRgFrZodpG63Y5cQf9Q5ih567R69a3moPsQk8+/xFFNMy+2IdY
         6HLxX5W/8JLS0jt6V8GQIPeDdl9phqsN/5fVzZksiZ8ThO/b538vuwlU9Bv/pe2g5mus
         lEanxG/YCpa1roUK/0DeMhGyn3UMHGElVEbgM6SmNeereVPmyl/FYGFRxUasPSc40LyH
         265g==
X-Gm-Message-State: AOAM532k6meMN1OpfDOHTec9w6Q2F82D9xGhueizOeXHrEPIBg0NybZj
        z2r5DAX1HvYGjB2i/xbBzN27Q5RH8F0sGWm9JKXjjg==
X-Google-Smtp-Source: ABdhPJzHdL8dpugKSarloUyddBzEwPBmBD6XrTKj9A429IAY747PSW744PUT05MeeLe5m+lw7jp+8qBYsHYD7XtjO6Y=
X-Received: by 2002:adf:e108:0:b0:1ef:97ad:5372 with SMTP id
 t8-20020adfe108000000b001ef97ad5372mr7705296wrz.658.1647014025860; Fri, 11
 Mar 2022 07:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20220113091056.1297982-1-james.clark@arm.com> <20220113091056.1297982-3-james.clark@arm.com>
 <50e5ff63-ae00-f04b-fc5b-f294742cb13a@arm.com> <292386ee-cfa8-d849-57ce-156c76680e12@arm.com>
In-Reply-To: <292386ee-cfa8-d849-57ce-156c76680e12@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 11 Mar 2022 15:53:41 +0000
Message-ID: <CAJ9a7VjiYrnQKUBkcQPs-iJomxFUAJ9Wmq0A+JwN4O_bbqhX1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] coresight: Fail to open with return stacks if they
 are unavailable
To:     James Clark <James.Clark@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Fri, 11 Mar 2022 at 14:52, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 28/01/2022 11:24, Suzuki K Poulose wrote:
> > Hi James
> >
> > On 13/01/2022 09:10, James Clark wrote:
> >> Maintain consistency with the other options by failing to open when they
> >> aren't supported. For example ETM_OPT_TS, ETM_OPT_CTXTID2 and the newly
> >> added ETM_OPT_BRANCH_BROADCAST all return with -EINVAL if they are
> >> requested but not supported by hardware.
> >
> > Looking at this again (with similar comment to the Branch Broadcast),
> > won't it disable using retstack on all CPUs, even when some of them
> > support it ?
> >
> > i.e., CPU0 - supports retstack, CPU1 - doesn't
> >
> > A perf run with retstack will fail, as CPU1 doesn't support it (even
> > though we advertise it, unconditionally).
> >
> > So, if we ignore the failure, this would still allow CPU0 to use
> > the feature and as long as the OpenCSD is able to decode the trace
> > we should ignore the failure ?
> >
> > I think we may also need to tune the etm4x_enable_hw() to skip
> > updating the TRCCONFIGR with features not supported by the ETM
> >
>
> Hi Suzuki,
>
> I'm picking up this branch broadcast change again after the haitus.
>
> For this point, do you think it would be worth distinguishing between "no
> known CPUs that support the feature" vs "not currently running on a
> CPU that supports it but there are others that do"?
>
> Also would we want to distinguish between per-CPU or per-process events?
> For the former it actually is possible to fail to open because all of
> the information is known.
>
> I'm just thinking of the case where someone asks for a load of flags
> and thinks that they're getting them but get no feedback that they won't.
> But I understand having some complicated solution like I'm suggesting
> might be even more surprising to users.
>
> Maybe the cleanest solution is to ask users to supply a config that
> can work on anywhere the event could possibly be scheduled. It doesn't
> really make sense to have retstack on a per-process event on big-little
> and then getting half of one type of data and half of another. It would
> make more sense to fail to open in that case and they have the choice of
> either doing per-CPU events or disabling retstacks altogether.
>

return stack has no effect on the decoder output whatsoever. The only
effect is to reduce the amount of traced addresses at the input
(leaving more space for other trace),
so it is irrelevant if CPU0 supports it but CPU1 doesn't.

sequence:

BL r0 (return stack is used only on link instructions)
...
RET

will output trace:-
ATOM E (BL r0)
...
ADDR_ELEM <ret addr>
ATOM E (RET)

for no return stack,

ATOM E (BL r0)
...
ATOM E (RET)

fior return stack.

In both cases the decoder will push the address after BL r0 onto its
return stack.

In the first case the decoder will use the supplied address, in the
second will pop the top of its return stack.

The decode output in both cases will be "branched to r0, ran code,
returned via link register"

The outcome is identical for the client. So the case for not tracing
on a core that does not have return stack if specified is weak.

Perhaps a warning will be sufficient?

Mike



> This seems like a similar problem to the issue causing the Coresight self
> test failure where a certain sink was picked that couldn't be reached and
> the test failed.
>
> In that case the change we made doesn't quite match up to my suggestion here:
>
>  * Per-cpu but an unreachable sink -> fail
>  * Per-process and potentially reachable sink in the future -> pass
>
> Maybe it would have been better to say that the sink always has to be
> reachable otherwise is the outcome predicatable?
>
> James
>
> > Suzuki
> >
> >
> >>
> >> The consequence of not doing this is that the user may not be
> >> aware that they are not enabling the feature as it is silently disabled.
> >>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++----
> >>   1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> index 04669ecc0efa..a93c1a5fe045 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> @@ -674,10 +674,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
> >>       }
> >>         /* return stack - enable if selected and supported */
> >> -    if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
> >> -        /* bit[12], Return stack enable bit */
> >> -        config->cfg |= BIT(12);
> >> -
> >> +    if (attr->config & BIT(ETM_OPT_RETSTK)) {
> >> +        if (!drvdata->retstack) {
> >> +            ret = -EINVAL;
> >> +            goto out;
> >> +        } else {
> >> +            /* bit[12], Return stack enable bit */
> >> +            config->cfg |= BIT(12);
> >> +        }
> >> +    }
> >>       /*
> >>        * Set any selected configuration and preset.
> >>        *
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
