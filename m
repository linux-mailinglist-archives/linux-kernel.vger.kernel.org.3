Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944815538D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353185AbiFUR0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352406AbiFUR0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:26:13 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841AE2D1F2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:26:12 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 68so10632799qkk.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rX/peAHmhyZwy77vQ2JcNhxgJXXBgZnIyQj7eweojrA=;
        b=fwypcRYdV1D8yWcf3IT9AiP9ODRtAGU+W+qLoiQFpNS34IWuY4vYKa1mjkpHQOFt8J
         pc7ymvs97JBiS2T5w4KusAoQ0s78r5pshZ0Nao/vhrzmzZRFeZqMn4xld9ZBr/5LbUlH
         pF62bCdEY1ttEbY5WjbhM2J5HRQ9ncfKyxkFjMdOgDzq9zLkvmqKObnrxNRuVZ11H5tH
         hJgJPss08/uELByIHex4h2I3QiGIvrrIMAMxFuM6wbaDJDp7CFOWXeXlUTWxO+vRdT49
         CEZEPYEk7RhOIb2xpkC2wnpwN6SjUe2PzdakfC236eczhf0NuZ3OP0vb/Z1zdByI7HtV
         x4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rX/peAHmhyZwy77vQ2JcNhxgJXXBgZnIyQj7eweojrA=;
        b=6XUQToHNse4y2T//pBHN+bUcVMfTPpAp+HVPUeIBzcTjUUihDb4Jll8OiKGI4eSnzx
         /t+A0c+eaNHmaIzpp/HJ2sej7pJ/HuwevmXqI8HnquKftE7TEHsgRBD2pwtd/x0AqWKz
         +bkbN9kobNl1QBT+n9tW2VJNqSKk4kn9FsHDNMGdETR1rAmKQhdYP0G/wsvkFUFQ9aZ8
         9HyvP3egD93GLLzR0CHSaeqHBhHafuR/cFGR1gAZD07Y5EMIk3/Se8BMZCPJBMXhjI/h
         vVXn6nsDtE9VfXFJOy/GmkNIlwbU/ejS8pdk7VIXytvpn3XXOfZ38u19GGw/R5T+s7mG
         5Tqw==
X-Gm-Message-State: AJIora8fQqdqm/ts7BXOPpsY8R5sLo3d60fGYgVxWppu1kcdk5RRJh4g
        kBXxorLzG+exKRQBxZlXhFQCWEc59g0jYEi6nVgIoA==
X-Google-Smtp-Source: AGRyM1tBlLWy/IzZYwrazH4Rk/tiu8x4mgf+qRApIeKdfuVwyySYOqQDFSnqtGWbl6uTf14jc0HkDInSpl6gsgXe+xQ=
X-Received: by 2002:a05:620a:4156:b0:6a6:f8d2:6d9e with SMTP id
 k22-20020a05620a415600b006a6f8d26d9emr21197020qko.30.1655832371507; Tue, 21
 Jun 2022 10:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220621111818.447452-1-robimarko@gmail.com> <20220621111818.447452-2-robimarko@gmail.com>
In-Reply-To: <20220621111818.447452-2-robimarko@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Jun 2022 20:26:00 +0300
Message-ID: <CAA8EJposq4796b33jkovDDQdzQsrp733kN5tQYAhFow4G8hvow@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] phy: qcom-qmp-pcie: add IPQ8074 PCIe Gen3 QMP PHY support
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 14:18, Robert Marko <robimarko@gmail.com> wrote:
>
> IPQ8074 has 2 different single lane PCIe PHY-s, one Gen2 and one Gen3.
> Gen2 one is already supported, so add the support for the Gen3 one.
> It uses the same register layout as IPQ6018.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v2:
> * Rebase onto next-20220621 to apply on the refactored driver
> * Remove non existant has_phy_com_ctrl and has_lane_rst
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 171 ++++++++++++++++++++++-
>  1 file changed, 169 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index b2cd0cf965d8..b4836417b2c0 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c

[skipped]

> @@ -2121,8 +2277,16 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>
>         init.ops = &clk_fixed_rate_ops;
>
> -       /* controllers using QMP phys use 125MHz pipe clock interface */
> -       fixed->fixed_rate = 125000000;
> +       /*
> +        * Controllers using QMP PHY-s use 125MHz pipe clock interface
> +        * unless other frequency is specified in the DTS.
> +        */
> +       ret = of_property_read_u32(np, "clock-output-rate", &rate);

The clock-output-rate is a new property, which doesn't exist yet. If
the rate is peculiar to your platform/PHY, I'd suggest adding a field
to the qmp configuration instead.

> +       if (ret)
> +               fixed->fixed_rate = 125000000;
> +       else
> +               fixed->fixed_rate = rate;
> +
>         fixed->hw.init = &init;
>
>         ret = devm_clk_hw_register(qmp->dev, &fixed->hw);
> @@ -2255,6 +2419,9 @@ static const struct of_device_id qcom_qmp_phy_pcie_of_match_table[] = {
>         }, {
>                 .compatible = "qcom,ipq8074-qmp-pcie-phy",
>                 .data = &ipq8074_pciephy_cfg,
> +       }, {
> +               .compatible = "qcom,ipq8074-qmp-gen3-pcie-phy",
> +               .data = &ipq8074_pciephy_gen3_cfg,
>         }, {
>                 .compatible = "qcom,ipq6018-qmp-pcie-phy",
>                 .data = &ipq6018_pciephy_cfg,
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
