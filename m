Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699184AD7D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiBHLtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349305AbiBHLsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:48:51 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6CDC03C18C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:37:02 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d27so1884593wrc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 03:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDmHxeBQUl+rZZAJ7g87tKDbqFdO7hParR4cnT5r2tY=;
        b=A7diG2DUiuxIOiAMuIE0aXaK5zh5HEg1Jg0KbudixlINuC+lFA9k1zxiz1wx9gyhbP
         MEYzc+X2DW/YmcFVPKHFFHWIKUrpC774nYFFTPRtWt147MGroD0RAzmS5CYZFs4Hy7x4
         pXkNHn+vkAd/seKhCSwbowiGN0miw85lPmlZJI5UX6gKmoo8xWkq1Ti2aRnEwfcdG7Fx
         3ZIWttONlELcZTfq3sj9iHSIExOBxvpVbWlXMr12M7t/FiOQh3rz1nxFtIueCMS+7gtv
         bMzLp0dQTr3J8wqW4UApxgpog7U2n2kafLb8kSV8w8R/gZvY/HUS9DOgIPU1x5PJr+Z/
         ersw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDmHxeBQUl+rZZAJ7g87tKDbqFdO7hParR4cnT5r2tY=;
        b=Hpmk6Cv/uGtZtSadvkMzwP1u+SAZa2jEFzNlckwciw/i9r/ZloX1sSquQYtt9dK6C5
         L9GlnNmrCUUylXj6/9lnYWOQCWJ/Jl6G4Ri0DeW4Ip3r+zkdS0cWY2P9ZcdZ1L3kX3s2
         xPgducOccDle0NuOhvYA2MrwGxKKqYanIKckZSgqhH2OxpFNMEO2I9vXHqSuqMbCiNM+
         Gs/cJ6jERjJ6Ek479RL9zIZSrAF77vkzSTL5Q2hh1bg+QFoqha+76mkmJrd0QEHrfkNP
         qQ/zKim0kkbhyXojlhj34sRNtnVEz3dV07UCaZm6UUazPFjwAiPcBu9GQp1ldQrgpLZq
         52rg==
X-Gm-Message-State: AOAM53082VTUg9/a5dCO/adRuK3XubTa/Pp4RO31OQITI7TMiANVyZKq
        AbUdQsPC/VmQMkk9kxLkJmxQikBQKFgK6z/t/6H+9RjSvr5nog==
X-Google-Smtp-Source: ABdhPJx/2NST9EpzbtJXXRKu42tRRBVlO9eVSm6xHpknVe/8H3P48fUbbue3/VeDXoMQsQ0b98oBalhrGKDBQGO7U7A=
X-Received: by 2002:adf:e710:: with SMTP id c16mr3276778wrm.699.1644320220607;
 Tue, 08 Feb 2022 03:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20220203120604.128396-1-james.clark@arm.com> <20220203120604.128396-2-james.clark@arm.com>
In-Reply-To: <20220203120604.128396-2-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 8 Feb 2022 11:36:49 +0000
Message-ID: <CAJ9a7Vh8gA1Qmxyoo1f6gbKMtK4pTXEFnubkEnv=AzSiSH+NVA@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] coresight: Make ETM4x TRCIDR0 register accesses
 consistent with sysreg.h
To:     James Clark <James.Clark@arm.com>
Cc:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi James,

On Thu, 3 Feb 2022 at 12:06, James Clark <james.clark@arm.com> wrote:
>
> This is a no-op change for style and consistency and has no effect on the
> binary produced by gcc-11.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 36 +++++--------------
>  drivers/hwtracing/coresight/coresight-etm4x.h | 17 +++++++++
>  drivers/hwtracing/coresight/coresight-priv.h  |  5 +++
>  3 files changed, 30 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index e2eebd865241..107e81948f76 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1091,41 +1091,21 @@ static void etm4_init_arch_data(void *info)
>         etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
>
>         /* INSTP0, bits[2:1] P0 tracing support field */
> -       if (BMVAL(etmidr0, 1, 2) == 0b11)
> -               drvdata->instrp0 = true;
> -       else
> -               drvdata->instrp0 = false;
> -
> +       drvdata->instrp0 = !!(REG_VAL(etmidr0, TRCIDR0_INSTP0) == 0b11);
>         /* TRCBB, bit[5] Branch broadcast tracing support bit */
> -       if (BMVAL(etmidr0, 5, 5))
> -               drvdata->trcbb = true;
> -       else
> -               drvdata->trcbb = false;
> -
> +       drvdata->trcbb = !!(etmidr0 & TRCIDR0_TRCBB);
>         /* TRCCOND, bit[6] Conditional instruction tracing support bit */
> -       if (BMVAL(etmidr0, 6, 6))
> -               drvdata->trccond = true;
> -       else
> -               drvdata->trccond = false;
> -
> +       drvdata->trccond = !!(etmidr0 & TRCIDR0_TRCCOND);
>         /* TRCCCI, bit[7] Cycle counting instruction bit */
> -       if (BMVAL(etmidr0, 7, 7))
> -               drvdata->trccci = true;
> -       else
> -               drvdata->trccci = false;
> -
> +       drvdata->trccci = !!(etmidr0 & TRCIDR0_TRCCCI);
>         /* RETSTACK, bit[9] Return stack bit */
> -       if (BMVAL(etmidr0, 9, 9))
> -               drvdata->retstack = true;
> -       else
> -               drvdata->retstack = false;
> -
> +       drvdata->retstack = !!(etmidr0 & TRCIDR0_RETSTACK);
>         /* NUMEVENT, bits[11:10] Number of events field */
> -       drvdata->nr_event = BMVAL(etmidr0, 10, 11);
> +       drvdata->nr_event = REG_VAL(etmidr0, TRCIDR0_NUMEVENT);
>         /* QSUPP, bits[16:15] Q element support field */
> -       drvdata->q_support = BMVAL(etmidr0, 15, 16);
> +       drvdata->q_support = REG_VAL(etmidr0, TRCIDR0_QSUPP);
>         /* TSSIZE, bits[28:24] Global timestamp size field */
> -       drvdata->ts_size = BMVAL(etmidr0, 24, 28);
> +       drvdata->ts_size = REG_VAL(etmidr0, TRCIDR0_TSSIZE);
>
>         /* maximum size of resources */
>         etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 3c4d69b096ca..2bd8ad953b8e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -130,6 +130,23 @@
>
>  #define TRCRSR_TA                      BIT(12)
>
> +/*
> + * Bit positions of registers that are defined above, in the sysreg.h style
> + * of _MASK, _SHIFT and BIT().
> + */
> +#define TRCIDR0_INSTP0_SHIFT                   1
> +#define TRCIDR0_INSTP0_MASK                    GENMASK(1, 0)
> +#define TRCIDR0_TRCBB                          BIT(5)
> +#define TRCIDR0_TRCCOND                                BIT(6)
> +#define TRCIDR0_TRCCCI                         BIT(7)
> +#define TRCIDR0_RETSTACK                       BIT(9)
> +#define TRCIDR0_NUMEVENT_SHIFT                 10
> +#define TRCIDR0_NUMEVENT_MASK                  GENMASK(1, 0)
> +#define TRCIDR0_QSUPP_SHIFT                    15
> +#define TRCIDR0_QSUPP_MASK                     GENMASK(1, 0)
> +#define TRCIDR0_TSSIZE_SHIFT                   24
> +#define TRCIDR0_TSSIZE_MASK                    GENMASK(4, 0)
> +
>  /*
>   * System instructions to access ETM registers.
>   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index ff1dd2092ac5..1452c6038421 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -36,6 +36,11 @@
>
>  #define TIMEOUT_US             100
>  #define BMVAL(val, lsb, msb)   ((val & GENMASK(msb, lsb)) >> lsb)
> +/*
> + * Extract a field from a register where field is #defined in the form
> + * <register_name>_<field_name>_MASK and <register_name>_<field_name>_SHIFT
> + */
> +#define REG_VAL(val, field)    ((val & (field##_MASK << field##_SHIFT)) >> field##_SHIFT)
>

The only v minor comment I would have is that this macro could be
REG_FIELD() or REG_FIELD_VAL(), which in my view would make more
natural and obvious reading in the source files where it appears.

e.g.

drvdata->nr_event = REG_FIELD(etmidr0, TRCIDR0_NUMEVENT);

However it ends up, it certainly needs to stay in a common header for
possible use in other drivers (not just ETMv3).

Regards

Mike

>  #define ETM_MODE_EXCL_KERN     BIT(30)
>  #define ETM_MODE_EXCL_USER     BIT(31)
> --
> 2.28.0
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
