Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345C95673E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiGEQLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGEQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:11:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3E8140CF;
        Tue,  5 Jul 2022 09:11:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r6so4490868edd.7;
        Tue, 05 Jul 2022 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36G4J+5wwUVJqJb4TMjdk+1pXu3QLUF2IGGsdXoPz5Y=;
        b=jFB3fKMVUSBi3Nj3BC8f/AsBM2Q8ZFPoAuR+kt1v5Msyzqbznxry+DDRk8+h8ysY2W
         ZQuRbYn7jqcLBYxKRJPhNGdG6numN6uXJQzieATwObgNChgnmu1wUs0Senkm3aqYFbTf
         6mhVO2bgqj/VY4Ol+d3g5NTh2AOdHdAb1Gzc9FHQ2N43ifIe7h9kFZJ4aZB7iUrb5hmd
         vFkFgOvhFDuJONsMQHZAqC1h4hDUSHg8z0/DNA/IVEbPgfF34NwG2WZya+1TLr5LAbQx
         bGQbZazHpE3CgdSy68dUcP9ragLYWSvZcfezgraEkRlwE/VS34YH+Fkn30gRmAvHdEZ5
         UCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36G4J+5wwUVJqJb4TMjdk+1pXu3QLUF2IGGsdXoPz5Y=;
        b=CYPG00HTQrz1klFXhCuTOvpoUwmXZdGQvwjIWD+PLE3jhXktWJOMMRLjclCKJTyjNh
         uvExfsXRJHoySboROI2GIEbA03RVDjeaT2bduRgX1Te8y0jABb4Loo3YPppnPpJLX/Fi
         khOJ1re7o+u8ZVfvY891VMuk9F8r1chLXIKEG8MmBVLGXUAaVwj73OeM8CwKe3KxbsfC
         /EJVvxSVr36opap+s318/zE++oQ2xCAR/mgtk8q34xosop9NMoKIyTlBlqfeCEFVh1Ig
         GpL19p/Khttlpj1yE/zHv06b+0ZEfT9BM1766pQqLcPadLCh7Bqxa7DHaBF6goLXGyc1
         lbpA==
X-Gm-Message-State: AJIora+Ymy9YjKD0xSgYuMjcCRiTZJZH5PFC/dRc/tOHM7jU2/BfQJvj
        CuskA79gcwZn4tcf4l8kSWU=
X-Google-Smtp-Source: AGRyM1sTbO8bbpUNNRESUXpCdjFmwrTJ5Z6Zb/ampipDhlK1iLjC6b7jH+hT350cAwrnvADHcvid+A==
X-Received: by 2002:a05:6402:3807:b0:435:20fb:318d with SMTP id es7-20020a056402380700b0043520fb318dmr46972596edb.272.1657037471184;
        Tue, 05 Jul 2022 09:11:11 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id d8-20020a056402000800b0043a71c376a2sm3108941edu.33.2022.07.05.09.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:11:10 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: Re: [PATCH v10 11/17] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Date:   Tue, 05 Jul 2022 18:11:09 +0200
Message-ID: <4408380.LvFx2qVVIh@kista>
In-Reply-To: <6ae43dcd-9b1d-ce30-8c3e-a8c313ef5b0a@collabora.com>
References: <20220705085420.272912-1-benjamin.gaignard@collabora.com> <YsRclobW7gL/Dtlr@eze-laptop> <6ae43dcd-9b1d-ce30-8c3e-a8c313ef5b0a@collabora.com>
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

Dne torek, 05. julij 2022 ob 18:03:28 CEST je Benjamin Gaignard napisal(a):
> Le 05/07/2022 =E0 17:45, Ezequiel Garcia a =E9crit :
> > Hi guys,
> >=20
> > On Tue, Jul 05, 2022 at 10:54:14AM +0200, Benjamin Gaignard wrote:
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
> >>=20
> >>   .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11 +++++++++=
++
> >>   drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
> >>   include/media/hevc-ctrls.h                            |  5 ++++-
> >>   3 files changed, 20 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst index
> >> db0df7d9f27c..8df8d7fdfe70 100644
> >> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >> @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> >>=20
> >>       * - __u32
> >>      =20
> >>         - ``data_bit_offset``
> >>         - Offset (in bits) to the video data in the current slice data.
> >>=20
> >> +    * - __u32
> >> +      - ``num_entry_point_offsets``
> >> +      - Specifies the number of entry point offset syntax elements in
> >> the slice header.>=20
> > This looks underdocumented. Somewhere in the docs it should be mentioned
> > that the field 'num_entry_point_offsets' is linked to the control
> > V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS.
>=20
> This field is here because some drivers would like know the number of
> entry point offsets without getting the entry point offsets data itself.

Yeah, this field must be set even when entry points offset control isn't us=
ed.=20
Additionally, if entry point offsets control is needed and if submitting=20
multiple slices at once, length of entry point offsets array must be sum of=
=20
num_entry_point_offsets of all slices in that job. Not sure where to put th=
is=20
explanation.

Best regards,
Jernej

>=20
> Benjamin
>=20
> > Thanks,
> > Ezequiel
> >=20
> >>       * - __u8
> >>      =20
> >>         - ``nal_unit_type``
> >>         - Specifies the coding type of the slice (B, P or I).
> >>=20
> >> @@ -3150,6 +3153,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
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
> >> +
> >>=20
> >>   ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
> >>  =20
> >>       Specifies the HEVC scaling matrix parameters used for the scaling
> >>       process
> >>       for transform coefficients.
> >>=20
> >> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c index
> >> d594efbcbb93..e22921e7ea61 100644
> >> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> >>=20
> >>   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return=20
"HEVC Decode
> >>   	Parameters"; case V4L2_CID_STATELESS_HEVC_DECODE_MODE:	=09
return "HEVC
> >>   	Decode Mode"; case V4L2_CID_STATELESS_HEVC_START_CODE:	=09
return "HEVC
> >>   	Start Code";>>=20
> >> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return=20
"HEVC Entry
> >> Point Offsets";>>=20
> >>   	/* Colorimetry controls */
> >>   	/* Keep the order of the 'case's the same as in v4l2-controls.h!=20
*/
> >>=20
> >> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name,
> >> enum v4l2_ctrl_type *type,>>=20
> >>   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
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
(V4L2_CID_CODEC_BASE +
> >>   1012)
> >>   #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE=20
+
> >>   1015)
> >>   #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 10=
16)
> >>=20
> >> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_B=
ASE
> >> + 1017)>>=20
> >>   /* enum v4l2_ctrl_type type values */
> >>   #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> >>=20
> >> @@ -316,6 +317,8 @@ struct v4l2_hevc_pred_weight_table {
> >>=20
> >>    *
> >>    * @bit_size: size (in bits) of the current slice data
> >>    * @data_bit_offset: offset (in bits) to the video data in the curre=
nt
> >>    slice data>>=20
> >> + * @num_entry_point_offsets: specifies the number of entry point offs=
et
> >> syntax + *			     elements in the slice=20
header.
> >>=20
> >>    * @nal_unit_type: specifies the coding type of the slice (B, P or I)
> >>    * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier f=
or
> >>    the NAL unit * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
> >>=20
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
> >>=20
> >> --
> >> 2.32.0


