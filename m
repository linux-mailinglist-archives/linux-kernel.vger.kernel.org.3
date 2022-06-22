Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFD055447B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354167AbiFVH5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242785AbiFVH53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:57:29 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C5637A13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:57:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 33A935C00D8;
        Wed, 22 Jun 2022 03:57:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 22 Jun 2022 03:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1655884648; x=1655971048; bh=x1drCMu5dq
        EeEn5rlOqr732uAMnNtHSW/+Yw52DBQHM=; b=pbyDL2YJVwqma+q5ZDQLE+Cw4h
        8zD5iAzAXCo402V0ukFU1qb9Ad+Mq6U1NBQ8QBQG8T0xBVhdSjE/SLm11/pFzedW
        tdQjkxxpaiqX6J5s7Xp5nw3l7e/Ln6StT0zo5GCV8V/Y5WY83wMeXNB/+B/JnQ8j
        kus9OCi7biIq7o/dfMizKS9zAl05EfvrYXEWzT5v4UHo6Qkiy9JdbW/FuwO47rFV
        wltuOvTmUG6PIfbMNgZ4VmbaaTq6ZfJBd/mlS9D2m8ZV17kQ/LqfN4065LSTRD4g
        r7q18oGc4qzphbpNoiegbT3WfclFkOvvOPQ0byd2qt/ilExPOvGNJU22hPbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655884648; x=1655971048; bh=x1drCMu5dqEeEn5rlOqr732uAMnN
        tHSW/+Yw52DBQHM=; b=o3k5NlJchNCwnv8bCsQZx2/IWFPd3VUiOaFHm4rkuDzW
        lipDdqr9jRUHzC/nBEM23CZ5SpS36QD2d19H/HlI8Nm3Oj4pNzNTs+ngj1j3R7a8
        SNxLCyfueW3ccnrqRAlsZbwuc2ezuArdl46u6HsrTfLNESWXdkKUtpLQXJkOToev
        KSRUh3eI1Ji+z1wCUn8ahheo6qMusFP2uh7hq2UGOdlxqvfruI7cEWd0MvhrCBAq
        emGDaBecGN7jv8f89FGDQ3bnf7Eq+pp9uaHl1OkVMmh0nVloX1HdTIbW4xdwbnW9
        wmny/fPZcaGGEk4utiITTKpAyJwSZqgj0xLPPdGOWA==
X-ME-Sender: <xms:Z8uyYgZ2ReBdYtNKL3VJ2PgyMc6fHTTdaCrXBU034dhqX9tH7U7oEQ>
    <xme:Z8uyYrbAGi_QegF8Am4XP-AonTO1ITYIWoYrils9wu9IgUA-ajjrY2QngeR07skJU
    3c1Iu70WvZCw4V2tL4>
X-ME-Received: <xmr:Z8uyYq_pr4oP7nXUWDgldaTfrX_gqanKAUXcstbh7_QWoCkoC1Z64z0huxFems1I0jJ_Wv2tSKfNwGvONkTSfx4IjSArhik7xEI5aOo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheeh
    fffhvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:aMuyYqolEY3y7cFboHCxtfkOyPUg118vLv8onNCDOttgVZcmQSAqJQ>
    <xmx:aMuyYrqJH9kravIH9cgZwhgZpbfNib3_jvdyPDWLUjtG2mS30vVqJA>
    <xmx:aMuyYoRciYyMCcVtFxBVWj734PGQyZv6hOUy1FTwe00mj3fHzeBGpg>
    <xmx:aMuyYsdotOKfnHfIX-jp_BpPP59zZ8mv7kZkmdZaYJDs9aNSK-lU2A>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 03:57:27 -0400 (EDT)
Date:   Wed, 22 Jun 2022 09:57:25 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Saud Farooqui <farooqui_saud@hotmail.com>
Cc:     jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, wens@csie.org, daniel@ffwll.ch
Subject: Re: [PATCH v1] drm/sun4i: Return from the function in error condition
Message-ID: <20220622075725.y6ws22ielpc4pmxw@houat>
References: <20220609142253.7aad4jlaoahqkmy7@houat>
 <PA4P189MB14215D2A66A54FFA3F7DD9348BB39@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dpuceqjgfufrqrxt"
Content-Disposition: inline
In-Reply-To: <PA4P189MB14215D2A66A54FFA3F7DD9348BB39@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dpuceqjgfufrqrxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 21, 2022 at 09:44:27PM +0500, Saud Farooqui wrote:
> Added return statement in sun4i_layer_format_mod_supported()
> in case of error.
>=20
> Signed-off-by: Saud Farooqui <farooqui_saud@hotmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_layer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/=
sun4i_layer.c
> index 6d43080791a0..85fb9e800ddf 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -117,7 +117,7 @@ static bool sun4i_layer_format_mod_supported(struct d=
rm_plane *plane,
>  	struct sun4i_layer *layer =3D plane_to_sun4i_layer(plane);
> =20
>  	if (IS_ERR_OR_NULL(layer->backend->frontend))
> -		sun4i_backend_format_is_supported(format, modifier);
> +		return sun4i_backend_format_is_supported(format, modifier);

While there's a bug, it definitely isn't what your commit message
describe.

Frontends only available on some SoCs and are thus optional in the
driver.

If the frontend pointer isn't set, it means that it isn't there and thus
we try to figure out the format through the backend that is always
there.

Maxime

--dpuceqjgfufrqrxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYrLLZQAKCRDj7w1vZxhR
xawwAP4u3twxDl6X0vHRjMf8txv6dArTqceH0FbDHlbmVRr+UgEAw7KvX806M1k8
y9t+0imQJJiEN4hGTzwC4nriK80T/AA=
=om1g
-----END PGP SIGNATURE-----

--dpuceqjgfufrqrxt--
