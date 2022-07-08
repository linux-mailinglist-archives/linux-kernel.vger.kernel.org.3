Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8F56BFC6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiGHQLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbiGHQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:11:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36E76958;
        Fri,  8 Jul 2022 09:11:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id n8so27472658eda.0;
        Fri, 08 Jul 2022 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CZGOyWzX4aGGV8YDTIG3/SXgM/jJGVj0i4XRm3yHlMw=;
        b=ctafkzvWgcOV2OzM2mLtdqBu7r8vX9aewGOA/8GwOzCIFL+mMxcHzGdOsaCvK7zKYn
         UaZN9TECi4qWzJsTOw6mgVk/xaEWk0Yp77cEBxfZM8h7+uEUg93qoRI3nPOC9U1JTWLl
         c2ZQHV/03lLI48bGOUni0PcbJUCaRPL9Sh9Y8N8MMZ3sD4oXVZdWliAwYaqN5qZgkUDw
         0jGrd7AaU3jiQ8cxzy1Oo/c2VRl/+FLvuS1enJvYV40/o8OKz3v1mD9d++CGqV+sUIpV
         sSeCHEd6pS8ZBvTkFwA2dNhOAnF5tQ/x18hOH1wF6aGbt4jWev0/c2xc+hWwzYEJ1rzZ
         V3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZGOyWzX4aGGV8YDTIG3/SXgM/jJGVj0i4XRm3yHlMw=;
        b=ZJzIqGDtH6dPDO9p6xrA95gx6nliAR081R7zp7riSrRInQspnsqKY2zbch9xyDoFGl
         +X9KfOHBd6k15/1Nc5dTUymFihMCAjPnKqrBqoalaxG3m2U+YTyDdpfpGfWvKpZCd2hb
         nyZMs7Tqc5VSzoSkE992nKxdJETcpkr56NpFjHgjFr3pNC7+VqI8SSdU5vO7bbIwt1Uz
         q26K+9RWNKRjivdt5tasfv9/EULzrPKNAzZyCoP/HZKvOFKXCRBxxN513dILrRTx0/uT
         HahcczeJU/PsTMXm5UjIHh/Vw+zaiKoRrLrZUDfJRmtfahFTXu8D5AVuWBBsjZ6NchmJ
         i7jQ==
X-Gm-Message-State: AJIora/eliqItrdGG0ww56OAtibHvHLlv/YrmIwj0VTxhEGYJfOG0upS
        bYEp0cYslq3/0MBzelFpiwQ=
X-Google-Smtp-Source: AGRyM1ur758Eyy5WK7DxbjtchEZ7mQrm9eCpKtxjRiabkDClljIhvXmYP8vDdeEYt0k+Bk+V/SzuuQ==
X-Received: by 2002:a05:6402:5c8:b0:433:545f:a811 with SMTP id n8-20020a05640205c800b00433545fa811mr5869270edx.101.1657296703871;
        Fri, 08 Jul 2022 09:11:43 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id bu23-20020a170906a15700b006fec56c57f3sm20658400ejb.178.2022.07.08.09.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:11:43 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: Re: [PATCH v12 11/17] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Date:   Fri, 08 Jul 2022 18:11:42 +0200
Message-ID: <4604967.rnE6jSC6OK@kista>
In-Reply-To: <5e346689-5a0c-8fc7-129d-53a6f28e5349@collabora.com>
References: <20220708120554.495495-1-benjamin.gaignard@collabora.com> <2106581.irdbgypaU6@jernej-laptop> <5e346689-5a0c-8fc7-129d-53a6f28e5349@collabora.com>
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

Dne petek, 08. julij 2022 ob 18:00:24 CEST je Benjamin Gaignard napisal(a):
> Le 08/07/2022 =C3=A0 16:02, Jernej =C5=A0krabec a =C3=A9crit :
> > Hi Benjamin!
> >=20
> > Dne petek, 08. julij 2022 ob 14:05:48 CEST je Benjamin Gaignard=20
napisal(a):
> >> The number of 'entry point offset' can be very variable.
> >> Instead of using a large static array define a v4l2 dynamic array
> >> of U32 (V4L2_CTRL_TYPE_U32).
> >> The number of entry point offsets is reported by the elems field
> >> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
> >> field.
> >>=20
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> >> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >> ---
> >> version 12:
> >> - Reword num_entry_point_offsets documentation
> >>=20
> >>   .../userspace-api/media/v4l/ext-ctrls-codec.rst     | 13 +++++++++++=
++
> >>   drivers/media/v4l2-core/v4l2-ctrls-defs.c           |  5 +++++
> >>   include/media/hevc-ctrls.h                          |  5 ++++-
> >>   3 files changed, 22 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst index
> >> c2e0adece613..0cd967126fdf 100644
> >> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >> @@ -3010,6 +3010,11 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> >>=20
> >>       * - __u32
> >>      =20
> >>         - ``data_bit_offset``
> >>         - Offset (in bits) to the video data in the current slice data.
> >>=20
> >> +    * - __u32
> >> +      - ``num_entry_point_offsets``
> >> +      - Specifies the number of entry point offset syntax elements in
> >> the
> >> slice header. +        When the driver supports it, the
> >> ``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS`` +        must be set.
> >>=20
> >>       * - __u8
> >>      =20
> >>         - ``nal_unit_type``
> >>         - Specifies the coding type of the slice (B, P or I).
> >>=20
> >> @@ -3150,6 +3155,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> >>=20
> >>       \normalsize
> >>=20
> >> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
> >> +    Specifies entry point offsets in bytes.
> >> +    This control is a dynamically sized array. The number of entry po=
int
> >> +    offsets is reported by the ``elems`` field.
> >> +    This bitstream parameter is defined according to :ref:`hevc`.
> >> +    They are described in section 7.4.7.1 "General slice segment head=
er
> >> +    semantics" of the specification.
> >=20
> > You forgot to update above description per Ezequiel comment.
>=20
> No it was num_entry_point_offsets which was needed to be updated
> not this control.

Both needs to be updated. Ezequiel said:

"I would add Jernej's clarification about the length of the control
here, where the control is documented."

""
This control is a dynamically sized array. The number of entry point
offsets is reported by the ``elems`` field.
This bitstream parameter is defined according to :ref:`hevc`.
They are described in section 7.4.7.1 "General slice segment header
semantics" of the specification.
When multiple slices are submitted in a request, the length
of this array must be the sum of num_entry_point_offsets
of all the slices in the request.
""

Best regards,
Jernej

>=20
> Regards,
> Benjamin
>=20
> > Best regards,
> > Jernej
> >=20
> >> +
> >>=20
> >>   ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
> >>  =20
> >>       Specifies the HEVC scaling matrix parameters used for the scaling
> >>=20
> >> process for transform coefficients.
> >> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c index
> >> d594efbcbb93..e22921e7ea61 100644
> >> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> >>=20
> >>   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return
> >=20
> > "HEVC Decode
> >=20
> >> Parameters"; case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return
> >=20
> > "HEVC Decode
> >=20
> >> Mode"; case V4L2_CID_STATELESS_HEVC_START_CODE:		return
> >=20
> > "HEVC Start Code";
> >=20
> >> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return
> >=20
> > "HEVC Entry
> >=20
> >> Point Offsets";
> >>=20
> >>   	/* Colorimetry controls */
> >>   	/* Keep the order of the 'case's the same as in v4l2-controls.h!
> >=20
> > */
> >=20
> >> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name,
> >> enum
> >>=20
> >> v4l2_ctrl_type *type, case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
> >>   		*type =3D V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
> >>   		break;
> >>=20
> >> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
> >> +		*type =3D V4L2_CTRL_TYPE_U32;
> >> +		*flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> >> +		break;
> >>=20
> >>   	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
> >>   		*type =3D V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
> >>   		break;
> >>=20
> >> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> >> index a372c184689e..3a6601a46ced 100644
> >> --- a/include/media/hevc-ctrls.h
> >> +++ b/include/media/hevc-ctrls.h
> >> @@ -20,6 +20,7 @@
> >>=20
> >>   #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS=09
(V4L2_CID_CODEC_BASE
> >=20
> > + 1012)
> >=20
> >>   #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE=20
+
> >>   1015)
> >>   #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 10=
16)
> >>=20
> >> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_B=
ASE
> >> +
> >> 1017)
> >>=20
> >>   /* enum v4l2_ctrl_type type values */
> >>   #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> >>=20
> >> @@ -316,6 +317,8 @@ struct v4l2_hevc_pred_weight_table {
> >>=20
> >>    *
> >>    * @bit_size: size (in bits) of the current slice data
> >>    * @data_bit_offset: offset (in bits) to the video data in the curre=
nt
> >>=20
> >> slice data + * @num_entry_point_offsets: specifies the number of entry
> >> point offset syntax + *			     elements in the slice
> >=20
> > header.
> >=20
> >>    * @nal_unit_type: specifies the coding type of the slice (B, P or I)
> >>    * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier f=
or
> >>    the
> >>=20
> >> NAL unit * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
> >> @@ -358,7 +361,7 @@ struct v4l2_hevc_pred_weight_table {
> >>=20
> >>   struct v4l2_ctrl_hevc_slice_params {
> >>  =20
> >>   	__u32	bit_size;
> >>   	__u32	data_bit_offset;
> >>=20
> >> -
> >> +	__u32	num_entry_point_offsets;
> >>=20
> >>   	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
> >>   	__u8	nal_unit_type;
> >>   	__u8	nuh_temporal_id_plus1;


