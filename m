Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149E04FD72D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377497AbiDLJfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388634AbiDLJWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:22:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9B72662
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:29:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i20so13455408wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CqvBmP+Qc0+EuRXZjCQaYGdhPsRI95L6d6IBMT4+9C4=;
        b=rsVtHOQaJ9doBkbGLUnKPy/TDXrqUhyOrvVYLBBHT4Ful8BQ9j7zk2pqxD+3gI4LEL
         1h0vsG1MIP+9vgqB/Ut2B+tAwiNhwV6d2ovlMnv19Ldmd2dkbExOgSnsRYnAIaq273u6
         L3pLSzlndrAcmkG4HgL23adAdW2Ed/3DxgUuqhiqKdFvmhrrgWClg2PJG7PuGByShg7/
         SaAXQs9vUS7Yc1U5eFciQxMGCyQKLqNZV8L2XNJUOvaAYYT9nfFVSd/1Q57rY/ffZDXL
         2O4HkZc1etowuJNkjHzcNLk1LPv39Jr6Kniurdf1mrlQ/4PhdPNCcRtiPLSPEsjygz0B
         XyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CqvBmP+Qc0+EuRXZjCQaYGdhPsRI95L6d6IBMT4+9C4=;
        b=KOr9XmmPkVRZmJdb8E8+FOrWly35345zqFlXj+yiyX+jyAuH10gJmzsE1PCU9QL/Le
         omvsym9jMNkG9sbgenrt5DvGt989nK7oyVidYOZu67OM27uhIHnbOI5jKzVpdnVJsBLq
         OyNrhhYbQ3kVo6LzQY7Q/gPlcOQFNVnbqiaoc1NIntfemmHLceEvbI74IJ0BIv0mKzCT
         /io9Mc16jAYSqvgJbQHT3x828fb5vwDRhy9OZueKnGobr1f0BnuRY9itWUqwNPBjndDQ
         Bm9COYt+TqQECC9xUfmwa8fDHDXolxvaRoIx9OBVaO+bnRqw7iK+TFQutQVP0QY0i3Nx
         owDg==
X-Gm-Message-State: AOAM531OXmx6QS2/bhp+Q93Ibgh5FXAnDIiScRengRYw0SHEj7zkBiTj
        kxeo0+RWaIUz/EEqJGoholS/p51h/7wqa4Yysj0T6A==
X-Google-Smtp-Source: ABdhPJxuzITykVKFvdy/AFU8aIjZw9nOtOrS0NjyNzbs5DXwm/9UkwFLlYnRjRMr8tD47iDgZo6bHFiJ2MOMNUSuy0s=
X-Received: by 2002:adf:816b:0:b0:203:7fae:a245 with SMTP id
 98-20020adf816b000000b002037faea245mr28603032wrm.619.1649752145967; Tue, 12
 Apr 2022 01:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-2-james.clark@arm.com>
In-Reply-To: <20220304171913.2292458-2-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 09:28:54 +0100
Message-ID: <CAJ9a7Vi+XpJhn8dCWNMNHSoH=rrHc17GdTnGpKjKaFOB9K8AWQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] coresight: etm4x: Cleanup TRCIDR0 register accesses
To:     James Clark <James.Clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        Anshuman.Khandual@arm.com, leo.yan@linaro.com,
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
>  .../coresight/coresight-etm4x-core.c          | 36 +++++--------------
>  drivers/hwtracing/coresight/coresight-etm4x.h | 13 +++++++
>  2 files changed, 21 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 7f416a12000e..9120390a7613 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1097,41 +1097,21 @@ static void etm4_init_arch_data(void *info)
>         etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
>
>         /* INSTP0, bits[2:1] P0 tracing support field */
> -       if (BMVAL(etmidr0, 1, 2) == 0b11)
> -               drvdata->instrp0 = true;
> -       else
> -               drvdata->instrp0 = false;
> -
> +       drvdata->instrp0 = !!(FIELD_GET(TRCIDR0_INSTP0_MASK, etmidr0) == 0b11);
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
> +       drvdata->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0);
>         /* QSUPP, bits[16:15] Q element support field */
> -       drvdata->q_support = BMVAL(etmidr0, 15, 16);
> +       drvdata->q_support = FIELD_GET(TRCIDR0_QSUPP_MASK, etmidr0);
>         /* TSSIZE, bits[28:24] Global timestamp size field */
> -       drvdata->ts_size = BMVAL(etmidr0, 24, 28);
> +       drvdata->ts_size = FIELD_GET(TRCIDR0_TSSIZE_MASK, etmidr0);
>
>         /* maximum size of resources */
>         etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 3c4d69b096ca..300741fbc0de 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -130,6 +130,19 @@
>
>  #define TRCRSR_TA                      BIT(12)
>
> +/*
> + * Bit positions of registers that are defined above, in the sysreg.h style
> + * of _MASK for multi bit fields and BIT() for single bits.
> + */
> +#define TRCIDR0_INSTP0_MASK                    GENMASK(2, 1)
> +#define TRCIDR0_TRCBB                          BIT(5)
> +#define TRCIDR0_TRCCOND                                BIT(6)
> +#define TRCIDR0_TRCCCI                         BIT(7)
> +#define TRCIDR0_RETSTACK                       BIT(9)
> +#define TRCIDR0_NUMEVENT_MASK                  GENMASK(11, 10)
> +#define TRCIDR0_QSUPP_MASK                     GENMASK(16, 15)
> +#define TRCIDR0_TSSIZE_MASK                    GENMASK(28, 24)
> +
>  /*
>   * System instructions to access ETM registers.
>   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> --
> 2.28.0
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
