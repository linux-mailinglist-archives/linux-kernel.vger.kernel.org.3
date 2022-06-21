Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EBC5539AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiFUSmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiFUSmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:42:51 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C4210FDF;
        Tue, 21 Jun 2022 11:42:48 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o73so10808498qke.7;
        Tue, 21 Jun 2022 11:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGfOroIOMjBFMqeQB76AS2zkjX5R3sWEZA4rFxbtDBQ=;
        b=HaPkMUwgnEgi/9PaAOcWC82P8iy7ma5WP+KVn7AtLQrQ2yiWKH5BUiXKWbGX7E5Rzg
         E49RWWwOM/yXXNgSdMGJxZYanpzVi8l7hvtZnQRNtqEpzARBRTBMZfjD7zjWW7vljD0F
         GiI46C86bVKVlFvUHYqV5OYlt2CWnzusNiWrSkQf4Z1oIYUTWjkRabFndApyA0ima+lU
         XPIqNi/wCSUspcphNmBId1SJCVwyxbOOUbIPxH5BF17X8lS5AV6qTNvsWUVcGjh9R3iq
         VVIbT1h8xx/8CXBHmlTqUl7lfQTjIllzJD1UAC8eZ3rjUQERVSeM6PTPvUz/jhwE14YW
         l3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGfOroIOMjBFMqeQB76AS2zkjX5R3sWEZA4rFxbtDBQ=;
        b=YCRdSqqV8CQrGKr5UYPQaKlFzeOpceKoN7k5Gsjo72gn1hYhB1oT9jibvjowNxU6Y/
         JuTBjPHEc9fBE+AwQflSYslV6NC0imL1wVU/BnTWz/zGSe74K84ahnaKzQwCyNQ1eAWG
         6ezR1Z8YSKF8RKFLVD3QdxVjFcAi9Btf+LC2f88y1qAH5BN0KNxX1e+XMdW/2l2DvDtM
         rifUTlDphLVCJp6cwodCKKK6aEUlqlqxRafsuVlx9kTQOLTB0TJ/ikknLZo50NjEJvAq
         OM8g6uZSCPGaT+TkrHk3jc4WF03TASjBLDB3OifGe8bEF57FX51zPgmDm/dIwGncJkZA
         efMA==
X-Gm-Message-State: AJIora+DVXx89e90dHqnZ2RKt7hdnwrQXlo1IkpKypLQ80DCAgYCoKgP
        x6yD+IWHaICdxiVGiiXX/5oKijpBxSx+LLQ4GWI=
X-Google-Smtp-Source: AGRyM1thp6nGMmzuJ/FywLbVv3L0O0Cuj95xEMlgTJOo52d5Ia3+d17MP/ybPtJvqNB5yRqHv0+ZUwU2SpnOjgoK8Go=
X-Received: by 2002:a05:620a:2494:b0:6a7:6a06:7aae with SMTP id
 i20-20020a05620a249400b006a76a067aaemr21419086qkn.87.1655836968098; Tue, 21
 Jun 2022 11:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220621111818.447452-1-robimarko@gmail.com> <20220621111818.447452-2-robimarko@gmail.com>
 <CAA8EJposq4796b33jkovDDQdzQsrp733kN5tQYAhFow4G8hvow@mail.gmail.com>
In-Reply-To: <CAA8EJposq4796b33jkovDDQdzQsrp733kN5tQYAhFow4G8hvow@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 21 Jun 2022 20:42:37 +0200
Message-ID: <CAOX2RU51EtsrxissD1-yx2z4tesE4Lgd5nWDQ3USEwuwvw9+ng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] phy: qcom-qmp-pcie: add IPQ8074 PCIe Gen3 QMP PHY support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, kishon@ti.com,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Tue, 21 Jun 2022 at 19:26, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 21 Jun 2022 at 14:18, Robert Marko <robimarko@gmail.com> wrote:
> >
> > IPQ8074 has 2 different single lane PCIe PHY-s, one Gen2 and one Gen3.
> > Gen2 one is already supported, so add the support for the Gen3 one.
> > It uses the same register layout as IPQ6018.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes in v2:
> > * Rebase onto next-20220621 to apply on the refactored driver
> > * Remove non existant has_phy_com_ctrl and has_lane_rst
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 171 ++++++++++++++++++++++-
> >  1 file changed, 169 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index b2cd0cf965d8..b4836417b2c0 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>
> [skipped]
>
> > @@ -2121,8 +2277,16 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
> >
> >         init.ops = &clk_fixed_rate_ops;
> >
> > -       /* controllers using QMP phys use 125MHz pipe clock interface */
> > -       fixed->fixed_rate = 125000000;
> > +       /*
> > +        * Controllers using QMP PHY-s use 125MHz pipe clock interface
> > +        * unless other frequency is specified in the DTS.
> > +        */
> > +       ret = of_property_read_u32(np, "clock-output-rate", &rate);
>
> The clock-output-rate is a new property, which doesn't exist yet. If
> the rate is peculiar to your platform/PHY, I'd suggest adding a field
> to the qmp configuration instead.

Hi,
That sounds like a better idea than adding new DT property, it's
specific only to the Gen3 PHY
for IPQ8074.

I will change it for v3.

Regards,
Robert
>
> > +       if (ret)
> > +               fixed->fixed_rate = 125000000;
> > +       else
> > +               fixed->fixed_rate = rate;
> > +
> >         fixed->hw.init = &init;
> >
> >         ret = devm_clk_hw_register(qmp->dev, &fixed->hw);
> > @@ -2255,6 +2419,9 @@ static const struct of_device_id qcom_qmp_phy_pcie_of_match_table[] = {
> >         }, {
> >                 .compatible = "qcom,ipq8074-qmp-pcie-phy",
> >                 .data = &ipq8074_pciephy_cfg,
> > +       }, {
> > +               .compatible = "qcom,ipq8074-qmp-gen3-pcie-phy",
> > +               .data = &ipq8074_pciephy_gen3_cfg,
> >         }, {
> >                 .compatible = "qcom,ipq6018-qmp-pcie-phy",
> >                 .data = &ipq6018_pciephy_cfg,
> > --
> > 2.36.1
> >
>
>
> --
> With best wishes
> Dmitry
