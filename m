Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1314FDEA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiDLL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbiDLL4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:56:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418AC5FF3F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:39:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s28so11158978wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5j+DyYR0o6Q93d00EPxQZq+xzuIpOumJGj/flLY2ZXQ=;
        b=XyeYRncEFduIhbzKjNRkk5jRGALM2S+GIQBdXaijG9//sHgGzzemlKCmqr1xWAfd5I
         nrMjKXCZgnaFKdwclYnlI51qeUEhpI+FWyWTsjieqAgoerhfqWT9gacYjLq7uj/5I+4v
         4ILKW5KZw6hKssD4TkWgDrluLpd+vWA6kWf0qmk1lZPovU/1rBUGK166hf9H5tRuxeYV
         ukjPKzOhEYAYnyeiplSl2N3oB95Bngvd43/TN2+PogxL9FG4uVRpJZGII/k9DHUNCvkY
         1uS0kplxMN1lNpD71tp1rPup1dfcS1MGJHOwk/wlYfmgxnWZeIw0wUEpnx1hQ+NbQuVL
         v6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5j+DyYR0o6Q93d00EPxQZq+xzuIpOumJGj/flLY2ZXQ=;
        b=o0hpWqKAQ5ndBT3xte8X8AoPicnI8yYfwFs1rxKpGsmYvVoJsOWkkBR+XIyd/9uku5
         OaCguN8rESpAyb2A95ISeCtm5zfwHOJ5DFGJYkwfsXPqjwX4ut760pZAtyUqU5nEj49C
         o88zmZb1BUpHPLx1dGMvuESjJObVNL1XxPuhLJm8JfrkU5mmDOn4CbegnROV+B40wwE7
         G4cWlSEowJr1rvaQXlBXcCHxJFNiCUkav9RxBRpq/yJXMGpMPpOVvOMsYRko9zxxUN4p
         6K3EyvzQ4LWwh6Gtbth/gU0lf5QdgPPDkclR1SUYhjz/um0e0K79BH6evyS9ajHvmtZ5
         ya/A==
X-Gm-Message-State: AOAM530M0y3Xc/VkT2AypyVmPQGRJDXKY0xvGAHK9H0MDwjC02RIyN85
        EWPFysGGw8zDDpxT6I58SsAwbZkZvRMKgXjgvQSwFA==
X-Google-Smtp-Source: ABdhPJxgPCMoovmuskyp4Di5ue29+LDcufEl00XCI6fpEE1DA39TMQXzYXAzWA70+Ozx57DE/0Isc/mTBKVToakkZh0=
X-Received: by 2002:adf:cd87:0:b0:207:b0ad:6d8 with SMTP id
 q7-20020adfcd87000000b00207b0ad06d8mr1310311wrj.111.1649759974016; Tue, 12
 Apr 2022 03:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-14-james.clark@arm.com>
In-Reply-To: <20220304171913.2292458-14-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 11:39:21 +0100
Message-ID: <CAJ9a7Vhh1m1uAc441wqAZLyDSTh8pPrZ1pxvR_VNz_crnXdinA@mail.gmail.com>
Subject: Re: [PATCH v3 13/15] coresight: etm4x: Cleanup TRCSSPCICRn register accesses
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
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 +-
>  drivers/hwtracing/coresight/coresight-etm4x.h       | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 7dd7636fc2a7..25f76a656308 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1842,7 +1842,7 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
>
>         spin_lock(&drvdata->spinlock);
>         idx = config->ss_idx;
> -       config->ss_pe_cmp[idx] = val & GENMASK(7, 0);
> +       config->ss_pe_cmp[idx] = FIELD_PREP(TRCSSPCICRn_PC_MASK, val);
>         /* must clear bit 31 in related status register on programming */
>         config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
>         spin_unlock(&drvdata->spinlock);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index b4217eaab450..3b81c104a44b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -218,6 +218,8 @@
>  #define TRCSSCSRn_STATUS                       BIT(31)
>  #define TRCSSCCRn_SAC_ARC_RST_MASK             GENMASK(24, 0)
>
> +#define TRCSSPCICRn_PC_MASK                    GENMASK(7, 0)
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
