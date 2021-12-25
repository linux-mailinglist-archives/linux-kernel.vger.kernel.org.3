Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850F647F33D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 13:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhLYMUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 07:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhLYMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 07:20:29 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF957C061401;
        Sat, 25 Dec 2021 04:20:28 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id w184so10424488ybg.5;
        Sat, 25 Dec 2021 04:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+43WiB59oN0B5WcFMgOGcjPd0Wu8v0DLecWvDIH/vQ=;
        b=n3BgSX3nAAWilH9e7B/C9YVPEMDqLCmUEfnCzSmkMs69CIWikJDr2kQpCN1hTFxG7J
         Ixy/ixvH8AuuS35qJp5sS7UnUXXDSOCRSltfwdpAUb5+KJVZEJl3isscaFMaHMemqhtZ
         nYGqcWT1f8jLaP4TgXUyI80MJ8aTQWHYVXjOGOhHRHQ1No2pICaD2+CSV1Q/k/Ixuz4u
         T2unxA/09w4xaMBoynKprw7Kid+pgUavqvK4StT3kcT5aWgpz6yzBAEDm9qHZ8/rg8+d
         OG+1jxfLBYYpvKpqkQYxAK845w16nMMncmkWm+jmMmODrpctjwWaUO4Wr1l6azbkKvMv
         8wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+43WiB59oN0B5WcFMgOGcjPd0Wu8v0DLecWvDIH/vQ=;
        b=4Pc37TMClqDR/CkYDD0yp1Kc7Fu3ZzJ+6sYrKSgCJLfIb43EE3xxwrpZo21YdoKLE0
         vuabPgN20lDb4giVPp+2K29Qe2vwAA00GrD+fOqUs2CTzRorrLpymJrG4kPKl08uZb11
         P83lQcBjYnDPf+/V/sUv+D3c+S7AlR+6dINZzpI4rhuM+NjQmpX8a41XqOQ76y7XIb4a
         xn+/Wto+KqSZJJZq76j7DU1VymBgt0FkU1durUWLYmkW2NqoiN0tRDl8g/LW9dyTfkfX
         3q0s+LL1qJUvakyvNjAGseOBGZdfr+UOwi7eGdjnNSVtaH0SBdtbI+vgI/QF7le9YGH+
         LYgQ==
X-Gm-Message-State: AOAM532db8DRbaVk7Q7q+B2GXSQPR/pnXbTSPnghfWQy4+X3F5nEcWgy
        qYmEVITx6Cdy+DoYk0fHQ+7+Mi+SZBwXRLof8NCN2UwxWLE=
X-Google-Smtp-Source: ABdhPJzcdV7GXniYR0W2CUYJuOOeSN6ZhrQXe6xy0Q/hpx9II0hPyB6TdnLEJIp+vdXAGX/MSS6C6h5Djftqy5kWJFQ=
X-Received: by 2002:a25:1004:: with SMTP id 4mr13377567ybq.669.1640434828304;
 Sat, 25 Dec 2021 04:20:28 -0800 (PST)
MIME-Version: 1.0
References: <20211224142917.6966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224142917.6966-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75VdC+JifneoYRS3yoXoAhio+TXQzca3pku7ug=A_ewWrsg@mail.gmail.com>
In-Reply-To: <CAHp75VdC+JifneoYRS3yoXoAhio+TXQzca3pku7ug=A_ewWrsg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Dec 2021 12:20:02 +0000
Message-ID: <CA+V-a8tzcCtnD9GDm8g+-84tKAdcPaj3Qy0s=vJmn5qMxLp=3g@mail.gmail.com>
Subject: Re: [PATCH 03/10] serial: 8250_bcm7271: Propagate error codes from brcmuart_probe()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for the review.

On Sat, Dec 25, 2021 at 11:20 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Friday, December 24, 2021, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>>
>> In case of failures brcmuart_probe() always returned -ENODEV, this
>> isn't correct for example platform_get_irq_byname() may return
>> -EPROBE_DEFER to handle such cases propagate error codes in
>> brcmuart_probe() in case of failures.
>>
>> Fixes: 41a469482de25 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> ---
>>  drivers/tty/serial/8250/8250_bcm7271.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
>> index 7ecfcc650d28..cc60a7874e8b 100644
>> --- a/drivers/tty/serial/8250/8250_bcm7271.c
>> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
>> @@ -1074,14 +1074,18 @@ static int brcmuart_probe(struct platform_device *pdev)
>>                 priv->rx_bufs = dma_alloc_coherent(dev,
>>                                                    priv->rx_size,
>>                                                    &priv->rx_addr, GFP_KERNEL);
>> -               if (!priv->rx_bufs)
>> +               if (!priv->rx_bufs) {
>> +                       ret = -EINVAL;
>
>
>
> For memory allocation we usually return -ENOMEM.
>
Agreed, will fix that.

Cheers,
Prabhakar
>>
>>                         goto err;
>> +               }
>>                 priv->tx_size = UART_XMIT_SIZE;
>>                 priv->tx_buf = dma_alloc_coherent(dev,
>>                                                   priv->tx_size,
>>                                                   &priv->tx_addr, GFP_KERNEL);
>> -               if (!priv->tx_buf)
>> +               if (!priv->tx_buf) {
>> +                       ret = -EINVAL;
>>                         goto err;
>> +               }
>>         }
>>
>>         ret = serial8250_register_8250_port(&up);
>> @@ -1095,6 +1099,7 @@ static int brcmuart_probe(struct platform_device *pdev)
>>         if (priv->dma_enabled) {
>>                 dma_irq = platform_get_irq_byname(pdev,  "dma");
>>                 if (dma_irq < 0) {
>> +                       ret = dma_irq;
>>                         dev_err(dev, "no IRQ resource info\n");
>>                         goto err1;
>>                 }
>> @@ -1114,7 +1119,7 @@ static int brcmuart_probe(struct platform_device *pdev)
>>  err:
>>         brcmuart_free_bufs(dev, priv);
>>         brcmuart_arbitration(priv, 0);
>> -       return -ENODEV;
>> +       return ret;
>>  }
>>
>>  static int brcmuart_remove(struct platform_device *pdev)
>> --
>> 2.17.1
>>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
