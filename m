Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EEF573E22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbiGMUsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbiGMUrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:47:45 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C913190A;
        Wed, 13 Jul 2022 13:47:18 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id ck6so12868427qtb.7;
        Wed, 13 Jul 2022 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxqplqseSWaS3T37CnGU50c0cuM5vlsIJtab1NxopUc=;
        b=jhGbdskv1XZp9zg+RMpcunfdt/ThU42O3H/Z+2KL/DCbS+D8RrSrFh/Y1sobtPDv7Z
         Tdv+LA5vjQ1iv0mJ/ogTQp17ON3e+09Fseq5mRzdP97xdMOVcrIjE0N2nYKAt/xcB7oT
         yHTzTskKOeBqJ1H17ZRNV8lKRBLLHKWYwmVtd2sZHYEA+9Jq+diNzZ0vcOp9yGFXct4m
         SwSmD7OfOBwiZjk64xXuQfBGitNQ2JIkZ48XcRkWPJ3l0Je9znTKzMxl+eDmhmRnCOQ0
         cVuJgHGSs2Gul8e8Yeo0Mj9dmGljW4crYS2UhsotQfCJ/j2wOHe5PkoU0Qm/iFACK320
         NQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxqplqseSWaS3T37CnGU50c0cuM5vlsIJtab1NxopUc=;
        b=XpQEWldE+5jsJr4cOb4hJapq3O0XqAD8OST4td7dhIc0NUDZ6iq9+EpDkRJoupSsKT
         mSNiHCrdn3OsrfSsxr1V7Aj5rf1Zn6xqTg8uY4TIfmTT5RqH+0acprh44+MbaEanHQ6A
         xfeCtG9+6k6AKZdByGJ8mazxGJX88vjEkh8JvG03tFvET20uEzIqxZcu0mHRbplZMUON
         8hLvQ69++QRho294xssrNZy0SDmPplTibcNAykTNKbvpcXsk9PmnXEVgZSfuVIHJ7coo
         ux1qPwwXBF/A0WclqEjY85+u4avGuAy2T9IRTywTACI3u+36LlGhiOVbp2FX9pAN/VyP
         zocQ==
X-Gm-Message-State: AJIora/EgNCwKySwSEaxmZszrUEL2v1YOkMbQ+FeKMNiVhBydWXPsRm2
        JrmfxztiOWJAsh+zjBQiIL/OYkzPymFV5KEYm3Y=
X-Google-Smtp-Source: AGRyM1s3CBz7Bos23p6iO45MPRR3/nqp3k5HlInZUfT0rxzTuk0pjcjlEVmrOCSt199k0tcETah6lIbRqUqrNq7jsk0=
X-Received: by 2002:a05:622a:178d:b0:31e:c386:510e with SMTP id
 s13-20020a05622a178d00b0031ec386510emr5128025qtk.82.1657745237430; Wed, 13
 Jul 2022 13:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220707173733.404947-1-robimarko@gmail.com> <20220707173733.404947-2-robimarko@gmail.com>
 <Ys8ukbAbrxwLG0XH@builder.lan>
In-Reply-To: <Ys8ukbAbrxwLG0XH@builder.lan>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 13 Jul 2022 22:47:06 +0200
Message-ID: <CAOX2RU6YxjN3XCRSsih7cpO6H1JvXLMG7=PNmzrbk+_Ksx8x-g@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock
 controller support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

On Wed, 13 Jul 2022 at 22:44, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 07 Jul 12:37 CDT 2022, Robert Marko wrote:
>
> > IPQ8074 has the APSS clock controller utilizing the same register space as
> > the APCS, so provide access to the APSS utilizing a child device like
> > IPQ6018 does as well, but just by utilizing the IPQ8074 specific APSS
> > clock driver.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Bjorn, please ignore the v6 series, a way simplified and better
support is in the v8 series.
Which is mostly reviewed, only DTS is pending.

Regards,
Robert
>
> Regards,
> Bjorn
>
> > ---
> > Changes in v6:
> > * Adjust max_register value using match data instead of globally
> >
> > Changes in v5:
> > * Use lower case hex for max_register
> > * Update the APSS clock name to match the new one without commas
> > ---
> >  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> > index c05f3276d02c..5d6b41fa6256 100644
> > --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> > +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> > @@ -34,6 +34,12 @@ static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
> >       .offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
> >  };
> >
> > +static const struct qcom_apcs_ipc_data ipq8074_apcs_data = {
> > +     .offset = 8,
> > +     .max_register = 0x5ffc,
> > +     .clk_name = "qcom-apss-ipq8074-clk"
> > +};
> > +
> >  static const struct qcom_apcs_ipc_data msm8916_apcs_data = {
> >       .offset = 8, .clk_name = "qcom-apcs-msm8916-clk"
> >  };
> > @@ -148,7 +154,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
> >  /* .data is the offset of the ipc register within the global block */
> >  static const struct of_device_id qcom_apcs_ipc_of_match[] = {
> >       { .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
> > -     { .compatible = "qcom,ipq8074-apcs-apps-global", .data = &msm8994_apcs_data },
> > +     { .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq8074_apcs_data },
> >       { .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
> >       { .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
> >       { .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
> > --
> > 2.36.1
> >
