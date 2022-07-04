Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CE0565A39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiGDPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiGDPoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:44:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740B41E6;
        Mon,  4 Jul 2022 08:44:13 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AC33466015CF;
        Mon,  4 Jul 2022 16:44:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656949451;
        bh=T0jdgrAyHCTaLPYprZARiSvG27dAijlSDfp7uHdeNpY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=f/smC5qK/a7kfrVFv3B/D+docBl4EQbeLo9oSRMcQJkp43qS39AOZW7J81g5d+m6h
         kmW6CnsaAMC8kAQdOGFEhwUTMQ9I91R3n3uaVqWWin3+KJ6iFI7ItwwFKv9IxRVYMy
         VmYmcOtlUwvzjYRKopx7WCASUljYlLKieHdFPWSntv2VWIFeMImNtXBT+e1/ZS1S50
         JU9NweKFQWnSlVCuDJB+PjMzvBD7jDtbCGjcO14HSGWo3z6V6CZLdcBLKvpcyfHV3D
         hefh5ZRU/mulv6r6O10RdtZ7m5aKjk0sfMk2sfxRJfjnygFLtWFCXgK5liKgJ8t+x4
         wQW/GDR+42WpQ==
Message-ID: <e7247c9af96be6565b8bc33760f3767e1bf2073f.camel@collabora.com>
Subject: Re: [PATCH 6/7] media: hantro: imx8m: Enable 10bit decoding
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        andrzej.p@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Date:   Mon, 04 Jul 2022 11:43:59 -0400
In-Reply-To: <16bb6fe6-0d95-d4d1-f7c7-f2ca61f7bdcc@collabora.com>
References: <20220617115802.396442-1-benjamin.gaignard@collabora.com>
         <20220617115802.396442-7-benjamin.gaignard@collabora.com>
         <Yr3gDuzOXk58wTnd@eze-laptop>
         <16bb6fe6-0d95-d4d1-f7c7-f2ca61f7bdcc@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 01 juillet 2022 =C3=A0 09:01 +0200, Benjamin Gaignard a =C3=A9c=
rit=C2=A0:
> Le 30/06/2022 =C3=A0 19:40, Ezequiel Garcia a =C3=A9crit=C2=A0:
> > Hi Benjamin,
> >=20
> > On Fri, Jun 17, 2022 at 01:58:01PM +0200, Benjamin Gaignard wrote:
> > > Expose 10bit pixel formats to enable 10bit decoding in IMX8M SoCs.
> > >=20
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > Looks good to me.
> >=20
> > Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> >=20
> > Have you checked Fluster tests passess using both P010 and P010_4L4?
> > It would be good to double-check.
>=20
> It isn't possible to check P010_4L4 with fluster because GStreamer
> videoconvert element doesn't support this format.

I can offert to work on this. If you can send me offline some picture dump,=
 so I
can validate, that would help.

>=20
> Regards,
> Benjamin
>=20
> >=20
> > Thanks a lot,
> > Ezequiel
> >=20
> > > ---
> > >   drivers/staging/media/hantro/imx8m_vpu_hw.c | 27 ++++++++++++++++++=
+++
> > >   1 file changed, 27 insertions(+)
> > >=20
> > > diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/st=
aging/media/hantro/imx8m_vpu_hw.c
> > > index 77f574fdfa77..b390228fd3b4 100644
> > > --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > @@ -162,12 +162,39 @@ static const struct hantro_fmt imx8m_vpu_g2_pos=
tproc_fmts[] =3D {
> > >   			.step_height =3D MB_DIM,
> > >   		},
> > >   	},
> > > +	{
> > > +		.fourcc =3D V4L2_PIX_FMT_P010,
> > > +		.codec_mode =3D HANTRO_MODE_NONE,
> > > +		.postprocessed =3D true,
> > > +		.frmsize =3D {
> > > +			.min_width =3D FMT_MIN_WIDTH,
> > > +			.max_width =3D FMT_UHD_WIDTH,
> > > +			.step_width =3D MB_DIM,
> > > +			.min_height =3D FMT_MIN_HEIGHT,
> > > +			.max_height =3D FMT_UHD_HEIGHT,
> > > +			.step_height =3D MB_DIM,
> > > +		},
> > > +	},
> > >   };
> > >  =20
> > >   static const struct hantro_fmt imx8m_vpu_g2_dec_fmts[] =3D {
> > >   	{
> > >   		.fourcc =3D V4L2_PIX_FMT_NV12_4L4,
> > >   		.codec_mode =3D HANTRO_MODE_NONE,
> > > +		.match_depth =3D true,
> > > +		.frmsize =3D {
> > > +			.min_width =3D FMT_MIN_WIDTH,
> > > +			.max_width =3D FMT_UHD_WIDTH,
> > > +			.step_width =3D TILE_MB_DIM,
> > > +			.min_height =3D FMT_MIN_HEIGHT,
> > > +			.max_height =3D FMT_UHD_HEIGHT,
> > > +			.step_height =3D TILE_MB_DIM,
> > > +		},
> > > +	},
> > > +	{
> > > +		.fourcc =3D V4L2_PIX_FMT_P010_4L4,
> > > +		.codec_mode =3D HANTRO_MODE_NONE,
> > > +		.match_depth =3D true,
> > >   		.frmsize =3D {
> > >   			.min_width =3D FMT_MIN_WIDTH,
> > >   			.max_width =3D FMT_UHD_WIDTH,
> > > --=20
> > > 2.32.0
> > >=20

