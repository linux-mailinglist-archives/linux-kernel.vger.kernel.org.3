Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E4C482490
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 16:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhLaPc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 10:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLaPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 10:32:59 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20BCC061574;
        Fri, 31 Dec 2021 07:32:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z9so39988362edm.10;
        Fri, 31 Dec 2021 07:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VysC3BYXJYli8788JzEtZNXjhfyXYrLxhWoo/L00x/E=;
        b=A5uw6B+NLxc54AYITgqbaMurE9BkhaMQycGBQ+64od14Ko3v4KZQ0LBEARMrOY0WWq
         BX4Q9tVxPWvGMEq69UVdh/66w0MXgK2hFrCDKomg3HJsqW2FZq+8fH7p2y248KmEq635
         DF816PiLjuuOdI+pRjldBagq752gNBnP52rVgUuOt7J2gOa62B8wis3gfhNryBDZZ4yY
         WvdvrumpkRfLRm/f20fzTrw2D2jLfZM+twPVLcjI0J1tCHQiOw+x1/osk0JkRLbbk6ta
         Dg1Kz5LCGrQyBm1xSY1jchqnFpAttMGxP9HtxH8YvMX2lFQv0oTG0YA+jtbhEOpPro+z
         Z8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VysC3BYXJYli8788JzEtZNXjhfyXYrLxhWoo/L00x/E=;
        b=iNMMhDfi3FLkm/YfL64i8nO8Y9VShw7y4DCYcmXUJQXInkF5VAf3j2Sc29IEkPeqXK
         D1RPkkLNrcOS0CLtGuSZEidQdlZsVKbxA+lNmK8u+f8h4mqnya6+SvOYHc6DVU/5eSOp
         +7L/XWBHxjtFEYXtxSXHgOSMBuaIU1YI4RNRipLq1B5bTnH7t6ATrB49o3DHWWjI6NS+
         JysqBHd99whqSoADQVRtgWaSd1wmp3dNy2DGs+ZfziC3C61KP9iLeQO1pUk0h1oHzLIy
         Ey66vC+vPp6CuX6Bc/le18nCtv3f0nu7OEW5Ifn08N4FE7naZ465h4M53BEiZgZ09DxT
         hdow==
X-Gm-Message-State: AOAM532RpLNU7hk17dXmViRKPQK6OaT4ot+7WpkoG4kHApToqu4dwXsN
        rJe66evu2oMaW7mwQQaKVXHk04l5MX7gWwBZm6o=
X-Google-Smtp-Source: ABdhPJwwyGmCRzsWC1+J5FYszmJ9Zjgj16AmXBvLzezgiA1gx+LbEMKOekxvjbgJhjN/PIHipJwl0+Zy8IHnasqVFB8=
X-Received: by 2002:a50:eacb:: with SMTP id u11mr35038865edp.290.1640964777172;
 Fri, 31 Dec 2021 07:32:57 -0800 (PST)
MIME-Version: 1.0
References: <20211230102110.3861-1-yu.tu@amlogic.com> <20211230102110.3861-5-yu.tu@amlogic.com>
 <CAFBinCCL-QaeSRCLzfyNXcRQZ7YC1D85rP2y4OGkAjCmQEqGgQ@mail.gmail.com> <3e1e40aa-7865-0f7a-5772-e2ad96c8141d@amlogic.com>
In-Reply-To: <3e1e40aa-7865-0f7a-5772-e2ad96c8141d@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 31 Dec 2021 16:32:46 +0100
Message-ID: <CAFBinCB2nF0TwRE1uJ4UTB_avcqRBfOHR1CDSe29dB1o-YjEHQ@mail.gmail.com>
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

On Fri, Dec 31, 2021 at 12:24 PM Yu Tu <yu.tu@amlogic.com> wrote:
[...]
> >>   static int meson_uart_request_port(struct uart_port *port)
> >>   {
> >> +       struct meson_uart_data *private_data = port->private_data;
> >> +       int ret;
> >> +
> >> +       ret = clk_prepare_enable(private_data->pclk);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       ret = clk_prepare_enable(private_data->baud_clk);
> >> +       if (ret) {
> >> +               clk_disable_unprepare(private_data->pclk);
> >> +               return ret;
> >> +       }
> > This code is from my original suggestion - and I had a doubt there
> > which I forgot to add as a comment originally:
> > Can you confirm that accessing the UART controller registers works
> > even when "pclk" is turned off?
> > I am asking this because the common clock framework can access the
> > clocks at any time.
> > And I have seen SoCs which would hang when trying to access a module's
> > registers while the module's pclk is turned off.
> On all meson platforms, the default pclk for all UART is turned on
> during the u-boot phase. When registering uart pclk in the kernel phase,
> the CLK_IGNORE_UNUSED flag is added. So the real shutdown is when the
> standby goes down, the parent clk shuts down.
Interesting, thanks for sharing that u-boot turns these clocks on.
Let's say someone wanted to make u-boot save power and turn off all
UART clocks except the one for uart_AO (where we typically connect the
serial console).
In that case the pclk of uart_C (just to choose an example here) is
turned off. Would there be a problem then accessing the registers of
uart_C before clk_prepare_enable is called?

[...]
> >>          port->fifosize = 64;
> > commit 27d44e05d7b85d ("tty: serial: meson: retrieve port FIFO size
> > from DT") [0] from May 2021 has changed this line to:
> >    port->fifosize = fifosize;
> > So your patch currently does not apply to linux-next (or even Linus'
> > mainline tree).
> >
> So do I need to wait for [0] patch merged before I can continue to make
> changes ?
These changes are already merged.

> What can I do before?
You should base your changes on top of the tty.git/tty-next branch [1]
where Greg (the maintainer of this tree) will pick up the patches once
they are good (got enough Acked-by/Reviewed-by, etc.).
I suspect that you based your changes on an older or stable kernel
version (let's say 5.10). New functionality should always get into the
-next tree where various auto-build robots will compile-test the
changes and we even have Kernel CI where changes are tested on real
hardware (BayLibre even maintains Amlogic boards in their Kernel CI
labs). Let's say Amlogic updates to Linux 5.17 next year then the
patches are already included in that kernel version - instead of being
only available in Linux 5.10.


Best regards,
Martin


[1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/log/?h=tty-next
