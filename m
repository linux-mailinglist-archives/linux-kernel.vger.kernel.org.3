Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B494CFE00
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbiCGMTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbiCGMSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:18:55 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B204093B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:18:01 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id r4so163202lfr.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DH+oocjZoheS2ppzlV3GMLdC/wnkrMQ+M6DhJ2OkEzo=;
        b=g708jxdHQUWcHu5206IcwS0xblL+SDdIq9n4R9CDqFeF5xNyeTcEOUcAqUVvzZDz8V
         hQn+nU+0TDuRJLO8SuFKWAJ+9W0CE8OPVyPeDvyG6SJISgOoEwburixXTLjO635V9Xl6
         eb6vEZ2sOM+IMYzzk65k+um889M6lSU+PdFr5zBazLPAiaWCBfJOHDI1el+dl8DtqFti
         HbpqegtfT0Zi9oKXVlX/XPgr0WUans98HRzlt836rH+FoCRKnF4RUK82+xTHJsq3QpnE
         hY7rL4SEc2ZEEr4fTMmSEyyYjnWLgSB/c0F2zPhxewUkASzctE4WEcfQDsD8dewD605S
         AO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DH+oocjZoheS2ppzlV3GMLdC/wnkrMQ+M6DhJ2OkEzo=;
        b=jmtdBGIweIXa/xROW5uEeIl0hXFXl3v6u9m7PxSn4N4/J1OD8nANTyRwevvfs84pgB
         GI75XXpgXQ+C78HKbRSHgrUq9Pfu5NYVFoc99MPk3iAWtTG8X+hc3+T5QNgrrxohQIXy
         jvkuZzrKrYMjPbnjXWhLDetCLddYe/A/fszSI5sqBWZIKvD/E1bz//LRkhu86QzolJ97
         +qlNmX4thC4G8mWL9ow9kr7w+JXh6xn7fTnr7HVSuZ6ll3IqWwblAOQFXp+i/gYmocAK
         Z6InFXFRHe4ub50qqqh7PXHKrXKwwHHiIfS/Zuas95mm6W5cdLtL/bEC+Cjn6ZTNVM6a
         hmcg==
X-Gm-Message-State: AOAM53022H4qnLQZc51u7WyLGKQX53y8F6Exo3O5kHZ4rsHE5ReOvf+X
        FfAc45o7qaPZzW2j5ovQy1LJWd4pKH+8xawckn6MOftKlVE=
X-Google-Smtp-Source: ABdhPJwbfy+LHJAnH3WR3mpkDHlEFZcuNi7GqXx9Xn7uVcgj3VU5VVdqiFlAV+K811utx5kneHGx2bTp2eJ1bDPK9e8=
X-Received: by 2002:a05:6512:260b:b0:445:c54c:4157 with SMTP id
 bt11-20020a056512260b00b00445c54c4157mr7377045lfb.254.1646655478490; Mon, 07
 Mar 2022 04:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20220305215835.2210388-1-pgwipeout@gmail.com> <20220305215835.2210388-2-pgwipeout@gmail.com>
In-Reply-To: <20220305215835.2210388-2-pgwipeout@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Mar 2022 13:17:22 +0100
Message-ID: <CAPDyKFpE-oSa1+rORK12X5uZLV4147hOiVZPG=j15b4QCU3muw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: host: dw_mmc: support setting f_min from host drivers
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>, robin.murphy@arm.com,
        linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org,
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

On Sat, 5 Mar 2022 at 22:58, Peter Geis <pgwipeout@gmail.com> wrote:
>
> Host drivers may not be able to support frequencies as low as dw-mmc
> supports. Unfortunately f_min isn't available when the drv_data->init
> function is called, as the mmc_host struct hasn't been set up yet.
>
> Support the host drivers saving the requested minimum frequency, so we
> can later set f_min when it is available.
>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 7 ++++++-
>  drivers/mmc/host/dw_mmc.h | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 42bf8a2287ba..0d90d0201759 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2898,7 +2898,12 @@ static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
>         if (host->pdata->caps2)
>                 mmc->caps2 = host->pdata->caps2;
>
> -       mmc->f_min = DW_MCI_FREQ_MIN;
> +       /* if host has set a minimum_freq, we should respect it */
> +       if (host->minimum_speed)
> +               mmc->f_min = host->minimum_speed;
> +       else
> +               mmc->f_min = DW_MCI_FREQ_MIN;
> +
>         if (!mmc->f_max)
>                 mmc->f_max = DW_MCI_FREQ_MAX;
>
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 7f1e38621d13..4ed81f94f7ca 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -99,6 +99,7 @@ struct dw_mci_dma_slave {
>   * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
>   *     rate and timeout calculations.
>   * @current_speed: Configured rate of the controller.
> + * @minimum_speed: Stored minimum rate of the controller.
>   * @fifoth_val: The value of FIFOTH register.
>   * @verid: Denote Version ID.
>   * @dev: Device associated with the MMC controller.
> @@ -201,6 +202,7 @@ struct dw_mci {
>
>         u32                     bus_hz;
>         u32                     current_speed;
> +       u32                     minimum_speed;
>         u32                     fifoth_val;
>         u16                     verid;
>         struct device           *dev;
> --
> 2.25.1
>
