Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4A527318
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 18:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiENQrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiENQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 12:47:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781923193B
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 09:47:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i5so15062133wrc.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/mgIjRvvJPY19sTVzBgUbBKV/toAZXWOr19sK94Ueg=;
        b=FnLI62tda7G4LUCDCeToyihFzqCLwmokw+LF+XC/D2mcefciSGP2A24Igxnhkkhahc
         vRvtv5rMVO2/vot6MWLs7i+BA9EuNCGusNNxfsWkF5D2sDrvpcnkRgDaLq+nVeIIhGNN
         LscT7xk/lrUsi0/oGm6JQpcsNHpPzodIUkHRGPUVcsidAuObpjxwwF0yzekrXG7igOgg
         BDmhv4snk6f0ykJPqElje/EJsyubnaGWxri4UaWNnz3oMQnmM1qWE1WRsoi3cR7XRCSy
         Pg2ICmtFYTpGLHnE9/elllsWYTHKc+63SC41gUBrvWrNGsVnE87liAaIl/3wKnsgQkzE
         jLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/mgIjRvvJPY19sTVzBgUbBKV/toAZXWOr19sK94Ueg=;
        b=p/iJMrG7wnvb6NuiPftCkov7PrUu0+yMa88l7wo2FyeOIfmBWHgAloe5YL0Ho4cvJB
         my/yrecM2/elnbl/4tRKQSRuWrPcGRnONCAiQKHLLEgVQkwMzzMpLKGRnKj1C+IFs2vQ
         xDj0f7YmpccHX1TYdEj+Y/JzKLdoJeBgBeNFPacdvy0T1jWoeCNhc3PUfpRvCyN+UsMs
         bQXFWkmxG1sIuDiv4ZhxWu90VIPHoEZY8wNnqyYp77d5KpvXCKcgRFWz7+/E7sU4de0m
         1KNTfpzN6V0gPpKVYM5KMBGFckyPtZQeXx2Jwv9Zzc6yY/4UAWJ0CDA9QB0kLaNy3nNt
         XRjg==
X-Gm-Message-State: AOAM531/qO+4koGHVJ3nvA92gdBhdIKYzTvnCs5mQThTktm2d04vJ+zM
        GoTpX8xRblzQ7hQ4b03ii9H/2qvqWMcqMeqz91PAtOC0Tj+26WfU
X-Google-Smtp-Source: ABdhPJxUfYpE2VhGuI45d7fw+1N7B/jx3qn+wllVENZjJFA+V3lCXac+BxeHu6VSjPf+yHW2DPEhjWtwJvgc5wit8dM=
X-Received: by 2002:a5d:6483:0:b0:20c:5c21:5c8c with SMTP id
 o3-20020a5d6483000000b0020c5c215c8cmr8122994wri.86.1652546852805; Sat, 14 May
 2022 09:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220514152044.758802-1-ulf.hansson@linaro.org>
In-Reply-To: <20220514152044.758802-1-ulf.hansson@linaro.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 14 May 2022 22:17:20 +0530
Message-ID: <CAAhSdy0=jvJ-Gqx7CEeRS+ZSBS8mEaZiZ1vT5p=47n=p3wBaBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpuidle: riscv-sbi: Fix code to allow a genpd
 governor to be used
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
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

On Sat, May 14, 2022 at 8:50 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The intent is to use a genpd governor when there are some states that needs
> to be managed. Although, the current code ends up to never assign a
> governor, let's fix this.
>
> Fixes: 6abf32f1d9c50 ("cpuidle: Add RISC-V SBI CPU idle driver")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks good to me. I have tested this on QEMU RISC-V as well.

Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index b459eda2cd37..478970fa3b0c 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -413,7 +413,7 @@ static int sbi_pd_init(struct device_node *np)
>         struct generic_pm_domain *pd;
>         struct sbi_pd_provider *pd_provider;
>         struct dev_power_governor *pd_gov;
> -       int ret = -ENOMEM, state_count = 0;
> +       int ret = -ENOMEM;
>
>         pd = dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
>         if (!pd)
> @@ -432,7 +432,7 @@ static int sbi_pd_init(struct device_node *np)
>                 pd->flags |= GENPD_FLAG_ALWAYS_ON;
>
>         /* Use governor for CPU PM domains if it has some states to manage. */
> -       pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
> +       pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
>
>         ret = pm_genpd_init(pd, pd_gov, false);
>         if (ret)
> --
> 2.25.1
>
