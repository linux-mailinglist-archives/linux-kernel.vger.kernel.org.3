Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6105A99A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiIAODI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:03:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5934311A0D;
        Thu,  1 Sep 2022 07:03:02 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C1DFF5C0134;
        Thu,  1 Sep 2022 10:02:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 01 Sep 2022 10:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1662040979; x=1662127379; bh=Ffc/RZEQI4
        hjFuUkxRf9nBYDShUEErzbXtlvMQHYkoU=; b=JtK+h8hcUlm1NBTcBPP1ao8LIV
        gFvg9ADICearOe/rAgHMR3oV+RyOIVH7vj295WLfGPdjSFpObwGBvfQ4HlAsgfaU
        flgYVjBvyC3QKanLZokwOTRdNjZLuFQtrNP4chO9SogHjPV9DW7Ug44sC9/9gy60
        j2rhWqJ6ro+sdjAajm5G2ksU2BdmnMJuHHsLBhacGm+vseyulSyzsVDTQRaYpmcQ
        j7yKtHf8hyjY2TJWs0eCS1N1rFKR2V0XMKniXPLj94B/wFQjIObVvhwwID12D0i7
        7pZ+TffkyQC1e2yw9BXpoMIFx2OfY33xzpOtl8l435+NhSp9jcmi2wBWfRzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662040979; x=1662127379; bh=Ffc/RZEQI4hjFuUkxRf9nBYDShUE
        ErzbXtlvMQHYkoU=; b=v/7DXqkmseCudlaTbZ4YE06w4cJJdyzbaqa2mxX1XcKy
        Qn8uqghouxGkwFG9pEuN6vORLUx7HKE4jBXrEM37vNJewbZ8OwEVoIZ/DT7uDc94
        s7O4oW4dksqVmhhavz6UN1SRMcErQpdlG38IjfWl19TCRhGTXvBDXYlKVVHSLzrr
        zDi8Z3Xl6n7kDCapB8k+mM2vTtDD47fphkPykSTh6cOTH8JSyksXZl++nPFrP6P4
        JlQiLNcUrj6yA/8uM5F1FavkUEPBwL60LLGlvERXn47A6DRIJLSFurUZMFtDuGE/
        1xr6Xzf7ofsLCYkwa28OmBM0LH8PUEF6yerw/T6fJQ==
X-ME-Sender: <xms:krsQY-bjPZB5E--4A7lqok3WFgsbo-poMzu3Jad1J5GwBc7uimmYWw>
    <xme:krsQYxbJGNnuKdzqiq0Yx9EkDq4HvEzDEgAmMsxSFbU9EN5l2XDWcOgfIA6qmNQ5t
    FAy-vXTqLLRdhthxzw>
X-ME-Received: <xmr:krsQY4-63x-heJoLloEEnzNBA3Htf5s7mLKpDTVBTo1Kzj5aWJEYwo-aaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekkedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejgeeiveevvdfgffeftdevuefhheduveejieefgeejveeuhfetkeelgfev
    teefffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:krsQYwpVlta34cqUd5B8u5uqV3WzQX8iZqH8j-HKLvJcNrGZ1GmF3g>
    <xmx:krsQY5r15Ls8FPbP5yVDV1evcMYz3q-HtlWrKbpSmN7OoLHU_95b0A>
    <xmx:krsQY-SKAyx135WmHbxKgn89rD5_CVJ7zRtR265F4_h073q6Sq4C6A>
    <xmx:k7sQY3jnyLTXUnSqoTToBACGOBNpZMuWG3g_CFR14GHq0HZLyPVHJg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Sep 2022 10:02:57 -0400 (EDT)
Date:   Thu, 1 Sep 2022 16:02:53 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Gow <davidgow@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH] drm: Simplify testing on UML with kunit.py
Message-ID: <20220901140253.6ebvykv35kyc3v3w@houat>
References: <20220901133621.353270-1-michal.winiarski@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lymi6tif3g4nxejp"
Content-Disposition: inline
In-Reply-To: <20220901133621.353270-1-michal.winiarski@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lymi6tif3g4nxejp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 01, 2022 at 03:36:21PM +0200, Micha=C5=82 Winiarski wrote:
> DRM depends on IOMEM and DMA, introduce an additional Kconfig to pull in
> IOMEM and DMA emulation on UML.
> Since --kconfig_add usage is no longer needed, remove it from
> documentation.
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  Documentation/gpu/drm-internals.rst | 7 +------
>  drivers/video/Kconfig               | 4 ++++
>  2 files changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/gpu/drm-internals.rst b/Documentation/gpu/drm-=
internals.rst
> index 5fd20a306718..c264a9587d21 100644
> --- a/Documentation/gpu/drm-internals.rst
> +++ b/Documentation/gpu/drm-internals.rst
> @@ -228,16 +228,11 @@ follows:
> =20
>  .. code-block:: bash
> =20
> -	$ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/gpu/drm/te=
sts \
> -		--kconfig_add CONFIG_VIRTIO_UML=3Dy \
> -		--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=3Dy
> +	$ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/gpu/drm/te=
sts
> =20
>  .. note::
>  	The configuration included in ``.kunitconfig`` should be as generic as
>  	possible.
> -	``CONFIG_VIRTIO_UML`` and ``CONFIG_UML_PCI_OVER_VIRTIO`` are not
> -	included in it because they are only required for User Mode Linux.
> -

I'm all for removing that part of the documentation, but because
6fc3a8636a7b, in 6.0 should address this entirely? Why would we need
that other symbol?

Maxime

--lymi6tif3g4nxejp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYxC7jQAKCRDj7w1vZxhR
xQglAP9zmZdegnfQtBGMTWrj4fjVJG3GP2M4l3bTsoldBLBhWwEAvG3BsOVQM1Lq
eqk061Y9Ou0biCjvdHK/I9lNIvRPiAM=
=uNx+
-----END PGP SIGNATURE-----

--lymi6tif3g4nxejp--
