Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18181482957
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 06:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiABFc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 00:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiABFcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 00:32:25 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D22C061401
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 21:32:25 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id t14so22538391ljh.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 21:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eoiQ1KQCJ264ktaBoIMzabH4DC3BnHoyNUOH7R2xfGE=;
        b=yYBSC5lysVvJJvnfgAikjlfcPvXtpBeSHCMXW02NeblK+R7M2cdUuXlPIQsC8hgj6S
         m9MClDBjLME/csDB9yr+lu2tJAczUjiZQugxQKJKJ/Y85c0/CIZyIoPEUl5o83nLjsQd
         yFYszFo2r81u/y51uN6O+HurpwmOo9M8TkZ4VgMSukjVAFnYKhDuS3QHNRSQ6xsYhBuU
         X2cMVp6CObIuuli55848qIysWAP/7IrvkE4fhng5L0fYkpzLBfjbObzyYm21uv35RX2N
         lmBWtfArOezp5xg7xGM6xXq9gv7w/3zSNrW+TqVYg/upO7oPZtc1kWklBnnTV0A7NqS3
         h1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoiQ1KQCJ264ktaBoIMzabH4DC3BnHoyNUOH7R2xfGE=;
        b=cGde1nMTKLqfLD+zMlUYiwrumQHd15xq16B7XCp3NtxbDdO15LNcshsidY6LqzzsIu
         zvBBYhPu/rSJn7UXnfI1QtD3v0bEZKA3VuGwuAZ1syy1/onXqbgmI96a9HgbmnuctLzs
         0EvIwMUrG1FjMNmU8Zqb7K7pVRSWbs7xTnnWgaqPr31Jz2kmWE2O8+nnop4KC+kgkTpw
         Tso14BUo63lv9atrwvjd2PWBQ0e/u5YoEHRgY+9Q8Uf2eGaeS5QRa2ZqVv/UsqbZntG0
         TbctiPDw+77wLlrQpVVfZsjoOBewjW9G81oNlnwTBLM0kU9RHInma/IA4ljGByGuRJZO
         iKgw==
X-Gm-Message-State: AOAM530h+OtLpDV2M2/sNgUjEx35ARJ/fx4O6rb54rNZh/vZFLc5/8L7
        bcOvmP7oaUqzKILYK+7yxNAH7Bxmq6jOcRkRD1o81w==
X-Google-Smtp-Source: ABdhPJw4xEaszeQin5r2Odu1gmvGU60LgLA3geDvlmTokl3LciZbSNZGYLPNPKmSyqjJHa3BrTln8FjKn/xFLZmC/AY=
X-Received: by 2002:a2e:7c01:: with SMTP id x1mr33669767ljc.145.1641101543185;
 Sat, 01 Jan 2022 21:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-4-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-4-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 06:31:26 +0100
Message-ID: <CACRpkdZc75XUJh7afPhcBNaVE63Ovby2HVBe+HObvURN8i84KQ@mail.gmail.com>
Subject: Re: [PATCH 03/34] brcmfmac: firmware: Support having multiple alt paths
To:     Hector Martin <marcan@marcan.st>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        "Daniel (Deognyoun) Kim" <dekim@broadcom.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 4:37 PM Hector Martin <marcan@marcan.st> wrote:

> Apple platforms have firmware and config files identified with multiple
> dimensions. We want to be able to find the most specific firmware
> available for any given platform, progressively trying more general
> firmwares.
>
> First, add support for having multiple alternate firmware paths.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

This looks OK to me so FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Make sure Dmitry Osipenko gets to review this though, he has many
valuable insights about how the FW is loaded and helped me out a
lot when I patched this.

Yours,
Linus Walleij
