Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B791550E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiFTArA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbiFTAqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:46:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918BDDFE4;
        Sun, 19 Jun 2022 17:45:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LR9sX41bJz4xD7;
        Mon, 20 Jun 2022 10:45:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655685904;
        bh=fZsJ+YoSpqHTBQV/80b74IIOHcEdhT9gIgEtsHi9Wlk=;
        h=Date:From:To:Cc:Subject:From;
        b=j6KArQv1GhY2ZVdaE0Z0kJbi75oHQV3uGvh1i/VTYX0H2DKqF1mLvUe4+nSB+Hyyo
         f3RmsMAp378bu9cf9s8DqNXNA9Q7z+Z6wlDYV7Jh4ISb6zaR3KGxUfLTFeRFYOpZF6
         nwooTWVd9qgqXYFZdxB1R/F41ZXhOndS8BtEKDhR4Tx1AIL/hfhufEs3FTZOkfAh0d
         ZQGHYt4Sw5v9HfTKctTD49LFs+RxKzfOY8Is2l2lmi08rPsNWjgGMThVp0FANUOzIY
         SX2idDzN4reIj30H0xcktGBe2NLfGJVXJ8m7xkzJevjzXBmAvGx/4KWiRI2X/8NSJT
         RzqHJx2As1NZw==
Date:   Mon, 20 Jun 2022 10:45:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the battery tree
Message-ID: <20220620104503.11c0f2e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9sxveIozfBx0WVjxIM+1Yax";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9sxveIozfBx0WVjxIM+1Yax
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the battery tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/power/reset/pwr-mlxbf.c: In function 'pwr_mlxbf_probe':
drivers/power/reset/pwr-mlxbf.c:67:15: error: implicit declaration of funct=
ion 'devm_work_autocancel' [-Werror=3Dimplicit-function-declaration]
   67 |         err =3D devm_work_autocancel(dev, &priv->send_work, pwr_mlx=
bf_send_work);
      |               ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  a4c0094fcf76 ("power: reset: pwr-mlxbf: add BlueField SoC power control d=
river")

I have used the battery tree from next-20220617 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/9sxveIozfBx0WVjxIM+1Yax
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKvww8ACgkQAVBC80lX
0Gwawgf/e3NZE+XICcPMn54eB39haSJZWGSl8LGjjfJtJ6a5LTttl4QsopZFC3gZ
nGBjYazcRl9yWSj6ooYfL5Aho9lLWs9cGG+63dSOs21SSjGcgYyKt3cZMETo6rLg
gzn0paxkcoqLYDnXbN5THWpaJ9b12ZW/Zlc5D6dWBnwRa1KpC0E5Jq4Xao7I97Yb
CwTrPWqdE+vHSS5IcIFlFvLDoUft3Ed+zUVYx5nYwM0qwtEVmr7XPzgr9GHNiJ6k
HExjp6BX53RxSmHGrTlA61aoeuQrOQJfDAGT5lZYr9SjVcZvv+tllNNgMm0msEx3
1ZSgR9TqQCIrmvM6FXo/0LTYjqFzHw==
=Oys2
-----END PGP SIGNATURE-----

--Sig_/9sxveIozfBx0WVjxIM+1Yax--
