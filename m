Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D2C570FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiGLByq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGLByo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:54:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9350E20F46
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31053615AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95671C341CB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657590882;
        bh=jai4unYoYEgmq9d0+NE1P3VEX4nsNsQTPUicfpX2T98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qbtg7wT1xzigRyUfeKQgY+bDFolYzHa8prAl/yt5FStmzlhg+n00NAK7IaoF7Swhr
         cRoMVeHEEQJ97eJ0JBMw0pzQlG5UkIEXWPulpab8vLM4Xg3BrLhK8XBBOTr15+DZh/
         2gn9ce749TknBA/9/JXFUQcCjqYyURO+/qTbpcu19MnLk7mDb1ML94CN7x2PQrdM2o
         vdfZdyikQckjFr9c68j1y2PDzw7a2ulsqpcdfWmeHYKNCc5sKmWYxZSTCL0LAM2i2w
         iZiYovAdVWMozPH89+FJtSeIK55qj22rVm5Cc4xotYR+WZGhPY+Ebck7jwYbrVb8DK
         0BS943y0OzcSg==
Received: by mail-vs1-f54.google.com with SMTP id d187so6529233vsd.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:54:42 -0700 (PDT)
X-Gm-Message-State: AJIora+4o/FN7UeC0YyjBr+UirWdVrY+9tZAwBzSYES2gzQyXIlvjGuQ
        gUu4/MGPKA0+4fa2YR/21/GzWtSx/2Y0m+CYBKM=
X-Google-Smtp-Source: AGRyM1uonhG1aIA7uUxN/Hmh1AaYTk5MdtW09YwB7rnwONdJmrKgrRXbRPHS15azbbpSISu0EpbhLOOsBS/vHuzSKCQ=
X-Received: by 2002:a67:e311:0:b0:357:58a3:6878 with SMTP id
 j17-20020a67e311000000b0035758a36878mr3274610vsf.2.1657590881589; Mon, 11 Jul
 2022 18:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220711174632.4186047-1-atishp@rivosinc.com> <20220711174632.4186047-3-atishp@rivosinc.com>
In-Reply-To: <20220711174632.4186047-3-atishp@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 12 Jul 2022 09:54:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT=0S-_nCM-+SHUNkG0i-h1zBca_KwgRgsZ8BBE-DPG_w@mail.gmail.com>
Message-ID: <CAJF2gTT=0S-_nCM-+SHUNkG0i-h1zBca_KwgRgsZ8BBE-DPG_w@mail.gmail.com>
Subject: Re: [v3 2/5] RISC-V: Update user page mapping only once during start
To:     Atish Patra <atishp@rivosinc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch, Is there any bug report?

Anyway:
Reviewed-by: Guo Ren <guoren@kernel.org>


On Tue, Jul 12, 2022 at 1:46 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> Currently, riscv_pmu_event_set_period updates the userpage mapping.
> However, the caller of riscv_pmu_event_set_period should update
> the userpage mapping because the counter can not be updated/started
> from set_period function in counter overflow path.
>
> Invoke the perf_event_update_userpage at the caller so that it
> doesn't get invoked twice during counter start path.
>
> Fixes: f5bfa23f576f ("RISC-V: Add a perf core library for pmu drivers")
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu.c     | 1 -
>  drivers/perf/riscv_pmu_sbi.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index b2b8d2074ed0..130b9f1a40e0 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -170,7 +170,6 @@ int riscv_pmu_event_set_period(struct perf_event *event)
>                 left = (max_period >> 1);
>
>         local64_set(&hwc->prev_count, (u64)-left);
> -       perf_event_update_userpage(event);
>
>         return overflow;
>  }
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 0cb694b794ae..3735337a4cfb 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -532,6 +532,7 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>                         sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
>                                   flag, init_val, 0, 0);
>  #endif
> +                       perf_event_update_userpage(event);
>                 }
>                 ctr_ovf_mask = ctr_ovf_mask >> 1;
>                 idx++;
> --
> 2.25.1
>


--
Best Regards
 Guo Ren
