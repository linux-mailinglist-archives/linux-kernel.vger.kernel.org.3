Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E5549829D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbiAXOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbiAXOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:41:59 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3C6C061401
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 06:41:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b14so50007550lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 06:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7LL1t8uDOWPBJxckYxtbiogyh1lZRm17pkYDYEV3e4=;
        b=lXQXR/Z/FrAUrvj7g7KZNL8QCydJ1TK/TITZ8WFtKZxQQQYBPmtc22GkImqyzbFhDf
         OAhRFpP5fBf0ve5YPJjD+xdrb6bMbGPhuX3meq7q4G695CQlnFOz7D5uNoBq8e11ykiJ
         U+ZUoj3ZXZiYkkp7bIFuSx254Noivw1U40+KRY4Xb5DF38ChE2A5PHSIUr4+tVi0fvbh
         JKD4xTgXuoJFVCG9iF++SXBd5prb3zllPRaacVCUNgi2GthC0LJmfucMHxtRLMEv6bHc
         pod6JhlpkmlrtT+DNBGAYhz7gtu2Kbd8BvcKEDZcVuJzgjcMUfNh+z5ri+F4QlHbqJQS
         AgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7LL1t8uDOWPBJxckYxtbiogyh1lZRm17pkYDYEV3e4=;
        b=PeLmqSV3YOnGuUg6xR8gmpnrZRheOxgGkmHd8vGdzNvdYsLTOTxuOIiHeNVHTKAJm+
         k1mzZMmVH/S0veRQqAOsRXKGXElMmPJ6U4Nsw1CgfSFEOAxwuczTKHFzTK+OtQxgHj9K
         oN7UIefG2e0DwqtWoEjnvrItpug+nLgv2Q7RIDJRMWK8ax0Fk+Zvf8EObXCdRZiiYcDN
         WvlgBwjKIKTMkUfrEDo1Ff61rcHnyN5VYOWLUkruGCs+AXFzO+wZpizNqpWRoW0d9qO7
         B+pcMvRx+iR1/BGDrJGEI6V1NT3yEs24TzurzRvSkk+ZpW5MmlUq6I5JHJ61/UrpiYsV
         0kuQ==
X-Gm-Message-State: AOAM533o+4HUG+heR3jB9zF+x0N8QUQcLBamUmg+FJdBpSD0gKVwUCTh
        1+8EA80NLs7nTGHnt3SEVnz+qs9bRpb/+zhE47D+nYKjrPE=
X-Google-Smtp-Source: ABdhPJwb6BPJjYrqIgJxJfIqkEBzNKcIqIJwWRrFsEzMoVaeh7RwT1DYK6kcAxu5XnN5wt//ZZ52mAvY8UeJvZ9+4xA=
X-Received: by 2002:a2e:5356:: with SMTP id t22mr4045998ljd.300.1643035316492;
 Mon, 24 Jan 2022 06:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20220119075406.36321-1-benchuanggli@gmail.com>
In-Reply-To: <20220119075406.36321-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Jan 2022 15:41:20 +0100
Message-ID: <CAPDyKFpF-Y5woXezMSNhNBvcX7=yvWi+525du8eRibpkCabuzg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-pci-gli: Add a switch to enable/disable
 SSC for GL9750 and GL9755
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, greg.tu@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 08:54, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Add a vendor-specific bit at the bit26 of GL9750's register 878h and
> GL9755's register 78h to decide whether to disable SSC function. If
> this bit is set, the SSC function will be disabled.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 66 ++++++++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 9de3d91283af..b8cd7a365ec2 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -62,6 +62,7 @@
>  #define   GLI_9750_MISC_RX_INV_OFF       0x0
>  #define   GLI_9750_MISC_RX_INV_VALUE     GLI_9750_MISC_RX_INV_OFF
>  #define   GLI_9750_MISC_TX1_DLY_VALUE    0x5
> +#define   SDHCI_GLI_9750_MISC_SSC_OFF    BIT(26)
>
>  #define SDHCI_GLI_9750_TUNING_CONTROL            0x540
>  #define   SDHCI_GLI_9750_TUNING_CONTROL_EN          BIT(4)
> @@ -134,6 +135,9 @@
>  #define PCI_GLI_9755_SerDes  0x70
>  #define PCI_GLI_9755_SCP_DIS   BIT(19)
>
> +#define PCI_GLI_9755_MISC          0x78
> +#define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>
>  /* Genesys Logic chipset */
> @@ -368,6 +372,19 @@ static void gl9750_set_pll(struct sdhci_host *host, u8 dir, u16 ldiv, u8 pdiv)
>         mdelay(1);
>  }
>
> +static bool gl9750_ssc_enable(struct sdhci_host *host)
> +{
> +       u32 misc;
> +       u8 off;
> +
> +       gl9750_wt_on(host);
> +       misc = sdhci_readl(host, SDHCI_GLI_9750_MISC);
> +       off = FIELD_GET(SDHCI_GLI_9750_MISC_SSC_OFF, misc);
> +       gl9750_wt_off(host);
> +
> +       return !off;
> +}
> +
>  static void gl9750_set_ssc(struct sdhci_host *host, u8 enable, u8 step, u16 ppm)
>  {
>         u32 pll;
> @@ -389,22 +406,28 @@ static void gl9750_set_ssc(struct sdhci_host *host, u8 enable, u8 step, u16 ppm)
>
>  static void gl9750_set_ssc_pll_205mhz(struct sdhci_host *host)
>  {
> -       /* set pll to 205MHz and enable ssc */
> -       gl9750_set_ssc(host, 0x1, 0xF, 0x5A1D);
> +       bool enable = gl9750_ssc_enable(host);
> +
> +       /* set pll to 205MHz and ssc */
> +       gl9750_set_ssc(host, enable, 0xF, 0x5A1D);
>         gl9750_set_pll(host, 0x1, 0x246, 0x0);
>  }
>
>  static void gl9750_set_ssc_pll_100mhz(struct sdhci_host *host)
>  {
> -       /* set pll to 100MHz and enable ssc */
> -       gl9750_set_ssc(host, 0x1, 0xE, 0x51EC);
> +       bool enable = gl9750_ssc_enable(host);
> +
> +       /* set pll to 100MHz and ssc */
> +       gl9750_set_ssc(host, enable, 0xE, 0x51EC);
>         gl9750_set_pll(host, 0x1, 0x244, 0x1);
>  }
>
>  static void gl9750_set_ssc_pll_50mhz(struct sdhci_host *host)
>  {
> -       /* set pll to 50MHz and enable ssc */
> -       gl9750_set_ssc(host, 0x1, 0xE, 0x51EC);
> +       bool enable = gl9750_ssc_enable(host);
> +
> +       /* set pll to 50MHz and ssc */
> +       gl9750_set_ssc(host, enable, 0xE, 0x51EC);
>         gl9750_set_pll(host, 0x1, 0x244, 0x3);
>  }
>
> @@ -529,6 +552,19 @@ static void gl9755_set_pll(struct pci_dev *pdev, u8 dir, u16 ldiv, u8 pdiv)
>         mdelay(1);
>  }
>
> +static bool gl9755_ssc_enable(struct pci_dev *pdev)
> +{
> +       u32 misc;
> +       u8 off;
> +
> +       gl9755_wt_on(pdev);
> +       pci_read_config_dword(pdev, PCI_GLI_9755_MISC, &misc);
> +       off = FIELD_GET(PCI_GLI_9755_MISC_SSC_OFF, misc);
> +       gl9755_wt_off(pdev);
> +
> +       return !off;
> +}
> +
>  static void gl9755_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
>  {
>         u32 pll;
> @@ -550,22 +586,28 @@ static void gl9755_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
>
>  static void gl9755_set_ssc_pll_205mhz(struct pci_dev *pdev)
>  {
> -       /* set pll to 205MHz and enable ssc */
> -       gl9755_set_ssc(pdev, 0x1, 0xF, 0x5A1D);
> +       bool enable = gl9755_ssc_enable(pdev);
> +
> +       /* set pll to 205MHz and ssc */
> +       gl9755_set_ssc(pdev, enable, 0xF, 0x5A1D);
>         gl9755_set_pll(pdev, 0x1, 0x246, 0x0);
>  }
>
>  static void gl9755_set_ssc_pll_100mhz(struct pci_dev *pdev)
>  {
> -       /* set pll to 100MHz and enable ssc */
> -       gl9755_set_ssc(pdev, 0x1, 0xE, 0x51EC);
> +       bool enable = gl9755_ssc_enable(pdev);
> +
> +       /* set pll to 100MHz and ssc */
> +       gl9755_set_ssc(pdev, enable, 0xE, 0x51EC);
>         gl9755_set_pll(pdev, 0x1, 0x244, 0x1);
>  }
>
>  static void gl9755_set_ssc_pll_50mhz(struct pci_dev *pdev)
>  {
> -       /* set pll to 50MHz and enable ssc */
> -       gl9755_set_ssc(pdev, 0x1, 0xE, 0x51EC);
> +       bool enable = gl9755_ssc_enable(pdev);
> +
> +       /* set pll to 50MHz and ssc */
> +       gl9755_set_ssc(pdev, enable, 0xE, 0x51EC);
>         gl9755_set_pll(pdev, 0x1, 0x244, 0x3);
>  }
>
> --
> 2.34.1
>
