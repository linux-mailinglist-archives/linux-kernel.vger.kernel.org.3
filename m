Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3E146A98D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350818AbhLFVSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350675AbhLFVR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:17:56 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90716C061A83;
        Mon,  6 Dec 2021 13:14:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z5so48854659edd.3;
        Mon, 06 Dec 2021 13:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brgm68BI0DE89Z05ISYE3IUoupNsIG1KMGEftjunI5o=;
        b=aV6y6k24rPw2CJyVM1o2JfsXWGgZNphya9sXdvmgdCHNWEevze2tiXZabbmGi8EIfL
         CTj7dWW7dXh1T9r9yt0N2nIzTEeOBdXYuxtFxoBO8IGj8Ne/Fv64vvWoJy+WItxQKBDQ
         1QT7uJku3XgFjyajlmu6wv6sa2zp5MRNYmEaXUat+KNJoIQlg5Kjz9v6pWYHzlHwE/O1
         mLt3CLkbWWIymOT6iwGGGOb/IFRJBuAGw6crKkGOUr7mTv20KsZFbleEyvxK0GRQUhou
         NvgSkGIXzlw85fmLah+tvtY9VBEFDmcH4WluTGbq1DJw9rEGli5FmadB1yRdbsxo9AXT
         ggFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brgm68BI0DE89Z05ISYE3IUoupNsIG1KMGEftjunI5o=;
        b=VgxuPcnDjERGMNUR0Qdkxl9dS+BX++hXpoJCWb8aBbBcbi2kUfcjwAxJRvaD4XThwE
         KnAIq7kp+r8lmsgqTcUmgupufhTSxPw65liXEX8aEvyXh6HKWYMwjUvZTD4kZeDfzuf8
         5dZUAA3NiBMknG8+9qxwuzVp7maKgaTmQkBcS32OX3VcYON8nDM/WEJTwhfv9WHKtiTY
         jUB/A5aibW7EtdqvN0VD9A0IILSlp+Nq0B7okvnu7LVjQJMrUxPxA4rdJcKslBy0Kf5s
         kBVcmykr/abCWmO1FOaR+on7mrY1QowMXYieJWfvCssvPy8VGkL5K8oy+5z6NJrQdFdb
         uHyA==
X-Gm-Message-State: AOAM533EFzZHs1Pc3U+4GqYfnhNb3KpDYF3KnqEc+Zkp8ZXDIRaqR/ps
        fgtV67zkPeZj0iJVAD8ABAvG6nPF8Z8uVbwPRDnGlQ7naFk=
X-Google-Smtp-Source: ABdhPJw5ibITs718vIr4C+hbrk32Vh1GdlEtCitlT3VL4LyBdRiQQ9tky/A86/h687vsKKgHTtL1oP0JoIiBigaPrLI=
X-Received: by 2002:aa7:d997:: with SMTP id u23mr2455547eds.164.1638825266106;
 Mon, 06 Dec 2021 13:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20211205215846.153703-1-aouledameur@baylibre.com> <20211205215846.153703-4-aouledameur@baylibre.com>
In-Reply-To: <20211205215846.153703-4-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Dec 2021 22:14:15 +0100
Message-ID: <CAFBinCAtuo46FGFoa=pObfuvTq0u7PXJhUpfHd34CCis7T1HQQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] phy: amlogic: meson8b-usb2: fix shared reset
 control use
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     khilman@baylibre.com, p.zabel@pengutronix.de, balbi@kernel.org,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 5, 2021 at 10:59 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Use reset_control_rearm() call if an error occurs in case
> phy_meson8b_usb2_power_on() fails after reset() has been called, or in
> case phy_meson8b_usb2_power_off() is called i.e the resource is no longer
> used and the reset line may be triggered again by other devices.
>
> reset_control_rearm() keeps use of triggered_count sane in the reset
> framework, use of reset_control_reset() on shared reset line should
> be balanced with reset_control_rearm().
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
