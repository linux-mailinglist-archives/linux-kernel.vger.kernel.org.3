Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDA351192B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiD0Oqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiD0Oqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:46:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B136B76
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:43:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p10so3497131lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDmOa+bBka6qRIRUThLVvMPBDyUXW6sZWoZqLJXms5Y=;
        b=yOC6fW9RNPJulLtZgpyeRCjXrRN+5xZh+FY3a8Ty6BbYqo5ickn0LrxJIOEAGkbv4M
         LyuSznG04eMX+qxn2wuh0fC0Di+u9fW6d1Ei47gG2KjKJJrEJ3ymIzlQaZ/NPxhJLP84
         tk8jGaig9Gqexe3Z2660toc4XACQE8h2u543AHmnZ5bU51d3cRkDlIm9yOzxkPeQbA7i
         ZkKvUQZH4LOEavauEpXqI5r++PmgAdfMUsPMayXwN+oQzCWw+Dw/u5KxuyPGc+4BQ0PV
         SKA5QYdQmUKPCZEJRYJU2m/pk6Ih90fkYClJl+xLNbvylVzv1r98sI4AezORGxQbBKxZ
         JdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDmOa+bBka6qRIRUThLVvMPBDyUXW6sZWoZqLJXms5Y=;
        b=yuEDEMuoz320NHD1T9ZdNuRyJppTRRCzom7aQztyYUS52D1fe62f46O0LOgGpXhX1T
         3mibDuE012q887CMJwNwjLYNdgAV/Hu87Ili/kLTP9tVeYPvHtLSMmWRx2dSoT0dba6h
         +ZZpTfBakNaainCN/FsC+RWfWa/Jyf+UbM6l58eXzOg5xWSdxBrKg1TgjCIe0rou7aOB
         2aWLdq8KVhpcBacR47Lc52rYsr3SICWHvb/U1Li6M6dqmZYLA62SnoPIivpi+Ovi+aHq
         DcnutSuQRGd4PIWRqCsVFa4xJDaIO7S1xWfNxfcdpbQMXN37F6cIR8+ROgdeWMO/yST7
         0HcA==
X-Gm-Message-State: AOAM531wdT5pS9tXpZpA2b/TymcOH6cHzpntlFis7TWzRnm7b6A7N0BB
        nQBioUAjeAFjyey3xWz8wql1Alm65WQTGJfET8GANA==
X-Google-Smtp-Source: ABdhPJzQyDIZlX5h7tysUHMoMBc+a8TpgO+P2gnLM0YuW9ekQDGqgTt7ZrZ264xWznzk2G8yb/O0FOtEviuGiwPfsk8=
X-Received: by 2002:ac2:5f0b:0:b0:448:1e32:4531 with SMTP id
 11-20020ac25f0b000000b004481e324531mr21491985lfq.167.1651070604294; Wed, 27
 Apr 2022 07:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <1650816153-23797-1-git-send-email-quic_c_sbhanu@quicinc.com>
In-Reply-To: <1650816153-23797-1-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Apr 2022 16:42:48 +0200
Message-ID: <CAPDyKFp=p+m2YSYJne=4TyejgYD-6OoARc=NkaFJOpora1r9iA@mail.gmail.com>
Subject: Re: [PATCH V5] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        adrian.hunter@intel.com, p.zabel@pengutronix.de, chris@printf.net,
        venkatg@codeaurora.org, gdjakov@mm-sol.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 at 18:02, Shaik Sajida Bhanu
<quic_c_sbhanu@quicinc.com> wrote:
>
> Reset GCC_SDCC_BCR register before every fresh initilazation. This will
> reset whole SDHC-msm controller, clears the previous power control
> states and avoids, software reset timeout issues as below.
>
> [ 5.458061][ T262] mmc1: Reset 0x1 never completed.
> [ 5.462454][ T262] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [ 5.469065][ T262] mmc1: sdhci: Sys addr: 0x00000000 | Version: 0x00007202
> [ 5.475688][ T262] mmc1: sdhci: Blk size: 0x00000000 | Blk cnt: 0x00000000
> [ 5.482315][ T262] mmc1: sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
> [ 5.488927][ T262] mmc1: sdhci: Present: 0x01f800f0 | Host ctl: 0x00000000
> [ 5.495539][ T262] mmc1: sdhci: Power: 0x00000000 | Blk gap: 0x00000000
> [ 5.502162][ T262] mmc1: sdhci: Wake-up: 0x00000000 | Clock: 0x00000003
> [ 5.508768][ T262] mmc1: sdhci: Timeout: 0x00000000 | Int stat: 0x00000000
> [ 5.515381][ T262] mmc1: sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
> [ 5.521996][ T262] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [ 5.528607][ T262] mmc1: sdhci: Caps: 0x362dc8b2 | Caps_1: 0x0000808f
> [ 5.535227][ T262] mmc1: sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
> [ 5.541841][ T262] mmc1: sdhci: Resp[0]: 0x00000000 | Resp[1]: 0x00000000
> [ 5.548454][ T262] mmc1: sdhci: Resp[2]: 0x00000000 | Resp[3]: 0x00000000
> [ 5.555079][ T262] mmc1: sdhci: Host ctl2: 0x00000000
> [ 5.559651][ T262] mmc1: sdhci_msm: ----------- VENDOR REGISTER DUMP-----------
> [ 5.566621][ T262] mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg: 0x6000642c | DLL cfg2: 0x0020a000
> [ 5.575465][ T262] mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl: 0x00010800 | DDR cfg: 0x80040873
> [ 5.584658][ T262] mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 : 0xf88218a8 Vndr func3: 0x02626040
>
> Fixes: 0eb0d9f4de34 ("mmc: sdhci-msm: Initial support for Qualcomm chipsets")
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>

So this looks good to me, but I can't apply it until I get a patch
that updates the DT doc too.

Kind regards
Uffe

> ---
>
> Changes since V4:
>         - Called reset_control_put() in error path.
>
> Changes since V3:
>         - Used reset controller local variable as suggested by
>           Bjorn Andersson.
>         - Passed NULL as a parameter to
>           devm_reset_control_get_optional_exclusive() as suggested by
>           Bjorn Andersson.
>         - Replaced devm_reset_control_get_optional_exclusive() with
>           reset_control_get_optional_exclusive() and called
>           reset_control_put() before returning to clear the reset
>           controller as suggested by Bjorn Andersson.
>
> Changes since V2:
>         - Dropped new line after fixes tag as suggested by Bjorn
>           Andersson.
>         - Passed device structure instead of passing platform_device
>           structure as a argument for sdhci_msm_gcc_reset() as suggested
>           by Bjorn Andersson.
>         - Replaced dev_err() with dev_err_probe() as suggested by Bjorn
>           Andersson.
>
> Changes since V1:
>         - Added fixes tag as suggested by Ulf Hansson.
>         - Replaced devm_reset_control_get() with
>           devm_reset_control_get_optional_exclusive() as suggested by
>           Ulf Hansson.
> ---
>  drivers/mmc/host/sdhci-msm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 50c71e0..ff9f5b6 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/interconnect.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/reset.h>
>
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -2482,6 +2483,43 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>         of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
>  }
>
> +static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
> +{
> +       struct reset_control *reset;
> +       int ret = 0;
> +
> +       reset = reset_control_get_optional_exclusive(dev, NULL);
> +       if (IS_ERR(reset))
> +               return dev_err_probe(dev, PTR_ERR(reset),
> +                               "unable to acquire core_reset\n");
> +
> +       if (!reset)
> +               return ret;
> +
> +       ret = reset_control_assert(reset);
> +       if (ret) {
> +               reset_control_put(reset);
> +               return dev_err_probe(dev, ret, "core_reset assert failed\n");
> +       }
> +
> +       /*
> +        * The hardware requirement for delay between assert/deassert
> +        * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
> +        * ~125us (4/32768). To be on the safe side add 200us delay.
> +        */
> +       usleep_range(200, 210);
> +
> +       ret = reset_control_deassert(reset);
> +       if (ret) {
> +               reset_control_put(reset);
> +               return dev_err_probe(dev, ret, "core_reset deassert failed\n");
> +       }
> +
> +       usleep_range(200, 210);
> +       reset_control_put(reset);
> +
> +       return ret;
> +}
>
>  static int sdhci_msm_probe(struct platform_device *pdev)
>  {
> @@ -2529,6 +2567,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>
>         msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
>
> +       ret = sdhci_msm_gcc_reset(&pdev->dev, host);
> +       if (ret)
> +               goto pltfm_free;
> +
>         /* Setup SDCC bus voter clock. */
>         msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
>         if (!IS_ERR(msm_host->bus_clk)) {
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
