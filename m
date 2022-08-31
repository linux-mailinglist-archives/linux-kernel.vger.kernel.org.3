Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2375A7F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiHaNjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiHaNjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:39:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E634A6C00
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:39:01 -0700 (PDT)
Received: from mercury (dyndsl-091-096-057-024.ewe-ip-backbone.de [91.96.57.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B072F66015AB;
        Wed, 31 Aug 2022 14:38:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661953138;
        bh=D+wIuqiZWeu7gavN5pedRVH0S1gDSqd8NQkvdp6C2jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IE55y2Vb7Ty9a/IkmCOdZHGF/Z9j7s6sAaHhsMGr18bGZ+5ffugYMp6huKUrKQJYO
         aEMmzoFpctXzWUrCRD9slFfU16gxIGf13nWN/t6z9esmvoLol/sbaH3oo0jkmQJspe
         6j9ZxlxyIHSG650NrcFuxmKOMjmRKi7LNHXiR6d/c9b4rmo/MXpvI6iNmW7Im65GGz
         yWRq9n9Nq/dDlpex/I8jddy0lKk+/Os51ecf93oDGKNd6h3/tXXFt+AI3idygkyJKA
         wtmEIwrWujqQxaqZJ8PTMnfTI+0drHR89t3jmIHc/b8GNJf5I62F1e+55SrqrhQ+nY
         itKXIBV/cuHcQ==
Received: by mercury (Postfix, from userid 1000)
        id 90ECE10607B6; Wed, 31 Aug 2022 15:38:56 +0200 (CEST)
Date:   Wed, 31 Aug 2022 15:38:56 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] HSI: cmt_speech: Pass a pointer to virt_to_page()
Message-ID: <20220831133856.paa3v4ve3dorppdu@mercury.elektranox.org>
References: <20220519212943.778610-1-linus.walleij@linaro.org>
 <CACRpkdamFTCuCTYX-Y_-HHM_WBQgwDbiud1pA_Xn3V2zm2zj_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ccex6t7vgmh6k35i"
Content-Disposition: inline
In-Reply-To: <CACRpkdamFTCuCTYX-Y_-HHM_WBQgwDbiud1pA_Xn3V2zm2zj_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ccex6t7vgmh6k35i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 29, 2022 at 03:16:03PM +0200, Linus Walleij wrote:
> On Thu, May 19, 2022 at 11:31 PM Linus Walleij <linus.walleij@linaro.org>=
 wrote:
>=20
> > A pointer into virtual memory is represented by a (void *)
> > not an u32, so the compiler warns:
> >
> > drivers/hsi/clients/cmt_speech.c:1092:35: warning: passing argument
> >   1 of 'virt_to_pfn' makes pointer from integer without a cast
> >   [-Wint-conversion]
> >
> > Fix this with an explicit cast.
> >
> > Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Sebastian can you apply this patch to the HSI tree please?

Thanks for the reminder. It's queued now and already in linux-next.

-- Sebastian

--ccex6t7vgmh6k35i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMPZGQACgkQ2O7X88g7
+poXAA/+JEjkQagA5HYuy6U8hD58V8vqcoeXGYQ3TRn8XnNNu/ai4rzFkqCtDUCP
QetfVratZTpAqaupcPKDAhWNi64HnLrPuJIsyefj9LtYvnZSAIz7gUeIWLHqookp
a0Y7v4/+NT7Td3kuHc11ottBRCwOC5Lpj3NJYA2bnbTCHwg9XqQrhlV0xBoC6egr
iaUVPl/hcknVBAyPJ3pLAepSqaKTi9A0HXtovbJ8IBlOxObgXEbPbFucK+DknPmu
xd+fU7fgPwwf9d/5m1SJ332Zz85eoRYwcCCpM/XNeBiNAq/q9IiOhG1CYMewJQQk
MNfPBaetNS4UIgjMA5uYAKQrMys7rjXL49qSMGvI6Zuk/4ud2JOGdHt2NNIfAMaJ
ApbDLvf/qDUfuuG8DbeFrhZpFz4yxsSN63LyQ77j0PqDXCwJL/hhDq40Ljh6n/ZW
55McjHyjIxNXJzSjSAZi2rA9cwBYS1LBdr/lWE5XHglpMk43gD7HkCSD94nMqTOZ
9BuXKEgqEr74Pps5E+Lbn7ohD4kdxl+bfM/YYPNN323vIdd2kSwiOdYwafRzwiwR
wj2ykTwbNuMphwtkrnEaI+93DC0TjbVqnTp01C6coW+qyw6GBpSrPPsUAigaLxp3
2NKiUgz0zszfn7upgxvhXP6BA7NwaZjiLaxO4x92Bo7PA6ipdAM=
=AFhS
-----END PGP SIGNATURE-----

--ccex6t7vgmh6k35i--
