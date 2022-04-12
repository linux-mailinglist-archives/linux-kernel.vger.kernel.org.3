Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744924FD4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391720AbiDLJgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389359AbiDLJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:23:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565EE13FBC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:34:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r64so11459701wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLvQK6u8X6MxfdwfZzKW+9KXgJVePbdHxyWV6mszZ8g=;
        b=th4EwU35I/WC+kzFgnRoRVuC+hKI7r5MJPm20JcujjTPKrbF3S3gnRKb95FPMWRIKg
         ljAxbCLqbmuWFCSAWRgTGgDxFDmCVyNYTPWjo4XfZLnpH2nzQx5y4BtVUhIZiHkRFi+2
         bVRiA2UGJi3oAUaNttTb2RwBOZxzvbC4h0vqPeLQyUNDeg+p/e+OWK9lcL96OxpwG8Wy
         xdvmxwI1NJbomJYlyAlFNCxafqaextmBQXpA344trYnChiW0MFaLCaX8uha6Ij+0g/79
         9Gqu1HoPgM7v+C/SHeQt89Pfx0hlIIKdOV3Y7OskdJiJbRMXPVsfzHjvHCatGhq5Ou5b
         iaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLvQK6u8X6MxfdwfZzKW+9KXgJVePbdHxyWV6mszZ8g=;
        b=XLr/YzA/ZI25nx1J8B4QCPPyhSERX9U0+o+2zCXkjI9LfVYNdPWkCyR+upmakhw6rg
         WbHxr7XEFxZzTWDQsmEBugKCybryl5i8+6rEL2PfkggY5ywFS79ARXfo/fOh6zRa6zX3
         5P60bNNOuFdG3tz1R8zT1Jd1qO8gBxldItGVRGvmUebaM8Wa/aJfkkfaQd1rBO7uJbkI
         R2nffS6V5zmPPWN9vUqOt0+yR8g02fXmsJ5nRpx6SCuI866QE1yKzoFlR8sqBfaepBjq
         gHecbfJqHI344vZgaznGGaOHk+HrmM41zr3PwmmKmWtI4oP8g/NKGAYBAb+0LAzbnm1L
         pLtQ==
X-Gm-Message-State: AOAM531ctW2AcfiQxSu/pa6EBPKMzndtWvqgku7y0L3KSGWxcH8g8Nnr
        JEzepyAR7CnB4XQ56sI+ECQgzWFBC0U4sCD20nhUUQ==
X-Google-Smtp-Source: ABdhPJw8zmRDxrpZAdkBdzVjqtih7cNCZUz/vPFDsylF1MB9TPzx3d4cMoyMoVwr/UPzvdzSxcj5zDYUAA1FPpNrn1I=
X-Received: by 2002:a05:600c:2b8d:b0:38e:9cb8:5d24 with SMTP id
 j13-20020a05600c2b8d00b0038e9cb85d24mr2975294wmc.149.1649752483914; Tue, 12
 Apr 2022 01:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-4-james.clark@arm.com>
In-Reply-To: <20220304171913.2292458-4-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 09:34:32 +0100
Message-ID: <CAJ9a7Vi-u75aoNXwFf75JfZhkJk5M0emiuFRXL8RfywqEX+gWQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] coresight: etm4x: Cleanup TRCIDR3 register accesses
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
>  .../coresight/coresight-etm4x-core.c          | 40 +++++--------------
>  drivers/hwtracing/coresight/coresight-etm4x.h | 10 +++++
>  2 files changed, 20 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index fd44231e9d8a..1b377f6b31bf 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1124,53 +1124,33 @@ static void etm4_init_arch_data(void *info)
>
>         etmidr3 = etm4x_relaxed_read32(csa, TRCIDR3);
>         /* CCITMIN, bits[11:0] minimum threshold value that can be programmed */
> -       drvdata->ccitmin = BMVAL(etmidr3, 0, 11);
> +       drvdata->ccitmin = FIELD_GET(TRCIDR3_CCITMIN_MASK, etmidr3);
>         /* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
> -       drvdata->s_ex_level = BMVAL(etmidr3, 16, 19);
> +       drvdata->s_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_S_MASK, etmidr3);
>         drvdata->config.s_ex_level = drvdata->s_ex_level;
>         /* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
> -       drvdata->ns_ex_level = BMVAL(etmidr3, 20, 23);
> -
> +       drvdata->ns_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_NS_MASK, etmidr3);
>         /*
>          * TRCERR, bit[24] whether a trace unit can trace a
>          * system error exception.
>          */
> -       if (BMVAL(etmidr3, 24, 24))
> -               drvdata->trc_error = true;
> -       else
> -               drvdata->trc_error = false;
> -
> +       drvdata->trc_error = !!(etmidr3 & TRCIDR3_TRCERR);
>         /* SYNCPR, bit[25] implementation has a fixed synchronization period? */
> -       if (BMVAL(etmidr3, 25, 25))
> -               drvdata->syncpr = true;
> -       else
> -               drvdata->syncpr = false;
> -
> +       drvdata->syncpr = !!(etmidr3 & TRCIDR3_SYNCPR);
>         /* STALLCTL, bit[26] is stall control implemented? */
> -       if (BMVAL(etmidr3, 26, 26))
> -               drvdata->stallctl = true;
> -       else
> -               drvdata->stallctl = false;
> -
> +       drvdata->stallctl = !!(etmidr3 & TRCIDR3_STALLCTL);
>         /* SYSSTALL, bit[27] implementation can support stall control? */
> -       if (BMVAL(etmidr3, 27, 27))
> -               drvdata->sysstall = true;
> -       else
> -               drvdata->sysstall = false;
> -
> +       drvdata->sysstall = !!(etmidr3 & TRCIDR3_SYSSTALL);
>         /*
>          * NUMPROC - the number of PEs available for tracing, 5bits
>          *         = TRCIDR3.bits[13:12]bits[30:28]
>          *  bits[4:3] = TRCIDR3.bits[13:12] (since etm-v4.2, otherwise RES0)
>          *  bits[3:0] = TRCIDR3.bits[30:28]
>          */
> -       drvdata->nr_pe = (BMVAL(etmidr3, 12, 13) << 3) | BMVAL(etmidr3, 28, 30);
> -
> +       drvdata->nr_pe =  (FIELD_GET(TRCIDR3_NUMPROC_HI_MASK, etmidr3) << 3) |
> +                          FIELD_GET(TRCIDR3_NUMPROC_LO_MASK, etmidr3);
>         /* NOOVERFLOW, bit[31] is trace overflow prevention supported */
> -       if (BMVAL(etmidr3, 31, 31))
> -               drvdata->nooverflow = true;
> -       else
> -               drvdata->nooverflow = false;
> +       drvdata->nooverflow = !!(etmidr3 & TRCIDR3_NOOVERFLOW);
>
>         /* number of resources trace unit supports */
>         etmidr4 = etm4x_relaxed_read32(csa, TRCIDR4);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index cfdf966016b7..1b95c63938f0 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -147,6 +147,16 @@
>  #define TRCIDR2_VMIDSIZE_MASK                  GENMASK(14, 10)
>  #define TRCIDR2_CCSIZE_MASK                    GENMASK(28, 25)
>
> +#define TRCIDR3_CCITMIN_MASK                   GENMASK(11, 0)
> +#define TRCIDR3_EXLEVEL_S_MASK                 GENMASK(19, 16)
> +#define TRCIDR3_EXLEVEL_NS_MASK                        GENMASK(23, 20)
> +#define TRCIDR3_TRCERR                         BIT(24)
> +#define TRCIDR3_SYNCPR                         BIT(25)
> +#define TRCIDR3_STALLCTL                       BIT(26)
> +#define TRCIDR3_SYSSTALL                       BIT(27)
> +#define TRCIDR3_NUMPROC_LO_MASK                        GENMASK(30, 28)
> +#define TRCIDR3_NUMPROC_HI_MASK                        GENMASK(13, 12)
> +#define TRCIDR3_NOOVERFLOW                     BIT(31)
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
