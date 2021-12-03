Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBEB4679D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381619AbhLCPCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245020AbhLCPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:02:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64376C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:59:07 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mtA1Z-0001xQ-2Q; Fri, 03 Dec 2021 15:58:57 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-4c70-bd43-38a4-642e.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:4c70:bd43:38a4:642e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E1C286BBB97;
        Fri,  3 Dec 2021 14:58:51 +0000 (UTC)
Date:   Fri, 3 Dec 2021 15:58:51 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org,
        Stephane Grosjean <s.grosjean@peak-system.com>, lkp@intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/net/can/usb/peak_usb/pcan_usb.c:523
 pcan_usb_decode_error() error: we previously assumed 'cf' could be null (see
 line 503)
Message-ID: <20211203145851.nrgmnu7c56w4vecy@pengutronix.de>
References: <202112021833.wABxM5UN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qem4j3f2flcmpazt"
Content-Disposition: inline
In-Reply-To: <202112021833.wABxM5UN-lkp@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qem4j3f2flcmpazt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.12.2021 17:09:55, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
> commit: c11dcee758302702a83c6e85e4c4c3d9af42d2b3 can: peak_usb: pcan_usb_=
decode_error(): upgrade handling of bus state changes
> config: x86_64-randconfig-m001-20211202 (https://download.01.org/0day-ci/=
archive/20211202/202112021833.wABxM5UN-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> smatch warnings:
> drivers/net/can/usb/peak_usb/pcan_usb.c:523 pcan_usb_decode_error() error=
: we previously assumed 'cf' could be null (see line 503)
>=20
> vim +/cf +523 drivers/net/can/usb/peak_usb/pcan_usb.c
>=20
> 46be265d338833 Stephane Grosjean 2012-03-02  450  static int pcan_usb_dec=
ode_error(struct pcan_usb_msg_context *mc, u8 n,
> 46be265d338833 Stephane Grosjean 2012-03-02  451  				 u8 status_len)
> 46be265d338833 Stephane Grosjean 2012-03-02  452  {
> 46be265d338833 Stephane Grosjean 2012-03-02  453  	struct sk_buff *skb;
> 46be265d338833 Stephane Grosjean 2012-03-02  454  	struct can_frame *cf;
> c11dcee7583027 Stephane Grosjean 2021-07-15  455  	enum can_state new_sta=
te =3D CAN_STATE_ERROR_ACTIVE;
> 46be265d338833 Stephane Grosjean 2012-03-02  456 =20
> 46be265d338833 Stephane Grosjean 2012-03-02  457  	/* ignore this error u=
ntil 1st ts received */
> 46be265d338833 Stephane Grosjean 2012-03-02  458  	if (n =3D=3D PCAN_USB_=
ERROR_QOVR)
> 46be265d338833 Stephane Grosjean 2012-03-02  459  		if (!mc->pdev->time_r=
ef.tick_count)
> 46be265d338833 Stephane Grosjean 2012-03-02  460  			return 0;
> 46be265d338833 Stephane Grosjean 2012-03-02  461 =20
> c11dcee7583027 Stephane Grosjean 2021-07-15  462  	/* allocate an skb to =
store the error frame */
> c11dcee7583027 Stephane Grosjean 2021-07-15  463  	skb =3D alloc_can_err_=
skb(mc->netdev, &cf);

alloc_can_err_skb() ->
alloc_canfd_skb()

https://elixir.bootlin.com/linux/v5.15/source/drivers/net/can/dev/skb.c#L210

If skb is NULL, cf is set to NULL, too.

> 46be265d338833 Stephane Grosjean 2012-03-02  464 =20
> c11dcee7583027 Stephane Grosjean 2021-07-15  465  	if (n & PCAN_USB_ERROR=
_RXQOVR) {
> c11dcee7583027 Stephane Grosjean 2021-07-15  466  		/* data overrun inter=
rupt */
> c11dcee7583027 Stephane Grosjean 2021-07-15  467  		netdev_dbg(mc->netdev=
, "data overrun interrupt\n");
> c11dcee7583027 Stephane Grosjean 2021-07-15  468  		mc->netdev->stats.rx_=
over_errors++;
> c11dcee7583027 Stephane Grosjean 2021-07-15  469  		mc->netdev->stats.rx_=
errors++;
> c11dcee7583027 Stephane Grosjean 2021-07-15  470  		if (cf) {
>=20
> Check for NULL
>=20
> c11dcee7583027 Stephane Grosjean 2021-07-15  471  			cf->can_id |=3D CAN_=
ERR_CRTL;
> c11dcee7583027 Stephane Grosjean 2021-07-15  472  			cf->data[1] |=3D CAN=
_ERR_CRTL_RX_OVERFLOW;
> 46be265d338833 Stephane Grosjean 2012-03-02  473  		}
> 46be265d338833 Stephane Grosjean 2012-03-02  474  	}
> 46be265d338833 Stephane Grosjean 2012-03-02  475 =20
> c11dcee7583027 Stephane Grosjean 2021-07-15  476  	if (n & PCAN_USB_ERROR=
_TXQFULL)
> c11dcee7583027 Stephane Grosjean 2021-07-15  477  		netdev_dbg(mc->netdev=
, "device Tx queue full)\n");
> c11dcee7583027 Stephane Grosjean 2021-07-15  478 =20
> 46be265d338833 Stephane Grosjean 2012-03-02  479  	if (n & PCAN_USB_ERROR=
_BUS_OFF) {
> 46be265d338833 Stephane Grosjean 2012-03-02  480  		new_state =3D CAN_STA=
TE_BUS_OFF;
> c11dcee7583027 Stephane Grosjean 2021-07-15  481  	} else if (n & PCAN_US=
B_ERROR_BUS_HEAVY) {
> c11dcee7583027 Stephane Grosjean 2021-07-15  482  		new_state =3D ((mc->p=
dev->bec.txerr >=3D 128) ||
> c11dcee7583027 Stephane Grosjean 2021-07-15  483  			     (mc->pdev->bec.=
rxerr >=3D 128)) ?
> c11dcee7583027 Stephane Grosjean 2021-07-15  484  				CAN_STATE_ERROR_PAS=
SIVE :
> c11dcee7583027 Stephane Grosjean 2021-07-15  485  				CAN_STATE_ERROR_WAR=
NING;
> c11dcee7583027 Stephane Grosjean 2021-07-15  486  	} else {
> c11dcee7583027 Stephane Grosjean 2021-07-15  487  		new_state =3D CAN_STA=
TE_ERROR_ACTIVE;
> 46be265d338833 Stephane Grosjean 2012-03-02  488  	}
> 46be265d338833 Stephane Grosjean 2012-03-02  489 =20
> c11dcee7583027 Stephane Grosjean 2021-07-15  490  	/* handle change of st=
ate */
> c11dcee7583027 Stephane Grosjean 2021-07-15  491  	if (new_state !=3D mc-=
>pdev->dev.can.state) {
> c11dcee7583027 Stephane Grosjean 2021-07-15  492  		enum can_state tx_sta=
te =3D
> c11dcee7583027 Stephane Grosjean 2021-07-15  493  			(mc->pdev->bec.txerr=
 >=3D mc->pdev->bec.rxerr) ?
> c11dcee7583027 Stephane Grosjean 2021-07-15  494  				new_state : 0;
> c11dcee7583027 Stephane Grosjean 2021-07-15  495  		enum can_state rx_sta=
te =3D
> c11dcee7583027 Stephane Grosjean 2021-07-15  496  			(mc->pdev->bec.txerr=
 <=3D mc->pdev->bec.rxerr) ?
> c11dcee7583027 Stephane Grosjean 2021-07-15  497  				new_state : 0;
> 46be265d338833 Stephane Grosjean 2012-03-02  498 =20
> c11dcee7583027 Stephane Grosjean 2021-07-15  499  		can_change_state(mc->=
netdev, cf, tx_state, rx_state);
> 46be265d338833 Stephane Grosjean 2012-03-02  500 =20
> c11dcee7583027 Stephane Grosjean 2021-07-15  501  		if (new_state =3D=3D =
CAN_STATE_BUS_OFF) {
> 46be265d338833 Stephane Grosjean 2012-03-02  502  			can_bus_off(mc->netd=
ev);
> c11dcee7583027 Stephane Grosjean 2021-07-15 @503  		} else if (cf && (cf-=
>can_id & CAN_ERR_CRTL)) {
>=20
> Check for NULL
>=20
> c11dcee7583027 Stephane Grosjean 2021-07-15  504  			/* Supply TX/RX erro=
r counters in case of
> c11dcee7583027 Stephane Grosjean 2021-07-15  505  			 * controller error.
> c11dcee7583027 Stephane Grosjean 2021-07-15  506  			 */
> ea8b33bde76c8f Stephane Grosjean 2019-12-06  507  			cf->data[6] =3D mc->=
pdev->bec.txerr;
> ea8b33bde76c8f Stephane Grosjean 2019-12-06  508  			cf->data[7] =3D mc->=
pdev->bec.rxerr;
> ea8b33bde76c8f Stephane Grosjean 2019-12-06  509  		}
> 46be265d338833 Stephane Grosjean 2012-03-02  510  	}
> 46be265d338833 Stephane Grosjean 2012-03-02  511 =20
> c11dcee7583027 Stephane Grosjean 2021-07-15  512  	if (!skb)
> c11dcee7583027 Stephane Grosjean 2021-07-15  513  		return -ENOMEM;

If cf is NULL, so is skb....

> 46be265d338833 Stephane Grosjean 2012-03-02  514 =20
> 46be265d338833 Stephane Grosjean 2012-03-02  515  	if (status_len & PCAN_=
USB_STATUSLEN_TIMESTAMP) {
> c9faaa09e2a133 Oliver Hartkopp   2012-11-21  516  		struct skb_shared_hwt=
stamps *hwts =3D skb_hwtstamps(skb);
> c9faaa09e2a133 Oliver Hartkopp   2012-11-21  517 =20
> d5888a1e75c799 Arnd Bergmann     2017-11-03  518  		peak_usb_get_ts_time(=
&mc->pdev->time_ref, mc->ts16,
> d5888a1e75c799 Arnd Bergmann     2017-11-03  519  				     &hwts->hwtstam=
p);
> 46be265d338833 Stephane Grosjean 2012-03-02  520  	}
> 46be265d338833 Stephane Grosjean 2012-03-02  521 =20
> 46be265d338833 Stephane Grosjean 2012-03-02  522  	mc->netdev->stats.rx_p=
ackets++;
> c7b74967799b1a Oliver Hartkopp   2020-11-20 @523  	mc->netdev->stats.rx_b=
ytes +=3D cf->len;
>                                                                          =
             ^^^^^^^^
> No check for NULL.

=2E..then this code is not reached.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qem4j3f2flcmpazt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGqMKcACgkQqclaivrt
76n0Iwf9HWjl3P35YRJKwX+091fA7NeknznWw1Zaa+9cKnh/7qI50UPvN02Sa87j
GApkLy1LPP6a/BwLycEXaBB//4jf2qIsrOfGUSSJWX2FMugkk3aDEEcWvlSIggxY
W3uymG9hv2rs2uljuZFb5peEYoa+yUL0HG5vI1kOOBayHI7FbNgoMzkcGGT4FGcD
zmQgK18xnd2+EHswrc4nkmw8fs3qju+iZRJeVQqukq6+lkZMhH5RrtBBghWlReOR
5ISuLipLBS9OuIRptaarcWtUQtVjLo2Hjoqw7l2fRdDvK++j/lB0GNVzW7s52BDs
03ahdB1rqW/LMuIZcNxXGffNf6iKdw==
=1km7
-----END PGP SIGNATURE-----

--qem4j3f2flcmpazt--
