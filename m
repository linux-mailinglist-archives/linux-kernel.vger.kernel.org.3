Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA5B471D05
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 21:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhLLUpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 15:45:24 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38424 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhLLUpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 15:45:23 -0500
Received: by mail-ed1-f54.google.com with SMTP id x10so28661802edd.5;
        Sun, 12 Dec 2021 12:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXgQgWZOt5Lcd8tcpSKbzedZtLgdrih2cq1/keXFtPE=;
        b=L7nAQLMJOL6Hq5grsZF2AlyaDdFjp4lq/O6Zic2EMxi0260c8TvRhC7fHhco/k/jgT
         sWOiiaRamLrRQxLqRcRPmm3i1iV4+HdxvKWgrZX94jXQFX/LLitz6mIPm3kFf0HFa9GM
         GGZC5ePi7UyU5L/KFa6J1TeLcBgqB7INckcVgZJoslWTIcNrmyPzAWEgNR86B0+ZTne1
         cUU65FfwSkv0j82+cGXV4AnS7CeC9rltDfyWxdmZ5UFqpZCaZTpdXHAaaCEt6obiDVcj
         FS2kh6tYKcSLUzsXQX09T9RCDrGPwKLbhtUXzE+SKIzle3PmF7ZRCZ60La8mQsb5PKRc
         M7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXgQgWZOt5Lcd8tcpSKbzedZtLgdrih2cq1/keXFtPE=;
        b=l2EnHpEvUxnWT7627FlWGfXMKNPMHDh0U9hYHJwUOO9UizITAI2C4949IPJ0q26vUw
         Y9/1raLv/rXSkJjBjRxHHmpTdQ2y5Ht8DW9KC8xu15wGvNvGU0uDzClIfP7pE09jF5PO
         qpLGVSjV4C7oKcunQ1fpwyxGi4XQbkIQhNH3pUrC9BZHfHxial3sEi81MPqHePpj8pD8
         FgJvKkRtYw9LkC1p2XjbDOvroHdOgIIv/tE4/jfCPUYqtUtJKKM5xdBpdnoEn7ZbIFwe
         1PvhFeJUc0jD4w+ybBSMS3avr9Z+FFdmRFio3ZWAexrD9dFXcpEkW1lbuXR7f1Lum2qv
         DBgw==
X-Gm-Message-State: AOAM532PZTBV4uvkwjpeBpCBtQ0/4959/l7uG+bucCufX1exWuW7Zihw
        Qx36bchcARhOi0BGY6I/gz8D+VQw51wdL3cOYAY=
X-Google-Smtp-Source: ABdhPJzd9TJQxEj/IUeKFluoqBBNCf+I+jyNuTmqEgQoBDo5oMC03OGm1ZEbULxErDuYoX+13MJUJIn2b4UjzQ+DZtk=
X-Received: by 2002:a17:907:75d3:: with SMTP id jl19mr39883954ejc.520.1639341862137;
 Sun, 12 Dec 2021 12:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20211212201844.114949-1-aouledameur@baylibre.com> <20211212201844.114949-2-aouledameur@baylibre.com>
In-Reply-To: <20211212201844.114949-2-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 12 Dec 2021 21:44:11 +0100
Message-ID: <CAFBinCDZw2Zxj5U_x8=EOmh1DX22vVbLwyDHvOYkLiSmuY7YDw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] phy: amlogic: phy-meson-gxl-usb2: fix shared reset
 controller use
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     khilman@baylibre.com, p.zabel@pengutronix.de, balbi@kernel.org,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 9:20 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Use reset_control_rearm() call if an error occurs in case
> phy_meson_gxl_usb2_init() fails after reset() has been called ; or in case
> phy_meson_gxl_usb2_exit() is called i.e the resource is no longer used
> and the reset line may be triggered again by other devices.
>
> reset_control_rearm() keeps use of triggered_count sane in the reset
> framework. Therefore, use of reset_control_reset() on shared reset line
> should be balanced with reset_control_rearm().
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
