Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2F04FDC48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245290AbiDLKSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354136AbiDLKDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:03:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0666E55F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:09:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m14so2335460wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzQL91UfqQPbfJ6ZhV1VQ1qjBggTHD9xe3spBn4t+EU=;
        b=kEvfCIxPRa8U6nebGEh5TI0c+cY4hEmAYNogP7iXYP1uyN3oKb1IiM3WreLELmLKx+
         Va/YTQz6ZcYYZssf5kJB/zq4HdY46jjM4dRRqBbaytP65JK7G6NE+CBo5zgkTegI/jR+
         NGACrSU2RN7+cYN4IaARg62XIYxgWnEEKT7t7OlAxiIwgCXkJ0jMu61unN58szDi+FIc
         iR0P5a92pJpqebrJKYHmDhD9EIrHiw/9vKvWgWTYVaintqERiVuloM3wOeNIp9rZNLqb
         AH4RHgVF6uzJfF2bOMKhZMaFcHDjYwupCKcNRTeuFqiB5/ztMhuj6Cck1FSzi/1w5dGv
         Z7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzQL91UfqQPbfJ6ZhV1VQ1qjBggTHD9xe3spBn4t+EU=;
        b=krZ/hxxL61TfmiXzLVMFnsIUtuPQID0W+6Yc/y929rcUW+BhR9clmXfcNbP8Fcw41K
         +T/h9ssdDiiq3VE8yH8KadT9QqUxuHukKQA5tHOm0f2lnWIOuddTi4NPRGeTD1J4Qv/k
         YVk/XjZwquRonAc9OJ7i3kBqkSb5VgCNn7lYZjjYVLBvkzkAIFMtwlBQnxTGnCSts1OR
         BBaKS+GFlgTIU5Jy2bqpXJfXAeA1dX+3JaEQlUILHKrfN+eST9FS+YFTnx9Mf5GVDBse
         AI9jwMDMB7w76ggaEWLRbYYjffPw3/UCenCHvqQyzaNpjQN7CMkTYG6QjNbkydaTD8HB
         FLqA==
X-Gm-Message-State: AOAM532iZVQSBdx5VJEg8D6eMC5cvaloE/+c5fnvhtyfEjcP2AggkST0
        PSOV/ZN9ZSf7u2Sb1adivUqI744a7PGlTm6kkUm2sw==
X-Google-Smtp-Source: ABdhPJzLpMvnABfw0xK1gK7iwUBeEBPWFl6bs7XbBI4oAttMFjuF+gCYRia1s3oBQlKzuEeVTR3V9rQtEOX05Dy67JA=
X-Received: by 2002:adf:cd87:0:b0:207:b0ad:6d8 with SMTP id
 q7-20020adfcd87000000b00207b0ad06d8mr1035423wrj.111.1649754581637; Tue, 12
 Apr 2022 02:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-8-james.clark@arm.com>
In-Reply-To: <20220304171913.2292458-8-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 10:09:29 +0100
Message-ID: <CAJ9a7VhXtAKeRw2JCR54eq0eV8XKAgJZJfjpk5V9xcPfKS0r2g@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] coresight: etm4x: Cleanup TRCEVENTCTL1R register accesses
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
>  .../coresight/coresight-etm4x-sysfs.c         | 25 +++++++++++--------
>  drivers/hwtracing/coresight/coresight-etm4x.h |  8 ++++++
>  2 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 53f84da3fe44..2d29e9daf515 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -384,16 +384,16 @@ static ssize_t mode_store(struct device *dev,
>         /* bit[11], AMBA Trace Bus (ATB) trigger enable bit */
>         if ((config->mode & ETM_MODE_ATB_TRIGGER) &&
>             (drvdata->atbtrig == true))
> -               config->eventctrl1 |= BIT(11);
> +               config->eventctrl1 |= TRCEVENTCTL1R_ATB;
>         else
> -               config->eventctrl1 &= ~BIT(11);
> +               config->eventctrl1 &= ~TRCEVENTCTL1R_ATB;
>
>         /* bit[12], Low-power state behavior override bit */
>         if ((config->mode & ETM_MODE_LPOVERRIDE) &&
>             (drvdata->lpoverride == true))
> -               config->eventctrl1 |= BIT(12);
> +               config->eventctrl1 |= TRCEVENTCTL1R_LPOVERRIDE;
>         else
> -               config->eventctrl1 &= ~BIT(12);
> +               config->eventctrl1 &= ~TRCEVENTCTL1R_LPOVERRIDE;
>
>         /* bit[8], Instruction stall bit */
>         if ((config->mode & ETM_MODE_ISTALL_EN) && (drvdata->stallctl == true))
> @@ -534,7 +534,7 @@ static ssize_t event_instren_show(struct device *dev,
>         struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
>         struct etmv4_config *config = &drvdata->config;
>
> -       val = BMVAL(config->eventctrl1, 0, 3);
> +       val = FIELD_GET(TRCEVENTCTL1R_INSTEN_MASK, config->eventctrl1);
>         return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
>  }
>
> @@ -551,23 +551,28 @@ static ssize_t event_instren_store(struct device *dev,
>
>         spin_lock(&drvdata->spinlock);
>         /* start by clearing all instruction event enable bits */
> -       config->eventctrl1 &= ~(BIT(0) | BIT(1) | BIT(2) | BIT(3));
> +       config->eventctrl1 &= ~TRCEVENTCTL1R_INSTEN_MASK;
>         switch (drvdata->nr_event) {
>         case 0x0:
>                 /* generate Event element for event 1 */
> -               config->eventctrl1 |= val & BIT(1);
> +               config->eventctrl1 |= val & TRCEVENTCTL1R_INSTEN_1;
>                 break;
>         case 0x1:
>                 /* generate Event element for event 1 and 2 */
> -               config->eventctrl1 |= val & (BIT(0) | BIT(1));
> +               config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 | TRCEVENTCTL1R_INSTEN_1);
>                 break;
>         case 0x2:
>                 /* generate Event element for event 1, 2 and 3 */
> -               config->eventctrl1 |= val & (BIT(0) | BIT(1) | BIT(2));
> +               config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
> +                                            TRCEVENTCTL1R_INSTEN_1 |
> +                                            TRCEVENTCTL1R_INSTEN_2);
>                 break;
>         case 0x3:
>                 /* generate Event element for all 4 events */
> -               config->eventctrl1 |= val & 0xF;
> +               config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
> +                                            TRCEVENTCTL1R_INSTEN_1 |
> +                                            TRCEVENTCTL1R_INSTEN_2 |
> +                                            TRCEVENTCTL1R_INSTEN_3);
>                 break;
>         default:
>                 break;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 4c8d7be3c159..cbba46f14ada 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -188,6 +188,14 @@
>  #define TRCCONFIGR_DA                          BIT(16)
>  #define TRCCONFIGR_DV                          BIT(17)
>
> +#define TRCEVENTCTL1R_INSTEN_MASK              GENMASK(3, 0)
> +#define TRCEVENTCTL1R_INSTEN_0                 BIT(0)
> +#define TRCEVENTCTL1R_INSTEN_1                 BIT(1)
> +#define TRCEVENTCTL1R_INSTEN_2                 BIT(2)
> +#define TRCEVENTCTL1R_INSTEN_3                 BIT(3)
> +#define TRCEVENTCTL1R_ATB                      BIT(11)
> +#define TRCEVENTCTL1R_LPOVERRIDE               BIT(12)
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
