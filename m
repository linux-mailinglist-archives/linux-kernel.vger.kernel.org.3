Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2414C420E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbiBYKRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiBYKRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:17:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261DDB0D3E;
        Fri, 25 Feb 2022 02:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645784200;
        bh=ZBa8/L8iW7ShngPtjDMHz5hutdlp2KMJfLYcYHlTSac=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UjcV5q8jw4HJ1NnJHIbhv9jjKqi803bfJEJkddrABEHqPOz4g0EFxZIJrHAzPmjJN
         UxH06gb96hwDsFANb6XM/Oi5Mf5S8wmiyoOtDOBH/HsnT1/4jstuZ5qc1EOACf+DHL
         9PkfTNLmJixtRvO/oGC9d/zi2N4aRD+MwcbKY7Nk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [149.172.237.68] ([149.172.237.68]) by web-mail.gmx.net
 (3c-app-gmx-bs22.server.lan [172.19.170.74]) (via HTTP); Fri, 25 Feb 2022
 11:16:40 +0100
MIME-Version: 1.0
Message-ID: <trinity-24577b7c-5c5c-4fc6-a651-76ff5306989f-1645784200761@3c-app-gmx-bs22>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, u.kleine-koenig@pengutronix.de,
        linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Aw: Re: [PATCH v3 1/9] serial: core: move RS485 configuration tasks
 from drivers into core
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Feb 2022 11:16:40 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <8c65bc42-438e-bf3e-fb76-2a4cbc7296c0@kernel.org>
References: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
 <20220222011433.8761-2-LinoSanfilippo@gmx.de>
 <e883ccb5-68ea-f802-e4fd-864672d8ad7b@kernel.org>
 <8c65bc42-438e-bf3e-fb76-2a4cbc7296c0@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ibYL81/cTwwyjgrY6rom2mIBEWHvIVWZqMEWewOjnErTr05yoYf2pdsMCoBxlPwP8FVC+
 6O0fux1W2EXyDiV77vhEuhlsD/FIlQedJo77XHw3gim6Ai615yn57T2QpdtbOULuKtJBn+RJthAX
 kes/rau+Wqar/h0FsnggtMlelJHLf9RKH1ZYsP2eXAcFOCHsT68GbxNN+BR+x/vgFmvZezc+mEY8
 IEthQkDlucjv4bBNrDFCof3m0/ACsl6zh47nnu+yvVEpeUKdLdU3QST7QT12DAxrI3qQGWwRHZ15
 b0=
X-UI-Out-Filterresults: notjunk:1;V03:K0:E9Z82zmc+mw=:pLPhOlVyfV3AzfuammmOhk
 BUI3M06giNfHrsX9mFJDK5aSVIo88CrtOWiEsVXW4NssL51BCEMf1EyA+f8kKvo+kfZUR4pcc
 wpybd3pyPMA/QvWat4LkIT4eSAHlSPQUCqAbXEyWIG0RXYPlOUIjeL1O3tPoaVZR1cUUudFti
 YeAMWy7QzbX9avZ4Y9QgJJMLTzvyLY+kBDMC0qcjcXnEI+3DIn8vSxLFDRjIKCGXQkQZ9a+zj
 2Rvjrs/xrXLJrqrSLkYRq32aLZhWrXxhhVVPWJQmGixlIHJUktd+5RPXxkQZNhfYwJARfop6B
 a2jNVOYWC66EH/uDBvVXUyrUVRFF3Pfh9x750huymEwXTX9rTbA5bJFaZoiraghQL2aphG2PB
 6UZEzgZ3ufDxKC3otERT03K0mN67CETOZdauXv96zeeBNArMUlnNuKki4Am+bAf3XsqWe+NLp
 CliIMVwGYSuW829QUf1pui31Q/pEeGnX8KSzUQNEYuK4qwOFboURM/LisnGDEEbhISnLJ1X3+
 2vxjb6Cw6MFav0aifpatTEidFtxHqG+Ed1CAeaE9Gs6+fkcL11gld4lXYYqtd53ZYkFSb1aJ0
 OknObjOgeAUYozHPsRLWHiATex/3ItRSTzBmUlzHx2RnLDR4wSBd5hhI/Wmn2KMzt30eP982I
 3m3hu1kiwoHjjx+SR2iDiqcbpxWszTexsKPhoKVOmzLwp3GLoM1qqFCkS31Py1VAtAWcMIIvu
 f+zcgjtNJ1IH3cg8fpihwnW5W+NgXru7XsBA7SLojo9DdHOWkMcNcXJbEaeuZeBuxTZMD/JmG
 kN19HXC
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> On 22=2E 02=2E 22, 7:51, Jiri Slaby wrote:
> > On 22=2E 02=2E 22, 2:14, Lino Sanfilippo wrote:
> >> Several drivers that support setting the RS485 configuration via=20
> >> userspace
> >> implement one or more of the following tasks:
> >>
> >> - in case of an invalid RTS configuration (both RTS after send and RT=
S on
> >> =C2=A0=C2=A0 send set or both unset) fall back to enable RTS on send =
and disable=20
> >> RTS
> >> =C2=A0=C2=A0 after send
> >>
> >> - nullify the padding field of the returned serial_rs485 struct
> >>
> >> - copy the configuration into the uart port struct
> >>
> >> - limit RTS delays to 100 ms
> >>
> >> Move these tasks into the serial core to make them generic and to pro=
vide
> >> a consistent behaviour among all drivers=2E
> >>
> >> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx=2Ede>
> >> ---
> >> =C2=A0 drivers/tty/serial/serial_core=2Ec | 29 ++++++++++++++++++++++=
+++++++
> >> =C2=A0 1 file changed, 29 insertions(+)
> >>
> >> diff --git a/drivers/tty/serial/serial_core=2Ec=20
> >> b/drivers/tty/serial/serial_core=2Ec
> >> index 846192a7b4bf=2E=2E2b3afe038c1c 100644
> >> --- a/drivers/tty/serial/serial_core=2Ec
> >> +++ b/drivers/tty/serial/serial_core=2Ec
> >> @@ -42,6 +42,11 @@ static struct lock_class_key port_lock_key;
> >> =C2=A0 #define HIGH_BITS_OFFSET=C2=A0=C2=A0=C2=A0 ((sizeof(long)-size=
of(int))*8)
> >> +/*
> >> + * Max time with active RTS before/after data is sent=2E
> >> + */
> >> +#define RS485_MAX_RTS_DELAY=C2=A0=C2=A0=C2=A0 100 /* msecs */
> >> +
> >> =C2=A0 static void uart_change_speed(struct tty_struct *tty, struct=
=20
> >> uart_state *state,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ktermios *=
old_termios);
> >> =C2=A0 static void uart_wait_until_sent(struct tty_struct *tty, int t=
imeout);
> >> @@ -1282,8 +1287,32 @@ static int uart_set_rs485_config(struct=20
> >> uart_port *port,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (copy_from_user(&rs485, rs485_user,=
 sizeof(*rs485_user)))
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFAULT=
;
> >> +=C2=A0=C2=A0=C2=A0 /* pick sane settings if the user hasn't */
> >> +=C2=A0=C2=A0=C2=A0 if (!(rs485=2Eflags & SER_RS485_RTS_ON_SEND) =3D=
=3D
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(rs485=2Eflags & SER_RS4=
85_RTS_AFTER_SEND)) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("invalid RTS sett=
ing, using RTS_ON_SEND instead\n");
> >=20
> > Can't we have a device prefix here, so that everyone knows what device=
=20
> > is affected? Without that, it's not that useful=2E At least port->name=
 &=20
> > port->line could be printed=2E The uart core uses dev_* prints, but pr=
ints=20
> > also line as uport->dev can be NULL sometimes=2E
>=20
> And this comes from userspace, so should be ratelimited=2E
>=20

Right, ratelimiting makes sense here=2E I will change it as suggested in t=
he next patch version=2E
Thanks a lot for the review=2E

Regards,
Lino

