Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B04F47A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357000AbiDEVPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457531AbiDEQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:06:09 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309EE10A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:04:11 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id b18so11779654qtk.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=M0AxM4HSzB7FJcdzLwDtwhTPLQwBjyaSdnNslV5A3vg=;
        b=oz4snY86uIc3rIeVZ7k6FgFvhGrLQYPuqNGF4lD9hxbg3b9nlIUgoMVTYTl3FmVe/E
         HnP6sz4pshofkv2LURFzZzcp/wteKk5qZvGHtojO36beRHg5Jzgpy99IurxRuGuI/cfN
         yNBLTwv4qtvLyZFKMgxgI6kmg8g7lQZvjhjJtcs76L77aaF9535VkvpeLCDiZLPUO8FB
         0HAw4gDFwbBqeHgA8H0PDVt+vFpPXmgozBBflP1bbzvW0fDOJVCRzvYyDtA2Q1HwtmUj
         2F/isJBjYZt6TWpuiN05uQ/Sp3HpAIe0EWuEsKhgoXuE9lCwEJL11XaitL70iS1uYAT0
         wF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=M0AxM4HSzB7FJcdzLwDtwhTPLQwBjyaSdnNslV5A3vg=;
        b=7k2N7+tceAqHfYv0GSyBwSTQYtDdxLpPxufjPrQnhT4oHTAXHvpe+P8Fv1vAJn72ZM
         S21uNmi2lRNEYSbl+UOOrk4uLME2eQgTevXifDRp5JbHmD4rU4KXAEFb4gfcZ7SkAUIe
         QFGEKGaaYOCZOyFlaV93HsgtxQNnNpv5GxfDM+BRHi62eoEudOo7FMJh/1u8e/s+8ok+
         pxwkq50qT4wHGiVOlsCsnXHsP9VUgOdAZfDRFhdlI24WptegMiMiq1V/V4nksSr2qTgJ
         vUuW3NrimIGTymI0mxGtCWB3kr/awEMX3qMJWu3vHusoK76NOmJX4NYDPyunxrZj876Y
         3g/g==
X-Gm-Message-State: AOAM532A/rWreAdXgah8LbOeyVl0N4sOxPJd3EBX8IIVEta/rGTc1pRm
        ijtga/4+Nt9XXRSIEz7/8wcS2g==
X-Google-Smtp-Source: ABdhPJwFDlRbxAqvWBRRoal6aGIaiCE0/MScYJoaefU7HyMjKB5dZEm/lU5tyaiVIAEm8QCo1kMITw==
X-Received: by 2002:a05:620a:400b:b0:67d:4f86:68a9 with SMTP id h11-20020a05620a400b00b0067d4f8668a9mr2675520qko.89.1649174650084;
        Tue, 05 Apr 2022 09:04:10 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002e06aa02021sm11358795qta.49.2022.04.05.09.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 09:04:09 -0700 (PDT)
Message-ID: <2abb0d787bf6579015d45123d1d9b6e86ceff3b4.camel@ndufresne.ca>
Subject: Re: [PATCH v2 15/23] media: rkvdec: h264: Validate and use pic
 width and height in mbs
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 05 Apr 2022 12:04:08 -0400
In-Reply-To: <67742466181fef8ca42d8f5ad2815a46367f5fa7.camel@collabora.com>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
         <20220331193726.289559-16-nicolas.dufresne@collabora.com>
         <Ykg0Qw24PuGCnbLT@eze-laptop>
         <67742466181fef8ca42d8f5ad2815a46367f5fa7.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 05 avril 2022 =C3=A0 11:44 -0400, Nicolas Dufresne a =C3=A9crit=C2=
=A0:
> Le samedi 02 avril 2022 =C3=A0 08:32 -0300, Ezequiel Garcia a =C3=A9crit=
=C2=A0:
> > Hi Nicolas,
> >=20
> > On Thu, Mar 31, 2022 at 03:37:17PM -0400, Nicolas Dufresne wrote:
> > > From: Jonas Karlman <jonas@kwiboo.se>
> > >=20
> > > The width and height in macroblocks is currently configured based on =
OUTPUT
> > > buffer resolution, this works for frame pictures but can cause issues=
 for
> > > field pictures.
> > >=20
> > > When frame_mbs_only_flag is 0 the height in mbs should be height of
> > > the field instead of height of frame.
> > >=20
> > > Validate pic_width_in_mbs_minus1 and pic_height_in_map_units_minus1
> > > against OUTPUT buffer resolution and use these values to configure HW=
.
> > >=20
> > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > > Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > > ---
> > >  drivers/staging/media/rkvdec/rkvdec-h264.c |  4 ++--
> > >  drivers/staging/media/rkvdec/rkvdec.c      | 10 ++++++++++
> > >  2 files changed, 12 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/sta=
ging/media/rkvdec/rkvdec-h264.c
> > > index 8d44a884a52e..a42cf19bcc6d 100644
> > > --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> > > +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > > @@ -672,8 +672,8 @@ static void assemble_hw_pps(struct rkvdec_ctx *ct=
x,
> > >  		  LOG2_MAX_PIC_ORDER_CNT_LSB_MINUS4);
> > >  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS=
_ZERO),
> > >  		  DELTA_PIC_ORDER_ALWAYS_ZERO_FLAG);
> > > -	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.width, 16), PIC_WI=
DTH_IN_MBS);
> > > -	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.height, 16), PIC_H=
EIGHT_IN_MBS);
> >=20
> > Please add a comment so we don't forget why we use the bitstream
> > fields here.
>=20
> And perhaps I should clarify that only the height will vary. It remains n=
ice if
> we can decode smaller images into larger image/format, that will be neede=
d to
> handle the sub-layers in SVC (these are not to be displayed, so we don't =
care
> much about the output stride and all). So that is also an improvement.
>=20
> >=20
> > > +	WRITE_PPS(sps->pic_width_in_mbs_minus1 + 1, PIC_WIDTH_IN_MBS);
> > > +	WRITE_PPS(sps->pic_height_in_map_units_minus1 + 1, PIC_HEIGHT_IN_MB=
S);
> > >  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY),
> > >  		  FRAME_MBS_ONLY_FLAG);
> > >  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIEL=
D),
> > > diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/=
media/rkvdec/rkvdec.c
> > > index 2df8cf4883e2..1b805710e195 100644
> > > --- a/drivers/staging/media/rkvdec/rkvdec.c
> > > +++ b/drivers/staging/media/rkvdec/rkvdec.c
> > > @@ -29,8 +29,11 @@
> > > =20
> > >  static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
> > >  {
> > > +	struct rkvdec_ctx *ctx =3D container_of(ctrl->handler, struct rkvde=
c_ctx, ctrl_hdl);
> > > +
> > >  	if (ctrl->id =3D=3D V4L2_CID_STATELESS_H264_SPS) {
> > >  		const struct v4l2_ctrl_h264_sps *sps =3D ctrl->p_new.p_h264_sps;
> > > +		unsigned int width, height;
> > >  		/*
> > >  		 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
> > >  		 * but it's currently broken in the driver.
> > > @@ -45,6 +48,13 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
> > >  		if (sps->bit_depth_luma_minus8 !=3D 0)
> > >  			/* Only 8-bit is supported */
> > >  			return -EINVAL;
> > > +
> > > +		width =3D (sps->pic_width_in_mbs_minus1 + 1) * 16;
> > > +		height =3D (sps->pic_height_in_map_units_minus1 + 1) * 16;
> > > +
> >=20
> > Let's please add a comment here, clarifying it's legal to check
> > the coded format (OUTPUT queue format) at .try_ctrl time,
> > because the stateless decoder specification [1] mandates
> > S_FMT on the OUTPUT queue, before passing the SPS/PPS controls.
>=20
> Indeed, though I come to see some flaw in the validation. First, the heig=
ht
> formula shall be base on formula 7-18 from the spec:
>=20
>   FrameHeightInMbs =3D ( 2 =E2=88=92 frame_mbs_only_flag ) * PicHeightInM=
apUnits
>=20
> So would be
>=20
> +		height =3D (sps->pic_height_in_map_units_minus1 + 1) * 16;
> +		if (sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY)
> +			height *=3D 2;

Oops, I meant:


+		if (!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY))
+			height *=3D 2;


>=20
> As this driver do interleaved interlaced buffer, not alternate. Finally, =
we
> should validate this again at STREAMON, since userland may have simply om=
itted
> to set the SPS at all. I'll try to improve this and drop the review tag t=
o
> ensure this get fully reviewed again.
>=20
> >=20
> > [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-=
stateless-decoder.html
> >=20
> > > +		if (width > ctx->coded_fmt.fmt.pix_mp.width ||
> > > +		    height > ctx->coded_fmt.fmt.pix_mp.height)
> >=20
> > Can you add a debug message or error message?
> > These silent errors tend to get super hard to track.
> >=20
> > With these changes:
> >=20
> > Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> >=20
> > Thanks,
> > Ezequiel
>=20

