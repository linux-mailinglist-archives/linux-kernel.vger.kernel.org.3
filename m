Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB8482967
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 06:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiABFlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 00:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiABFlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 00:41:02 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B491FC061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 21:41:01 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id by39so51014320ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 21:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9BPVOsdEqjOxajqEoJCegalHFCf3/pMHIsfcU5ymJBg=;
        b=f5VQtVdgWJBxHVNjSpPkkwFvOGIQpZeOMrpOLwtPyqAQh2ATfL6Y1fIlA87m7TPWlD
         +bDl0tr8jE46HyO2/g98YM0Nfd5iTyGEfaqibj4jcepqBu44itaFODOfAIRAhaHDm+i8
         enHuSW+sJZtaCrAP+8R5kjL9a+hC49XOLGBHWZ4z30ys/8TLiWXGH+0T9geoeZ++Qq2a
         Q5jV8QkSrUDwyC9DZoE2eTWRpv4w+lzoqxm8QI8ojGZQdwXdg+WhW6DPAK9s6C/2b7Eg
         wnfnpLHVRUMdVgYhgV0Q6XmUOUifFlPT4L4xTojREdKFFkz6hv3/ZpJS4dWyKl6G/2ak
         hVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BPVOsdEqjOxajqEoJCegalHFCf3/pMHIsfcU5ymJBg=;
        b=U6e69gPccVZFdIHLgWSVVjH3hqA6Gtpw/wzmQDRaHn4czP8l+9rL0VEpD4CNQ0FMAK
         sH/ar/RsMM4sX8MnhYM12M4+RzmUpsZo2AT0P5/78NmbzXE8lcJu/C6hun+Tr0jPuLx3
         qsjk95PosbvvhSatI9M6sJUIVGEL/xgQchvhdoZoaPkkRHDSbZ8G2OZh3fZ35qnyEdnP
         pk/rApMM5PczR6LR7MmZN6Ecntp2+no184gcW+pbESMwxMQN1fd0kMgY+rsZAwPrwQJj
         1Tayf9/O9GSnJ91ariRCxPM9VcttW/MGhX1EuXGgVZFG2q8g7wNgjSEHnwTQmpDnlk4G
         58rQ==
X-Gm-Message-State: AOAM532C8V5UpH/Em7NhFkdUqDv3XWxONYMvdkZzaTao7MrojufFtC3X
        rZY7qYZSXgN8qQntY2jhVSDZsPjovZ5RJXm2lRhPIg==
X-Google-Smtp-Source: ABdhPJwlq9o1i1c8yySPLmZXKqgSTy84XHmf+/Wv+oOgBlfYhtIr8GM2itL5v6JvbCXjJqGEJ1ZoeVJEbd3+k/2/yEM=
X-Received: by 2002:a05:651c:623:: with SMTP id k35mr35519889lje.133.1641102060025;
 Sat, 01 Jan 2022 21:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-9-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-9-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 06:40:47 +0100
Message-ID: <CACRpkdZx2Y6aMbOohAoa60GXT8NPg1iyw4+PzUQrs_V8b4=yrA@mail.gmail.com>
Subject: Re: [PATCH 08/34] brcmfmac: of: Fetch Apple properties
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

On Sun, Dec 26, 2021 at 4:37 PM Hector Martin <marcan@marcan.st> wrote:

> On Apple ARM64 platforms, firmware selection requires two properties
> that come from system firmware: the module-instance (aka "island", a
> codename representing a given hardware platform) and the antenna-sku.
>
> The module-instance is hard-coded in per-board DTS files, while the
> antenna-sku is forwarded by our bootloader from the Apple Device Tree
> into the FDT. Grab them from the DT so firmware selection can use
> them.
>
> The module-instance is used to construct a board_type by prepending it
> with "apple,".
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
