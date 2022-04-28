Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AEE512DED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbiD1IOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244662AbiD1IOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:14:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACB520196;
        Thu, 28 Apr 2022 01:11:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p18so4589549edr.7;
        Thu, 28 Apr 2022 01:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QbyW2w5H9Ka2dhH/td4Wv+BKvF3xkANmkzFDgDmtue8=;
        b=HQd0kA1m+C0QmxadGWI0aCnyBHVFA1iHFAk7jfMw/UasZhv5pwI0KjaJMVRZkCZJrN
         3RJnGXNm690WuQIt8pfRrbTLKQ1Nms+m2XDpJ9LNekWnCm2K8Ui8JKrkDzneuxOGmTiX
         QNn7/8dMRKWKcyqLeUTKIwgoM4yOr5HtUeyLv/HyxOQ/r5tPZemUURmEtvDGsd/zVffS
         lvdQFqxKBjTVBj1/erDk9ys6Uz5S++FRcWrPetzXefU3bETPA57Z6WNmtlydmNewV0gF
         wI7HlColpG+y6428UPuUPlM6j25PgnSdNT/44LXg/9cRXjQZK6rhAKz/qgOj+fhkb4Vl
         d9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbyW2w5H9Ka2dhH/td4Wv+BKvF3xkANmkzFDgDmtue8=;
        b=gJ/B3JC9Jh9qq3UkT1+hFOtwvvAOHro4KB5XsAtDAfVRefuMCMSN9beuPSveBOwl02
         1wXyFvG+GuiBqttX2QUT24sLLWB1375ruGK9SALfvpAK4YX1g4auMon5LtVr8Yv5NMoF
         PFr3bk07vdQEC7GTEgpKzWaI6/jiKiYiSQ5Iple/RgA70fmkUA5EdvM4a7VmTKFl6nUW
         A6gEImQ+GSE0HoyxweMjwTYS9ssW+o3Q9GUuZhc3h3PIHxfP9xtkn02cbI63l8ussYvE
         PRKv7lGMH4UcSLln1cIQNW5Qda+NatL9EuvbUI9UtkDtzI3dkYj2ejWWYhoxkJbii00n
         1fRA==
X-Gm-Message-State: AOAM530iSkLhYdBVcWXoLiDVU4goh0FX+kZqzhr3WT9OqulHTeal9foT
        kgfE93E2tzEmy5723bJrNn9TFDM8f0oyHA==
X-Google-Smtp-Source: ABdhPJwFw2pOZnyh9oRygVJ7qZsJlbB+WneoIlqrRr1h8lnQhxkv3D6qguqu3L0NrWtNcrca2PY/tQ==
X-Received: by 2002:a05:6402:2995:b0:425:d3a1:28aa with SMTP id eq21-20020a056402299500b00425d3a128aamr27611771edb.247.1651133479617;
        Thu, 28 Apr 2022 01:11:19 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id e26-20020aa7d7da000000b0042617ba63ccsm1106214eds.86.2022.04.28.01.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 01:11:19 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 13/45] media: sun6i-csi: Introduce and use video helper functions
Date:   Thu, 28 Apr 2022 10:11:18 +0200
Message-ID: <1701259.X513TT2pbd@jernej-laptop>
In-Reply-To: <YmpKlePweCAyeOT0@aptenodytes>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <13001485.uLZWGnKmhe@jernej-laptop> <YmpKlePweCAyeOT0@aptenodytes>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 28. april 2022 ob 10:04:37 CEST je Paul Kocialkowski napi=
sal(a):
> Hi Jernej,
>=20
> On Wed 27 Apr 22, 20:50, Jernej =C5=A0krabec wrote:
> > Dne petek, 15. april 2022 ob 17:27:39 CEST je Paul Kocialkowski=20
napisal(a):
> > > Introduce some helpers for buffer and general video configuration.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >=20
> > >  .../platform/sunxi/sun6i-csi/sun6i_video.c    | 46 +++++++++++------=
=2D-
> > >  1 file changed, 28 insertions(+), 18 deletions(-)
> > >=20
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> > > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c index
> > > e6c85fcc65bb..e47eeb27dc4e 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> > > @@ -92,6 +92,29 @@ static bool sun6i_video_format_check(u32 format)
> > >=20
> > >  	return false;
> > > =20
> > >  }
> > >=20
> > > +/* Video */
> > > +
> > > +static void sun6i_video_buffer_configure(struct sun6i_csi_device
> > > *csi_dev,
> > > +					 struct=20
sun6i_csi_buffer
> >=20
> > *csi_buffer)
> >=20
> > > +{
> > > +	csi_buffer->queued_to_csi =3D true;
> > > +	sun6i_csi_update_buf_addr(csi_dev, csi_buffer->dma_addr);
> > > +}
> > > +
> > > +static void sun6i_video_configure(struct sun6i_csi_device *csi_dev)
> > > +{
> > > +	struct sun6i_video *video =3D &csi_dev->video;
> > > +	struct sun6i_csi_config config =3D { 0 };
> > > +
> > > +	config.pixelformat =3D video->format.fmt.pix.pixelformat;
> > > +	config.code =3D video->mbus_code;
> > > +	config.field =3D video->format.fmt.pix.field;
> > > +	config.width =3D video->format.fmt.pix.width;
> > > +	config.height =3D video->format.fmt.pix.height;
> > > +
> > > +	sun6i_csi_update_config(csi_dev, &config);
> > > +}
> > > +
> > >=20
> > >  /* Queue */
> > > =20
> > >  static int sun6i_video_queue_setup(struct vb2_queue *queue,
> > >=20
> > > @@ -160,7 +183,6 @@ static int sun6i_video_start_streaming(struct
> > > vb2_queue
> > > *queue, struct video_device *video_dev =3D &video->video_dev;
> > >=20
> > >  	struct sun6i_csi_buffer *buf;
> > >  	struct sun6i_csi_buffer *next_buf;
> > >=20
> > > -	struct sun6i_csi_config config;
> > >=20
> > >  	struct v4l2_subdev *subdev;
> > >  	unsigned long flags;
> > >  	int ret;
> > >=20
> > > @@ -182,22 +204,13 @@ static int sun6i_video_start_streaming(struct
> > > vb2_queue *queue, goto error_media_pipeline;
> > >=20
> > >  	}
> > >=20
> > > -	config.pixelformat =3D video->format.fmt.pix.pixelformat;
> > > -	config.code =3D video->mbus_code;
> > > -	config.field =3D video->format.fmt.pix.field;
> > > -	config.width =3D video->format.fmt.pix.width;
> > > -	config.height =3D video->format.fmt.pix.height;
> > > -
> > > -	ret =3D sun6i_csi_update_config(csi_dev, &config);
> > > -	if (ret < 0)
> > > -		goto error_media_pipeline;
> > > +	sun6i_video_configure(csi_dev);
> >=20
> > What happened to that error handling? New helper function ignores return
> > value of sun6i_csi_update_config(). Why?
>=20
> Ah that's a good point, the error value is still being returned by
> sun6i_csi_update_config so it should be kept around at this stage.
>=20
> Note that this is a transitional commit and sun6i_video_configure
> (which gets renamed to sun6i_csi_capture_configure) is eventually
> reworked to only configure registers (no checks) and returns void.
>=20
> If you think it's important to keep it in the meantime I can do that.

If it's only transitional, then it's fine.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> Paul
>=20
> > Best regards,
> > Jernej
> >=20
> > >  	spin_lock_irqsave(&video->dma_queue_lock, flags);
> > >  =09
> > >  	buf =3D list_first_entry(&video->dma_queue,
> > >  =09
> > >  			       struct sun6i_csi_buffer, list);
> > >=20
> > > -	buf->queued_to_csi =3D true;
> > > -	sun6i_csi_update_buf_addr(csi_dev, buf->dma_addr);
> > > +	sun6i_video_buffer_configure(csi_dev, buf);
> > >=20
> > >  	sun6i_csi_set_stream(csi_dev, true);
> > >=20
> > > @@ -219,8 +232,7 @@ static int sun6i_video_start_streaming(struct
> > > vb2_queue
> > > *queue, * would also drop frame when lacking of queued buffer.
> > >=20
> > >  	 */
> > >  =09
> > >  	next_buf =3D list_next_entry(buf, list);
> > >=20
> > > -	next_buf->queued_to_csi =3D true;
> > > -	sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
> > > +	sun6i_video_buffer_configure(csi_dev, next_buf);
> > >=20
> > >  	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
> > >=20
> > > @@ -294,8 +306,7 @@ void sun6i_video_frame_done(struct sun6i_csi_devi=
ce
> > > *csi_dev) * for next ISR call.
> > >=20
> > >  	 */
> > >  =09
> > >  	if (!next_buf->queued_to_csi) {
> > >=20
> > > -		next_buf->queued_to_csi =3D true;
> > > -		sun6i_csi_update_buf_addr(csi_dev, next_buf-
>dma_addr);
> > > +		sun6i_video_buffer_configure(csi_dev, next_buf);
> > >=20
> > >  		dev_dbg(csi_dev->dev, "Frame dropped!\n");
> > >  		goto complete;
> > >  =09
> > >  	}
> > >=20
> > > @@ -309,8 +320,7 @@ void sun6i_video_frame_done(struct sun6i_csi_devi=
ce
> > > *csi_dev) /* Prepare buffer for next frame but one.  */
> > >=20
> > >  	if (!list_is_last(&next_buf->list, &video->dma_queue)) {
> > >  =09
> > >  		next_buf =3D list_next_entry(next_buf, list);
> > >=20
> > > -		next_buf->queued_to_csi =3D true;
> > > -		sun6i_csi_update_buf_addr(csi_dev, next_buf-
>dma_addr);
> > > +		sun6i_video_buffer_configure(csi_dev, next_buf);
> > >=20
> > >  	} else {
> > >  =09
> > >  		dev_dbg(csi_dev->dev, "Next frame will be dropped!
\n");
> > >  =09
> > >  	}




