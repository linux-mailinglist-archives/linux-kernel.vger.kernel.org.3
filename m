Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5EA4820D2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 00:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbhL3XNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 18:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhL3XNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 18:13:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8251FC061574;
        Thu, 30 Dec 2021 15:13:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m21so104420308edc.0;
        Thu, 30 Dec 2021 15:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjS3WKP5qJV4EDilsIZw+xVU+rDXRT31OPDC34vv2uI=;
        b=Y07RmJGr6NZBTjFC//bhbEjk+UhhWpNPddiGau7tN3tcFkHbtGr+o1fPe4V6nB8thD
         +E2ahByORD/7KewpDKmG8Bqgz2i4v0Jgid4wQ9MWFk/uKZ8/dj+yH9zpAff381qey49V
         Xt1inaa+QOLdykM7etsTPLWUX8OUS4JUjZihy+kNo35MS/mR8wDNFQKrbrXXC09q5tin
         65mJjwVw+EUPQRrqckyRVMj8u/qQxpgAcsMvXqwv0uyB2GG69CNrPSfLJllt87faddGR
         QGiIx4I9c8OAxOUy7HGWKoLHxFPeKiiMVIQV5bT7dLV8a3yURWnKfmFt+jIcxZEHBnSn
         zppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjS3WKP5qJV4EDilsIZw+xVU+rDXRT31OPDC34vv2uI=;
        b=hayo3pvBXQ0Sb0FgJRKyTF4IcEazrktw6DCt34UYsvHKlgWptlyZUL1Ikx5mIR5ErI
         D95ovvZycr9duyaCY1U+HUyDWRvN8Yn3utpqn9Nd1xNBiYhkmY1jiVrdERz0e71llwZC
         fOQMi/0cSsV5uAlNLZyWbI89Oel5NResh7XUMODxz+bZ4adAmoLcRB89tRmIqpHFln7c
         AKJ3YBhNqsK6TLh1X66pNrtX3C5DtXIApQCTZxVDn8Pt8IQF1QMdKrbeY0/AZPZsHriA
         YBD3OesBKo4/uOMk5znM9ksrXTarnZenRwIeIs7LxEH+k+Ed0Ars5Ht1XYIwL3ojqapK
         R8iQ==
X-Gm-Message-State: AOAM53358DdkCR5UYG7yU9z5ZZFv0i1RdKKpEl5GChBxOLeLjkUzIH3z
        pON43KgZFUKSwqsJFmpJ0v3IzpO+fzN9hoVInKFcyEExtjk=
X-Google-Smtp-Source: ABdhPJxBvPIVBgX5cxzud69fvSHeIG189+MSK3hCBdSdcNGtK0h/eCppV761qa/XMsD0MuRHo7R/XrhfEvxvez1M1UI=
X-Received: by 2002:a05:6402:1b9c:: with SMTP id cc28mr31790799edb.219.1640906026806;
 Thu, 30 Dec 2021 15:13:46 -0800 (PST)
MIME-Version: 1.0
References: <20211230102110.3861-1-yu.tu@amlogic.com> <20211230102110.3861-5-yu.tu@amlogic.com>
In-Reply-To: <20211230102110.3861-5-yu.tu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 31 Dec 2021 00:13:36 +0100
Message-ID: <CAFBinCCL-QaeSRCLzfyNXcRQZ7YC1D85rP2y4OGkAjCmQEqGgQ@mail.gmail.com>
Subject: Re: [PATCH V3 4/6] tty: serial: meson: The UART baud rate calculation
 is described using the common clock code. Also added S4 chip uart Compatible.
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:21 AM Yu Tu <yu.tu@amlogic.com> wrote:
[...]
> @@ -270,14 +284,11 @@ static void meson_uart_reset(struct uart_port *port)
>  static int meson_uart_startup(struct uart_port *port)
>  {
>         u32 val;
> -       int ret = 0;
> +       int ret;
>
> -       val = readl(port->membase + AML_UART_CONTROL);
> -       val |= AML_UART_CLEAR_ERR;
> -       writel(val, port->membase + AML_UART_CONTROL);
> -       val &= ~AML_UART_CLEAR_ERR;
> -       writel(val, port->membase + AML_UART_CONTROL);
> +       meson_uart_reset(port);
I suggest splitting this into a separate patch. In general I think
it's a good idea to re-use meson_uart_reset here if possible.
However, if during testing it turns out that this doesn't work then we
can revert this single patch which updates meson_uart_startup() only -
instead of reverting the whole transition to the common clock
framework.

[...]
>  static int meson_uart_request_port(struct uart_port *port)
>  {
> +       struct meson_uart_data *private_data = port->private_data;
> +       int ret;
> +
> +       ret = clk_prepare_enable(private_data->pclk);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(private_data->baud_clk);
> +       if (ret) {
> +               clk_disable_unprepare(private_data->pclk);
> +               return ret;
> +       }
This code is from my original suggestion - and I had a doubt there
which I forgot to add as a comment originally:
Can you confirm that accessing the UART controller registers works
even when "pclk" is turned off?
I am asking this because the common clock framework can access the
clocks at any time.
And I have seen SoCs which would hang when trying to access a module's
registers while the module's pclk is turned off.

[...]
>         port->fifosize = 64;
commit 27d44e05d7b85d ("tty: serial: meson: retrieve port FIFO size
from DT") [0] from May 2021 has changed this line to:
  port->fifosize = fifosize;
So your patch currently does not apply to linux-next (or even Linus'
mainline tree).

[...]
>  static const struct of_device_id meson_uart_dt_match[] = {
> -       { .compatible = "amlogic,meson6-uart" },
> -       { .compatible = "amlogic,meson8-uart" },
> -       { .compatible = "amlogic,meson8b-uart" },
> -       { .compatible = "amlogic,meson-gx-uart" },
> +       {
> +               .compatible = "amlogic,meson6-uart",
> +               .data = (void *)false,
> +       },
> +       {
> +               .compatible = "amlogic,meson8-uart",
> +               .data = (void *)false,
> +       },
> +       {
> +               .compatible = "amlogic,meson8b-uart",
> +               .data = (void *)false,
> +       },
> +       {
> +               .compatible = "amlogic,meson-gxbb-uart",
> +               .data = (void *)false,
> +       },
> +       {
> +               .compatible = "amlogic,meson-gxl-uart",
> +               .data = (void *)true,
> +       },
> +       {
> +               .compatible = "amlogic,meson-g12a-uart",
> +               .data = (void *)true,
> +       },
> +       {
> +               .compatible = "amlogic,meson-s4-uart",
> +               .data = (void *)true,
> +       },
> +       /*
> +        * deprecated, don't use anymore because it doesn't differentiate
> +        * between GXBB and GXL which have different revisions of the UART IP.
> +        */
> +       {
> +               .compatible = "amlogic,meson-gx-uart",
> +               .data = (void *)false,
> +       },
For this change I think it's also best to split it into separate
changes, similar to the dt-bindings:
1) deprecate and replace "amlogic,meson-gx-uart"
2) another one to add the S4 compatible string
3) and a third one with the big common clock framework change (adding
the .data attributes)

This is about the "Separate each logical change into a separate patch"
rule from the Linux kernel patch submission guide [1]
Also I hope that it will make it (at least a bit) easier for others to
also review this patch.


Best regards,
Martin


[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/tty/serial/meson_uart.c?id=27d44e05d7b85d9d4cfe0a3c0663ea49752ece93
[1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#separate-your-changes
