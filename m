Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD864744C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhLNOXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhLNOXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:23:44 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45648C06173E;
        Tue, 14 Dec 2021 06:23:44 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 40C368C4;
        Tue, 14 Dec 2021 15:23:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1639491822;
        bh=nE3Qud+GSTfrUs4bvkqftGgrfvMHZoBroRjwMqjlWno=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IyGcmSbnqi6CqE7G69BAnc6+lnZIcuAFn5uphmwdzy2Ncef6wIjSj2aLX/FOvdYqG
         x8bTm/ZB4UEjKWL6hiegLZhuJYb/ukiryNHBrF4j2CXM9tI4Q12ceX1kr/nq4+PleU
         QpH2D2/kdeyUPow6MsQKkBLCaAQAxY29yn0Mh118=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdW81VE=J+ChT5jVMhHmVnMi_eQix7aXjLQPJk+qKp-EdQ@mail.gmail.com>
References: <20211130164311.2909616-1-kieran.bingham+renesas@ideasonboard.com> <20211130164311.2909616-3-kieran.bingham+renesas@ideasonboard.com> <CAMuHMdW81VE=J+ChT5jVMhHmVnMi_eQix7aXjLQPJk+qKp-EdQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: renesas: r8a779a0: falcon-cpu: Add DSI display output
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>, open list:
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        open list <linux-kernel@vger.kernel.org>, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Dec 2021 14:23:39 +0000
Message-ID: <163949181978.2512616.9466994004921760294@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2021-12-14 10:49:15)
> Hi Kieran,
>=20
> On Tue, Nov 30, 2021 at 5:43 PM Kieran Bingham
> <kieran.bingham+renesas@ideasonboard.com> wrote:
> > Provide the display output using the sn65dsi86 MIPI DSI bridge
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>=20
> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v5.17.
>=20
> > --- a/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
>=20
> > @@ -146,6 +190,41 @@ &i2c1 {
> >
> >         status =3D "okay";
> >         clock-frequency =3D <400000>;
> > +
> > +       sn65dsi86@2c {
> > +               compatible =3D "ti,sn65dsi86";
> > +               reg =3D <0x2c>;
> > +
> > +               clocks =3D <&sn65dsi86_refclk>;
> > +               clock-names =3D "refclk";
> > +
> > +               interrupt-parent =3D <&gpio1>;
> > +               interrupts =3D <24 IRQ_TYPE_LEVEL_HIGH>;
>=20
> Does the driver use this interrupt, and is it triggered?

No, it does not currently, but I expect it can be made to do so. Which
is likely a next development task to adapt polling hotplug to interrupt
driven hotplug detection anyway, so I'll try that then.


> If yes, as GP1_24 =3D=3D IRQ0, you can switch from a GPIO to an INTC_EX I=
RQ,
> (don't forget to configure pinctrl) and test the INTC_EX driver.
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
