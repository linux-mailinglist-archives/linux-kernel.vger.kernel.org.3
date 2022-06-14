Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7E554B7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243315AbiFNRuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349624AbiFNRum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:50:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D9234B93
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:50:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w17so4760176wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynesim-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=x63h/c1BGVusV25ZT0fkdjHSGcrp+du01iw2pt40ZiY=;
        b=wC2k+b0KHPpw9d+uXu4XTg8ogHhDCwtZpfR40+2PQfGRRBsqMojV22iXjFCOch/cT3
         xw/T7iXOTdS/PrAX/Zsaj1o3TbbFQqxJZQIUxj+7Y31I/IEuvUv7OqSAbbAI1shq6DWa
         HBNOJiHl9ztLGL5Vs2c16KPnqGPiC0m11MRD4Bv/iQNjIbVIVghhimmepwZCO2ovAZsf
         r5Yc3DVnG5DW2LGbQaQmzYZuzu+Kupw+QtfhjZ/sXjSUvHMP4Sljtsdz2FrdxVGljNFC
         IA1ZajZI5Hn63JfA6oIxVJDAcflZt36ayzw9IBG01Fo9D4AckSwYz/ZGgXkT5C6r7pOF
         8IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=x63h/c1BGVusV25ZT0fkdjHSGcrp+du01iw2pt40ZiY=;
        b=wEaL4a/e1ifgnLStxr9pP+9B+I5FIFiOX+dITCif011rmTBZbqhvxLeXJ/oXBBoib3
         2iZIhMjf+QeHHsDxHPLdxd3XT5J9X8WmZLParR05qOuQZUTnD+KcLZ7zl1o44OZuYFKT
         TOe16+WnTRIWJ9VNCAGNkscd8cNy4BF6L21LfdOrShhx4OOih8oalR1QMTh+CIHYzjO8
         6IU6Ogp+A29EbsoAS1RF7WkDoryxiMcDLrzqCJ5M7BlIctc8bcsopicDqy0Lm191Fyqh
         pPmOJWsDSG4ewCvbEZHmfyzB9UiSXF2NkZKAGTQIIAjKT9yNg0r0Z9WdawHqiPBKfWCv
         c25Q==
X-Gm-Message-State: AJIora+pzbcNM6/wugxnnVaAnkyhQj+dAuAlyJxTb9w+OmgDVIw0EMe0
        wd6Js7j4nutEjGHLxfo5GgJkUA==
X-Google-Smtp-Source: AGRyM1vtyiXwWVIL9MMf4TgYpUoAn9bBTXR+rnlA9ZEo4F4daQXCmIIAXO7sujqKVZGPndgDzp1Efg==
X-Received: by 2002:adf:978c:0:b0:219:e4e7:7057 with SMTP id s12-20020adf978c000000b00219e4e77057mr5959106wrb.568.1655229038553;
        Tue, 14 Jun 2022 10:50:38 -0700 (PDT)
Received: from CTHALPA.outer.uphall.net (cpc1-cmbg20-2-0-cust759.5-4.cable.virginm.net. [86.21.218.248])
        by smtp.gmail.com with ESMTPSA id bh8-20020a05600c3d0800b003942a244ee6sm13732418wmb.43.2022.06.14.10.50.37
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 14 Jun 2022 10:50:37 -0700 (PDT)
From:   John Cox <jc@kynesim.co.uk>
To:     =?utf-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, nicolas.dufresne@collabora.com,
        andrzej.p@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v8 09/17] media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a dynamic array
Date:   Tue, 14 Jun 2022 18:50:36 +0100
Message-ID: <cgihahl6gu9089b1ph9tj4vobftaoatbjt@4ax.com>
References: <20220614083614.240641-1-benjamin.gaignard@collabora.com> <20220614083614.240641-10-benjamin.gaignard@collabora.com> <e16c48e0-39ab-80db-0d14-2b3f97079823@xs4all.nl> <2830572.e9J7NaK4W3@kista>
In-Reply-To: <2830572.e9J7NaK4W3@kista>
User-Agent: ForteAgent/8.00.32.1272
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>Dne torek, 14. junij 2022 ob 15:50:23 CEST je Hans Verkuil napisal(a):
>> On 6/14/22 10:36, Benjamin Gaignard wrote:
>> > Make explicit that V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control is
>> > a dynamic array control type.
>> > Some drivers may be able to receive multiple slices in one control
>> > to improve decoding performance.
>> >=20
>> > Define the max size of the dynamic that can driver can set in .dims =
=3D {}.
>> >=20
>> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> > ---
>> > version 7:
>> > - Add Jernej patch to set array dims for Cedrus
>> >=20
>> > version 6:
>> > - Set V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag automatically when using
>> >   V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control.
>> > - Add a define for max slices count
>> >=20
>> >  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
>> >  drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 1 +
>> >  drivers/staging/media/sunxi/cedrus/cedrus.c               | 1 +
>> >  include/media/hevc-ctrls.h                                | 5 +++++
>> >  4 files changed, 9 insertions(+)
>> >=20
>> > diff --git =
a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
>Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> > index 06b967de140c..0796b1563daa 100644
>> > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> > @@ -2986,6 +2986,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field=
 -
>> >      These bitstream parameters are defined according to =
:ref:`hevc`.
>> >      They are described in section 7.4.7 "General slice segment =
header
>> >      semantics" of the specification.
>> > +    This control is a dynamically sized 1-dimensional array,
>> > +    V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
>> > =20
>> >  .. c:type:: v4l2_ctrl_hevc_slice_params
>> > =20
>> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c =
b/drivers/media/
>v4l2-core/v4l2-ctrls-defs.c
>> > index 9f55503cd3d6..d594efbcbb93 100644
>> > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> > @@ -1510,6 +1510,7 @@ void v4l2_ctrl_fill(u32 id, const char **name,=
 enum=20
>v4l2_ctrl_type *type,
>> >  		break;
>> >  	case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:
>> >  		*type =3D V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS;
>> > +		*flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
>> >  		break;
>> >  	case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:
>> >  		*type =3D V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX;
>> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c =
b/drivers/staging/
>media/sunxi/cedrus/cedrus.c
>> > index 87be975a72b6..f3391c7c811c 100644
>> > --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
>> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
>> > @@ -178,6 +178,7 @@ static const struct cedrus_control =
cedrus_controls[] =3D=20
>{
>> >  	{
>> >  		.cfg =3D {
>> >  			.id	=3D=20
>V4L2_CID_STATELESS_HEVC_SLICE_PARAMS,
>> > +			.dims   =3D { 1 },
>>=20
>> So cedrus HW supports only a single SLICE_PARAMS struct? Perhaps add =
that
>> as a comment.
>
>Yes, for now. I have WIP patch which will remove this limitation.
>
>Please corrrect me if I'm wrong, but this dimension represents maximum =
allowed=20
>array length? If so, this is a bit awkward for cases where there is =
really no=20
>limit. Like in this case. Cedrus can process only one slice which means =
that=20
>driver will have to loop over all submitted slices, one by one. Thus, =
there is=20
>no real limitation. It could be set to 10, 1000 or even more. Any =
suggestion=20
>for appropriate upper limit is appreciated.

Likewise for Pi there is no real upper limit.

Regards

John Cox

>Best regards,
>Jernej
>
>>=20
>> >  		},
>> >  		.codec		=3D CEDRUS_CODEC_H265,
>> >  	},
>> > diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>> > index 0dbd5d681c28..140151609c96 100644
>> > --- a/include/media/hevc-ctrls.h
>> > +++ b/include/media/hevc-ctrls.h
>> > @@ -311,9 +311,14 @@ struct v4l2_hevc_pred_weight_table {
>> >  #define=20
>V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED =
(1ULL <<=20
>8)
>> >  #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL =
<<=20
>9)
>> > =20
>> > +#define V4L2_HEVC_SLICE_MAX_COUNT	600
>> > +
>>=20
>> I would drop this define. It is not used at the moment, and I think it
>> is the driver that should set this through the dims field (as cedrus
>> does above). It is likely to be limited by hardware anyway (just my =
guess).
>>=20
>> If it is needed in the future, it can always be added.
>>=20
>> Regards,
>>=20
>> 	Hans
>>=20
>> >  /**
>> >   * v4l2_ctrl_hevc_slice_params - HEVC slice parameters
>> >   *
>> > + * This control is a dynamically sized 1-dimensional array,
>> > + * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
>> > + *
>> >   * @bit_size: size (in bits) of the current slice data
>> >   * @data_bit_offset: offset (in bits) to the video data in the =
current=20
>slice data
>> >   * @nal_unit_type: specifies the coding type of the slice (B, P or =
I)
>>=20
>>=20
>
