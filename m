Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840584B719B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbiBOQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:01:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbiBOQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:00:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A6ECFB80
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:00:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s10so19375975wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynesim-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=ev89lW43hp3qbktlsuNQsUosdM2OcOnj9zBVHNAOnL8=;
        b=MzhjypX5VGUPPfW7ufDzJ8pOoKfavQjYoYSJYclgytqFqBZXKAxG/msV+MgbB55DP5
         jYgdlvnq14freS8c1DXIVKTwo4g3MgEAMfJamOTRNvFOfeNTbM+HFp7pbT6Rg3MkaSsv
         2W1i9eXP/Pqq5DdvtAIxaKRpeDKINU1a6ydfjrucTHbKhKNZs6Z3UBJs12sy8snQSROw
         n+f2mC8o9/2bgRRyaVwia0sH4QP7EjM0R91QflOf1mCsWwroGs8zNw1amBlMvOIItEgh
         q0070k1DGHqGBfi59rC1aLgL30M3xE7jnZLs+N+jscdMKK/83d5YG6WsZQxb0IH/70Wr
         my3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=ev89lW43hp3qbktlsuNQsUosdM2OcOnj9zBVHNAOnL8=;
        b=Pdtds2wWIsXBO5amFfSOFU40/Q/Cq5LwDD0b14WSxQGIP7tZ8Ud3dMQseG23aZ953m
         vfUeTMSGe/BHwry3d1zmL06hU0bbLW/gCrHpzLJ8vSe0jBi5mS157yWtClSMAMwoVBNJ
         O8CEkL3e8/ZmFmDy4K6pbEvtwcyCZQZXPtyeku0CFEnlsqHEO+4+jVuSja859CuGM4wR
         top++7M5kUdVqvTuigeFhg84+AYY94cdbbpPAEGhdYCHvnIBPZNpZNlHT5O/sfql0jfV
         OVqa5J6pD18qt4QV8YCmuWI2qVubZoMr4TKEb0Fa2xIxgy2xQPjGbulT66LTsIxsq/KL
         Jn1A==
X-Gm-Message-State: AOAM531DwxsBINV/ALIEwpzi56BXzPHjD/WIFeVxzpxRbZ31qZNGIBr9
        dI5SQk9pUeJGAj3bvl8pC2EswQ==
X-Google-Smtp-Source: ABdhPJyG0esH7uOaAhVJZcD69tfS19xit7vvGYjc7dcKtgtWanE0SsRjK2d4ZYNkwauxdqt+v2WpYw==
X-Received: by 2002:a5d:6488:: with SMTP id o8mr3708827wri.24.1644940834309;
        Tue, 15 Feb 2022 08:00:34 -0800 (PST)
Received: from CTHALPA.outer.uphall.net (cpc1-cmbg20-2-0-cust759.5-4.cable.virginm.net. [86.21.218.248])
        by smtp.gmail.com with ESMTPSA id l9sm15483830wrt.29.2022.02.15.08.00.33
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 15 Feb 2022 08:00:33 -0800 (PST)
From:   John Cox <jc@kynesim.co.uk>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl,
        jonas@kwiboo.se, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com
Subject: Re: [RFC v2 6/8] media: uapi: Remove bit_size field from v4l2_ctrl_hevc_slice_params
Date:   Tue, 15 Feb 2022 16:00:33 +0000
Message-ID: <48in0h5qq4ea87gcnmtkpsfqdk1r4tipid@4ax.com>
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com> <20220215110103.241297-7-benjamin.gaignard@collabora.com> <t2dn0hddgq22nt6a7sr6kl44irm3c2lj1j@4ax.com> <99062279-a3c4-96f7-4c4b-f39e7f812e68@collabora.com> <mqen0ht146rbtukbd47tbtbiqvsmfta8oa@4ax.com> <9a78eb88f8690d43d34d8140420dae3f5f043637.camel@ndufresne.ca>
In-Reply-To: <9a78eb88f8690d43d34d8140420dae3f5f043637.camel@ndufresne.ca>
User-Agent: ForteAgent/8.00.32.1272
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 10:28:55 -0500, you wrote:

>Le mardi 15 f=C3=A9vrier 2022 =C3=A0 14:50 +0000, John Cox a =
=C3=A9crit=C2=A0:
>> On Tue, 15 Feb 2022 15:35:12 +0100, you wrote:
>>=20
>> >=20
>> > Le 15/02/2022 =C3=A0 15:17, John Cox a =C3=A9crit=C2=A0:
>> > > Hi
>> > >=20
>> > > > The bit size of the slice could be deduced from the buffer =
payload
>> > > > so remove bit_size field to avoid duplicated the information.
>> > > I think this is a bad idea. In the future we are (I hope) going to=
 want
>> > > to have an array (variable) of slice headers all referring to the =
same
>> > > bit buffer.  When we do that we will need this field.
>> >=20
>> > I wonder if that could be considering like another decode mode and =
so
>> > use an other control ?
>>=20
>> I, personally, would be in favour of making the slice header control a
>> variable array just as it is.  If userland can't cope with multiple
>> entries then just send them one at a time and the code looks exactly
>> like it does at the moment and if the driver can't then set max array
>> entries to 1.
>>=20
>> Having implemented this in rpi port of ffmpeg and the RPi V4L2 driver =
I
>> can say with experience that the code and effort overhead is very low.
>>=20
>> Either way having a multiple slice header control in the UAPI is
>> important for efficiency.
>
>Just to clarify the idea, we would have a single slice controls, always =
dynamic:
>
>1. For sliced based decoder
>
>The dynamic array slice control is implemented by the driver and its =
size must
>be 1.

Yes

>2. For frame based decoder that don't care for slices
>
>The dynamic array slice controls is not implement. Userland detects that=
 at
>runtime, similar to the VP9 compressed headers.

If the driver parses all the slice header then that seems plausible

>3. For frame based decoders that needs slices (or driver that supports =
offset
>and can gain performance with such mode)
>
>The dynamic array slice controls is implemented, and should contain all =
the
>slices found in the OUTPUT buffer.
>
>So the reason for this bit_size (not sure why its bits though, perhaps =
someone
>can educate me ?)

RPi doesn't need bits and would be happy with bytes however
slice_segment data isn't byte aligned at the end so its possible that
there might be decoders out there that want an accurate length for that.

> Would be to let the driver offset inside the the single
>OUTPUT/bitstream buffer in case this is not automatically found by the =
driver
>(or that no start-code is needed). Is that last bit correct ? If so, =
should we
>change it to an offset rather then a size ? Shall we allow using =
offesets inside
>larger buffer (e.g. to avoid some memory copies) for the Sliced Base =
cases ?

I use (in the current structure) data_bit_offset to find the start of
each slice's slice_segment_data within the OUTPUT buffer and bit_size to
find the end.  RPi doesn't / can't parse the slice_header and so wants
all of that.  Decoders that do parse the header might plausably want
header offsets too and it would facilitate zero copy of the bit buffer.

=20
>> Regards
>>=20
>> John Cox
>>=20
>> > > > Signed-off-by: Benjamin Gaignard =
<benjamin.gaignard@collabora.com>
>> > > > ---
>> > > > .../userspace-api/media/v4l/ext-ctrls-codec.rst       |  3 ---
>> > > > drivers/staging/media/sunxi/cedrus/cedrus_h265.c      | 11 =
++++-------
>> > > > include/uapi/linux/v4l2-controls.h                    |  3 +--
>> > > > 3 files changed, 5 insertions(+), 12 deletions(-)
>> > > >=20
>> > > > diff --git =
a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst =
b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> > > > index 3296ac3b9fca..c3ae97657fa7 100644
>> > > > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> > > > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> > > > @@ -2965,9 +2965,6 @@ enum =
v4l2_mpeg_video_hevc_size_of_length_field -
>> > > >      :stub-columns: 0
>> > > >      :widths:       1 1 2
>> > > >=20
>> > > > -    * - __u32
>> > > > -      - ``bit_size``
>> > > > -      - Size (in bits) of the current slice data.
>> > > >      * - __u32
>> > > >        - ``data_bit_offset``
>> > > >        - Offset (in bits) to the video data in the current slice=
 data.
>> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c =
b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>> > > > index 8ab2d9c6f048..db8c7475eeb8 100644
>> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>> > > > @@ -312,8 +312,8 @@ static void cedrus_h265_setup(struct =
cedrus_ctx *ctx,
>> > > > 	const struct v4l2_hevc_pred_weight_table *pred_weight_table;
>> > > > 	unsigned int width_in_ctb_luma, ctb_size_luma;
>> > > > 	unsigned int log2_max_luma_coding_block_size;
>> > > > +	size_t slice_bytes;
>> > > > 	dma_addr_t src_buf_addr;
>> > > > -	dma_addr_t src_buf_end_addr;
>> > > > 	u32 chroma_log2_weight_denom;
>> > > > 	u32 output_pic_list_index;
>> > > > 	u32 pic_order_cnt[2];
>> > > > @@ -370,8 +370,8 @@ static void cedrus_h265_setup(struct =
cedrus_ctx *ctx,
>> > > >=20
>> > > > 	cedrus_write(dev, VE_DEC_H265_BITS_OFFSET, 0);
>> > > >=20
>> > > > -	reg =3D slice_params->bit_size;
>> > > > -	cedrus_write(dev, VE_DEC_H265_BITS_LEN, reg);
>> > > > +	slice_bytes =3D vb2_get_plane_payload(&run->src->vb2_buf, 0);
>> > > > +	cedrus_write(dev, VE_DEC_H265_BITS_LEN, slice_bytes);
>> > > I think one of these must be wrong. bit_size is in bits,
>> > > vb2_get_plane_payload is in bytes?
>> >=20
>> > You are right it should be vb2_get_plane_payload() * 8 to get the =
size in bits.
>> >=20
>> > I will change that in v3.
>> >=20
>> > >=20
>> > > Regards
>> > >=20
>> > > John Cox
>> > >  =20
>> > > > 	/* Source beginning and end addresses. */
>> > > >=20
>> > > > @@ -384,10 +384,7 @@ static void cedrus_h265_setup(struct =
cedrus_ctx *ctx,
>> > > >=20
>> > > > 	cedrus_write(dev, VE_DEC_H265_BITS_ADDR, reg);
>> > > >=20
>> > > > -	src_buf_end_addr =3D src_buf_addr +
>> > > > -			   DIV_ROUND_UP(slice_params->bit_size, 8);
>> > > > -
>> > > > -	reg =3D VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_end_addr);
>> > > > +	reg =3D VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_addr + =
slice_bytes);
>> > > > 	cedrus_write(dev, VE_DEC_H265_BITS_END_ADDR, reg);
>> > > >=20
>> > > > 	/* Coding tree block address */
>> > > > diff --git a/include/uapi/linux/v4l2-controls.h =
b/include/uapi/linux/v4l2-controls.h
>> > > > index b1a3dc05f02f..27f5d272dc43 100644
>> > > > --- a/include/uapi/linux/v4l2-controls.h
>> > > > +++ b/include/uapi/linux/v4l2-controls.h
>> > > > @@ -2457,7 +2457,6 @@ struct v4l2_hevc_pred_weight_table {
>> > > > #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	=
(1ULL << 9)
>> > > >=20
>> > > > struct v4l2_ctrl_hevc_slice_params {
>> > > > -	__u32	bit_size;
>> > > > 	__u32	data_bit_offset;
>> > > >=20
>> > > > 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>> > > > @@ -2484,7 +2483,7 @@ struct v4l2_ctrl_hevc_slice_params {
>> > > > 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI =
message */
>> > > > 	__u8	pic_struct;
>> > > >=20
>> > > > -	__u8	reserved;
>> > > > +	__u8	reserved[5];
>> > > >=20
>> > > > 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment =
header */
>> > > > 	__u32	slice_segment_addr;
