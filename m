Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96557F7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 03:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiGYBC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 21:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYBC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 21:02:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D1E9FCF;
        Sun, 24 Jul 2022 18:02:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lrhbw1tl0z4xD0;
        Mon, 25 Jul 2022 11:02:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658710972;
        bh=xfEOERNDo1y78gzbb41CwS+nnW2OQPeiP9gx+SiTJl8=;
        h=Date:From:To:Cc:Subject:From;
        b=HbipA9aN4LsE1W4mLHLwSoDoZ93S9qulibjTtuHb/tg0pUhBKdvhyLqpgryJxYKYL
         kHob/liqzNMMQzEWc26FRl71jA30YBL/IGu2IxPdwJHLwzfHpc0nOj2nQwkV8BonHD
         h8VAWK4o6XZZLPKAoa1OZkHSCpRYgqKSA2OkB/Ify1TrCC3Z4ow7JeNCFnbo+WPn/E
         n0uXaUMdEROcmZLvRyYKX0Lhhige/EGpFnqnV5d+rALvbJlSam5PpSXz5Ug88Fmvq3
         eeQ+AQnd+NKZH3Xyx3rLjMfRsmXYSeD5ptgChKSBLpNVY4l33se8HTbCzeXByMUaXd
         YSMlFy7aVggBQ==
Date:   Mon, 25 Jul 2022 10:40:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Aashish Sharma <shraash@google.com>,
        "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hid tree
Message-ID: <20220725104035.15c2e506@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7aL2RUTZ9Y_UU8Kn98AtOq7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7aL2RUTZ9Y_UU8Kn98AtOq7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/hid/hid-nintendo.c:1514:29: error: redefinition of 'JC_RUMBLE_ZERO_=
AMP_PKT_CNT'
 1514 | static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT =3D 5;
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/hid/hid-nintendo.c:295:29: note: previous definition of 'JC_RUMBLE_=
ZERO_AMP_PKT_CNT' with type 'short unsigned int'
  295 | static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT =3D 5;
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  669abca7b767 ("HID: nintendo: Fix unused-const-variable compiler warning")

interacting with commit

  92cdfba40155 ("HID: nintendo: fix unused const warning")

I have used the hid tree from next-20220722 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/7aL2RUTZ9Y_UU8Kn98AtOq7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLd5oMACgkQAVBC80lX
0GxLMQf/W31AAm/LuLpBtJpF7vvmp9HNYBiyY3JqfdOoLbPgKyZDlN8dR6teMqiU
Rl5z5CmQCQ3WLtGo2DcQqyvN5MlOoXNjfjnDVHzqEb4vZR2eiNLcEywJKWkw11xG
e43YY/gHtjrTfg8Ci/JJM5vpCMtiXMA8gdU+PUqUhpnPcmKnrRYb00rEFyP8UmVJ
EfaKfG6MwS/6UX4DYUrcQQiWjeC4OAkW/Y3NPGkuEUSl0aNDLqa6/2IQAnbBYu9R
34kND5ud6WVLLWXdJuQPL5P1fwuQx+h3nZM7Xalb+dhsal0uSzbU2kbe4+m5Jg93
9fjhtRrsafELRmEupolKeZjgMJKdlw==
=KS1z
-----END PGP SIGNATURE-----

--Sig_/7aL2RUTZ9Y_UU8Kn98AtOq7--
