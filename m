Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86786485056
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiAEJtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiAEJtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:49:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F955C061761;
        Wed,  5 Jan 2022 01:49:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z9so89702555edm.10;
        Wed, 05 Jan 2022 01:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6x4PwvQc1pIjPEUaropE86VL7XAgRF0aYILOjusc2Hs=;
        b=XKFr/kth/8WdOGJepWf6TpLQfbyCFOg5/qCBRo5Fasvpx5ydUNZixVK5EavU/o+x74
         phi+mnAcTQL/ltLs7pCJWw1iv67weKLjPHBPYtIWDED2IM//zgCckf2nbCEXq9lmG48L
         l8Piirx8zbWQR85ezRsGdmv+Ldn1RC9wDxQa6HpgMvjq+OD69KOCNNKUij9r7ySh0fUK
         oR+v7nm0rLIeIa3admbGbJMncNFuLrtu3u5FuXi9LdGVU9d0jOPxJNbR+8RfvMlr/xKm
         WpWnGyoTZ5bfx7TTjJ/++loM196jvCOFX35SgHPrOz+N8Tutxipj1aqai4BjPQfbBTzH
         GZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6x4PwvQc1pIjPEUaropE86VL7XAgRF0aYILOjusc2Hs=;
        b=TRdb2oA2pRcozFPC7JW0MhstEXfhhMLB4bM9opHCPlZJk2Z4BzpUM65yl7B2pUNfiD
         kXRChJ90+cXh9JOSLjTW4DhJQeZj4Pl8cgCyCj0FnP+3lPp8kgy3nJA0AJtlVQfKBBgm
         j6NIl2QRhW+Hle2frSp4POAwXsoat7xa5wEbGkKwjmPjufVqxjt0zMXJ4XpONSi922Jg
         O8KqfDTnXsFA50Hu0RLBI0XuhCJkHC3+2iisiUrYlqcidD7AEllPFJeAnxFqyvdlPlqh
         igBf+SzyAxn3a6QbXs/wXZsB0+nWg2xz6xCMVBNzKlxDvc5lB9Kjfs3DvMKzCvsCjnzj
         DhtA==
X-Gm-Message-State: AOAM532rwQKrEuLrtq3+gIfJmTUqS0y3GQ+i5mBIzxDReIU5WZHgtviI
        pqtFyOJDXGyvh+cGItWwjQaPuUSOdObVe1CB5BQ=
X-Google-Smtp-Source: ABdhPJyQMPAWr47j3se8aGjOEOPyZ1CueVjonTdO81QG7FMKMjgkAxeDBhxNqtJmJnzjplWkJ59l/LVZ/SQPEw1eSIk=
X-Received: by 2002:a05:6402:2ce:: with SMTP id b14mr52898262edx.122.1641376170234;
 Wed, 05 Jan 2022 01:49:30 -0800 (PST)
MIME-Version: 1.0
References: <20220104175009.7029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220104175009.7029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jan 2022 11:48:54 +0200
Message-ID: <CAHp75Vdp1f84MUp01OYHb6HQ8G4zu8bXOQPbkC_xgHVdsYHnNw@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_bcm7271: Fix return error code in case of
 dma_alloc_coherent() failure
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 7:50 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> In case of dma_alloc_coherent() failure return -ENOMEM instead of
> returning -EINVAL.
>
> Fixes: c195438f1e84 ("serial: 8250_bcm7271: Propagate error codes from brcmuart_probe()")

It doesn't fix any issue that needs to be backported.
After dropping that tag,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
>
> This patch applies to -next.

The rule of thumb is to test it against the subsystem thru which you
are routing your patch, in this case you need to use tty-next.

>
> Cheers,
> Prabhakar
> ---
>  drivers/tty/serial/8250/8250_bcm7271.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
> index cc60a7874e8b..9b878d023dac 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -1075,7 +1075,7 @@ static int brcmuart_probe(struct platform_device *pdev)
>                                                    priv->rx_size,
>                                                    &priv->rx_addr, GFP_KERNEL);
>                 if (!priv->rx_bufs) {
> -                       ret = -EINVAL;
> +                       ret = -ENOMEM;
>                         goto err;
>                 }
>                 priv->tx_size = UART_XMIT_SIZE;
> @@ -1083,7 +1083,7 @@ static int brcmuart_probe(struct platform_device *pdev)
>                                                   priv->tx_size,
>                                                   &priv->tx_addr, GFP_KERNEL);
>                 if (!priv->tx_buf) {
> -                       ret = -EINVAL;
> +                       ret = -ENOMEM;
>                         goto err;
>                 }
>         }
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
