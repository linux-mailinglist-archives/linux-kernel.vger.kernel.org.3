Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CF6539623
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346975AbiEaSUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbiEaSUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:20:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B89CC92;
        Tue, 31 May 2022 11:20:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o29-20020a05600c511d00b00397697f172dso1552654wms.0;
        Tue, 31 May 2022 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5xAebr2NVeBjl9CHUGU02Xh2JLK4FCctFhmN5cMdt6I=;
        b=gk/ovidVQQdHp8HZE/8jFAZU/0TwEC/us2MtNRmAfCBRojJ9hBaHTgmmr1sFwZw7KW
         r56qq1OQnvV+8IzbhbdUKOULHqZtdIjcsI0Ce0ZX9AOUnphsp1LAAhu5A6PDEOzvXek1
         Zo5S+Oc6DEfvnuNcHmJQNJi9T0kTOk8uwIt0CyamHqYYasxEGrXS5WYwbpKah8B/aljQ
         9DN3X5DJ6zbMLwVFUgqDHza6cNZSKOqOL8v9h69xNw+BAI21olb5928JnMhPfAlT4N6F
         xJHmbT2kNm31NdGu/49Sy2WMGwQeCIdGjpcSamEaCWe1hp59iStfOHt8D4G4WVWCDGnd
         lb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xAebr2NVeBjl9CHUGU02Xh2JLK4FCctFhmN5cMdt6I=;
        b=CZCO6YNoxtd+TY2uLyQqfOQvA7bp7hSyglyurGi5fosW9o1XLbelFf04rKB4d2hBZZ
         1/P2ID+QxpWbCCLVxa2HJ/UzVEvl1kcdpw8uTD4ftz8brSxK592nt4SuFX5/JTfpT/Sh
         9GUNiATQPjJuFfjwpBVE1grl3LFy0UxHXcl/BxBZ5kfmxGgiw54FWy2tQ4Q4k4KAIjHs
         +x2N8w/qGA9SPAZK4Bnow5QG4osvx8TziIfX9klbx7/wKg1jjDk22uDQC+koH4f6265G
         M8DVxPXEiKkK8+ujbLhnJv3jGj4RAou9BCUKIr6zVONvQ8UtC7kN1XQV7m/RZcl7pSMi
         X98g==
X-Gm-Message-State: AOAM530nyAuqFOV0ivVmDWpbWB4NpU5jAiHX94gWCPCSytRx6yH8lcKT
        QlSbSM1MbKD/FUmjN9Ww2pI=
X-Google-Smtp-Source: ABdhPJyvbycKBrgfnKv4yFm4VwT5uI4NbXHu65pEWt5+zb8TyOf7VpEV4NxD1mfNB5Amncf9wK7U2w==
X-Received: by 2002:a7b:c109:0:b0:397:43ef:b66f with SMTP id w9-20020a7bc109000000b0039743efb66fmr24459854wmi.44.1654021239010;
        Tue, 31 May 2022 11:20:39 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c2cac00b0039749256d74sm3130267wmc.2.2022.05.31.11.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:20:38 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, nicolas.dufresne@collabora.com,
        andrzej.p@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: Re: [PATCH v6 11/17] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Date:   Tue, 31 May 2022 20:20:37 +0200
Message-ID: <2102878.irdbgypaU6@kista>
In-Reply-To: <b398272b-daf8-7499-b4fd-8a6f2af30053@collabora.com>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com> <5824953.lOV4Wx5bFT@kista> <b398272b-daf8-7499-b4fd-8a6f2af30053@collabora.com>
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

Dne torek, 31. maj 2022 ob 08:58:46 CEST je Benjamin Gaignard napisal(a):
>=20
> Le 30/05/2022 =C3=A0 23:24, Jernej =C5=A0krabec a =C3=A9crit :
> > Dne ponedeljek, 30. maj 2022 ob 15:49:57 CEST je Hans Verkuil napisal(a=
):
> >> On 30/05/2022 11:18, Hans Verkuil wrote:
> >>> On 29/05/2022 08:40, Jernej =C5=A0krabec wrote:
> >>>> Hi!
> >>>>
> >>>> This series looks very good and I plan to test it shortly on Cedrus,=
=20
but
> > I
> >>>> have one major concern below.
> >>>>
> >>>> Dne petek, 27. maj 2022 ob 16:31:28 CEST je Benjamin Gaignard=20
napisal(a):
> >>>>> The number of 'entry point offset' can be very variable.
> >>>>> Instead of using a large static array define a v4l2 dynamic array
> >>>>> of U32 (V4L2_CTRL_TYPE_U32).
> >>>>> The number of entry point offsets is reported by the elems field
> >>>>> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
> >>>>> field.
> >>>> Slice control by itself is variable length array, so you would actua=
lly
> > need
> >>>> 2D variable array for entry points which is not supported. However,=
=20
easy
> >>>> workaround for that is to flatten 2D array to 1D and either have ano=
ther
> > slice
> >>>> control field which would tell first entry point index for convenien=
ce or
> > let
> >>>> driver calculate it by adding up all num_entry_point_offsets of prev=
ious
> >>>> slices.
> >>>>
> >>>> Hans, what do you think?
> >>> If I would support 2D variable array sizes, wouldn't that be more=20
elegant?
> >>>
> >>> The current implementation doesn't support that, but as the commit lo=
g=20
for
> >>> patch 1/17 says:
> >>>
> >>> "Currently dynamically sized arrays are limited to one dimensional=20
arrays,
> >>> but that might change in the future if there is a need for it."
> >>>
> >>> Let me know if you agree, and I'll try to implement this. It's been a
> > while
> >>> since I last looked at this, so I'm not sure how much work it is, but=
 it
> > is
> >>> probably worth a shot.
> >> Digging more into this made me realize that this doesn't actually help=
=20
for
> > this
> >> particular case.
> >>
> >> I would lean towards your second suggestion of adding up all
> > num_entry_point_offsets
> >> of previous slices.
> > Just one question/clarification about dynamic arrays - does driver need=
 to
> > reserve maximum amount of memory for dynamic array control at=20
initialization
> > time? If so, this would still be problematic, since there cound be a hu=
ge
> > amount of entry points in theory.
>=20
> When adding the control the driver could set .dims field to specify
> the max number of accepted slices.
> I have added '#define V4L2_HEVC_SLICE_MAX_COUNT 600' that you could use
> for this field. It is the value we have found when using slices with RKVD=
EC
> driver.

Is this maximum value applicable only to RKVDEC or is universal? Anyway, th=
is=20
means maximum offset points control for Cedrus would be 600 * 1024 (max. of=
fset=20
points supported per slice) * 4 ~=3D 2.4 MB, which is a lot for one control=
, but=20
I can live with that...

Best regards,
Jernej

>=20
> Regards,
> Benjamin
>=20
> >
> > Best regards,
> > Jernej
> >
> >> Regards,
> >>
> >> 	Hans
> >>
> >>> Regards,
> >>>
> >>> 	Hans
> >>>
> >>>> Note, it seems that H265 decoding on Cedrus still works without entry
> > points,
> >>>> so this problem can be solved later. I'm not sure what we lose with=
=20
that
> > but
> >>>> it was suggested that this could influence speed or error resilience=
 or
> > both.
> >>>> However, I think we're close to solve it, so I'd like to do that now.
> >>>>
> >>>> Best regards,
> >>>> Jernej
> >>>>
> >>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >>>>> ---
> >>>>>   .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11 ++++++=
+++
++
> >>>>>   drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
> >>>>>   include/media/hevc-ctrls.h                            |  5 ++++-
> >>>>>   3 files changed, 20 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.=
rst=20
b/
> >>>> Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >>>>> index 0796b1563daa..05228e280f66 100644
> >>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >>>>> @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_fiel=
d -
> >>>>>       * - __u32
> >>>>>         - ``data_bit_offset``
> >>>>>         - Offset (in bits) to the video data in the current slice d=
ata.
> >>>>> +    * - __u32
> >>>>> +      - ``num_entry_point_offsets``
> >>>>> +      - Specifies the number of entry point offset syntax elements=
 in=20
the
> >>>> slice header.
> >>>>>       * - __u8
> >>>>>         - ``nal_unit_type``
> >>>>>         - Specifies the coding type of the slice (B, P or I).
> >>>>> @@ -3150,6 +3153,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_fie=
ld -
> >>>>>  =20
> >>>>>       \normalsize
> >>>>>  =20
> >>>>> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
> >>>>> +    Specifies entry point offsets in bytes.
> >>>>> +    This control is a dynamically sized array. The number of entry
> > point
> >>>>> +    offsets is reported by the ``elems`` field.
> >>>>> +    This bitstream parameter is defined according to :ref:`hevc`.
> >>>>> +    They are described in section 7.4.7.1 "General slice segment=20
header
> >>>>> +    semantics" of the specification.
> >>>>> +
> >>>>>   ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
> >>>>>       Specifies the HEVC scaling matrix parameters used for the sca=
ling
> >>>> process
> >>>>>       for transform coefficients.
> >>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/me=
dia/
> > v4l2-
> >>>> core/v4l2-ctrls-defs.c
> >>>>> index d594efbcbb93..e22921e7ea61 100644
> >>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>>> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> >>>>>   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return
> >>>> "HEVC Decode Parameters";
> >>>>>   	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return
> >>>> "HEVC Decode Mode";
> >>>>>   	case V4L2_CID_STATELESS_HEVC_START_CODE:		return
> >>>> "HEVC Start Code";
> >>>>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return
> >>>> "HEVC Entry Point Offsets";
> >>>>>  =20
> >>>>>   	/* Colorimetry controls */
> >>>>>   	/* Keep the order of the 'case's the same as in v4l2-controls.h!
> >>>> */
> >>>>> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **nam=
e,
> > enum
> >>>> v4l2_ctrl_type *type,
> >>>>>   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
> >>>>>   		*type =3D V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
> >>>>>   		break;
> >>>>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
> >>>>> +		*type =3D V4L2_CTRL_TYPE_U32;
> >>>>> +		*flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> >>>>> +		break;
> >>>>>   	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
> >>>>>   		*type =3D V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
> >>>>>   		break;
> >>>>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> >>>>> index a3c829ef531a..1319cb99ae3f 100644
> >>>>> --- a/include/media/hevc-ctrls.h
> >>>>> +++ b/include/media/hevc-ctrls.h
> >>>>> @@ -20,6 +20,7 @@
> >>>>>   #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS=09
(V4L2_CID_CODEC_BASE
> >>>> + 1012)
> >>>>>   #define V4L2_CID_STATELESS_HEVC_DECODE_MODE=09
(V4L2_CID_CODEC_BASE
> > + 1015)
> >>>>>   #define V4L2_CID_STATELESS_HEVC_START_CODE=09
(V4L2_CID_CODEC_BASE + 1016)
> >>>>> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS=20
(V4L2_CID_CODEC_BASE
> > +
> >>>> 1017)
> >>>>>  =20
> >>>>>   /* enum v4l2_ctrl_type type values */
> >>>>>   #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> >>>>> @@ -318,6 +319,8 @@ struct v4l2_hevc_pred_weight_table {
> >>>>>    *
> >>>>>    * @bit_size: size (in bits) of the current slice data
> >>>>>    * @data_bit_offset: offset (in bits) to the video data in the cu=
rrent
> > slice
> >>>> data
> >>>>> + * @num_entry_point_offsets: specifies the number of entry point o=
ffset
> > syntax
> >>>>> + *			     elements in the slice header.
> >>>>>    * @nal_unit_type: specifies the coding type of the slice (B, P o=
r I)
> >>>>>    * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifie=
r for
> > the
> >>>> NAL unit
> >>>>>    * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
> >>>>> @@ -360,7 +363,7 @@ struct v4l2_hevc_pred_weight_table {
> >>>>>   struct v4l2_ctrl_hevc_slice_params {
> >>>>>   	__u32	bit_size;
> >>>>>   	__u32	data_bit_offset;
> >>>>> -
> >>>>> +	__u32	num_entry_point_offsets;
> >>>>>   	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
> >>>>>   	__u8	nal_unit_type;
> >>>>>   	__u8	nuh_temporal_id_plus1;
> >>>>> --=20
> >>>>> 2.32.0
> >>>>>
> >>>>>
> >>>>
> >>
> >
>=20


