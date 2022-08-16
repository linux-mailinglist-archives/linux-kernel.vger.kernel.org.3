Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E73595B65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbiHPMI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbiHPMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:07:34 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2851A23
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:57:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id A0B622B05957;
        Tue, 16 Aug 2022 07:57:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 16 Aug 2022 07:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1660651030; x=1660658230; bh=Bq03lVvJy5
        RJk5H2jo3OulUHY8HxQaSHcH39oL5pRFM=; b=LWkNGdC+qKavdgb06LCYhhdfaH
        EMilD3yNruebG4rdFpIEf/I4xnlrJyUn9xE6NIN3HxPA7FdOTeBHXU54ELxt9Vts
        /TEy3DDaL05UnzuFbzp2mP5cLACMIbB1dNecnbiMUWk1IVGBETPJ+1uhAqwZPoDH
        fqM7mZZE9VPgjTXmenP2OT8fEAzuk3AGPtUl/tpH1snsTs4n6xmjP7Fesne8J80k
        wsGf/8lSANiEam48J/7VUsCDx0BsEiyQMAHoo61crP6hQEIMd4HTPwEXsyDhCTYE
        LxurXivClkNnluoJqMoobh2U7tkI2YB30ImyM9+0Y7ar/9uTb7qZdpIGkfrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660651030; x=1660658230; bh=Bq03lVvJy5RJk5H2jo3OulUHY8Hx
        QaSHcH39oL5pRFM=; b=tDtWMsyT9dCSohJZolo2mSo6j08so3UpgKj1hYIbmaXh
        waSP51wOKEb5Ply3yvRQLIEphIKB83VIekklo1Qg/TXsSZCAWvOnDUIXDTBU4QB2
        FAOPE4hIg/QY7GA3yfEmoohqHpKUcSg6M77BfxcAcAtIhbacAvt342Wn2sQQOm46
        ZanJnKgviDsseWtZxoJ5yFxBoDH+20Yk2UOUPc0HvbY37a+ILT3NtK+gNtMi4brh
        Ncrwgu7Xbhfd9ixEUFYDfskHcCyfm4NGgx6+skv/h1uZndqM+rTSTojNxZNWvCK4
        2vl5n1fgGuZp4WIT/3lFjWUnTuaskSPGVcucu0vEFA==
X-ME-Sender: <xms:FIb7YtLe5ycAPmkRukyv_usJsIdDUpXMX0U8k3o-2grPWxzl9iEOng>
    <xme:FIb7YpKneB3U0bxY4so0ZLmmz4CiKpGDWJchVJ5ToOxJkXQ6B5yOoZgq6fg1eE-yM
    XA14xtMLr9dBMUwt1c>
X-ME-Received: <xmr:FIb7Ylvd5ADF_a-_o0ncybmn7ALYvjAn7FgHBrMsbfySC45HMtZHZIex8Mc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:FIb7YuZtGT-7Iwe_2Xvy5OmK4cNcOxQIQw9CbOBLfM2KuGjmcGJVlg>
    <xmx:FIb7YkYz3LYKkO8f9qGZmPgeLoU2sXhTt7x39ofcXq2X36YoDaM5mA>
    <xmx:FIb7YiBVQSvOkGirQDAKVr4cCvKoB8kL1duQFv4bCXdB74SbkISo8A>
    <xmx:Fob7YhLKnsHr-bCzG1ZaYbIxRvAUXlz15kZU_Da8CLH5AUU0BayaHVe_Bpo>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Aug 2022 07:57:08 -0400 (EDT)
Date:   Tue, 16 Aug 2022 13:57:06 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mateusz Kwiatkowski <kfyatek@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
Subject: Re: [PATCH v1 20/35] drm/vc4: vec: Switch for common modes
Message-ID: <20220816115706.nizhpgqi2gggvhtf@houat>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-20-3d53ae722097@cerno.tech>
 <0e285cf5-6ef2-3484-9fb7-5eb55c0ca269@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6rmmsvytrn6spomv"
Content-Disposition: inline
In-Reply-To: <0e285cf5-6ef2-3484-9fb7-5eb55c0ca269@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6rmmsvytrn6spomv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 29, 2022 at 08:12:07PM +0200, Mateusz Kwiatkowski wrote:
> I'm just noting that the modelines you defined in drm_modes.c are differe=
nt
> to the ones you're removing here.
>=20
> The horizontal sync differences probably doesn't matter too much, VC4 uses
> those only as a hint anyway and generates sync autonomously, so the slight
> differences will only cause the image to slightly shift horizontally.
>=20
> But you're also changing the 480i vertical sync (vsync_start is now 488
> instead of 487, etc.). Are you sure that this won't break anything? This
> will probably shift the image by 1 line (which for the 480i might actually
> mean going out of spec), and I _think_ it might control the odd vs. even
> field first modes on some drivers. I won't be able to test this before
> Monday, but I'm just pointing out the potential issue.

I didn't see any difference on both vc4 and sun4i, but you might be
right about this.

I didn't have much confidence in the vc4 modes since they were broken
before your patches, but maybe I should have used yours still.

> BTW, I've seen a similar thing in the sun4i driver changes (patch 32/35) =
and
> the differences in vertical sync are even more dramatic. It's entirely
> possible that the current timings in sun4i are broken and the new ones are
> correct (the new ones certainly look saner to me), but I'd double-check if
> that driver does not have any quirks that would _require_ such weird
> settings.

The only thing sun4i requires from the new mode is the line number
anyway, which stays the same.

Maxime

--6rmmsvytrn6spomv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYvuGEgAKCRDj7w1vZxhR
xRHiAP9fE8CmBUW5DpGpBM8rlS+1m979Rf5KfhJkiXI4XgaLTQD7B6CwXU7vkS/6
Zd1eWht5CPS1YtFPdcFpEpBIdg0jkQw=
=VB11
-----END PGP SIGNATURE-----

--6rmmsvytrn6spomv--
