Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EA35A412E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiH2DAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiH2DA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:00:28 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A77BC97
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:00:26 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3376851fe13so164882027b3.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FxEqGVOxWo4CfjZbtxIGb6qGKvvik/aFKVrft6obxao=;
        b=Ls6cq9vBmUp9sU96vVz3RUD5Ups9j1qMMOUCDJGBfRwWfZmcptBunhaKBP1bY0xDRl
         mDbPVoKd0xLW4LcA73K8vDo5iFO6JzlBT35KedPwWKWrEkrcx/W2YucdD1ef8IcsW0ra
         aQUNRHz1fQ5eE4YiiLsGIe2rxAn5rscIPWB4xkl1Su0YzmYWD8Nj6jpRqXyloArxhfpJ
         HVeAK84ZNeDyPtc9yxTFLqZNYQdQnGVgD37bFpWf3vndNUaJzqgiKFzDqGi/CLdT52pZ
         f57c7IIhG0uNgW+lvvq0QpNI1ZERNGlyJyZpJQgt8EKCK0xYIxWplDx087/XyyHBNUh4
         iJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FxEqGVOxWo4CfjZbtxIGb6qGKvvik/aFKVrft6obxao=;
        b=pJcPz0DzIOC1kndRvTFqwA00KVPSw73OPV3nnFIzYYCZGPOjjbs2MFvUGmx7LpZzhY
         FYUz81yU4RjcJmJ/Z94MEqb46FQmGW9aL1lJ475e6ubcdjssi3uPltGRagmF7oPrE8AS
         zeWOibMSiES8kAs/GoDJSSAW3AwmMayzeQpLwZlgyrBqeq9MUGEIdWDxLrwCmyLbiiVh
         +kF5aawX37v7856P/OWr474N1lqWQPupIFDICDMVKR2UYi8gjLFG6SH84n7l83L7YO9o
         UI++nQC2rW0D52cae0ePNxSyFw+zO8DlFilCvkzZc23qWUaS+iJ3QSP5aH1leTrPRT6U
         rKZw==
X-Gm-Message-State: ACgBeo1fuSE0/jPtEGoF44fv42N9TtjEUUyA5R1Srre2P6D53kXiCzzj
        1dj0lGnURsxNWdKmN9JnBQ6NWbtX1+rSGJ1KglhMTg==
X-Google-Smtp-Source: AA6agR5RekBOHwggN87C/mXTpSYMdD1Z7xcNpSwA3k6eug2L7ykiVE/1ZIcjpE57qLb0Pv2zwkP/FZ4X0nMEJXKN9P8=
X-Received: by 2002:a25:253:0:b0:696:4000:8844 with SMTP id
 80-20020a250253000000b0069640008844mr7310831ybc.619.1661742025413; Sun, 28
 Aug 2022 20:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220718084553.2056169-1-apatel@ventanamicro.com>
In-Reply-To: <20220718084553.2056169-1-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Aug 2022 08:29:45 +0530
Message-ID: <CAAhSdy0zGaZXoJHVAN+2n1sP4+2rsfo+G874NeBMgrhBeEW2ZA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Fix CPU_PM_CPU_IDLE_ENTER_xyz() macro usage
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Mon, Jul 18, 2022 at 2:16 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> Currently, we are using CPU_PM_CPU_IDLE_ENTER_PARAM() for all SBI HSM
> suspend types so retentive suspend types are also treated non-retentive
> and kernel will do redundant additional work for these states.
>
> The BIT[31] of SBI HSM suspend types allows us to differentiate between
> retentive and non-retentive suspend types so we should use this BIT
> to call appropriate CPU_PM_CPU_IDLE_ENTER_xyz() macro.
>
> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Can you please take this patch through the RISC-V tree ?

Regards,
Anup

> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index 1151e5e2ba82..33c92fec4365 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -97,8 +97,13 @@ static int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
>                                    struct cpuidle_driver *drv, int idx)
>  {
>         u32 *states = __this_cpu_read(sbi_cpuidle_data.states);
> +       u32 state = states[idx];
>
> -       return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, states[idx]);
> +       if (state & SBI_HSM_SUSP_NON_RET_BIT)
> +               return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, state);
> +       else
> +               return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
> +                                                            idx, state);
>  }
>
>  static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
> --
> 2.34.1
>
