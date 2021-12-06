Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6A8468E58
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 01:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbhLFAlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 19:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbhLFAlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 19:41:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B408C061751;
        Sun,  5 Dec 2021 16:37:51 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J6kzc3N2Qz4xRC;
        Mon,  6 Dec 2021 11:37:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638751068;
        bh=0ZG6xHfrkDkp9Omkj6rzHUrIDFVnDF46v8Sai/KOmPQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Vb+ktFQ97hZnIJ0GliLyIUnnsg8Uv0zuGSV+zeL79sxWjpTOVUU1QNrhW2p08kXSA
         pJkwoYXvUMSHBYb7iBC5LFE7gm3hwkidoKPWCnZ9ulrhZ1Nz5Fzmn61Pp/dkWmA7YA
         O/NN45z0golfEVeU1KtMRU34EMrcJU889w32dVMgGE1ZeZgnw7W6BNERo4r2SuYwuT
         yzh8D7/Sp5mRiZXVk9Zpgt44tnyFz6+5ZI/RuIO8zaSC/8Mu+Io6NmHdrijNM/XnmR
         CPrAPxZ5piZ9AHiXZCtFM3+GEyB23w2Df3dg0Gee+FQ9ikppd6sSvlDbNe15M23Mxt
         ebjzm5/AnaHUA==
Date:   Mon, 6 Dec 2021 11:37:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20211206113745.59692762@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9w+hEwVP3L9zqyX7ILBQaqr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9w+hEwVP3L9zqyX7ILBQaqr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bluetooth tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

net/bluetooth/hci_event.c:6776:24: error: initialization of 'void (*)(struc=
t hci_dev *, void *, struct sk_buff *)' from incompatible pointer type 'voi=
d (*)(struct hci_dev *, struct sk_buff *)' [-Werror=3Dincompatible-pointer-=
types]
 6776 |  HCI_EV(HCI_EV_VENDOR, msft_vendor_evt, 0),
      |                        ^~~~~~~~~~~~~~~
net/bluetooth/hci_event.c:6599:10: note: in definition of macro 'HCI_EV_VL'
 6599 |  .func =3D _func, \
      |          ^~~~~
net/bluetooth/hci_event.c:6776:2: note: in expansion of macro 'HCI_EV'
 6776 |  HCI_EV(HCI_EV_VENDOR, msft_vendor_evt, 0),
      |  ^~~~~~
net/bluetooth/hci_event.c:6776:24: note: (near initialization for 'hci_ev_t=
able[255].<anonymous>.func')
 6776 |  HCI_EV(HCI_EV_VENDOR, msft_vendor_evt, 0),
      |                        ^~~~~~~~~~~~~~~
net/bluetooth/hci_event.c:6599:10: note: in definition of macro 'HCI_EV_VL'
 6599 |  .func =3D _func, \
      |          ^~~~~
net/bluetooth/hci_event.c:6776:2: note: in expansion of macro 'HCI_EV'
 6776 |  HCI_EV(HCI_EV_VENDOR, msft_vendor_evt, 0),
      |  ^~~~~~
cc1: some warnings being treated as errors

Caused by commit

  6b3d4c8fcf3f ("Bluetooth: hci_event: Use of a function table to handle HC=
I events")

There are 2 declarations of msft_vendor_evt() in net/bluetooth/msft.h ...

I have used the bluetooth tree from next-20211203 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/9w+hEwVP3L9zqyX7ILBQaqr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGtW1kACgkQAVBC80lX
0GwFlQf/bkNLdDioAPXAZ76SWlGWfI1U4RqWIx3BwIAZC+knqK5wEl96/HPzw6D4
+/rO72UnbFNL/SphipwMFnb2AtAovOauHnbxa3AaXOCzrflLAxEqs/vep4oNhtGK
v0L0lS8tSYR9MQwLSv23IgHSyJucwG1RoM2EdMgaEUPdJFr/+hWtuzKEcWtulS7i
pWJdeJ892UX2rK17iBpWa2i/j8psxYOGI2h1OFqGNeldlQBVc13yzP9kRLL7KaFW
CbtWqgttLY+7xF9N6xFjwBZaIajaa+GXH21p2+92a1tlEXMdsLHlvLbc2rVdYONX
ARIbqgVVhr/gDSLgsEmomYKxkxSV+A==
=NTqI
-----END PGP SIGNATURE-----

--Sig_/9w+hEwVP3L9zqyX7ILBQaqr--
