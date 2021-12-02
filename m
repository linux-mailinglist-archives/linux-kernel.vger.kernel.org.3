Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F8465BCC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 02:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347426AbhLBBum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 20:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347291AbhLBBug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 20:50:36 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356D8C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:47:15 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso37934778otr.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 17:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oAq/6yqP+Rs00XBfo1g1KbQwNm45N3/d0cp7dLPBOg4=;
        b=ig+aiqr1KC3nRxcqO696YtpJY+3ph1C4OHtQX+Rw204KfgFTnZ7T9mJQPx9fjuMs4I
         wCiy+KFi6WMFU66ZTJdEP+U2sch0WKL/QhJLuH9TVhLN2UMvkoU9oUtMXW8+RsctrgOg
         z0lGMt/XwaIljHbhdYZ5xOgoHdt+CmiQxtYc1Ug2MLfuhOSfpKMN8Ot5EwV7iq9j82Ki
         jiuigdesuFHxYRWpEE7KCIbD/Z0+0Jo9yeima6lE6tWnYhC6IOM736ihNW7/lnamwiaf
         xiq+Wn9/kmVPZtQTwTHT7Y62gvRc9fd5g4TykiteffupHusT5LrCuoEh3Si0/3iyp7z+
         0zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAq/6yqP+Rs00XBfo1g1KbQwNm45N3/d0cp7dLPBOg4=;
        b=bnrwQOIeiPKe8PJrC1NJzY6scG0z75H8EI2N1opK4QjBAPrbCMEcdzsKdNoKewooRF
         u/QMaMRSpNKHU9vckoK6JgcPfIemtMOs7ddPSATcSebhhaMze3J4CW6RSiRdwPqZRo0J
         cDW4039ISf+Ur4Uv1/RlkBu6zS7TQ/5DfbytHYaGWpn7DMOlX8KAcNm0u0rEdpDNALKm
         6uw5SzLbX+Tnui7E3AYnvSVpE4WWWk0FjkkodS7WpuXz52NTRvoPBSmx2xf7lr4EK/Qq
         vbMQcNNe20Tm1sQunSaLgnLPRPipethPhJ4oPaQBUhHou+ZeOslG9RZkAPY5sjXJAOFk
         Q68g==
X-Gm-Message-State: AOAM531enijXxMKZ5oMmxrPgpSFLuW/G0J3GyNDiS+GoRCYqJJGFpFAE
        REj08s1MkaSduDFt7PvXzNOBoCi0JZ2BI7p+eYgZbw==
X-Google-Smtp-Source: ABdhPJxu/7Clco3SFiGJPXWgXj5k3rEQqe7phGhKHjJYymefXn8zHnSpG9SDKu6GGDk6D20yFG3in2eRs0XWKWhlMJg=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr9375658otg.179.1638409634547;
 Wed, 01 Dec 2021 17:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20211129153330.37719-1-nbd@nbd.name> <20211129153330.37719-13-nbd@nbd.name>
In-Reply-To: <20211129153330.37719-13-nbd@nbd.name>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Dec 2021 02:47:02 +0100
Message-ID: <CACRpkdacgoT-K4qZoBpMx8RiPcvOf=YmrTP36LKyizcQk+VyUQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] gpio: Add support for Airoha EN7523 GPIO controller
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, john@phrozen.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felix!

Thanks for your patch!

On Mon, Nov 29, 2021 at 4:54 PM Felix Fietkau <nbd@nbd.name> wrote:

> From: John Crispin <john@phrozen.org>
>
> Airoha's GPIO controller on their ARM EN7523 SoCs consists of two banks of 32
> GPIOs. Each instance in DT is for an single bank.
>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

(...)
> +config GPIO_EN7523
> +       tristate "Airoha GPIO support"
> +       depends on ARCH_AIROHA
> +       default ARCH_AIROHA
> +       select GPIO_GENERIC

Yes that looks applicable, but why isn't it used?

The few 32-bit registers look like an ideal candidate for
using the generic GPIO. Check similar drivers such as
drivers/gpio/gpio-ftgpio010.c and how it uses
bgpio_init() and the nice doc for bgpio_init() in
drivers/gpio/gpio-mmio.c.

If it's not working already with generic GPIO I do not
think it would be far fetched to fix it.

Yours,
Linus Walleij
