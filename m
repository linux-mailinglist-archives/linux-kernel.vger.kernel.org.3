Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909A74F6A2B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiDFToe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiDFTng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:43:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93DE156086;
        Wed,  6 Apr 2022 10:58:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 187121F45822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649267902;
        bh=L6qng+F82oavfDa6788iqCCq/nZ4DDudHD6oBSS4ZsU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ToMdnMOajCHGEsuTDq2o7irGVZ/vonCu8rKAo9Cl7YKcX5zG+YLzs283SlHbCODto
         SvsFtpNgtXUn9yXXpOuo7RLiBBfG5Z9IaGauAV63nQI0UzJksGgEO+RofqjEpkD+1r
         G85f67ACEFpyYBQcM49XTiyzQjF0z7PjiLw2fdR+sG/+TVsQ5JelVAJ2wqNkVZy6sO
         pb8nAU9BAz+GDjm8lewRSn+hphoBWSsGtGP/202jzhha496yxJ999aNnnAgN4r9fvh
         dMhRNLu1nptPL2TD4eYI8nVPAYT5zkyCwzuIkTn1dv6Sq2hWKVyn1WwIp8a2AEZBL5
         orNXEQmAXctuA==
Message-ID: <71c796610c3c9e1c8a117045c3764e40681a680a.camel@collabora.com>
Subject: Re: [PATCH v3 00/24] H.264 Field Decoding Support for Frame-based
 Decoders
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-media <linux-media@vger.kernel.org>
Date:   Wed, 06 Apr 2022 13:58:11 -0400
In-Reply-To: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

its not clear if that cover made it this time, though it will now. Adding a
comment below ...

Le mardi 05 avril 2022 =C3=A0 16:44 -0400, Nicolas Dufresne a =C3=A9crit=C2=
=A0:
> Until now, only Cedrus (a slice base decoder) supported interlaced
> decoding.  In order to support field decoding in our frame-based decoder,
> the v4l2-h264 library needed adaptation to produce the appropriate
> reference lists.
>=20
> This patch extends the v4l2-h264 library to produce the larger references
> list needed to represent fields separately. Hantro, MTK-VCODEC and RKVDEC
> drivers have been adapted to accommodate the larger lists. Though, only
> Hantro and RKVDEC actually have HW support for field decoding. So only
> these two have been updated to make use of the larger lists. All this wor=
k
> has been done using the H.264 specification, LibreELEC downstream kernel
> patches, Rockchip MPP reference software and Hantro reference software.
>=20
> For reviewers, the following is the map of all commit. Patches that could
> be merge independently of this serie are marked as independent. Note that
> the test results do depend on the generic fixes.
>=20
> 01    : Documentation fix (independent)
> 02-03 : Improving some generic traces (independent)
> 04    : Minor v4l2-h264 fix (independent)
> 05-11 : v4l2-h264 field decoding support
> 12-16 : rkvdec h.264 generic fixes (independent)
> 17-20 : rkvdec h.264 field decoding support
> 21-24 : hantro h.264 field decoding support
>=20
> All this work have been tested using GStreamer mainline implementation
> but also with FFMPEG LibreELEC fork using the testing tool fluster
> running through the ITU-T H.264 (2016-02) AVCv2 set of bitstream. Before
> this patch, the scores were:
>=20
> Hantro:
>   FFMPEG:   88/135
>   GSteamer: 90/135
> RKVDEC:
>   FFMPEG:   73/135
>   GSteamer: 77/135
>=20
> And after these changes:
>=20
> Hantro:
>   FFMPEG:   118/135
>   GSteamer: 129/135

I have also tested on IMX8MQ now, same results. This exercise the
hantro_g1_h264.c code.

> RKVDEC:
>   FFMPEG:   118/135
>   GSteamer: 129/135
>=20
> Note that a bug in FFMPEG / LibreELEC fork was noticed and fixed with the
> following change:
>=20
> diff --git a/libavcodec/v4l2_request_h264.c b/libavcodec/v4l2_request_h26=
4.c
> index 88da8f0a2d..394bae0550 100644
> --- a/libavcodec/v4l2_request_h264.c
> +++ b/libavcodec/v4l2_request_h264.c
> @@ -66,7 +66,7 @@ static void fill_dpb_entry(struct v4l2_h264_dpb_entry *=
entry, const H264Picture
>  {
>      entry->reference_ts =3D ff_v4l2_request_get_capture_timestamp(pic->f=
);
>      entry->pic_num =3D pic->pic_id;
> -    entry->frame_num =3D pic->frame_num;
> +    entry->frame_num =3D pic->long_ref ? pic->pic_id : pic->frame_num;
>      entry->fields =3D pic->reference & V4L2_H264_FRAME_REF;
>      entry->flags =3D V4L2_H264_DPB_ENTRY_FLAG_VALID;
>      if (entry->fields)
>=20
> Some useful links:
>=20
> Detailed Hantro Results:     https://gitlab.freedesktop.org/-/snippets/51=
89
> Detailed RKVDEC Results:     https://gitlab.freedesktop.org/-/snippets/52=
53
> ITU-T H.264 (2016-02) AVCv2: https://www.itu.int/net/itu-t/sigdb/spevideo=
/VideoForm-s.aspx?val=3D102002641
> Fluster:                     https://github.com/fluendo/fluster
> GStreamer:                   https://gitlab.freedesktop.org/gstreamer/gst=
reamer/
> FFMPEG Fork:                 https://github.com/jernejsk/FFmpeg/tree/v4l2=
-request-hwaccel-4.4
> Rockchip MPP:                https://github.com/rockchip-linux/mpp
>=20
> Changes in v3:
> - Improved debug message on timestamp miss-match
> - Moved H264 SPS validation into rkvdec-h264
> - Added more comments around H264 SPS validation
> - Also validate at streamon (rkvdec start())
> - Applied more Review-by and Fixes tag
> - Fixed Signed-off-by chain in Jonas patch
>=20
> Changes in v2:
> - Applied most of Sebastian's suggestion in comments and commit messages.
> - Use a bool for dpb_valid and dpb_bottom in rkvdec
> - Dropped one wrong typo fix (media: v4l2-mem2mem: Fix typo in trace mess=
age)
> - Dropped Alex fix (media: rkvdec-h264: Don't hardcode SPS/PPS parameters
>   + I will carry this one later, it seems cosmetic
>=20
> Jonas Karlman (5):
>   media: rkvdec: h264: Fix bit depth wrap in pps packet
>   media: rkvdec: h264: Validate and use pic width and height in mbs
>   media: rkvdec: h264: Fix reference frame_num wrap for second field
>   media: rkvdec: Ensure decoded resolution fit coded resolution
>   media: hantro: h264: Make dpb entry management more robust
>=20
> Nicolas Dufresne (18):
>   media: doc: Document dual use of H.264 pic_num/frame_num
>   media: v4l2-mem2mem: Trace on implicit un-hold
>   media: h264: Avoid wrapping long_term_frame_idx
>   media: h264: Use v4l2_h264_reference for reflist
>   media: h264: Increase reference lists size to 32
>   media: h264: Store current picture fields
>   media: h264: Store all fields into the unordered list
>   media: v4l2: Trace calculated p/b0/b1 initial reflist
>   media: h264: Sort p/b reflist using frame_num
>   media: v4l2: Reorder field reflist
>   media: rkvdec: Stop overclocking the decoder
>   media: rkvdec: h264: Fix dpb_valid implementation
>   media: rkvdec: Move H264 SPS validation in rkvdec-h264
>   media: rkvdec-h264: Add field decoding support
>   media: rkvdec: Enable capture buffer holding for H264
>   media: hantro: Stop using H.264 parameter pic_num
>   media: hantro: Add H.264 field decoding support
>   media: hantro: Enable HOLD_CAPTURE_BUF for H.264
>=20
> Sebastian Fricke (1):
>   media: videobuf2-v4l2: Warn on holding buffers without support
>=20
>  .../media/v4l/ext-ctrls-codec-stateless.rst   |  10 +-
>  .../media/common/videobuf2/videobuf2-v4l2.c   |   7 +-
>  .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |  17 +-
>  drivers/media/v4l2-core/v4l2-h264.c           | 261 ++++++++++++++----
>  drivers/media/v4l2-core/v4l2-mem2mem.c        |   1 +
>  .../staging/media/hantro/hantro_g1_h264_dec.c |  38 +--
>  drivers/staging/media/hantro/hantro_h264.c    | 119 ++++++--
>  drivers/staging/media/hantro/hantro_hw.h      |   7 +-
>  drivers/staging/media/hantro/hantro_v4l2.c    |  25 ++
>  .../media/hantro/rockchip_vpu2_hw_h264_dec.c  |  98 +++----
>  drivers/staging/media/rkvdec/rkvdec-h264.c    | 154 ++++++++---
>  drivers/staging/media/rkvdec/rkvdec.c         |  35 +--
>  drivers/staging/media/rkvdec/rkvdec.h         |   2 +
>  include/media/v4l2-h264.h                     |  31 ++-
>  14 files changed, 580 insertions(+), 225 deletions(-)
>=20
> --=20
> 2.34.1
>=20
>=20

