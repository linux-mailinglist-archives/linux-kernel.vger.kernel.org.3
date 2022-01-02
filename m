Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5002B4829D2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 07:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiABGAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 01:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiABGAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 01:00:07 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A529C061746
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 22:00:07 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t14so22605129ljh.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 22:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rjti7d90WP8Xg6Hp0kYEpjGAZMuupp9s0gpIcrJvVXQ=;
        b=L1tmfP4ShxzOgVIz2PEl+IiE+pc1ShqKkzJJ3FuYtfcWHhlrJjkBbrlzQHfZfIdCUM
         PXAkJt+SUZEoMSaVFBM3Nq06zF4p2yiOFu7CRXwL5CtCCJa1tzVSU5SW2HmWTE4Y0Vom
         MGbq/EvQRtsdpZ8mkfr+feE+xoqZk4AVLIt9U2HW06NUr1jOQ82yEcjRbpe9tprarXF4
         BoDEEUZ/qPvEThxmwys0ZFwWAh4kYjvLJ43MsSpmPzAa+EoHrzVb7nspqlRkMVUpuW4d
         WSoB4RqbFdaXgtm3ufJy+Rjle+oc1q5LstR9kV6Jnr2vNbOE2iUpez/gxylWrX2HZOC0
         lqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rjti7d90WP8Xg6Hp0kYEpjGAZMuupp9s0gpIcrJvVXQ=;
        b=u9B47uXbXJZn2CgRwTlb+A3rTebc7UQWMD+8aufaBmq8nmQ1pD8iCVAdiPH9N0FxAo
         YkO1LWmle2n+8Jbi9o/4vIg25oM7kKx9VNAp7XK64ZEulnfMbIZbyn2Uy5MeRoaBJ9aJ
         qmYVYeNPxngG1niaoOSPzBGut77nPWebo97vW6bJ9HQLEq4ERWntLWCfgJX0ROfzuauK
         IZ1HWv1cyGLwx1XmOs7sSmVTTyWx3QEIasmbgyoo8msc/PYoZmn/1ZqLzwt12156/28E
         j0CpBRQ1196OrRecI7uua8/0tN28ssnt/AR3o2OCtB6ntslwr0oByXEZd2bW2zL3MzmT
         FRTw==
X-Gm-Message-State: AOAM53231BHuHk0LXLjp6KwNm21osZE6QERfK/eYo1T84D1nE9AIWQ1J
        MLxpQyWWQIjxWNePjgrRG+hDmdNj/8Hf+VnxLt/odA==
X-Google-Smtp-Source: ABdhPJyv1Mvd6Mp+D18WKgLy8no0MQSmte5uMFeAHGA5tMcWXaralMbmZV5qMWOi9pa6EMdURgIDyO+USZ9oJ0EGv5k=
X-Received: by 2002:a2e:b808:: with SMTP id u8mr24152647ljo.282.1641103205129;
 Sat, 01 Jan 2022 22:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-18-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-18-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 06:59:52 +0100
Message-ID: <CACRpkda=bD6BRVko5MZOnfLbKxLVbrwYmv4T4NSwY1vq9AGoTw@mail.gmail.com>
Subject: Re: [PATCH 17/34] brcmfmac: pcie: Provide a buffer of random bytes to
 the device
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

On Sun, Dec 26, 2021 at 4:38 PM Hector Martin <marcan@marcan.st> wrote:

> Newer Apple firmwares on chipsets without a hardware RNG require the
> host to provide a buffer of 256 random bytes to the device on
> initialization. This buffer is present immediately before NVRAM,
> suffixed by a footer containing a magic number and the buffer length.
>
> This won't affect chips/firmwares that do not use this feature, so do it
> unconditionally.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
