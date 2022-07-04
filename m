Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33603565DED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiGDTUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiGDTUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:20:31 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEBB60C2;
        Mon,  4 Jul 2022 12:20:30 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id bs20so10960167qtb.11;
        Mon, 04 Jul 2022 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=efBiIx6Z74wz+LEYNht2L8mOGHfZ2/nsYi3si0X8qUQ=;
        b=oUIROjQTvBzdYVfmxDoO4IvUMCJsVN0ErIlpDYdemPxncSnGAikTY+jF7Lh5tmyceE
         okQFItfBRzQ8oa4PwELKembxTH5KTsv4LnNPp+onGOKZo+EouITj75jQ19T2gzYEj3if
         gPho36rodSAQtXRh6xFAi2/5C8dEEtl99A7tXaQsY7Tiq64S8Ed7HFpfLvW6u58AUK+M
         DHtR/8pR/WoEBqi3926jPFDAI33/nHtbk1JwgsXyIlYaBg3smQKG1MUAQT+j+i1U5dCH
         RdoJ4pzBpMhdv/BwK5wQ9Tv9K2UyKMEUnmwty4GwgQ2epoQhLrjDW2Ctz6aLeTW8yDyR
         j9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efBiIx6Z74wz+LEYNht2L8mOGHfZ2/nsYi3si0X8qUQ=;
        b=0sBvTRcSn8eZUQsQ4YuK26IURh2FoqeuS4k9sqXV4Ks84/RGUEbc/hTN9e9YbIxZ9+
         AIAOfskXBylVl2crIiGPEhD8qLTUctq4LZsqqmZwGlgwtPR8o4DtyfQfhPHAUjUcUkJV
         z/wQYTDuOH0y0AQU8UocCuzDWblKt0CwvD9/OuP3LHvS2BG3QPTqRS1OBBhJgG0r4jzL
         85ekiRbQ71ERzrX3tPpR55HkbJZzYIHJXsnrgeyElNjP5I1sBhoAva4HpnLfu8WCfr8b
         ys4+qdC8jT6KZ6GWu+LcAb5taVaAPfvx8oylD1+P+iM+cN+NwsX78mVcCevp0Gdc5RxJ
         O1FA==
X-Gm-Message-State: AJIora8bJIaruBqXGRjQ3VstlgITJNQ9XpVcwhIufRYWa2SUCX6wgfVL
        +mk8HiF3PWD6pipq2orMoULGFCWlltijKena0NU=
X-Google-Smtp-Source: AGRyM1v9fjtjLV5IOZSPd2UXznyGsSvexOh1kKFoICuxe2R5nQ/R8J3odTQoWU/bbnb5YCO8GjE1rNVnoL12U5EFUto=
X-Received: by 2002:ac8:59c9:0:b0:31c:22a5:9a5d with SMTP id
 f9-20020ac859c9000000b0031c22a59a5dmr25171871qtf.494.1656962429931; Mon, 04
 Jul 2022 12:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220515204540.477711-1-robimarko@gmail.com> <20220515204540.477711-4-robimarko@gmail.com>
 <Yr4q0G1AT4YSOIU5@builder.lan>
In-Reply-To: <Yr4q0G1AT4YSOIU5@builder.lan>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 4 Jul 2022 21:20:19 +0200
Message-ID: <CAOX2RU6UFpZPN0EO+Jyg93x7audYPhq+yzPM2gURUmOBheTLeA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock
 controller support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-clk@vger.kernel.org
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

On Fri, 1 Jul 2022 at 00:59, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Sun 15 May 15:45 CDT 2022, Robert Marko wrote:
>
> > IPQ8074 has the APSS clock controller utilizing the same register space as
> > the APCS, so provide access to the APSS utilizing a child device like
> > IPQ6018 does as well, but just by utilizing the IPQ8074 specific APSS
> > clock driver.
> >
> > Also, APCS register space in IPQ8074 is 0x6000 so max_register needs to be
> > updated to 0x5FFC.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> > index 80a54d81412e..b3b9debf5673 100644
> > --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> > +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> > @@ -33,6 +33,10 @@ static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
> >       .offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
> >  };
> >
> > +static const struct qcom_apcs_ipc_data ipq8074_apcs_data = {
> > +     .offset = 8, .clk_name = "qcom,apss-ipq8074-clk"
> > +};
> > +
> >  static const struct qcom_apcs_ipc_data msm8916_apcs_data = {
> >       .offset = 8, .clk_name = "qcom-apcs-msm8916-clk"
> >  };
> > @@ -57,7 +61,7 @@ static const struct regmap_config apcs_regmap_config = {
> >       .reg_bits = 32,
> >       .reg_stride = 4,
> >       .val_bits = 32,
> > -     .max_register = 0x1008,
> > +     .max_register = 0x5FFC,
>
> Please use lower case hex digits.

Hi,
Will fix it in v5.

>
> And please send the mailbox patches separately, to make it clear for the
> maintainers that this can be picked independently of others.

Ok, will send patches 4-6 separately.

Regards,
Robert
>
> Regards,
> Bjorn
>
> >       .fast_io = true,
> >  };
> >
> > @@ -142,7 +146,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
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
