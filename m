Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5674829EC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 07:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiABGD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 01:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiABGD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 01:03:28 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5145AC061746
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 22:03:28 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bp20so68502603lfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 22:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOSEt2UYspkO7KlpH0taqWCjFFVAh5LxlRawNiLoSCA=;
        b=tGCb3hDZ09NPFPr6FT12MbJtVURDBtkxRXV2FAUpIK+IdsXRbxxLlxD5RF8xeHOlEc
         rdmSfOvohYAfAqnQntjwxXcMrg8fpekXTKeiEFtU+MjoWUpWzrz6GxsLS2PcAK2OmQEy
         YumzH+DZG7mHqw7l6y3F2G18Ru+zT6NqLuwsAIkADGyZ4dRhzF7YoWyMV5/9RlP8Nu+b
         z51JezLya73SyPTWGXQTVea/ARxo88mAjh5xPmHLM3Y+UnVUeA3Ir/OY3xosGv89OQP1
         vyZohRjymVa7nmmoZKQUluLyyA9P0Wnp6d0ZturGsebk89CRpkHYtSDzYi333r+AjIv+
         uUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOSEt2UYspkO7KlpH0taqWCjFFVAh5LxlRawNiLoSCA=;
        b=4YH83PNX55UCqr8Od7lk7lYjKIbVeBQsgHGX4KBQJIa3NjuGnZaD1VsaYQH62/78Fh
         1YNqXK/98tPOLcwrSg1mAYpacaDUzsjD5O4m1KbZI3ydj6WcYT9hNcBftv+0g2dWz9X6
         in+y6KxxwGW1F/GWsk37i2AFxVupGPX6KZO5TFxJ/zTCInVxpt5FWpgJAugrqX1DiWea
         heVck0jZs0P4kOoT8dUiu1wn/CMbxrvh5p+ln5JRLBoA5XSCZK8EXRdqth7EtdR6FLbQ
         a88Q8D8xYIYJDayUN3JHol7OYbgegCPX92MHPJLVfogwCgPwMleHMD2jzUm6SET0g09N
         AC2w==
X-Gm-Message-State: AOAM533biQz8oTlZ6DG763F/SUV45nmx6byEbzVzDGmYyBSVhdHwmnDI
        T+PqQcY+xVYgDhgapXNFdpA0GrdkCNhGOdnqTUDZ9w==
X-Google-Smtp-Source: ABdhPJyUsJK/0aqdGyEKpwuU7vg2NlhR00lEWpxX20MF2aZZkZEtuybziC46nnAcrr7lYQhYJfFsFAUfCpx4oTaGd/A=
X-Received: by 2002:a05:6512:2303:: with SMTP id o3mr36790809lfu.362.1641103406623;
 Sat, 01 Jan 2022 22:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-22-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-22-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:03:14 +0100
Message-ID: <CACRpkdaPwG7gQd6Zk81NH_u2ZzPA8=33kCThm+SPn_fywBm6AQ@mail.gmail.com>
Subject: Re: [PATCH 21/34] brcmfmac: chip: Only disable D11 cores; handle an
 arbitrary number
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

> At least on BCM4387, the D11 cores are held in reset on cold startup and
> firmware expects to release reset itself. Just assert reset here and let
> firmware deassert it. Premature deassertion results in the firmware
> failing to initialize properly some of the time, with strange AXI bus
> errors.
>
> Also, BCM4387 has 3 cores, up from 2. The logic for handling that is in
> brcmf_chip_ai_resetcore(), but since we aren't using that any more, just
> handle it here.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
