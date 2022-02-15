Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E76E4B72D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbiBOQLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:11:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbiBOQL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:11:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC9889CEF;
        Tue, 15 Feb 2022 08:11:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so1750083wmb.0;
        Tue, 15 Feb 2022 08:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akgdp0nUv5uW3+1NF74dVrBjd5UKlSd+kdDxEGnURlI=;
        b=OW5eC5e0Hw7A8e+obDqk/mPLrNgsKu4gUvOxpCk1fQ31ZU+HqUQASIID/sK08luaon
         uTpX1ZKa3WoPtopByrinsY/9Vi8TcXr8l+tBThcHxLuOMOXQgvro9frSZncupt7ymjj1
         xi+CfEY3VCyC0bVR4k3Qc9Z9vHlPiNbGfmt7DdqlO15Jp+ZtrgQnvn9KdjxjWzy9taIY
         Y8jziBkOyx36BUc5vEOCtkch9jc91y5uGmQHxHEHEXLhGdxdmre4DCEyEPoiICk4gsxN
         KkvS+0SX07teMVNjnAPsXb2BnpFxaAe81CZ4pR4Y0p1nvaKiJ2uvUi6oEa/4IhTocnLg
         ioDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akgdp0nUv5uW3+1NF74dVrBjd5UKlSd+kdDxEGnURlI=;
        b=eX4YAb6aMb4CtIvwAc+gNCiNoRO8wS4krQdAJx47PALIPvLvpoikCMQmfHLFbT8a9u
         7ogFlf1uZ3jpQFkcEshb6Vo0h99G+sIFH8+z6z1Qr1QxtJSIVDdr8dfyfjsZR6rag13X
         U4izHoy02mrtI3OamPBK2BUWmOF3g/6GkPUjY0bm27dZ9F3p/8QYEeLHIW2iQr4edONG
         9aDpwE2j1UAjvY123P9lmIDt/8EUZAaOyS7lQgyyVOdVhZIBNXIKlwpmzzI2hK/gJKJ1
         vSe7vdFP1r8yuIJ4+dsWcnx1MbMwU7JRbdtQrJpi4FrGUBdkJZUMUncNOf/9aVC9EBa0
         F33w==
X-Gm-Message-State: AOAM531vUlgSc/eHZ9BAJSBXi7LdTcY0jTapXbn7Nq4oI4V5Yk/d4z8l
        sHcEYeDGAvjgE4DD/b7seLg=
X-Google-Smtp-Source: ABdhPJz+cr/FbFbp/YEWBzYvFGhBIyLbtURqpGlikSXHMAgdXnC/xWHzfx1gavbudlcdtP2aXAFQBQ==
X-Received: by 2002:a05:600c:601a:: with SMTP id az26mr3769890wmb.2.1644941474494;
        Tue, 15 Feb 2022 08:11:14 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id a9sm17741358wrg.53.2022.02.15.08.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:11:13 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        John Cox <jc@kynesim.co.uk>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        hverkuil-cisco@xs4all.nl, jonas@kwiboo.se,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com
Subject: Re: Re: [RFC v2 6/8] media: uapi: Remove bit_size field from v4l2_ctrl_hevc_slice_params
Date:   Tue, 15 Feb 2022 17:11:12 +0100
Message-ID: <2071229.OBFZWjSADL@kista>
In-Reply-To: <48in0h5qq4ea87gcnmtkpsfqdk1r4tipid@4ax.com>
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com> <9a78eb88f8690d43d34d8140420dae3f5f043637.camel@ndufresne.ca> <48in0h5qq4ea87gcnmtkpsfqdk1r4tipid@4ax.com>
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

Dne torek, 15. februar 2022 ob 17:00:33 CET je John Cox napisal(a):
> On Tue, 15 Feb 2022 10:28:55 -0500, you wrote:
>=20
> >Le mardi 15 f=E9vrier 2022 =E0 14:50 +0000, John Cox a =E9crit :
> >> On Tue, 15 Feb 2022 15:35:12 +0100, you wrote:
> >>=20
> >> >=20
> >> > Le 15/02/2022 =E0 15:17, John Cox a =E9crit :
> >> > > Hi
> >> > >=20
> >> > > > The bit size of the slice could be deduced from the buffer paylo=
ad
> >> > > > so remove bit_size field to avoid duplicated the information.
> >> > > I think this is a bad idea. In the future we are (I hope) going to=
=20
want
> >> > > to have an array (variable) of slice headers all referring to the=
=20
same
> >> > > bit buffer.  When we do that we will need this field.
> >> >=20
> >> > I wonder if that could be considering like another decode mode and so
> >> > use an other control ?
> >>=20
> >> I, personally, would be in favour of making the slice header control a
> >> variable array just as it is.  If userland can't cope with multiple
> >> entries then just send them one at a time and the code looks exactly
> >> like it does at the moment and if the driver can't then set max array
> >> entries to 1.
> >>=20
> >> Having implemented this in rpi port of ffmpeg and the RPi V4L2 driver I
> >> can say with experience that the code and effort overhead is very low.
> >>=20
> >> Either way having a multiple slice header control in the UAPI is
> >> important for efficiency.
> >
> >Just to clarify the idea, we would have a single slice controls, always=
=20
dynamic:
> >
> >1. For sliced based decoder
> >
> >The dynamic array slice control is implemented by the driver and its siz=
e=20
must
> >be 1.
>=20
> Yes
>=20
> >2. For frame based decoder that don't care for slices
> >
> >The dynamic array slice controls is not implement. Userland detects that=
 at
> >runtime, similar to the VP9 compressed headers.
>=20
> If the driver parses all the slice header then that seems plausible
>=20
> >3. For frame based decoders that needs slices (or driver that supports=20
offset
> >and can gain performance with such mode)
> >
> >The dynamic array slice controls is implemented, and should contain all =
the
> >slices found in the OUTPUT buffer.
> >
> >So the reason for this bit_size (not sure why its bits though, perhaps=20
someone
> >can educate me ?)
>=20
> RPi doesn't need bits and would be happy with bytes however
> slice_segment data isn't byte aligned at the end so its possible that
> there might be decoders out there that want an accurate length for that.

There are two fields, please don't mix them up:

__u32	bit_size;
__u32	data_bit_offset; (changed to data_byte_offset in this series)

data_bit_offset/data_byte_offset is useful, while bit_size is IMO not. If y=
ou=20
have multiple slices in array, you only need to know start of the slice dat=
a=20
and that offset is always offset from start of the buffer (absolute, it's n=
ot=20
relative to previous slice data).

Best regards,
Jernej

>=20
> > Would be to let the driver offset inside the the single
> >OUTPUT/bitstream buffer in case this is not automatically found by the=20
driver
> >(or that no start-code is needed). Is that last bit correct ? If so, sho=
uld=20
we
> >change it to an offset rather then a size ? Shall we allow using offeset=
s=20
inside
> >larger buffer (e.g. to avoid some memory copies) for the Sliced Base cas=
es ?
>=20
> I use (in the current structure) data_bit_offset to find the start of
> each slice's slice_segment_data within the OUTPUT buffer and bit_size to
> find the end.  RPi doesn't / can't parse the slice_header and so wants
> all of that.  Decoders that do parse the header might plausably want
> header offsets too and it would facilitate zero copy of the bit buffer.
>=20
> =20
> >> Regards
> >>=20
> >> John Cox
> >>=20
> >> > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.co=
m>
> >> > > > ---
> >> > > > .../userspace-api/media/v4l/ext-ctrls-codec.rst       |  3 ---
> >> > > > drivers/staging/media/sunxi/cedrus/cedrus_h265.c      | 11 +++
+-------
> >> > > > include/uapi/linux/v4l2-controls.h                    |  3 +--
> >> > > > 3 files changed, 5 insertions(+), 12 deletions(-)
> >> > > >=20
> >> > > > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-
codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >> > > > index 3296ac3b9fca..c3ae97657fa7 100644
> >> > > > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >> > > > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >> > > > @@ -2965,9 +2965,6 @@ enum v4l2_mpeg_video_hevc_size_of_length_f=
ield=20
=2D
> >> > > >      :stub-columns: 0
> >> > > >      :widths:       1 1 2
> >> > > >=20
> >> > > > -    * - __u32
> >> > > > -      - ``bit_size``
> >> > > > -      - Size (in bits) of the current slice data.
> >> > > >      * - __u32
> >> > > >        - ``data_bit_offset``
> >> > > >        - Offset (in bits) to the video data in the current slice=
=20
data.
> >> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/
drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> >> > > > index 8ab2d9c6f048..db8c7475eeb8 100644
> >> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> >> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> >> > > > @@ -312,8 +312,8 @@ static void cedrus_h265_setup(struct cedrus_=
ctx=20
*ctx,
> >> > > > 	const struct v4l2_hevc_pred_weight_table *pred_weight_table;
> >> > > > 	unsigned int width_in_ctb_luma, ctb_size_luma;
> >> > > > 	unsigned int log2_max_luma_coding_block_size;
> >> > > > +	size_t slice_bytes;
> >> > > > 	dma_addr_t src_buf_addr;
> >> > > > -	dma_addr_t src_buf_end_addr;
> >> > > > 	u32 chroma_log2_weight_denom;
> >> > > > 	u32 output_pic_list_index;
> >> > > > 	u32 pic_order_cnt[2];
> >> > > > @@ -370,8 +370,8 @@ static void cedrus_h265_setup(struct cedrus_=
ctx=20
*ctx,
> >> > > >=20
> >> > > > 	cedrus_write(dev, VE_DEC_H265_BITS_OFFSET, 0);
> >> > > >=20
> >> > > > -	reg =3D slice_params->bit_size;
> >> > > > -	cedrus_write(dev, VE_DEC_H265_BITS_LEN, reg);
> >> > > > +	slice_bytes =3D vb2_get_plane_payload(&run->src->vb2_buf, 0);
> >> > > > +	cedrus_write(dev, VE_DEC_H265_BITS_LEN, slice_bytes);
> >> > > I think one of these must be wrong. bit_size is in bits,
> >> > > vb2_get_plane_payload is in bytes?
> >> >=20
> >> > You are right it should be vb2_get_plane_payload() * 8 to get the si=
ze=20
in bits.
> >> >=20
> >> > I will change that in v3.
> >> >=20
> >> > >=20
> >> > > Regards
> >> > >=20
> >> > > John Cox
> >> > >  =20
> >> > > > 	/* Source beginning and end addresses. */
> >> > > >=20
> >> > > > @@ -384,10 +384,7 @@ static void cedrus_h265_setup(struct=20
cedrus_ctx *ctx,
> >> > > >=20
> >> > > > 	cedrus_write(dev, VE_DEC_H265_BITS_ADDR, reg);
> >> > > >=20
> >> > > > -	src_buf_end_addr =3D src_buf_addr +
> >> > > > -			   DIV_ROUND_UP(slice_params->bit_size,=20
8);
> >> > > > -
> >> > > > -	reg =3D VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_end_addr);
> >> > > > +	reg =3D VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_addr + slice_by=
tes);
> >> > > > 	cedrus_write(dev, VE_DEC_H265_BITS_END_ADDR, reg);
> >> > > >=20
> >> > > > 	/* Coding tree block address */
> >> > > > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/
linux/v4l2-controls.h
> >> > > > index b1a3dc05f02f..27f5d272dc43 100644
> >> > > > --- a/include/uapi/linux/v4l2-controls.h
> >> > > > +++ b/include/uapi/linux/v4l2-controls.h
> >> > > > @@ -2457,7 +2457,6 @@ struct v4l2_hevc_pred_weight_table {
> >> > > > #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT=09
(1ULL << 9)
> >> > > >=20
> >> > > > struct v4l2_ctrl_hevc_slice_params {
> >> > > > -	__u32	bit_size;
> >> > > > 	__u32	data_bit_offset;
> >> > > >=20
> >> > > > 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
> >> > > > @@ -2484,7 +2483,7 @@ struct v4l2_ctrl_hevc_slice_params {
> >> > > > 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI messag=
e=20
*/
> >> > > > 	__u8	pic_struct;
> >> > > >=20
> >> > > > -	__u8	reserved;
> >> > > > +	__u8	reserved[5];
> >> > > >=20
> >> > > > 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment=20
header */
> >> > > > 	__u32	slice_segment_addr;
>=20


