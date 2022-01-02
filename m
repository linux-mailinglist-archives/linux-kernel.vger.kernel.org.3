Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379BD4829F4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 07:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiABGLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 01:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiABGLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 01:11:49 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779CAC061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 22:11:48 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id v15so51273610ljc.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 22:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLYs6RPdlYoNdW+4UL3boVj/wZ9DVO7dQZSS21vPQg8=;
        b=k1AOt9g7ctt0LaNkr2kqTxIjq3+DWOMbt5ZOTBEJA6LntouCvz3cYAhESGIrt+jF0n
         ThCPNtuYU7nqQ93Bv0wFNIvD4gbfeV0LShkAxf5Pr0L5cPrKs2+YInUWDDQu7k7SJ5p6
         dW8xprCt6mIhj1AUY+0jhZHcBb5vkt7Q955Netg7siEtQuDgaeEx8X8gGl62VSvtVW2N
         gBkrprBk9ggy11Y8xjCLCx2NbSC3yW+m+PUtZyybJOs9RAu1Jw0ErbEyapVGNta+aa2K
         zhHVlyN89pAO2JUBqUUrUym51c9J7skKnHoo0d0iNNhQOeAFJzN5W29j3j0hQ7FocYqU
         wI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLYs6RPdlYoNdW+4UL3boVj/wZ9DVO7dQZSS21vPQg8=;
        b=I/s/bkVjGdKtwJJi21CvZXbvMLV9Rn6FeTwpPh/jIdGh9C6J850usOeVBa9qO996hY
         fOwCH7+R7758ca99XFAZbr18b6pZNMExMx92sedbGDl3XFE7hY/uHv8ZJFcsolIykmnL
         m+8lO7OHe0tqpVsJlfcHtclIZbpELo6xsbKdgC793tjqwMA+dtC9Jwla0E4vVxIvT+uB
         Ke/6/QH+CQyrqxDy88XBx/tqgLr438/Bps0TK0vKHQYtvvS+ab0vcHo6tu5UMHsMKGxJ
         YA87mB9ZMTE5gPWEQKlRrq1nAG6odsEY5ORcTziKISb98+7x07ZN4koZ9FMLEcFc9wiL
         1AAQ==
X-Gm-Message-State: AOAM533C5M30xe2szm8XQaktb/UznL8OxGI0AWhe+ozktcvq7Uu6hBIw
        cykjwVWQ6j2jEL8FHMDExl8vjZxr1uYeadJEGw//vA==
X-Google-Smtp-Source: ABdhPJwgIObPmwk+diSjYih9QUhroCYQGoR5YghpXUjDlvzhjBXtDoMBCB6FepG9wKcYRFCuczmvG4SeU5CjPd2DRiI=
X-Received: by 2002:a2e:7c01:: with SMTP id x1mr33723616ljc.145.1641103906802;
 Sat, 01 Jan 2022 22:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-25-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-25-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:11:34 +0100
Message-ID: <CACRpkdZJnXhzDRhZt97Svf5pU5T_Xc2mfxFFnibNda7JJ8fiFQ@mail.gmail.com>
Subject: Re: [PATCH 24/34] brcmfmac: feature: Add support for setting feats
 based on WLC version
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

On Sun, Dec 26, 2021 at 4:39 PM Hector Martin <marcan@marcan.st> wrote:

> The "wlc_ver" iovar returns information on the WLC and EPI versions.
> This can be used to determine whether the PMKID_V2 and _V3 features are
> supported.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
