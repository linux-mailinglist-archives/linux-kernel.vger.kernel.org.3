Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9240B4F5182
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348917AbiDFCE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573282AbiDESn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:43:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59F93BBC3;
        Tue,  5 Apr 2022 11:41:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d7so4069315edn.11;
        Tue, 05 Apr 2022 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m8+gZUwdiEE5qvl2VnmW6rVS2LU3YP93jBijbUtmgIU=;
        b=XYbsuW/9J3w3AJ5TIXJONDZppci86m75YL2FDgn0BaMCRRL3EXnp4ebuaOd1zQIy0u
         XLnuET7H+rFD/Ge1BZsJmxmLwTUc/fEkgd9s71790cxoRZRMM9rqpIbga772wTCLoc2W
         QlfVKF9CjwpkoJ7CvrAUQdS1nyxawahdgwr1MOw4b6QC7D83s62JBwP+7IdTAjZ1KyD9
         I4zOGbI8xhi7aHYcAeKU3T7PRfBICAw0yN2UUOMNk5Cvdd17gHRT/NAa82rOWg+AUVh9
         GxoGY0GayTi7hetZuDPDQcxFwi45JPJUAMgSiHDW2ERr9LYChHTYTzbDFGEwF2u9iZBF
         s0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m8+gZUwdiEE5qvl2VnmW6rVS2LU3YP93jBijbUtmgIU=;
        b=EcgLgX6h07i94/D+ScLsPNApcx6hMb132mn/9xPl4jIs7DLv6Nt3j7dRqZm7aYN5cc
         ha8NDrxuPh0MDzRcCfIQQFS1rjaPthUCaeJX4UWRIZpB61Yfy94QgEvS3pPvB0d1B7p3
         IhZ5FOmUU/GwUM32MBirPQluHHFVIqmgT9EDl5YElA7zoBdbCCzvwjs+ajtdalfQvOMq
         Vw4jAI3zyjHtqtFm5k53yQf6iI4DT+PWoa+PSFAbmQJ8Y1gsysZ9PtMTUoAxmAqx45bU
         dv9i+bfOJpsmc7Vr/SW3GVqP3jFvhLR+rwLIVxn/RnoAnwQw4yCLQBDUeQPQhJH/QXEY
         8Y4w==
X-Gm-Message-State: AOAM5320RdEZsJU/hcTvPspTKYPpOeweTtRuQNe/GP5JAEmNuEFWLLS5
        oPgCU3mqjX01xB2Fkdte4ow=
X-Google-Smtp-Source: ABdhPJz/BDSth3cyv5w1yUkWvK/7raS2HQuG5NyF9YhgGRBDVIEl5pHryGirWcHzIO89O4eDdGT19g==
X-Received: by 2002:a05:6402:b3a:b0:41c:dcf9:ca65 with SMTP id bo26-20020a0564020b3a00b0041cdcf9ca65mr4980860edb.208.1649184084319;
        Tue, 05 Apr 2022 11:41:24 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906289500b006d144662b24sm5730375ejd.152.2022.04.05.11.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 11:41:24 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, nicolas@ndufresne.ca, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [RFC PATCH 3/8] media: hantro: Support format filtering by depth
Date:   Tue, 05 Apr 2022 20:41:22 +0200
Message-ID: <4699374.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <7972feba-221c-9960-68d0-ee15ad2a4f1a@collabora.com>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com> <20220227144926.3006585-4-jernej.skrabec@gmail.com> <7972feba-221c-9960-68d0-ee15ad2a4f1a@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 05. april 2022 ob 18:09:03 CEST je Benjamin Gaignard napisal(a):
> Le 27/02/2022 =E0 15:49, Jernej Skrabec a =E9crit :
> > In preparation for supporting 10-bit formats, add mechanism which will
> > filter formats based on pixel depth.
> >=20
> > Hantro G2 supports only one decoding format natively and that is based
> > on bit depth of current video frame. Additionally, it makes no sense to
> > upconvert bitness, so filter those out too.
> >=20
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> >=20
> >   drivers/staging/media/hantro/hantro.h      |  4 ++
> >   drivers/staging/media/hantro/hantro_v4l2.c | 48 ++++++++++++++++++++--
> >   drivers/staging/media/hantro/hantro_v4l2.h |  1 +
> >   3 files changed, 50 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/hantro/hantro.h
> > b/drivers/staging/media/hantro/hantro.h index 06d0f3597694..c6525ee8d89a
> > 100644
> > --- a/drivers/staging/media/hantro/hantro.h
> > +++ b/drivers/staging/media/hantro/hantro.h
> > @@ -227,6 +227,7 @@ struct hantro_dev {
> >=20
> >    *
> >    * @ctrl_handler:	Control handler used to register controls.
> >    * @jpeg_quality:	User-specified JPEG compression quality.
> >=20
> > + * @bit_depth:		Bit depth of current frame
> >=20
> >    *
> >    * @codec_ops:		Set of operations related to codec mode.
> >    * @postproc:		Post-processing context.
> >=20
> > @@ -252,6 +253,7 @@ struct hantro_ctx {
> >=20
> >   	struct v4l2_ctrl_handler ctrl_handler;
> >   	int jpeg_quality;
> >=20
> > +	int bit_depth;
> >=20
> >   	const struct hantro_codec_ops *codec_ops;
> >   	struct hantro_postproc_ctx postproc;
> >=20
> > @@ -278,6 +280,7 @@ struct hantro_ctx {
> >=20
> >    * @enc_fmt:	Format identifier for encoder registers.
> >    * @frmsize:	Supported range of frame sizes (only for bitstream
> >    formats).
> >    * @postprocessed: Indicates if this format needs the post-processor.
> >=20
> > + * @match_depth: Indicates if format bit depth must match video bit de=
pth
> >=20
> >    */
> >  =20
> >   struct hantro_fmt {
> >  =20
> >   	char *name;
> >=20
> > @@ -288,6 +291,7 @@ struct hantro_fmt {
> >=20
> >   	enum hantro_enc_fmt enc_fmt;
> >   	struct v4l2_frmsize_stepwise frmsize;
> >   	bool postprocessed;
> >=20
> > +	bool match_depth;
> >=20
> >   };
> >  =20
> >   struct hantro_reg {
> >=20
> > diff --git a/drivers/staging/media/hantro/hantro_v4l2.c
> > b/drivers/staging/media/hantro/hantro_v4l2.c index
> > e595905b3bd7..1214fa2f64ae 100644
> > --- a/drivers/staging/media/hantro/hantro_v4l2.c
> > +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> > @@ -64,6 +64,42 @@ hantro_get_postproc_formats(const struct hantro_ctx
> > *ctx,>=20
> >   	return ctx->dev->variant->postproc_fmts;
> >  =20
> >   }
> >=20
> > +int hantro_get_formath_depth(u32 fourcc)
>=20
> Just a typo here:
>=20
> s/hantro_get_formath_depth -> hantro_get_format_depth

Good catch! I'll fix it in new series.

Best regards,
Jernej

>=20
> regards
> Benjamin
>=20
> > +{
> > +	switch (fourcc) {
> > +	case V4L2_PIX_FMT_P010:
> > +	case V4L2_PIX_FMT_P010_4L4:
> > +		return 10;
> > +	default:
> > +		return 8;
> > +	}
> > +}
> > +
> > +static bool
> > +hantro_check_depth_match(const struct hantro_ctx *ctx,
> > +			 const struct hantro_fmt *fmt)
> > +{
> > +	int fmt_depth, ctx_depth =3D 8;
> > +
> > +	if (!fmt->match_depth && !fmt->postprocessed)
> > +		return true;
> > +
> > +	/* 0 means default depth, which is 8 */
> > +	if (ctx->bit_depth)
> > +		ctx_depth =3D ctx->bit_depth;
> > +
> > +	fmt_depth =3D hantro_get_formath_depth(fmt->fourcc);
> > +
> > +	/*
> > +	 * Allow only downconversion for postproc formats for now.
> > +	 * It may be possible to relax that on some HW.
> > +	 */
> > +	if (!fmt->match_depth)
> > +		return fmt_depth <=3D ctx_depth;
> > +
> > +	return fmt_depth =3D=3D ctx_depth;
> > +}
> > +
> >=20
> >   static const struct hantro_fmt *
> >   hantro_find_format(const struct hantro_ctx *ctx, u32 fourcc)
> >   {
> >=20
> > @@ -91,7 +127,8 @@ hantro_get_default_fmt(const struct hantro_ctx *ctx,
> > bool bitstream)>=20
> >   	formats =3D hantro_get_formats(ctx, &num_fmts);
> >   	for (i =3D 0; i < num_fmts; i++) {
> >   =09
> >   		if (bitstream =3D=3D (formats[i].codec_mode !=3D
> >=20
> > -				  HANTRO_MODE_NONE))
> > +				  HANTRO_MODE_NONE) &&
> > +		    hantro_check_depth_match(ctx, &formats[i]))
> >=20
> >   			return &formats[i];
> >   =09
> >   	}
> >   	return NULL;
> >=20
> > @@ -163,11 +200,13 @@ static int vidioc_enum_fmt(struct file *file, void
> > *priv,>=20
> >   	formats =3D hantro_get_formats(ctx, &num_fmts);
> >   	for (i =3D 0; i < num_fmts; i++) {
> >   =09
> >   		bool mode_none =3D formats[i].codec_mode =3D=3D=20
HANTRO_MODE_NONE;
> >=20
> > +		fmt =3D &formats[i];
> >=20
> >   		if (skip_mode_none =3D=3D mode_none)
> >   	=09
> >   			continue;
> >=20
> > +		if (!hantro_check_depth_match(ctx, fmt))
> > +			continue;
> >=20
> >   		if (j =3D=3D f->index) {
> >=20
> > -			fmt =3D &formats[i];
> >=20
> >   			f->pixelformat =3D fmt->fourcc;
> >   			return 0;
> >   	=09
> >   		}
> >=20
> > @@ -183,8 +222,11 @@ static int vidioc_enum_fmt(struct file *file, void
> > *priv,>=20
> >   		return -EINVAL;
> >   =09
> >   	formats =3D hantro_get_postproc_formats(ctx, &num_fmts);
> >   	for (i =3D 0; i < num_fmts; i++) {
> >=20
> > +		fmt =3D &formats[i];
> > +
> > +		if (!hantro_check_depth_match(ctx, fmt))
> > +			continue;
> >=20
> >   		if (j =3D=3D f->index) {
> >=20
> > -			fmt =3D &formats[i];
> >=20
> >   			f->pixelformat =3D fmt->fourcc;
> >   			return 0;
> >   	=09
> >   		}
> >=20
> > diff --git a/drivers/staging/media/hantro/hantro_v4l2.h
> > b/drivers/staging/media/hantro/hantro_v4l2.h index
> > 18bc682c8556..f4a5905ed518 100644
> > --- a/drivers/staging/media/hantro/hantro_v4l2.h
> > +++ b/drivers/staging/media/hantro/hantro_v4l2.h
> > @@ -22,5 +22,6 @@ extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
> >=20
> >   extern const struct vb2_ops hantro_queue_ops;
> >  =20
> >   void hantro_reset_fmts(struct hantro_ctx *ctx);
> >=20
> > +int hantro_get_formath_depth(u32 fourcc);
> >=20
> >   #endif /* HANTRO_V4L2_H_ */




