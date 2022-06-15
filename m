Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DF954D003
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354809AbiFOReJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357939AbiFORdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:33:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F7152517
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:33:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w20so19973032lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rEBSyXeCbmBUBcCDVrlaJF/sb3hQ6cDD+mTYpXhaT5Y=;
        b=NHk1jGKwkU2BrG33SfVEnhC0RF9ehEMIxRspkW9YY0bIyXGTIr7Wd9t+5XEZncbb2w
         Po2euByjQ9qiAh3cOvXZ68Z2NYJEsgK/cqwcuqgjLpcaF/M4EI7uKed+Qz2XwjSRWnK5
         A7FAIGoMw8pseVV+w6+VmsmAGl/+hCeCipcX0MSWeWCHimBHaA70MKvO04pr5zfmw5HG
         +3wlOonEgbO/H9EimUhVVT1Ihcd822/7PbCDjOxC7tsls2izvotRwFP2A51p90v/77Rz
         xV99fIS+FSqF5r0jujwn2gdxaaprTDad65FSN63dEagRi1nTFBBt/2vscajcg9aZv8u4
         CHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rEBSyXeCbmBUBcCDVrlaJF/sb3hQ6cDD+mTYpXhaT5Y=;
        b=eeaV7q0XC3YtgiSdu6WDasKak+W8/QWBltMWL/54efjpl8COvapLQdnGuahw4vY9fW
         6kn5Sff9v9zMzD6xUNTT3ro1/HFw9d3ZXb/uI5VvfQQBULvKX3d+OfNHrXTKNh0kKn6U
         9MPqwx1JAFCA7vR3dLX5FtmGHezqiQlqGwy+0blgu+0km6q9Z/YNfbj299oGKmjfdur/
         +TsTcvNexK5GhIKvCqDq4C+vtFKU77xBxGvireDoNpfD5RJEjNwqh6lAErnX7NlT1F5M
         5REZt4Dby/WRKA0povsH7lF8O13Og+//bJidtE40AfwbTy/OdHjEAb77JMnE20CtHKeE
         pP5w==
X-Gm-Message-State: AJIora+8vatA/NjSk/jDQy4n+gRXk8tz1EjPjdPC/V89ipCJgMx3KMb1
        QZqUBz+Cvz6PXtSG548xhZ+2nS4yv8nJXWBwoET2JQ==
X-Google-Smtp-Source: AGRyM1sWRqYe+A4qepiU6K08Gk2UDWKSsUHbIH4KwHmf8+CbMzbiIK6O9l48yMlOhTn4bi5DWqmSSxXBKjEklcsVy0U=
X-Received: by 2002:a05:6512:403:b0:479:1627:a9b7 with SMTP id
 u3-20020a056512040300b004791627a9b7mr343348lfk.233.1655314413654; Wed, 15 Jun
 2022 10:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 10:32:57 -0700
Message-ID: <CAPDyKFr35sr7RFpv4S0eosY4BT1r0te083rdan_tRq0T+7agJA@mail.gmail.com>
Subject: Re: [PATCH 1/5] mmc: dw_mmc: exynos: Obviously always return success
 in remove callback
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel@pengutronix.de, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 at 14:13, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> dw_mci_pltfm_remove() returns 0 unconditionally and returning an error
> in a platform remove callback isn't very sensible. (The only effect of
> the latter is that the device core emits a generic warning and then
> removes the device anyhow.)
>
> So return 0 unconditionally to make it obvious there is no error
> forwarded to the upper layers.
>
> This is a preparation for making platform remove callbacks return void.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

This one and the other 4 patches in the series, applied for next. Thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-exynos.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-e=
xynos.c
> index ca5be4445ae0..9f20ac524c8b 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -670,7 +670,9 @@ static int dw_mci_exynos_remove(struct platform_devic=
e *pdev)
>         pm_runtime_set_suspended(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
>
> -       return dw_mci_pltfm_remove(pdev);
> +       dw_mci_pltfm_remove(pdev);
> +
> +       return 0;
>  }
>
>  static const struct dev_pm_ops dw_mci_exynos_pmops =3D {
>
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> --
> 2.36.1
>
