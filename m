Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315524FD96B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391761AbiDLJgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390748AbiDLJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:25:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3225B57B07
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:42:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r64so11471679wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXu2KEOQrQmmf/qE2DwSD4OVXGnj91SlN5UJEVCoaX4=;
        b=k1kvR5j2afkTP9a2drwU91TqKmsM7sIfsv9Po7Fo9CFf+2X2chyJ6aos8nW69Qua+x
         dtulxm7VVZ58zjw088Gd4yfWIhpOyh9Do4WHr18sRZmekJRb9q1Pjb5/bBvSZotyo8tK
         ChxSVd+o8g4+BMvMnn3eg7/eHa+bbZuP4NF8cmf+osIBKcO86m50ATcqrXCReKN9cLKV
         ewDviUG2ndzjiFPLKw1a+zAFLwH7zr4cM2BEcOuQPgTGqxaAAJ7AE6CW/ZxodqV/RAes
         q1hdz8du1VmpGa3BWKQkfLTb4swr6DSR/eFpQb6FgJUOZL90gN5eMKI45GZcXKJcQ1jK
         s1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXu2KEOQrQmmf/qE2DwSD4OVXGnj91SlN5UJEVCoaX4=;
        b=OHgdA1aebVHzqlGqAlazMBfy1jztvZMNXT+BJY5uwJcAN8uS1CZ3U8B9PQVK80S1+v
         3Vk2NNxnDDGIkkZ7Gw3cJQpbgjK+zC5KATf7GyGxS2FEYNTYahUUOROnt3q699Qdhgd0
         7CjKLbnnPyDSns6IFZSlJWpE5R7fF0VEneXfS6g40XhRudP16MmvkzR2315cSV8UkUC5
         3OQhAJ0iObhg4tniwTbrjvCCY0hEClhmBjhSq9GWg6Qp/T5qvdrduywASE+tJS494QLf
         8T+5+tSgfhfxF4EjrwK+baqz8hB4z6sYDxsZTVNzPVLcXCMgbveDzSOkcSfJRwX59zXM
         P9aQ==
X-Gm-Message-State: AOAM533oSpXNUAYGt2akz0bAKgw1xEdF+9G9be78qtf3Ib0Lo1+/gmtf
        5DRHwhgqAPzdgyXOi8Osui2/lRDdugF4gQvrMbIpZQ==
X-Google-Smtp-Source: ABdhPJxYhabPb6gGJkUG38B7sezAvlwxgHjf+aikWna8H1DYx5r56v7GISPk5WOMepJy5u8DYnaVRlDm8q25l9BH0Mk=
X-Received: by 2002:a7b:cbc2:0:b0:388:faec:2036 with SMTP id
 n2-20020a7bcbc2000000b00388faec2036mr3090378wmi.190.1649752930571; Tue, 12
 Apr 2022 01:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-6-james.clark@arm.com>
In-Reply-To: <20220304171913.2292458-6-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 09:41:59 +0100
Message-ID: <CAJ9a7VjvgEcQPngSwe5OKSjreeMwT_rNcTod31azfdYbLZCRgg@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] coresight: etm4x: Cleanup TRCIDR5 register accesses
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
>  .../hwtracing/coresight/coresight-etm4x-core.c | 18 ++++++------------
>  drivers/hwtracing/coresight/coresight-etm4x.h  |  7 +++++++
>  2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index c52ab7f29f41..3f4263117570 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1188,26 +1188,20 @@ static void etm4_init_arch_data(void *info)
>
>         etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
>         /* NUMEXTIN, bits[8:0] number of external inputs implemented */
> -       drvdata->nr_ext_inp = BMVAL(etmidr5, 0, 8);
> +       drvdata->nr_ext_inp = FIELD_GET(TRCIDR5_NUMEXTIN_MASK, etmidr5);
>         /* TRACEIDSIZE, bits[21:16] indicates the trace ID width */
> -       drvdata->trcid_size = BMVAL(etmidr5, 16, 21);
> +       drvdata->trcid_size = FIELD_GET(TRCIDR5_TRACEIDSIZE_MASK, etmidr5);
>         /* ATBTRIG, bit[22] implementation can support ATB triggers? */
> -       if (BMVAL(etmidr5, 22, 22))
> -               drvdata->atbtrig = true;
> -       else
> -               drvdata->atbtrig = false;
> +       drvdata->atbtrig = !!(etmidr5 & TRCIDR5_ATBTRIG);
>         /*
>          * LPOVERRIDE, bit[23] implementation supports
>          * low-power state override
>          */
> -       if (BMVAL(etmidr5, 23, 23) && (!drvdata->skip_power_up))
> -               drvdata->lpoverride = true;
> -       else
> -               drvdata->lpoverride = false;
> +       drvdata->lpoverride = (etmidr5 & TRCIDR5_LPOVERRIDE) && (!drvdata->skip_power_up);
>         /* NUMSEQSTATE, bits[27:25] number of sequencer states implemented */
> -       drvdata->nrseqstate = BMVAL(etmidr5, 25, 27);
> +       drvdata->nrseqstate = FIELD_GET(TRCIDR5_NUMSEQSTATE_MASK, etmidr5);
>         /* NUMCNTR, bits[30:28] number of counters available for tracing */
> -       drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
> +       drvdata->nr_cntr = FIELD_GET(TRCIDR5_NUMCNTR_MASK, etmidr5);
>         etm4_cs_lock(drvdata, csa);
>         cpu_detect_trace_filtering(drvdata);
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index c9c5fd655196..3b604cde668b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -165,6 +165,13 @@
>  #define TRCIDR4_NUMCIDC_MASK                   GENMASK(27, 24)
>  #define TRCIDR4_NUMVMIDC_MASK                  GENMASK(31, 28)
>
> +#define TRCIDR5_NUMEXTIN_MASK                  GENMASK(8, 0)
> +#define TRCIDR5_TRACEIDSIZE_MASK               GENMASK(21, 16)
> +#define TRCIDR5_ATBTRIG                                BIT(22)
> +#define TRCIDR5_LPOVERRIDE                     BIT(23)
> +#define TRCIDR5_NUMSEQSTATE_MASK               GENMASK(27, 25)
> +#define TRCIDR5_NUMCNTR_MASK                   GENMASK(30, 28)
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
