Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8352C169
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbiERRbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240922AbiERRbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:31:35 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9A154011;
        Wed, 18 May 2022 10:31:32 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id s5so2015850qvo.12;
        Wed, 18 May 2022 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tp/rNQKL0TWzy+hRF9HYHRScsQKVTMKttWXmuk1QTdU=;
        b=X6W1PeMM8ZLYjmUO8hou2BR60SvbPoWsE8CnU9Vji0yuxYuV/9porT4XzVYYuCMc5/
         Cd7Te/0gxi8mpxQcAzNvHATwYDusKZ1p6XEctuO9hxzgKi5X8QWUeg2m8SqoEA8IGBq3
         ObkqXv5FAq8qFxIFR7DqRk4RIH03RTY5lFEARCN9AQh3KfmmO3MzM8f63lHmy1zF7WSW
         Sdo8bcID+kaJi0VseRe6dpd1iD+DN1bzGD4/NNoyNSZyzq8fWPWcqkRS94AU5/e4AMmw
         C0xVLEKjRkxbn7w6oxGkt/RV/Jg3KL4DxiEHAhBwuWllXvPCuI39VxPTedNQUcebYeHu
         Uhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tp/rNQKL0TWzy+hRF9HYHRScsQKVTMKttWXmuk1QTdU=;
        b=T7rB4vr/Y39znxxTBhBaf/PcpSVNBSYpl1+UymZ6dUs0c60JnfGAbmj9812Wr5Veoq
         /SvsmZ51p+22JVVBizyC9Er30OVdDFzqyKhzzxwq1YqN0pdSglkkpTvqO9aWCN8HQlFP
         8nVwf6Y3rTxzvvamYTBRNsz0WpXDPM/gKl65JAzWhn8dmI0NDSaF4ukjwG6x9shvPuAy
         1gKiGYrD73h2hG37suqF4X9bljn+FP8Aiq2A3uhLND8SfvKOKMjouN/i7QqFWSq4YUXQ
         cGKkTxgA5sLPVOBYSxGNPQRvAKYMu/ljSNxyIyoSdggT/UylY9/UINropWiqr8UJTk2e
         tJnA==
X-Gm-Message-State: AOAM532y36p+RFgEIng2WSCKEw/LfH3C+XJf1+HYnK8SJXaWeMwPa0+y
        Hy0pSlp/8po1SBwRo68M+C+12cICkSN9ZwSam4Q=
X-Google-Smtp-Source: ABdhPJzRW7al4Gnd3IWntgOH06VaU22uUJAO/dwGmNmlk88NT5JvG2PDbjaRbSreeKg64ycU+LFYEWx/FMUQIRctHZQ=
X-Received: by 2002:ad4:5bef:0:b0:45c:e552:8e63 with SMTP id
 k15-20020ad45bef000000b0045ce5528e63mr855418qvc.34.1652895091597; Wed, 18 May
 2022 10:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220517205341.536587-1-robimarko@gmail.com> <20220517205341.536587-4-robimarko@gmail.com>
 <d60f32dc-a9f5-95ad-245e-6b9521d73fce@somainline.org>
In-Reply-To: <d60f32dc-a9f5-95ad-245e-6b9521d73fce@somainline.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 18 May 2022 19:31:20 +0200
Message-ID: <CAOX2RU7jCdggA8y1cE4sfZLw_niDUNkG8pkJ=d=5mM1BbrrBQA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] regulator: qcom_spmi: Add support for PMP8074 regulators
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 at 15:42, Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
> On 17/05/2022 22:53, Robert Marko wrote:
> > PMP8074 is a companion PMIC for the Qualcomm IPQ8074 WiSoC-s.
> >
> > It features 5 HF-SMPS and 13 LDO regulators.
> >
> > This commit adds support for S3 and S4 HF-SMPS buck regulators of
> > the HFS430 type and LDO11 of the HT_P150 type.
> > S3 is the CPU cluster voltage supply, S4 supplies the UBI32 NPU cores
> > and LDO11 is the SDIO/eMMC I/O voltage regulator required for high speeds.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >   drivers/regulator/qcom_spmi-regulator.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
> > index 38bbc70241ae..696b088aae40 100644
> > --- a/drivers/regulator/qcom_spmi-regulator.c
> > +++ b/drivers/regulator/qcom_spmi-regulator.c
> > @@ -2137,6 +2137,13 @@ static const struct spmi_regulator_data pms405_regulators[] = {
> >       { }
> >   };
> >
> > +static const struct spmi_regulator_data pmp8074_regulators[] = {
>
> Please sort the struct alphabletically.

Hi,
Will fixup in v3.

>
>
> > +     { "s3", 0x1a00, "vdd_s3"},
> > +     { "s4", 0x1d00, "vdd_s4"},
> > +     { "l11", 0x4a00, "vdd_l10_l11_l12_l13"},
>
> Are the other regulators somehow not controllable through SPMI? Please
> leave a comment if that's the case.

No, they are all controllable via SPMI as far as I know.
Though the output table completely leaves out L7, L9, and L10.
L5 and L6 are specified as Ebuck-4 subtypes (0x3d), while L10 is not
listed at all (0x34).
These are not currently supported and I don't have enough information
to support them.
L1, L2, L3, L4, L7, L8, L9, L11, L12, and L13 appear to have their
subtype already supported.
L1, L2, L3, L8, L9 subtype (0x32)
L4 subtype (0x30)
L7, L11, L12, L13 subtype (0x35)

S3, S4, and L11 are the most important ones.
>
>
> > +     { }
> > +};
> > +
> >   static const struct of_device_id qcom_spmi_regulator_match[] = {
> >       { .compatible = "qcom,pm8004-regulators", .data = &pm8004_regulators },
> >       { .compatible = "qcom,pm8005-regulators", .data = &pm8005_regulators },
> > @@ -2150,6 +2157,7 @@ static const struct of_device_id qcom_spmi_regulator_match[] = {
> >       { .compatible = "qcom,pm660-regulators", .data = &pm660_regulators },
> >       { .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
> >       { .compatible = "qcom,pms405-regulators", .data = &pms405_regulators },
> > +     { .compatible = "qcom,pmp8074-regulators", .data = &pmp8074_regulators },
>
> Please sort the compatible too.

Will fixup in v3.

Regards,
Robert
>
>
> Konrad
>
> >       { }
> >   };
> >   MODULE_DEVICE_TABLE(of, qcom_spmi_regulator_match);
> >
