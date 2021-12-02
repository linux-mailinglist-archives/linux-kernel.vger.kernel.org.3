Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03496466ABB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbhLBUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348354AbhLBUIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:08:25 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AADC06174A;
        Thu,  2 Dec 2021 12:05:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w1so2580263edc.6;
        Thu, 02 Dec 2021 12:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kll/FcC5dw2T57BuF9qgheNiW8//IfAQCFYPnU8fXnk=;
        b=lcTQaX3zFWsnFUPCv2/i7IglUBYgO5ojuvtBrQ/J7LozFbtYYZ6QJXvj5SKz8uZ8VT
         fIjXJzIPyjeSm9VrTUd8+xqoq5jJXWqof1sszItMAcOc6/D34qTZdNa/jodb9o2VHjES
         tWE5G3fXr8DLle5piIeUF9KKlTXXaQelfRATwXY9DToDTMSnUknmgTABXkbHLvkaSMWn
         O8RYhBJLqmk+K9/H1mjDmrDoUZ0zirJVuIhidbPy5bMllbWAT9+ZIcAkQ9yr3ANU/zPV
         GL7k2ABZMa0d6LOo706nzEYHeTyuGJU2diLM8yHiKe5wVmYkOCRgzg8e84RdHjbNPBRk
         ne9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kll/FcC5dw2T57BuF9qgheNiW8//IfAQCFYPnU8fXnk=;
        b=H6wuZCXwwY8ED5xRStWmSraj0K0iNrCbRk7VthZKLUB0FcTaE7JixQ1zVVFOzCaLSe
         HPILNt+W2+Hvmj1KncXLlCbs0q0I6t33Kea8AMW+N/40ymPpZTRP/SjBZYdV6iHLBgzW
         yLcQ87RO3MzrZ6SG3SfwwSBGE3fP8WU2HcpHBJYtpKVFPBsvoUGJdzx1BgH4F9wshxtD
         oQ6xypofJ1MSZiixbau2CJXsNX15scaFYoQr7JMQXveBMIQKMYdmqP/L7g71FJVeqf2u
         nboTNQhkpm9XDlkEWPHgSFGjSAU+F45SlpzkGWbD5BUOWeH0dHBQQ4ZFHiG+FyBj+qt3
         /nqQ==
X-Gm-Message-State: AOAM532Ex7+DJ5fvFfGw5IVEzyUs8DGnVrtoeV0LXmZVjiMh+E+nd3fg
        6tKwjjAfH7JOzk/FwpHePZDnZKJy4Mmpic/XBD4=
X-Google-Smtp-Source: ABdhPJwD0S+RQajQEVk91EijHu9MsSQiYyktQdtMq/NEVwE2hqeG6bAqz5/y5D3mRhZFz8tgyNhoIN1l9Xj/qscn8Jc=
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr20317491edd.258.1638475500420;
 Thu, 02 Dec 2021 12:05:00 -0800 (PST)
MIME-Version: 1.0
References: <1638355604-24002-1-git-send-email-hammer.hsieh@sunplus.com> <1638355604-24002-3-git-send-email-hammer.hsieh@sunplus.com>
In-Reply-To: <1638355604-24002-3-git-send-email-hammer.hsieh@sunplus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Dec 2021 22:03:24 +0200
Message-ID: <CAHp75VdQYvbDR7kpBF4pJFr-o8WoUADcBpfn6vk2j3zh-KvHdg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, tony.huang@sunplus.com,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 9:35 PM Hammer Hsieh <hammerh0314@gmail.com> wrote:
>
> Add Sunplus SoC UART Driver

...

> +config SERIAL_SUNPLUS
> +       tristate "Sunplus UART support"
> +       depends on OF || COMPILE_TEST
> +       select SERIAL_CORE
> +       help
> +         Select this option if you would like to use Sunplus serial port on
> +         Sunplus SoC SP7021.
> +         If you enable this option, Sunplus serial ports in the system will
> +         be registered as ttySUPx.

What will be the module name in case of module build?

...

> +/*
> + * Sunplus SoC UART driver
> + *
> + * Author: Hammer Hsieh <hammer.hsieh@sunplus.com>

Authors:

> + * Tony Huang <tony.huang@sunplus.com>
> + * Wells Lu <wells.lu@sunplus.com>

And please indent names to be on the same column.

> + */

...

> +#define UART_AUTOSUSPEND_TIMEOUT       3000

Add units to the name.

...

> +static inline u32 sunplus_tx_buf_not_full(struct uart_port *port)
> +{
> +       unsigned int lsr = readl(port->membase + SUP_UART_LSR);
> +
> +       return ((lsr & SUP_UART_LSR_TX) ? SUP_UART_LSR_TX_NOT_FULL : 0);

Too many parentheses. Ditto for all similar cases.

> +}

...

> +       do {
> +               sp_uart_put_char(port, xmit->buf[xmit->tail]);
> +               xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);

"% UART_XMIT_SIZE" is more accurate since it doesn't require a value
to be a power of 2. In case of power of 2 it will be properly
optimized by a compiler.

> +               port->icount.tx++;
> +
> +               if (uart_circ_empty(xmit))
> +                       break;
> +       } while (sunplus_tx_buf_not_full(port));

...

> +       spin_lock_irqsave(&port->lock, flags);

Why irqsave here?

...

> +       if (readl(port->membase + SUP_UART_ISC) & SUP_UART_ISC_RX)
> +               receive_chars(port);
> +
> +       if (readl(port->membase + SUP_UART_ISC) & SUP_UART_ISC_TX)
> +               transmit_chars(port);

Do you really need to perform two I/O against the very same register?

...

> +static int sunplus_startup(struct uart_port *port)
> +{
> +       unsigned int isc;
> +       int ret;

> +#ifdef CONFIG_PM

Why is this ifdeffery around the driver?

> +       if (!uart_console(port)) {
> +               ret = pm_runtime_get_sync(port->dev);
> +               if (ret < 0)
> +                       goto out;
> +       }
> +#endif
> +       ret = request_irq(port->irq, sunplus_uart_irq, 0, "sunplus_uart", port);
> +       if (ret)
> +               return ret;
> +
> +       spin_lock_irq(&port->lock);
> +
> +       isc |= SUP_UART_ISC_RXM;
> +       writel(isc, port->membase + SUP_UART_ISC);
> +
> +       spin_unlock_irq(&port->lock);

> +#ifdef CONFIG_PM
> +       if (!uart_console(port))
> +               pm_runtime_put(port->dev);

Why doesn't it set autosuspend, i.o.w. Why is it different from an error case?

> +       return 0;
> +out:
> +       if (!uart_console(port)) {
> +               pm_runtime_mark_last_busy(port->dev);
> +               pm_runtime_put_autosuspend(port->dev);
> +       }
> +#endif
> +       return 0;
> +}

...

> +static void sunplus_set_termios(struct uart_port *port,
> +                               struct ktermios *termios,
> +                               struct ktermios *oldtermios)
> +{
> +       u32 clk, ext, div, div_l, div_h, baud;
> +       u32 lcr, val;
> +       unsigned long flags;

> +       clk = port->uartclk;

This can be done in the definition block above.

> +       baud = uart_get_baud_rate(port, termios, oldtermios, 0, port->uartclk / 16);
> +
> +       readl_poll_timeout_atomic(port->membase + SUP_UART_LSR, val,
> +                                 (val & SUP_UART_LSR_TXE), 1, 10000);

No error check?

> +       /*
> +        * baud rate = uartclk / ((16 * div[15:0] + 1) + div_ext[3:0])
> +        * get target baud rate and uartclk
> +        * auto calculate div and div_ext
> +        * div_h = (div[15:8] >> 8); div_l = (div_ext[3:0] << 12) + div[7:0]

There is no need to explain the code, please add excerpts from the
data sheet on how the divisors and baud rate are calculated, use
mathematical language, and not programming in the comment.

> +        */
> +       clk += baud >> 1;
> +       div = clk / baud;
> +       ext = div & 0x0F;
> +       div = (div >> 4) - 1;
> +       div_l = (div & 0xFF) | (ext << 12);
> +       div_h = div >> 8;

...

> +static const char *sunplus_type(struct uart_port *port)
> +{
> +       struct sunplus_uart_port *sup = to_sunplus_uart(port);
> +
> +       return sup->port.type == PORT_SUNPLUS ? "sunplus_uart" : NULL;
> +}


What do we achieve with this? Who and how will see this information?
Under which circumstances the port type is not SUNPLUS?

...

> +static void sunplus_release_port(struct uart_port *port)
> +{
> +}
> +
> +static int sunplus_request_port(struct uart_port *port)
> +{
> +       return 0;
> +}

Are these stubs mandatory?

...

> +static void sunplus_config_port(struct uart_port *port, int type)
> +{

> +       if (type & UART_CONFIG_TYPE) {
> +               port->type = PORT_SUNPLUS;
> +               sunplus_request_port(port);
> +       }

if (!(type & ...))
  return;

?

> +}

...

> +static int sunplus_poll_init(struct uart_port *port)
> +{
> +       return 0;
> +}

Why is this stub needed?

...

> +static inline void wait_for_xmitr(struct uart_port *port)
> +{
> +       unsigned int val;
> +
> +       readl_poll_timeout_atomic(port->membase + SUP_UART_LSR, val,
> +                                 (val & SUP_UART_LSR_TX), 1, 10000);

Error handling?
Or explain why it's not needed.

> +}

...

> +       sup->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (!IS_ERR(sup->clk)) {

Instead use devm_clk_get_optional().

> +               ret = clk_prepare_enable(sup->clk);
> +               if (ret)
> +                       return ret;

> +               ret = devm_add_action_or_reset(&pdev->dev,
> +                                              (void(*)(void *))clk_disable_unprepare,
> +                                              sup->clk);

Look at the examples of how other drivers do this (that were submitted
more or less recently).

> +               if (ret)
> +                       return ret;
> +       } else {

> +               if (PTR_ERR(sup->clk) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;

Why?!

> +               return dev_err_probe(&pdev->dev, PTR_ERR(sup->clk), "clk not found\n");
> +       }

...

> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       port->membase = devm_ioremap_resource(&pdev->dev, res);

We have an API that does both at once. Use it.

> +       if (IS_ERR(port->membase))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(port->membase), "membase not found\n");

...

> +       ret = reset_control_deassert(sup->rstc);
> +       if (ret)
> +               return ret;

From here no reset assertion on error? Why?

...

> +#ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
> +       if (pdev->id == 0)
> +               port->cons = &sunplus_uart_console;
> +       sunplus_console_ports[sup->port.line] = sup;
> +#endif

Actually why don't you use register_console() ?

...

> +static struct platform_driver sunplus_uart_platform_driver = {
> +       .probe          = sunplus_uart_probe,
> +       .remove         = sunplus_uart_remove,
> +       .driver = {
> +               .name   = "sunplus_uart",

> +               .of_match_table = of_match_ptr(sp_uart_of_match),

How did you test this when OF=n and COMPILE_TEST=y?
Hint: Compiler will warn about unused variables (you need W=1).

> +               .pm     = &sunplus_uart_pm_ops,
> +       }
> +};

...

> +static void __exit sunplus_uart_exit(void)
> +{
> +       platform_driver_unregister(&sunplus_uart_platform_driver);
> +       uart_unregister_driver(&sunplus_uart_driver);
> +}

> +

Dtop this blank line...

> +module_init(sunplus_uart_init);
> +module_exit(sunplus_uart_exit);

...and attach each of the calls to the implemented function.

...

> +static int __init
> +sunplus_uart_early_setup(struct earlycon_device *dev, const char *opt)
> +{
> +       if (!(dev->port.membase || dev->port.iobase))
> +               return -ENODEV;
> +
> +       dev->con->write = sunplus_uart_early_write;
> +
> +       return 0;
> +}

> +

No blank line.

> +OF_EARLYCON_DECLARE(sunplus_uart, "sunplus,sp7021-uart", sunplus_uart_early_setup);

-- 
With Best Regards,
Andy Shevchenko
