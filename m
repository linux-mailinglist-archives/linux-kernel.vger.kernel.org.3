Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E553E5960BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiHPRAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbiHPRAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:00:41 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC387786E6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:00:40 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31f445bd486so167484067b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AFXUApVom+DNuZKpfEUejz7pP/LfFyAYaE0Pt08DBKU=;
        b=haVwI37xfonrnZIKY8V7jvDBWI9LEDFeEGXNJs8lgC/bxW9jgvMfpZxBtmpnftr5Um
         EX9HLT6pjIdGGDDhGLWWfn0kiXYqYtEP0w/1aFCp22dTSJm7bRUNnxtosK98hjCfQSjo
         GezoF4GX7vbJSNAKHHWbAJWsItDW/XQ+SlVzZlBR2O2oc4AG6mWA/1G3SjY3uUpMY8Kl
         DFCYAybiXXg8VwnncjhQ9tJX9SlLA3fFFjBAZVt0FprWrD9qnxFBhs5pcZ/CtAC+Duwg
         /dG4R3rRGm9tbcfWjV+2dF53GBag37NwCGm7CFTkj5i3JMx17aDAuZ2yOOOLMsxYNk4R
         fPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AFXUApVom+DNuZKpfEUejz7pP/LfFyAYaE0Pt08DBKU=;
        b=vQ7OkteZb1OUjYzZpZR1zE3Q8rKvzwaDIF+FyHf04718IZShcqxwLRkLcPBmTtnf42
         dmZA8kY3TB9i0eWfWLtiaZA8H8doGkLep7M57alQnYSSrr8eqD8M3V6c9t+78Xljedo+
         X80OQENCd8xZ6XnhxbMQN8ZF6atnXsKc6U6Q+EBFnet3dlUPFvN2/0EUCHmspHV0vEcW
         yDrm71DvZdnvuzxaOLtCbF3i4s3rlfRFo2YRGVZlS5jwN8tBM+tNPigyAN0eRiJE9axf
         xQMFxcp2IC3ycxCvm8VO6tJj9NG8AL0Erkato72wmuHkjioAfjc455SfzH+txzpkNSyc
         nZQQ==
X-Gm-Message-State: ACgBeo1fE7Om80n4B9GyiJ29Jf2MP4Nz0+MI5w2P9LGliLcN0dycBv4A
        KsyTLhHvy/DlY81l40vWjdcUWbLL+8HYgXQIZ30Cxg==
X-Google-Smtp-Source: AA6agR7OimpQPwJJIpSO4Sw9pAkvcSmYHrPH+JP+mYVuD9PEj3WRkBPmDWQFqzjGuujaEveJUZSaDUIBus0+5cX8CmY=
X-Received: by 2002:a0d:e745:0:b0:320:ae6a:ac06 with SMTP id
 q66-20020a0de745000000b00320ae6aac06mr17027700ywe.185.1660669239852; Tue, 16
 Aug 2022 10:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220816130221.885920-1-peternewman@google.com> <YvunKCJHSXKz/kZB@FVFF77S0Q05N>
In-Reply-To: <YvunKCJHSXKz/kZB@FVFF77S0Q05N>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 16 Aug 2022 19:00:29 +0200
Message-ID: <CALPaoCjJyYW68Vn1CNbf0Asggyu1AY68DbqcoK5n5FcXqeybJA@mail.gmail.com>
Subject: Re: [PATCH v3] perf/arm: adjust hwevents mappings on boot
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, Stephane Eranian <eranian@google.com>
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

On Tue, Aug 16, 2022 at 4:18 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On big.LITTLE systems this is array is shared by multiple PMUs, so this cannot
> be altered based on a single PMU.
>
> Rather than applying a fixup, could we special-case this at mapping time?
>
> Does the following work for you?
>
> Thanks
> Mark.
>
> ---->8----
> From 6cf78ec72194296e8d0c87572b81f2b02a097918 Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Tue, 16 Aug 2022 15:16:23 +0100
> Subject: [PATCH] arm64: pmuv3: dynamically map
>  PERF_COUNT_HW_BRANCH_INSTRUCTIONS
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>


Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Peter Newman <peternewman@google.com>


> ---
>  arch/arm64/kernel/perf_event.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cb69ff1e61380..0435adee5cab8 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -45,7 +45,6 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
>         [PERF_COUNT_HW_INSTRUCTIONS]            = ARMV8_PMUV3_PERFCTR_INST_RETIRED,
>         [PERF_COUNT_HW_CACHE_REFERENCES]        = ARMV8_PMUV3_PERFCTR_L1D_CACHE,
>         [PERF_COUNT_HW_CACHE_MISSES]            = ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
> -       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
>         [PERF_COUNT_HW_BRANCH_MISSES]           = ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
>         [PERF_COUNT_HW_BUS_CYCLES]              = ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
>         [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
> @@ -1050,6 +1049,28 @@ static void armv8pmu_reset(void *info)
>         armv8pmu_pmcr_write(pmcr);
>  }
>
> +static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
> +                                     struct perf_event *event)
> +{
> +       if (event->attr.type == PERF_TYPE_HARDWARE &&
> +           event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS) {
> +
> +               if (test_bit(ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
> +                            armpmu->pmceid_bitmap))
> +                       return ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED;
> +
> +               if (test_bit(ARMV8_PMUV3_PERFCTR_BR_RETIRED,
> +                            armpmu->pmceid_bitmap))
> +                       return ARMV8_PMUV3_PERFCTR_BR_RETIRED;
> +
> +               return HW_OP_UNSUPPORTED;
> +       }
> +
> +       return armpmu_map_event(event, &armv8_pmuv3_perf_map,
> +                               &armv8_pmuv3_perf_cache_map,
> +                               ARMV8_PMU_EVTYPE_EVENT);
> +}
> +
>  static int __armv8_pmuv3_map_event(struct perf_event *event,
>                                    const unsigned (*extra_event_map)
>                                                   [PERF_COUNT_HW_MAX],
> @@ -1061,9 +1082,7 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
>         int hw_event_id;
>         struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
>
> -       hw_event_id = armpmu_map_event(event, &armv8_pmuv3_perf_map,
> -                                      &armv8_pmuv3_perf_cache_map,
> -                                      ARMV8_PMU_EVTYPE_EVENT);
> +       hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
>
>         if (armv8pmu_event_is_64bit(event))
>                 event->hw.flags |= ARMPMU_EVT_64BIT;
> --
> 2.30.2
>

Hi Mark,

I can confirm that your patch fixes the issue we saw.

Thank you for coming back with this quickly, it looks like a better
solution to me.

Which branch were you going to apply it to?

Thanks!
-Peter
