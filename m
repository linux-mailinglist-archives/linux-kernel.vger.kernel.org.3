Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5905706A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiGKPJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiGKPJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:09:14 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EA025EAA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:09:11 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id u6so5002773iop.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjJyUrv/9KeAF4uwLYY03FcyF3s57OWw5tLe/ipLqOA=;
        b=ZgMqfivM/ulF9/76btxe6b02wCo/5qZWqIUWWwrSRzFcU6xI4UUMRgLgzZTgQ3xOTl
         TAxvsLCJ4AcY5KWdYyxsWoVb/zmhDp2kgVRPbcEkOuOdCuaN9d+7NKwAXlKE6XN9djX9
         qRu82BLQgsvTR6iC/z53I4Jf9lk4h6s6vL0fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjJyUrv/9KeAF4uwLYY03FcyF3s57OWw5tLe/ipLqOA=;
        b=jmH1rZjhXrV8laHW0XKlfBTdXUGG6pD/6I8D0xEf+qQAuFfqFRFtGiJv13ELzVVhSv
         XabvRhHnj4oqU0tRJfSRAdcRQK2X16lvib8kUeeSxCc2E4fpSJf39EewwYO9SaVYbctO
         YU81hvoVbEdBwH1fR3t/Rzlk35Z7lHP4U1CLz6Er4+pRbBcsUc4nzv50f+PMAN++u1jw
         HX1wvdfKFW+J1hC2EjWYPZi3LNw2NIh0bef/XbiHOEyiuDgFFv82qLS2Sg33swbCHvCi
         WJdBKfjNjMKGm1PJywqrEYOS72dKYaDaQr4f2s6ul8ppXbNtoTsz/yaUeEtcibtjPNoR
         yJig==
X-Gm-Message-State: AJIora/zpNkocsCEPoRIWuWViTBR6wxYfDn77Bxc3bDzMdaAggz1yg3J
        xPWVJ6wZlUH033j3tdthQDtONm3XlULNNB1wawE=
X-Google-Smtp-Source: AGRyM1tqveYBR+fIp0wvStByx6rHKRyjfK6Wy7e5ceuXAgHbRWs3RouqZRd6ixY532D/XKlP7MPdkw==
X-Received: by 2002:a02:9044:0:b0:33f:3845:3ea0 with SMTP id y4-20020a029044000000b0033f38453ea0mr8631170jaf.176.1657552150893;
        Mon, 11 Jul 2022 08:09:10 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id s22-20020a02b156000000b00339db3266c7sm3008235jah.124.2022.07.11.08.09.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 08:09:09 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id z3so3173529ilz.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:09:09 -0700 (PDT)
X-Received: by 2002:a05:6e02:174a:b0:2dc:7bc5:f810 with SMTP id
 y10-20020a056e02174a00b002dc7bc5f810mr3279673ill.254.1657552149101; Mon, 11
 Jul 2022 08:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org> <20220711082709.39102-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711082709.39102-2-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 08:08:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7BCMTByC9xn2iRsxoB9RzRENz5zuTy1Sgmhjbw3aQMw@mail.gmail.com>
Message-ID: <CAD=FV=W7BCMTByC9xn2iRsxoB9RzRENz5zuTy1Sgmhjbw3aQMw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-msm: add MSM8998 SDCC specific compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 1:27 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add a MSM8998-specific SDCC compatible, because using only a generic
> qcom,sdhci-msm-v4 fallback is deprecated.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e395411fb6fd..bb169c1c2b5e 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2447,6 +2447,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
>         {.compatible = "qcom,msm8992-sdhci", .data = &sdhci_msm_mci_var},
>         {.compatible = "qcom,msm8994-sdhci", .data = &sdhci_msm_mci_var},
>         {.compatible = "qcom,msm8996-sdhci", .data = &sdhci_msm_mci_var},
> +       {.compatible = "qcom,msm8998-sdhci", .data = &sdhci_msm_mci_var},

FWIW I'm _against_ this change.

In my mind while it is correct to specify both the specific and
generic compatible string in the device tree, the driver itself should
rely on just the generic compatible string until there is a reason to
use the specific one (like we needed to for sdm845 and sc7180).

I think I pointed that out before, but somehow all of the specific
device tree strings have snuck their way into the driver without me
paying attention. :(

-Doug
