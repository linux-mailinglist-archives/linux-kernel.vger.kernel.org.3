Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4699C4CEE1D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 23:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiCFWOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 17:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiCFWOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 17:14:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5132366AD;
        Sun,  6 Mar 2022 14:13:46 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g20so17489264edw.6;
        Sun, 06 Mar 2022 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d07l6897o6MrSAkIwgSUFhA0NhycxI0AnBPO1cVoW8o=;
        b=B6y/niMvLqAqBPL90NfdQwBJiRcjHs6OGnXR875jYgCEK4Se5HLcO5/svp+7R2kCYf
         9z864K1QRXbch5fVAucZjUpBoegiSoFXhHwziPlRxl4PoJyy2ZlQS7Vi6SJ8btyuIr9d
         FSi+uMFFCH5gRrHWnrMdyRsgHfW+x/ROJ3I2GQx4msxjb7ZvWwvp6zp2PU5VpUdRMTt5
         XbZZ8ys3g9YZGKsymfJjL+jmICOYPzhfNxxxEuWNHaiTjeaBdL6w3rQP4kJFUV3wPar6
         C3DqDHLP6zirpcfs2ai6SCK5QAvElMPfifHWoGE+txKv7+p0OS8DLjdaYhWiJdSSPnnj
         ULPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d07l6897o6MrSAkIwgSUFhA0NhycxI0AnBPO1cVoW8o=;
        b=12e61SaL+sQ+ww6JFUJK9DPvoRu/tt51y2r96vPNJ8rkdAOq2Lbeyh1B78XW3h5Rm/
         3L0BUDzkXimfjCuTip+p+vYhi0/D1JcRsNDUboOJkNO7aEn5YQ+sqoR6dOsJhBFE1fd+
         EvMOBXaM9anPZ71eE3CgUWgt3VZ8ePvzIa8y0ldrO+Qcxe4SV8J9M1gX+hL6GMxS7rNk
         fQevZMLQP9xXH3//4kikARQJlETlZHbgbyFihRuFVcMmn9HKKk8QyHRruoTtr0ImU97E
         L0oT6zSBLYTholFb6DusHKNtM5Me2rf+7hn9NNy6SMbUlDSG0U/+ob7BJMHbsd8/s9Pd
         W7Pw==
X-Gm-Message-State: AOAM530bUmLdqsyH+ivajoumWK28Zi/rkl6EWD6UKPoYn7fIr+IQUlwm
        BdsPI0eublB5KxDIg9ekm0XSHMIHBKGf9rYGg/Y=
X-Google-Smtp-Source: ABdhPJxaxbPETqCTTCnyeytGz7+giPjMlyWwFiqv0eg3u607TfxlzoZDyIaudmc/6PddD94Bx7f01c4Tc4madVMYaCE=
X-Received: by 2002:a05:6402:3452:b0:415:9d25:3967 with SMTP id
 l18-20020a056402345200b004159d253967mr8355081edc.125.1646604825414; Sun, 06
 Mar 2022 14:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-4-ilpo.jarvinen@linux.intel.com> <20220306192135.GC19394@wunner.de>
In-Reply-To: <20220306192135.GC19394@wunner.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Mar 2022 00:13:09 +0200
Message-ID: <CAHp75Ve3EmFMZGsHpsBfy4QUnKqP3LhOXFZ+d7RhVS9RkAqCHw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] serial: 8250_dwlib: Implement SW half duplex support
To:     Lukas Wunner <lukas@wunner.de>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 12:01 AM Lukas Wunner <lukas@wunner.de> wrote:
> On Wed, Mar 02, 2022 at 11:56:02AM +0200, Ilpo J=C3=A4rvinen wrote:
> > This patch enables support for SW half-duplex mode. Synopsys
> > DesignWare UART has a build-in support for the RS485 protocol
> > from IP version 4.0 onward with dedicated RE/DE_EN registers.
> > This patch enables RS485 either using dedicated registers or
> > em485 as fallback.
> >
> > In order to select preference for SW half-duplex mode (em485 +
> > RE/DE_EN) over HW managed one, as both are supported under
> > some configurations, SER_RS485_SW_RX_OR_TX flag is added to
> > serial_rs485.
> >
> > This patch depends on UART_CAP_NOTEMT which is not provided
> > by this series but another one:
> >   https://lore.kernel.org/all/20210204161158.643-1-etremblay@distech-co=
ntrols.com/
>
> I don't see any benefit in using software emulated RTS assertion
> if hardware support is present.  It just consumes more CPU time
> and is slower to deassert RTS, thereby increasing bus turn-around time.
>
> So if hardware support is present, I think you always want to
> use that and you need to fallback to software emulation only
> if hardware support is missing (i.e. on IP versions < 4).

No, this is not a good idea because presence of the HW support does
not guarantee we will have pins on PCB level and/or properly muxed by
firmware, or be able to be properly muxed by software (OS). Or am I
missing something here and you have an idea how to enable RS485 in
that case?

> The registers you're using here, DW_UART_RE_EN and DW_UART_DE_EN
> don't seem to be present on older IP versions.  I'm looking at
> the databook for version 3.04a and those registers aren't mentioned:
>
> https://linux-sunxi.org/images/d/d2/Dw_apb_uart_db.pdf
>
> So the software emulation you've implemented here won't help with
> older IP and the newer IP doesn't need it because it supports
> RTS assertion in hardware.  Is that correct?  If so, I'd suggest
> not supporting DW_UART_TCR_XFER_MODE_SW_DE_OR_RE at all.
>
> A number of people have attempted to add rs485 software emulation
> to 8250_dw.c but noone ever pursued it into mainline.  The last
> attempt was by Heiko St=C3=BCbner, who used patches by Giulio Benetti (+c=
c):
>
> https://lore.kernel.org/linux-serial/20200517215610.2131618-1-heiko@sntec=
h.de/
>
> FWIW, newer TI Sitara SoCs have also added hardware support for
> rs485 and in this (not yet upstreamed) patch, I likewise chose
> to use software emulation only if hardware support is not available:
>
> https://github.com/l1k/linux/commit/82c989617a05



--=20
With Best Regards,
Andy Shevchenko
