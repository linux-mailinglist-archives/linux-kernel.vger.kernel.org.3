Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCCF47C9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 00:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbhLUX2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 18:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbhLUX2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:28:36 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C0C061574;
        Tue, 21 Dec 2021 15:28:36 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id u8so606391iol.5;
        Tue, 21 Dec 2021 15:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Y9qNhArsQ0y20VLdp6J5wDm7XykoFJAUNYk5IaM9hU=;
        b=ffbFCTx9cfBHU9hVLoh1EuPKDfCbDkzePVspueec6ve0wQOxK3Dy3UTajDENOBWcQp
         3acuN4AJC4/cQfOHUVm4rfZcCEB79xPSQ/1Xs2knQPKSppIUuMp6Z9YEmznMypkZC/Lw
         qxavyX1+ZR82xuusqd1+l3ejhhDRBSv43dksVNIN38QVBOnIF+x+wb51eGNR+44o84zt
         v49Za90vVKeECaz59prHRMf/PDtQJoW/PneufPYykMW+81S8JAfNM02zxwGvxNQ41qrN
         7r2cIEMBO0N5xS+DtmB2TNA1yiKJ2uAicO9L9LmDqulNhKn/WChLbYTRiJbw6D3I0khq
         gOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Y9qNhArsQ0y20VLdp6J5wDm7XykoFJAUNYk5IaM9hU=;
        b=7KfPTOiOs2Mfo8UMe+IkH15PuGX/FbbOPAVBoooSfHDGQ0BymOmLd9/u45knJEHYti
         SY85JslEZz/a52h/+kq1ZqKZMo8mYmHURkBuogZFasIhX5rttVb7SbV+0jqzMPjsuypl
         DP8Wk3jXXRAXPJPc7BNTFJpSqtcxK41+9y4rAvQ8TZbVGDuQqhLoqHehgyUiHgtOO7Us
         7Bn7X71RIf39R8Bwk3dILhYc+STal/+BpGsvnpfoyOImZXVD1HRqWIQ/ORV69f89tJkb
         6OpqClFwdfczCW5B6yFLRXPFIN0OD0ts/G1ded9NXVVdrudRJ9xEgaOC0WkLq7V5mEjf
         Md3Q==
X-Gm-Message-State: AOAM5304ntmPT2n1if852H2EeSyYc9V11E5JZ4nFDlbT8H0CMBds9DV/
        3UVMlK/E9TKM2DJHK/AZsUPraPQ4Tn2zuxEmfm2fmp12ZuoINgHQEWbVHw==
X-Google-Smtp-Source: ABdhPJxEqu9uWtwLGTXTaastqfzijEJ++BtgObWTVb3g45BTyAIZLFBFjCN3lj09MdocSmg5U6Aq/GG7aq42sEeGSjs=
X-Received: by 2002:a05:6602:204e:: with SMTP id z14mr212310iod.90.1640129316028;
 Tue, 21 Dec 2021 15:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20211103114830.62711-1-alistair@alistair23.me>
 <20211103114830.62711-2-alistair@alistair23.me> <YYYk/uisKqPNgRu0@google.com>
 <CAKmqyKOFZOLpjMY+kj2CLibFhYJ3-tL+9+cKEVzgSn9Mzq30gw@mail.gmail.com>
 <YbbeDFJERtP0mAIQ@google.com> <20211218231823.49a72256@aktux>
In-Reply-To: <20211218231823.49a72256@aktux>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 22 Dec 2021 09:28:10 +1000
Message-ID: <CAKmqyKOtZ5AfVtNPYDNTMUjMRobZUwP7coTgEt94uze35Zxb7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Input: Add driver for Cypress Generation 5 touchscreen
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alistair Francis <alistair@alistair23.me>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mylene Josserand <mylene.josserand@free-electrons.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 8:18 AM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> Hi,
>
> On Sun, 12 Dec 2021 21:45:48 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> [...]
> > > > This is also likely unsafe if controller is not completely shut off and
> > > > is capable of generating interrupts given input device is not yet
> > > > allocated.
> > >
> > > I have dropped the `IRQF_TRIGGER_FALLING |`
> > >
> > > I have tried to use level interrupts, but I can't get the device
> > > working with them.
> >
> > That is weird, does the interrupt controller support level interrupts?
> >
> I have set level interrupts via the devicetree,
> things seem to work on Kobo Clara HD:
> /proc/interrupts
> 203:      37402  gpio-mxc   6 Level     tt21000
>
>        touchscreen@24 {
>                 compatible = "cypress,tt21000";
>                 reg = <0x24>;
>                 pinctrl-names = "default","sleep";
>                 pinctrl-0 = <&pinctrl_cyttsp5_gpio>;
>                 pinctrl-1 = <&pinctrl_cyttsp5_gpio_sleep>;
>                 interrupt-parent = <&gpio5>;
>                 interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
>                 reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
>         };

I have tried using IRQ_TYPE_LEVEL_LOW as well, but the device doesn't
start correctly and the commands time out.

It works fine with IRQ_TYPE_EDGE_FALLING though.

Alistair

>
> Regards,
> Andreas
