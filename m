Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A2D570FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiGLBpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiGLBpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:45:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E181BEA3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46CFDB81628
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8F2C341CB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657590316;
        bh=ug3EM0lWD6FBtLJmvnDlTpopo55TsPF/PU14j4ote2o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZWk4O0+SICYK/UoA6NSPCMfkpdSVKyDu4idYp1/QzOCT6v1w9Wcq8WRtbTGOv5als
         7Kj7D7xfU2VOpmglfedxu7/uyD13jxIaB98hSTw9+24rFyHB31uf8TMyYVA7Nji78L
         SGpphqI7Io28zZgGg0iC5p/u9bQu+9aJkvN+7Y0EjkZJ2CFjC9TwFieq4ePd1eu6nN
         e5dciWgwyWTsBQUw8EnGgkYbxlW1lZLCelKkF1gsQPnGopo/hY5km95rEieLDy5NN5
         Su+oyuyiicHd5gp/nBRohCsHL+a1hPAa3B8oEJneIgYqAYEdEW2KekIDS6JSBjKtoL
         aeQcJRlfAzaKg==
Received: by mail-vs1-f44.google.com with SMTP id 189so6548622vsh.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:45:15 -0700 (PDT)
X-Gm-Message-State: AJIora95krS58Zki3z1EG7EFPSYWYo/djwtTLCWJ6pg6xszSPerNFvOG
        TXLBChffMLkbcsCMvLmiTL61y95Ux54H5b6rHRE=
X-Google-Smtp-Source: AGRyM1vAwFRACPEu1U1egIdw7WpvZsw4rgeb1YS+FcEt4kHUvLXb3rS/nPFG9yOVaqbk2/arVNwfuusgtfiULf/141s=
X-Received: by 2002:a67:e311:0:b0:357:58a3:6878 with SMTP id
 j17-20020a67e311000000b0035758a36878mr3266147vsf.2.1657590314910; Mon, 11 Jul
 2022 18:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220711174632.4186047-1-atishp@rivosinc.com> <20220711174632.4186047-2-atishp@rivosinc.com>
In-Reply-To: <20220711174632.4186047-2-atishp@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 12 Jul 2022 09:45:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT2G7A5+sdhrvuMxtVEwOxS976EguP6Fp1uxhDaxGZfYg@mail.gmail.com>
Message-ID: <CAJF2gTT2G7A5+sdhrvuMxtVEwOxS976EguP6Fp1uxhDaxGZfYg@mail.gmail.com>
Subject: Re: [v3 1/5] RISC-V: Fix counter restart during overflow for RV32
To:     Atish Patra <atishp@rivosinc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
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

Reviewed-by: Guo Ren <guoren@kernel.org>

On Tue, Jul 12, 2022 at 1:46 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> Pass the upper half of the initial value of the counter correctly
> for RV32.
>
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index dca3537a8dcc..0cb694b794ae 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -525,8 +525,13 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>                         hwc = &event->hw;
>                         max_period = riscv_pmu_ctr_get_width_mask(event);
>                         init_val = local64_read(&hwc->prev_count) & max_period;
> +#if defined(CONFIG_32BIT)
> +                       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
> +                                 flag, init_val, init_val >> 32, 0);
> +#else
>                         sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
>                                   flag, init_val, 0, 0);
> +#endif
>                 }
>                 ctr_ovf_mask = ctr_ovf_mask >> 1;
>                 idx++;
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren
