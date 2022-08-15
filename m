Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C5593647
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244176AbiHOSww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiHOSrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:47:19 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCEB422D3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:28:32 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u14so9434865oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0+JtMsU2Pn0zu2wwFZknm1ETM7jmS8MJnZsirTHcweU=;
        b=nRs9HJAXTO9lHEjOI+iq0RH9RlnXkpWR+GsFpey5SuNfCsZOfa5afRBNWWYYH+ZCJn
         cqvw9AFg4owIoV6E+y4L0fTd0z5deLeCJN88M9Actjm0tlkMSWYZoYKrlgK6NAWyvAa5
         CJ/PX0MgIjoRVIoZovsy8dh9PjLmq4U8R0QRnFoXpk0rXY563pu6rYBPeVSg5Akg8mcl
         Y8xilbc/awP0bGBWZXLy7RZJGuWq0zrZgOYpM4FLkyiR6rEkw+tTkF6ZCxjbQotVtLBs
         yevDp5JETYO3ZzTZsnrtsi8W0mJO+3kJNmjxmwJP0YlrKOIeptxKZnXZzxIFTI6bCQGc
         MxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0+JtMsU2Pn0zu2wwFZknm1ETM7jmS8MJnZsirTHcweU=;
        b=MzAm3ryHxiHz4tn+EZvfob6+pXXKP3mwvAcTFIJqO9m3c4vVaYgBokv8vubyTMTlyP
         ndFnHtbMAtJz5njnQOTUwgO55Jun660k4vW7PY0Hoz2dYzrf45HMgzdqoEWl5FFvpK73
         AZkGOIc44zZuIC+zgamDZR50ifTzfg1X435J3cu9LOi7WP7ly8EW4i6BBrN5CW7KAqJk
         /eWOKNJTZWgF/GUA9pNdJsqypNLmP1fYS0SQbN5mnXCb/UgS1R/kZfHDIrwQOZgfseKx
         Ir1I4Wod20lBlu0FoYi8qGq4LeDTfv4QsDhCzmDyL8HKoMhGFNkpHLMbUJRG2cJsmba0
         HkFw==
X-Gm-Message-State: ACgBeo2LaaFvulSdWwBYc1Qm/nDNkO//eHvEeKqDxD+2b7eNX5/qG9Wo
        KWRMnbAQ41XthBYoh0dWsIyHjbyOvLu1nVpNwW+dD72rqps=
X-Google-Smtp-Source: AA6agR7626L/pa4dy2T0F2o05pWhrOkIvj3kHjOlc+z1xZzsmVzmd761YvyMaN1OAaQ7b/kRZm7xbmB9h6cdTERnlXQ=
X-Received: by 2002:aca:5e89:0:b0:344:80ab:1351 with SMTP id
 s131-20020aca5e89000000b0034480ab1351mr4589823oib.105.1660588111543; Mon, 15
 Aug 2022 11:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220729100524.387-1-chevron.li@bayhubtech.com>
In-Reply-To: <20220729100524.387-1-chevron.li@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 20:27:54 +0200
Message-ID: <CAPDyKFqGhgiAwzsia7aXO8Rb+1xYwfQDtLRj0ArncX=Qt8Tg1A@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] mmc: sdhci-pci-o2micro: fix some SD cards
 compatibility issue at DDR50 mode
To:     Chevron Li <chevron.li@bayhubtech.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaper.liu@bayhubtech.com,
        shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com
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

On Fri, 29 Jul 2022 at 12:05, Chevron Li <chevron.li@bayhubtech.com> wrote:
>
> Bayhub chips have better compatibility support for SDR50 than DDR50
> and both mode have the same R/W performance when clock frequency >= 100MHz.
> Disable DDR50 mode and use SDR50 instead.
>
> Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>

Applied for next, thanks!

Kind regards
Uffe



> ---
> Changes on V1:
> 1.Set quirks2 flag SDHCI_QUIRK2_BROKEN_DDR50 for bayhub chips.
> 2.Use bayhub hardware input tuning for SDR50 mode instead of standard tuning flow.
>
> Changes on V2:
> Update commit format and information.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 0d4d343dbb77..ad457cd9cbaa 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -317,11 +317,12 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         u32 reg_val;
>
>         /*
> -        * This handler only implements the eMMC tuning that is specific to
> +        * This handler implements the hardware tuning that is specific to
>          * this controller.  Fall back to the standard method for other TIMING.
>          */
>         if ((host->timing != MMC_TIMING_MMC_HS200) &&
> -               (host->timing != MMC_TIMING_UHS_SDR104))
> +               (host->timing != MMC_TIMING_UHS_SDR104) &&
> +               (host->timing != MMC_TIMING_UHS_SDR50))
>                 return sdhci_execute_tuning(mmc, opcode);
>
>         if (WARN_ON((opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
> @@ -631,6 +632,8 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>                 if (reg & 0x1)
>                         host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>
> +               host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;
> +
>                 sdhci_pci_o2_enable_msi(chip, host);
>
>                 if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
>
> base-commit: 68e77ffbfd06ae3ef8f2abf1c3b971383c866983
> --
> 2.32.0
>
