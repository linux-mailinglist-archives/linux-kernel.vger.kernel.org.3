Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9720B591090
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbiHLML4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbiHLMLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:11:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531D24949
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCA35B80502
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70047C433C1;
        Fri, 12 Aug 2022 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660306275;
        bh=dAqrv2yaE8n/OaYLt/qwzXO195DO7zq6Y4b0SYUBhWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFNECSV7jB51nrYS8PmwZ1+Atn6MI8t/Rw0UNUueKKAidPgJQdlN8I7OsmfsQKwQ0
         EeN/eAyFva27XYXdGR/jtp4LFGGqBBVAnN5PVl4a7ujPCRuutld6tjgO4TSbB4UYqU
         y7NtIzXMBdlNcMbimU3iY2rKamx5fSxjIS43K97AsrTiPbgp/iKEXd2mzTr0+Xeq+P
         WJmfRrXQQGPm1D66+LTGsBng3VBswfv2W21nKMTTnQs94ZzS+d018LbCZqwkZDeNIR
         h8tq8phyccXTTzlSwlspZzFyVqlSKcVpVJOyiX6i2e7xVzErifso48pAkjZYIowqjc
         aDbUINWNxtbiw==
Date:   Fri, 12 Aug 2022 13:11:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Lu <luminlong@139.com>
Cc:     linux-kernel@vger.kernel.org, shenghao-ding@ti.com, kevin-lu@ti.com
Subject: Re: [PATCH 1/1] drivers: Add kcontrol
Message-ID: <YvZDXivnmHc3pSkw@sirena.org.uk>
References: <20220812031816.6529-1-luminlong@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BaiKfGlomJePEhOj"
Content-Disposition: inline
In-Reply-To: <20220812031816.6529-1-luminlong@139.com>
X-Cookie: No foreign coins.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BaiKfGlomJePEhOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2022 at 11:18:16AM +0800, Kevin Lu wrote:
> Add a new kcontrol for phase calib
>=20
> Signed-off-by: Kevin Lu <luminlong@139.com>

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> +static const char * const phase_calib_switch[] =3D {
> +	"Disable",
> +	"Enable"
> +};
> +
> +static const struct soc_enum phase_calib_enum[] =3D {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(phase_calib_switch), phase_calib_switch),
> +};

To repeat this is a simple on/off control and should be a normal Switch,
not an enum.

> +static int adcx140_phase_calib_get(struct snd_kcontrol *Kcontrol,
> +	struct snd_ctl_elem_value *Value)

*Please* follow the kernel coding style for variable names.  It's good
that you've taken out the hungarian notation but the caps are also bad.

> +static int adcx140_phase_calib_put(struct snd_kcontrol *Kcontrol,
> +	struct snd_ctl_elem_value *Value)
> +{
> +	struct snd_soc_component *codec
> +		=3D snd_soc_kcontrol_component(Kcontrol);
> +	struct adcx140_priv *adcx140 =3D snd_soc_component_get_drvdata(codec);
> +
> +	adcx140->phase_calib_on =3D Value->value.integer.value[0] ? true : fals=
e;
> +
> +	return 0;
> +}

To repeat my previous comments:

| This should return 1 if the value changes, the mixer-test selftest will
| check for this and a number of other issues - you should ensure your
| driver passes that cleanly.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--BaiKfGlomJePEhOj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL2Q14ACgkQJNaLcl1U
h9C9Tgf+OxhHQQ7BBiUYYqx6R+yxBRS8hxSijM/QRXYM5f01/Rp4JCc3UbYlmFSu
3YG9a+3yaBKd6BPc43Q0n1ATLYHYa1cVqTO2leNQrAWYf/bSMZr2MDCRpUcs226v
yRUysEBy460Shtcz4X/eLfmEME7bzkTdJmerOObTx7Ur7LrMOWT99j8OUb82fT23
L5TExT03v61dcIB8T7XM5o8eryGbbJWM5iMGJXi5WKZxANhWeY1eWX+yMOrphlgz
xauHWTagWwYxX1HhMLomnS8JR7WnlbFQRz4KbTwcDiwDBPOkzCnmZgunlurMPpr/
ioxB03rECYmjYmUDABDXH2+Hen5I7g==
=Cf+k
-----END PGP SIGNATURE-----

--BaiKfGlomJePEhOj--
