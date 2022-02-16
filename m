Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89E44B85A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiBPKat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:30:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiBPKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:30:41 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4162225E3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:30:29 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o2so3003063lfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+U2blIz2bHr/Hou20K+vB8EK8yt9Gm5o6A0v/q1Ufs=;
        b=bmaY2mTyY9evN92fL8S15FP23bwOQg175/j/w9J0MQSQPxSnTXMxBZDaWXAKWYsZ+h
         SHp12rfwrzGOlePdMZPIDVrnCGk3OAtITljLm+pXcSXXN1VH3CklKSnRika3NENyDtEC
         zIlceVPicu6kGBc5349Bp7IZ2FjkyV40XJ0O/DBt08q/kZleBR0bX0ZF8WnrqrI4V9sQ
         Ug5PMGQX62KF4aO/ZrT6rR8x1hz3YRMGDk+1CerrfW5q8hSv7BFDExJ+Z0tDYDbr4hPl
         IUZK3qKeFFUHcijTy2F2TRpctIFFTN/lgHBnUOTPFd58uVqeYuiCUUm5z8InjmRScavs
         xuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+U2blIz2bHr/Hou20K+vB8EK8yt9Gm5o6A0v/q1Ufs=;
        b=3FRkVmqPDuaOkkjy/jLnbSILlx+vFk9QcCKjHMv81G6k4AzIKSwLuLIMGUc2E6dTBw
         26yNPPEi7dkXmrnQ5NuFXC/kWnN0sEqhz1ehXqYTKgMU86PQoAnE80FI7uCR8o3DwwkX
         9tMjVsSw3kxuWH90cfZQbnNnBjUEnq/kJxrxIcOid/tVeSSCUVEz+u/0XhSsZDnRa15V
         H+TZ03Rz+YEHmpbEFkrGz5hHFv6WSU91HgFV8wvj49XvPfD/kDz1rxWySN4YI17I6vtN
         btxEYhL0LnGnTs47JsINjWM9bLHzMW83igeXRgHJKo9OpS2fCeOD8CErnpcfhv6M2r7J
         FcEg==
X-Gm-Message-State: AOAM533zStTFJnHB3JpFQKQw4uwFRUEOOeU98j0hrOIxt1EotDNhdqSS
        dzUZeBF54y2jCMnU6FdPLU39WiwVBZpPJq28gd92xg==
X-Google-Smtp-Source: ABdhPJxuTx34WgTkAaui/+oWNPCJhtdpRgb8InCtADP80jomO+tijlnanWqSIZvsT7xoMawzOxj4Y0yq7BoIcfsvHcA=
X-Received: by 2002:ac2:5de4:0:b0:443:5b80:d4c4 with SMTP id
 z4-20020ac25de4000000b004435b80d4c4mr1505822lfq.373.1645007428152; Wed, 16
 Feb 2022 02:30:28 -0800 (PST)
MIME-Version: 1.0
References: <20220216055435.2335297-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220216055435.2335297-1-kai.heng.feng@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Feb 2022 11:29:52 +0100
Message-ID: <CAPDyKFrAjT2PJBg+d00Tvekujk6Bh_dsK33121Fxr9hwHi9gLw@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: Let MMC core handle runtime PM
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Hebb <tommyhebb@gmail.com>, linux-mmc@vger.kernel.org,
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

On Wed, 16 Feb 2022 at 06:55, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> Since MMC core handles runtime PM reference counting, we can avoid doing
> redundant runtime PM work in the driver. That means the only thing
> commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") misses is
> to always enable runtime PM, to let its parent driver enable ASPM in the
> runtime idle routine.
>
> Fixes: 7499b529d97f ("mmc: rtsx: Use pm_runtime_{get,put}() to handle runtime PM")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

This looks good to me!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Greg, do you want to funnel this through your tree - or should I wait
for an rc containing 7499b529d97f and take it through my mmc tree?
Either way works for me.

Kind regards
Uffe

> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 18 ------------------
>  1 file changed, 18 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 2a3f14afe9f83..265b3889f9d72 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -823,7 +823,6 @@ static void sd_request(struct work_struct *work)
>         }
>
>         mutex_lock(&pcr->pcr_mutex);
> -       pm_runtime_get_sync(dev);
>
>         rtsx_pci_start_run(pcr);
>
> @@ -860,8 +859,6 @@ static void sd_request(struct work_struct *work)
>                         data->bytes_xfered = data->blocks * data->blksz;
>         }
>
> -       pm_runtime_mark_last_busy(dev);
> -       pm_runtime_put_autosuspend(dev);
>         mutex_unlock(&pcr->pcr_mutex);
>
>  finish:
> @@ -1093,7 +1090,6 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 return;
>
>         mutex_lock(&pcr->pcr_mutex);
> -       pm_runtime_get_sync(dev);
>
>         rtsx_pci_start_run(pcr);
>
> @@ -1127,8 +1123,6 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         rtsx_pci_switch_clock(pcr, ios->clock, host->ssc_depth,
>                         host->initial_mode, host->double_clk, host->vpclk);
>
> -       pm_runtime_mark_last_busy(dev);
> -       pm_runtime_put_autosuspend(dev);
>         mutex_unlock(&pcr->pcr_mutex);
>  }
>
> @@ -1144,7 +1138,6 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
>                 return -ENOMEDIUM;
>
>         mutex_lock(&pcr->pcr_mutex);
> -       pm_runtime_get_sync(dev);
>
>         rtsx_pci_start_run(pcr);
>
> @@ -1154,8 +1147,6 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
>         if (val & SD_WRITE_PROTECT)
>                 ro = 1;
>
> -       pm_runtime_mark_last_busy(dev);
> -       pm_runtime_put_autosuspend(dev);
>         mutex_unlock(&pcr->pcr_mutex);
>
>         return ro;
> @@ -1173,7 +1164,6 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
>                 return cd;
>
>         mutex_lock(&pcr->pcr_mutex);
> -       pm_runtime_get_sync(dev);
>
>         rtsx_pci_start_run(pcr);
>
> @@ -1183,8 +1173,6 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
>         if (val & SD_EXIST)
>                 cd = 1;
>
> -       pm_runtime_mark_last_busy(dev);
> -       pm_runtime_put_autosuspend(dev);
>         mutex_unlock(&pcr->pcr_mutex);
>
>         return cd;
> @@ -1282,7 +1270,6 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>                 return err;
>
>         mutex_lock(&pcr->pcr_mutex);
> -       pm_runtime_get_sync(dev);
>
>         rtsx_pci_start_run(pcr);
>
> @@ -1312,8 +1299,6 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>         err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
>                         SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
>
> -       pm_runtime_mark_last_busy(dev);
> -       pm_runtime_put_autosuspend(dev);
>         mutex_unlock(&pcr->pcr_mutex);
>
>         return err;
> @@ -1334,7 +1319,6 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 return err;
>
>         mutex_lock(&pcr->pcr_mutex);
> -       pm_runtime_get_sync(dev);
>
>         rtsx_pci_start_run(pcr);
>
> @@ -1367,8 +1351,6 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 err = sd_change_phase(host, DDR50_RX_PHASE(pcr), true);
>
>  out:
> -       pm_runtime_mark_last_busy(dev);
> -       pm_runtime_put_autosuspend(dev);
>         mutex_unlock(&pcr->pcr_mutex);
>
>         return err;
> --
> 2.34.1
>
