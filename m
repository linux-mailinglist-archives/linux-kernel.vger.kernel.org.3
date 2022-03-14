Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539324D8F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiCNWFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiCNWFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:05:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A11F3D1E4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:04:13 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nTsnR-0003Aq-9a; Mon, 14 Mar 2022 23:04:09 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-6399-440a-c2a2-bdf7.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:6399:440a:c2a2:bdf7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 631184B40D;
        Mon, 14 Mar 2022 22:04:08 +0000 (UTC)
Date:   Mon, 14 Mar 2022 23:04:08 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220314220408.hn4vdohtjdbfoaqo@pengutronix.de>
References: <20220307214303.1822590-1-max@enpas.org>
 <CAMZ6RqJZObevKPc29jW+m6i0eAgestTbw8KCPXxSGHzSXK7cRg@mail.gmail.com>
 <20220309135414.34f77251.max@enpas.org>
 <CAMZ6RqJJ-PO=WeFeuXk4iC9GHLXz_ZMWtsVCm6sGVGbmeE5U1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jairfwongtmk2mz3"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJJ-PO=WeFeuXk4iC9GHLXz_ZMWtsVCm6sGVGbmeE5U1Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jairfwongtmk2mz3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2022 22:49:49, Vincent Mailhol wrote:
> > But rx_offload needs the mailbox_read function, even if it's a dummy,
> > because can_rx_offload_add_fifo() checks:
> >
> >         if (!offload->mailbox_read)
> >                 return -EINVAL;
>=20
> I think that there should not be a dummy functions like this one.
>=20
> Either we agree that using can_rx_offload without implementing
> the mailbox_read() is OK and in that case, the can_rx_offload
> framework should be modified to allow mailbox_read() to be a NULL
> pointer.
>=20
> Either it is not the case and you use the more classic
> netif_rx().
>=20
> And I do not have the answer. I haven't studied can_rx_offload
> enough to be a judge here. Sorry.
>=20
> @Marc, any thoughts?

Use can_rx_offload_add_manual() instead.

> > > > +/* Send a can_frame to a TTY. */
> > > > +static netdev_tx_t elmcan_netdev_start_xmit(struct sk_buff *skb,
> > > > +                                           struct net_device *dev)
> > > > +{
> > > > +       struct elmcan *elm =3D netdev_priv(dev);
> > > > +       struct can_frame *frame =3D (struct can_frame *)skb->data;
> > > > +
> > > > +       if (skb->len !=3D sizeof(struct can_frame))
> > > > +               goto out;
> > >
> > > Isn=E2=80=99t this aleardy guaranteed by the upper layers?
> >
> > Copy-pasta from slcan.c - will look into it.
>=20
> Also give a look at can_dropped_invalid_skb().

ACK

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jairfwongtmk2mz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIvu9UACgkQrX5LkNig
010z+wf8COaZnIFyF/cDQMT+ve8a0iwBPignONvdZYfNxHc+rLtj3801S/p2AaDj
oI8HTmCwRyl2HBIXPCyBIiy3YgqiY0kb54FDZqZ9JuvNxTgAj0HtWqS6EW32DYdB
cs7da4RXLR2xyQMr4YizVUePiETHQwu4y4wof3rg2ghdfIBcfZJwqpnm6LfNG9Jn
n2IEY3ntpULQrA08ittg0kvPQAVehJZ0h/1OARpsxyK7P1yrEgdOxgEG1KsIfrfu
RcjRqLhX/h9iu619oTuofcCSzvZgieyXawWgBbP13bgue8fHjKbibKr93Hnv8orp
Bd5CPt6oULFdq775Wu36VSvqJjyMmg==
=KNPb
-----END PGP SIGNATURE-----

--jairfwongtmk2mz3--
