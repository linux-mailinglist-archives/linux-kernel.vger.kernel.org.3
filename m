Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6969B582616
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiG0MGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiG0MGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:06:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31B5F56;
        Wed, 27 Jul 2022 05:06:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E2E35C01A0;
        Wed, 27 Jul 2022 08:06:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Jul 2022 08:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658923594; x=1659009994; bh=sns5b3/QFe
        KrteH5LAIPWxoG6sLFqTq3vrWcUhZbXYo=; b=GibnmcNO6wp3WeAyKuTE/nUCLB
        YW50Ol+91ZDj79Zo5CIskHeaFVR8jAMN0X49kTLFWOa3a9HjROw12SLcp+WTbRWk
        OAkgmgaftSsl5cwK5scd/mWQIJFxIcXwJ1bcX64UgyDee8EVuuwj44j05ryTguUB
        p4DCIfXbxijwwku9KDHPm/VhzCK98td11UVKG7pSS/a7NmdUAmozFwQXu3IG1JFW
        txl5azyk8POfhYSw+3hREMc6nZv9m7rRxqDP8J8Vajz9PGVQLBsC2PlyTMAIwkXm
        D5yStClLg0CP5ubMKD1whxvJ0Og4wzm6jioIRQ20dGJ6ekEYdHcOyHVe+pFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658923594; x=1659009994; bh=sns5b3/QFeKrteH5LAIPWxoG6sLF
        qTq3vrWcUhZbXYo=; b=CPOvtjMSWfr51w9qpRc0e0LNAed6DSTlNlYhggqfevUC
        XGfbJ7p3LwPJWqUWCd9A2SMlnM+cLnehqodde9XgZ5q7NJjPW1cPu960mZoIUu+Z
        MLtHutev6Jg6MRHV7ZuYmcu463JoZ56rC+pIo38UBmuZ91cuktZr3PfECppTuleR
        WMLUUJaap9ElmMQVnCox/54tVH+0yXXjJJtLkRxteSs55EAxP8C8XnXgsO6TB1WB
        gWiOY4jExXpp8UFQ7CKeiQWNA90ehzhOO+HibWyvhBUzwZCZuwSwtUA2gssBu4Ig
        jHUbywnvlinBSmdRzE/t7o4wYzVBt+GLMzcD049NfQ==
X-ME-Sender: <xms:SSrhYuzCudXQOXDePTu9vd-jnHWA2c0dG9z3DmtX82aSwA_iiHLlVQ>
    <xme:SSrhYqQivoa7jzWzw_mNC5VX8HsHDGaFeRqg7-0c9M8dAne77B8nWeOZvJglqA2F8
    13RETjYW95OvqTKwa4>
X-ME-Received: <xmr:SSrhYgVwpFCYbJHWnIkNSZl2pqClDE01SmH6gCdeKdXa4o7jKmy2gepA-Ejw_cRbcv9nvxuLg3wZ3U5mLd650aRxRfb9Ip_VeJjiaj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduvddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtleekjeeiudefvdfhieffteelhfeivdeliefgieeugffhvdelieffjeei
    geetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:SSrhYkicJ_IGgqz6iexkhVvJotQY9PgHDYu6at83sP86XcN-jbRxig>
    <xmx:SSrhYgD_6W9SF0CcaX5syZO4GDpQtYW869-2NL9JMz79PzcyP-mG8w>
    <xmx:SSrhYlIvonbC6Au2J1vGXrnhrB9vVXK9few-aIOgGzwMHy05o0c_Hw>
    <xmx:SirhYob7ea0CytTonx1V7XsjzDERI7TE34Dj8js15DQ3IuZ1nqkMsQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Jul 2022 08:06:33 -0400 (EDT)
Date:   Wed, 27 Jul 2022 14:06:31 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH RFC v3 1/8] of: Mark interconnects property supplier as
 optional
Message-ID: <20220727120631.iefzititedahdsdt@houat>
References: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
 <20220302211100.65264-2-paul.kocialkowski@bootlin.com>
 <YiaTfsMDs7RGob2N@robh.at.kernel.org>
 <CAGETcx9u9RO_5nSp+=qgwDGY=jL_Q1hAcj+RfVN=q-H_8iuT4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5f267h7mxg6wplag"
Content-Disposition: inline
In-Reply-To: <CAGETcx9u9RO_5nSp+=qgwDGY=jL_Q1hAcj+RfVN=q-H_8iuT4w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5f267h7mxg6wplag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 07, 2022 at 07:34:22PM -0800, Saravana Kannan wrote:
> On Mon, Mar 7, 2022 at 3:21 PM Rob Herring <robh@kernel.org> wrote:
> >
> > +Saravana
> >
> > On Wed, Mar 02, 2022 at 10:10:53PM +0100, Paul Kocialkowski wrote:
> > > In order to set their correct DMA address offset, some devices rely on
> > > the device-tree interconnects property which identifies an
> > > interconnect node that provides a dma-ranges property that can be used
> > > to set said offset.
> > >
> > > Since that logic is all handled by the generic openfirmware and driver
> > > code, the device-tree description could be enough to properly set
> > > the offset.
> > >
> > > However the interconnects property is currently not marked as
> > > optional, which implies that a driver for the corresponding node
> > > must be loaded as a requirement. When no such driver exists, this
> > > results in an endless EPROBE_DEFER which gets propagated to the
> > > calling driver. This ends up in the driver never loading.
> > >
> > > Marking the interconnects property as optional makes it possible
> > > to load the driver in that situation, since the EPROBE_DEFER return
> > > code will no longer be propagated to the driver.
> > >
> > > There might however be undesirable consequences with this change,
> > > which I do not fully grasp at this point.
>=20
> Temporary NACK till I get a bit more time to take a closer look. I
> really don't like the idea of making interconnects optional. IOMMUs
> and DMAs were exceptions. Also, we kinda discuss similar issues in
> LPC. We had some consensus on how to handle these and I noted them all
> down with a lot of details -- let me go take a look at those notes
> again and see if I can send a more generic patch.
>=20
> Paul,
>=20
> Can you point to the DTS (not DTSI) file that corresponds to this?
> Also, if it's a builtin kernel, I'd recommend setting
> deferred_probe_timeout=3D1 and that should take care of it too.

For the record, I also encountered this today on next-20220726 with this
device:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm/boot/dts/sun5i.dtsi#n775

The driver won't probe without fw_devlink=3Doff

Maxime

--5f267h7mxg6wplag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYuEqRwAKCRDj7w1vZxhR
xU7hAPwISO3g/gkHRCgtYcqZGbLJsQTjFn8UlaYIl4MsqUE71AEArjHaL+k43u3L
IMF27kO1knwUR8duIkDbYBb49e/ZQgs=
=h3a/
-----END PGP SIGNATURE-----

--5f267h7mxg6wplag--
