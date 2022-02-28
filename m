Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80D4C7221
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbiB1RFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiB1RFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:05:17 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9CD86E12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:04:38 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m14so22489978lfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIdq0xDa5SoPSxzAGTemiHfQ1WhVcvzkPC8IThSINzA=;
        b=DspDnAfRiAw2/8sOryQqZ05e2H7MMu1/Fzinh2vhH418uJZn+bTF9LC4dXcr8AzBC5
         SN3Yv21IbqS+X+xBDEEAzEj78Ho/vuMmrN+Ed5HQz22qDK4UJ40TBf3whlVCwkYbGVHW
         rkhvErM1Qfur9LKi1ZRSXNg3Xh9Caz/+F1d6jyhafsu5qmJdGPJs2Hl/BrY4PPQC3Llp
         EAU1bDalFvvdutjL2iHCNdv4gzHtTZY9UF5e3G6W5vjJTXGGVGqVvUgSEuJiI3Q0sxlA
         3ZFbWMmdXAA6GNlDXiqNCBqrZGIpQyr61kkowWx13aWKrXuMmYv/MewPouWWt+HVrmax
         jNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIdq0xDa5SoPSxzAGTemiHfQ1WhVcvzkPC8IThSINzA=;
        b=BhfwT0Nuygr6X10dnhy2I2sBrrLehnlehQjdiWfnDrmmgogCqQl9lK9CFUNVzbnACP
         El23x3JgoK6oACx8Pr38AmvfLKpsfEwtFo3CiuXHPv7pGkBKaztUpzvtQSlSDn4o9IJ3
         TnMxFehoaf3xQ2InMgTT4cD3kf9ouIv6dLr/doe2IZHrpJiV75iaYPJvq07UDLhP59wb
         DKvCmgp4DwjlDp9GnhLCwlP9vjvPjVCLnc9avGTf9YB6Wi2HQAJD2m5t1+oFYryet9nt
         IsqylhTT4pazbn0lDqs4uA8Ub7dhg6gx63lHnRPuYK0JV4dJGKnWiGBwWQeXwNMkjGtQ
         0Frg==
X-Gm-Message-State: AOAM532Bzs60oaJZOUHkfbpiJbMFbWwBleOgkVJE9iMAXYPrExpwigeC
        m198j1Ww39mGIuudvZaYa4NUYumeSLMKVeM/RTsaqepsEzaBYQ==
X-Google-Smtp-Source: ABdhPJz9RUZwJ8mORaL4cPamANxjVL0XmzpuvxgMDMuvfL0KaGeivTo02ZgSgXlFrroGwKFIiVaG5nG00YiDsTVuEOE=
X-Received: by 2002:a05:6512:3d2a:b0:443:3198:cb95 with SMTP id
 d42-20020a0565123d2a00b004433198cb95mr14015061lfv.233.1646067876428; Mon, 28
 Feb 2022 09:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20220225125553.1185108-1-benchuanggli@gmail.com> <20220225125553.1185108-2-benchuanggli@gmail.com>
In-Reply-To: <20220225125553.1185108-2-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Feb 2022 18:03:59 +0100
Message-ID: <CAPDyKFq5MdGWefVW6Uwe74Ef5giW+68qRS2hmXNmHLqpfqav8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Add runtime PM for GL9763E
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, greg.tu@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw,
        Kevin Chang <kevin.chang@lcfuturecenter.com>
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

On Fri, 25 Feb 2022 at 13:56, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Add runtime PM for GL9763E and disable PLL in runtime suspend. So power
> gated of upstream port can be enabled.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Tested-by: Kevin Chang <kevin.chang@lcfuturecenter.com>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 54 ++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 97035d77c18c..cf99b6af792d 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -873,6 +873,55 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>  }
>
> +#ifdef CONFIG_PM
> +static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       struct sdhci_host *host = slot->host;
> +       u16 clock;
> +
> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +       return 0;
> +}
> +
> +static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       struct sdhci_host *host = slot->host;
> +       ktime_t timeout;
> +       u16 clock;
> +
> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +       clock |= SDHCI_CLOCK_PLL_EN;
> +       clock &= ~SDHCI_CLOCK_INT_STABLE;
> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +       timeout = ktime_add_ms(ktime_get(), 150);
> +       while (1) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +               if (clock & SDHCI_CLOCK_INT_STABLE)
> +                       break;
> +               if (timedout) {
> +                       pr_err("%s: PLL clock never stabilised.\n",
> +                              mmc_hostname(host->mmc));
> +                       sdhci_dumpregs(host);
> +                       break;
> +               }
> +               udelay(10);
> +       }
> +       clock |= SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +       return 0;
> +}

Both functions above look very similar to what sdhci_set_clock() does.
Can you use that, rather than open coding the above?

Other than that, I would appreciate it if Adrian could have a look at
this too. For example, I wonder if perhaps
sdhci_runtime_suspend|resume_host() should be called in these paths
too.

> +#endif
> +
>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  {
>         struct pci_dev *pdev = slot->chip->pdev;
> @@ -982,6 +1031,11 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>  #ifdef CONFIG_PM_SLEEP
>         .resume         = sdhci_cqhci_gli_resume,
>         .suspend        = sdhci_cqhci_gli_suspend,
> +#endif
> +#ifdef CONFIG_PM
> +       .runtime_suspend = gl9763e_runtime_suspend,
> +       .runtime_resume  = gl9763e_runtime_resume,
> +       .allow_runtime_pm = true,
>  #endif
>         .add_host       = gl9763e_add_host,
>  };
> --
> 2.35.1
>

Kind regards
Uffe
