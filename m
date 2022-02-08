Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593DC4ADC1F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379536AbiBHPM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351656AbiBHPM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:12:56 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9ADC061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:12:55 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id k13so33885224lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 07:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2+GjzePMFpH5F944i8QOqtHOHuiYTriOX9rD5i+Mws=;
        b=CCldQERGrCvjQn5prWyMGA1XEKEW6SlWWAaXNhd7pkglCcsjtbVcmreyYaIM3JRU9j
         kzk2Vw2WL5thyTjoc3WD0CQqbGvg3PKeTzSv0YKVWdDaPFH+Cv/zdLacQ+656059qxEr
         02eooFkw1Fu+hgpYEBviCX6usGPrpmARJXS5MtCDlIzDstS/xHJx3T6Za6DFTU5xR58q
         Syqh3/QfMiLIdezUQQR2WQ5B2k8psty8U+PwTzVKYHreCXIGf8GTHEANiqHMaeOdUtuz
         weE7yf3pFibbTCQL55PMQLGuX6xHedTNwMa0iyzP5/HstY7f53Ar5jfluhPmsrEDpQ3l
         tU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2+GjzePMFpH5F944i8QOqtHOHuiYTriOX9rD5i+Mws=;
        b=WlHw4rQR42r5setP4oEHTrBzpbSyJCR1jShM8lJtv+DNwI6KfEzfEoPrhev8j6u4uR
         h8QUpGJqgPhU6/0fswq+g79qXAAFVDC2JIy0kYiLAYPvDuZ2O8RN4uaBKZBR46jEI7tA
         w9PYbUD3Uu4kaCTbRuT2oDM9CmTZyuo3GO9fYMGNCwFL5gKW0cn25fsYSK4w7eT2FmLb
         6ouIiDFYl5y7Dl5eYpy7bVS54RbQ4MlssS9Pdeg2lopcv3jtA18ClekMaaNVyLlb6FCI
         TxKv3s8qP4R9ZbRevW6FV3ufLofcOs0fSLLhYcZqyo08IT5BpkhrPJ5P3BY98ly4Fjpn
         HAHg==
X-Gm-Message-State: AOAM531oAXH5qK80k2EMgTetgO0pGK1GU93TCgx9gSukc8kgMyHbWWSp
        Lx6FwzQ8tRZQ8QycvgGNaw0IaHy14wvlSepu1arikA==
X-Google-Smtp-Source: ABdhPJwhm+nC6e2kePHoIEaRqqooZpIwL78JW6X7AsmRxvU286v5l6BSxZS1fegs8BoD3N9IXlW/J6k8YKCiTPMT5kU=
X-Received: by 2002:ac2:5dcb:: with SMTP id x11mr3273145lfq.254.1644333173813;
 Tue, 08 Feb 2022 07:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20220202180648.1252154-1-huobean@gmail.com>
In-Reply-To: <20220202180648.1252154-1-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Feb 2022 16:12:17 +0100
Message-ID: <CAPDyKFqDk3Jik5tXoKNbQijZTd08nTcHgv_Z-D2DbV_TUM+76w@mail.gmail.com>
Subject: Re: [PATCH 0/5] Use of_device_get_match_data() helper
To:     Bean Huo <huobean@gmail.com>
Cc:     Eugen.Hristev@microchip.com, adrian.hunter@intel.com,
        nicolas.ferre@microchip.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com
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

On Wed, 2 Feb 2022 at 19:07, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> *** BLURB HERE ***
>
> Bean Huo (5):
>   mmc: wmt-sdmmc: Use of_device_get_match_data() helper
>   mmc: sdhci-tegra: Use of_device_get_match_data() helper
>   mmc: sdhci-omap: Use of_device_get_match_data() helper
>   mmc: sdhci-of-at91: Use of_device_get_match_data() helper
>   mmc: davinci: Use of_device_get_match_data() helper
>
>  drivers/mmc/host/davinci_mmc.c   | 6 ++----
>  drivers/mmc/host/sdhci-of-at91.c | 6 ++----
>  drivers/mmc/host/sdhci-omap.c    | 7 +------
>  drivers/mmc/host/sdhci-tegra.c   | 6 ++----
>  drivers/mmc/host/wmt-sdmmc.c     | 7 ++-----
>  5 files changed, 9 insertions(+), 23 deletions(-)
>

Series applied for next, except patch3 that seems to need some minor
adjustments, thanks!

Kind regards
Uffe
