Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF094B6EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbiBOOSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:18:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiBOOSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:18:15 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C0EB109E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:18:00 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso1499075wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynesim-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=CG3P56xlFsoBU79QJPpFdYrXPhtp38683i1XknICllQ=;
        b=B4qU0nqAzx/qiAZj1y+v9vFn/1D1VF+7O5sDkagPNYxDPi0kKEDrxFZs59OTl0Q0wY
         +gZeTMkypecV6C9sbnkn/iWF4WBmLGQVjJ86A/QxUaiuPJdegV/WiPXQeKegfhW4YYQf
         ZiP33FZa+o14B2hlB+rkDBhQDgsgAzXFfQJwEmUOQUX5ocXMvBD1rBKTg+usfVBT3eXk
         W3snXxRd0TjHDF3iuZxPAoRxuBfBYv0DL+/HYH0oqE7X7/To4U7FjrQLRggIcqjxV6U0
         BX477H1cBINxU2jers608Krj60f/PiKnpjkqR2utsR4s5n/fTMF9ZTHgMUXl3OzsmG1u
         T4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=CG3P56xlFsoBU79QJPpFdYrXPhtp38683i1XknICllQ=;
        b=D+B8Kj1fIjH8SwWCJ6GH/CRjjSmeUBjjTjwWFRMcPYDN453BzlPRtpji/Wq6xDsNx+
         vmfC5OSS8LseLPRVlu4mBatLzcV6TepkJACnTHfozFYL9or66JKz0ABO2R9PvqSFP+WC
         hJmkSy9BdLWAQ+MgiWRpAt6UZud/bTQaSzxANVTDE5z5I3DgCJN2zUlOUli5lzcShW+8
         58k1RP41W42zrImmpw+W7bZdBGUqHIsuIC2Y+f9DReIeF9RbEvFz5AI4J0pqAxVKZWcg
         u4pr9AMDn9UImuI25om2GrP6GIY2KUVTZalBYpR2MoivhF9klDVgrzXe6oRThumOzONk
         U9pA==
X-Gm-Message-State: AOAM531OzZUpFVpFet4kjwRKU84PG/YLWYyPWASY+QDmlc/tDdcXbJjH
        +RgUaG2DnkkfeWPKb2+mpf4ELw==
X-Google-Smtp-Source: ABdhPJwXgJ7HnZxlPFUESAzSmrFq3Y5J8UCvZ0uCcLzfXnoYTam1CrM5dvh2jkgKvzQJEZNfaKqtxg==
X-Received: by 2002:a05:600c:4e0a:b0:37b:c548:622a with SMTP id b10-20020a05600c4e0a00b0037bc548622amr3398548wmq.55.1644934679483;
        Tue, 15 Feb 2022 06:17:59 -0800 (PST)
Received: from CTHALPA.outer.uphall.net (cpc1-cmbg20-2-0-cust759.5-4.cable.virginm.net. [86.21.218.248])
        by smtp.gmail.com with ESMTPSA id o20sm14929542wmq.21.2022.02.15.06.17.57
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 15 Feb 2022 06:17:58 -0800 (PST)
From:   John Cox <jc@kynesim.co.uk>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl,
        jonas@kwiboo.se, nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [RFC v2 6/8] media: uapi: Remove bit_size field from v4l2_ctrl_hevc_slice_params
Date:   Tue, 15 Feb 2022 14:17:57 +0000
Message-ID: <t2dn0hddgq22nt6a7sr6kl44irm3c2lj1j@4ax.com>
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com> <20220215110103.241297-7-benjamin.gaignard@collabora.com>
In-Reply-To: <20220215110103.241297-7-benjamin.gaignard@collabora.com>
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

>The bit size of the slice could be deduced from the buffer payload
>so remove bit_size field to avoid duplicated the information.

I think this is a bad idea. In the future we are (I hope) going to want
to have an array (variable) of slice headers all referring to the same
bit buffer.  When we do that we will need this field.

>Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>---
> .../userspace-api/media/v4l/ext-ctrls-codec.rst       |  3 ---
> drivers/staging/media/sunxi/cedrus/cedrus_h265.c      | 11 ++++-------
> include/uapi/linux/v4l2-controls.h                    |  3 +--
> 3 files changed, 5 insertions(+), 12 deletions(-)
>
>diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst =
b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>index 3296ac3b9fca..c3ae97657fa7 100644
>--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>@@ -2965,9 +2965,6 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>     :stub-columns: 0
>     :widths:       1 1 2
>=20
>-    * - __u32
>-      - ``bit_size``
>-      - Size (in bits) of the current slice data.
>     * - __u32
>       - ``data_bit_offset``
>       - Offset (in bits) to the video data in the current slice data.
>diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c =
b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>index 8ab2d9c6f048..db8c7475eeb8 100644
>--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>@@ -312,8 +312,8 @@ static void cedrus_h265_setup(struct cedrus_ctx =
*ctx,
> 	const struct v4l2_hevc_pred_weight_table *pred_weight_table;
> 	unsigned int width_in_ctb_luma, ctb_size_luma;
> 	unsigned int log2_max_luma_coding_block_size;
>+	size_t slice_bytes;
> 	dma_addr_t src_buf_addr;
>-	dma_addr_t src_buf_end_addr;
> 	u32 chroma_log2_weight_denom;
> 	u32 output_pic_list_index;
> 	u32 pic_order_cnt[2];
>@@ -370,8 +370,8 @@ static void cedrus_h265_setup(struct cedrus_ctx =
*ctx,
>=20
> 	cedrus_write(dev, VE_DEC_H265_BITS_OFFSET, 0);
>=20
>-	reg =3D slice_params->bit_size;
>-	cedrus_write(dev, VE_DEC_H265_BITS_LEN, reg);
>+	slice_bytes =3D vb2_get_plane_payload(&run->src->vb2_buf, 0);
>+	cedrus_write(dev, VE_DEC_H265_BITS_LEN, slice_bytes);

I think one of these must be wrong. bit_size is in bits,
vb2_get_plane_payload is in bytes?

Regards

John Cox
=20
> 	/* Source beginning and end addresses. */
>=20
>@@ -384,10 +384,7 @@ static void cedrus_h265_setup(struct cedrus_ctx =
*ctx,
>=20
> 	cedrus_write(dev, VE_DEC_H265_BITS_ADDR, reg);
>=20
>-	src_buf_end_addr =3D src_buf_addr +
>-			   DIV_ROUND_UP(slice_params->bit_size, 8);
>-
>-	reg =3D VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_end_addr);
>+	reg =3D VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_addr + slice_bytes);
> 	cedrus_write(dev, VE_DEC_H265_BITS_END_ADDR, reg);
>=20
> 	/* Coding tree block address */
>diff --git a/include/uapi/linux/v4l2-controls.h =
b/include/uapi/linux/v4l2-controls.h
>index b1a3dc05f02f..27f5d272dc43 100644
>--- a/include/uapi/linux/v4l2-controls.h
>+++ b/include/uapi/linux/v4l2-controls.h
>@@ -2457,7 +2457,6 @@ struct v4l2_hevc_pred_weight_table {
> #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL << 9)
>=20
> struct v4l2_ctrl_hevc_slice_params {
>-	__u32	bit_size;
> 	__u32	data_bit_offset;
>=20
> 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>@@ -2484,7 +2483,7 @@ struct v4l2_ctrl_hevc_slice_params {
> 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI message */
> 	__u8	pic_struct;
>=20
>-	__u8	reserved;
>+	__u8	reserved[5];
>=20
> 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
> 	__u32	slice_segment_addr;
