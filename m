Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C72B47C04F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbhLUNDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbhLUNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:03:19 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5700AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:03:19 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id i31so13912291lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWzCt+T8UkYpAGzTveuD56wBYeSm7wcDkmh117uxRvU=;
        b=K3V/VNH6ZIoPn4j0ryz6Cm6UZFFfVitYHO+kQBB0J90Qp/9ITQ/TGs35UiB5nASven
         3YKV8ZgUfLLaZhYB5P0/90FpvVP7kgpIW9v7IDxyN2x8cD/1EiIrIzekM5Dxt1o6NUjB
         FpdIHBCd90heM4yxUhI3c88o+75KD2KUVDcCjOZ0VBGYCGr9tiYs98fDuMqM28rAXF2n
         b4pSidVT43tR/6lVe0/KubUBTu+NmnTi6CIrwZ0nN8onY//z2eeLliiR87CGlaRll8Gb
         6Ce3u/FRuKC/dgfcegt03/hGrkqtWEXVyuo5cKQOa8L2nmYKOq4rLTn69I73NfJYaqqH
         YGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWzCt+T8UkYpAGzTveuD56wBYeSm7wcDkmh117uxRvU=;
        b=zCGG5UueltKCGI50DkNab9FnGV+q1WxFNTUeXAlLL0L9RTopAIeKsEq8A/mKovYCNa
         /kMFNwxWnBF8yMjALsvpFcAZ5nvoJ3HDmYFaS3kOHD7reWewoXm3J/p3YonwPaBTuKcp
         gYuO9ezF2xxVIjQjbmCLRT2nvkaNkOt3EbwsbA93p/h0MCV6ViLJPdXcobUcdletZCxx
         GU01WOAZSFr29qEuzsdiIUbAAOHe5B8mSUakw3xAYLpkcNZRcLFSVDRRZrA0OR5yCl62
         Hqf5wDzJUxAjs7CTTiWfFR2H9/w78oCINIfIOOvo00jyFQjQibaFQsmEZowzm6LbOBfu
         8eEw==
X-Gm-Message-State: AOAM532hRAgNnUXpl1o3DKgoVXF9UdIy+zePERUujT2nQZ5IYaPGsxCp
        UanPIehWFqLUWn1lbNIFl5d2mEqhCyY26D2vrXf16Q==
X-Google-Smtp-Source: ABdhPJzlKqWv6wXLhW5FNFjEcxu5IsCLseG7Ejt3W39SV2RDB50NrFUNXphXzmj6T+y5IRvHkg6RUg1AoGyNFwSVSdA=
X-Received: by 2002:a19:5019:: with SMTP id e25mr2971601lfb.254.1640091797600;
 Tue, 21 Dec 2021 05:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20211219153442.463863-1-martin.blumenstingl@googlemail.com> <20211219153442.463863-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20211219153442.463863-2-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:02:39 +0100
Message-ID: <CAPDyKFry2L5RKTtxKQ-Qu+xJEsK-hSCNgrgB371MMSGsd4DwZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: meson-mx-sdhc: Set MANUAL_STOP for
 multi-block SDIO commands
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2021 at 16:34, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The vendor driver implements special handling for multi-block
> SD_IO_RW_EXTENDED (and SD_IO_RW_DIRECT) commands which have data
> attached to them. It sets the MANUAL_STOP bit in the MESON_SDHC_MISC
> register for these commands. In all other cases this bit is cleared.
> Here we omit SD_IO_RW_DIRECT since that command never has any data
> attached to it.
>
> This fixes SDIO wifi using the brcmfmac driver which reported the
> following error without this change on a Netxeon S82 board using a
> Meson8 (S802) SoC:
>   brcmf_fw_alloc_request: using brcm/brcmfmac43362-sdio for chip
>                           BCM43362/1
>   brcmf_sdiod_ramrw: membytes transfer failed
>   brcmf_sdio_download_code_file: error -110 on writing 219557 membytes
>                                  at 0x00000000
>   brcmf_sdio_download_firmware: dongle image file download failed
>
> And with this change:
>   brcmf_fw_alloc_request: using brcm/brcmfmac43362-sdio for chip
>                           BCM43362/1
>   brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may
>                             have limited channels available
>   brcmf_c_preinit_dcmds: Firmware: BCM43362/1 wl0: Apr 22 2013 14:50:00
>                          version 5.90.195.89.6 FWID 01-b30a427d
>
> Fixes: e4bf1b0970ef96 ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> index 7cd9c0ec2fcf..8fdd0bbbfa21 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> @@ -135,6 +135,7 @@ static void meson_mx_sdhc_start_cmd(struct mmc_host *mmc,
>                                     struct mmc_command *cmd)
>  {
>         struct meson_mx_sdhc_host *host = mmc_priv(mmc);
> +       bool manual_stop = false;
>         u32 ictl, send;
>         int pack_len;
>
> @@ -172,12 +173,27 @@ static void meson_mx_sdhc_start_cmd(struct mmc_host *mmc,
>                 else
>                         /* software flush: */
>                         ictl |= MESON_SDHC_ICTL_DATA_XFER_OK;
> +
> +               /*
> +                * Mimic the logic from the vendor driver where (only)
> +                * SD_IO_RW_EXTENDED commands with more than one block set the
> +                * MESON_SDHC_MISC_MANUAL_STOP bit. This fixes the firmware
> +                * download in the brcmfmac driver for a BCM43362/1 card.
> +                * Without this sdio_memcpy_toio() (with a size of 219557
> +                * bytes) times out if MESON_SDHC_MISC_MANUAL_STOP is not set.
> +                */
> +               manual_stop = cmd->data->blocks > 1 &&
> +                             cmd->opcode == SD_IO_RW_EXTENDED;
>         } else {
>                 pack_len = 0;
>
>                 ictl |= MESON_SDHC_ICTL_RESP_OK;
>         }
>
> +       regmap_update_bits(host->regmap, MESON_SDHC_MISC,
> +                          MESON_SDHC_MISC_MANUAL_STOP,
> +                          manual_stop ? MESON_SDHC_MISC_MANUAL_STOP : 0);
> +
>         if (cmd->opcode == MMC_STOP_TRANSMISSION)
>                 send |= MESON_SDHC_SEND_DATA_STOP;
>
> --
> 2.34.1
>
