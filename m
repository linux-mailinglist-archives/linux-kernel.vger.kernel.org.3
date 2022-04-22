Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F2450C00B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiDVS7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiDVS6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:58:31 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4016917C52A;
        Fri, 22 Apr 2022 11:54:53 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id j9so6460726qkg.1;
        Fri, 22 Apr 2022 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQ40q30UltGPLcxI7Io5PMB3YYsh2rTffdRN3EHyu6c=;
        b=RdHamgujXU7B88WXCri1aYVijHI83k3VkPNNzKtG/MLExSd3tIZhvESxewq0tXjykm
         ZbLf3MYd+E+jl55CDkujFwCtgTIQGeesQfrYn/H+8XX3KHlq6UOqVWd5HD568lvBJS6t
         92kcI88/9o48d6YdJHOnjZ/6OtWJqI/i2kqcLu9frpMNsVT+urshO4xfvMbWCcvhOGT+
         ZGB+ld9FNj2oviMGVglawZScNhMQGkyXBEL2Bv9lIuhrEf31/qdwSWjNbmpQW1L9ZCLF
         WO18jlmA5OWphmosTS1G/HzZqOBTYQSv3GAcU9nwVqg+Zg0DGaHDdCxGIvrcaxb3d8Ex
         vYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQ40q30UltGPLcxI7Io5PMB3YYsh2rTffdRN3EHyu6c=;
        b=xidNL2lWsM7sbfR2kAj2SrMSlyzuE/cikUvc+IflaZQWY2ZxCBxgE0QvLp9F+i+UIl
         cJUZ2Vzafe/LCC+9byJP06YpF3EnZo3WHyDUfCZLPYLcUiq1DnBFkiazGFFpkJXDBL+S
         tjgKYVWbmrzRRK0uzZvTOJspadUkdAYRjEJN3RD72MA3abaAFE0ypyEtkoxLxKkYrJul
         Edfx1Nf2uJdc4z+WbczlrHnPPZ9BZZxlhW2DbTEbPHoDtO8v7mwQMxNndRrQoRgzjgGf
         2oqXHizP7Aq6ysU9uVawhbxxGUtmHminW3WyUdXHDku9r4130NDYyKsD3IHiWXMFRRV9
         ZGbw==
X-Gm-Message-State: AOAM530//+W59TfyP7GpyKQN7pW71dGsBQTo/4W3b80V60S39lD5aF99
        WpTQXteEM3tJCZoglgu/2M7M2/5SCnxYIO6hVpo=
X-Google-Smtp-Source: ABdhPJyrbF6gvV7/wmLrqZkZPzMLNWIkWAv1BEqTuRLLFd+eovymNNvGQWzPxUcW2ESAhhinTTllnLRYQlRa6HY7eho=
X-Received: by 2002:a37:89c7:0:b0:69a:121b:9256 with SMTP id
 l190-20020a3789c7000000b0069a121b9256mr3714602qkd.218.1650653396872; Fri, 22
 Apr 2022 11:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220422161156.1075227-1-icenowy@outlook.com> <BYAPR20MB24720C488FD2BB42038D9825BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
In-Reply-To: <BYAPR20MB24720C488FD2BB42038D9825BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Fri, 22 Apr 2022 11:49:30 -0700
Message-ID: <CA+E=qVfhEhe325M+s784BYw4Ctvv=eGWxGAJBMwPptHXs_vKFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: sun8i: add R329 THS
To:     icenowy@outlook.com
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:12 AM <icenowy@outlook.com> wrote:
>
> From: Icenowy Zheng <icenowy@aosc.io>
>
> The thermal sensor controller on R329 is similar to the one on H6, but
> with only one sensor. Calibration method is still unknown because no
> calibration is implemented in BSP kernel, neither is it documented in
> the user manual.
>
> Add its support to sun8i-thermal driver. Calibrating it is now
> prevented.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/thermal/sun8i_thermal.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index d9cd23cbb671..3a2f381005b4 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -312,7 +312,8 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
>                 goto out;
>         }
>
> -       tmdev->chip->calibrate(tmdev, caldata, callen);
> +       if (tmdev->chip->calibrate)
> +               tmdev->chip->calibrate(tmdev, caldata, callen);

I think it's a bit late to check it here since you already read nvmem
cell if you got here. I'd suggest moving the check to
sun8i_ths_resource_init(), i.e. call sun8i_ths_calibrate()
conditionally depending on whether calibrate callback is present.

>         kfree(caldata);
>  out:
> @@ -628,6 +629,17 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
>         .calc_temp = sun8i_ths_calc_temp,
>  };
>
> +static const struct ths_thermal_chip sun50i_r329_ths = {
> +       .sensor_num = 1,
> +       .has_bus_clk_reset = true,
> +       .offset = 188744,
> +       .scale = 672,
> +       .temp_data_base = SUN50I_H6_THS_TEMP_DATA,
> +       .init = sun50i_h6_thermal_init,
> +       .irq_ack = sun50i_h6_irq_ack,
> +       .calc_temp = sun8i_ths_calc_temp,
> +};
> +
>  static const struct of_device_id of_ths_match[] = {
>         { .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
>         { .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
> @@ -636,6 +648,7 @@ static const struct of_device_id of_ths_match[] = {
>         { .compatible = "allwinner,sun50i-a100-ths", .data = &sun50i_a100_ths },
>         { .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
>         { .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
> +       { .compatible = "allwinner,sun50i-r329-ths", .data = &sun50i_r329_ths },
>         { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, of_ths_match);
> --
> 2.35.1
>
