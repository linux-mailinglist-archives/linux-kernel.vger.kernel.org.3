Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCBD52C22C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241467AbiERS0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241366AbiERS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:26:05 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452F17CDE7;
        Wed, 18 May 2022 11:26:03 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id y20so2108011qvx.3;
        Wed, 18 May 2022 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfgYoWCNYtN7yDfm2+d3s9VvRbNwsmq2M10lbEvV91w=;
        b=BU4UhCSBQmodnhlemcE31H7c2P5bS4uD95BTXf+A6pZjh/XS3tC1t1En3GecHCtM0t
         mXQzgOkt6y2dhDUY4NaqxzkRzFnNMxFB4vbJUXChGiDaCeCFkzu5wJklFunrx/hsoTT4
         DDRXS8UCcvLanVCmZV8nJjMyto4R6qqi3P1Tm23y4csTS2oY7xthDULzOf5X+hnuKGaJ
         X03is8tUWDjhmeZkDo6Ma0u3ZEmvm5T17uAkkGtZd6pAO5HEFbHOq5jKBTJEThCQyV8/
         EMQVr/w2ANjh/ZxHtdzRLqqlA8lxcIh0UiG47/f0dRuTjnFXUSDrVFyIgBdYSFOEHDqo
         hfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfgYoWCNYtN7yDfm2+d3s9VvRbNwsmq2M10lbEvV91w=;
        b=jEkzD9UEu6pILcZi/1ENbeJH4Hq/TWjVTgnaXOVX4TUzZpm+WdgRLN9Vdy/muXFNuY
         uWzTT9Lv6ga4Zio3pFFppxWsVtOesA0B6NeRFFtov4GAeNI2ydW19QY89Y6ASDrGjjLn
         F3OAqfRYH0/6nEnwy47LL7bYssq7cMOMdaBsHXIHDT7tWluqBcezOxRpD+ZfYXKhdcV/
         Ie5kZRoj6v49L2kcTU5OY+d1/k0ddDnk9hlJDoutsF8i/hiB9Ja5qehR/LaKLQ906j8c
         5MP1gb/fmECdQLiir5Uj0smk+IbPAKuNGGBHEcKWMY09CUim7oqK3HC3lYDgvjqeOK/O
         31ZQ==
X-Gm-Message-State: AOAM532XZ59VtOhDzBX4Jv/UX92XQMdB08L+J31totlxfI2bZdJaicUv
        cV7Aw3gwk43uJDSkjGOqLYEGA8iPGgaeRffX/lk=
X-Google-Smtp-Source: ABdhPJxjdpnM2ndfyB5ODLWDF8yv7yrQbec+TF3B+bzIAyN+RclUCT2TptIXCHT028RbwipcOB7Y/r3VopoJQUn8u/U=
X-Received: by 2002:a05:6214:48f:b0:461:d4fe:4eed with SMTP id
 ay15-20020a056214048f00b00461d4fe4eedmr859981qvb.48.1652898362364; Wed, 18
 May 2022 11:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220517205341.536587-1-robimarko@gmail.com> <20220517205341.536587-4-robimarko@gmail.com>
 <d60f32dc-a9f5-95ad-245e-6b9521d73fce@somainline.org> <CAOX2RU7jCdggA8y1cE4sfZLw_niDUNkG8pkJ=d=5mM1BbrrBQA@mail.gmail.com>
In-Reply-To: <CAOX2RU7jCdggA8y1cE4sfZLw_niDUNkG8pkJ=d=5mM1BbrrBQA@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 18 May 2022 20:25:51 +0200
Message-ID: <CAOX2RU4wVXvm93Z5u1hEEUxn4S2YDGHVq_89Z7b-ryf0t7iJSg@mail.gmail.com>
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

On Wed, 18 May 2022 at 19:31, Robert Marko <robimarko@gmail.com> wrote:
>
> On Wed, 18 May 2022 at 15:42, Konrad Dybcio
> <konrad.dybcio@somainline.org> wrote:
> >
> >
> > On 17/05/2022 22:53, Robert Marko wrote:
> > > PMP8074 is a companion PMIC for the Qualcomm IPQ8074 WiSoC-s.
> > >
> > > It features 5 HF-SMPS and 13 LDO regulators.
> > >
> > > This commit adds support for S3 and S4 HF-SMPS buck regulators of
> > > the HFS430 type and LDO11 of the HT_P150 type.
> > > S3 is the CPU cluster voltage supply, S4 supplies the UBI32 NPU cores
> > > and LDO11 is the SDIO/eMMC I/O voltage regulator required for high speeds.
> > >
> > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > ---
> > >   drivers/regulator/qcom_spmi-regulator.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
> > > index 38bbc70241ae..696b088aae40 100644
> > > --- a/drivers/regulator/qcom_spmi-regulator.c
> > > +++ b/drivers/regulator/qcom_spmi-regulator.c
> > > @@ -2137,6 +2137,13 @@ static const struct spmi_regulator_data pms405_regulators[] = {
> > >       { }
> > >   };
> > >
> > > +static const struct spmi_regulator_data pmp8074_regulators[] = {
> >
> > Please sort the struct alphabletically.
>
> Hi,
> Will fixup in v3.
>
> >
> >
> > > +     { "s3", 0x1a00, "vdd_s3"},
> > > +     { "s4", 0x1d00, "vdd_s4"},
> > > +     { "l11", 0x4a00, "vdd_l10_l11_l12_l13"},
> >
> > Are the other regulators somehow not controllable through SPMI? Please
> > leave a comment if that's the case.
>
> No, they are all controllable via SPMI as far as I know.
> Though the output table completely leaves out L7, L9, and L10.
> L5 and L6 are specified as Ebuck-4 subtypes (0x3d), while L10 is not
> listed at all (0x34).

Ok, I dug a bit further and L5/6 are HT_P600 and are easily supportable.
L10 is an HT_P50 type but it's listed as unused and left disabled, I don't know
its supported output voltage range.

Regards,
Robert

> These are not currently supported and I don't have enough information
> to support them.
> L1, L2, L3, L4, L7, L8, L9, L11, L12, and L13 appear to have their
> subtype already supported.
> L1, L2, L3, L8, L9 subtype (0x32)
> L4 subtype (0x30)
> L7, L11, L12, L13 subtype (0x35)
>
> S3, S4, and L11 are the most important ones.
> >
> >
> > > +     { }
> > > +};
> > > +
> > >   static const struct of_device_id qcom_spmi_regulator_match[] = {
> > >       { .compatible = "qcom,pm8004-regulators", .data = &pm8004_regulators },
> > >       { .compatible = "qcom,pm8005-regulators", .data = &pm8005_regulators },
> > > @@ -2150,6 +2157,7 @@ static const struct of_device_id qcom_spmi_regulator_match[] = {
> > >       { .compatible = "qcom,pm660-regulators", .data = &pm660_regulators },
> > >       { .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
> > >       { .compatible = "qcom,pms405-regulators", .data = &pms405_regulators },
> > > +     { .compatible = "qcom,pmp8074-regulators", .data = &pmp8074_regulators },
> >
> > Please sort the compatible too.
>
> Will fixup in v3.
>
> Regards,
> Robert
> >
> >
> > Konrad
> >
> > >       { }
> > >   };
> > >   MODULE_DEVICE_TABLE(of, qcom_spmi_regulator_match);
> > >
