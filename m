Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5592E4FD77C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245387AbiDLJkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389191AbiDLJX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:23:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAFD532E3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:30:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w4so26516624wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zpl0hwMGWEj8iscWufFMYxFWQQ4xMDR4HXav9sORTE=;
        b=o59LQ7Jij0zJWqE6zB/VIgcLMCkkonLhW64GQBq5wbep+0k2t1ZeNLR1uahoMHDAPo
         y6M9qsaimN6wml7rw7k1Lzsp5NRuJt4rgKVABbnGFFBSu3hLrxLRxWCGnmqcL3D3H5nO
         Cm//2HbDGOuNVCuBE82hSH8oSRadIsubVSwGro4ZHWMV71lHc+BFtodqSobt/sj6emJ/
         orB/tYiDE8702v/5e2WwOhd2an65Y6HLBYSENmib0NlCxUXbEC53nHYd/1zFcXr3wjpd
         beDF4S03cr5bXNmsuzHv2h3Kbsr4PM8X2wzQMzFpb52ZhUp0KfK4IPEQ19jCDxLJr7CW
         M0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zpl0hwMGWEj8iscWufFMYxFWQQ4xMDR4HXav9sORTE=;
        b=QDM1kUjFh+229iTAd1fz6ThDEvg/ecu6bQdPlXqK5cPIzKB7TnKNTvrPTgjiRHm85I
         zI50n3q/efr5U3+ao3wFNpfnLiUpCcoQjwW+59JZy6c2QQ3cy2cwModWKSRRZeeU1fIe
         fwtbk4JkwJAB39wdG7sYWO1o9sYs5A/Xu+cfN/cHbcrVZW0diIgbu4RVvJTvPEBWPfcv
         0oONX13RmAr/VEmdLnxRfpOIh4+AWG198wOFgXVDFcVcs14HX0jrUhxulTZhguhXTZPP
         4JZjWhNfOTOVmRD+eI3e/t5KltIar9yW2QL7SGeISgaBoEDKtg4a+UHznWyqG68F7PI2
         kI+A==
X-Gm-Message-State: AOAM531dWxhGpIdKc40yOBWR0E0FCS2d6D5YPQkF1H/7synUj9U/Sxwz
        Vch6jhUQ9kVvAcdTsmE6Cyoptt/x6CTe0r2fAGhYdQ==
X-Google-Smtp-Source: ABdhPJxp7bqY5lQnD8NOcSvVk9/VYysZ+n/SYHKIGxtdvY95XsVL02z/7wGmBWqR7o2ga2M99jkzxWkNGfllJY+iSJ0=
X-Received: by 2002:adf:e5d2:0:b0:207:9be3:c080 with SMTP id
 a18-20020adfe5d2000000b002079be3c080mr12995747wrn.519.1649752235431; Tue, 12
 Apr 2022 01:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-3-james.clark@arm.com>
In-Reply-To: <20220304171913.2292458-3-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 09:30:23 +0100
Message-ID: <CAJ9a7VjwRDF+J7K-TmWYLVEE72EqW+_YRgfuVz5N5wi8KQbodA@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] coresight: etm4x: Cleanup TRCIDR2 register accesses
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
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 6 +++---
>  drivers/hwtracing/coresight/coresight-etm4x.h      | 4 ++++
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 9120390a7613..fd44231e9d8a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1116,11 +1116,11 @@ static void etm4_init_arch_data(void *info)
>         /* maximum size of resources */
>         etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
>         /* CIDSIZE, bits[9:5] Indicates the Context ID size */
> -       drvdata->ctxid_size = BMVAL(etmidr2, 5, 9);
> +       drvdata->ctxid_size = FIELD_GET(TRCIDR2_CIDSIZE_MASK, etmidr2);
>         /* VMIDSIZE, bits[14:10] Indicates the VMID size */
> -       drvdata->vmid_size = BMVAL(etmidr2, 10, 14);
> +       drvdata->vmid_size = FIELD_GET(TRCIDR2_VMIDSIZE_MASK, etmidr2);
>         /* CCSIZE, bits[28:25] size of the cycle counter in bits minus 12 */
> -       drvdata->ccsize = BMVAL(etmidr2, 25, 28);
> +       drvdata->ccsize = FIELD_GET(TRCIDR2_CCSIZE_MASK, etmidr2);
>
>         etmidr3 = etm4x_relaxed_read32(csa, TRCIDR3);
>         /* CCITMIN, bits[11:0] minimum threshold value that can be programmed */
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 300741fbc0de..cfdf966016b7 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -143,6 +143,10 @@
>  #define TRCIDR0_QSUPP_MASK                     GENMASK(16, 15)
>  #define TRCIDR0_TSSIZE_MASK                    GENMASK(28, 24)
>
> +#define TRCIDR2_CIDSIZE_MASK                   GENMASK(9, 5)
> +#define TRCIDR2_VMIDSIZE_MASK                  GENMASK(14, 10)
> +#define TRCIDR2_CCSIZE_MASK                    GENMASK(28, 25)
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
