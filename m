Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B853148F7F1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiAOQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:42:07 -0500
Received: from mail-4317.proton.ch ([185.70.43.17]:32554 "EHLO
        mail-4317.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiAOQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:42:05 -0500
Date:   Sat, 15 Jan 2022 16:42:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alfasys.se;
        s=protonmail2; t=1642264923;
        bh=osBdiWyUWB5UFKuwp0VI80b3Eq7SBrPOORm6P2M1jNA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=vz+gD4GgUFyAufrGY4iE5StS6HmqNtoniKhz3TlA1KsyctiBmzK4isbv0y9//Q4FM
         QalwHxT7ngX4aLU/VvcHLM8FrMoFIn7lJEr/4tJ+nVx5qg+HMitW2e1Sij9PpymjCr
         aHdcFieLqrjBNT3CCXR2631wcVuwl5SlmPUmM9edwk0IaJuoEZJ3OQf1M+LQDxS7a6
         gSD+g5cjUSN8HZlrNkqTcaXhFW7DWkc4d6rATS8kyi0usTEha2sg+PDISSVzPjnubY
         CSKiq7s613slY7csGKFEEqHRXuTWkmYSrH5IfsJXpFv4xIXWMSSuwobu1O+1+Rr/pz
         ofRor/Rml7vLw==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Alfasys <alfred@alfasys.se>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>
Reply-To: Alfasys <alfred@alfasys.se>
Subject: [PATCH 001/001] UIO: allow binding uio_dmem_genirq to devices using command line options
Message-ID: <qFul607Amxy21SnrHljzWlk1zF1aanKgSpEIH0--hvj9t9wRzQR5xx80eFgl_2I6pppi8NNFp0TTHwkQw0uQD0Xl-8vth8-KOsbfwrLIHNg=@alfasys.se>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------1a12312c1b586c2261ba94b99a2075ad2fd891cff25605e68e3b11db1bbaca1e"; charset=utf-8
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------1a12312c1b586c2261ba94b99a2075ad2fd891cff25605e68e3b11db1bbaca1e
Content-Type: multipart/mixed;boundary=---------------------979133eaa6260ebbf7515c2184d6b46c

-----------------------979133eaa6260ebbf7515c2184d6b46c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Add an option to bind the uio_dmem_genirq driver to a given device
using command line options.
Make uio_dmem_genirq match uio_pdrv_genirq functionality added in
commit 05c3e0bb5629 ("UIO: allow binding uio_pdrv_genirq.c to devices =


using command line option")

CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Signed-off-by: Alfred Patriksson <alfred@alfasys.se>

---

git diff c9e6606c7fe92 #(tag: v5.16-rc8)
diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 6b5cfa5b0673..7f6c9b594dd4 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -317,10 +317,13 @@ static const struct dev_pm_ops uio_dmem_genirq_dev_p=
m_ops =3D {
 };
 =


 #ifdef CONFIG_OF
-static const struct of_device_id uio_of_genirq_match[] =3D {
-       { /* empty for now */ },
+static struct of_device_id uio_of_genirq_match[] =3D {
+       { /* This is filled with module_parm */ },
+       { /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, uio_of_genirq_match);
+module_param_string(of_id, uio_of_genirq_match[0].compatible, 128, 0);
+MODULE_PARM_DESC(of_id, "Openfirmware id of the device to be handled by u=
io");
 #endif
-----------------------979133eaa6260ebbf7515c2184d6b46c--

--------1a12312c1b586c2261ba94b99a2075ad2fd891cff25605e68e3b11db1bbaca1e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKAAYFAmHi+UUAIQkQUNpnjRayphAWIQSeloIZhOMBIRON26tQ2meN
FrKmEDDEAP937pgEUdJoUDIxWsSqd1USB2GnGeb3W+/z6f/5FcjwuwD+OkKe
UkVHYJRvikadEwl+uNZQLYkfp3aejTBB9IQaaQw=
=9Siu
-----END PGP SIGNATURE-----


--------1a12312c1b586c2261ba94b99a2075ad2fd891cff25605e68e3b11db1bbaca1e--

