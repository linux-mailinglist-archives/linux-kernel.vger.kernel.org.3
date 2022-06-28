Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF2055D855
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245404AbiF1CfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245365AbiF1Cc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:32:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC6125C66;
        Mon, 27 Jun 2022 19:30:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LX7qj0jdrz4yW9;
        Tue, 28 Jun 2022 12:30:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656383441;
        bh=183Ifzju1Y8pI3+aCwyoMpycdvgHXeXxZv4hkg68xc0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h++5nLGGTBccYZfx1SHJn33zeI2+/S1Bki3I/HQYVaw1vig8ZbGX4KK6efplC8JVK
         aq7MmB4wP3baWpPkrIY5Qf1y/e8ZhaiLMPAT4kBY5bEGH/ci06TNSzFkIjf6+Bn1wl
         FGH1VJ7d4VzhRUf/X/fVa165h/xQLTOl1REdOvnWJhzhK27JMHW0jV7FtzJu1Obk0K
         n2u7sOsVeCXYkRH9nENa2mUWMHsSD1+6owR9bphsaR7VcDjERRTuGUMng2yI7EGor9
         WarTTYKCzTHmgBQMZtjrHQTJ51J3y/rkpyDuupHfbgoCf4AwtnwlApPIB/H8im/l9l
         vWTxkHl/8S8MQ==
Date:   Tue, 28 Jun 2022 12:30:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the battery tree
Message-ID: <20220628123035.167f28ea@canb.auug.org.au>
In-Reply-To: <20220624124730.3516928c@canb.auug.org.au>
References: <20220620104503.11c0f2e1@canb.auug.org.au>
        <20220624124730.3516928c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Uek7JuHLB.xW/WUpLGaHjbb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Uek7JuHLB.xW/WUpLGaHjbb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 24 Jun 2022 12:47:30 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 20 Jun 2022 10:45:03 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >=20
> > After merging the battery tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > drivers/power/reset/pwr-mlxbf.c: In function 'pwr_mlxbf_probe':
> > drivers/power/reset/pwr-mlxbf.c:67:15: error: implicit declaration of f=
unction 'devm_work_autocancel' [-Werror=3Dimplicit-function-declaration]
> >    67 |         err =3D devm_work_autocancel(dev, &priv->send_work, pwr=
_mlxbf_send_work);
> >       |               ^~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >=20
> > Caused by commit
> >=20
> >   a4c0094fcf76 ("power: reset: pwr-mlxbf: add BlueField SoC power contr=
ol driver")
> >=20
> > I have used the battery tree from next-20220617 for today. =20
>=20
> I am still seeing this failure.

I am still getting this failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/Uek7JuHLB.xW/WUpLGaHjbb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK6Z8sACgkQAVBC80lX
0GzPCAf9GHvzifB5AcyMJZcEIZ/RNOzafUZUidclYNN5KWYN5fXSdVTVvaJgFtdN
4ESjGa+8Sa4TL8e8V91yGnJPh0v0nsJflton7WGpGIKTY/oImismVd1o8aX55D/U
NYh68pVRDCAupOo9EhiJpqqyEFx8w5VhMKXso6xd7pFolGru4BdwpoPpb2zeXMB1
/1Ws3fP9BQxzzXwoUd4RsBncYwOWt5QcC7Lc14Kxh1mFXQ47c+LCwGedXihAnBHv
2JbF9yeJWoN9Yp8p5w+cYAiNJyhCVDJ5S/7GxJKvj9YabTjBm2lfrG0XA51/JgXf
NT+TLl38KBxpg18G6mXBLmhMpBW0/g==
=r89t
-----END PGP SIGNATURE-----

--Sig_/Uek7JuHLB.xW/WUpLGaHjbb--
