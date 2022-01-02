Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA0B4829B7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 06:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiABFwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 00:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiABFwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 00:52:03 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1557C06173E
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 21:52:02 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u22so50961022lju.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 21:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1IdkO2v3WWPYSUTncvDnfGDMDrfABtHyJ12lBtRt4A=;
        b=wDPn0Jr+i3Ne3uIfUMRrc8qtDSm3mBZfR4pC/cTBiQ5xoFgztpIkqZE0aoMSWL9CYM
         p4empsBUWq+plhKvwpWgg1psHX4gHau9FVaXoOrzVCDiQqIL0ecOMx5kNHBMWD/tzoKp
         s+CYL0Qz7pVSkPyVn7ui/EuafYsSDUAodi63H145X98ARPys1LR/H2YAQ9ZA8zRy5ZZV
         B8SMHR+rk9xm9TzIGdveVWHO1vtVb4wsf6WXaWtOyhev38qygrVRNprhkiSpjkSA8PlV
         26trSfYiYZGfE0+NYotRn+hrXSiykF763+t+fzNBLCdtjcdkFWwLFFrCcYYHLelEZuCg
         dhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1IdkO2v3WWPYSUTncvDnfGDMDrfABtHyJ12lBtRt4A=;
        b=wTt+RhULxN7TCCzoUfSUe1wmSG7Y/c/ahlY8FCJ1QItpgvzwV2B+lw7dkjY1m61SLk
         lgfSl3xDO79wCSKexzQV3GNe4Ikho6seRqJx2RAjNwdGA1lSFs9/Jm7czXrql6yl0he2
         +0dadSM9RqclTuXLk693mM04Th/gyYT3fFTJ0KnyhDvyHaNvrdpDylK5pMBLH9jxh88+
         kHBWYAa/wqgonX7FaZTjdLi68bohiS2TQ309tW3e4e503XTSLNWP1LD+acK1gxUPhXAk
         zmwa5H81nP3fg2QiSTRqpIKDkXidAWwGhbhAEf7xIYXHRDH5iUr/b103jAQ3MY7cfzL4
         +i9g==
X-Gm-Message-State: AOAM531W+ST8sfIsB8AxiKYeK/wtzSi0GmwWdDbNkx0Okb74Epg55ouI
        YYfp0xrGqkM93Yj+RYnSFyhFg3USjY0YuGG+/FmhbQ==
X-Google-Smtp-Source: ABdhPJz3850HYLW8wxEtlvPJb84T9SqXhem/mi/73BSeo5E7P0JHUZBkParKaPmI6AIp8XQ33Vb7i+PVLJ6RLVAtbBE=
X-Received: by 2002:a2e:b808:: with SMTP id u8mr24141804ljo.282.1641102721114;
 Sat, 01 Jan 2022 21:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-13-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-13-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 06:51:49 +0100
Message-ID: <CACRpkdYZUBjOG-kW4Gj4HfzvQySsjpU_h8+mzywwFHxMCuHUYQ@mail.gmail.com>
Subject: Re: [PATCH 12/34] brcmfmac: pcie: Fix crashes due to early IRQs
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

> The driver was enabling IRQs before the message processing was
> initialized. This could cause IRQs to come in too early and crash the
> driver. Instead, move the IRQ enable and hostready to a bus preinit
> function, at which point everything is properly initialized.
>
> Fixes: 9e37f045d5e7 ("brcmfmac: Adding PCIe bus layer support.")
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
