Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863B1482A1F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 07:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiABGSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 01:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiABGSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 01:18:53 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7B5C06173F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 22:18:53 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s4so33086721ljd.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 22:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bIpZkSSwUqhTYMnQk3E9gHCYpVd9Az41cx0tuuegs8=;
        b=OucrQEUNhyBWKSnCvR9D16DFgQtdfmnAf29tqqy6+HKU6EZirHATPRfr10cwmrj5xi
         IPnUytEzWZkMLH+qlYRtqKr6tkjD2acjFa8Qdt31WUwJZ0Kno7EF8cJ5yqKKdl+mIdXk
         ilZepGNn3QIJA9g9iha95KxYbhJAcndKTwo8OirDIHlUGnAdEFWHmw7J+zB2KAAyb0qA
         DGpK0SR3rHZGaEmaOOxy+GPwhbI0G69v6YuwFCUy46a/hbaigcKMuTA7q+kBsz8VjjUC
         YQCOT9EVAwprQARP6JU4KpdkQY/CElKrtyH6lZ4C2WTeJ9eL4ZP/uUI1VzPhZBo9NNGu
         DaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bIpZkSSwUqhTYMnQk3E9gHCYpVd9Az41cx0tuuegs8=;
        b=e87t/J6l/OXJ/BcmKLSpQPX+4QVf6xxQgb7T9Jnz91J7cmN5L5JX7gwpa6Kt7qXw3N
         gTQKqfvWN+BmJ8088MYk7PuCckMkjazdtovFs2HGFNEhj2l+CMEKQxgGLo3IJURNUt7l
         bdiyp/7ccY4QgOUqMKpWx2CTdF4xkkOQi1MvgmeTA5rLHqPOsyBUvrlRBzrAjDpCQNZh
         2ZPMTY/enZGYOZJ71r7zxHoo4nPW1kWQJ8W4nPWdqfQO/4BkSOvaGZIwMj1yI0q9/Glg
         z192wJraQXSDwRZZDTXBBNImcK5blYA9oVT70mpnBWp/CDAZoOEfcGEzwRx7UW5TtQKq
         TPEg==
X-Gm-Message-State: AOAM533whsAIs1iIcomLbCFyV+3+/3WOBTXwnGoOOuXH9u+9+VBaZjZX
        i4Y02FqTM32NrtfUm8OFZo6Q1K/ruQ2RpEVw9OzBkQ==
X-Google-Smtp-Source: ABdhPJzZTch5KFk/VIhETikoFA4AzemvKxIUlgqqKTF8a4qqacW7BOlB0kgbtiXPJUPQfLEeQYoq5Y6boyIoaHacTf0=
X-Received: by 2002:a2e:b808:: with SMTP id u8mr24179798ljo.282.1641104331778;
 Sat, 01 Jan 2022 22:18:51 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-33-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-33-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:18:39 +0100
Message-ID: <CACRpkdZJiizvQfhqyVefXNj+L8ajhY-QcvKXtfMy3BVVwC3Vsg@mail.gmail.com>
Subject: Re: [PATCH 32/34] brcmfmac: common: Add support for downloading TxCap blobs
To:     Hector Martin <marcan@marcan.st>
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

On Sun, Dec 26, 2021 at 4:40 PM Hector Martin <marcan@marcan.st> wrote:

> The TxCap blobs are additional data blobs used on Apple devices, and
> are uploaded analogously to CLM blobs. Add core support for doing this.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
