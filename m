Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C787509F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383453AbiDUMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358962AbiDUMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:15:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737AABE2B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:12:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d6so8323246lfv.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gASVhU/crs6sXEphNU/hZV9BV2Qz02aD86zFkSz7dK0=;
        b=AL/cU7XSsTVHVXBOy9gNNsGbwO4XtEb7qDxziknT+GhSzSOKw/nGhJ8bkG0b4pBEC8
         RqagWYyY1PfSUlcsMEUQx9vbiqwQmJz3vOw6tv5J+IaMRvALQbqTRetz9AU0Fx5a2RwT
         RgGUeKNArgHrzrgo/H4ztslTetgHDX5j4mmGliQzF7mu3Q5tkKFo9NW2joKRrcGKq466
         YUIlPloRjds1l+4UbO5eS3DKvZ7IbBLDJjL7ExyfWkejPkerLoYyocgS1kg38sY8qkDI
         Db/AHnTSn7lwLSq4zH4gxqSIWpr/FCAAEvzHH0btOALKV204L6qTr2Jk+Bkvl+6raUFf
         /T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gASVhU/crs6sXEphNU/hZV9BV2Qz02aD86zFkSz7dK0=;
        b=ongWWxaComrmTKQt4zImVHUGyJrx4XAoUEJkEYH6NxinO65NQ4/PEoPEs29lIVau5Z
         PBpjQOr6cTUTOXVYOHfRDXmCIUFTrqk0aTjEE/HJrkPy3TlrQDhMRXCe6MPK3CVqhLBj
         qVdCGybtQZ1EoMzCtmdUX7rHq95JJGbRK5QRx0AXOedfTERX9E79i35spGaw+OxzGEDm
         FAzXYT3/Xhy18Ht5KsOVXCokOb2X5OHZH4jfhaX7RDEd2uS0UR95NVjO1r5kBurMt4Cw
         FJjSstfjGvQ9HYmQKZKyTQ7/vQxYFPLVbvKVcOCoM552mzGSWR33v5/R9wDZPsqhZ5Yv
         1s9w==
X-Gm-Message-State: AOAM532k/Z+y1oGD536kRmkKb+qU5WAq4M0d1Mz3eFePqCugPKlxU5Bz
        XC4gc+SvM8UT7lSWULjpEZ4191OnH82PP2VaZD6aYg==
X-Google-Smtp-Source: ABdhPJzzmEIowJToWOzSJDQuwgmSD6gBEbeEuLfo7t2ZABJXLNCi5A40sLZ5f4IPRbUM1f5J+33uzMoTexb64mmtoVs=
X-Received: by 2002:a19:505d:0:b0:46d:167e:b9df with SMTP id
 z29-20020a19505d000000b0046d167eb9dfmr18438699lfj.184.1650543155741; Thu, 21
 Apr 2022 05:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220418102040.4993-1-a-govindraju@ti.com> <20220418102040.4993-3-a-govindraju@ti.com>
In-Reply-To: <20220418102040.4993-3-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 14:11:59 +0200
Message-ID: <CAPDyKFreftOExcZ9hgxpDGtdHhniB847vGAGpoO-McTy5_ao1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: mmc: sdhci_am654: Add the quirk to set
 TESTCD bit
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 at 12:21, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> From: Vignesh Raghavendra <vigneshr@ti.com>
>
> The ARASAN MMC controller on Keystone 3 class of devices need the SDCD
> line to be connected for proper functioning. Similar to the issue pointed
> out in sdhci-of-arasan.c driver, commit 3794c542641f ("mmc:
> sdhci-of-arasan: Set controller to test mode when no CD bit").
>
> In cases where this can't be connected, add a quirk to force the
> controller into test mode and set the TESTCD bit. Use the flag
> "ti,fails-without-test-cd", to implement this above quirk when required.
>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index e54fe24d47e7..c36b969ed1b6 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -147,6 +147,9 @@ struct sdhci_am654_data {
>         int drv_strength;
>         int strb_sel;
>         u32 flags;
> +       u32 quirks;
> +
> +#define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>  };
>
>  struct sdhci_am654_driver_data {
> @@ -369,6 +372,21 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>         }
>  }
>
> +void sdhci_am654_reset(struct sdhci_host *host, u8 mask)

This should be a static function.

> +{
> +       u8 ctrl;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +
> +       sdhci_reset(host, mask);
> +
> +       if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
> +               ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +               ctrl |= SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
> +               sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +       }
> +}
> +
>  static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
> @@ -500,7 +518,7 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
>         .set_clock = sdhci_j721e_4bit_set_clock,
>         .write_b = sdhci_am654_write_b,
>         .irq = sdhci_am654_cqhci_irq,
> -       .reset = sdhci_reset,
> +       .reset = sdhci_am654_reset,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_j721e_4bit_pdata = {
> @@ -719,6 +737,9 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>         device_property_read_u32(dev, "ti,clkbuf-sel",
>                                  &sdhci_am654->clkbuf_sel);
>
> +       if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
> +               sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
> +
>         sdhci_get_of_property(pdev);
>
>         return 0;
> --
> 2.17.1
>

Other than the minor thing above, this looks good to me.

Kind regards
Uffe
