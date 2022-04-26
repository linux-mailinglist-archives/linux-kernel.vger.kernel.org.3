Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3790450FFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351299AbiDZN6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351285AbiDZN6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:58:43 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C298BF58
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:55:35 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2eba37104a2so183418197b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGnnsOro0fTXcSX75g0Ywninw1vwEOc38VMslUYvHZE=;
        b=ou4OCBxLogQNNf8C6zhUpKLSHiGc3WCvh0CNrGET0ELwEcHPQyIO8lythpvVt5NhYa
         oCBY1DvCQmYF6ZQ4TEu/nyUUUKhzFEdtRquDmZejzk2utI8slhzSQjnwZIdzdy0R3P8L
         flPjin7Npxygkx5yX4hYsC2z70tKosRQWT3nQw5gB4QB0vZ68iXUZCg38XyB3+r31Bv9
         VtZ4jrKnnjvRl4Ywdnq+xwintuDuIj6GDGeuws5SP2Gq4UT72BzRD238stCxkyNEM5N3
         3GKEKyo1nl4pJ95rtndCzYE9PnhYNnqtCxC2mYqsFaArqkgfkOErCyhGIlJdG6urxNEt
         3kFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGnnsOro0fTXcSX75g0Ywninw1vwEOc38VMslUYvHZE=;
        b=rBwxhIDfGFJbHoxeftagyV5WhazJLeg7DzxdhbSHQNogVbVaOu/I9h+aYsX1QwHYO3
         LlJ/ZKcIV4NpA55X40RnCWjBPa5ZVA2iLcvaCeSUgugbM8JQaCrStD71d1B5kbCgfDEi
         cFncuoSWdbWhNEi9YQTMimIwH1W9uTnO3eM72vcYCDrONm0OGb24SLhNXbrVfhaDYrcp
         6SfhmOBcGkZFKjUGfokiV1FgNcPuRYHpTsvlFNlzwUHyW1mub9oJjfbeaSL5w7aGRs+w
         SlPwBOVb5oXvtKOLHktXlSdKGe7kTToP+jfWX09ljWpHeSXpo35eimyGOk9ukBB5ZSEC
         DflA==
X-Gm-Message-State: AOAM533oi9WYbBPTPZWG1SOtZT6HoxGihD6Vm+HQH7o4BTjzXy6e8i9W
        Qj91R7qJJQi3JKtb1PxW3AFKJTjvZeJRM+5xZIT+6Q==
X-Google-Smtp-Source: ABdhPJwaDHorEVacERGa/V+qc+V5d8PTrwAODlB0texVMiYzB5A4RvNHZtZNRufKjNleEX1dYBFdKo0sZDhbnGGNlik=
X-Received: by 2002:a0d:d101:0:b0:2eb:4bd7:bcc1 with SMTP id
 t1-20020a0dd101000000b002eb4bd7bcc1mr22378985ywd.495.1650981335233; Tue, 26
 Apr 2022 06:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220425063120.10135-1-a-govindraju@ti.com>
In-Reply-To: <20220425063120.10135-1-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Apr 2022 15:54:58 +0200
Message-ID: <CAPDyKFrXogNFhdyHbo_KF3uA0nTc_MRV3tvv3v6Q+K3-KhsO=Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] MMC: Add quirk to set the TESTCD bit
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, 25 Apr 2022 at 08:31, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> The following series of patches add support for setting TESTCD bit
> when SDCD line is connected to the controller, in the sdhci_am654.c
> driver.
>
> Changes since v1:
> - Rephrased the commit message in patch 1 to decribe the hardware
>   and not the sw support
> - Made the reset function static in patch 2
>
> Aswath Govindraju (1):
>   dt-bindings: mmc: sdhci-am654: Add flag to force setting of TESTCD bit
>
> Vignesh Raghavendra (1):
>   drivers: mmc: sdhci_am654: Add the quirk to set TESTCD bit
>
>  .../devicetree/bindings/mmc/sdhci-am654.yaml  |  7 ++++++
>  drivers/mmc/host/sdhci_am654.c                | 23 ++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
>

Applied for next, thanks!

Kind regards
Uffe
