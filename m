Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8448573E15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbiGMUrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbiGMUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:46:51 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9404131384;
        Wed, 13 Jul 2022 13:46:41 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f14so9584688qkm.0;
        Wed, 13 Jul 2022 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U26H2yjtoqk3G+ApdwFG0UDwZ7t26E242ISXdxHOwaQ=;
        b=dcwvse6elpSIaOaq/tnBh6PpOGmEmljnwtockaiBKoLjZQwIZbXDow/z/+mscLYzJI
         eetmXqZ1TkRCVmdvru6YWV48vFGJAFo1hHFLlgl7RlZFoBvGpaeZQQNbaHdqNgXyRvF2
         2PLil+Z8hEiIWZQAW0Xi63UmvZY2Y/jgbWB4pEx0qB81YCN3leW6/ahtdY2DvjAit9Ih
         x0YFYEKabAImM3U9SI52qfzKLWz8Mdme5JIZLKrdoZzXBSbTZUU1Yexm1jSDPyYINB34
         5yJSCWkDr0Atf2SANl3nErYkpF6I9oQAmKlXASu6bqARrE6LxyEWM1pLAygPs7b7+l2a
         L9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U26H2yjtoqk3G+ApdwFG0UDwZ7t26E242ISXdxHOwaQ=;
        b=xI5yMp+fpHPILSXHlBVH7OAX82cCqEKA+XqQdHsN4PWnWW4BO/wG3469MdoyLqCg3x
         PC5zJLoxlTMPz3LtAgZiFbisQzTZRZHm9P7zUYT9IVVzP3yr2IVKJJwLV6LnHxtoOdbk
         VM0LOQQ8OkolhJ1gf0KYUdl5ahQ4nth47sYeP0luyMHhF7azHdNdgvC72c/RgaW/MGZM
         S5FubcwBqSSeHNBhRc0kEAfo2ZDgFGA3yvHBpvsbAmUgAvdv9wRVcezbZbhIoSLiO/Ni
         V6r/Pkx2dL4cZB0HgN6mortFZo6Dma9yNx/FgcsMQxAgwACbjMLRJ100POQVzc3Wxa/p
         O3Kw==
X-Gm-Message-State: AJIora/E4J2bQSNjh4kfVp119b6+HzWxGRqZFVAdqXK1dDMUFYgKjm/3
        k+KzdYuJQIkdfV9x5RKIPDwZ4e4VpvZDPmiv7mM=
X-Google-Smtp-Source: AGRyM1tNIunw5L6nNXKP9rKwC6LXKYoJ+y6XCGUk8pXb+cDj/D2cB5FQgQbBGuGK2yu9pMS63FL1HJQJ7LFEUkCDjic=
X-Received: by 2002:a05:620a:1a01:b0:6b5:af87:aaf3 with SMTP id
 bk1-20020a05620a1a0100b006b5af87aaf3mr3828597qkb.42.1657745200614; Wed, 13
 Jul 2022 13:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220707173733.404947-1-robimarko@gmail.com> <Ys8ueXn77ZjRTt25@builder.lan>
In-Reply-To: <Ys8ueXn77ZjRTt25@builder.lan>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 13 Jul 2022 22:46:29 +0200
Message-ID: <CAOX2RU491K_ze466NRBg401YcwFHXxB+KZBhx=nJ8O_6abn3oQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mailbox: qcom-apcs-ipc: make regmap max_register configurable
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

On Wed, 13 Jul 2022 at 22:43, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 07 Jul 12:37 CDT 2022, Robert Marko wrote:
>
> > APCS register space in IPQ8074 is 0x6000 so regmap max_register needs to
> > be 0x5ffc.
> >
> > Instead of making it global, make max_register configurable via match data.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Bjorn, please ignore the v6 series, a way simplified and better
support is in the v8 series.

Regards,
Robert
>
> Regards,
> Bjorn
>
> > ---
> >  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> > index 80a54d81412e..c05f3276d02c 100644
> > --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> > +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> > @@ -27,6 +27,7 @@ struct qcom_apcs_ipc {
> >  struct qcom_apcs_ipc_data {
> >       int offset;
> >       char *clk_name;
> > +     unsigned int max_register;
> >  };
> >
> >  static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
> > @@ -53,7 +54,7 @@ static const struct qcom_apcs_ipc_data sdx55_apcs_data = {
> >       .offset = 0x1008, .clk_name = "qcom-sdx55-acps-clk"
> >  };
> >
> > -static const struct regmap_config apcs_regmap_config = {
> > +static struct regmap_config apcs_regmap_config = {
> >       .reg_bits = 32,
> >       .reg_stride = 4,
> >       .val_bits = 32,
> > @@ -91,12 +92,17 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
> >       if (IS_ERR(base))
> >               return PTR_ERR(base);
> >
> > +     apcs_data = of_device_get_match_data(&pdev->dev);
> > +     if (!apcs_data)
> > +             return -ENODATA;
> > +
> > +     if (apcs_data->max_register)
> > +             apcs_regmap_config.max_register = apcs_data->max_register;
> > +
> >       regmap = devm_regmap_init_mmio(&pdev->dev, base, &apcs_regmap_config);
> >       if (IS_ERR(regmap))
> >               return PTR_ERR(regmap);
> >
> > -     apcs_data = of_device_get_match_data(&pdev->dev);
> > -
> >       apcs->regmap = regmap;
> >       apcs->offset = apcs_data->offset;
> >
> > --
> > 2.36.1
> >
