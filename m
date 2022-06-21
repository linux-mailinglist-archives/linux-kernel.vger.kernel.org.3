Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C1555362B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351758AbiFUPfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352002AbiFUPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:33:18 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1590E9FD8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:33:17 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id g18so13375678qvn.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=dy8yeG9fTBHltWG4kJedgv5LPIew+OWd8uTBYekbBzc=;
        b=ApJ/dLZCmEw0l/GZjONyC5HqMPHnP/1v5EjjO1KCkzHQMylqrSeF7f1PAqFEtcA5p7
         B5L7VLmvKXMkO3mBusxE4aofO5gnetF3tBYYwFOBpVJp+ZHpNjY2yIJIKkIC5ik+xBVg
         uADxSpGmWIuEmcvyscNyZq4wRAFjkfTGd5fw8vkIUElXZ7Fh7K0t4I4f6BB6HMBT5br2
         7NCDPnMq22xS1dnrAdLeSQoiWz64pI/Jrs0HO9z4O6pbFJ4oAYasBaxsv3sEwsv/op3Y
         PyNof9m1d/UwIgmRDoOP1CmTU/y+FXB4dNy3XB838qTtpSSnqKp5JlrXrGTQNEKwf5FG
         7rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=dy8yeG9fTBHltWG4kJedgv5LPIew+OWd8uTBYekbBzc=;
        b=JvB79ZPCTX1CVyDexlQPeRfXmLjViwIdD6Yv2PXwB2igA56/j+Cag+rKU3KlZx8L//
         J9ufkxTpu20rxekfPW0ePCnGJhsZoqEVGebTHMdvWccWD6LAYR94yelyCMIebPhyVr6s
         T4fbDYgXJQfcMFIqw/pdOYPWithEwC9uvRe0Y/Om5dRb8iDrgeJLu4F1LjpBBYKu5xou
         WLwakDZ+p17ASBkV2sDEeo9gNQR0QYEoOPzMTSYMeTApskjqLBS3vbZxJCWT7PJCJwH/
         NRb1PN15/5O6HdfuV6uVSqtWqVX7uSc2jj/qrEVSPE3kpuNAq83+hgU3A7V9d8raZuqA
         QVEQ==
X-Gm-Message-State: AJIora8232DjRtXBcILaYjTuNnpWQeUVQaMlaS7w3qiPewTbauYOP9iq
        6Og46mfID7HvOEJVnXxKg9Zz6Q==
X-Google-Smtp-Source: AGRyM1srW5WWOiSz7XlL+lVwbQcKJ8mCJy/w+hJaCXN4HQuLbalFyFAI4j3aN7yjXcA9VUwq7W66HA==
X-Received: by 2002:a05:622a:1054:b0:306:3216:4f00 with SMTP id f20-20020a05622a105400b0030632164f00mr24570852qte.109.1655825596108;
        Tue, 21 Jun 2022 08:33:16 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id 20-20020ac85754000000b002f93554c009sm11589284qtx.59.2022.06.21.08.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 08:33:15 -0700 (PDT)
Message-ID: <e95f2b43c131927a488f86081683c15b885efea7.camel@ndufresne.ca>
Subject: Re: [PATCH v7, 04/15] media: mtk-vcodec: Read max resolution from
 dec_capability
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Tue, 21 Jun 2022 11:33:14 -0400
In-Reply-To: <YqwjOurt2DCV6snP@google.com>
References: <20220223034008.15781-1-yunfei.dong@mediatek.com>
         <20220223034008.15781-5-yunfei.dong@mediatek.com>
         <cb7cf296bc7df7334f55cc51ef11b671572559ac.camel@ndufresne.ca>
         <YqwjOurt2DCV6snP@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 17 juin 2022 =C3=A0 14:46 +0800, Chen-Yu Tsai a =C3=A9crit=C2=
=A0:
> Hi,
>=20
> On Mon, Feb 28, 2022 at 04:29:15PM -0500, Nicolas Dufresne wrote:
> > Hi Yunfei,
> >=20
> > this patch does not work unless userland calls enum_framesizes, which i=
s
> > completely optional. See comment and suggestion below.
> >=20
> > Le mercredi 23 f=C3=A9vrier 2022 =C3=A0 11:39 +0800, Yunfei Dong a =C3=
=A9crit=C2=A0:
> > > Supported max resolution for different platforms are not the same: 2K
> > > or 4K, getting it according to dec_capability.
> > >=20
> > > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > > Reviewed-by: Tzung-Bi Shih<tzungbi@google.com>
> > > ---
> > >  .../platform/mtk-vcodec/mtk_vcodec_dec.c      | 29 +++++++++++------=
--
> > >  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  4 +++
> > >  2 files changed, 21 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/dri=
vers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > > index 130ecef2e766..304f5afbd419 100644
> > > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > > @@ -445,7 +447,7 @@ static int vidioc_vdec_s_fmt(struct file *file, v=
oid *priv,
> > >  		return -EINVAL;
> > > =20
> > >  	q_data->fmt =3D fmt;
> > > -	vidioc_try_fmt(f, q_data->fmt);
> > > +	vidioc_try_fmt(ctx, f, q_data->fmt);
> > >  	if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > >  		q_data->sizeimage[0] =3D pix_mp->plane_fmt[0].sizeimage;
> > >  		q_data->coded_width =3D pix_mp->width;
> > > @@ -545,6 +547,9 @@ static int vidioc_enum_framesizes(struct file *fi=
le, void *priv,
> > >  				fsize->stepwise.min_height,
> > >  				fsize->stepwise.max_height,
> > >  				fsize->stepwise.step_height);
> > > +
> > > +		ctx->max_width =3D fsize->stepwise.max_width;
> > > +		ctx->max_height =3D fsize->stepwise.max_height;
> >=20
> > The spec does not require calling enum_fmt, so changing the maximum her=
e is
> > incorrect (and fail with GStreamer). If userland never enum the framesi=
zes, the
> > resolution get limited to 1080p.
> >=20
> > As this only depends and the OUTPUT format and the device being open()
> > (condition being dev_capability being set and OUTPUT format being known=
 / not
> > VP8), you could initialize the cxt max inside s_fmt(OUTPUT) instead, wh=
ich is a
> > mandatory call. I have tested this change to verify this:
> >=20
> >=20
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drive=
rs/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > index 044e3dfbdd8c..3e7c571526a4 100644
> > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > @@ -484,6 +484,14 @@ static int vidioc_vdec_s_fmt(struct file *file, vo=
id *priv,
> >  	if (fmt =3D=3D NULL)
> >  		return -EINVAL;
> > =20
> > +	if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
> > +	    !(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED) &&
> > +	    fmt->fourcc !=3D V4L2_PIX_FMT_VP8_FRAME) {
> > +		mtk_v4l2_debug(3, "4K is enabled");
> > +		ctx->max_width =3D VCODEC_DEC_4K_CODED_WIDTH;
> > +		ctx->max_height =3D VCODEC_DEC_4K_CODED_HEIGHT;
> > +	}
> > +
> >  	q_data->fmt =3D fmt;
> >  	vidioc_try_fmt(ctx, f, q_data->fmt);
> >  	if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > @@ -574,15 +582,9 @@ static int vidioc_enum_framesizes(struct file *fil=
e, void *priv,
> > =20
> >  		fsize->type =3D V4L2_FRMSIZE_TYPE_STEPWISE;
> >  		fsize->stepwise =3D dec_pdata->vdec_framesizes[i].stepwise;
> > -		if (!(ctx->dev->dec_capability &
> > -				VCODEC_CAPABILITY_4K_DISABLED) &&
> > -				fsize->pixel_format !=3D V4L2_PIX_FMT_VP8_FRAME) {
> > -			mtk_v4l2_debug(3, "4K is enabled");
> > -			fsize->stepwise.max_width =3D
> > -					VCODEC_DEC_4K_CODED_WIDTH;
> > -			fsize->stepwise.max_height =3D
> > -					VCODEC_DEC_4K_CODED_HEIGHT;
> > -		}
> > +		fsize->stepwise.max_width =3D ctx->max_width;
> > +		fsize->stepwise.max_height =3D ctx->max_height;
> > +
>=20
> Recent testing on ChromeOS suggests this doesn't work. The spec implies
> that querying capabilities could happen before the output format is set.
> And also, supported frame sizes are detected for each given format,
> which may not be the one current set.

In v4l2, formats are always set. Perhaps the problem is that we don't
automatically set ctx->max_width/height for the default format when the fir=
mware
is up. I noticed recently the chromium always do G_FMT before S_FMT, so per=
haps
it can skip S_FMT if the default format is appropriate, and that endup avoi=
ding
the code I've just suggested. At the time I wrote that, I only had GStreame=
r
available to test, and it always calls S_FMT, which is mandatory, see 4.5.3=
.2.
Initialization step 1. But I cannot say userland would be wrong to skip if =
that
format was "initially" correct.

If my understanding is not correct, then perhaps you should provide a tad m=
ore
details on how this failed for you, and we can then better judge an appropr=
iate
fix.

regards,
Nicolas

>=20
> So the if block above has to be reintroduced in some form. I'll take a
> look at this.
>=20
>=20
> Regards
> ChenYu
>=20
> >  		mtk_v4l2_debug(1, "%x, %d %d %d %d %d %d",
> >  				ctx->dev->dec_capability,
> >  				fsize->stepwise.min_width,
> > @@ -592,8 +594,6 @@ static int vidioc_enum_framesizes(struct file *file=
, void *priv,
> >  				fsize->stepwise.max_height,
> >  				fsize->stepwise.step_height);
> > =20
> > -		ctx->max_width =3D fsize->stepwise.max_width;
> > -		ctx->max_height =3D fsize->stepwise.max_height;
> >  		return 0;
> >  	}
> > =20
> >=20
> >=20
> > >  		return 0;
> > >  	}
> > > =20
>=20
> [...]
>=20

