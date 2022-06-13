Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A16548239
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbiFMIfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiFMIfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:35:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE941409A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:35:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o0fXr-0006k5-AI; Mon, 13 Jun 2022 10:35:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o0fXq-000GDa-7j; Mon, 13 Jun 2022 10:35:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o0fXo-00G0Mf-Rf; Mon, 13 Jun 2022 10:35:32 +0200
Date:   Mon, 13 Jun 2022 10:35:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mmc: sdhci-of-arasan: Obviously always return
 success in remove callback
Message-ID: <20220613083532.thz4pi7mequqlrp6@pengutronix.de>
References: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
 <20220610211257.102071-4-u.kleine-koenig@pengutronix.de>
 <c0a313ac-20b9-2d1a-4c10-9ba57c62ae95@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sr7shbna5h5acpmw"
Content-Disposition: inline
In-Reply-To: <c0a313ac-20b9-2d1a-4c10-9ba57c62ae95@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
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


--sr7shbna5h5acpmw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2022 at 10:13:16AM +0300, Adrian Hunter wrote:
> On 11/06/22 00:12, Uwe Kleine-K=F6nig wrote:
> > sdhci_pltfm_unregister() returns 0 unconditionally and returning an
> > error in a platform remove callback isn't very sensible. (The only
> > effect of the latter is that the device core emits a generic warning and
> > then removes the device anyhow.)
> >=20
> > So return 0 unconditionally to make it obvious there is no error
> > forwarded to the upper layers.
> >=20
> > This is a preparation for making platform remove callbacks return void.
>=20
> This preparation seems a bit unnatural.

IMHO it's not. I have to adapt all ~4800 platform drivers together in a
single commit to change the prototype of the return callback.

Now assume you want to review that commit and make sure there are no
relevant changes in behaviour. Without the preparation in the commit
under discussion, the change to sdhci-of-arasan.c would look as follows:

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of=
-arasan.c
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1733,7 +1733,4 @@ static int sdhci_arasan_probe(struct platform_device =
*pdev)
=20
 static int sdhci_arasan_remove(struct platform_device *pdev)
 {
-	int ret;
 	struct sdhci_host *host =3D platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan =3D sdhci_pltfm_priv(pltfm_host);
@@ -1747,11 +1746,11 @@ static int sdhci_arasan_remove(struct platform_devi=
ce *pdev)
=20
 	sdhci_arasan_unregister_sdclk(&pdev->dev);
=20
-	ret =3D sdhci_pltfm_unregister(pdev);
+	sdhci_pltfm_unregister(pdev);
=20
 	clk_disable_unprepare(clk_ahb);
-=20
-	return ret;
 }
=20
 static struct platform_driver sdhci_arasan_driver =3D {

So you have to look up then what sdhci_pltfm_unregister() does and if
it's ok to ignore the return value. Should I mention that in the commit
log? What about the other drivers?

If however the change to the sdhci-arasan driver is only

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of=
-arasan.c
index 3997cad1f793..84c949bd99c8 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1749,8 +1749,6 @@ static int sdhci_arasan_remove(struct platform_device=
 *pdev)
 	sdhci_pltfm_unregister(pdev);
=20
 	clk_disable_unprepare(clk_ahb);
-
-	return 0;
 }
=20
 static struct platform_driver sdhci_arasan_driver =3D {

, it's trivial to see that there is no relevant driver specific change.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sr7shbna5h5acpmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKm9swACgkQwfwUeK3K
7Aki2wf9F0ud30c2kemIUfXTupGIbY73km9wA/ibaQq0zJy5/F1D3fQ8+zknouGq
nVWT4pVthEfmJV7/8ePylDmyBgViV91ptCtoB+7v8XAD9Z2pOMTIaCxCYemL8j+N
ZHCfLAToYr8VhT/dl/aSo5D2A6MSgDZvJ/oYsblcfAT9n5+B8OjNOOaxy3Mp2PMj
cS3Qi/ga+BgZWuwY55a9s9YVOPET5CynD4OS9ISKqMM9jBP5g4RgCZBH3639WsQr
hDE7zqf/rMKVmI86G2yntjdOa+drraU0A2F+4ejrNcpON4bb30U5EY/B0nx+snV6
n89+vPr2lYI3esEBcSrboGXIW9YuHQ==
=e9uP
-----END PGP SIGNATURE-----

--sr7shbna5h5acpmw--
