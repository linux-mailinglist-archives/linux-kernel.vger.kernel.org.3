Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37DF482A14
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 07:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiABGRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 01:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiABGRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 01:17:53 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67053C061746
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 22:17:53 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id g13so38894954ljj.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 22:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTUHfKRdioYLECUoZlRuL32Q2PqnN4yjnZblT7aqDM0=;
        b=w+ugdhPlKPlZcLck5NJn7Usp4yhrQdlxk3h+/HEEGljmQ9CPFPCJ2XzCU9jAaZw/pp
         0VDAOSY333lqD/zXPU6cr8ukEiggKDKcimpb0xKAXowCLnmlTU5Tr19IyjfIS2kiOWry
         du8/pGLPMeHxlV3oz1VppBEsYjwv0YumdEGoPDn7PdxQcBUIzKjfG9wzceMSIctwJ+Js
         z6Kqauc6vWzUS2O76h5zZZdcYCVRpIflvcoGkEvQeYai4CKMnaX8QQoLzboM/5qszSGF
         i8yFBklV+fplPetsJu23JfGgUk8ykxfYU2ctBAUP4d+h6wqaYlRe/Dorvn4f0cVz5fTh
         WdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTUHfKRdioYLECUoZlRuL32Q2PqnN4yjnZblT7aqDM0=;
        b=41UvACjQTaQzrQDnfMuoJRWl2qwMdUUdRXjEe4ZbFM8+FALV8ao3WxGGHHuhBSfvD1
         wBjR3T7rm9a/3SV1ATxuDNfskA9v32WwV7fQKYi3J/oUqs1/sHpZAN7sdI1HpR/uou0q
         TMNkUmVRpXMgRKpx28hfW1ImxXb3MMdGwAYeIfrTAahdEURd+Ixp1QIGTb24QcdmHvka
         04R+3lCEKkIOC/cGINAyVSQdhdtxaL/JTqHmPD0x6Sk2BUHPN0PLKCzQwQNgLx4kfgMo
         7A3X6ZeBvgyxi+WYZUsNIpXxd4mxJ7tquA0r31f0OhQemW9lr8jNSqNCwd7GfPorsdER
         vRFg==
X-Gm-Message-State: AOAM533WEpTlSZwVpZoQ8y1U1o7Rrz9OFb9x3zDcYn/aDpRhNZtPKEaL
        5u4/fLZOgbk5rzzc6Jj8dGgmsma77dTe6nM73impmw==
X-Google-Smtp-Source: ABdhPJzzCDPBIiOo97GBtw8SZ48SuKryXbyoX9ruzryom1nWgTzX4jPEUxlf56udoGSy41VxdS5F7nXcGTjq4DymU30=
X-Received: by 2002:a2e:a4ac:: with SMTP id g12mr14347112ljm.183.1641104271733;
 Sat, 01 Jan 2022 22:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-31-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-31-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:16:57 +0100
Message-ID: <CACRpkdYqyoU63SLh9GuDzL57WJz=m0t0B5RmCeGsO-VAVOZZzg@mail.gmail.com>
Subject: Re: [PATCH 30/34] brcmfmac: pcie: Release firmwares in the
 brcmf_pcie_setup error path
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

> This avoids leaking memory if brcmf_chip_get_raminfo fails. Note that
> the CLM blob is released in the device remove path.
>
> Fixes: 82f93cf46d60 ("brcmfmac: get chip's default RAM info during PCIe setup")
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
