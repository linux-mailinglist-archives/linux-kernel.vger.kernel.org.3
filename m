Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77AA4FDE93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349569AbiDLLu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355001AbiDLLtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:49:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AEA615B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:33:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso1437029wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KN4VAQd4/qyqK8sDusPnudj+GDiHOaQV7xvYMDkiTks=;
        b=XM2MOFFejQ4NdtID4QYIxFgCD8YZk3+NF54lpVLwI6Sl8gl3mFp8lGNNoBonnbhMDn
         mvKgnit/HeuklxJYMKZuS6+D6gvO1XWvSzva0Vb43JtMLnjYkO8qHKGQG47Ogt9ta80R
         YzXZvcBcNgv7Y+LP7KkCgLoxmMAfXxggVLVApKgvmi+VRsFetcFu8dCftc9GtpkN92LG
         D6L5GP/GJH9qA9+qVrAR0rm5jVJQl6M0umwA6ZH70Js0srpLGz+ZB1uavAFUkjPgyugu
         iBHYrGc2ufxZobmWR/FTGr9h4Am3iNBBEPSt88uOg92PKTU5DXi6DMOVgrJFxtaz/BaR
         8BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KN4VAQd4/qyqK8sDusPnudj+GDiHOaQV7xvYMDkiTks=;
        b=bXRBVlgjzuz39HdL7+Sj2lPqbcG6hJIZVCrXtEocBt6tSEsmUeUE5eo6gUUHOO95I/
         2UDrDc9PsbJurqbAKPl4VWwlKkH2DizSqh4UFEDJM2V7sFU8ielNXS3RJGyzxRebUJpY
         hsM/88eIMpll+WqKcAejuT/FGa0UKko0CfgPmlJ7/EzlOjwIoM4aavPMyQVMpbd0eF+h
         j+7Wn3wdAM8CiZSACdkxQnPIxC+1qrUH3Hjoj2DXMK61GO75xSREp5viNzlWYlIRTVyc
         UP+qzWOHXANtocrirxsyY9tW7/FOAHqw8kFoz8kHocrj2GOxT01nZU7pQmNj76fhcnIF
         VAbg==
X-Gm-Message-State: AOAM5309mu3crxinHXeJt5CjAp5qmu1JhRpqc/BGOCuFtTYFN4Wtx0tA
        Zu1fdLNDz6VX2s3SIgPhMa9aL7HnOso4t8jxhtTGow==
X-Google-Smtp-Source: ABdhPJwSXDn9YmkWgGELQczo3n9FEZZZm1+V5a8KqZ4Dml/JIHfAl5j7evJy7Qb6xtUx3IpEcVAS5Vfj5+4kKqJDXZ0=
X-Received: by 2002:a05:600c:210b:b0:38e:c62a:398b with SMTP id
 u11-20020a05600c210b00b0038ec62a398bmr3278105wml.118.1649759579945; Tue, 12
 Apr 2022 03:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-13-james.clark@arm.com>
In-Reply-To: <20220304171913.2292458-13-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 11:32:48 +0100
Message-ID: <CAJ9a7Vg9aDuS026s_qdp1krqPWd5j8cs7Ka0XxSbFsNLe8d8PA@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] coresight: etm4x: Cleanup TRCSSCCRn and
 TRCSSCSRn register accesses
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
>  drivers/hwtracing/coresight/coresight-etm4x-core.c  | 2 +-
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 6 +++---
>  drivers/hwtracing/coresight/coresight-etm4x.h       | 4 ++++
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 88353f8ba414..87299e99dabb 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -443,7 +443,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>         for (i = 0; i < drvdata->nr_ss_cmp; i++) {
>                 /* always clear status bit on restart if using single-shot */
>                 if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
> -                       config->ss_status[i] &= ~BIT(31);
> +                       config->ss_status[i] &= ~TRCSSCSRn_STATUS;
>                 etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
>                 etm4x_relaxed_write32(csa, config->ss_status[i], TRCSSCSRn(i));
>                 if (etm4x_sspcicrn_present(drvdata, i))
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 29188b1a4646..7dd7636fc2a7 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1792,9 +1792,9 @@ static ssize_t sshot_ctrl_store(struct device *dev,
>
>         spin_lock(&drvdata->spinlock);
>         idx = config->ss_idx;
> -       config->ss_ctrl[idx] = val & GENMASK(24, 0);
> +       config->ss_ctrl[idx] = FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
>         /* must clear bit 31 in related status register on programming */
> -       config->ss_status[idx] &= ~BIT(31);
> +       config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
>         spin_unlock(&drvdata->spinlock);
>         return size;
>  }
> @@ -1844,7 +1844,7 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
>         idx = config->ss_idx;
>         config->ss_pe_cmp[idx] = val & GENMASK(7, 0);
>         /* must clear bit 31 in related status register on programming */
> -       config->ss_status[idx] &= ~BIT(31);
> +       config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
>         spin_unlock(&drvdata->spinlock);
>         return size;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 802ddbe2eecd..b4217eaab450 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -214,6 +214,10 @@
>  #define TRCACATRn_CONTEXTTYPE_VMID             BIT(3)
>  #define TRCACATRn_CONTEXT_MASK                 GENMASK(6, 4)
>  #define TRCACATRn_EXLEVEL_MASK                 GENMASK(14, 8)
> +
> +#define TRCSSCSRn_STATUS                       BIT(31)
> +#define TRCSSCCRn_SAC_ARC_RST_MASK             GENMASK(24, 0)
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
