Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D4A50E197
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiDYNaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiDYN37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:29:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF443FBEB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49597614EC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87E4C385A4;
        Mon, 25 Apr 2022 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650893214;
        bh=a+0NZEJ8nHXpJbL0is/cZVV2TUWQq/Qh4MN4veAvkSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QKsLeTI77/UNLHRaceL0QDzlvbwugACqZoCzXLlKffa6ODqQv3cv0xRsdZ/W8MsH7
         sDHXDHiplW+hnkQge47OP9CZKIHGxSkRicTPNGKU4Lm0epvjzJznLDqW6mStMxvEmx
         8GxGeZwuiIp2nGPXv6BcVlXd3Br0qN+7Rh027E+HSkw4ZFnf82ANF18+VHY0BJajJ0
         7Vd/UPnAf04s2t85JfcDLetnS3lflynNd7NlSi1J+XlcjEs0Dr/CoHEqLp8Y5ugzsd
         Z5/q2H1mpWN1iRZ/wwYLq/khn9HDEfr1vd0DPWjJPdZTHCcszq3A/BesN2P1oxSG1H
         ZcVI/FGYjhELw==
Date:   Mon, 25 Apr 2022 14:26:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Wolfram Sang <wsa@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] ASoC: tpa6130: use i2c_match_id and simple i2c
 probe
Message-ID: <YmahmnPi4B2n29BE@sirena.org.uk>
References: <20220415160613.148882-1-steve@sk2.org>
 <20220415160613.148882-8-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T8rJwMde3z+laYB7"
Content-Disposition: inline
In-Reply-To: <20220415160613.148882-8-steve@sk2.org>
X-Cookie: Last week's pet, this week's special.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T8rJwMde3z+laYB7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2022 at 06:06:13PM +0200, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.

This breaks the build for omap2plus defconfig on arm:

/build/stage/linux/sound/soc/codecs/tpa6130a2.c:322:11: error: initializati=
on of =E2=80=98int (*)(struct i2c_client *, const struct i2c_device_id *)=
=E2=80=99 from incompatible pointer type =E2=80=98int (*)(struct i2c_client=
 *)=E2=80=99 [-Werror=3Dincompatible-pointer-types]
  322 |  .probe =3D tpa6130a2_probe,
      |           ^~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/codecs/tpa6130a2.c:322:11: note: (near initial=
ization for =E2=80=98tpa6130a2_i2c_driver.probe=E2=80=99)
cc1: some warnings being treated as errors

You forgot to move probe() to probe_new() in the driver struct.

--T8rJwMde3z+laYB7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJmoZkACgkQJNaLcl1U
h9BefAf/VDPZ0QQrR6OeJku+HULqwEWbUZpAa/ixPLJa2dPE1oZZDRB2TYdUD1Tt
NccZ3n8Btpt80ic08sQeSAyNMwy35WKJRCKtLQmiXWMQ83XNO+vc0DBAVYxYYZfH
ijjKNYUpNac0Zf1m0hSRdIqsAFoQJ1oMWxIARx5p0SU+RpZqvOesbqrxwsu4ll/Y
EmCwRTJDfFd83r6iz5MpTGk3i4mbQxznMVwCT8zvtAdovGToy8OWD8veBk1Kbmje
cs4eelWdRW2w4/uzV2ljKbyvvwX8defeanZOCxt94moqUjVr5PA/VBj4Yofmxo/1
yJ7li4d0QB/Jcs/bJzUZtcb/19Hdvw==
=g1Ku
-----END PGP SIGNATURE-----

--T8rJwMde3z+laYB7--
