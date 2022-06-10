Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA715465FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbiFJLsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345490AbiFJLsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:48:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7159DC4EA3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35965B83125
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64432C34114;
        Fri, 10 Jun 2022 11:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654861694;
        bh=Oa42FrDX9SAL3GgVXXJClDSCVxDWXe2Bxa0EkqA/4Vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1xzeGYvoPCBu/ecVmTQwZn+lwurLiLyJmitLb7wERxfmympx7BU0Ur68VBWbAGku
         Z3sWYZKggLE55kmjB+qCDbQTa6BOGbXuarpImfyKCqxCmMGxuBn4MMGm5JzEz+/uP8
         Nhcpb1wpb4yvqTfdJuV5WCjnFnJNT3rAUfEfAAQXKt9O/Kfz5EgWz+VZ7VDDFTNly/
         su+w4rjSUhkBYJWI+36Xx1iy2CWV9TQH5ANbb8Wq6J/fgbh1oBCUCyia6i0nfxvFgI
         ijgNiFwmQmasZLBMK8aq05UlN1X79fTM7Z1xY07IVISG7W3USUubCfHqIhb8GBE0MR
         4U4e35Rm9H8yQ==
Date:   Fri, 10 Jun 2022 12:48:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 3/3] ASoC: wm8940: Mute also the speaker output
Message-ID: <YqMveGXbwMhLeo4M@sirena.org.uk>
References: <20220606154441.20848-1-lukma@denx.de>
 <20220606154441.20848-3-lukma@denx.de>
 <Yp4qb5jaGYf5qnxt@sirena.org.uk>
 <20220610112331.4dcc183b@ktm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kPV9gyCZ3tfx091g"
Content-Disposition: inline
In-Reply-To: <20220610112331.4dcc183b@ktm>
X-Cookie: Teachers have class.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kPV9gyCZ3tfx091g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2022 at 11:23:31AM +0200, Lukasz Majewski wrote:
> > On Mon, Jun 06, 2022 at 05:44:41PM +0200, Lukasz Majewski wrote:

> > > Without this change the BTL speaker produces some
> > > "distortion" noise when test program
> > > (speaker-test -t waw) is ended with ctrl+c. =20

> > > As our design uses speaker outputs to drive BTL speaker,
> > > it was necessary to also mute the speaker via the codec
> > > internal WM8940_SPKVOL register with setting
> > > WM8940_SPKMUTE bit. =20

> > This will not interact well with both the user visible control of the
> > speaker volume via the Speaker Playback Volume control and the analog
> > bypass paths that the device has - it'll change the state of the
> > control without generating any events, and cut off any bypassed audio
> > that's mixed in.

> I'm wondering why it is safe to call DAI's .digital_mute()
> callback, which explicitly changes state of the "DAC soft mute enable"
> bit (DACMU) ?

If there's a user visible control for the same register bit that's a
bug.  If there's no user visible control for it then there's nothing to
conflict with.

> And on the other hand it is not correct to just mute the speakers?

No, that's not what we're muting playback for - the digital mute is
there specifically to deal with issues with host controllers outputing
noise during startup/teardown.  If there are issues with the speaker
output then they need to be addressed at that point, especially given
that the device has bypass paths.

> > You can probably achieve a similar effect by making the control an
> > _AUTODISABLE one which will allow the core to mute the control when
> > it's not being used in a way that's not visible to userspace.

> The exact definition for the event, which I'm forcing above:

> SOC_SINGLE("Speaker Playback Switch", WM8940_SPKVOL,  6, 1, 1),

> And there is no SOC_SINGLE_AUTODISABLE() macro available.

That seems solvable?  Though if the issue isn't triggered in connection
with a DAPM event (which sounds like the case) then it's probably not
going to help.

> The issue I'm trying to fix:

> - The mclk clock is stopped (after some time) by imx SOC when I end
>   'speaker-test' program with ctrl+c.

> - When the clock is not provided (after ~1sec) I do hear a single short
>   noise from speakers.

> - The other solution (which also works) would be to enable clock once
>   (during probe) and then do not disable it till system is powered
>   off (yes it is a hack :-) ).

If the issue is triggered by the MCLK being disabled prematurely then
the simplest fix is probably to wire up the CODEC MCLK to the clock API
and manage it during set_bias_level() (probably on transition out of and
into _STANDBY) - that should have a similar effect to leaving it enabled
all the time.

--kPV9gyCZ3tfx091g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKjL3cACgkQJNaLcl1U
h9DwXgf9Eqq0qI5+Aw9AhO+y+X3Rc2s2lb059a1Ftb2g9zunZ5OEQQr5Cf8o4cDP
N//WRbzdOsY6YWdCTFY0W+8U6ZIA43UZ/Ouce9NJhdBjqDEWgAXvN33Jr43/0umY
1cQ8acjZEIC6S6DUPMCqpeF14pXIZwROgq/fUHfuO+nQA9t2sM2c2dbd8LsoUiJj
tcU5CNuWbt1KVvSKmQv4H1tjcvEO+6M+8b28yGtPLPptniUGYxWCQkvbCeDGW5c/
Bttcy6yX7JL8351r2XEsStUAQJlPFE93i9ljwCTrXgVmGky9cdrSfEchQHAJnh78
mk18imjyrb1WLLMLHzBsgiGQpSH39A==
=EJBV
-----END PGP SIGNATURE-----

--kPV9gyCZ3tfx091g--
