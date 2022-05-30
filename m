Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA7D538895
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbiE3VYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiE3VYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:24:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB79994F6;
        Mon, 30 May 2022 14:24:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n10so23074882ejk.5;
        Mon, 30 May 2022 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CE58DyVsFpj1+2/hyAZSSQtjoW8T3CW+eJ7jWuJZvgg=;
        b=Iw4lsRwvQS7PQ4uSFhO6pnlkBU/2pxGh67h4gxpCa1TN0bGK1RRzg6jfX8QiIW0X2z
         dZojQHMJeCH19SaB1N4wLlVv4phDp8xqRvav5elYuMjvGIKTrxWom5gHPRTr7ejeaApU
         OSx1pvMl9z8BUL9TN2TYsJJCoaZjXrFH1B6P+9qqxYmoduJWbzYcxzQ4G11ziYuUEjlk
         0gXR4XnrtOUJxCO+T1m+fsYc6WcJjelUZQx+oCdY1niS0pXFtYcirl75GCHZL4zEPQ2D
         jFoPm9TyaqhcAEy+H3F3VkANMTPkWHVMfZmb8brYHV0JY5Cd47/TgenQnev00Dwy/PxS
         6iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CE58DyVsFpj1+2/hyAZSSQtjoW8T3CW+eJ7jWuJZvgg=;
        b=kR8qVFiIU4wp0YcZzK+2xugfIy6ocnoKquWZv0Rcbfz7ySWBQYfqmbuy8zoxOum2Xb
         C3Rf16Njy71COI/nZGXhmvcBC5ZWcDPRjj+5Ga6jf8CH2M+jAAnYHC9Zdtn4KYqqr5SI
         gc3ywVVvZIW5RV1DOWRGFvEllTweBtNXh24Q8HJQFGudqX5vJLI7N2LbNsJFBR8o+hZm
         aVc/HVl9bc4gBhAmI6PH5WZEs4USPTAASnjFEM3q5Tx3jOiDOJDKWrNXcaN8QO9Xyf51
         kD5MK3ZU2EhInmEG5EhlOCyQTtEO6hYxljIrR65cnnbW4imDVKpcEtPsB6vMQWj5vzuV
         sGFA==
X-Gm-Message-State: AOAM532gU1GQXdXfsurM0Lc74Yc/ah/HO1iAG4rBT2E/+ECR885Z/xgR
        I+pHvo31H3+Z+pd7HIGKHoQ=
X-Google-Smtp-Source: ABdhPJwGS3A1Qmp0+vGUdObvEPcZ7zMJAXqBix8pd9sLBcoG4Rxhn+fBrxg/1jlRdhbKvSTCzipA+A==
X-Received: by 2002:a17:907:720a:b0:6ff:2e1c:f22f with SMTP id dr10-20020a170907720a00b006ff2e1cf22fmr17953781ejc.16.1653945884756;
        Mon, 30 May 2022 14:24:44 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id b16-20020a50b410000000b0042b5cf75d6esm7032775edh.97.2022.05.30.14.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 14:24:44 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, nicolas.dufresne@collabora.com,
        andrzej.p@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: Re: [PATCH v6 11/17] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Date:   Mon, 30 May 2022 23:24:42 +0200
Message-ID: <5824953.lOV4Wx5bFT@kista>
In-Reply-To: <c47b3218-069b-790e-8781-7b6d195ac8a7@xs4all.nl>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com> <c639efc2-2089-359d-44c6-e9d92e8fd22e@xs4all.nl> <c47b3218-069b-790e-8781-7b6d195ac8a7@xs4all.nl>
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

Dne ponedeljek, 30. maj 2022 ob 15:49:57 CEST je Hans Verkuil napisal(a):
> On 30/05/2022 11:18, Hans Verkuil wrote:
> > On 29/05/2022 08:40, Jernej =C5=A0krabec wrote:
> >> Hi!
> >>
> >> This series looks very good and I plan to test it shortly on Cedrus, b=
ut=20
I=20
> >> have one major concern below.
> >>
> >> Dne petek, 27. maj 2022 ob 16:31:28 CEST je Benjamin Gaignard napisal(=
a):
> >>> The number of 'entry point offset' can be very variable.
> >>> Instead of using a large static array define a v4l2 dynamic array
> >>> of U32 (V4L2_CTRL_TYPE_U32).
> >>> The number of entry point offsets is reported by the elems field
> >>> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
> >>> field.
> >>
> >> Slice control by itself is variable length array, so you would actuall=
y=20
need=20
> >> 2D variable array for entry points which is not supported. However, ea=
sy=20
> >> workaround for that is to flatten 2D array to 1D and either have anoth=
er=20
slice=20
> >> control field which would tell first entry point index for convenience=
 or=20
let=20
> >> driver calculate it by adding up all num_entry_point_offsets of previo=
us=20
> >> slices.
> >>
> >> Hans, what do you think?
> >=20
> > If I would support 2D variable array sizes, wouldn't that be more elega=
nt?
> >=20
> > The current implementation doesn't support that, but as the commit log =
for
> > patch 1/17 says:
> >=20
> > "Currently dynamically sized arrays are limited to one dimensional arra=
ys,
> > but that might change in the future if there is a need for it."
> >=20
> > Let me know if you agree, and I'll try to implement this. It's been a=20
while
> > since I last looked at this, so I'm not sure how much work it is, but i=
t=20
is
> > probably worth a shot.
>=20
> Digging more into this made me realize that this doesn't actually help fo=
r=20
this
> particular case.
>=20
> I would lean towards your second suggestion of adding up all=20
num_entry_point_offsets
> of previous slices.

Just one question/clarification about dynamic arrays - does driver need to=
=20
reserve maximum amount of memory for dynamic array control at initializatio=
n=20
time? If so, this would still be problematic, since there cound be a huge=20
amount of entry points in theory.

Best regards,
Jernej

>=20
> Regards,
>=20
> 	Hans
>=20
> >=20
> > Regards,
> >=20
> > 	Hans
> >=20
> >>
> >> Note, it seems that H265 decoding on Cedrus still works without entry=
=20
points,=20
> >> so this problem can be solved later. I'm not sure what we lose with th=
at=20
but=20
> >> it was suggested that this could influence speed or error resilience o=
r=20
both.=20
> >> However, I think we're close to solve it, so I'd like to do that now.
> >>
> >> Best regards,
> >> Jernej
> >>
> >>>
> >>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >>> ---
> >>>  .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11 +++++++++=
++
> >>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
> >>>  include/media/hevc-ctrls.h                            |  5 ++++-
> >>>  3 files changed, 20 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rs=
t b/
> >> Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >>> index 0796b1563daa..05228e280f66 100644
> >>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >>> @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> >>>      * - __u32
> >>>        - ``data_bit_offset``
> >>>        - Offset (in bits) to the video data in the current slice data.
> >>> +    * - __u32
> >>> +      - ``num_entry_point_offsets``
> >>> +      - Specifies the number of entry point offset syntax elements i=
n the=20
> >> slice header.
> >>>      * - __u8
> >>>        - ``nal_unit_type``
> >>>        - Specifies the coding type of the slice (B, P or I).
> >>> @@ -3150,6 +3153,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_field=
 -
> >>> =20
> >>>      \normalsize
> >>> =20
> >>> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
> >>> +    Specifies entry point offsets in bytes.
> >>> +    This control is a dynamically sized array. The number of entry=20
point
> >>> +    offsets is reported by the ``elems`` field.
> >>> +    This bitstream parameter is defined according to :ref:`hevc`.
> >>> +    They are described in section 7.4.7.1 "General slice segment hea=
der
> >>> +    semantics" of the specification.
> >>> +
> >>>  ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
> >>>      Specifies the HEVC scaling matrix parameters used for the scalin=
g=20
> >> process
> >>>      for transform coefficients.
> >>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/medi=
a/
v4l2-
> >> core/v4l2-ctrls-defs.c
> >>> index d594efbcbb93..e22921e7ea61 100644
> >>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> >>>  	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return=20
> >> "HEVC Decode Parameters";
> >>>  	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return=20
> >> "HEVC Decode Mode";
> >>>  	case V4L2_CID_STATELESS_HEVC_START_CODE:		return=20
> >> "HEVC Start Code";
> >>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return=20
> >> "HEVC Entry Point Offsets";
> >>> =20
> >>>  	/* Colorimetry controls */
> >>>  	/* Keep the order of the 'case's the same as in v4l2-controls.h!=20
> >> */
> >>> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name,=
=20
enum=20
> >> v4l2_ctrl_type *type,
> >>>  	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
> >>>  		*type =3D V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
> >>>  		break;
> >>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
> >>> +		*type =3D V4L2_CTRL_TYPE_U32;
> >>> +		*flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> >>> +		break;
> >>>  	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
> >>>  		*type =3D V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
> >>>  		break;
> >>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> >>> index a3c829ef531a..1319cb99ae3f 100644
> >>> --- a/include/media/hevc-ctrls.h
> >>> +++ b/include/media/hevc-ctrls.h
> >>> @@ -20,6 +20,7 @@
> >>>  #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE=20
> >> + 1012)
> >>>  #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE=20
+ 1015)
> >>>  #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 10=
16)
> >>> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_=
BASE=20
+=20
> >> 1017)
> >>> =20
> >>>  /* enum v4l2_ctrl_type type values */
> >>>  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> >>> @@ -318,6 +319,8 @@ struct v4l2_hevc_pred_weight_table {
> >>>   *
> >>>   * @bit_size: size (in bits) of the current slice data
> >>>   * @data_bit_offset: offset (in bits) to the video data in the curre=
nt=20
slice=20
> >> data
> >>> + * @num_entry_point_offsets: specifies the number of entry point off=
set=20
syntax
> >>> + *			     elements in the slice header.
> >>>   * @nal_unit_type: specifies the coding type of the slice (B, P or I)
> >>>   * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier f=
or=20
the=20
> >> NAL unit
> >>>   * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
> >>> @@ -360,7 +363,7 @@ struct v4l2_hevc_pred_weight_table {
> >>>  struct v4l2_ctrl_hevc_slice_params {
> >>>  	__u32	bit_size;
> >>>  	__u32	data_bit_offset;
> >>> -
> >>> +	__u32	num_entry_point_offsets;
> >>>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
> >>>  	__u8	nal_unit_type;
> >>>  	__u8	nuh_temporal_id_plus1;
> >>> --=20
> >>> 2.32.0
> >>>
> >>>
> >>
> >>
> >=20
>=20
>=20


