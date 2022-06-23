Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F9E5578EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiFWLps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiFWLpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:45:47 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD7A4CD43
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:45:46 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id g18so21976542qvn.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRbfQ+fc1DYVLY6g+4vwWxQuk6rUPZT1TbLMZi5yV+w=;
        b=e0EAfqUzFTj9jvyBUyQ+swSrbqZDv3wJwWLcT3g2UrWjiWVkn+0p+8Q+WMVZ8lmQY1
         bLCbZBEDBEit5MvQk9s1rB48MUSXA+x1CXdOSb+DBzMYM86k09lk5ZQ9juqg7rJ+pmFz
         JtOtKCV2OqivcRk1HAjA5qtIEHT2IwHNtKE11j45ycspKLW/VyybbI7cCuN54wCEDkFQ
         kmjINPuFbIMQ6K55Mtt2K0h3hpPuvUcWrTNByz1nw2MiXEatxCc8DumZsk16oyHSiTvF
         h4ZNMYisfIHxrIEppM0mUdprLxYGvfDzFcMu912Rh6IOq3GNoKFW1X0sjw5VYZHavLbU
         YAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRbfQ+fc1DYVLY6g+4vwWxQuk6rUPZT1TbLMZi5yV+w=;
        b=gVMqrUk/CbmLoycAkbFofW1QaP9uoHvS9AqQdkfWpQTulKCTn7qkZnmQ8zMm/wGE7u
         rxFG8YZVB+9rTFiE+XJwoeCYIJUWZMjZx/pKp1mHuvot7rDDCNHfb4GEXsoIE2mpClrZ
         Ng+0R5kuuSdi1xENxxSns4PNHCWy4AiA0iETr0ty2dRQQ0gQfjIBN/mFIijq7MIvtfGe
         EXdxAy2wUEYItK8H3bvnFm1r9h56YiTIgWLtrArYZ24eS4IW7tuHeukAcc7VvpZfxcUf
         207xQrESUUYJlMNCDJvEQ0Eiq41bkUyNMITes4NpEFFy7gT4514Vr+2UcuNPWvK5z49N
         i7yw==
X-Gm-Message-State: AJIora8REru8XpAHSLZKfLJJnH3sDDT/Ni/CJCWiFkMru29Mxq4QBouZ
        lIzYek80daFW1OzidsMNFobgZcJrLnAa5xaa3yznTw==
X-Google-Smtp-Source: AGRyM1vG+915xBfnnjmYq/lGJQ1IzVhHBCFJSMCuDhc5UgDd8Zp7+Ubl/80Odgaa8L45ZqmAYOHA+8FdE9u8gIdDuCU=
X-Received: by 2002:ad4:5b81:0:b0:465:ded8:780 with SMTP id
 1-20020ad45b81000000b00465ded80780mr31801261qvp.119.1655984745466; Thu, 23
 Jun 2022 04:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220623113314.29761-1-johan+linaro@kernel.org> <20220623113314.29761-4-johan+linaro@kernel.org>
In-Reply-To: <20220623113314.29761-4-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 23 Jun 2022 14:45:34 +0300
Message-ID: <CAA8EJprpED7Ap28YrXQ1MCub20DNLZ_MrXhHcej+V_SZqfBk-g@mail.gmail.com>
Subject: Re: [PATCH 3/3] phy: qcom-qmp-usb: clean up pipe clock handling
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Thu, 23 Jun 2022 at 14:33, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Clean up the pipe clock handling by using dev_err_probe() to handle
> probe deferral and dropping the obsolete comment that claimed that the
> pipe clock was optional for some other PHY types.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index aebe5ed4e4e3..40e87f75ec4a 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -2530,22 +2530,11 @@ int qcom_qmp_phy_usb_create(struct device *dev, struct device_node *np, int id,
>         if (!qphy->pcs_misc)
>                 dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
>
> -       /*
> -        * Get PHY's Pipe clock, if any. USB3 and PCIe are PIPE3
> -        * based phys, so they essentially have pipe clock. So,
> -        * we return error in case phy is USB3 or PIPE type.
> -        * Otherwise, we initialize pipe clock to NULL for
> -        * all phys that don't need this.
> -        */
>         snprintf(prop_name, sizeof(prop_name), "pipe%d", id);
>         qphy->pipe_clk = devm_get_clk_from_child(dev, np, prop_name);
>         if (IS_ERR(qphy->pipe_clk)) {
> -               ret = PTR_ERR(qphy->pipe_clk);
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(dev,
> -                               "failed to get lane%d pipe_clk, %d\n",
> -                               id, ret);
> -               return ret;
> +               return dev_err_probe(dev, PTR_ERR(qphy->pipe_clk),
> +                                    "failed to get lane%d pipe clock\n", id);
>         }

And here too. Afterwards:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
>         generic_phy = devm_phy_create(dev, np, &qcom_qmp_phy_usb_ops);
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
