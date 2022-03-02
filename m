Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85234CA3D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbiCBLfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbiCBLfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:35:33 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA50F9AE5A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:34:50 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id y24so1811633ljh.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jk/kyV1GLxWOeF6Q9fh0NKxfKT7911e8jRHc7/h85W8=;
        b=pyLW304YtYPCtMvRo2/e1WNmsRPQvhp2e1XDgqMPZlRnwdOc6UJufV599LDH1IXlKZ
         BfE0B7r8teLF1tIoJshUoYVOOzKG/oK6uyOLRm/WZ4Z49/VVQK/G680A8ADN3P6vXS8V
         0SMgE2WqihcpiU14qL/wFXteGveVRQ6U6EMXY0Sd7j4r90SLkEFtw3DtjDMvdvCcduVg
         jEsrJX8p9iuemmRkcsZAEtTln9noZl3eLaX88r4RPyoof28AR1yxg7oCH+6m14Jfek12
         2ldG2moeAgKrMhkGzLYmqSOrjbZMMKDUXjSM1cPjdid0x9sYUjqdte6e02gxvfsG7LxA
         kFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jk/kyV1GLxWOeF6Q9fh0NKxfKT7911e8jRHc7/h85W8=;
        b=NExRkjuj8ijVCYbiFqYKzCWZwXZT5vctq+a7TuokkGGKM4iuoMDUv9C/t15S1h8p3I
         RbKslruveXvv2EMBJyZR0KWrBQJ4CF7dIMjZhudgMXIinJBpcNWwjU3tEOjGKZxJ64+X
         KHv/53E62otEWi3afQAU/gxmI7pTiQMtHoVFEsbQ2kItX3UMxe9zY8J9sKskKt2L/QDG
         hHeFJEVjk2Y20cwAbqAJwoO+irqqMODe8mKCwT8hFBpTlHF/8CEoC8GbU6+q4DTJnqj0
         2v5qNyq8NAWuSZ6/0Xmx/kIXqOtr7AYpC7ek49bqyZg7GmAYstFLQ3Z5ZFb7RhSdBkYu
         es3g==
X-Gm-Message-State: AOAM530nMFKzwgKHfu7MOXjbi9tcgX2irQ2e7vf2G5NoBLNnrNx6bhvO
        kY5POsc84jnk+q0Rc/9XgveruXJVEvOCfe4pTQU1gw==
X-Google-Smtp-Source: ABdhPJz6V1qwnDI6lZX9QgPe+WFHQPCPir7L0W08RpKrIxDAoCdDoWNUsQw7hLQyKs5Va9bM6ldL5n0zYBJ1B4A7LZs=
X-Received: by 2002:a2e:9c94:0:b0:233:82df:a3b8 with SMTP id
 x20-20020a2e9c94000000b0023382dfa3b8mr20356385lji.229.1646220889153; Wed, 02
 Mar 2022 03:34:49 -0800 (PST)
MIME-Version: 1.0
References: <1badf10aba764191a1a752edcbf90389@realtek.com>
In-Reply-To: <1badf10aba764191a1a752edcbf90389@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Mar 2022 12:34:12 +0100
Message-ID: <CAPDyKFoa6d8_8VXp1QcTguuq3d9kX=g8H3yJo-ZJmF9neE_JKQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: rtsx: add 74 Clocks in power on flow
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, 2 Mar 2022 at 10:43, Ricky WU <ricky_wu@realtek.com> wrote:
>
> SD spec definition:
> "Host provides at least 74 Clocks before issuing first command"
> After 1ms for the voltage stable then start issuing the Clock signals
>
> if POWER STATE is
> MMC_POWER_OFF to MMC_POWER_UP to issue Clock signal to card
> MMC_POWER_UP to MMC_POWER_ON to stop issuing signal to card
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

Applied for next, thanks!

Greg, I verified that this shouldn't conflict with the changes you
have picked up already for the rtsx mmc driver.

Kind regards
Uffe

> ---
> v2:
> modify commit message
> move mdelay(5) to host->power_delay_ms
> replace host->power_state with host->prev_power_state
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 2a3f14afe9f8..d26803d3f4ca 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -38,10 +38,7 @@ struct realtek_pci_sdmmc {
>         bool                    double_clk;
>         bool                    eject;
>         bool                    initial_mode;
> -       int                     power_state;
> -#define SDMMC_POWER_ON         1
> -#define SDMMC_POWER_OFF                0
> -
> +       int                     prev_power_state;
>         int                     sg_count;
>         s32                     cookie;
>         int                     cookie_sg_count;
> @@ -909,7 +906,7 @@ static int sd_set_bus_width(struct realtek_pci_sdmmc *host,
>         return err;
>  }
>
> -static int sd_power_on(struct realtek_pci_sdmmc *host)
> +static int sd_power_on(struct realtek_pci_sdmmc *host, unsigned char power_mode)
>  {
>         struct rtsx_pcr *pcr = host->pcr;
>         struct mmc_host *mmc = host->mmc;
> @@ -917,9 +914,14 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>         u32 val;
>         u8 test_mode;
>
> -       if (host->power_state == SDMMC_POWER_ON)
> +       if (host->prev_power_state == MMC_POWER_ON)
>                 return 0;
>
> +       if (host->prev_power_state == MMC_POWER_UP) {
> +               rtsx_pci_write_register(pcr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0);
> +               goto finish;
> +       }
> +
>         msleep(100);
>
>         rtsx_pci_init_cmd(pcr);
> @@ -940,10 +942,15 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>         if (err < 0)
>                 return err;
>
> +       mdelay(1);
> +
>         err = rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, SD_OUTPUT_EN);
>         if (err < 0)
>                 return err;
>
> +       /* send at least 74 clocks */
> +       rtsx_pci_write_register(pcr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
> +
>         if (PCI_PID(pcr) == PID_5261) {
>                 /*
>                  * If test mode is set switch to SD Express mandatorily,
> @@ -968,7 +975,8 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>                 }
>         }
>
> -       host->power_state = SDMMC_POWER_ON;
> +finish:
> +       host->prev_power_state = power_mode;
>         return 0;
>  }
>
> @@ -977,7 +985,7 @@ static int sd_power_off(struct realtek_pci_sdmmc *host)
>         struct rtsx_pcr *pcr = host->pcr;
>         int err;
>
> -       host->power_state = SDMMC_POWER_OFF;
> +       host->prev_power_state = MMC_POWER_OFF;
>
>         rtsx_pci_init_cmd(pcr);
>
> @@ -1003,7 +1011,7 @@ static int sd_set_power_mode(struct realtek_pci_sdmmc *host,
>         if (power_mode == MMC_POWER_OFF)
>                 err = sd_power_off(host);
>         else
> -               err = sd_power_on(host);
> +               err = sd_power_on(host, power_mode);
>
>         return err;
>  }
> @@ -1506,10 +1514,11 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
>
>         host = mmc_priv(mmc);
>         host->pcr = pcr;
> +       mmc->ios.power_delay_ms = 5;
>         host->mmc = mmc;
>         host->pdev = pdev;
>         host->cookie = -1;
> -       host->power_state = SDMMC_POWER_OFF;
> +       host->prev_power_state = MMC_POWER_OFF;
>         INIT_WORK(&host->work, sd_request);
>         platform_set_drvdata(pdev, host);
>         pcr->slots[RTSX_SD_CARD].p_dev = pdev;
> --
> 2.25.1
