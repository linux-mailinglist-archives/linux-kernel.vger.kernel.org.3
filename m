Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEC14CFE02
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbiCGMTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241556AbiCGMS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:18:59 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC6E46B0D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:18:04 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 25so6505364ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNR3f5FVXa248OQajwRB1Kx5/IQv2/TXCkkX63d6suE=;
        b=bCferKM/V+lImGm/PdeHl007TQf3wY2vb3UOxJQ6KiLRc90utNuSwF1sueXYgMJkFv
         0GZeNpLSs4Giw1a9eq2Wpg0M5F1sC1bt1Z7DMM2+JqFukRJ3AJqxYIEK9oJXQe8yUF/U
         4XCvs0VHG9LQI3OdrVsLdd/OImfMMEr5LSddm0Za5UIEeVRHtwlsE6SnlkYyUDYNb4TY
         p4bVdO52erLTtnL4uwv4d/rD9PT4BgadV3vkHEw84l0FlHCs0/kkty3AZF54HKi8yr7E
         R3ZkK/O3jpYwBe2Pd+JBfc7qOOqkhgKmwp+uv7XHSRlTubHlPC/2W758RdcuUyzUeaqC
         1NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNR3f5FVXa248OQajwRB1Kx5/IQv2/TXCkkX63d6suE=;
        b=JWH08vKyVu0GwAVoFerMpoz1w4+SSSnoXRriTUPYT5VL7BVpqrehJcMR9H7Qv9NOYv
         xbNZvpqujAYjQNd5e4Gdb2oUqm6ezHQBEAfudpkoVOlSj3N1nhbASrFO2vJoGhC9oVYJ
         7mU+Q4kXzZdi4ZSyAdId2oY62h3QEb+Awi9vUT0BvjVe26etq3wpg64CMhBcmCmGI7cD
         TkuDi7ONhcRygry4jSfAkizyrqMotwnmnrjXdcGanRz5AelpcCm1Nt/8KExusvTD0nk+
         2310A+UHvPflRB6yPeOrwFWpWnwAFI6wp42xXrvB9ot/3H/ViERjpkGzL9hPDIL18g2q
         fUzA==
X-Gm-Message-State: AOAM533pyfr8UDJwfM6Z5M7NOSI4Sf9u7xfyegeefA6gtk4lQI4ANX1p
        OlmykL0OumWu6xHbzp3+6i6X9eXE6+AE8WLtjlJQbXMUL1Y=
X-Google-Smtp-Source: ABdhPJyavN8gFI2kidlB0YcSPhnurtTVDWwRGAnerpwrCjt+YQ+W6WOKQNYHwWGOK4gwCb3zM54XoHPkkwYEAZvTgoM=
X-Received: by 2002:a05:651c:201b:b0:246:34b5:155e with SMTP id
 s27-20020a05651c201b00b0024634b5155emr7057374ljo.273.1646655481163; Mon, 07
 Mar 2022 04:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20220305215835.2210388-1-pgwipeout@gmail.com> <20220305215835.2210388-3-pgwipeout@gmail.com>
In-Reply-To: <20220305215835.2210388-3-pgwipeout@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Mar 2022 13:17:25 +0100
Message-ID: <CAPDyKFoNjx4xvR=okfL4BSSNwcmvWcaQOyDNvqjzeq07qdbd5Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: host: dw-mmc-rockchip: fix handling invalid
 clock rates
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, robin.murphy@arm.com,
        linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Sat, 5 Mar 2022 at 22:58, Peter Geis <pgwipeout@gmail.com> wrote:
>
> The Rockchip rk356x ciu clock cannot be set as low as the dw-mmc
> hardware supports. This leads to a situation during card initialization
> where the clock is set lower than the clock driver can support. The
> dw-mmc-rockchip driver spews errors when this happens.
> For normal operation this only happens a few times during boot, but when
> cd-broken is enabled (in cases such as the SoQuartz module) this fires
> multiple times each poll cycle.
>
> Fix this by testing the lowest possible frequency that the clock driver
> can support which is within the mmc specification. Divide that rate by
> the internal divider and set f_min to this.
>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 95d0ec0f5f3a..f825487aa739 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -15,7 +15,9 @@
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
>
> -#define RK3288_CLKGEN_DIV       2
> +#define RK3288_CLKGEN_DIV      2
> +
> +static const unsigned int freqs[] = { 100000, 200000, 300000, 400000 };
>
>  struct dw_mci_rockchip_priv_data {
>         struct clk              *drv_clk;
> @@ -51,7 +53,7 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>
>         ret = clk_set_rate(host->ciu_clk, cclkin);
>         if (ret)
> -               dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> +               dev_warn(host->dev, "failed to set rate %uHz err: %d\n", cclkin, ret);
>
>         bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
>         if (bus_hz != host->bus_hz) {
> @@ -290,13 +292,30 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>
>  static int dw_mci_rockchip_init(struct dw_mci *host)
>  {
> +       int ret, i;
> +
>         /* It is slot 8 on Rockchip SoCs */
>         host->sdio_id0 = 8;
>
> -       if (of_device_is_compatible(host->dev->of_node,
> -                                   "rockchip,rk3288-dw-mshc"))
> +       if (of_device_is_compatible(host->dev->of_node, "rockchip,rk3288-dw-mshc")) {
>                 host->bus_hz /= RK3288_CLKGEN_DIV;
>
> +               /* clock driver will fail if the clock is less than the lowest source clock
> +                * divided by the internal clock divider. Test for the lowest available
> +                * clock and set the minimum freq to clock / clock divider.
> +                */
> +
> +               for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> +                       ret = clk_round_rate(host->ciu_clk, freqs[i] * RK3288_CLKGEN_DIV);
> +                       if (ret > 0) {
> +                               host->minimum_speed = ret / RK3288_CLKGEN_DIV;
> +                               break;
> +                       }
> +               }
> +               if (ret < 0)
> +                       dev_warn(host->dev, "no valid minimum freq: %d\n", ret);
> +       }
> +
>         return 0;
>  }
>
> --
> 2.25.1
>
