Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB35D50530D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiDRMzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbiDRMiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:38:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605DE23BC6;
        Mon, 18 Apr 2022 05:28:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ck12so5042071ejb.4;
        Mon, 18 Apr 2022 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MS8QH1JXt2RhAQ2nGDbUJJM4tymM2sb4H79H+9Zs7o=;
        b=Yzni4FFWrRedQOL11Hx+zfIAG/ric0LHy/+WxlfHcHH60ux0zaWfFTw5B/jGogWNJE
         GgT5AWhJdDPqBf+XvKwVWz7X4B8ti5jlMGRDCs/aDoPEeeoQ1kfwEeyiWQMYL2TmQmOI
         3Mr/1dVMAqTglwkd/81ZVpqHrgRlZsHNwYgUp6UQj1jwvplqTE3Z1REPe6LGz8GqbWjJ
         A3yk4bGTAaV42ssnYuzFurtvmO7RYe/8hNXyUCESdofgCqAPuQfJ1/W56ReqEJvG8LTt
         Zc6kyTXeVIuZdtdRD+l0M/7tDXnC6tBgK4tKEVtjhHJwd7i6NJxrzdMnHk+2Y48KQVoo
         sldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MS8QH1JXt2RhAQ2nGDbUJJM4tymM2sb4H79H+9Zs7o=;
        b=IrjVFTYPHhGgGkV5vDB6F3bgOCUY7cbX9H02lIKB7iSqNKaLUzKwFgMklBrdh+15ML
         5GU7URgVHFPVe8p6kBJrjX75fH18ygsGO81WAktzqzgVDqIu1EEfCnocGRDEnXMWQelm
         4vsov3KsOdxKpIQr1RiVh6fZOZa7kTQMVEhvuA6+ciqjPjrtZ1jejVm4Y4bN3439nm8O
         XRYOtlYU8kkA+PXyk/YRe/WpVuWme6qPpnfETBQ7RDfCKXFWIWJq1KVhspYbZmCrFDz1
         vGuTVvipY3/FME/HZkAWYUALmzVukiPTjg9o3wuorgPcaCxR3vS0YE9sI4x77ciivpxp
         XRJw==
X-Gm-Message-State: AOAM532XLtWXebONCuHFPSIDDG2qQ9oD1I4sG4nrru/QMHIMkeAwD51V
        FMTJyCsURjEMJUBXzNAurrF9Qm3kZtcDcb9G/68=
X-Google-Smtp-Source: ABdhPJwNx7Bp/x1FQBaUjl/jZ8pw6C55FHSm8z3w5fMkShl/CiMC0Pnn8EnH+wbT0XbNQSwCEF0uSLppoqh0yuPvJOk=
X-Received: by 2002:a17:906:3799:b0:6ec:d25:3afe with SMTP id
 n25-20020a170906379900b006ec0d253afemr9098925ejc.44.1650284907498; Mon, 18
 Apr 2022 05:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2204161848030.9383@angie.orcam.me.uk> <alpine.DEB.2.21.2204162141010.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204162141010.9383@angie.orcam.me.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Apr 2022 15:27:51 +0300
Message-ID: <CAHp75Vc6n+86jhhK2JRSZ=f6ZBV46Kz=Ayq=dWTHFbB-Hr+C7A@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] serial: 8250: Add proper clock handling for OxSemi
 PCIe devices
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 2:02 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> Oxford Semiconductor PCIe (Tornado) 950 serial port devices are driven
> by a fixed 62.5MHz clock input derived from the 100MHz PCI Express clock.
>
> We currently drive the device using its default oversampling rate of 16
> and the clock prescaler disabled, consequently yielding the baud base of
> 3906250.  This base is inadequate for some of the high-speed baud rates
> such as 460800bps, for which the closest rate possible can be obtained
> by dividing the baud base by 8, yielding the baud rate of 488281.25bps,
> which is off by 5.9638%.  This is enough for data communication to break
> with the remote end talking actual 460800bps where missed stop bits have

', where'

> been observed.
>
> We can do better however, by taking advantage of a reduced oversampling
> rate, which can be set to any integer value from 4 to 16 inclusive by
> programming the TCR register, and by using the clock prescaler, which
> can be set to any value from 1 to 63.875 in increments of 0.125 in the
> CPR/CPR2 register pair.  The prescaler has to be explicitly enabled
> though by setting bit 7 in the MCR or otherwise it is bypassed (in the
> enhanced mode that we enable) as if the value of 1 was used.
>
> Make use of these features then as follows:
>
> - Set the baud base to 15625000, reflecting the minimum oversampling
>   rate of 4 with the clock prescaler and divisor both set to 1.
>
> - Override the `set_mctrl' and set the MCR shadow there so as to have
>   MCR[7] always set and have the 8250 core propagate this settings.

these

> - Override the `get_divisor' handler and determine a good combination of
>   parameters by using a lookup table with predetermined value pairs of
>   the oversampling rate and the clock prescaler and finding a pair that
>   divides the input clock such that the quotient, when rounded to the
>   nearest integer, deviates the least from the exact result.  Calculate
>   the clock divisor accordingly.
>
>   Scale the resulting oversampling rate (only by powers of two) if
>   possible so as to maximise it, reducing the divisor accordingly, and
>   avoid a divisor overflow for very low baud rates by scaling the
>   oversampling rate and/or the prescaler even if that causes some
>   accuracy loss.
>
>   Also handle the historic spd_cust feature so as to allow one to set
>   all the three parameters manually to arbitrary values, by keeping the
>   low 16 bits for the divisor and then putting TCR in bits 19:16 and
>   CPR/CPR2 in bits 28:20, sanitising the bit pattern supplied such as
>   to clamp CPR/CPR2 values between 0.000 and 0.875 inclusive to 33.875.
>   This preserves compatibility with any existing setups, that is where
>   requesting a custom divisor that only has any bits set among the low
>   16 the oversampling rate of 16 and the clock prescaler of 33.875 will
>   be used as with the original 8250.
>
>   Finally abuse the `frac' argument to store the determined bit patterns
>   for the TCR, CPR and CPR2 registers.
>
> - Override the `set_divisor' handler so as to set the TCR, CPR and CPR2
>   registers from the `frac' value supplied.  Set the divisor as usually.

usual

> With the baud base set to 15625000 and the unsigned 16-bit UART_DIV_MAX
> limitation imposed by `serial8250_get_baud_rate' standard baud rates
> below 300bps become unavailable in the regular way, e.g. the rate of
> 200bps requires the baud base to be divided by 78125 and that is beyond
> the unsigned 16-bit range.  The historic spd_cust feature can still be
> used to obtain such rates if so required.
>
> See Documentation/tty/device_drivers/oxsemi-tornado.rst for more details.

I'm not sure I understand how this change can have the 8250_port
changes which were done in the previous patches. What did I miss?
Also, looking at the below if the two *_icr_*() functions were moved
from 8250_port, how they have been used before? Dead code?

...

> +       /* Old custom speed handling.  */
> +       if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {

This part is not needed.  We have a BOTHER mechanism in the kernel
that works for each driver that supports it in the generic way, hence
the user space tool wouldn't be patched to support this exact card
separately. Using SPD_CUST is a step back.

> +               unsigned int cust_div = port->custom_divisor;
> +
> +               quot = cust_div & UART_DIV_MAX;
> +               tcr = (cust_div >> 16) & OXSEMI_TORNADO_TCR_MASK;
> +               cpr = (cust_div >> 20) & OXSEMI_TORNADO_CPR_MASK;
> +               if (cpr < OXSEMI_TORNADO_CPR_MIN)
> +                       cpr = OXSEMI_TORNADO_CPR_DEF;
> +       } else {

> +       }

-- 
With Best Regards,
Andy Shevchenko
