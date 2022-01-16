Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF79548FF96
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 00:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbiAPXBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 18:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiAPXBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 18:01:40 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FE1C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 15:01:40 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z22so58032111edd.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 15:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/Nq4QhxxH6TvASap+JSynns/x7p4+2FE5gYsfa20fQ=;
        b=K0SAKM7Z4RB5TeMm8UCWcpG7HyCwLdHOD0h//vpyIo8FxWNNjKSMKieCg/nzmOXn3J
         kg84rkoOqHCskvcOJE6vse7hBk6l2fr0PblIN4Ry/ekKIpNsgpP1Z1OH6ENIZCDzBYkq
         mYqqT6PYTSoYx+9pKoMevVJhnHEX9yZ6H2/lQuQAAx/ELafyLHGtmozLgQzKtuXzmDVp
         GVWviNuJDUtG0ws0gRKInEZyRQgr+s7xdTOasUHODHuwf74S1qRn+XqVBpI4B+gKGR6n
         /JUu2vmekG89c8sJTI2pvgQu+ep+7auoSB0ZCXkLluBxRn6X2fGDtZs+ob6PjnTKDpSt
         cJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/Nq4QhxxH6TvASap+JSynns/x7p4+2FE5gYsfa20fQ=;
        b=wjC1iTAcyIyk9g/A1ScFULz0Y3kqZigfqbjYYhsOO8RYyN4FEHN+UzaS/zcwrz52Zf
         G8z0ZzCjtbASJ8jACwd3A8aSQh1LjigeEVgi2SguU2HiZBx1IOFeuh6GyMAbnB3MVopm
         RzC+So1+HneJj4lI3EYaUQ0RHMz2cItGbD/TJBgMKSKKvcSTurcETmH7SUffr7pFg0Zh
         DbpXsYnlw7vfMeL4JNHGRed2NRWZcNLmkUUpqBfVzNwXTvR1kT6+gMYwUq82i8vCm+z9
         B16B6CLpJCbH1YZlRi9HBnR2idRtVnYmPV/v3CL9Di3+8m0eIEOD6f+uP51JbolJaL0M
         AtMA==
X-Gm-Message-State: AOAM531EXlTSwTeEYE69AQZTMdH6zMI3V2XsYxLpp5HyYDfOM/TA7rZl
        WEYPJcdEJsoB3J1DrElQsScGBzTokC6N9xWcdto=
X-Google-Smtp-Source: ABdhPJzZ7lcIBvR+V7X/PUTXu4n9JFiImkUSOHW8oqJ6w4dOIKb5T3WH1CsLnYZKUTL5JVwOlhWCBkc8/Ml0No92hMI=
X-Received: by 2002:a05:6402:3456:: with SMTP id l22mr13804982edc.280.1642374098685;
 Sun, 16 Jan 2022 15:01:38 -0800 (PST)
MIME-Version: 1.0
References: <tencent_0F8E090AA07050A5857F1E9067E6B9DC0C07@qq.com>
In-Reply-To: <tencent_0F8E090AA07050A5857F1E9067E6B9DC0C07@qq.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 17 Jan 2022 00:01:27 +0100
Message-ID: <CAFBinCDigiSYT+AkRmCgEB6u_v2uJLg49aNrt8ddxq97FkEMxw@mail.gmail.com>
Subject: Re: [PATCH] nvmem: meson-mx-efuse: check the return value of devm_kstrdup()
To:     xkernel.wang@foxmail.com
Cc:     srinivas.kandagatla@linaro.org,
        Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First of all: thank you for this patch!

On Sun, Jan 16, 2022 at 6:37 AM <xkernel.wang@foxmail.com> wrote:
[...]
> @@ -211,6 +211,9 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
>
>         efuse->config.name = devm_kstrdup(&pdev->dev, drvdata->name,
>                                           GFP_KERNEL);
> +       if (!efuse->config.name)
> +               return -ENOMEM;
Looking at other drivers and also at drivers/nvmem/core.c I believe
that the whole devm_kstrdup is unnecessary.
Instead I think the code can be simplified as:
    efuse->config.name = drvdata->name;

What do you think?


Best regards,
Martin
