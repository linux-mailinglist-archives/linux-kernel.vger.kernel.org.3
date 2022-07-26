Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5658116A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiGZKrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiGZKri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:47:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B817237E0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:47:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32CC360A1E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB0DC341C0;
        Tue, 26 Jul 2022 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658832456;
        bh=ci/EEXJm+0aiaYmwA6HNzBCEI0fWGk+Bm/b7csyVWHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yk/LBf0yH+zt7E0wDUR5SpFbGsoBYCwikzqadLeixwt08orqi0hjgIHvEbq3xRp82
         liTd5bhrYdXUz9S/m8IuayYGRq9YVkhM3maUfNvDiZV8eURadjZoWZOqVWmXNmwYbT
         ApEtZThUc36vjsmADT4hYaJkEImhovw5gjm5QCI6MZnOZR5Ny4JtP/drsjlIuvhIb4
         6Yxd062jcHAYO581QwQ2dPblQBgBOZioN9ShG5vqZ1e9zDkkfAGDYxNRws+6/jGs+h
         MJKEWwcCY740a+h+rMOTA9LVrl1IGZYOmIjp+FblBAX6nW1ECiiAwAtltbCk4TFGmN
         DW3XCNSoyPrPw==
Date:   Tue, 26 Jul 2022 11:47:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ASoC: mchp-spdiftx: remove references to
 mchp_i2s_caps
Message-ID: <Yt/GQ80pj2JiRA0a@sirena.org.uk>
References: <20220725130925.1781791-1-claudiu.beznea@microchip.com>
 <20220725130925.1781791-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ck+mz0KY5S4xoQrf"
Content-Disposition: inline
In-Reply-To: <20220725130925.1781791-4-claudiu.beznea@microchip.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ck+mz0KY5S4xoQrf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2022 at 04:09:23PM +0300, Claudiu Beznea wrote:

> @@ -782,11 +780,6 @@ static int mchp_spdiftx_probe(struct platform_device=
 *pdev)
>  	if (!dev)
>  		return -ENOMEM;
> =20
> -	/* Get hardware capabilities. */
> -	match =3D of_match_node(mchp_spdiftx_dt_ids, np);
> -	if (match)
> -		dev->caps =3D match->data;
> -

This breaks an x86_64 allmodconfig build:

/build/stage/linux/sound/soc/atmel/mchp-spdiftx.c: In function =E2=80=98mch=
p_spdiftx_pro
be=E2=80=99:
/build/stage/linux/sound/soc/atmel/mchp-spdiftx.c:766:29: error: unused var=
iable
 =E2=80=98np=E2=80=99 [-Werror=3Dunused-variable]
  766 |         struct device_node *np =3D pdev->dev.of_node;
      |                             ^~
cc1: all warnings being treated as errors

--Ck+mz0KY5S4xoQrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLfxkIACgkQJNaLcl1U
h9D77gf/bl83AEFzuWVWM277by6LYfmiOQGjOsbYdS0yiwS8s1eCd+HXf5d+EweF
MQuMRPpBIfU3XGNJlBM3SQOmhzMIUdRN9Dvg8c1xJ7gaa0TTGApwyW6HQvHTurfV
zGF0dVXz//tufIcn5WLmIX1cQiCs17yswvnH5EZ6nLuaUyCvr00zT7jPgciy4toR
TKQKbpYJ07B09nW4ppFAGk8ugQCPpC7tJ70dBhj4rSOTLqAHNApMR5N2v6mpJ0Rg
9epAgxxjzaqgIDwC0t7Pfp5KMGuD3czaT82riH4O+K4GRLHNn9cJYu7LThuk3f0W
U4zvcoUSL+7KVF+qhjk4Fdw1AV3SLQ==
=YTMR
-----END PGP SIGNATURE-----

--Ck+mz0KY5S4xoQrf--
