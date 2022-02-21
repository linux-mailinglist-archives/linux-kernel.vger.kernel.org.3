Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97AF4BD587
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344685AbiBUFp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:45:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344730AbiBUFpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:45:51 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170AC31930;
        Sun, 20 Feb 2022 21:45:29 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id n6so29327854qvk.13;
        Sun, 20 Feb 2022 21:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7iWv0TIz5zfKcN40ggMRpAwMAzLJY7hcWbLoCDV8jBE=;
        b=RZY5wviDdsYmF6+0n46ur2sAoi5BDlJ652riNsbryFTtB2XRo3b4XN0FA4XmzJqwiV
         Zx8HNdM77a1FGgP9MTDh6hZZwcXdD0pfvaEx+IMv/kJSH5mYToWhl/LI5pv3Q17sgUI0
         Uwq+uJShduNM1Yl4kRfpaGGM1ZdxMdiTS6ALQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7iWv0TIz5zfKcN40ggMRpAwMAzLJY7hcWbLoCDV8jBE=;
        b=pmBWctTWow+DAdrMzre+F/MUqBpyRgsmXjyC4ndfSDTYz1JLfzlhNRXMhxN827ypVz
         L3dg6vTqgZF2YpZ3inkGqUyvbJPmbgdkAvhAJJ9tZweZW8R/KfMcIbFMmAjk18ontxW7
         /8VmfiS7ov4gA4/LlPRMKmWo4E/ilpCR+a4Oufe2qUlIA2oKmYQxX5HPJqMysBpL7dvE
         i3aMxoNNht41lLyNo26vB4iTsOONruD1TuJXq8wZdgBBqI6FNgGVMgEqTe3JL+kejNaI
         9+JpUJ1JhxsgbJckceRkRjOFBug6n8/HgXluNk3LRFuArPIXr6byIM1jKBMZmpkL04zp
         iIDA==
X-Gm-Message-State: AOAM532Tpwj4yq2jgvh7JvHOemMgP44u4mXshHnhMJ34jxFp7KV31saz
        5SvNsg3zRtqo/7sFaNG5xnVvgN1UDZAlKQH7k+Y=
X-Google-Smtp-Source: ABdhPJwZ3cez5RRZ8JANQhauH1ZC98MKYhcjjQCwKLDq49sTcKbnNdbemiCR1mN2fgoBnk06bhQx9ruHolhircEkRbk=
X-Received: by 2002:a05:622a:1b8d:b0:2c6:59a9:360e with SMTP id
 bp13-20020a05622a1b8d00b002c659a9360emr16137525qtb.678.1645422328203; Sun, 20
 Feb 2022 21:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20220221012705.22008-1-billy_tsai@aspeedtech.com>
In-Reply-To: <20220221012705.22008-1-billy_tsai@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 21 Feb 2022 05:45:16 +0000
Message-ID: <CACPK8XdsRorJvMjUMNYGAYNLGLzhYJEZSQMTk1ZywwY+SyqDbQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: aspeed: Add divider flag to fix incorrect
 voltage reading.
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrew Jeffery <andrew@aj.id.au>,
        Colin King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Klubnichkin <kitsok@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022 at 01:26, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> The formula for the ADC sampling period in ast2400/ast2500 is:
> ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0])
> When ADC0C[9:0] is set to 0 the sampling voltage will be lower than
> expected, because the hardware may not have enough time to
> charge/discharge to a stable voltage. This patch use the flag
> CLK_DIVIDER_ONE_BASED which will use the raw value read from the
> register, with the value of zero considered invalid to conform to the
> corrected formula.

(to answer my own question)

..and this is okay on the 2600, because we do not set need_prescaler =
true on that platform.

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Fixes: 573803234e72 ("iio: Aspeed ADC")
> Reported-by: Konstantin Klubnichkin <kitsok@yandex-team.ru>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/iio/adc/aspeed_adc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index a957cad1bfab..ffae64f39221 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -539,7 +539,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>         data->clk_scaler = devm_clk_hw_register_divider(
>                 &pdev->dev, clk_name, clk_parent_name, scaler_flags,
>                 data->base + ASPEED_REG_CLOCK_CONTROL, 0,
> -               data->model_data->scaler_bit_width, 0, &data->clk_lock);
> +               data->model_data->scaler_bit_width,
> +               data->model_data->need_prescaler ? CLK_DIVIDER_ONE_BASED : 0,
> +               &data->clk_lock);
>         if (IS_ERR(data->clk_scaler))
>                 return PTR_ERR(data->clk_scaler);
>
> --
> 2.25.1
>
