Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ECC4FDC67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbiDLK0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379254AbiDLKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:19:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8128220E4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:18:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m14so2370727wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1lzjwxfRXe1DwU9VxJjnLzAF8CyRAgCWO3N0tVaS6A=;
        b=f01vyjAEjFoGUrkbgP2UXQGBY1xVxDhe0SiX9aofWD9JMxHLgQk63dG1EqGaWLpYv+
         UzFRqPYlI69MMAP6HRWmAqnO3RWWmHVrd8TjspfasQaP/WBMuyG2wpcrm3IGN6/DgUoV
         8N9x5l8Nz3gyMLUcSxxZ52Z394Od1YSmPAtSDX+4evi4ZNIdRIz1TqAMoUYBRJw7OGw4
         Lpri9tle00M6lwOn1g0zLhElnDIUExObh2NYjkw85BvbXWliFSOZ3Taas/l4HczG5LCX
         R2NAX3FE9vhKR9VeYBXr/RVJc6fSBVj5N0t5Kp6+EXGr06njt6IX4KtfcxPcAa1TI1UI
         oRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1lzjwxfRXe1DwU9VxJjnLzAF8CyRAgCWO3N0tVaS6A=;
        b=sIKw4W//QSyYvyz0AQbeUdPOBEF9RS/2ZxdPqAwjabVftwBmHXDU1JWQImYdUHQhyg
         rOmWl5BvIZHav9nLnGgOYeNzrmNISI0WMrpp60gypjexhnc6Moyt6McM/Bum77M/DPrG
         8OF6KdGcYs5fNFjw4ahSEOK2HQoUv21M/zS4MaEmL+FVXprz9ON8Nx60+qhxe2EAZLbb
         0hshnIsvnkaEdPFqH7U6QqV7TN7Fb0LYbGo2GTE9H8QBNx6yCNkANm7tQOANy0Mj5JJa
         2IRvu4SDU5MrcYcajqGIrS+PYxlSI2jrJrX6WioTmuI2q6BwU40luQbA+KuoSJKPlmtM
         aMug==
X-Gm-Message-State: AOAM532v3CNdps0IYD4HxFaKc0u0LzvfQnsmd4dBanS/N3pB3jhE1UY2
        RjRdn7OXVpKnfBGTHiT1NG7pfD6MWP/UsR9qsFMXqg==
X-Google-Smtp-Source: ABdhPJyJZQSz39RZRShX34GTe7gth4LcPYRJldMbR5u2AYoxr6ePL9Zbhj0Uk6ECOq/NAoYbHYNTVCHKNrEl1z2ynwE=
X-Received: by 2002:adf:cd87:0:b0:207:b0ad:6d8 with SMTP id
 q7-20020adfcd87000000b00207b0ad06d8mr1062384wrj.111.1649755109255; Tue, 12
 Apr 2022 02:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-9-james.clark@arm.com>
In-Reply-To: <20220304171913.2292458-9-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 10:18:18 +0100
Message-ID: <CAJ9a7Vj+0GN3xN2S9=hMUJuLtnSmHVbN8W-B4H_juSG+DG+z5Q@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] coresight: etm4x: Cleanup TRCSTALLCTLR register accesses
To:     James Clark <James.Clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        Anshuman.Khandual@arm.com, mathieu.poirier@linaro.org,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
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

On Fri, 4 Mar 2022 at 17:19, James Clark <james.clark@arm.com> wrote:
>
> This is a no-op change for style and consistency and has no effect on
> the binary output by the compiler. In sysreg.h fields are defined as
> the register name followed by the field name and then _MASK. This
> allows for grepping for fields by name rather than using magic numbers.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 12 ++++++------
>  drivers/hwtracing/coresight/coresight-etm4x.h       |  4 ++++
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 2d29e9daf515..cd24590ea38a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -397,22 +397,22 @@ static ssize_t mode_store(struct device *dev,
>
>         /* bit[8], Instruction stall bit */
>         if ((config->mode & ETM_MODE_ISTALL_EN) && (drvdata->stallctl == true))
> -               config->stall_ctrl |= BIT(8);
> +               config->stall_ctrl |= TRCSTALLCTLR_ISTALL;
>         else
> -               config->stall_ctrl &= ~BIT(8);
> +               config->stall_ctrl &= ~TRCSTALLCTLR_ISTALL;
>
>         /* bit[10], Prioritize instruction trace bit */
>         if (config->mode & ETM_MODE_INSTPRIO)
> -               config->stall_ctrl |= BIT(10);
> +               config->stall_ctrl |= TRCSTALLCTLR_INSTPRIORITY;
>         else
> -               config->stall_ctrl &= ~BIT(10);
> +               config->stall_ctrl &= ~TRCSTALLCTLR_INSTPRIORITY;
>
>         /* bit[13], Trace overflow prevention bit */
>         if ((config->mode & ETM_MODE_NOOVERFLOW) &&
>                 (drvdata->nooverflow == true))
> -               config->stall_ctrl |= BIT(13);
> +               config->stall_ctrl |= TRCSTALLCTLR_NOOVERFLOW;
>         else
> -               config->stall_ctrl &= ~BIT(13);
> +               config->stall_ctrl &= ~TRCSTALLCTLR_NOOVERFLOW;
>
>         /* bit[9] Start/stop logic control bit */
>         if (config->mode & ETM_MODE_VIEWINST_STARTSTOP)
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index cbba46f14ada..36934056a5dc 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -196,6 +196,10 @@
>  #define TRCEVENTCTL1R_ATB                      BIT(11)
>  #define TRCEVENTCTL1R_LPOVERRIDE               BIT(12)
>
> +#define TRCSTALLCTLR_ISTALL                    BIT(8)
> +#define TRCSTALLCTLR_INSTPRIORITY              BIT(10)
> +#define TRCSTALLCTLR_NOOVERFLOW                        BIT(13)
> +
>  /*
>   * System instructions to access ETM registers.
>   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> --
> 2.28.0
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
