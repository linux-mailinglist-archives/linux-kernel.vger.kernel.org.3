Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB0D4829FF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 07:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiABGNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 01:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiABGN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 01:13:28 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F21C06173F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 22:13:28 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id h21so39143705ljh.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 22:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQZLwT+w1+Y2g2ul+2mg6iUoYfiNjzZt86lCdfnWPtA=;
        b=AW/ZNbPSLW468zW/twl9o/cgXt0oE2gt8F4kyzPQGwiulKCrpOaWwAM0cyUJ1FPKJk
         A6QNbIDZTy9H6jycg5ZpeCoAvVEmfyIIjdo3JyNI2Bhc+9jijMoFpYbDWad9ao1nxGzv
         l2D6ltASDWxaZJpXCGXEYIRszLKvpLrBVLODpBTSIWex436szk5LoV/gKPejKrDnng1z
         4BI5m2do8sdvrhOCT7NxgfYh1xc9b0e0LKCI6S7MtVpl6KHt977Da09LB2yfTeDOrSL6
         UEMNeDcgaXkmkUG3wWnTXp3OHn23qojCG9T0srXLdJc4wmrqdKZafnFL67r2CQFmmMiN
         BtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQZLwT+w1+Y2g2ul+2mg6iUoYfiNjzZt86lCdfnWPtA=;
        b=JQjHt7fCEe6YCipg/weeeOT5I9GiWz5qYtOUky9HmaGMVhai7XSlRpLcRcPbbG6btj
         QeUT+rj9UqKFKNJbFNlidHsTBxXzXoOGJmp0ekIXkIARcGOR6QTfI2l/gbVOl45L+VRK
         R9NZ8k+hnKz7YYZPDEdqLNhsjcI7F2N9JYQjDQj/nYj7+GxQFpwVAXqGKyc/L3G6Za25
         iOr/RSraz6zzZn0ihnZ/T/GngSCbCVYa4x7z3V9jIywDkikiVBLXxa527GYmzz51VXjw
         2Ihzjxkq7hvag5bs9pbbFb/cLHkNy2cjkYI6G+wJl5z/9k3bYunq7iJMax2nZrqrmBTI
         GDZg==
X-Gm-Message-State: AOAM533LA4YL5P1i9d5woDa+2uwMLvA+I0Lu2amoUJ/vx0qmCrThAbN8
        nqV6e9sI9hQmi0Zkp8UCyBctBZVrtqK5X6ggM1n0vw==
X-Google-Smtp-Source: ABdhPJxM2f7u0RlwdZkYufWQhioNOnTnjJqHgjzjatwX6cpu+GxEYVnS/6kGtZs3QlqQ09MrlhCLnoOvUxy7A8YmozA=
X-Received: by 2002:a05:651c:623:: with SMTP id k35mr35568925lje.133.1641104006495;
 Sat, 01 Jan 2022 22:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-27-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-27-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:13:13 +0100
Message-ID: <CACRpkdZ4w1Ftq+UcpmYVzcESG-2tJTkUs8RViqRPv9EKmL4NLg@mail.gmail.com>
Subject: Re: [PATCH 26/34] brcmfmac: cfg80211: Pass the PMK in binary instead
 of hex
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

> Apparently the hex passphrase mechanism does not work on newer
> chips/firmware (e.g. BCM4387). It seems there was a simple way of
> passing it in binary all along, so use that and avoid the hexification.
>
> OpenBSD has been doing it like this from the beginning, so this should
> work on all chips.
>
> Also clear the structure before setting the PMK. This was leaking
> uninitialized stack contents to the device.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
