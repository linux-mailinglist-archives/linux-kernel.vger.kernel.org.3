Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16646546207
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348506AbiFJJ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244365AbiFJJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:26:54 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60684F47E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:23:40 -0700 (PDT)
Received: from ktm (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id AF81E83DFE;
        Fri, 10 Jun 2022 11:23:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1654853018;
        bh=5weI8ThFC9uRaLOv9c3iXamNh9h427e4N5Q5IBoMeLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lQPNjVazUi1IWi0Edu2lkBtFEnjDd+uztvzyip15bbk/uS4uan2GsP5lo13vAIMuJ
         vPbwv78Ewi/w9XD5bof+XwiJlREVbCiUvfqcby+40+lrA675A025upX9dESktvRoOA
         ZiR1erXnQ4cxrtr7pg2whiYAlDJZOSGRq+oTpTgNpm85kmODnv59oVJEftgm3S8zvt
         1XdJvGIFgu/KvEkNHVEX9rJGelNlASRpshYMgIGy41u4+ERkoyBGgHJCmHx55MEyKT
         Hq9VJztTdqUhQmdFSLJii/LKiUEflEoTQS5IPNmyMZPnkAkDnRcM2XHZqt9yib2D+U
         v012UucOCfYDg==
Date:   Fri, 10 Jun 2022 11:23:31 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 3/3] ASoC: wm8940: Mute also the speaker output
Message-ID: <20220610112331.4dcc183b@ktm>
In-Reply-To: <Yp4qb5jaGYf5qnxt@sirena.org.uk>
References: <20220606154441.20848-1-lukma@denx.de>
        <20220606154441.20848-3-lukma@denx.de>
        <Yp4qb5jaGYf5qnxt@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/oEf7duWcwTr6LfWwV/Z47nI"; protocol="application/pgp-signature"
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oEf7duWcwTr6LfWwV/Z47nI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Mon, Jun 06, 2022 at 05:44:41PM +0200, Lukasz Majewski wrote:
>=20
> > Without this change the BTL speaker produces some
> > "distortion" noise when test program
> > (speaker-test -t waw) is ended with ctrl+c. =20
>=20
> > As our design uses speaker outputs to drive BTL speaker,
> > it was necessary to also mute the speaker via the codec
> > internal WM8940_SPKVOL register with setting
> > WM8940_SPKMUTE bit. =20
>=20
> This will not interact well with both the user visible control of the
> speaker volume via the Speaker Playback Volume control and the analog
> bypass paths that the device has - it'll change the state of the
> control without generating any events, and cut off any bypassed audio
> that's mixed in.
>=20

I'm wondering why it is safe to call DAI's .digital_mute()
callback, which explicitly changes state of the "DAC soft mute enable"
bit (DACMU) ?

And on the other hand it is not correct to just mute the speakers?

> You can probably achieve a similar effect by making the control an
> _AUTODISABLE one which will allow the core to mute the control when
> it's not being used in a way that's not visible to userspace.

The exact definition for the event, which I'm forcing above:

SOC_SINGLE("Speaker Playback Switch", WM8940_SPKVOL,  6, 1, 1),

And there is no SOC_SINGLE_AUTODISABLE() macro available.


The issue I'm trying to fix:

- The mclk clock is stopped (after some time) by imx SOC when I end
  'speaker-test' program with ctrl+c.

- When the clock is not provided (after ~1sec) I do hear a single short
  noise from speakers.

- The other solution (which also works) would be to enable clock once
  (during probe) and then do not disable it till system is powered
  off (yes it is a hack :-) ).


I'm wondering if this can be fixed by some 'amixer' user space switch?

Thanks in advance for help.

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/oEf7duWcwTr6LfWwV/Z47nI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmKjDZMACgkQAR8vZIA0
zr2CUQf/cMiEn0CiJcSLLczk6LXmGNX0z7B7luu7hDG27kP/cyJH42qi50TI8cRg
eF8C0FxzKATJ6yt9I70mXvYsSZOeadZUbvKxuS40twZgIowbtuIDXwXIaOFTuC1D
haC6/3iQSLq0CUYZfPO+4SJKXGIUsGa7pu/Tr+BdlPWqhhb5kmS/4QTTAhlhEh+a
S0QHrJxahiouJL53wgvYBZibmsgnVAr83T+tTGI7zZ9g/mhdUOdnZ1N0eLrbSRC4
EsNfnNPvB/xkj7gouSrugdg4eQxF4drpJDmUrgMwNIMxQxK9gGdWHU41TVuUU4xw
2MD+/qf7xGmZqKGM2qUaFUAGsbwnrw==
=vKPT
-----END PGP SIGNATURE-----

--Sig_/oEf7duWcwTr6LfWwV/Z47nI--
