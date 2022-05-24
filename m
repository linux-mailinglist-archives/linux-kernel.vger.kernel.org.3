Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19285328D3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiEXLWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiEXLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:22:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0E878907
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:22:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p19so1938120wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bP8kRhNwmItUataEWlKC3/a9/zDgSR+UCaI4XtaJeW8=;
        b=XzMEoSZMGBZwlINe84xBxoGx1pKIgVbH99vxCzUkPIJzN3JV0eDFsCR8EAx/1BygLJ
         cePe2lrU+5GgaHk+UR8j+kecsKslpF/sU0BVFAmewkEObHuVLp/pcJ4cBRux2GupvwxR
         cMW11jOIirzCYBcEIjHYc3LlTXrLnCg80SWwOUfgBUdi98+F2fOPcdV/An2ZIYxZJqB5
         V+ukL+BZGcB+6UUe3A5Tht/JpbErBZjDv3ZKFKlKj2nhxsG306pNeiHeRDWrmorkCzP4
         XhtP2PDthBK4pw5omr8V52y0ul+yqw/3qxueGmkCFMGeE2U5MBBgJXlL4MqlHuZxYuPv
         vNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bP8kRhNwmItUataEWlKC3/a9/zDgSR+UCaI4XtaJeW8=;
        b=cTcodiJgviSrPml+c72ymXAhQk7CR4sowKxLxG+xfmldqA3Uoki4EboIxa/RJkFUB+
         Y+qGLNg0Dscaa3WdCErh3x8wD7i8rk/FYignH9CKDK3P3Re0awher7sOQIjsDOU8bCaL
         /VG3tRI1VMNfMhggPh1lHcEZ8dZxd0NMeLLl+HgSq3/02NQacXPwUdgXuDAONvgW4zi+
         b2OIAEuGTIouE9Q3rnZ6KrwYx50p8Vo43Lw1r3bH+a27OydOVOSqpkcVwSbYJonAhx16
         hTuyor1NpsGArDuuDls7wM5WW0T7Em0Rs7O0jnazfYeSQHrfWCPdbAOCyCEkc4jQaZuQ
         MekQ==
X-Gm-Message-State: AOAM531yAnhWZZXApGELkbLqfbq135aMDsnKQ4M07YxqpSavIkFvye9g
        B4cv0IQDMWxPfqqdyk7pxZ1tRExrQf0r4IwDIZrBoinjkt+2K68r
X-Google-Smtp-Source: ABdhPJyR7B9J7D6CK1B3dMJZTSB7iWaPjyVVDnv/Tx1ucz4fNWMDrPaLFUufih2NH30uRYzTEFWy8jR8vcxupKx59wk=
X-Received: by 2002:a05:600c:4fd5:b0:394:55ae:32c7 with SMTP id
 o21-20020a05600c4fd500b0039455ae32c7mr3332614wmq.73.1653391358329; Tue, 24
 May 2022 04:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220513015522.910856-1-atishp@rivosinc.com> <20220513015522.910856-4-atishp@rivosinc.com>
In-Reply-To: <20220513015522.910856-4-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 24 May 2022 16:52:26 +0530
Message-ID: <CAAhSdy23vE8+HxU5Jxy2rBMjy3rBTrJt_4sriuROac_sEESSVw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] RISC-V: Fix SBI PMU calls for RV32
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 7:25 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> Some of the SBI PMU calls does not pass 64bit arguments
> correctly and not under RV32 compile time flags. Currently,
> this doesn't create any incorrect results as RV64 ignores
> any value in the additional register and qemu doesn't support
> raw events.
>
> Fix those SBI calls in order to set correct values for RV32.
>
> Fixes: e9991434596f ("RISC-V: Add perf platform driver based on SBI PMU extension")
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 7ad92039a718..fab0dd497393 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -274,8 +274,13 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
>                 cflags |= SBI_PMU_CFG_FLAG_SET_UINH;
>
>         /* retrieve the available counter index */
> +#if defined(CONFIG_32BIT)
> +       ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase, cmask,
> +                       cflags, hwc->event_base, hwc->config, hwc->config >> 32);
> +#else
>         ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase, cmask,
>                         cflags, hwc->event_base, hwc->config, 0);
> +#endif
>         if (ret.error) {
>                 pr_debug("Not able to find a counter for event %lx config %llx\n",
>                         hwc->event_base, hwc->config);
> @@ -417,8 +422,13 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>         struct hw_perf_event *hwc = &event->hw;
>         unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>
> +#if defined(CONFIG_32BIT)
>         ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
>                         1, flag, ival, ival >> 32, 0);
> +#else
> +       ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
> +                       1, flag, ival, 0, 0);
> +#endif
>         if (ret.error && (ret.error != SBI_ERR_ALREADY_STARTED))
>                 pr_err("Starting counter idx %d failed with error %d\n",
>                         hwc->idx, sbi_err_map_linux_errno(ret.error));
> --
> 2.25.1
>
