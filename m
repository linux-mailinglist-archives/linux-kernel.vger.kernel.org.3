Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373F74B35A7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 15:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiBLOg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 09:36:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiBLOg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 09:36:56 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0474720F;
        Sat, 12 Feb 2022 06:36:53 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s7so20571618edd.3;
        Sat, 12 Feb 2022 06:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNVtGj2HlwN1t95oRwbX7m9qgYlxgxLGOkN+c8cOGws=;
        b=PFReLFuS9ZMwPZ3FYSl4edpXkzUzLQtYO8nz/FObDG9k8yQNHvUIKpt8BSKuegk+Qz
         URLWLVSAthB9vRGw3F1hKQR41+mjgGkdJ/tClO052v4vI7sp1qVwBspsNnn0LNcavv1q
         2TPq/tdMi4U4iqLaOi6hC6ChcjUkbhNOnVooIV1273/wseBqAtvnFOEoZVjM9lPlUXNw
         9djtWzil1652IT6SVM7VIg5ugD2fOR46xWkoeUZRMNPGhSJi/dglHFopinDR00ElFzDC
         XWyzzawbTtcQWfG2ylh6u22XtRoGcNvNb/qY4qTwr/xWSPJbo5gV5bseO0+s4Iii+QOj
         ewaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNVtGj2HlwN1t95oRwbX7m9qgYlxgxLGOkN+c8cOGws=;
        b=iufiu2Dyr+52CC9JRoJjFm9uSETJtn43nc4Idgk8QTpaedgxsNQTVA5Rxy+fSYN9s6
         yiW11bSPBPdTvFJhskqP0iPMy/NRJlRW6L3OvUVMEKimWM/Ea/IEusbirGL7ue5Z7c4i
         Oz2tH3VINgDVmCke6nwr9LP6iB5rauAa7m2tIM6Z1mBPckx80knKtCVvIXGGAZAyRmxs
         HNylxMNh5Q8TRSruhdjayIT8PVuZ33U2RWoNUgZU3G7e9+4lykXVJY01nO4ef/QH/Ehn
         SQphUqJhpCwSw+N90ll050n1hE2AqWJIptMsl0bf9q1hPtmCctY2ijSaOHvIDZodT6kY
         3FQw==
X-Gm-Message-State: AOAM533rkgt7WANAmm5LqiyZ4vAkEvkcjv2V7s6JE9vHLOp3WdlNa3UB
        aU58lCBrzHN6j6LEzYChVnWaiHMIIbCSejq0d+0=
X-Google-Smtp-Source: ABdhPJz5lyeOKwpjBCZn6+Mov6KD2nS/waJD+PZ2ykYAukvMfSAgZnKNiBl8E/8nTVAcDZUoXe8dbS79s7Q3VO/YJKM=
X-Received: by 2002:aa7:c395:: with SMTP id k21mr4401538edq.436.1644676611377;
 Sat, 12 Feb 2022 06:36:51 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2202100424280.34636@angie.orcam.me.uk> <alpine.DEB.2.21.2202111127200.34636@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2202111127200.34636@angie.orcam.me.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 12 Feb 2022 16:36:15 +0200
Message-ID: <CAHp75VdxUv-807W9OajsM95OVpbwtZ4ts-uJKt+X9e4fXHHuyg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] serial: 8250: Add proper clock handling for OxSemi
 PCIe devices
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mike Skoog <mskoog@endruntechnologies.com>,
        Mike Korreng <mkorreng@endruntechnologies.com>,
        info@endruntechnologies.com,
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

On Sat, Feb 12, 2022 at 10:41 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
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
>   MCR[7] always set and have the 8250 core propagate this settings; also
>   make the console restorer use this shadow.
>
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
>
> With the baud base set to 15625000 and the unsigned 16-bit UART_DIV_MAX
> limitation imposed by `serial8250_get_baud_rate' standard baud rates
> below 300bps become unavailable in the regular way, e.g. the rate of
> 200bps requires the baud base to be divided by 78125 and that is beyond
> the unsigned 16-bit range.  The historic spd_cust feature can still be
> used to obtain such rates if so required.
>
> See Documentation/tty/device_drivers/oxsemi-tornado.rst for more details.

...

> +       /* Old custom speed handling.  */

Exactly and we do not want to see this in the new code.

> +       if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
> +               unsigned int cust_div = port->custom_divisor;
> +
> +               quot = cust_div & UART_DIV_MAX;
> +               tcr = (cust_div >> 16) & OXSEMI_TORNADO_TCR_MASK;
> +               cpr = (cust_div >> 20) & OXSEMI_TORNADO_CPR_MASK;
> +               if (cpr < OXSEMI_TORNADO_CPR_MIN)
> +                       cpr = OXSEMI_TORNADO_CPR_DEF;
> +       } else {

I'll read and comment on the rest later on (hopefully next week).

P.S. I still think that overloading 8250_pci with custom quirks is not
a good idea.

-- 
With Best Regards,
Andy Shevchenko
