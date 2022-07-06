Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14E7569225
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiGFStk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiGFSti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:49:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396961F2DE;
        Wed,  6 Jul 2022 11:49:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b26so23313400wrc.2;
        Wed, 06 Jul 2022 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ko/7vC9uowvuhOuaHcW9SY3o/jbXX33rNYIe8reYijA=;
        b=QLJylXo2eaBfDec1E1bIZZKyHJ2Ip5yd5MiTpPTCsWMP3gnUBm/WIUhKFc+DLKY2xY
         jX5sbJ4vqW1/WKy5myg14xYhnjLfKXFL9tRizC137hXm1sIoZhtM6csu/b8LdJ9CsaFM
         ZA72EpVHaWiqK49RF88f1AtPl/kn1888m0/wzD3RhQlp4GbqDy7Ql9umdC05ShqnrgV+
         WxBf3SH1ZJkh4KSPiMbuY1Ll+j8HI1ZKUBRaxbcmXUmZd7w4KTMbRbv0GbJT41UsSQvI
         Uw8KfcqGzNemOI842jvMib1Ul1BlQBcjS9lNGAthAxvcA3PNG2qKQOGwAHD/FVEa/LtW
         JbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ko/7vC9uowvuhOuaHcW9SY3o/jbXX33rNYIe8reYijA=;
        b=n4+2xmxrAkC82HHhCZgUMMWzcMoJQ838486eENyKUcEYTmHiwwJvW0411ha461sao2
         G9MUnFJXqvVroz/1lVNGkpyyYc4H4SwetLDriShq3z1cn/9dSS8y9WYUjIo+MNF1tdUr
         fMKomTJXnc8QqK9o15VTvBp3RQsXmD9TP/RddBvLREh3P1ZQ18vwRjgx2F49ps71t+XU
         4H5rFfF23BfzHTai7cNgDphUfTThE4/xfOBdG5mWWtfdo39d+gScqgzWWcL3lgjYC8Fw
         MjjrqBYXokK+6y4yj5TIJswoCx+OFZeCxHKoJssDf+MzJrUGh1k7yfMSkkKTinYd+pk7
         58FQ==
X-Gm-Message-State: AJIora/WtI35UjuUI6+x+5+z9oiY1mb46xLk+U0HbntkXAgDKKEU8Ezq
        eB6YeDIkTKPLrrU83T8bdcPdePkb8+XD6Q==
X-Google-Smtp-Source: AGRyM1sYaoB/gPUJLbwXa1xJPEIH03jj58v64kXD0M1vI4pS1KVWTePPmY1i0+YU9sbkMOpmkfe1Bg==
X-Received: by 2002:a5d:4aca:0:b0:21d:6793:1c11 with SMTP id y10-20020a5d4aca000000b0021d67931c11mr18375854wrs.202.1657133375703;
        Wed, 06 Jul 2022 11:49:35 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id e10-20020a05600c4e4a00b00397402ae674sm18080800wmq.11.2022.07.06.11.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:49:34 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: Re: Re: [PATCH v10 11/17] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Date:   Wed, 06 Jul 2022 20:49:33 +0200
Message-ID: <1769918.8hzESeGDPO@kista>
In-Reply-To: <CAAEAJfDNHSBtJD_chSV0_UMTJWztyPFxjORRn0+dSrtcZCoYwg@mail.gmail.com>
References: <20220705085420.272912-1-benjamin.gaignard@collabora.com> <4408380.LvFx2qVVIh@kista> <CAAEAJfDNHSBtJD_chSV0_UMTJWztyPFxjORRn0+dSrtcZCoYwg@mail.gmail.com>
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

Dne sreda, 06. julij 2022 ob 20:39:41 CEST je Ezequiel Garcia napisal(a):
> Hi Jernej,
>=20
> On Tue, Jul 5, 2022 at 1:11 PM Jernej =C5=A0krabec <jernej.skrabec@gmail.=
com>=20
wrote:
> > Dne torek, 05. julij 2022 ob 18:03:28 CEST je Benjamin Gaignard=20
napisal(a):
> > > Le 05/07/2022 =C3=A0 17:45, Ezequiel Garcia a =C3=A9crit :
> > > > Hi guys,
> > > >=20
> > > > On Tue, Jul 05, 2022 at 10:54:14AM +0200, Benjamin Gaignard wrote:
> > > >> The number of 'entry point offset' can be very variable.
> > > >> Instead of using a large static array define a v4l2 dynamic array
> > > >> of U32 (V4L2_CTRL_TYPE_U32).
> > > >> The number of entry point offsets is reported by the elems field
> > > >> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
> > > >> field.
> > > >>=20
> > > >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > >> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > > >> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > >> ---
> > > >>=20
> > > >>   .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11
> > > >>   +++++++++++
> > > >>   drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
> > > >>   include/media/hevc-ctrls.h                            |  5 ++++-
> > > >>   3 files changed, 20 insertions(+), 1 deletion(-)
> > > >>=20
> > > >> diff --git
> > > >> a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > >> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst index
> > > >> db0df7d9f27c..8df8d7fdfe70 100644
> > > >> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > >> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > >> @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_fie=
ld
> > > >> -
> > > >>=20
> > > >>       * - __u32
> > > >>      =20
> > > >>         - ``data_bit_offset``
> > > >>         - Offset (in bits) to the video data in the current slice
> > > >>         data.
> > > >>=20
> > > >> +    * - __u32
> > > >> +      - ``num_entry_point_offsets``
> > > >> +      - Specifies the number of entry point offset syntax elements
> > > >> in
> > > >> the slice header.>
> > > >=20
> > > > This looks underdocumented. Somewhere in the docs it should be
> > > > mentioned
> > > > that the field 'num_entry_point_offsets' is linked to the control
> > > > V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS.
> > >=20
> > > This field is here because some drivers would like know the number of
> > > entry point offsets without getting the entry point offsets data itse=
lf.
> >=20
> > Yeah, this field must be set even when entry points offset control isn't
> > used. Additionally, if entry point offsets control is needed and if
> > submitting multiple slices at once, length of entry point offsets array
> > must be sum of num_entry_point_offsets of all slices in that job. Not
> > sure where to put this explanation.
>=20
> This confused me a bit: so you mean that this field (called
> num_entry_point_offsets)
> must be the sum of "num_entry_point_offsets" syntax elements for
> slices in the request?

No, it's the other way around. num_entry_point_offsets field has same meani=
ng as=20
in syntax. It's per slice property. I said that if there is control with al=
l=20
entry point offsets, it has to have number of elements, which is sum of all=
=20
num_entry_point_offsets fields in slice array.

Example (totaly made up):

=46rame has 4 slices, each with 16 entry points.
App sends only 2 slices per job. Both num_entry_point_offsets fields in sli=
ce=20
control will have value 16, but entry point offsets array control will have=
 32=20
elements (16 entry points offsets from first and 16 entry point offsets fro=
m=20
second slice).

Best regards,
Jernej

>=20
> If this is the case, then perhaps it will be a mistake to name our V4L2
> field exactly like the syntax element, since it this sum meaning.
> Otherwise, developers would tend to get confused by it.
>=20
> What do you think?
>=20
> Thanks,
> Ezequiel
>=20
> > Best regards,
> > Jernej
> >=20
> > > Benjamin
> > >=20
> > > > Thanks,
> > > > Ezequiel
> > > >=20
> > > >>       * - __u8
> > > >>      =20
> > > >>         - ``nal_unit_type``
> > > >>         - Specifies the coding type of the slice (B, P or I).
> > > >>=20
> > > >> @@ -3150,6 +3153,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_fi=
eld
> > > >> -
> > > >>=20
> > > >>       \normalsize
> > > >>=20
> > > >> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
> > > >> +    Specifies entry point offsets in bytes.
> > > >> +    This control is a dynamically sized array. The number of entry
> > > >> point
> > > >> +    offsets is reported by the ``elems`` field.
> > > >> +    This bitstream parameter is defined according to :ref:`hevc`.
> > > >> +    They are described in section 7.4.7.1 "General slice segment
> > > >> header
> > > >> +    semantics" of the specification.
> > > >> +
> > > >>=20
> > > >>   ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
> > > >>  =20
> > > >>       Specifies the HEVC scaling matrix parameters used for the
> > > >>       scaling
> > > >>       process
> > > >>       for transform coefficients.
> > > >>=20
> > > >> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > >> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c index
> > > >> d594efbcbb93..e22921e7ea61 100644
> > > >> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > >> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > >> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> > > >>=20
> > > >>    case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:             return
> >=20
> > "HEVC Decode
> >=20
> > > >>    Parameters"; case V4L2_CID_STATELESS_HEVC_DECODE_MODE:
> > return "HEVC
> >=20
> > > >>    Decode Mode"; case V4L2_CID_STATELESS_HEVC_START_CODE:
> > return "HEVC
> >=20
> > > >>    Start Code";>>
> > > >>=20
> > > >> +  case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:       return
> >=20
> > "HEVC Entry
> >=20
> > > >> Point Offsets";>>
> > > >>=20
> > > >>    /* Colorimetry controls */
> > > >>    /* Keep the order of the 'case's the same as in v4l2-controls.h!
> >=20
> > */
> >=20
> > > >> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **na=
me,
> > > >> enum v4l2_ctrl_type *type,>>
> > > >>=20
> > > >>    case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
> > > >>            *type =3D V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
> > > >>            break;
> > > >>=20
> > > >> +  case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
> > > >> +          *type =3D V4L2_CTRL_TYPE_U32;
> > > >> +          *flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> > > >> +          break;
> > > >>=20
> > > >>    case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
> > > >>            *type =3D V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
> > > >>            break;
> > > >>=20
> > > >> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls=
=2Eh
> > > >> index a372c184689e..3a6601a46ced 100644
> > > >> --- a/include/media/hevc-ctrls.h
> > > >> +++ b/include/media/hevc-ctrls.h
> > > >> @@ -20,6 +20,7 @@
> > > >>=20
> > > >>   #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS
> >=20
> > (V4L2_CID_CODEC_BASE +
> >=20
> > > >>   1012)
> > > >>   #define V4L2_CID_STATELESS_HEVC_DECODE_MODE    =20
> > > >>   (V4L2_CID_CODEC_BASE
> >=20
> > +
> >=20
> > > >>   1015)
> > > >>   #define V4L2_CID_STATELESS_HEVC_START_CODE     =20
> > > >>   (V4L2_CID_CODEC_BASE + 1016)> > >>=20
> > > >> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
> > > >> (V4L2_CID_CODEC_BASE
> > > >> + 1017)>>
> > > >>=20
> > > >>   /* enum v4l2_ctrl_type type values */
> > > >>   #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> > > >>=20
> > > >> @@ -316,6 +317,8 @@ struct v4l2_hevc_pred_weight_table {
> > > >>=20
> > > >>    *
> > > >>    * @bit_size: size (in bits) of the current slice data
> > > >>    * @data_bit_offset: offset (in bits) to the video data in the
> > > >>    current
> > > >>    slice data>>
> > > >>=20
> > > >> + * @num_entry_point_offsets: specifies the number of entry point
> > > >> offset
> > > >> syntax + *                      elements in the slice
> >=20
> > header.
> >=20
> > > >>    * @nal_unit_type: specifies the coding type of the slice (B, P =
or
> > > >>    I)
> > > >>    * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifi=
er
> > > >>    for
> > > >>    the NAL unit * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
> > > >>=20
> > > >> @@ -358,7 +361,7 @@ struct v4l2_hevc_pred_weight_table {
> > > >>=20
> > > >>   struct v4l2_ctrl_hevc_slice_params {
> > > >>  =20
> > > >>    __u32   bit_size;
> > > >>    __u32   data_bit_offset;
> > > >>=20
> > > >> -
> > > >> +  __u32   num_entry_point_offsets;
> > > >>=20
> > > >>    /* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
> > > >>    __u8    nal_unit_type;
> > > >>    __u8    nuh_temporal_id_plus1;
> > > >>=20
> > > >> --
> > > >> 2.32.0


