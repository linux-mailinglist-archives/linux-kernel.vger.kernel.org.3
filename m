Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021F951E241
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444724AbiEFW1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378204AbiEFW1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:27:37 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC2047548
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 15:23:52 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id m203so4206929vke.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8FGKS1PL8k+5168owDaSwyN7g7teLABdV4iw5fydrU=;
        b=l/pXff84cIW4LQxunIpO81eiZvLP/xRhmbol62quz4f87GHSsIMV3Ie2tkPKNn4We4
         WNZrFRIfvJaTugHCO2z3e8GwN4RZ4OAWK1GTNkj1Z33HRYeXPGWOkHvXIU8rXOTP4BnX
         QdXZe5WuN/Ck0Do+Z360p6Xd3PjxSIbKhuxlUlVz2ILcSfyxIJjzOz+t/6HFjV4UqeP4
         XdFq0JMaUJFqZgLu0pmWOQEpx82QzQxOxV7E7UDFqTLrndQFArQSj6ciiEJz5d8ZIeb/
         uH9rCaP23RhTCZz/qYkmMhUVe/TXPI6fPYFjzfOX4RJlrKunKwh/o508rsmcy/nHLYDH
         gbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8FGKS1PL8k+5168owDaSwyN7g7teLABdV4iw5fydrU=;
        b=mwgxD9cGQcdfJsoad3Hq0O6nXY/SaQHGpOLJeQ10dWJacJt7/50U/6NT7yL5oVEPX1
         AGAR0iNcCG+3d4EIaT6YuLgIptYAodtLT36DrVzcpF1AHHjqvaqfwkzucDStz0l+8pQM
         p9wSQEs7XoSPiyHIvNHkY30vyIv617PIPRIrUF+fr7sFM9X2Wqjaqq+i07jJ5ZvoCLiS
         FMyq7wAVczRjZJdlzej2fNucRmkSL5PUT0mq/UuBLII8lPFtUJtqDdv9vlXdK6rybm7F
         EcUCiTHVAgw3s6H+2XRc2WEHSBWpuOMsVHeI5VrI/g8Wxn007JSZgsvM8ltfUzahZpsr
         qSgA==
X-Gm-Message-State: AOAM533wlZZkthRuZFHbd09xTTlchnXjIOyVmLWX/PU0Qbot+7N5qzud
        e0sBQaqDG8LNnfD5+TxFrC4ol2/PusUQAWq/OHPIpw==
X-Google-Smtp-Source: ABdhPJzNufoSr1uNuyS8ZXojRdgik4net/4CC3t7RbteR+0zZ/ZJb1k353DZukSbY8SLjYOAp0Be4TgupLOw086qSAo=
X-Received: by 2002:a05:6122:208f:b0:34e:b8ba:ec88 with SMTP id
 i15-20020a056122208f00b0034eb8baec88mr2113060vkd.0.1651875831656; Fri, 06 May
 2022 15:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220324181458.3216262-1-eranian@google.com> <20220506130915.GD22892@willie-the-truck>
In-Reply-To: <20220506130915.GD22892@willie-the-truck>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 6 May 2022 15:23:40 -0700
Message-ID: <CABPqkBRx5p_1z4n8i0yTgd8LTsXxgx+c+j0BBJmD6uA4GMowCg@mail.gmail.com>
Subject: Re: [PATCH v2] perf/arm: adjust hwevents mappings on boot
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mark.rutland@arm.com
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

On Fri, May 6, 2022 at 6:09 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Mar 24, 2022 at 11:14:58AM -0700, Stephane Eranian wrote:
> > The mapping of perf_events generic hardware events to actual PMU events on
> > ARM PMUv3 may not always be correct. This is in particular true for the
> > PERF_COUNT_HW_BRANCH_INSTRUCTIONS event. Although the mapping points to an
> > architected event, it may not always be available. This can be seen with a
> > simple:
> >
> > $ perf stat -e branches sleep 0
> >  Performance counter stats for 'sleep 0':
> >
> >    <not supported>      branches
> >
> >        0.001401081 seconds time elapsed
> >
> > Yet the hardware does have an event that could be used for branches.
> > This patch fixes the problem by dynamically validating the generic hardware
> > events against the supported architected events. If a mapping is wrong it
> > can be replaced it with another. This is done for the event above at boot time
> > and the kernel will log the remapping:
> >
> > armv8_pmuv3: hwevent HW_BRANCH_INSTRUCTIONS remapped  from 0xc to 0x21
> >
> > And with that:
> >
> > $ perf stat -e branches sleep 0
> >
> >  Performance counter stats for 'sleep 0':
> >
> >            166,739      branches
> >
> >        0.000832163 seconds time elapsed
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > ---
> >  arch/arm64/kernel/perf_event.c | 41 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index cab678ed6618..d438f5a46bdc 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -39,7 +39,7 @@
> >   * be supported on any given implementation. Unsupported events will
> >   * be disabled at run-time based on the PMCEID registers.
> >   */
> > -static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
> > +static unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
> >       PERF_MAP_ALL_UNSUPPORTED,
> >       [PERF_COUNT_HW_CPU_CYCLES]              = ARMV8_PMUV3_PERFCTR_CPU_CYCLES,
> >       [PERF_COUNT_HW_INSTRUCTIONS]            = ARMV8_PMUV3_PERFCTR_INST_RETIRED,
> > @@ -1222,6 +1222,42 @@ static void armv8_pmu_register_sysctl_table(void)
> >               register_sysctl("kernel", armv8_pmu_sysctl_table);
> >  }
> >
> > +static void armv8pmu_fixup_perf_map(struct arm_pmu *cpu_pmu)
> > +{
> > +     int i, code;
> > +     unsigned *map = armv8_pmuv3_perf_map;
> > +
> > +     for (i = 0; i < PERF_COUNT_HW_MAX; i++) {
> > +retry:
> > +             code = map[i];
> > +             if (code == HW_OP_UNSUPPORTED)
> > +                     continue;
> > +
> > +             if (test_bit(map[i], cpu_pmu->pmceid_bitmap))
> > +                     continue;
> > +             /*
> > +              * mapping does not exist,
> > +              * let's see if we can fix it
> > +              */
> > +             switch (i) {
> > +             case PERF_COUNT_HW_BRANCH_INSTRUCTIONS:
> > +                     if (code == ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED) {
> > +                             map[i] = ARMV8_PMUV3_PERFCTR_BR_RETIRED;
> > +                             pr_info("armv8_pmuv3: hwevent "
> > +                                     "HW_BRANCH_INSTRUCTIONS remapped "
> > +                                     " from 0x%x to 0x%x\n", code, map[i]);
> > +                             goto retry;
> > +                     }
> > +                     break;
> > +             default:
> > +                     pr_info("armv8_pmuv3: hwevent %d not supported\n", i);
>
> If a CPU supports neither ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED nor
> ARMV8_PMUV3_PERFCTR_BR_RETIRED, won't we get a funny series of messages
> here? I think I'd prefer to drop the prints altogether.
>
Ok, let me clean this up.

> Will
