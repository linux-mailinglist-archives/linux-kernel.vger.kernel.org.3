Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385414F4942
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392132AbiDEWJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457450AbiDEQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809B129C85;
        Tue,  5 Apr 2022 08:45:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 6D8A91F45363
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649173505;
        bh=JztdWyn4zziH9ZCDywtAj0401GGJ+F6Gh6lAOrlJVn0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F/JTFnrOUX5ld+nCQAlSFBiWbidM6sjYzQfKABxhezmsugaSjKXbZTYa3mJI2NO7Z
         prUuuq4CLDhuxZMRAt/1DdlXXdMbQzQoD8UBDr2nmOinv8OiXT6pA7wwewyZnawB+I
         bdseOHQ1aS6Frr4iZN9RIgvG9SZFSGGh3vqJQEMuKS+Sad21/PBn5eOh+G8l1nQGHB
         Kni9YQ1tC8iiDpl2EO1zIXNNQEQ5u400SXnZpSX9bFi2gpKBS+ObKFjvY+8X3aXN92
         zvYQmwOEfYwpsDEjXJJrRfiYGQXodXKolpKhN0USNA5NvvFePqzP/dCVwLRSUKrBH2
         E5NIhLqCk1BJw==
Message-ID: <67742466181fef8ca42d8f5ad2815a46367f5fa7.camel@collabora.com>
Subject: Re: [PATCH v2 15/23] media: rkvdec: h264: Validate and use pic
 width and height in mbs
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 05 Apr 2022 11:44:54 -0400
In-Reply-To: <Ykg0Qw24PuGCnbLT@eze-laptop>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
         <20220331193726.289559-16-nicolas.dufresne@collabora.com>
         <Ykg0Qw24PuGCnbLT@eze-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 02 avril 2022 =C3=A0 08:32 -0300, Ezequiel Garcia a =C3=A9crit=C2=
=A0:
> Hi Nicolas,
>=20
> On Thu, Mar 31, 2022 at 03:37:17PM -0400, Nicolas Dufresne wrote:
> > From: Jonas Karlman <jonas@kwiboo.se>
> >=20
> > The width and height in macroblocks is currently configured based on OU=
TPUT
> > buffer resolution, this works for frame pictures but can cause issues f=
or
> > field pictures.
> >=20
> > When frame_mbs_only_flag is 0 the height in mbs should be height of
> > the field instead of height of frame.
> >=20
> > Validate pic_width_in_mbs_minus1 and pic_height_in_map_units_minus1
> > against OUTPUT buffer resolution and use these values to configure HW.
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > ---
> >  drivers/staging/media/rkvdec/rkvdec-h264.c |  4 ++--
> >  drivers/staging/media/rkvdec/rkvdec.c      | 10 ++++++++++
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/stagi=
ng/media/rkvdec/rkvdec-h264.c
> > index 8d44a884a52e..a42cf19bcc6d 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> > +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > @@ -672,8 +672,8 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
> >  		  LOG2_MAX_PIC_ORDER_CNT_LSB_MINUS4);
> >  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_Z=
ERO),
> >  		  DELTA_PIC_ORDER_ALWAYS_ZERO_FLAG);
> > -	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.width, 16), PIC_WIDT=
H_IN_MBS);
> > -	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.height, 16), PIC_HEI=
GHT_IN_MBS);
>=20
> Please add a comment so we don't forget why we use the bitstream
> fields here.

And perhaps I should clarify that only the height will vary. It remains nic=
e if
we can decode smaller images into larger image/format, that will be needed =
to
handle the sub-layers in SVC (these are not to be displayed, so we don't ca=
re
much about the output stride and all). So that is also an improvement.

>=20
> > +	WRITE_PPS(sps->pic_width_in_mbs_minus1 + 1, PIC_WIDTH_IN_MBS);
> > +	WRITE_PPS(sps->pic_height_in_map_units_minus1 + 1, PIC_HEIGHT_IN_MBS)=
;
> >  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY),
> >  		  FRAME_MBS_ONLY_FLAG);
> >  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD)=
,
> > diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/me=
dia/rkvdec/rkvdec.c
> > index 2df8cf4883e2..1b805710e195 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec.c
> > +++ b/drivers/staging/media/rkvdec/rkvdec.c
> > @@ -29,8 +29,11 @@
> > =20
> >  static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
> >  {
> > +	struct rkvdec_ctx *ctx =3D container_of(ctrl->handler, struct rkvdec_=
ctx, ctrl_hdl);
> > +
> >  	if (ctrl->id =3D=3D V4L2_CID_STATELESS_H264_SPS) {
> >  		const struct v4l2_ctrl_h264_sps *sps =3D ctrl->p_new.p_h264_sps;
> > +		unsigned int width, height;
> >  		/*
> >  		 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
> >  		 * but it's currently broken in the driver.
> > @@ -45,6 +48,13 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
> >  		if (sps->bit_depth_luma_minus8 !=3D 0)
> >  			/* Only 8-bit is supported */
> >  			return -EINVAL;
> > +
> > +		width =3D (sps->pic_width_in_mbs_minus1 + 1) * 16;
> > +		height =3D (sps->pic_height_in_map_units_minus1 + 1) * 16;
> > +
>=20
> Let's please add a comment here, clarifying it's legal to check
> the coded format (OUTPUT queue format) at .try_ctrl time,
> because the stateless decoder specification [1] mandates
> S_FMT on the OUTPUT queue, before passing the SPS/PPS controls.

Indeed, though I come to see some flaw in the validation. First, the height
formula shall be base on formula 7-18 from the spec:

  FrameHeightInMbs =3D ( 2 =E2=88=92 frame_mbs_only_flag ) * PicHeightInMap=
Units

So would be

+		height =3D (sps->pic_height_in_map_units_minus1 + 1) * 16;
+		if (sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY)
+			height *=3D 2;

As this driver do interleaved interlaced buffer, not alternate. Finally, we
should validate this again at STREAMON, since userland may have simply omit=
ted
to set the SPS at all. I'll try to improve this and drop the review tag to
ensure this get fully reviewed again.

>=20
> [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-st=
ateless-decoder.html
>=20
> > +		if (width > ctx->coded_fmt.fmt.pix_mp.width ||
> > +		    height > ctx->coded_fmt.fmt.pix_mp.height)
>=20
> Can you add a debug message or error message?
> These silent errors tend to get super hard to track.
>=20
> With these changes:
>=20
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>=20
> Thanks,
> Ezequiel

