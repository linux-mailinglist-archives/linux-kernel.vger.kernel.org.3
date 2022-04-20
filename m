Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1495082CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376470AbiDTHy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376452AbiDTHxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:53:55 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741673BFB8;
        Wed, 20 Apr 2022 00:50:47 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 77443240002;
        Wed, 20 Apr 2022 07:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650441045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zk0UJgX+zS8uYCmoLn7JkGQ+qKIowqpPLy9PBUXizmI=;
        b=ls8Cn19nbxV/9ffObyyoOzrBODoj+hI7TxwVZbwu4IgkYriEXLB/U3GUAIGKJF43uH9pNe
        sRVMBO2e5Mvd4RJH93WFex2LBr6VQNSWbwaUXg36/saJtxRei+pWEcAs4XW6I4rpdTy7wz
        IOMtkZv7IrDPYfzE5b9BbHQyhazCJVdszKOC3Gk+tOqoxL9QcTpV0/Wf9dHBRSfNm0l0v5
        XnhYsnNmrR7Qa1LPpVKoi77DAdkRE3ueVDNSOd/koZI5gk4RLJKfZeX2rqilSGMsu74y+T
        KcOxrvecpZYIHIMudzwTMzT3vAgb8p5K3/Y4gkW1zlyjGqKmFCtqARkiRajqtQ==
Date:   Wed, 20 Apr 2022 09:50:42 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/4] staging: media: Add support for the Allwinner A31
 ISP
Message-ID: <Yl+7UrQFyLvfKRdG@aptenodytes>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-4-paul.kocialkowski@bootlin.com>
 <20220420074249.GB2951@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VYpzucMrXezC+iN2"
Content-Disposition: inline
In-Reply-To: <20220420074249.GB2951@kadam>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VYpzucMrXezC+iN2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed 20 Apr 22, 10:42, Dan Carpenter wrote:
> I ran Smatch on this patch.

Thanks for doing this!

> On Fri, Apr 15, 2022 at 05:37:07PM +0200, Paul Kocialkowski wrote:
> > +void sun6i_isp_capture_configure(struct sun6i_isp_device *isp_dev)
> > +{
> > +	unsigned int width, height;
> > +	unsigned int stride_luma, stride_chroma =3D 0;
> > +	unsigned int stride_luma_div4, stride_chroma_div4;
> > +	const struct sun6i_isp_capture_format *format;
> > +	const struct v4l2_format_info *info;
> > +	u32 pixelformat;
> > +
> > +	sun6i_isp_capture_dimensions(isp_dev, &width, &height);
> > +	sun6i_isp_capture_format(isp_dev, &pixelformat);
> > +
> > +	format =3D sun6i_isp_capture_format_find(pixelformat);
> > +	if (WARN_ON(!format))
> > +		return;
> > +
> > +	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_SIZE_CFG_REG,
> > +			     SUN6I_ISP_MCH_SIZE_CFG_WIDTH(width) |
> > +			     SUN6I_ISP_MCH_SIZE_CFG_HEIGHT(height));
> > +
> > +	info =3D v4l2_format_info(pixelformat);
> > +	if (WARN_ON(!info))
> > +		return;
> > +
> > +	stride_luma =3D width * info->bpp[0];
> > +	stride_luma_div4 =3D DIV_ROUND_UP(stride_luma, 4);
> > +
> > +	if (info->comp_planes > 1) {
> > +		stride_chroma =3D width * info->bpp[1] / info->hdiv;
> > +		stride_chroma_div4 =3D DIV_ROUND_UP(stride_chroma, 4);
>=20
> stride_chroma_div4 is not intialized on the else path.

One could say it's not an issue to put an uninitialized value in this situa=
tion
since the hardware won't be taking it into account but I'll initialize the =
value
early in the next iteration.

> > +	}
> > +
> > +	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_CFG_REG,
> > +			     SUN6I_ISP_MCH_CFG_EN |
> > +			     SUN6I_ISP_MCH_CFG_OUTPUT_FMT(format->output_format) |
> > +			     SUN6I_ISP_MCH_CFG_STRIDE_Y_DIV4(stride_luma_div4) |
> > +			     SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(stride_chroma_div4));
> > +}
>=20
> [ snip ]
>=20
> > +void sun6i_isp_params_configure(struct sun6i_isp_device *isp_dev)
> > +{
> > +	struct sun6i_isp_params_state *state =3D &isp_dev->params.state;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&state->lock, flags);
> > +
> > +	sun6i_isp_params_configure_base(isp_dev);
> > +
> > +	/* Default config is only applied at the very first stream start. */
> > +	if (state->configured)
> > +		goto complete;
> > +
> > +	 sun6i_isp_params_configure_modules(isp_dev,
>         ^
> There is an extra space character here.

Good catch, thanks!

> > +					    &sun6i_isp_params_config_default);
> > +
> > +	state->configured =3D true;
> > +
> > +complete:
> > +	spin_unlock_irqrestore(&state->lock, flags);
> > +}

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--VYpzucMrXezC+iN2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJfu1EACgkQ3cLmz3+f
v9GROggAhvf/IrRIYswrCnaCpPLhkw4Ly73/iOp4HatHnslaoOnc2CK8KfD2bYxv
SoNYxaxuY8pKUmTtGNOoeX4rj1MeOR5TeDPqNOJHYScFZb94ap3UveCyh+AzROnY
n/pbj6zBGJPjxjpV+epd5LgJId+r09yM3EAlYN5Fnuz5ot9urfLXSZIUo2XJGQQs
tBkdjG5hnqX+SgMsdMlAHSzpXA41J1Y2vLB2ngIRh2/j4fdid+65+9JlgNOYKfBo
d6HNp6QXAsQOhdTFzJaA2aXK3h54cxt5I0Wmhsi3uHe2bQLungevWyCPnYKvaZo7
PoBqL/Y9x73xyEIjCFcQwp8aT6rpJA==
=Vq1E
-----END PGP SIGNATURE-----

--VYpzucMrXezC+iN2--
