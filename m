Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5674FD5AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391681AbiDLJfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389364AbiDLJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:23:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B3421BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:37:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e21so10105670wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KueaafBCeJeb8X5fTOt3ZTO9jhoa81nVXCf85JsoVfg=;
        b=hGWUwdEGiI8eiml7vIPA0KT83FdxzPsvJULyHlUCmNhsqgSH4R3tDCXlxp3SwdvlLP
         5XIPXzt/t26kseGz1CWRON00uHpRPfGEJtKuqN1pT5SOvaB51YLu/F8dOvRI28o8pSWc
         7Al7QpJlXjIFkmkLIfd9l05lv7Hz6juD/cYlZakeZc6D8NL13hk6sFGfW3W0PgtIz4kO
         yRTQQ2HnmZ5XMmnLVXio5GzBS47SxrJBPqvW5P/VQ6fvx0a4Whe1IetCdFoiEQEO2L+s
         0bE8OY0wxEjyrHgdDFuNOZoZsIokwx1WJa7KdMUTc8guZ3IKPI1g4ghkRo6bqkKGIEzt
         fg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KueaafBCeJeb8X5fTOt3ZTO9jhoa81nVXCf85JsoVfg=;
        b=zyUorYTGfPvFAlDIq/N8H1QHe6dKwooflPTcU/f8UaJry+2Tji6ZXTUSoQ98189m4h
         cfC5TrF0ch01WhI2zkTyhHLh+ublCa3IrRs+Fn+ixEg53UjFkM4CFJQKpEo1V+0a7C0+
         a0QR0/FiANVf+6oieg14KP3qdZBvV7ds2oD6Ine3k3zOrQxOW6lYRLd4SNO6iKzkncgq
         /Fgxd4osx4Vbq1Dp8eww0xcwxbtan2x3JRyqm3+nUk/q+dbzIxyjjiUHDv64DAQFZKrP
         Zkp/AeJcyys3rsmxQ3IAeolZOw0k826DH6bbrcdqZU2RpfSZ3i7Hk45/mmOVJ/VeuwWJ
         06cw==
X-Gm-Message-State: AOAM533i/n27JLZRaM3WkWKBGrlACBVUd15A64QE1gHg87FAXdr/9LSu
        DRLflhhbpEo8o67q0mXJK+KxqdOraOB7iLX1fh3+FA==
X-Google-Smtp-Source: ABdhPJzlR1P1z3GTJ0AcRQ80Hob6Wx2eGcmvHIHVYR2jJRQ8HI/D9Gk32iW2lSDPivgRP+0NCc64XiIZcmGzNCqtBgs=
X-Received: by 2002:adf:e108:0:b0:1ef:97ad:5372 with SMTP id
 t8-20020adfe108000000b001ef97ad5372mr27423376wrz.658.1649752671320; Tue, 12
 Apr 2022 01:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-5-james.clark@arm.com>
In-Reply-To: <20220304171913.2292458-5-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 09:37:39 +0100
Message-ID: <CAJ9a7Vi7fEXNTPbN_d1Gnf0pqtmoK6xUvioq3mvuUpdA0yq7Yw@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] coresight: etm4x: Cleanup TRCIDR4 register accesses
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
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 ++++++------
>  drivers/hwtracing/coresight/coresight-etm4x.h      |  8 ++++++++
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 1b377f6b31bf..c52ab7f29f41 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1155,9 +1155,9 @@ static void etm4_init_arch_data(void *info)
>         /* number of resources trace unit supports */
>         etmidr4 = etm4x_relaxed_read32(csa, TRCIDR4);
>         /* NUMACPAIRS, bits[0:3] number of addr comparator pairs for tracing */
> -       drvdata->nr_addr_cmp = BMVAL(etmidr4, 0, 3);
> +       drvdata->nr_addr_cmp = FIELD_GET(TRCIDR4_NUMACPAIRS_MASK, etmidr4);
>         /* NUMPC, bits[15:12] number of PE comparator inputs for tracing */
> -       drvdata->nr_pe_cmp = BMVAL(etmidr4, 12, 15);
> +       drvdata->nr_pe_cmp = FIELD_GET(TRCIDR4_NUMPC_MASK, etmidr4);
>         /*
>          * NUMRSPAIR, bits[19:16]
>          * The number of resource pairs conveyed by the HW starts at 0, i.e a
> @@ -1168,7 +1168,7 @@ static void etm4_init_arch_data(void *info)
>          * the default TRUE and FALSE resource selectors are omitted.
>          * Otherwise for values 0x1 and above the number is N + 1 as per v4.2.
>          */
> -       drvdata->nr_resource = BMVAL(etmidr4, 16, 19);
> +       drvdata->nr_resource = FIELD_GET(TRCIDR4_NUMRSPAIR_MASK, etmidr4);
>         if ((drvdata->arch < ETM_ARCH_V4_3) || (drvdata->nr_resource > 0))
>                 drvdata->nr_resource += 1;
>         /*
> @@ -1176,15 +1176,15 @@ static void etm4_init_arch_data(void *info)
>          * comparator control for tracing. Read any status regs as these
>          * also contain RO capability data.
>          */
> -       drvdata->nr_ss_cmp = BMVAL(etmidr4, 20, 23);
> +       drvdata->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
>         for (i = 0; i < drvdata->nr_ss_cmp; i++) {
>                 drvdata->config.ss_status[i] =
>                         etm4x_relaxed_read32(csa, TRCSSCSRn(i));
>         }
>         /* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
> -       drvdata->numcidc = BMVAL(etmidr4, 24, 27);
> +       drvdata->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);
>         /* NUMVMIDC, bits[31:28] number of VMID comparators for tracing */
> -       drvdata->numvmidc = BMVAL(etmidr4, 28, 31);
> +       drvdata->numvmidc = FIELD_GET(TRCIDR4_NUMVMIDC_MASK, etmidr4);
>
>         etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
>         /* NUMEXTIN, bits[8:0] number of external inputs implemented */
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 1b95c63938f0..c9c5fd655196 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -157,6 +157,14 @@
>  #define TRCIDR3_NUMPROC_LO_MASK                        GENMASK(30, 28)
>  #define TRCIDR3_NUMPROC_HI_MASK                        GENMASK(13, 12)
>  #define TRCIDR3_NOOVERFLOW                     BIT(31)
> +
> +#define TRCIDR4_NUMACPAIRS_MASK                        GENMASK(3, 0)
> +#define TRCIDR4_NUMPC_MASK                     GENMASK(15, 12)
> +#define TRCIDR4_NUMRSPAIR_MASK                 GENMASK(19, 16)
> +#define TRCIDR4_NUMSSCC_MASK                   GENMASK(23, 20)
> +#define TRCIDR4_NUMCIDC_MASK                   GENMASK(27, 24)
> +#define TRCIDR4_NUMVMIDC_MASK                  GENMASK(31, 28)
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
