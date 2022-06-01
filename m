Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED4D53AB18
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356150AbiFAQfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353043AbiFAQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:35:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0100C580F8;
        Wed,  1 Jun 2022 09:35:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id jx22so4849871ejb.12;
        Wed, 01 Jun 2022 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1EvKDiEy2mDM7M3ZxgWlbFl9Z+GodMXi6d9iudxPnGU=;
        b=JmLG+8b1EiVyVLTs8YmmpsnIEKHzGCt2qwyKITVt7fKPZxzr3XE7JUluqsYAgcnjzj
         8pvWHwtmIs/K8xHs/RojrozRWD+hVjb+8am5zwbKSJW9iWcfRVFfDlOAY+M3mpi8EESo
         fivqF5g2Vz+djoM+R3szKSLr7vKErG0Blu07ShZ96dy4WFXJdC2ekugfoUe9oPuW7fXj
         7nzjtDxgtl3UKZWdXcL0Nk9TTaT6gPROks2F99d1yJhoavZ6z8UvxsYKF6jBUabRxAxc
         WCz7X72s1LfYpm4Ebfzd95hosS6lhJCySs2upwzaqaYW4zKvyf7gMf0Pruk7Ka5aorjx
         8EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EvKDiEy2mDM7M3ZxgWlbFl9Z+GodMXi6d9iudxPnGU=;
        b=RBWHdlfNDJcjKkrXtH32E4938ghF3S+5cT+Jd4zZUCWLrbUOv8pej7CNcn4XT+reRx
         nsTl4xem8GwKFkijJEhrpsnZMCUB7y3cB4NB51mjj7AzMv+MBfw0qTprq4o28ShizVsz
         KF85YOiJ8dNFFDnWRF8sCb+v6+Ls6WkDUda6Xc5QWydXMMP0lXMGrHG/wJifGs9OGFpI
         S0z923hxdVrHv6FQeKAOAfW103oBYWkfdkY8YlrASkoZpy3BIHRG3cQbl97ebgqQ1yfQ
         nril+kaw6frHTH/dwbyqyk5tOHxN2gooxjk96S2EI/ZSaoP2xJ/JrPMNPtS7GoZXANxa
         Ow6g==
X-Gm-Message-State: AOAM530a0hMUQDl14nDfpMSLRnneM+c9w6UvMsTetnIFf2jwRqtGRfmY
        K3YD96Q8MsO0FsNIlswb9EQ=
X-Google-Smtp-Source: ABdhPJwxZzkqm5dCsP8Ds0XHL9RdHf0YFnMeVJGn/lyzHpSOHMWBIVw1LWtDn0BIibmiKKHXbbXOTg==
X-Received: by 2002:a17:907:1621:b0:6fe:fc8f:21f1 with SMTP id hb33-20020a170907162100b006fefc8f21f1mr321615ejc.359.1654101325457;
        Wed, 01 Jun 2022 09:35:25 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402150300b0042dd3bf1403sm1177480edw.54.2022.06.01.09.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 09:35:25 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, andrzej.p@collabora.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v6 11/17] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Date:   Wed, 01 Jun 2022 18:35:23 +0200
Message-ID: <11988268.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <95261aa18425e8f5571888a41ee03d9dfd2814b9.camel@collabora.com>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com> <2102878.irdbgypaU6@kista> <95261aa18425e8f5571888a41ee03d9dfd2814b9.camel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 01. junij 2022 ob 18:20:53 CEST je Nicolas Dufresne napisal(a):
> Le mardi 31 mai 2022 =C3=A0 20:20 +0200, Jernej =C5=A0krabec a =C3=A9crit=
 :
> > Dne torek, 31. maj 2022 ob 08:58:46 CEST je Benjamin Gaignard napisal(a=
):
> > > Le 30/05/2022 =C3=A0 23:24, Jernej =C5=A0krabec a =C3=A9crit :
> > > > Dne ponedeljek, 30. maj 2022 ob 15:49:57 CEST je Hans Verkuil=20
napisal(a):
> > > > > On 30/05/2022 11:18, Hans Verkuil wrote:
> > > > > > On 29/05/2022 08:40, Jernej =C5=A0krabec wrote:
> > > > > > > Hi!
> > > > > > >=20
> > > > > > > This series looks very good and I plan to test it shortly on
> > > > > > > Cedrus,
> >=20
> > but
> >=20
> > > > I
> > > >=20
> > > > > > > have one major concern below.
> > > > > > >=20
> > > > > > > Dne petek, 27. maj 2022 ob 16:31:28 CEST je Benjamin Gaignard
> >=20
> > napisal(a):
> > > > > > > > The number of 'entry point offset' can be very variable.
> > > > > > > > Instead of using a large static array define a v4l2 dynamic
> > > > > > > > array
> > > > > > > > of U32 (V4L2_CTRL_TYPE_U32).
> > > > > > > > The number of entry point offsets is reported by the elems
> > > > > > > > field
> > > > > > > > and in struct
> > > > > > > > v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
> > > > > > > > field.
> > > > > > >=20
> > > > > > > Slice control by itself is variable length array, so you would
> > > > > > > actually
> > > >=20
> > > > need
> > > >=20
> > > > > > > 2D variable array for entry points which is not supported.
> > > > > > > However,
> >=20
> > easy
> >=20
> > > > > > > workaround for that is to flatten 2D array to 1D and either h=
ave
> > > > > > > another
> > > >=20
> > > > slice
> > > >=20
> > > > > > > control field which would tell first entry point index for
> > > > > > > convenience or
> > > >=20
> > > > let
> > > >=20
> > > > > > > driver calculate it by adding up all num_entry_point_offsets =
of
> > > > > > > previous
> > > > > > > slices.
> > > > > > >=20
> > > > > > > Hans, what do you think?
> > > > > >=20
> > > > > > If I would support 2D variable array sizes, wouldn't that be mo=
re
> >=20
> > elegant?
> >=20
> > > > > > The current implementation doesn't support that, but as the com=
mit
> > > > > > log
> >=20
> > for
> >=20
> > > > > > patch 1/17 says:
> > > > > >=20
> > > > > > "Currently dynamically sized arrays are limited to one dimensio=
nal
> >=20
> > arrays,
> >=20
> > > > > > but that might change in the future if there is a need for it."
> > > > > >=20
> > > > > > Let me know if you agree, and I'll try to implement this. It's
> > > > > > been a
> > > >=20
> > > > while
> > > >=20
> > > > > > since I last looked at this, so I'm not sure how much work it i=
s,
> > > > > > but it
> > > >=20
> > > > is
> > > >=20
> > > > > > probably worth a shot.
> > > > >=20
> > > > > Digging more into this made me realize that this doesn't actually
> > > > > help
> >=20
> > for
> >=20
> > > > this
> > > >=20
> > > > > particular case.
> > > > >=20
> > > > > I would lean towards your second suggestion of adding up all
> > > >=20
> > > > num_entry_point_offsets
> > > >=20
> > > > > of previous slices.
> > > >=20
> > > > Just one question/clarification about dynamic arrays - does driver
> > > > need to
> > > > reserve maximum amount of memory for dynamic array control at
> >=20
> > initialization
> >=20
> > > > time? If so, this would still be problematic, since there cound be a
> > > > huge
> > > > amount of entry points in theory.
> > >=20
> > > When adding the control the driver could set .dims field to specify
> > > the max number of accepted slices.
> > > I have added '#define V4L2_HEVC_SLICE_MAX_COUNT 600' that you could u=
se
> > > for this field. It is the value we have found when using slices with
> > > RKVDEC
> > > driver.
> >=20
> > Is this maximum value applicable only to RKVDEC or is universal? Anyway,
> > this means maximum offset points control for Cedrus would be 600 * 1024
> > (max. offset points supported per slice) * 4 ~=3D 2.4 MB, which is a lot
> > for one control, but I can live with that...
>=20
> I believe its defined following "Table A.8 =E2=80=93 General tier and lev=
el limits".
> With the assumption there will never be a level 7 (which I think is fair).
> If anyone saw other reasons for this limit, let me know.
>=20
> This is a worse case scenario, this is quite unlikely in practice, so whi=
le
> performance might be a disaster if your craft a stream for that case, I
> don't think it will ever happen in real life.

But do we really need to cover worst case scenario? In theory, one driver c=
an=20
set limit to (for example) max 100 slices and if there is a frame with 600=
=20
slices, userspace app would submit 6 decode requests. Basically the same wa=
y=20
it's done today. While not as performant, it would be good compromise betwe=
en=20
resources and speed.

>=20
> > Best regards,
> > Jernej
> >=20
> > > Regards,
> > > Benjamin
> > >=20
> > > > Best regards,
> > > > Jernej
> > > >=20
> > > > > Regards,
> > > > >=20
> > > > > 	Hans
> > > > > =09
> > > > > > Regards,
> > > > > >=20
> > > > > > 	Hans
> > > > > > =09
> > > > > > > Note, it seems that H265 decoding on Cedrus still works witho=
ut
> > > > > > > entry
> > > >=20
> > > > points,
> > > >=20
> > > > > > > so this problem can be solved later. I'm not sure what we lose
> > > > > > > with
> >=20
> > that
> >=20
> > > > but
> > > >=20
> > > > > > > it was suggested that this could influence speed or error
> > > > > > > resilience or
> > > >=20
> > > > both.
> > > >=20
> > > > > > > However, I think we're close to solve it, so I'd like to do t=
hat
> > > > > > > now.
> > > > > > >=20
> > > > > > > Best regards,
> > > > > > > Jernej
> > > > > > >=20
> > > > > > > > Signed-off-by: Benjamin Gaignard
> > > > > > > > <benjamin.gaignard@collabora.com>
> > > > > > > > ---
> > > > > > > >=20
> > > > > > > >   .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11
> > > > > > > >   +++++++++
> >=20
> > ++
> >=20
> > > > > > > >   drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5
> > > > > > > >   +++++
> > > > > > > >   include/media/hevc-ctrls.h                            |  5
> > > > > > > >   ++++-
> > > > > > > >   3 files changed, 20 insertions(+), 1 deletion(-)
> > > > > > > >=20
> > > > > > > > diff --git
> > > > > > > > a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >=20
> > b/
> >=20
> > > > > > > Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > > > > >=20
> > > > > > > > index 0796b1563daa..05228e280f66 100644
> > > > > > > > ---
> > > > > > > > a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > > > > > > +++
> > > > > > > > b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > > > > > > @@ -3010,6 +3010,9 @@ enum
> > > > > > > > v4l2_mpeg_video_hevc_size_of_length_field -
> > > > > > > >=20
> > > > > > > >       * - __u32
> > > > > > > >      =20
> > > > > > > >         - ``data_bit_offset``
> > > > > > > >         - Offset (in bits) to the video data in the current
> > > > > > > >         slice data.
> > > > > > > >=20
> > > > > > > > +    * - __u32
> > > > > > > > +      - ``num_entry_point_offsets``
> > > > > > > > +      - Specifies the number of entry point offset syntax
> > > > > > > > elements in
> >=20
> > the
> >=20
> > > > > > > slice header.
> > > > > > >=20
> > > > > > > >       * - __u8
> > > > > > > >      =20
> > > > > > > >         - ``nal_unit_type``
> > > > > > > >         - Specifies the coding type of the slice (B, P or I=
).
> > > > > > > >=20
> > > > > > > > @@ -3150,6 +3153,14 @@ enum
> > > > > > > > v4l2_mpeg_video_hevc_size_of_length_field -
> > > > > > > >=20
> > > > > > > >       \normalsize
> > > > > > > >=20
> > > > > > > > +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
> > > > > > > > +    Specifies entry point offsets in bytes.
> > > > > > > > +    This control is a dynamically sized array. The number =
of
> > > > > > > > entry
> > > >=20
> > > > point
> > > >=20
> > > > > > > > +    offsets is reported by the ``elems`` field.
> > > > > > > > +    This bitstream parameter is defined according to
> > > > > > > > :ref:`hevc`.
> > > > > > > > +    They are described in section 7.4.7.1 "General slice
> > > > > > > > segment
> >=20
> > header
> >=20
> > > > > > > > +    semantics" of the specification.
> > > > > > > > +
> > > > > > > >=20
> > > > > > > >   ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
> > > > > > > >  =20
> > > > > > > >       Specifies the HEVC scaling matrix parameters used for
> > > > > > > >       the scaling
> > > > > > >=20
> > > > > > > process
> > > > > > >=20
> > > > > > > >       for transform coefficients.
> > > > > > > >=20
> > > > > > > > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > > > > > > b/drivers/media/
> > > >=20
> > > > v4l2-
> > > >=20
> > > > > > > core/v4l2-ctrls-defs.c
> > > > > > >=20
> > > > > > > > index d594efbcbb93..e22921e7ea61 100644
> > > > > > > > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > > > > > > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > > > > > > @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> > > > > > > >=20
> > > > > > > >   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:	=09
return
> > > > > > >=20
> > > > > > > "HEVC Decode Parameters";
> > > > > > >=20
> > > > > > > >   	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:	=09
return
> > > > > > >=20
> > > > > > > "HEVC Decode Mode";
> > > > > > >=20
> > > > > > > >   	case V4L2_CID_STATELESS_HEVC_START_CODE:	=09
return
> > > > > > >=20
> > > > > > > "HEVC Start Code";
> > > > > > >=20
> > > > > > > > +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:=09
return
> > > > > > >=20
> > > > > > > "HEVC Entry Point Offsets";
> > > > > > >=20
> > > > > > > >   	/* Colorimetry controls */
> > > > > > > >   	/* Keep the order of the 'case's the same as in
> > > > > > > >   	v4l2-controls.h!
> > > > > > >=20
> > > > > > > */
> > > > > > >=20
> > > > > > > > @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const ch=
ar
> > > > > > > > **name,
> > > >=20
> > > > enum
> > > >=20
> > > > > > > v4l2_ctrl_type *type,
> > > > > > >=20
> > > > > > > >   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
> > > > > > > >   		*type =3D=20
V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
> > > > > > > >   		break;
> > > > > > > >=20
> > > > > > > > +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
> > > > > > > > +		*type =3D V4L2_CTRL_TYPE_U32;
> > > > > > > > +		*flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> > > > > > > > +		break;
> > > > > > > >=20
> > > > > > > >   	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
> > > > > > > >   		*type =3D=20
V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
> > > > > > > >   		break;
> > > > > > > >=20
> > > > > > > > diff --git a/include/media/hevc-ctrls.h
> > > > > > > > b/include/media/hevc-ctrls.h
> > > > > > > > index a3c829ef531a..1319cb99ae3f 100644
> > > > > > > > --- a/include/media/hevc-ctrls.h
> > > > > > > > +++ b/include/media/hevc-ctrls.h
> > > > > > > > @@ -20,6 +20,7 @@
> > > > > > > >=20
> > > > > > > >   #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS
> >=20
> > (V4L2_CID_CODEC_BASE
> >=20
> > > > > > > + 1012)
> > > > > > >=20
> > > > > > > >   #define V4L2_CID_STATELESS_HEVC_DECODE_MODE
> >=20
> > (V4L2_CID_CODEC_BASE
> >=20
> > > > + 1015)
> > > >=20
> > > > > > > >   #define V4L2_CID_STATELESS_HEVC_START_CODE
> >=20
> > (V4L2_CID_CODEC_BASE + 1016)
> >=20
> > > > > > > > +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
> >=20
> > (V4L2_CID_CODEC_BASE
> >=20
> > > > +
> > > >=20
> > > > > > > 1017)
> > > > > > >=20
> > > > > > > >   /* enum v4l2_ctrl_type type values */
> > > > > > > >   #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> > > > > > > >=20
> > > > > > > > @@ -318,6 +319,8 @@ struct v4l2_hevc_pred_weight_table {
> > > > > > > >=20
> > > > > > > >    *
> > > > > > > >    * @bit_size: size (in bits) of the current slice data
> > > > > > > >    * @data_bit_offset: offset (in bits) to the video data in
> > > > > > > >    the current
> > > >=20
> > > > slice
> > > >=20
> > > > > > > data
> > > > > > >=20
> > > > > > > > + * @num_entry_point_offsets: specifies the number of entry
> > > > > > > > point offset
> > > >=20
> > > > syntax
> > > >=20
> > > > > > > > + *			     elements in the slice=20
header.
> > > > > > > >=20
> > > > > > > >    * @nal_unit_type: specifies the coding type of the slice
> > > > > > > >    (B, P or I)
> > > > > > > >    * @nuh_temporal_id_plus1: minus 1 specifies a temporal
> > > > > > > >    identifier for
> > > >=20
> > > > the
> > > >=20
> > > > > > > NAL unit
> > > > > > >=20
> > > > > > > >    * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
> > > > > > > >=20
> > > > > > > > @@ -360,7 +363,7 @@ struct v4l2_hevc_pred_weight_table {
> > > > > > > >=20
> > > > > > > >   struct v4l2_ctrl_hevc_slice_params {
> > > > > > > >  =20
> > > > > > > >   	__u32	bit_size;
> > > > > > > >   	__u32	data_bit_offset;
> > > > > > > >=20
> > > > > > > > -
> > > > > > > > +	__u32	num_entry_point_offsets;
> > > > > > > >=20
> > > > > > > >   	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit=20
header */
> > > > > > > >   	__u8	nal_unit_type;
> > > > > > > >   	__u8	nuh_temporal_id_plus1;




