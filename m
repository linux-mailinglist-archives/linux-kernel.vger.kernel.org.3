Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FEA49FD0E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349672AbiA1Pps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiA1Ppl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:45:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11A7C061714;
        Fri, 28 Jan 2022 07:45:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 067EC1F4620F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643384739;
        bh=IGq7GfuBi8NHWX6SthTV1+6EDRykLJzQI/cy6hWLrnQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Uxmpo0wgV5Ee4ZcofY6PZWLYACT15x0X0dwLoKAY4upp6GrBmtgs9HnDSEaXamu1g
         2ZAVhA0fw1IJPx3uubs3EOKdjnEMVI7JmwbsbQiXXhh32HDSXkIHW8cP7dawQVh/ez
         9aXog+QCM/8USka6PCvZ6IvHL7gso26W50ckeg3LlUjcZKlJ75grb3Er4ORv1WLw4a
         t08qVJC/ZLv6/If5u8VcopvmfpKXbfaEaVcs/PRPqpd/2N3qycGn+i+o+x3fuBnmGg
         JecmoPUn9C8P53K0yMtsrvZWge+y1YLVU5s2npQ4iFbruccw9vKP2w5jVvxu+oL0dY
         i72bbuXTrvJmw==
Message-ID: <8976b666053a22a39e6e28f909394dd78558d769.camel@collabora.com>
Subject: Re: [RFC PATCH 1/2] media: Add AV1 uAPI
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     daniel.almeida@collabora.com, stevecho@google.com,
        shawnku@google.com, tzungbi@google.com, mcasas@google.com,
        nhebert@google.com, abodenha@google.com, randy.wu@mediatek.com,
        yunfei.dong@mediatek.com, gustavo.padovan@collabora.com,
        andrzej.pietrasiewicz@collabora.com, tomeu.vizoso@collabora.com,
        nick.milner@collabora.com, xiaoyong.lu@mediatek.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Date:   Fri, 28 Jan 2022 10:45:26 -0500
In-Reply-To: <20210810220552.298140-2-daniel.almeida@collabora.com>
References: <20210810220552.298140-1-daniel.almeida@collabora.com>
         <20210810220552.298140-2-daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 10 août 2021 à 19:05 -0300, daniel.almeida@collabora.com a écrit :
> From: Daniel Almeida <daniel.almeida@collabora.com>
> 
> This patch adds the  AOMedia Video 1 (AV1) kernel uAPI.
> 
> This design is based on currently available AV1 API implementations and
> aims to support the development of AV1 stateless video codecs
> on Linux.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  .../userspace-api/media/v4l/biblio.rst        |   10 +
>  .../media/v4l/ext-ctrls-codec-stateless.rst   | 1268 +++++++++++++++++
>  .../media/v4l/pixfmt-compressed.rst           |   21 +
>  .../media/v4l/vidioc-g-ext-ctrls.rst          |   36 +
>  .../media/v4l/vidioc-queryctrl.rst            |   54 +
>  .../media/videodev2.h.rst.exceptions          |    9 +
>  drivers/media/v4l2-core/v4l2-ctrls-core.c     |  286 +++-
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |   79 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
>  include/media/v4l2-ctrls.h                    |   12 +
>  include/uapi/linux/v4l2-controls.h            |  796 +++++++++++
>  include/uapi/linux/videodev2.h                |   15 +
>  12 files changed, 2586 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/biblio.rst b/Documentation/userspace-api/media/v4l/biblio.rst
> index 7b8e6738ff9e..7061144d10bb 100644
> --- a/Documentation/userspace-api/media/v4l/biblio.rst
> +++ b/Documentation/userspace-api/media/v4l/biblio.rst
> @@ -417,3 +417,13 @@ VP8
>  :title:     RFC 6386: "VP8 Data Format and Decoding Guide"
>  
>  :author:    J. Bankoski et al.
> +
> +.. _av1:
> +
> +AV1
> +===
> +
> +
> +:title:     AV1 Bitstream & Decoding Process Specification
> +
> +:author:    Peter de Rivaz, Argon Design Ltd, Jack Haughton, Argon Design Ltd
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> index 72f5e85b4f34..960500651e4b 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
> @@ -1458,3 +1458,1271 @@ FWHT Flags
>  .. raw:: latex
>  
>      \normalsize
> +
> +
> +.. _v4l2-codec-stateless-av1:
> +
> +``V4L2_CID_STATELESS_AV1_SEQUENCE (struct)``
> +    Represents an AV1 Sequence OBU. See section 5.5. "Sequence header OBU syntax"
> +    in :ref:`av1` for more details.
> +
> +.. c:type:: v4l2_ctrl_av1_sequence
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{5.8cm}|p{4.8cm}|p{6.6cm}|
> +
> +.. flat-table:: struct v4l2_ctrl_av1_sequence
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u32
> +      - ``flags``
> +      - See :ref:`AV1 Sequence Flags <av1_sequence_flags>`.
> +    * - __u8
> +      - ``seq_profile``
> +      - Specifies the features that can be used in the coded video sequence.
> +    * - __u8
> +      - ``order_hint_bits``
> +      - Specifies the number of bits used for the order_hint field at each frame.
> +    * - __u8
> +      - ``bit_depth``
> +      - the bitdepth to use for the sequence as described in section 5.5.2
> +        "Color config syntax" in :ref:`av1` for more details.
> +
> +
> +.. _av1_sequence_flags:
> +
> +``AV1 Sequence Flags``
> +
> +.. cssclass:: longtable
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_STILL_PICTURE``
> +      - 0x00000001
> +      - If set, specifies that the coded video sequence contains only one coded
> +	frame. If not set, specifies that the coded video sequence contains one or
> +	more coded frames.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_USE_128X128_SUPERBLOCK``
> +      - 0x00000002
> +      - If set, indicates that superblocks contain 128x128 luma samples.
> +	When equal to 0, it indicates that superblocks contain 64x64 luma samples.
> +	(The number of contained chroma samples depends on subsampling_x and
> +	subsampling_y).
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_ENABLE_FILTER_INTRA``
> +      - 0x00000004
> +      - If set, specifies that the use_filter_intra syntax element may be
> +	present. If not set, specifies that the use_filter_intra syntax element will
> +	not be present.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTRA_EDGE_FILTER``
> +      - 0x00000008
> +      - Specifies whether the intra edge filtering process should be enabled.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTERINTRA_COMPOUND``
> +      - 0x00000010
> +      - If set, specifies that the mode info for inter blocks may contain the
> +	syntax element interintra. If not set, specifies that the syntax element
> +	interintra will not be present.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND``
> +      - 0x00000020
> +      - If set, specifies that the mode info for inter blocks may contain the
> +	syntax element compound_type. If not set, specifies that the syntax element
> +	compound_type will not be present.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_ENABLE_WARPED_MOTION``
> +      - 0x00000040
> +      - If set, indicates that the allow_warped_motion syntax element may be
> +	present. If not set, indicates that the allow_warped_motion syntax element
> +	will not be present.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_ENABLE_DUAL_FILTER``
> +      - 0x00000080
> +      - If set, indicates that the inter prediction filter type may be specified
> +	independently in the horizontal and vertical directions. If the flag is
> +	equal to 0, only one filter type may be specified, which is then used in
> +	both directions.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_ENABLE_ORDER_HINT``
> +      - 0x00000100
> +      - If set, indicates that tools based on the values of order hints may be
> +	used. If not set, indicates that tools based on order hints are disabled.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_ENABLE_JNT_COMP``
> +      - 0x00000200
> +      - If set, indicates that the distance weights process may be used for
> +	inter prediction.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_ENABLE_REF_FRAME_MVS``
> +      - 0x00000400
> +      - If set, indicates that the use_ref_frame_mvs syntax element may be
> +	present. If not set, indicates that the use_ref_frame_mvs syntax element
> +	will not be present.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_ENABLE_SUPERRES``
> +      - 0x00000800
> +      - If set, specifies that the use_superres syntax element will be present
> +	in the uncompressed header. If not set, specifies that the use_superres
> +	syntax element will not be present (instead use_superres will be set to 0
> +	in the uncompressed header without being read).
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF``
> +      - 0x00001000
> +      - If set, specifies that cdef filtering may be enabled. If not set,
> +	specifies that cdef filtering is disabled.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_ENABLE_RESTORATION``
> +      - 0x00002000
> +      - If set, specifies that loop restoration filtering may be enabled. If not
> +	set, specifies that loop restoration filtering is disabled.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME``
> +      - 0x00004000
> +      - If set, indicates that the video does not contain U and V color planes.
> +	If not set, indicates that the video contains Y, U, and V color planes.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_COLOR_RANGE``
> +      - 0x00008000
> +      - If set, signals full swing representation. If not set, signals studio
> +	swing representation.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X``
> +      - 0x00010000
> +      - Specify the chroma subsampling format.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y``
> +      - 0x00020000
> +      - Specify the chroma subsampling format.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT``
> +      - 0x00040000
> +      - Specifies whether film grain parameters are present in the coded video
> +	sequence.
> +    * - ``V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q``
> +      - 0x00080000
> +      - If set, indicates that the U and V planes may have separate delta
> +	quantizer values. If not set, indicates that the U and V planes will share
> +	the same delta quantizer value.
> +
> +``V4L2_CID_STATELESS_AV1_TILE_GROUP (struct)``
> +    Represents a tile group as seen in an AV1 Tile Group OBU or Frame OBU. A
> +    v4l2_ctrl_av1_tile_group instance will refer to tg_end - tg_start instances
> +    of struct :c:type:`struct v4l2_ctrl_av1_tile_group_entry`. See section
> +    6.10.1 "General tile group OBU semantics" in :ref:`av1` for more details.
> +
> +.. c:type:: v4l2_ctrl_av1_tile_group
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{5.8cm}|p{4.8cm}|p{6.6cm}|
> +
> +.. flat-table:: struct v4l2_ctrl_av1_tile_group
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``flags``
> +      - See :ref:`AV1 Tile Group Flags <av1_tile_group_flags>`.
> +    * - __u8
> +      - ``tg_start``
> +      - Specifies the zero-based index of the first tile in the current tile
> +        group.
> +    * - __u8
> +      - ``tg_end``
> +      - Specifies the zero-based index of the last tile in the current tile
> +        group.
> +
> +.. _av1_tile_group_flags:
> +
> +``AV1 Tile Group Flags``
> +
> +.. cssclass:: longtable
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_TILE_GROUP_FLAG_START_AND_END_PRESENT``
> +      - 0x00000001
> +      - Specifies whether tg_start and tg_end are present. If tg_start and
> +	tg_end are not present, this tile group covers the entire frame.
> +
> +``V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY (struct)``
> +    Represents a single AV1 tile inside an AV1 Tile Group. Note that MiRowStart,
> +    MiRowEnd, MiColStart and MiColEnd can be retrieved from struct
> +    v4l2_av1_tile_info in struct v4l2_ctrl_av1_frame_header using tile_row and
> +    tile_col. See section 6.10.1 "General tile group OBU semantics" in
> +    :ref:`av1` for more details.
> +
> +.. c:type:: v4l2_ctrl_av1_tile_group_entry
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{5.8cm}|p{4.8cm}|p{6.6cm}|
> +
> +.. flat-table:: struct v4l2_ctrl_av1_tile_group_entry
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u32
> +      - ``tile_offset``
> +      - Offset from the OBU data, i.e. where the coded tile data actually starts.
> +    * - __u32
> +      - ``tile_size``
> +      - Specifies the size in bytes of the coded tile. Equivalent to "TileSize"
> +        in :ref:`av1`.
> +    * - __u32
> +      - ``tile_row``
> +      - Specifies the row of the current tile. Equivalent to "TileRow" in
> +        :ref:`av1`.
> +    * - __u32
> +      - ``tile_col``
> +      - Specifies the column of the current tile. Equivalent to "TileColumn" in
> +        :ref:`av1`.
> +
> +``V4L2_CID_STATELESS_AV1_TILE_LIST (struct)``
> +    Represents a tile list as seen in an AV1 Tile List OBU. Tile lists are used
> +    in "Large Scale Tile Decode Mode". Note that tile_count_minus_1 should be at
> +    most V4L2_AV1_MAX_TILE_COUNT - 1. A struct v4l2_ctrl_av1_tile_list instance
> +    will refer to "tile_count_minus_1" + 1 instances of struct
> +    v4l2_ctrl_av1_tile_list_entry.
> +
> +.. c:type:: v4l2_ctrl_av1_tile_list
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{5.8cm}|p{4.8cm}|p{6.6cm}|
> +
> +.. flat-table:: struct v4l2_ctrl_av1_tile_list
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``output_frame_width_in_tiles_minus_1``
> +      - This field plus one is the width of the output frame, in tile units.
> +    * - __u8
> +      - ``output_frame_height_in_tiles_minus_1``
> +      - This field plus one is the height of the output frame, in tile units.
> +    * - __u8
> +      - ``tile_count_minus_1``
> +      - This field plus one is the number of tile_list_entry in the list.
> +
> +``V4L2_CID_STATELESS_AV1_TILE_LIST_ENTRY (struct)``
> +    Represents a tile list entry as seen in an AV1 Tile List OBU. See section
> +    6.11.2. "Tile list entry semantics" of :ref:`av1` for more details.
> +
> +.. c:type:: v4l2_ctrl_av1_tile_list_entry
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{5.8cm}|p{4.8cm}|p{6.6cm}|
> +
> +.. flat-table:: struct v4l2_ctrl_av1_tile_list
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``anchor_frame_idx``
> +      - The index into an array AnchorFrames of the frames that the tile uses
> +	for prediction.
> +    * - __u8
> +      - ``anchor_tile_row``
> +      - The row coordinate of the tile in the frame that it belongs, in tile
> +	units.
> +    * - __u8
> +      - ``anchor_tile_col``
> +      - The column coordinate of the tile in the frame that it belongs, in tile
> +	units.
> +    * - __u8
> +      - ``tile_data_size_minus_1``
> +      - This field plus one is the size of the coded tile data in bytes.
> +
> +.. c:type:: v4l2_av1_film_grain
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{1.5cm}|p{5.8cm}|p{10.0cm}|
> +
> +.. flat-table:: struct v4l2_av1_film_grain
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``flags``
> +      - See :ref:`AV1 Film Grain Flags <av1_film_grain_flags>`.
> +    * - __u16
> +      - ``grain_seed``
> +      - Specifies the starting value for the pseudo-random numbers used during
> +	film grain synthesis.
> +    * - __u8
> +      - ``film_grain_params_ref_idx``
> +      - Indicates which reference frame contains the film grain parameters to be
> +	used for this frame.
> +    * - __u8
> +      - ``num_y_points``
> +      - Specifies the number of points for the piece-wise linear scaling
> +	function of the luma component.
> +    * - __u8
> +      - ``point_y_value[V4L2_AV1_MAX_NUM_Y_POINTS]``
> +      - Represents the x (luma value) coordinate for the i-th point
> +        of the piecewise linear scaling function for luma component. The values
> +        are signaled on the scale of 0..255. (In case of 10 bit video, these
> +        values correspond to luma values divided by 4. In case of 12 bit video,
> +        these values correspond to luma values divided by 16.).
> +    * - __u8
> +      - ``point_y_scaling[V4L2_AV1_MAX_NUM_Y_POINTS]``
> +      - Represents the scaling (output) value for the i-th point
> +	of the piecewise linear scaling function for luma component.
> +    * - __u8
> +      - ``num_cb_points``
> +      -  Specifies the number of points for the piece-wise linear scaling
> +         function of the cb component.
> +    * - __u8
> +      - ``point_cb_value[V4L2_AV1_MAX_NUM_CB_POINTS]``
> +      - Represents the x coordinate for the i-th point of the
> +        piece-wise linear scaling function for cb component. The values are
> +        signaled on the scale of 0..255.
> +    * - __u8
> +      - ``point_cb_scaling[V4L2_AV1_MAX_NUM_CB_POINTS]``
> +      - Represents the scaling (output) value for the i-th point of the
> +        piecewise linear scaling function for cb component.
> +    * - __u8
> +      - ``num_cr_points``
> +      - Represents the number of points for the piece-wise
> +        linear scaling function of the cr component.
> +    * - __u8
> +      - ``point_cr_value[V4L2_AV1_MAX_NUM_CR_POINTS]``
> +      - Represents the x coordinate for the i-th point of the
> +        piece-wise linear scaling function for cr component. The values are
> +        signaled on the scale of 0..255.
> +    * - __u8
> +      - ``point_cr_scaling[V4L2_AV1_MAX_NUM_CR_POINTS]``
> +      - Represents the scaling (output) value for the i-th point of the
> +        piecewise linear scaling function for cr component.
> +    * - __u8
> +      - ``grain_scaling_minus_8``
> +      - Represents the shift – 8 applied to the values of the chroma component.
> +        The grain_scaling_minus_8 can take values of 0..3 and determines the
> +        range and quantization step of the standard deviation of film grain.
> +    * - __u8
> +      - ``ar_coeff_lag``
> +      - Specifies the number of auto-regressive coefficients for luma and
> +	chroma.
> +    * - __u8
> +      - ``ar_coeffs_y_plus_128[V4L2_AV1_MAX_NUM_POS_LUMA]``
> +      - Specifies auto-regressive coefficients used for the Y plane.
> +    * - __u8
> +      - ``ar_coeffs_cb_plus_128[V4L2_AV1_MAX_NUM_POS_LUMA]``
> +      - Specifies auto-regressive coefficients used for the U plane.
> +    * - __u8
> +      - ``ar_coeffs_cr_plus_128[V4L2_AV1_MAX_NUM_POS_LUMA]``
> +      - Specifies auto-regressive coefficients used for the V plane.
> +    * - __u8
> +      - ``ar_coeff_shift_minus_6``
> +      - Specifies the range of the auto-regressive coefficients. Values of 0,
> +        1, 2, and 3 correspond to the ranges for auto-regressive coefficients of
> +        [-2, 2), [-1, 1), [-0.5, 0.5) and [-0.25, 0.25) respectively.
> +    * - __u8
> +      - ``grain_scale_shift``
> +      - Specifies how much the Gaussian random numbers should be scaled down
> +	during the grain synthesis process.
> +    * - __u8
> +      - ``cb_mult``
> +      - Represents a multiplier for the cb component used in derivation of the
> +	input index to the cb component scaling function.
> +    * - __u8
> +      - ``cb_luma_mult``
> +      - Represents a multiplier for the average luma component used in
> +	derivation of the input index to the cb component scaling function..
> +    * - __u16
> +      - ``cb_offset``
> +      - Represents an offset used in derivation of the input index to the
> +	cb component scaling function.
> +    * - __u8
> +      - ``cr_mult``
> +      - Represents a multiplier for the cb component used in derivation of the
> +	input index to the cr component scaling function.
> +    * - __u8
> +      - ``cr_luma_mult``
> +      - Represents a multiplier for the average luma component used in
> +        derivation of the input index to the cr component scaling function.
> +    * - __u16
> +      - ``cr_offset``
> +      - Represents an offset used in derivation of the input index to the
> +        cr component scaling function.
> +
> +.. _av1_film_grain_flags:
> +
> +``AV1 Film Grain Flags``
> +
> +.. cssclass:: longtable
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_FILM_GRAIN_FLAG_APPLY_GRAIN``
> +      - 0x00000001
> +      - If set, specifies that film grain should be added to this frame. If not
> +	set, specifies that film grain should not be added.
> +    * - ``V4L2_AV1_FILM_GRAIN_FLAG_UPDATE_GRAIN``
> +      - 0x00000002
> +      - If set, means that a new set of parameters should be sent. If not set,
> +	specifies that the previous set of parameters should be used.
> +    * - ``V4L2_AV1_FILM_GRAIN_FLAG_CHROMA_SCALING_FROM_LUMA``
> +      - 0x00000004
> +      - If set, specifies that the chroma scaling is inferred from the luma
> +	scaling.
> +    * - ``V4L2_AV1_FILM_GRAIN_FLAG_OVERLAP``
> +      - 0x00000008
> +      - If set, indicates that the overlap between film grain blocks shall be
> +	applied. If not set, indicates that the overlap between film grain blocks
> +	shall not be applied.
> +    * - ``V4L2_AV1_FILM_GRAIN_FLAG_CLIP_TO_RESTRICTED_RANGE``
> +      - 0x00000010
> +      - If set, indicates that clipping to the restricted (studio) range shall
> +        be applied to the sample values after adding the film grain (see the
> +        semantics for color_range for an explanation of studio swing). If not
> +        set, indicates that clipping to the full range shall be applied to the
> +        sample values after adding the film grain.
> +
> +.. c:type:: v4l2_av1_warp_model
> +
> +	AV1 Warp Model as described in section 3 "Symbols and abbreviated terms" of
> +	:ref:`av1`.
> +
> +.. raw:: latex
> +
> +    \scriptsize
> +
> +.. tabularcolumns:: |p{7.4cm}|p{0.3cm}|p{9.6cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_WARP_MODEL_IDENTITY``
> +      - 0
> +      - Warp model is just an identity transform.
> +    * - ``V4L2_AV1_WARP_MODEL_TRANSLATION``
> +      - 1
> +      - Warp model is a pure translation.
> +    * - ``V4L2_AV1_WARP_MODEL_ROTZOOM``
> +      - 2
> +      - Warp model is a rotation + symmetric zoom + translation.
> +    * - ``V4L2_AV1_WARP_MODEL_AFFINE``
> +      - 3
> +      - Warp model is a general affine transform.
> +
> +.. c:type:: v4l2_av1_reference_frame
> +
> +AV1 Reference Frames as described in section 6.10.24. "Ref frames semantics"
> +of :ref:`av1`.
> +
> +.. raw:: latex
> +
> +    \scriptsize
> +
> +.. tabularcolumns:: |p{7.4cm}|p{0.3cm}|p{9.6cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_REF_INTRA_FRAME``
> +      - 0
> +      - Intra Frame Reference.
> +    * - ``V4L2_AV1_REF_LAST_FRAME``
> +      - 1
> +      - Last Frame Reference.
> +    * - ``V4L2_AV1_REF_LAST2_FRAME``
> +      - 2
> +      - Last2 Frame Reference.
> +    * - ``V4L2_AV1_REF_LAST3_FRAME``
> +      - 3
> +      - Last3 Frame Reference.
> +    * - ``V4L2_AV1_REF_GOLDEN_FRAME``
> +      - 4
> +      - Golden Frame Reference.
> +    * - ``V4L2_AV1_REF_BWDREF_FRAME``
> +      - 5
> +      - BWD Frame Reference.
> +    * - ``V4L2_AV1_REF_ALTREF2_FRAME``
> +      - 6
> +      - ALTREF2 Frame Reference.
> +    * - ``V4L2_AV1_REF_ALTREF_FRAME``
> +      - 7
> +      - ALTREF Frame Reference.
> +    * - ``V4L2_AV1_NUM_REF_FRAMES``
> +      - 8
> +      - Total number of reference frames.
> +
> +.. c:type:: v4l2_av1_global_motion
> +
> +AV1 Global Motion parameters as described in section 6.8.17
> +"Global motion params semantics" of :ref:`av1` for more details.
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{1.5cm}|p{5.8cm}|p{10.0cm}|
> +
> +.. flat-table:: struct v4l2_av1_global_motion
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``flags[V4L2_AV1_TOTAL_REFS_PER_FRAME]``
> +      - A bitfield containing the flags per reference frame. See
> +        :ref:`AV1 Global Motion Flags <av1_global_motion_flags>` for more
> +        details.
> +    * - enum :c:type:`v4l2_av1_warp_model`
> +      - ``type[V4L2_AV1_TOTAL_REFS_PER_FRAME]``
> +      - The type of global motion transform used.
> +    * - __u32
> +      - ``params[V4L2_AV1_TOTAL_REFS_PER_FRAME][6]``
> +      - This field has the same meaning as "gm_params" in :ref:`av1`.
> +    * - __u8
> +      - ``invalid``
> +      - Bitfield indicating whether the global motion params are invalid for a
> +        given reference frame. See section 7.11.3.6. Setup shear process and the
> +        variable "warpValid". Use V4L2_AV1_GLOBAL_MOTION_IS_INVALID(ref) to
> +        create a suitable mask.
> +
> +.. _av1_global_motion_flags:
> +
> +``AV1 Global Motion Flags``
> +
> +.. cssclass:: longtable
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_GLOBAL_MOTION_FLAG_IS_GLOBAL``
> +      - 0x00000001
> +      - Specifies whether global motion parameters are present for a particular
> +        reference frame.
> +    * - ``V4L2_AV1_GLOBAL_MOTION_FLAG_IS_ROT_ZOOM``
> +      - 0x00000002
> +      - Specifies whether a particular reference frame uses rotation and zoom
> +        global motion.
> +    * - ``V4L2_AV1_GLOBAL_MOTION_FLAG_IS_TRANSLATION``
> +      - 0x00000004
> +      - Specifies whether a particular reference frame uses rotation and zoom
> +        global motion.
> +
> +.. c:type:: v4l2_av1_frame_restoration_type
> +
> +AV1 Frame Restoration Type.
> +
> +.. raw:: latex
> +
> +    \scriptsize
> +
> +.. tabularcolumns:: |p{7.4cm}|p{0.3cm}|p{9.6cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_FRAME_RESTORE_NONE``
> +      - 0
> +      - No filtering is applied.
> +    * - ``V4L2_AV1_FRAME_RESTORE_WIENER``
> +      - 1
> +      - Wiener filter process is invoked.
> +    * - ``V4L2_AV1_FRAME_RESTORE_SGRPROJ``
> +      - 2
> +      - Self guided filter process is invoked.
> +    * - ``V4L2_AV1_FRAME_RESTORE_SWITCHABLE``
> +      - 3
> +      - Restoration filter is swichtable.
> +
> +.. c:type:: v4l2_av1_loop_restoration
> +
> +AV1 Loop Restauration as described in section 6.10.15 "Loop restoration params
> +semantics" of :ref:`av1`.
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{1.5cm}|p{5.8cm}|p{10.0cm}|
> +
> +.. flat-table:: struct v4l2_av1_loop_restoration
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - :c:type:`v4l2_av1_frame_restoration_type`
> +      - ``frame_restoration_type[V4L2_AV1_NUM_PLANES_MAX]``
> +      - Specifies the type of restoration used for each plane.
> +    * - __u8
> +      - ``lr_unit_shift``
> +      - Specifies if the luma restoration size should be halved.
> +    * - __u8
> +      - ``lr_uv_shift``
> +      - Specifies if the chroma size should be half the luma size.
> +    * - __u8
> +      - ``loop_restoration_size[V4L2_AV1_MAX_NUM_PLANES]``
> +      - specifies the size of loop restoration units in units of samples in the
> +        current plane.
> +
> +.. c:type:: v4l2_av1_cdef
> +
> +AV1 CDEF params semantics as described in section 6.10.14. "CDEF params
> +semantics" of :ref:`av1`.
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{1.5cm}|p{5.8cm}|p{10.0cm}|
> +
> +.. flat-table:: struct v4l2_av1_cdef
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``damping_minus_3``
> +      - Controls the amount of damping in the deringing filter.
> +    * - __u8
> +      - ``bits``
> +      - Specifies the number of bits needed to specify which CDEF filter to
> +        apply.
> +    * - __u8
> +      - ``y_pri_strength[V4L2_AV1_CDEF_MAX]``
> +      -  Specifies the strength of the primary filter.
> +    * - __u8
> +      - ``y_sec_strength[V4L2_AV1_CDEF_MAX]``
> +      -  Specifies the strength of the secondary filter.
> +    * - __u8
> +      - ``uv_pri_strength[V4L2_AV1_CDEF_MAX]``
> +      -  Specifies the strength of the primary filter.
> +    * - __u8
> +      - ``uv_secondary_strength[V4L2_AV1_CDEF_MAX]``
> +      -  Specifies the strength of the secondary filter.
> +
> +.. c:type:: v4l2_av1_segment_feature
> +
> +AV1 segment features as described in section 3 "Symbols and abbreviated terms"
> +of :ref:`av1`.
> +
> +.. raw:: latex
> +
> +    \scriptsize
> +
> +.. tabularcolumns:: |p{7.4cm}|p{0.3cm}|p{9.6cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_SEG_LVL_ALT_Q``
> +      - 0
> +      - Index for quantizer segment feature.
> +    * - ``V4L2_AV1_SEG_LVL_ALT_LF_Y_V``
> +      - 1
> +      - Index for vertical luma loop filter segment feature.
> +    * - ``V4L2_AV1_SEG_LVL_REF_FRAME``
> +      - 5
> +      - Index for reference frame segment feature.
> +    * - ``V4L2_AV1_SEG_LVL_REF_SKIP``
> +      - 6
> +      - Index for skip segment feature.
> +    * - ``V4L2_AV1_SEG_LVL_REF_GLOBALMV``
> +      - 7
> +      - Index for global mv feature.
> +    * - ``V4L2_AV1_SEG_LVL_MAX``
> +      - 8
> +      - Number of segment features.
> +
> +.. c:type:: v4l2_av1_segmentation
> +
> +AV1 Segmentation params as defined in section 6.8.13. "Segmentation params
> +semantics" of :ref:`av1`.
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{1.5cm}|p{5.8cm}|p{10.0cm}|
> +
> +.. flat-table:: struct v4l2_av1_film_grain
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``flags``
> +      - See :ref:`AV1 Segmentation Flags <av1_segmentation_flags>`
> +    * - __u8
> +      - ``feature_enabled[V4L2_AV1_MAX_SEGMENTS]``
> +      - Bitmask defining which features are enabled in each segment. Use
> +        V4L2_AV1_SEGMENT_FEATURE_ENABLED to build a suitable mask.
> +    * - __u16
> +      - `feature_data[V4L2_AV1_MAX_SEGMENTS][V4L2_AV1_SEG_LVL_MAX]``
> +      -  Data attached to each feature. Data entry is only valid if the feature
> +         is enabled
> +    * - __u8
> +      - ``last_active_seg_id``
> +      -  Indicates the highest numbered segment id that has some
> +         enabled feature. This is used when decoding the segment id to only decode
> +         choices corresponding to used segments.
> +
> +.. _av1_segmentation_flags:
> +
> +``AV1 Segmentation Flags``
> +
> +.. cssclass:: longtable
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_SEGMENTATION_FLAG_ENABLED``
> +      - 0x00000001
> +      - If set, indicates that this frame makes use of the segmentation tool. If
> +        not set, indicates that the frame does not use segmentation.
> +    * - ``V4L2_AV1_SEGMENTATION_FLAG_UPDATE_MAP``
> +      - 0x00000002
> +      - If set, indicates that the segmentation map are updated during the
> +        decoding of this frame. If not set, indicates that the segmentation map
> +        from the previous frame is used.
> +    * - ``V4L2_AV1_SEGMENTATION_FLAG_TEMPORAL_UPDATE``
> +      - 0x00000004
> +      - If set, indicates that the updates to the segmentation map are coded
> +        relative to the existing segmentation map. If not set, indicates that
> +        the new segmentation map is coded without reference to the existing
> +        segmentation map.
> +    * - ``V4L2_AV1_SEGMENTATION_FLAG_UPDATE_DATA``
> +      - 0x00000008
> +      - If set, indicates that the updates to the segmentation map are coded
> +        relative to the existing segmentation map. If not set, indicates that
> +        the new segmentation map is coded without reference to the existing
> +        segmentation map.
> +    * - ``V4L2_AV1_SEGMENTATION_FLAG_SEG_ID_PRE_SKIP``
> +      - 0x00000010
> +      - If set, indicates that the segment id will be read before the skip
> +        syntax element. If not set, indicates that the skip syntax element will
> +        be read first.
> +
> +.. c:type:: v4l2_av1_loop_filter
> +
> +AV1 Loop filter params as defined in section 6.8.10. "Loop filter semantics" of
> +:ref:`av1`.
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{1.5cm}|p{5.8cm}|p{10.0cm}|
> +
> +.. flat-table:: struct v4l2_av1_global_motion
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``flags``
> +      - See
> +        :ref:`AV1 Loop Filter flags <av1_loop_filter_flags>` for more details.
> +    * - __u8
> +      - ``level[4]``
> +      - an array containing loop filter strength values. Different loop
> +        filter strength values from the array are used depending on the image
> +        plane being filtered, and the edge direction (vertical or horizontal)
> +        being filtered.
> +    * - __u8
> +      - ``sharpness``
> +      - indicates the sharpness level. The loop_filter_level and
> +        loop_filter_sharpness together determine when a block edge is filtered,
> +        and by how much the filtering can change the sample values. The loop
> +        filter process is described in section 7.14 of :ref:`av1`.
> +    * - __u8
> +      - ``ref_deltas[V4L2_AV1_TOTAL_REFS_PER_FRAME]``

As per "5.9.11. Loop filter params syntax", this should be signed, so __s8. This
actually trigger a bug as it fails with the default values in validation.

  ref_deltas[N] < 63
  255 (aka -1) < 63

> +      - contains the adjustment needed for the filter level based on the
> +        chosen reference frame. If this syntax element is not present, it
> +        maintains its previous value.
> +    * - __u8
> +      - ``mode_deltas[2]``

Same here, should be __s8

> +      - contains the adjustment needed for the filter level based on
> +        the chosen mode. If this syntax element is not present, it maintains its
> +        previous value.
> +    * - __u8
> +      - ``delta_lf_res``
> +      - specifies the left shift which should be applied to decoded loop filter
> +        delta values.
> +    * - __u8
> +      - ``delta_lf_multi``
> +      - a value equal to 1 specifies that separate loop filter
> +        deltas are sent for horizontal luma edges, vertical luma edges, the U
> +        edges, and the V edges. A value of delta_lf_multi equal to 0 specifies
> +        that the same loop filter delta is used for all edges.
> +
> +.. _av1_loop_filter_flags:
> +
> +``AV1 Loop Filter Flags``
> +
> +.. cssclass:: longtable
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_LOOP_FILTER_FLAG_DELTA_ENABLED``
> +      - 0x00000001
> +      - If set, means that the filter level depends on the mode and reference
> +        frame used to predict a block. If not set, means that the filter level
> +        does not depend on the mode and reference frame.
> +    * - ``V4L2_AV1_LOOP_FILTER_FLAG_DELTA_UPDATE``
> +      - 0x00000002
> +      - If set, means that additional syntax elements are present that specify
> +        which mode and reference frame deltas are to be updated. If not set,
> +        means that these syntax elements are not present.
> +    * - ``V4L2_AV1_LOOP_FILTER_FLAG_DELTA_LF_PRESENT``
> +      - 0x00000004
> +      - Specifies whether loop filter delta values are present
> +
> +.. c:type:: v4l2_av1_quantization
> +
> +AV1 Quantization params as defined in section 6.8.11 "Quantization params
> +semantics" of :ref:`av1`.
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{1.5cm}|p{5.8cm}|p{10.0cm}|
> +
> +.. flat-table:: struct v4l2_av1_quantization
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``flags``
> +      - See
> +        :ref:`AV1 Loop Filter flags <av1_quantization_flags>` for more details.
> +    * - __u8
> +      - ``base_q_idx``
> +      - Indicates the base frame qindex. This is used for Y AC coefficients and
> +        as the base value for the other quantizers.
> +    * - __u8
> +      - ``delta_q_y_dc``
> +      - Indicates the Y DC quantizer relative to base_q_idx.
> +    * - __u8
> +      - ``delta_q_u_dc``
> +      - Indicates the U DC quantizer relative to base_q_idx.
> +    * - __u8
> +      - ``delta_q_u_ac``
> +      - Indicates the U AC quantizer relative to base_q_idx.
> +    * - __u8
> +      - ``delta_q_v_dc``
> +      - Indicates the V DC quantizer relative to base_q_idx.
> +    * - __u8
> +      - ``delta_q_v_dc``
> +      - Indicates the V DC quantizer relative to base_q_idx.
> +    * - __u8
> +      - ``qm_y``
> +      - Specifies the level in the quantizer matrix that should be used for
> +        luma plane decoding.
> +    * - __u8
> +      - ``qm_u``
> +      - Specifies the level in the quantizer matrix that should be used for
> +        chroma U plane decoding.
> +    * - __u8
> +      - ``qm_y``
> +      - Specifies the level in the quantizer matrix that should be used for
> +        chroma V plane decoding.
> +    * - __u8
> +      - ``delta_q_res``
> +      - Specifies the left shift which should be applied to decoded quantizer
> +        index delta values.
> +
> +.. _av1_quantization_flags:
> +
> +``AV1 Quantization Flags``
> +
> +.. cssclass:: longtable
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_QUANTIZATION_FLAG_DIFF_UV_DELTA``
> +      - 0x00000001
> +      - If set, indicates that the U and V delta quantizer values are coded
> +        separately. If not set, indicates that the U and V delta quantizer
> +        values share a common value.
> +    * - ``V4L2_AV1_QUANTIZATION_FLAG_USING_QMATRIX``
> +      - 0x00000002
> +      - If set, specifies that the quantizer matrix will be used to compute
> +        quantizers.
> +    * - ``V4L2_AV1_QUANTIZATION_FLAG_DELTA_Q_PRESENT``
> +      - 0x00000004
> +      - Specifies whether quantizer index delta values are present.
> +
> +.. c:type:: v4l2_av1_tile_info
> +
> +AV1 Tile info as defined in section 6.8.14. "Tile info semantics" of ref:`av1`.
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{1.5cm}|p{5.8cm}|p{10.0cm}|
> +
> +.. flat-table:: struct v4l2_av1_film_grain
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``flags``
> +      - See
> +        :ref:`AV1 Tile Info flags <av1_tile_info_flags>` for more details.
> +    * - __u32
> +      - ``mi_col_starts[V4L2_AV1_MAX_TILE_COLS + 1]``
> +      - An array specifying the start column (in units of 4x4 luma
> +        samples) for each tile across the image.
> +    * - __u32
> +      - ``mi_row_starts[V4L2_AV1_MAX_TILE_ROWS + 1]``
> +      - An array specifying the start row (in units of 4x4 luma
> +        samples) for each tile across the image.
> +    * - __u32
> +      - ``width_in_sbs_minus_1[V4L2_AV1_MAX_TILE_COLS]``
> +      - Specifies the width of a tile minus 1 in units of superblocks.
> +    * - __u32
> +      - ``height_in_sbs_minus_1[V4L2_AV1_MAX_TILE_ROWS]``
> +      - Specifies the height of a tile minus 1 in units of superblocks.
> +    * - __u8
> +      - ``tile_size_bytes``
> +      - Specifies the number of bytes needed to code each tile size.
> +    * - __u8
> +      - ``context_update_tile_id``
> +      - Specifies which tile to use for the CDF update.
> +    * - __u8
> +      - ``tile_rows``
> +      - Specifies the number of tiles down the frame.
> +    * - __u8
> +      - ``tile_rows``
> +      - Specifies the number of tiles across the frame.
> +
> +.. _av1_tile_info_flags:
> +
> +``AV1 Tile Info Flags``
> +
> +.. cssclass:: longtable
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_TILE_INFO_FLAG_UNIFORM_TILE_SPACING``
> +      - 0x00000001
> +      - If set, means that the tiles are uniformly spaced across the frame. (In
> +        other words, all tiles are the same size except for the ones at the
> +        right and bottom edge which can be smaller). If not set means that the
> +        tile sizes are coded.
> +
> +.. c:type:: v4l2_av1_frame_type
> +
> +AV1 Frame Type
> +
> +.. raw:: latex
> +
> +    \scriptsize
> +
> +.. tabularcolumns:: |p{7.4cm}|p{0.3cm}|p{9.6cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_KEY_FRAME``
> +      - 0
> +      - Key frame.
> +    * - ``V4L2_AV1_INTER_FRAME``
> +      - 1
> +      - Inter frame.
> +    * - ``V4L2_AV1_INTRA_ONLY_FRAME``
> +      - 2
> +      - Intra-only frame.
> +    * - ``V4L2_AV1_SWITCH_FRAME``
> +      - 3
> +      - Switch frame.
> +
> +.. c:type:: v4l2_av1_interpolation_filter
> +
> +AV1 Interpolation Filter
> +
> +.. raw:: latex
> +
> +    \scriptsize
> +
> +.. tabularcolumns:: |p{7.4cm}|p{0.3cm}|p{9.6cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP``
> +      - 0
> +      - Eight tap filter.
> +    * - ``V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP_SMOOTH``
> +      - 1
> +      - Eight tap smooth filter.
> +    * - ``V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP_SHARP``
> +      - 2
> +      - Eight tap sharp filter.
> +    * - ``V4L2_AV1_INTERPOLATION_FILTER_BILINEAR``
> +      - 3
> +      - Bilinear filter.
> +    * - ``V4L2_AV1_INTERPOLATION_FILTER_SWITCHABLE``
> +      - 4
> +      - Filter selection is signaled at the block level.
> +
> +.. c:type:: v4l2_av1_tx_mode
> +
> +AV1 Tx mode as described in section 6.8.21 "TX mode semantics" of :ref:`av1`.
> +
> +.. raw:: latex
> +
> +    \scriptsize
> +
> +.. tabularcolumns:: |p{7.4cm}|p{0.3cm}|p{9.6cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_TX_MODE_ONLY_4X4``
> +      - 0
> +      -  The inverse transform will use only 4x4 transforms.
> +    * - ``V4L2_AV1_TX_MODE_LARGEST``
> +      - 1
> +      - The inverse transform will use the largest transform size that fits
> +        inside the block.
> +    * - ``V4L2_AV1_TX_MODE_SELECT``
> +      - 2
> +      - The choice of transform size is specified explicitly for each block.
> +
> +``V4L2_CID_STATELESS_AV1_FRAME_HEADER (struct)``
> +    Represents a tile list entry as seen in an AV1 Tile List OBU. See section
> +    6.11.2. "Tile list entry semantics" of :ref:`av1` for more details.
> +
> +.. c:type:: v4l2_ctrl_av1_frame_header
> +
> +.. cssclass:: longtable
> +
> +.. tabularcolumns:: |p{5.8cm}|p{4.8cm}|p{6.6cm}|
> +
> +.. flat-table:: struct v4l2_ctrl_av1_frame_header
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - struct :c:type:`v4l2_av1_tile_info`
> +      - ``tile_info``
> +      - Tile info
> +    * - struct :c:type:`v4l2_av1_quantization`
> +      - ``quantization``
> +      - Quantization params
> +    * - struct :c:type:`v4l2_av1_segmentation`
> +      - ``segmentation``
> +      - Segmentation params
> +    * - struct :c:type:`v4l2_av1_loop_filter`
> +      - ``loop_filter``
> +      - Loop filter params
> +    * - struct :c:type:`v4l2_av1_cdef`
> +      - ``cdef``
> +      - CDEF params
> +    * - struct :c:type:`v4l2_av1_loop_restoration`
> +      - ``loop_restoration``
> +      - Loop restoration params
> +    * - struct :c:type:`v4l2_av1_loop_restoration`
> +      - ``loop_restoration``
> +      - Loop restoration params
> +    * - struct :c:type:`v4l2_av1_loop_global_motion`
> +      - ``global_motion``
> +      - Global motion params
> +    * - struct :c:type:`v4l2_av1_loop_film_grain`
> +      - ``film_grain``
> +      - Film grain params
> +    * - __u32
> +      - ``flags``
> +      - See
> +        :ref:`AV1 Tile Info flags <av1_frame_header_flags>` for more details.
> +    * - enum :c:type:`v4l2_av1_frame_type`
> +      - ``frame_type``
> +      - Specifies the AV1 frame type
> +    * - __u32
> +      - ``order_hint``
> +      - Specifies OrderHintBits least significant bits of the expected output
> +        order for this frame.
> +    * - __u8
> +      - ``superres_denom``
> +      - The denominator for the upscaling ratio.
> +    * - __u32
> +      - ``upscaled_width``
> +      - The upscaled width.
> +    * - enum :c:type:`v4l2_av1_interpolation_filter`
> +      - ``interpolation_filter``
> +      - Specifies the filter selection used for performing inter prediction.
> +    * - enum :c:type:`v4l2_av1_tx_mode`
> +      - ``tx_mode``
> +      - Specifies how the transform size is determined.
> +    * - __u32
> +      - ``frame_width_minus_1``
> +      - Add 1 to get the frame's width.
> +    * - __u32
> +      - ``frame_height_minus_1``
> +      - Add 1 to get the frame's height.
> +    * - __u16
> +      - ``render_width_minus_1``
> +      - Add 1 to get the render width of the frame in luma samples.
> +    * - __u16
> +      - ``render_height_minus_1``
> +      - Add 1 to get the render height of the frame in luma samples.
> +    * - __u32
> +      - ``current_frame_id``
> +      - Specifies the frame id number for the current frame. Frame
> +        id numbers are additional information that do not affect the decoding
> +        process, but provide decoders with a way of detecting missing reference
> +        frames so that appropriate action can be taken.
> +    * - __u8
> +      - ``primary_ref_frame``
> +      - Specifies which reference frame contains the CDF values and other state
> +        that should be loaded at the start of the frame..
> +    * - __u8
> +      - ``buffer_removal_time[V4L2_AV1_MAX_OPERATING_POINTS]``
> +      - Specifies the frame removal time in units of DecCT clock ticks counted
> +        from the removal time of the last random access point for operating point
> +        opNum.
> +    * - __u8
> +      - ``refresh_frame_flags[V4L2_AV1_MAX_OPERATING_POINTS]``
> +      - Contains a bitmask that specifies which reference frame slots will be
> +        updated with the current frame after it is decoded.
> +    * - __u32
> +      - ``ref_order_hint[V4L2_AV1_NUM_REF_FRAMES]``
> +      - Specifies the expected output order hint for each reference frame.
> +    * - __s8
> +      - ``last_frame_idx``
> +      - Specifies the reference frame to use for LAST_FRAME.
> +    * - __s8
> +      - ``gold_frame_idx``
> +      - Specifies the reference frame to use for GOLDEN_FRAME.
> +    * - __u64
> +      - ``reference_frame_ts[V4L2_AV1_NUM_REF_FRAMES]``
> +      - the V4L2 timestamp for each of the reference frames enumerated in
> +        enum :c:type:`v4l2_av1_reference_frame`. The timestamp refers to the
> +        ``timestamp`` field in struct :c:type:`v4l2_buffer`. Use the
> +        :c:func:`v4l2_timeval_to_ns()` function to convert the struct
> +        :c:type:`timeval` in struct :c:type:`v4l2_buffer` to a __u64.
> +    * - __u8
> +      - ``skip_mode_frame[2]``
> +      - Specifies the frames to use for compound prediction when skip_mode is
> +        equal to 1.
> +
> +.. _av1_frame_header_flags:
> +
> +``AV1 Frame Header Flags``
> +
> +.. cssclass:: longtable
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_SHOW_FRAME``
> +      - 0x00000001
> +      - If set, specifies that this frame should be immediately output once
> +        decoded. If not set, specifies that this frame should not be immediately
> +        output. (It may be output later if a later uncompressed header uses
> +        show_existing_frame equal to 1).
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_SHOWABLE_FRAME``
> +      - 0x00000002
> +      - If set, specifies that the frame may be output using the
> +        show_existing_frame mechanism. If not set, specifies that this frame
> +        will not be output using the show_existing_frame mechanism.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_ERROR_RESILIENT_MODE``
> +      - 0x00000004
> +      - Specifies whether error resilient mode is enabled.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_DISABLE_CDF_UPDATE``
> +      - 0x00000008
> +      - Specifies whether the CDF update in the symbol decoding process should
> +        be disabled.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_ALLOW_SCREEN_CONTENT_TOOLS``
> +      - 0x00000010
> +      - Specifies whether the CDF update in the symbol decoding process should
> +        be disabled.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_FORCE_INTEGER_MV``
> +      - 0x00000020
> +      - If set, specifies that motion vectors will always be integers. If not
> +        set, specifies that motion vectors can contain fractional bits.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_ALLOW_INTRABC``
> +      - 0x00000040
> +      - If set, indicates that intra block copy may be used in this frame. If
> +        not set, indicates that intra block copy is not allowed in this frame.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_USE_SUPERRES``
> +      - 0x00000080
> +      - If set, indicates that upscaling is needed.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_ALLOW_HIGH_PRECISION_MV``
> +      - 0x00000100
> +      - If set, specifies that motion vectors are specified to eighth pel
> +        precision. If not set, specifies that motion vectors are specified to
> +        quarter pel precision;
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_IS_MOTION_MODE_SWITCHABLE``
> +      - 0x00000200
> +      - If not set, specifies that only the SIMPLE motion mode will be used.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_USE_REF_FRAME_MVS``
> +      - 0x00000400
> +      - If set specifies that motion vector information from a previous frame
> +        can be used when decoding the current frame. If not set, specifies that
> +        this information will not be used.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_DISABLE_FRAME_END_UPDATE_CDF``
> +      - 0x00000800
> +      - If set indicates that the end of frame CDF update is disabled. If not
> +        set, indicates that the end of frame CDF update is enabled
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_UNIFORM_TILE_SPACING``
> +      - 0x00001000
> +      - If set, means that the tiles are uniformly spaced across the frame. (In
> +        other words, all tiles are the same size except for the ones at the
> +        right and bottom edge which can be smaller). If not set, means that the
> +        tile sizes are coded
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_ALLOW_WARPED_MOTION``
> +      - 0x00002000
> +      - If set, indicates that the syntax element motion_mode may be present, if
> +        not set, indicates that the syntax element motion_mode will not be
> +        present.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_REFERENCE_SELECT``
> +      - 0x00004000
> +      - If set, specifies that the mode info for inter blocks contains the
> +        syntax element comp_mode that indicates whether to use single or
> +        compound reference prediction. If not set, specifies that all inter
> +        blocks will use single prediction.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_REDUCED_TX_SET``
> +      - 0x00008000
> +      - If set, specifies that the frame is restricted to a reduced subset of
> +        the full set of transform types.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_SKIP_MODE_PRESENT``
> +      - 0x00010000
> +      - If set, specifies that the syntax element skip_mode will be present, if
> +        not set, specifies that skip_mode will not be used for this frame.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_FRAME_SIZE_OVERRIDE``
> +      - 0x00020000
> +      - If set, specifies that the frame size will either be specified as the
> +        size of one of the reference frames, or computed from the
> +        frame_width_minus_1 and frame_height_minus_1 syntax elements. If not
> +        set, specifies that the frame size is equal to the size in the sequence
> +        header.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_BUFFER_REMOVAL_TIME_PRESENT``
> +      - 0x00040000
> +      - If set, specifies that buffer_removal_time is present. If not set,
> +        specifies that buffer_removal_time is not present.
> +    * - ``V4L2_AV1_FRAME_HEADER_FLAG_FRAME_REFS_SHORT_SIGNALING``
> +      - 0x00080000
> +      - If set, indicates that only two reference frames are explicitly
> +        signaled. If not set, indicates that all reference frames are explicitly
> +        signaled.
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> index 0ede39907ee2..c1951e890d6f 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> @@ -223,6 +223,27 @@ Compressed Formats
>          through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
>  	See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
>  
> +    * .. _V4L2-PIX-FMT-AV1-FRAME:
> +
> +      - ``V4L2_PIX_FMT_AV1_FRAME``
> +      - 'AV1F'
> +      - AV1 parsed frame, including the frame header, as extracted from the container.
> +        This format is adapted for stateless video decoders that implement a AV1
> +        pipeline with the :ref:`stateless_decoder`. Metadata associated with the
> +        frame to decode is required to be passed through the
> +        ``V4L2_CID_STATELESS_AV1_SEQUENCE``, ``V4L2_CID_STATELESS_AV1_FRAME``,
> +        ``V4L2_CID_STATELESS_AV1_TILE_GROUP`` and
> +        ``V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY`` controls.
> +        ``V4L2_CID_STATELESS_AV1_TILE_LIST`` and
> +        ``V4L2_CID_STATELESS_AV1_TILE_LIST_ENTRY`` controls should be used if
> +        the decoder supports large scale tile decoding mode as signaled by the
> +        ``V4L2_CID_STATELESS_AV1_OPERATING_MODE`` control.
> +        See the :ref:`associated Codec Control IDs <v4l2-codec-stateless-av1>`.
> +        Exactly one output and one capture buffer must be provided for use with
> +        this pixel format. The output buffer must contain the appropriate number
> +        of macroblocks to decode a full corresponding frame to the matching
> +        capture buffer.
> +
>  .. raw:: latex
>  
>      \normalsize
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> index 2d6bc8d94380..50d4ed714123 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> @@ -233,6 +233,42 @@ still cause this situation.
>        - ``p_mpeg2_quantisation``
>        - A pointer to a struct :c:type:`v4l2_ctrl_mpeg2_quantisation`. Valid if this control is
>          of type ``V4L2_CTRL_TYPE_MPEG2_QUANTISATION``.
> +    * - struct :c:type:`v4l2_ctrl_av1_sequence` *
> +      - ``p_av1_sequence``
> +      - A pointer to a struct :c:type:`v4l2_ctrl_av1_sequence`. Valid if this control is
> +        of type ``V4L2_CTRL_TYPE_AV1_SEQUENCE``.
> +    * - struct :c:type:`v4l2_ctrl_av1_tile_group` *
> +      - ``p_av1_tile_group``
> +      - A pointer to a struct :c:type:`v4l2_ctrl_av1_tile_group`. Valid if this control is
> +        of type ``V4L2_CTRL_TYPE_AV1_TILE_GROUP``.
> +    * - struct :c:type:`v4l2_ctrl_av1_tile_group_entry` *
> +      - ``p_av1_tile_group_entry``
> +      - A pointer to a struct :c:type:`v4l2_ctrl_av1_tile_group_entry`. Valid if this control is
> +        of type ``V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY``.
> +    * - struct :c:type:`v4l2_ctrl_av1_tile_list` *
> +      - ``p_av1_tile_list``
> +      - A pointer to a struct :c:type:`v4l2_ctrl_av1_tile_list`. Valid if this control is
> +        of type ``V4L2_CTRL_TYPE_AV1_TILE_GROUP_LIST``.
> +    * - struct :c:type:`v4l2_ctrl_av1_tile_list_entry` *
> +      - ``p_av1_tile_list_entry``
> +      - A pointer to a struct :c:type:`v4l2_ctrl_av1_tile_list_entry`. Valid if this control is
> +        of type ``V4L2_CTRL_TYPE_AV1_TILE_GROUP_LIST_ENTRY``.
> +    * - struct :c:type:`v4l2_ctrl_av1_frame_header` *
> +      - ``p_av1_frame_header``
> +      - A pointer to a struct :c:type:`v4l2_ctrl_av1_frame_header`. Valid if this control is
> +        of type ``V4L2_CTRL_TYPE_AV1_FRAME_HEADER``.
> +    * - struct :c:type:`v4l2_ctrl_av1_profile` *
> +      - ``p_av1_profile``
> +      - A pointer to a struct :c:type:`v4l2_ctrl_av1_profile`. Valid if this control is
> +        of type ``V4L2_CTRL_TYPE_AV1_PROFILE``.
> +    * - struct :c:type:`v4l2_ctrl_av1_level` *
> +      - ``p_av1_level``
> +      - A pointer to a struct :c:type:`v4l2_ctrl_av1_level`. Valid if this control is
> +        of type ``V4L2_CTRL_TYPE_AV1_LEVEL``.
> +    * - struct :c:type:`v4l2_ctrl_av1_operating_mode` *
> +      - ``p_av1_operating_mode``
> +      - A pointer to a struct :c:type:`v4l2_ctrl_av1_operating_mode`. Valid if this control is
> +        of type ``V4L2_CTRL_TYPE_AV1_OPERATING_MODE``.
>      * - struct :c:type:`v4l2_ctrl_hdr10_cll_info` *
>        - ``p_hdr10_cll``
>        - A pointer to a struct :c:type:`v4l2_ctrl_hdr10_cll_info`. Valid if this control is
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> index 819a70a26e18..73ff5311b7ae 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> @@ -507,6 +507,60 @@ See also the examples in :ref:`control`.
>        - n/a
>        - A struct :c:type:`v4l2_ctrl_hevc_decode_params`, containing HEVC
>  	decoding parameters for stateless video decoders.
> +    * - ``V4L2_CTRL_TYPE_AV1_SEQUENCE``
> +      - n/a
> +      - n/a
> +      - n/a
> +      - A struct :c:type:`v4l2_ctrl_av1_sequence`, containing AV1 Sequence OBU
> +	decoding parameters for stateless video decoders.
> +    * - ``V4L2_CTRL_TYPE_AV1_TILE_GROUP``
> +      - n/a
> +      - n/a
> +      - n/a
> +      - A struct :c:type:`v4l2_ctrl_av1_tile_group`, containing AV1 Tile Group
> +	OBU decoding parameters for stateless video decoders.
> +    * - ``V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY``
> +      - n/a
> +      - n/a
> +      - n/a
> +      - A struct :c:type:`v4l2_ctrl_av1_tile_group`, containing AV1 Tile Group
> +	OBU decoding parameters for stateless video decoders.
> +    * - ``V4L2_CTRL_TYPE_AV1_TILE_LIST``
> +      - n/a
> +      - n/a
> +      - n/a
> +      - A struct :c:type:`v4l2_ctrl_av1_tile_list`, containing AV1 Tile List
> +	OBU decoding parameters for stateless video decoders.
> +    * - ``V4L2_CTRL_TYPE_AV1_TILE_LIST_ENTRY``
> +      - n/a
> +      - n/a
> +      - n/a
> +      - A struct :c:type:`v4l2_ctrl_av1_tile_list_entry`, containing AV1 Tile List
> +	OBU decoding parameters for stateless video decoders.
> +    * - ``V4L2_CTRL_TYPE_AV1_FRAME_HEADER``
> +      - n/a
> +      - n/a
> +      - n/a
> +      - A struct :c:type:`v4l2_ctrl_av1_frame_header`, containing AV1 Frame/Frame
> +	Header OBU decoding parameters for stateless video decoders.
> +    * - ``V4L2_CTRL_TYPE_AV1_PROFILE``
> +      - n/a
> +      - n/a
> +      - n/a
> +      - A enum :c:type:`v4l2_ctrl_av1_profile`, indicating what AV1 profiles
> +	an AV1 stateless decoder might support.
> +    * - ``V4L2_CTRL_TYPE_AV1_LEVEL``
> +      - n/a
> +      - n/a
> +      - n/a
> +      - A enum :c:type:`v4l2_ctrl_av1_level`, indicating what AV1 levels
> +	an AV1 stateless decoder might support.
> +    * - ``V4L2_CTRL_TYPE_AV1_OPERATING_MODE``
> +      - n/a
> +      - n/a
> +      - n/a
> +      - A enum :c:type:`v4l2_ctrl_av1_operating_mode`, indicating what AV1
> +	operating modes an AV1 stateless decoder might support.
>  
>  .. raw:: latex
>  
> diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> index 2217b56c2686..088d4014e4c5 100644
> --- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> +++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> @@ -146,6 +146,15 @@ replace symbol V4L2_CTRL_TYPE_H264_DECODE_PARAMS :c:type:`v4l2_ctrl_type`
>  replace symbol V4L2_CTRL_TYPE_HEVC_SPS :c:type:`v4l2_ctrl_type`
>  replace symbol V4L2_CTRL_TYPE_HEVC_PPS :c:type:`v4l2_ctrl_type`
>  replace symbol V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS :c:type:`v4l2_ctrl_type`
> +replace symbol V4L2_CTRL_TYPE_AV1_SEQUENCE :c:type:`v4l2_ctrl_type`
> +replace symbol V4L2_CTRL_TYPE_AV1_TILE_GROUP :c:type:`v4l2_ctrl_type`
> +replace symbol V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY :c:type:`v4l2_ctrl_type`
> +replace symbol V4L2_CTRL_TYPE_AV1_TILE_LIST :c:type:`v4l2_ctrl_type`
> +replace symbol V4L2_CTRL_TYPE_AV1_TILE_LIST_ENTRY :c:type:`v4l2_ctrl_type`
> +replace symbol V4L2_CTRL_TYPE_AV1_FRAME_HEADER :c:type:`v4l2_ctrl_type`
> +replace symbol V4L2_CTRL_TYPE_AV1_PROFILE :c:type:`v4l2_ctrl_type`
> +replace symbol V4L2_CTRL_TYPE_AV1_LEVEL :c:type:`v4l2_ctrl_type`
> +replace symbol V4L2_CTRL_TYPE_AV1_OPERATING_MODE :c:type:`v4l2_ctrl_type`
>  replace symbol V4L2_CTRL_TYPE_AREA :c:type:`v4l2_ctrl_type`
>  replace symbol V4L2_CTRL_TYPE_FWHT_PARAMS :c:type:`v4l2_ctrl_type`
>  replace symbol V4L2_CTRL_TYPE_VP8_FRAME :c:type:`v4l2_ctrl_type`
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> index e7ef2d16745e..3f0e425278b3 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> @@ -283,6 +283,25 @@ static void std_log(const struct v4l2_ctrl *ctrl)
>  	case V4L2_CTRL_TYPE_MPEG2_PICTURE:
>  		pr_cont("MPEG2_PICTURE");
>  		break;
> +	case V4L2_CTRL_TYPE_AV1_SEQUENCE:
> +		pr_cont("AV1_SEQUENCE");
> +		break;
> +	case V4L2_CTRL_TYPE_AV1_TILE_GROUP:
> +		pr_cont("AV1_TILE_GROUP");
> +		break;
> +	case V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY:
> +		pr_cont("AV1_TILE_GROUP_ENTRY");
> +		break;
> +	case V4L2_CTRL_TYPE_AV1_TILE_LIST:
> +		pr_cont("AV1_TILE_LIST");
> +		break;
> +	case V4L2_CTRL_TYPE_AV1_TILE_LIST_ENTRY:
> +		pr_cont("AV1_TILE_LIST_ENTRY");
> +		break;
> +	case V4L2_CTRL_TYPE_AV1_FRAME_HEADER:
> +		pr_cont("AV1_FRAME_HEADER");
> +		break;
> +
>  	default:
>  		pr_cont("unknown type %d", ctrl->type);
>  		break;
> @@ -317,6 +336,244 @@ static void std_log(const struct v4l2_ctrl *ctrl)
>  #define zero_reserved(s) \
>  	memset(&(s).reserved, 0, sizeof((s).reserved))
>  
> +static int validate_av1_quantization(struct v4l2_av1_quantization *q)
> +{
> +	if (q->flags > GENMASK(2, 0))
> +		return -EINVAL;
> +
> +	if (q->delta_q_y_dc < -63 || q->delta_q_y_dc > 63 ||
> +	    q->delta_q_u_dc < -63 || q->delta_q_u_dc > 63 ||
> +	    q->delta_q_v_dc < -63 || q->delta_q_v_dc > 63 ||
> +	    q->delta_q_u_ac < -63 || q->delta_q_u_ac > 63 ||
> +	    q->delta_q_v_ac < -63 || q->delta_q_v_ac > 63 ||
> +	    q->delta_q_res > GENMASK(1, 0))
> +		return -EINVAL;
> +
> +	if (q->qm_y > GENMASK(3, 0) ||
> +	    q->qm_u > GENMASK(3, 0) ||
> +	    q->qm_v > GENMASK(3, 0))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int validate_av1_segmentation(struct v4l2_av1_segmentation *s)
> +{
> +	u32 i;
> +	u32 j;
> +	s32 limit;
> +
> +	if (s->flags > GENMASK(3, 0))
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(s->feature_data); i++) {
> +		const int segmentation_feature_signed[] = { 1, 1, 1, 1, 1, 0, 0, 0 };
> +		const int segmentation_feature_max[] = { 255, 63, 63, 63, 63, 7, 0, 0};
> +
> +		for (j = 0; j < ARRAY_SIZE(s->feature_data[j]); j++) {
> +			if (segmentation_feature_signed[j]) {
> +				limit = segmentation_feature_max[j];
> +
> +				if (s->feature_data[i][j] < -limit ||
> +				    s->feature_data[i][j] > limit)
> +					return -EINVAL;
> +			} else {
> +				if (s->feature_data[i][j] > limit)
> +					return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int validate_av1_loop_filter(struct v4l2_av1_loop_filter *lf)
> +{
> +	u32 i;
> +
> +	if (lf->flags > GENMASK(2, 0))
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(lf->level); i++) {
> +		if (lf->level[i] > GENMASK(5, 0))
> +			return -EINVAL;
> +	}
> +
> +	if (lf->sharpness > GENMASK(2, 0))
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(lf->ref_deltas); i++) {
> +		if (lf->ref_deltas[i] < -63 || lf->ref_deltas[i] > 63)
> +			return -EINVAL;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(lf->mode_deltas); i++) {
> +		if (lf->mode_deltas[i] < -63 || lf->mode_deltas[i] > 63)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int validate_av1_cdef(struct v4l2_av1_cdef *cdef)
> +{
> +	u32 i;
> +
> +	if (cdef->damping_minus_3 > GENMASK(1, 0) ||
> +	    cdef->bits > GENMASK(1, 0))
> +		return -EINVAL;
> +
> +	for (i = 0; i < 1 << cdef->bits; i++) {
> +		if (cdef->y_pri_strength[i] > GENMASK(3, 0) ||
> +		    cdef->y_sec_strength[i] > 4 ||
> +		    cdef->uv_pri_strength[i] > GENMASK(3, 0) ||
> +		    cdef->uv_sec_strength[i] > 4)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int validate_av1_loop_restauration(struct v4l2_av1_loop_restoration *lr)
> +{
> +	if (lr->lr_unit_shift > 3 || lr->lr_uv_shift > 1)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int validate_av1_film_grain(struct v4l2_av1_film_grain *fg)
> +{
> +	u32 i;
> +
> +	if (fg->flags > GENMASK(4, 0))
> +		return -EINVAL;
> +
> +	if (fg->film_grain_params_ref_idx > GENMASK(2, 0) ||
> +	    fg->num_y_points > 14 ||
> +	    fg->num_cb_points > 10 ||
> +	    fg->num_cr_points > GENMASK(3, 0) ||
> +	    fg->grain_scaling_minus_8 > GENMASK(1, 0) ||
> +	    fg->ar_coeff_lag > GENMASK(1, 0) ||
> +	    fg->ar_coeff_shift_minus_6 > GENMASK(1, 0) ||
> +	    fg->grain_scale_shift > GENMASK(1, 0))
> +		return -EINVAL;
> +
> +	if (!(fg->flags & V4L2_AV1_FILM_GRAIN_FLAG_APPLY_GRAIN))
> +		return 0;
> +
> +	for (i = 1; i < ARRAY_SIZE(fg->point_y_value); i++)
> +		if (fg->point_y_value[i] <= fg->point_y_value[i - 1])
> +			return -EINVAL;
> +
> +	for (i = 1; i < ARRAY_SIZE(fg->point_cb_value); i++)
> +		if (fg->point_cb_value[i] <= fg->point_cb_value[i - 1])
> +			return -EINVAL;
> +
> +	for (i = 1; i < ARRAY_SIZE(fg->point_cr_value); i++)
> +		if (fg->point_cr_value[i] <= fg->point_cr_value[i - 1])
> +			return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int validate_av1_frame_header(struct v4l2_ctrl_av1_frame_header *f)
> +{
> +	int ret = 0;
> +
> +	ret = validate_av1_quantization(&f->quantization);
> +	if (ret)
> +		return ret;
> +	ret = validate_av1_segmentation(&f->segmentation);
> +	if (ret)
> +		return ret;
> +	ret = validate_av1_loop_filter(&f->loop_filter);
> +	if (ret)
> +		return ret;
> +	ret = validate_av1_cdef(&f->cdef);
> +	if (ret)
> +		return ret;
> +	ret = validate_av1_loop_restauration(&f->loop_restoration);
> +	if (ret)
> +		return ret;
> +	ret = validate_av1_film_grain(&f->film_grain);
> +	if (ret)
> +		return ret;
> +
> +	if (f->flags &
> +	~(V4L2_AV1_FRAME_HEADER_FLAG_SHOW_FRAME |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_SHOWABLE_FRAME |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_ERROR_RESILIENT_MODE |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_DISABLE_CDF_UPDATE |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_ALLOW_SCREEN_CONTENT_TOOLS |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_FORCE_INTEGER_MV |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_ALLOW_INTRABC |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_USE_SUPERRES |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_ALLOW_HIGH_PRECISION_MV |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_IS_MOTION_MODE_SWITCHABLE |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_USE_REF_FRAME_MVS |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_DISABLE_FRAME_END_UPDATE_CDF |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_UNIFORM_TILE_SPACING |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_ALLOW_WARPED_MOTION |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_REFERENCE_SELECT |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_REDUCED_TX_SET |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_FRAME_SIZE_OVERRIDE |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_BUFFER_REMOVAL_TIME_PRESENT |
> +	  V4L2_AV1_FRAME_HEADER_FLAG_FRAME_REFS_SHORT_SIGNALING))
> +		return -EINVAL;
> +
> +	if (f->superres_denom > GENMASK(2, 0) + 9)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int validate_av1_sequence(struct v4l2_ctrl_av1_sequence *s)
> +{
> +	if (s->flags &
> +	~(V4L2_AV1_SEQUENCE_FLAG_STILL_PICTURE |
> +	 V4L2_AV1_SEQUENCE_FLAG_USE_128X128_SUPERBLOCK |
> +	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_FILTER_INTRA |
> +	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTRA_EDGE_FILTER |
> +	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTERINTRA_COMPOUND |
> +	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND |
> +	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_WARPED_MOTION |
> +	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_DUAL_FILTER |
> +	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_ORDER_HINT |
> +	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_JNT_COMP |
> +	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_REF_FRAME_MVS |
> +	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_SUPERRES |
> +	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF |
> +	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_RESTORATION |
> +	 V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME |
> +	 V4L2_AV1_SEQUENCE_FLAG_COLOR_RANGE |
> +	 V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X |
> +	 V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y |
> +	 V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT |
> +	 V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q))
> +		return -EINVAL;
> +
> +	if (s->seq_profile == 1 && s->flags & V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME)
> +		return -EINVAL;
> +
> +	/* reserved */
> +	if (s->seq_profile > 2)
> +		return -EINVAL;
> +
> +	/* TODO: PROFILES */
> +	return 0;
> +}
> +
> +static int validate_av1_tile_group(struct v4l2_ctrl_av1_tile_group *t)
> +{
> +	if (t->flags & ~(V4L2_AV1_TILE_GROUP_FLAG_START_AND_END_PRESENT))
> +		return -EINVAL;
> +	if (t->tg_start > t->tg_end)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  /*
>   * Compound controls validation requires setting unused fields/flags to zero
>   * in order to properly detect unchanged controls with std_equal's memcmp.
> @@ -573,7 +830,16 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
>  		zero_padding(p_vp8_frame->entropy);
>  		zero_padding(p_vp8_frame->coder_state);
>  		break;
> -
> +	case V4L2_CTRL_TYPE_AV1_FRAME_HEADER:
> +		return validate_av1_frame_header(p);
> +	case V4L2_CTRL_TYPE_AV1_SEQUENCE:
> +		return validate_av1_sequence(p);
> +	case V4L2_CTRL_TYPE_AV1_TILE_GROUP:
> +		return validate_av1_tile_group(p);
> +	case V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY:
> +	case V4L2_CTRL_TYPE_AV1_TILE_LIST:
> +	case V4L2_CTRL_TYPE_AV1_TILE_LIST_ENTRY:
> +		break;
>  	case V4L2_CTRL_TYPE_HEVC_SPS:
>  		p_hevc_sps = p;
>  
> @@ -1313,6 +1579,24 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
>  	case V4L2_CTRL_TYPE_VP8_FRAME:
>  		elem_size = sizeof(struct v4l2_ctrl_vp8_frame);
>  		break;
> +	case V4L2_CTRL_TYPE_AV1_SEQUENCE:
> +		elem_size = sizeof(struct v4l2_ctrl_av1_sequence);
> +		break;
> +	case V4L2_CTRL_TYPE_AV1_TILE_GROUP:
> +		elem_size = sizeof(struct v4l2_ctrl_av1_tile_group);
> +		break;
> +	case V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY:
> +		elem_size = sizeof(struct v4l2_ctrl_av1_tile_group_entry);
> +		break;
> +	case V4L2_CTRL_TYPE_AV1_TILE_LIST:
> +		elem_size = sizeof(struct v4l2_ctrl_av1_tile_list);
> +		break;
> +	case V4L2_CTRL_TYPE_AV1_TILE_LIST_ENTRY:
> +		elem_size = sizeof(struct v4l2_ctrl_av1_tile_list_entry);
> +		break;
> +	case V4L2_CTRL_TYPE_AV1_FRAME_HEADER:
> +		elem_size = sizeof(struct v4l2_ctrl_av1_frame_header);
> +		break;
>  	case V4L2_CTRL_TYPE_HEVC_SPS:
>  		elem_size = sizeof(struct v4l2_ctrl_hevc_sps);
>  		break;
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index 421300e13a41..6f9b53f180cc 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -499,6 +499,45 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		NULL,
>  	};
>  
> +	static const char * const av1_profile[] = {
> +		"Main",
> +		"High",
> +		"Professional",
> +		NULL,
> +	};
> +	static const char * const av1_level[] = {
> +		"2.0",
> +		"2.1",
> +		"2.2",
> +		"2.3",
> +		"3.0",
> +		"3.1",
> +		"3.2",
> +		"3.3",
> +		"4.0",
> +		"4.1",
> +		"4.2",
> +		"4.3",
> +		"5.0",
> +		"5.1",
> +		"5.2",
> +		"5.3",
> +		"6.0",
> +		"6.1",
> +		"6.2",
> +		"6.3",
> +		"7.0",
> +		"7.1",
> +		"7.2",
> +		"7.3",
> +		NULL,
> +	};
> +	static const char * const av1_operating_mode[] = {
> +		"General decoding",
> +		"Large scale tile decoding",
> +		NULL,
> +	};
> +
>  	static const char * const hevc_profile[] = {
>  		"Main",
>  		"Main Still Picture",
> @@ -685,6 +724,12 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		return dv_it_content_type;
>  	case V4L2_CID_DETECT_MD_MODE:
>  		return detect_md_mode;
> +	case V4L2_CID_STATELESS_AV1_PROFILE:
> +		return av1_profile;
> +	case V4L2_CID_STATELESS_AV1_LEVEL:
> +		return av1_level;
> +	case V4L2_CID_STATELESS_AV1_OPERATING_MODE:
> +		return av1_operating_mode;
>  	case V4L2_CID_MPEG_VIDEO_HEVC_PROFILE:
>  		return hevc_profile;
>  	case V4L2_CID_MPEG_VIDEO_HEVC_LEVEL:
> @@ -1175,6 +1220,15 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_STATELESS_MPEG2_SEQUENCE:			return "MPEG-2 Sequence Header";
>  	case V4L2_CID_STATELESS_MPEG2_PICTURE:			return "MPEG-2 Picture Header";
>  	case V4L2_CID_STATELESS_MPEG2_QUANTISATION:		return "MPEG-2 Quantisation Matrices";
> +	case V4L2_CID_STATELESS_AV1_SEQUENCE:			return "AV1 Sequence parameters";
> +	case V4L2_CID_STATELESS_AV1_TILE_GROUP:		        return "AV1 Tile Group";
> +	case V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY:	        return "AV1 Tile Group Entry";
> +	case V4L2_CID_STATELESS_AV1_TILE_LIST:		        return "AV1 Tile List";
> +	case V4L2_CID_STATELESS_AV1_TILE_LIST_ENTRY:		return "AV1 Tile List Entry";
> +	case V4L2_CID_STATELESS_AV1_FRAME_HEADER:		return "AV1 Frame Header parameters";
> +	case V4L2_CID_STATELESS_AV1_PROFILE:			return "AV1 Profile";
> +	case V4L2_CID_STATELESS_AV1_LEVEL:			return "AV1 Level";
> +	case V4L2_CID_STATELESS_AV1_OPERATING_MODE:		return "AV1 Operating Mode";
>  
>  	/* Colorimetry controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
> @@ -1343,6 +1397,9 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
>  	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:
>  	case V4L2_CID_DETECT_MD_MODE:
> +	case V4L2_CID_STATELESS_AV1_PROFILE:
> +	case V4L2_CID_STATELESS_AV1_LEVEL:
> +	case V4L2_CID_STATELESS_AV1_OPERATING_MODE:
>  	case V4L2_CID_MPEG_VIDEO_HEVC_PROFILE:
>  	case V4L2_CID_MPEG_VIDEO_HEVC_LEVEL:
>  	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_TYPE:
> @@ -1481,6 +1538,28 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_STATELESS_VP8_FRAME:
>  		*type = V4L2_CTRL_TYPE_VP8_FRAME;
>  		break;
> +	case V4L2_CID_STATELESS_AV1_SEQUENCE:
> +		*type = V4L2_CTRL_TYPE_AV1_SEQUENCE;
> +		break;
> +	case V4L2_CID_STATELESS_AV1_TILE_GROUP:
> +		*type = V4L2_CTRL_TYPE_AV1_TILE_GROUP;
> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> +		break;
> +	case V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY:
> +		*type = V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY;
> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> +		break;
> +	case V4L2_CID_STATELESS_AV1_TILE_LIST:
> +		*type = V4L2_CTRL_TYPE_AV1_TILE_LIST;
> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> +		break;
> +	case V4L2_CID_STATELESS_AV1_TILE_LIST_ENTRY:
> +		*type = V4L2_CTRL_TYPE_AV1_TILE_LIST_ENTRY;
> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> +		break;
> +	case V4L2_CID_STATELESS_AV1_FRAME_HEADER:
> +		*type = V4L2_CTRL_TYPE_AV1_FRAME_HEADER;
> +		break;
>  	case V4L2_CID_MPEG_VIDEO_HEVC_SPS:
>  		*type = V4L2_CTRL_TYPE_HEVC_SPS;
>  		break;
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 05d5db3d85e5..135474c43b65 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1416,6 +1416,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
>  		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
>  		case V4L2_PIX_FMT_SUNXI_TILED_NV12: descr = "Sunxi Tiled NV12 Format"; break;
> +		case V4L2_PIX_FMT_AV1_FRAME: descr = "AV1 Frame"; break;
>  		default:
>  			if (fmt->description[0])
>  				return;
> diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
> index ebd9cef13309..5f8ba4fac92e 100644
> --- a/include/media/v4l2-ctrls.h
> +++ b/include/media/v4l2-ctrls.h
> @@ -56,6 +56,12 @@ struct video_device;
>   * @p_hdr10_cll:		Pointer to an HDR10 Content Light Level structure.
>   * @p_hdr10_mastering:		Pointer to an HDR10 Mastering Display structure.
>   * @p_area:			Pointer to an area.
> + * @p_av1_sequence:		Pointer to an AV1 sequence.
> + * @p_av1_tile_group:		Pointer to an AV1 tile group.
> + * @p_av1_tile_group_entry:	Pointer to an AV1 tile group entry.
> + * @p_av1_tile_list:		Pointer to an AV1 tile list.
> + * @p_av1_tile_list_entry:	Pointer to an AV1 tile list entry.
> + * @p_av1_frame_header:		Pointer to an AV1 frame header.
>   * @p:				Pointer to a compound value.
>   * @p_const:			Pointer to a constant compound value.
>   */
> @@ -83,6 +89,12 @@ union v4l2_ctrl_ptr {
>  	struct v4l2_ctrl_hdr10_cll_info *p_hdr10_cll;
>  	struct v4l2_ctrl_hdr10_mastering_display *p_hdr10_mastering;
>  	struct v4l2_area *p_area;
> +	struct v4l2_ctrl_av1_sequence *p_av1_sequence;
> +	struct v4l2_ctrl_av1_tile_group *p_av1_tile_group;
> +	struct v4l2_ctrl_av1_tile_group_entry *p_av1_tile_group_entry;
> +	struct v4l2_ctrl_av1_tile_list *p_av1_tile_list;
> +	struct v4l2_ctrl_av1_tile_list_entry *p_av1_tile_list_entry;
> +	struct v4l2_ctrl_av1_frame_header *p_av1_frame_header;
>  	void *p;
>  	const void *p_const;
>  };
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 5532b5f68493..0378fe8e1967 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -1976,6 +1976,802 @@ struct v4l2_ctrl_mpeg2_quantisation {
>  	__u8	chroma_non_intra_quantiser_matrix[64];
>  };
>  
> +/* Stateless AV1 controls */
> +
> +#define V4L2_AV1_TOTAL_REFS_PER_FRAME	8
> +#define V4L2_AV1_CDEF_MAX		8
> +#define V4L2_AV1_NUM_PLANES_MAX		3 /* 1 if monochrome, 3 otherwise */
> +#define V4L2_AV1_MAX_SEGMENTS		8
> +#define V4L2_AV1_MAX_OPERATING_POINTS	(1 << 5) /* 5 bits to encode */
> +#define V4L2_AV1_REFS_PER_FRAME		7
> +#define V4L2_AV1_MAX_NUM_Y_POINTS	(1 << 4) /* 4 bits to encode */
> +#define V4L2_AV1_MAX_NUM_CB_POINTS	(1 << 4) /* 4 bits to encode */
> +#define V4L2_AV1_MAX_NUM_CR_POINTS	(1 << 4) /* 4 bits to encode */
> +#define V4L2_AV1_MAX_NUM_POS_LUMA	25 /* (2 * 3 * (3 + 1)) + 1 */
> +#define V4L2_AV1_MAX_NUM_PLANES		3
> +#define V4L2_AV1_MAX_TILE_COLS		64
> +#define V4L2_AV1_MAX_TILE_ROWS		64
> +#define V4L2_AV1_MAX_TILE_COUNT		512
> +
> +#define V4L2_AV1_SEQUENCE_FLAG_STILL_PICTURE		  BIT(0)
> +#define V4L2_AV1_SEQUENCE_FLAG_USE_128X128_SUPERBLOCK	  BIT(1)
> +#define V4L2_AV1_SEQUENCE_FLAG_ENABLE_FILTER_INTRA	  BIT(2)
> +#define V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTRA_EDGE_FILTER   BIT(3)
> +#define V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTERINTRA_COMPOUND BIT(4)
> +#define V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND	  BIT(5)
> +#define V4L2_AV1_SEQUENCE_FLAG_ENABLE_WARPED_MOTION	  BIT(6)
> +#define V4L2_AV1_SEQUENCE_FLAG_ENABLE_DUAL_FILTER	  BIT(7)
> +#define V4L2_AV1_SEQUENCE_FLAG_ENABLE_ORDER_HINT	  BIT(8)
> +#define V4L2_AV1_SEQUENCE_FLAG_ENABLE_JNT_COMP		  BIT(9)
> +#define V4L2_AV1_SEQUENCE_FLAG_ENABLE_REF_FRAME_MVS	  BIT(10)
> +#define V4L2_AV1_SEQUENCE_FLAG_ENABLE_SUPERRES		  BIT(11)
> +#define V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF		  BIT(12)
> +#define V4L2_AV1_SEQUENCE_FLAG_ENABLE_RESTORATION	  BIT(13)
> +#define V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME		  BIT(14)
> +#define V4L2_AV1_SEQUENCE_FLAG_COLOR_RANGE		  BIT(15)
> +#define V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X		  BIT(16)
> +#define V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y		  BIT(17)
> +#define V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT  BIT(18)
> +#define V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q	  BIT(19)
> +
> +#define V4L2_CID_STATELESS_AV1_SEQUENCE (V4L2_CID_CODEC_STATELESS_BASE + 401)
> +/**
> + * struct v4l2_ctrl_av1_sequence - AV1 Sequence
> + *
> + * Represents an AV1 Sequence OBU. See section 5.5. "Sequence header OBU syntax"
> + * for more details.
> + *
> + * @flags: See V4L2_AV1_SEQUENCE_FLAG_{}.
> + * @seq_profile: specifies the features that can be used in the coded video
> + * sequence.
> + * @order_hint_bits: specifies the number of bits used for the order_hint field
> + * at each frame.
> + * @bit_depth: the bitdepth to use for the sequence as described in section
> + * 5.5.2 "Color config syntax".
> + */
> +struct v4l2_ctrl_av1_sequence {
> +	__u32 flags;
> +	__u8 seq_profile;
> +	__u8 order_hint_bits;
> +	__u8 bit_depth;
> +};
> +
> +#define V4L2_AV1_TILE_GROUP_FLAG_START_AND_END_PRESENT BIT(0)
> +
> +#define V4L2_CID_STATELESS_AV1_TILE_GROUP (V4L2_CID_CODEC_STATELESS_BASE + 402)
> +/**
> + * struct v4l2_ctrl_av1_tile_group - AV1 Tile Group header.
> + *
> + * Represents a tile group as seen in an AV1 Tile Group OBU or Frame OBU. A
> + * v4l2_ctrl_av1_tile_group instance will refer to tg_end - tg_start instances
> + * of v4l2_ctrl_tile_group_entry. See section 6.10.1 "General tile group OBU
> + * semantics" for more details.
> + *
> + * @flags: see V4L2_AV1_TILE_GROUP_FLAG_{}.
> + * @tg_start: specifies the zero-based index of the first tile in the current
> + * tile group.
> + * @tg_end: specifies the zero-based index of the last tile in the current tile
> + * group.
> + */
> +struct v4l2_ctrl_av1_tile_group {
> +	__u8 flags;
> +	__u32 tg_start;
> +	__u32 tg_end;
> +};
> +
> +#define V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY (V4L2_CID_CODEC_STATELESS_BASE + 403)
> +/**
> + * struct v4l2_ctrl_av1_tile_group_entry - AV1 Tile Group entry
> + *
> + * Represents a single AV1 tile inside an AV1 Tile Group. Note that MiRowStart,
> + * MiRowEnd, MiColStart and MiColEnd can be retrieved from struct
> + * v4l2_av1_tile_info in struct v4l2_ctrl_av1_frame_header using tile_row and
> + * tile_col. See section 6.10.1 "General tile group OBU semantics" for more
> + * details.
> + *
> + * @tile_offset: offset from the OBU data, i.e. where the coded tile data
> + * actually starts.
> + * @tile_size: specifies the size in bytes of the coded tile. Equivalent to
> + * "TileSize" in the AV1 Specification.
> + * @tile_row: specifies the row of the current tile. Equivalent to "TileRow" in
> + * the AV1 Specification.
> + * @tile_col: specifies the col of the current tile. Equivalent to "TileCol" in
> + * the AV1 Specification.
> + */
> +struct v4l2_ctrl_av1_tile_group_entry {
> +	__u32 tile_offset;
> +	__u32 tile_size;
> +	__u32 tile_row;
> +	__u32 tile_col;
> +};
> +
> +#define V4L2_CID_STATELESS_AV1_TILE_LIST (V4L2_CID_CODEC_STATELESS_BASE + 404)
> +/**
> + * struct v4l2_ctrl_av1_tile_list - AV1 Tile List header.
> + *
> + * Represents a tile list as seen in an AV1 Tile List OBU. Tile lists are used
> + * in "Large Scale Tile Decode Mode". Note that tile_count_minus_1 should be at
> + * most V4L2_AV1_MAX_TILE_COUNT - 1. A struct v4l2_ctrl_av1_tile_list instance
> + * will refer to "tile_count_minus_1" + 1 instances of struct
> + * v4l2_ctrl_av1_tile_list_entry.
> + *
> + * Each rendered frame may require at most two tile list OBU to be decodded. See
> + * section "6.11.1. General tile list OBU semantics" for more details.
> + *
> + * @output_frame_width_in_tiles_minus_1: this field plus one is the width of the
> + * output frame, in tile units.
> + * @output_frame_height_in_tiles_minus_1: this field plus one is the height of
> + * the output frame, in tile units.
> + * @tile_count_minus_1: this field plus one is the number of tile_list_entry in
> + * the list.
> + */
> +struct v4l2_ctrl_av1_tile_list {
> +	__u8 output_frame_width_in_tiles_minus_1;
> +	__u8 output_frame_height_in_tiles_minus_1;
> +	__u8 tile_count_minus_1;
> +};
> +
> +#define V4L2_CID_STATELESS_AV1_TILE_LIST_ENTRY (V4L2_CID_CODEC_STATELESS_BASE + 405)
> +
> +/**
> + * struct v4l2_ctrl_av1_tile_list_entry - AV1 Tile List entry
> + *
> + * Represents a tile list entry as seen in an AV1 Tile List OBU. See section
> + * 6.11.2. "Tile list entry semantics" of the AV1 Specification for more
> + * details.
> + *
> + * @anchor_frame_idx: the index into an array AnchorFrames of the frames that
> + * the tile uses for prediction.
> + * @anchor_tile_row: the row coordinate of the tile in the frame that it
> + * belongs, in tile units.
> + * @anchor_tile_col: the column coordinate of the tile in the frame that it
> + * belongs, in tile units.
> + * @tile_data_size_minus_1: this field plus one is the size of the coded tile
> + * data in bytes.
> + */
> +struct v4l2_ctrl_av1_tile_list_entry {
> +	__u8 anchor_frame_idx;
> +	__u8 anchor_tile_row;
> +	__u8 anchor_tile_col;
> +	__u8 tile_data_size_minus_1;
> +};
> +
> +#define V4L2_AV1_FILM_GRAIN_FLAG_APPLY_GRAIN BIT(0)
> +#define V4L2_AV1_FILM_GRAIN_FLAG_UPDATE_GRAIN BIT(1)
> +#define V4L2_AV1_FILM_GRAIN_FLAG_CHROMA_SCALING_FROM_LUMA BIT(2)
> +#define V4L2_AV1_FILM_GRAIN_FLAG_OVERLAP BIT(3)
> +#define V4L2_AV1_FILM_GRAIN_FLAG_CLIP_TO_RESTRICTED_RANGE BIT(4)
> +
> +/**
> + * struct v4l2_av1_film_grain - AV1 Film Grain parameters.
> + *
> + * Film grain parameters as specified by section 6.8.20 of the AV1
> +   Specification.
> + *
> + * @flags: see V4L2_AV1_FILM_GRAIN_{}.
> + * @grain_seed: specifies the starting value for the pseudo-random numbers used
> + * during film grain synthesis.
> + * @film_grain_params_ref_idx: indicates which reference frame contains the
> + * film grain parameters to be used for this frame.
> + * @num_y_points: specifies the number of points for the piece-wise linear
> + * scaling function of the luma component.
> + * @point_y_value: represents the x (luma value) coordinate for the i-th point
> + * of the piecewise linear scaling function for luma component. The values are
> + * signaled on the scale of 0..255. (In case of 10 bit video, these values
> + * correspond to luma values divided by 4. In case of 12 bit video, these values
> + * correspond to luma values divided by 16.).
> + * @point_y_scaling:  represents the scaling (output) value for the i-th point
> + * of the piecewise linear scaling function for luma component.
> + * @num_cb_points: specifies the number of points for the piece-wise linear
> + * scaling function of the cb component.
> + * @point_cb_value: represents the x coordinate for the i-th point of the
> + * piece-wise linear scaling function for cb component. The values are signaled
> + * on the scale of 0..255.
> + * @point_cb_scaling: represents the scaling (output) value for the i-th point
> + * of the piecewise linear scaling function for cb component.
> + * @num_cr_points: specifies represents the number of points for the piece-wise
> + * linear scaling function of the cr component.
> + * @point_cr_value:  represents the x coordinate for the i-th point of the
> + * piece-wise linear scaling function for cr component. The values are signaled
> + * on the scale of 0..255.
> + * @point_cr_scaling:  represents the scaling (output) value for the i-th point
> + * of the piecewise linear scaling function for cr component.
> + * @grain_scaling_minus_8: represents the shift – 8 applied to the values of the
> + * chroma component. The grain_scaling_minus_8 can take values of 0..3 and
> + * determines the range and quantization step of the standard deviation of film
> + * grain.
> + * @ar_coeff_lag: specifies the number of auto-regressive coefficients for luma
> + * and chroma.
> + * @ar_coeffs_y_plus_128: specifies auto-regressive coefficients used for the Y
> + * plane.
> + * @ar_coeffs_cb_plus_128: specifies auto-regressive coefficients used for the U
> + * plane.
> + * @ar_coeffs_cr_plus_128: specifies auto-regressive coefficients used for the V
> + * plane.
> + * @ar_coeff_shift_minus_6: specifies the range of the auto-regressive
> + * coefficients. Values of 0, 1, 2, and 3 correspond to the ranges for
> + * auto-regressive coefficients of [-2, 2), [-1, 1), [-0.5, 0.5) and [-0.25,
> + * 0.25) respectively.
> + * @grain_scale_shift: specifies how much the Gaussian random numbers should be
> + * scaled down during the grain synthesis process.
> + * @cb_mult: represents a multiplier for the cb component used in derivation of
> + * the input index to the cb component scaling function.
> + * @cb_luma_mult: represents a multiplier for the average luma component used in
> + * derivation of the input index to the cb component scaling function.
> + * @cb_offset: represents an offset used in derivation of the input index to the
> + * cb component scaling function.
> + * @cr_mult: represents a multiplier for the cr component used in derivation of
> + * the input index to the cr component scaling function.
> + * @cr_luma_mult: represents a multiplier for the average luma component used in
> + * derivation of the input index to the cr component scaling function.
> + * @cr_offset: represents an offset used in derivation of the input index to the
> + * cr component scaling function.
> + */
> +struct v4l2_av1_film_grain {
> +	__u8 flags;
> +	__u16 grain_seed;
> +	__u8 film_grain_params_ref_idx;
> +	__u8 num_y_points;
> +	__u8 point_y_value[V4L2_AV1_MAX_NUM_Y_POINTS];
> +	__u8 point_y_scaling[V4L2_AV1_MAX_NUM_Y_POINTS];
> +	__u8 num_cb_points;
> +	__u8 point_cb_value[V4L2_AV1_MAX_NUM_CB_POINTS];
> +	__u8 point_cb_scaling[V4L2_AV1_MAX_NUM_CB_POINTS];
> +	__u8 num_cr_points;
> +	__u8 point_cr_value[V4L2_AV1_MAX_NUM_CR_POINTS];
> +	__u8 point_cr_scaling[V4L2_AV1_MAX_NUM_CR_POINTS];
> +	__u8 grain_scaling_minus_8;
> +	__u8 ar_coeff_lag;
> +	__u8 ar_coeffs_y_plus_128[V4L2_AV1_MAX_NUM_POS_LUMA];
> +	__u8 ar_coeffs_cb_plus_128[V4L2_AV1_MAX_NUM_POS_LUMA];
> +	__u8 ar_coeffs_cr_plus_128[V4L2_AV1_MAX_NUM_POS_LUMA];
> +	__u8 ar_coeff_shift_minus_6;
> +	__u8 grain_scale_shift;
> +	__u8 cb_mult;
> +	__u8 cb_luma_mult;
> +	__u16 cb_offset;
> +	__u8 cr_mult;
> +	__u8 cr_luma_mult;
> +	__u16 cr_offset;
> +};
> +
> +/**
> + * enum v4l2_av1_warp_model - AV1 Warp Model as described in section 3
> + * "Symbols and abbreviated terms" of the AV1 Specification.
> + *
> + * @V4L2_AV1_WARP_MODEL_IDENTITY: Warp model is just an identity transform.
> + * @V4L2_AV1_WARP_MODEL_TRANSLATION: Warp model is a pure translation.
> + * @V4L2_AV1_WARP_MODEL_ROTZOOM: Warp model is a rotation + symmetric zoom +
> + * translation.
> + * @V4L2_AV1_WARP_MODEL_AFFINE: Warp model is a general affine transform.
> + */
> +enum v4l2_av1_warp_model {
> +	V4L2_AV1_WARP_MODEL_IDENTITY = 0,
> +	V4L2_AV1_WARP_MODEL_TRANSLATION = 1,
> +	V4L2_AV1_WARP_MODEL_ROTZOOM = 2,
> +	V4L2_AV1_WARP_MODEL_AFFINE = 3,
> +};
> +
> +/**
> + * enum v4l2_av1_reference_frame - AV1 reference frames
> + *
> + * @V4L2_AV1_REF_INTRA_FRAME: Intra Frame Reference
> + * @V4L2_AV1_REF_LAST_FRAME: Last Reference Frame
> + * @V4L2_AV1_REF_LAST2_FRAME: Last2 Reference Frame
> + * @V4L2_AV1_REF_LAST3_FRAME: Last3 Reference Frame
> + * @V4L2_AV1_REF_GOLDEN_FRAME: Golden Reference Frame
> + * @V4L2_AV1_REF_BWDREF_FRAME: BWD Reference Frame
> + * @V4L2_AV1_REF_ALTREF2_FRAME: Alternative2 Reference Frame
> + * @V4L2_AV1_REF_ALTREF_FRAME: Alternative Reference Frame
> + * @V4L2_AV1_NUM_REF_FRAMES: Total Reference Frame Number
> + */
> +enum v4l2_av1_reference_frame {
> +	V4L2_AV1_REF_INTRA_FRAME = 0,
> +	V4L2_AV1_REF_LAST_FRAME = 1,
> +	V4L2_AV1_REF_LAST2_FRAME = 2,
> +	V4L2_AV1_REF_LAST3_FRAME = 3,
> +	V4L2_AV1_REF_GOLDEN_FRAME = 4,
> +	V4L2_AV1_REF_BWDREF_FRAME = 5,
> +	V4L2_AV1_REF_ALTREF2_FRAME = 6,
> +	V4L2_AV1_REF_ALTREF_FRAME = 7,
> +	V4L2_AV1_NUM_REF_FRAMES,
> +};
> +
> +#define V4L2_AV1_GLOBAL_MOTION_IS_INVALID(ref) (1 << (ref))
> +
> +#define V4L2_AV1_GLOBAL_MOTION_FLAG_IS_GLOBAL	   BIT(0)
> +#define V4L2_AV1_GLOBAL_MOTION_FLAG_IS_ROT_ZOOM	   BIT(1)
> +#define V4L2_AV1_GLOBAL_MOTION_FLAG_IS_TRANSLATION BIT(2)
> +/**
> + * struct v4l2_av1_global_motion - AV1 Global Motion parameters as described in
> + * section 6.8.17 "Global motion params semantics" of the AV1 specification.
> + *
> + * @flags: A bitfield containing the flags per reference frame. See
> + * V4L2_AV1_GLOBAL_MOTION_FLAG_{}
> + * @type: The type of global motion transform used.
> + * @params: this field has the same meaning as "gm_params" in the AV1
> + * specification.
> + * @invalid: bitfield indicating whether the global motion params are invalid
> + * for a given reference frame. See section 7.11.3.6. Setup shear process and
> + * the variable "warpValid". Use V4L2_AV1_GLOBAL_MOTION_IS_INVALID(ref) to
> + * create a suitable mask.
> + */
> +
> +struct v4l2_av1_global_motion {
> +	__u8 flags[V4L2_AV1_TOTAL_REFS_PER_FRAME];
> +	enum v4l2_av1_warp_model type[V4L2_AV1_TOTAL_REFS_PER_FRAME];
> +	__u32 params[V4L2_AV1_TOTAL_REFS_PER_FRAME][6];
> +	__u8 invalid;
> +};
> +
> +/**
> + * enum v4l2_av1_frame_restoration_type - AV1 Frame Restoration Type
> + * @V4L2_AV1_FRAME_RESTORE_NONE: no filtering is applied.
> + * @V4L2_AV1_FRAME_RESTORE_WIENER: Wiener filter process is invoked.
> + * @V4L2_AV1_FRAME_RESTORE_SGRPROJ: self guided filter process is invoked.
> + * @V4L2_AV1_FRAME_RESTORE_SWITCHABLE: restoration filter is swichtable.
> + */
> +enum v4l2_av1_frame_restoration_type {
> +	V4L2_AV1_FRAME_RESTORE_NONE = 0,
> +	V4L2_AV1_FRAME_RESTORE_WIENER = 1,
> +	V4L2_AV1_FRAME_RESTORE_SGRPROJ = 2,
> +	V4L2_AV1_FRAME_RESTORE_SWITCHABLE = 3,
> +};
> +
> +/**
> + * struct v4l2_av1_loop_restoration - AV1 Loop Restauration as described in
> + * section 6.10.15 "Loop restoration params semantics" of the AV1 specification.
> + *
> + * @frame_restoration_type: specifies the type of restoration used for each
> + * plane. See enum_v4l2_av1_frame_restoration_type.
> + * @lr_unit_shift: specifies if the luma restoration size should be halved.
> + * @lr_uv_shift: specifies if the chroma size should be half the luma size.
> + * @loop_restoration_size: specifies the size of loop restoration units in units
> + * of samples in the current plane.
> + */
> +struct v4l2_av1_loop_restoration {
> +	enum v4l2_av1_frame_restoration_type frame_restoration_type[V4L2_AV1_NUM_PLANES_MAX];
> +	__u8 lr_unit_shift;
> +	__u8 lr_uv_shift;
> +	__u32 loop_restoration_size[V4L2_AV1_MAX_NUM_PLANES];
> +};
> +
> +/**
> + * struct v4l2_av1_cdef - AV1 CDEF params semantics as described in section
> + * 6.10.14. "CDEF params semantics" of the AV1 specification
> + *
> + * @damping_minus_3: controls the amount of damping in the deringing filter.
> + * @bits: specifies the number of bits needed to specify which CDEF filter to
> + * apply.
> + * @y_pri_strength: specifies the strength of the primary filter.
> + * @y_sec_strength: specifies the strength of the secondary filter.
> + * @uv_pri_strength: specifies the strength of the primary filter.
> + * @uv_sec_strength: specifies the strength of the secondary filter.
> + */
> +struct v4l2_av1_cdef {
> +	__u8 damping_minus_3;
> +	__u8 bits;
> +	__u8 y_pri_strength[V4L2_AV1_CDEF_MAX];
> +	__u8 y_sec_strength[V4L2_AV1_CDEF_MAX];
> +	__u8 uv_pri_strength[V4L2_AV1_CDEF_MAX];
> +	__u8 uv_sec_strength[V4L2_AV1_CDEF_MAX];
> +};
> +
> +#define V4L2_AV1_SEGMENTATION_FLAG_ENABLED	   BIT(0)
> +#define V4L2_AV1_SEGMENTATION_FLAG_UPDATE_MAP	   BIT(1)
> +#define V4L2_AV1_SEGMENTATION_FLAG_TEMPORAL_UPDATE BIT(2)
> +#define V4L2_AV1_SEGMENTATION_FLAG_UPDATE_DATA	   BIT(3)
> +#define V4L2_AV1_SEGMENTATION_FLAG_SEG_ID_PRE_SKIP	BIT(4)
> +
> +/**
> + * enum v4l2_av1_segment_feature - AV1 segment features as described in section
> + * 3 "Symbols and abbreviated terms" of the AV1 specification.
> + *
> + * @V4L2_AV1_SEG_LVL_ALT_Q: Index for quantizer segment feature.
> + * @V4L2_AV1_SEG_LVL_ALT_LF_Y_V: Index for vertical luma loop filter segment
> + * feature.
> + * @V4L2_AV1_SEG_LVL_REF_FRAME: Index for reference frame segment feature.
> + * @V4L2_AV1_SEG_LVL_SKIP: Index for skip segment feature.
> + * @V4L2_AV1_SEG_LVL_GLOBALMV: Index for global mv feature.
> + * @V4L2_AV1_SEG_LVL_MAX: Number of segment features.
> + */
> +enum v4l2_av1_segment_feature {
> +	V4L2_AV1_SEG_LVL_ALT_Q = 0,
> +	V4L2_AV1_SEG_LVL_ALT_LF_Y_V = 1,
> +	V4L2_AV1_SEG_LVL_REF_FRAME = 5,
> +	V4L2_AV1_SEG_LVL_REF_SKIP = 6,
> +	V4L2_AV1_SEG_LVL_REF_GLOBALMV = 7,
> +	V4L2_AV1_SEG_LVL_MAX = 8
> +};
> +
> +#define V4L2_AV1_SEGMENT_FEATURE_ENABLED(id)	(1 << (id))
> +
> +/**
> + * struct v4l2_av1_segmentation - AV1 Segmentation params as defined in section
> + * 6.8.13. "Segmentation params semantics" of the AV1 specification.
> + *
> + * @flags: see V4L2_AV1_SEGMENTATION_FLAG_{}.
> + * @feature_enabled: bitmask defining which features are enabled in each segment.
> + * Use V4L2_AV1_SEGMENT_FEATURE_ENABLED to build a suitable mask.
> + * @feature_data: data attached to each feature. Data entry is only valid if the
> + * feature is enabled
> + * @last_active_seg_id: indicates the highest numbered segment id that has some
> + * enabled feature. This is used when decoding the segment id to only decode
> + * choices corresponding to used segments.
> + */
> +struct v4l2_av1_segmentation {
> +	__u8 flags;
> +	__u8 feature_enabled[V4L2_AV1_MAX_SEGMENTS];
> +	__u16 feature_data[V4L2_AV1_MAX_SEGMENTS][V4L2_AV1_SEG_LVL_MAX];
> +	__u8 last_active_seg_id;
> +};
> +
> +#define V4L2_AV1_LOOP_FILTER_FLAG_DELTA_ENABLED    BIT(0)
> +#define V4L2_AV1_LOOP_FILTER_FLAG_DELTA_UPDATE     BIT(1)
> +#define V4L2_AV1_LOOP_FILTER_FLAG_DELTA_LF_PRESENT BIT(2)
> +
> +/**
> + * struct v4l2_av1_loop_filter - AV1 Loop filter params as defined in section
> + * 6.8.10. "Loop filter semantics" of the AV1 specification.
> + *
> + * @flags: see V4L2_AV1_LOOP_FILTER_FLAG_{}
> + * @level: an array containing loop filter strength values. Different loop
> + * filter strength values from the array are used depending on the image plane
> + * being filtered, and the edge direction (vertical or horizontal) being
> + * filtered.
> + * @sharpness: indicates the sharpness level. The loop_filter_level and
> + * loop_filter_sharpness together determine when a block edge is filtered, and
> + * by how much the filtering can change the sample values. The loop filter
> + * process is described in section 7.14 of the AV1 specification.
> + * @ref_deltas: contains the adjustment needed for the filter level based on the
> + * chosen reference frame. If this syntax element is not present, it maintains
> + * its previous value.
> + * @mode_deltas: contains the adjustment needed for the filter level based on
> + * the chosen mode. If this syntax element is not present, it maintains its
> + * previous value.
> + * @delta_lf_res: specifies the left shift which should be applied to decoded
> + * loop filter delta values.
> + * @delta_lf_multi: a value equal to 1 specifies that separate loop filter
> + * deltas are sent for horizontal luma edges, vertical luma edges,
> + * the U edges, and the V edges. A value of delta_lf_multi equal to 0 specifies
> + * that the same loop filter delta is used for all edges.
> + */
> +struct v4l2_av1_loop_filter {
> +	__u8 flags;
> +	__u8 level[4];
> +	__u8 sharpness;
> +	__u8 ref_deltas[V4L2_AV1_TOTAL_REFS_PER_FRAME];
> +	__u8 mode_deltas[2];
> +	__u8 delta_lf_res;
> +	__u8 delta_lf_multi;
> +};
> +
> +#define V4L2_AV1_QUANTIZATION_FLAG_DIFF_UV_DELTA   BIT(0)
> +#define V4L2_AV1_QUANTIZATION_FLAG_USING_QMATRIX   BIT(1)
> +#define V4L2_AV1_QUANTIZATION_FLAG_DELTA_Q_PRESENT BIT(2)
> +
> +/**
> + * struct v4l2_av1_quantization - AV1 Quantization params as defined in section
> + * 6.8.11 "Quantization params semantics" of the AV1 specification.
> + *
> + * @flags: see V4L2_AV1_QUANTIZATION_FLAG_{}
> + * @base_q_idx: indicates the base frame qindex. This is used for Y AC
> + * coefficients and as the base value for the other quantizers.
> + * @delta_q_y_dc: indicates the Y DC quantizer relative to base_q_idx.
> + * @delta_q_u_dc: indicates the U DC quantizer relative to base_q_idx.
> + * @delta_q_u_ac: indicates the U AC quantizer relative to base_q_idx.
> + * @delta_q_v_dc: indicates the V DC quantizer relative to base_q_idx.
> + * @delta_q_v_ac: indicates the V AC quantizer relative to base_q_idx.
> + * @qm_y: specifies the level in the quantizer matrix that should be used for
> + * luma plane decoding.
> + * @qm_u: specifies the level in the quantizer matrix that should be used for
> + * chroma U plane decoding.
> + * @qm_v: specifies the level in the quantizer matrix that should be used for
> + * chroma V plane decoding.
> + * @delta_q_res: specifies the left shift which should be applied to decoded
> + * quantizer index delta values.
> + */
> +struct v4l2_av1_quantization {
> +	__u8 flags;
> +	__u8 base_q_idx;
> +	__s8 delta_q_y_dc;
> +	__s8 delta_q_u_dc;
> +	__s8 delta_q_u_ac;
> +	__s8 delta_q_v_dc;
> +	__s8 delta_q_v_ac;
> +	__u8 qm_y;
> +	__u8 qm_u;
> +	__u8 qm_v;
> +	__u8 delta_q_res;
> +};
> +
> +#define V4L2_AV1_TILE_INFO_FLAG_UNIFORM_TILE_SPACING	BIT(0)
> +
> +/**
> + * struct v4l2_av1_tile_info - AV1 Tile info as defined in section 6.8.14. "Tile
> + * info semantics" of the AV1 specification.
> + *
> + * @flags: see V4L2_AV1_TILE_INFO_FLAG_{}
> + * @mi_col_starts: an array specifying the start column (in units of 4x4 luma
> + * samples) for each tile across the image.
> + * @mi_row_starts: an array specifying the start row (in units of 4x4 luma
> + * samples) for each tile down the image.
> + * @width_in_sbs_minus_1: specifies the width of a tile minus 1 in units of
> + * superblocks.
> + * @height_in_sbs_minus_1:  specifies the height of a tile minus 1 in units of
> + * superblocks.
> + * @tile_size_bytes: specifies the number of bytes needed to code each tile
> + * size.
> + * @context_update_tile_id: specifies which tile to use for the CDF update.
> + * @tile_rows: specifies the number of tiles down the frame.
> + * @tile_cols: specifies the number of tiles across the frame.
> + */
> +struct v4l2_av1_tile_info {
> +	__u8 flags;
> +	__u32 mi_col_starts[V4L2_AV1_MAX_TILE_COLS + 1];
> +	__u32 mi_row_starts[V4L2_AV1_MAX_TILE_ROWS + 1];
> +	__u32 width_in_sbs_minus_1[V4L2_AV1_MAX_TILE_COLS];
> +	__u32 height_in_sbs_minus_1[V4L2_AV1_MAX_TILE_ROWS];
> +	__u8 tile_size_bytes;
> +	__u8 context_update_tile_id;
> +	__u8 tile_cols;
> +	__u8 tile_rows;
> +};
> +
> +/**
> + * enum v4l2_av1_frame_type - AV1 Frame Type
> + *
> + * @V4L2_AV1_KEY_FRAME: Key frame
> + * @V4L2_AV1_INTER_FRAME: Inter frame
> + * @V4L2_AV1_INTRA_ONLY_FRAME: Intra-only frame
> + * @V4L2_AV1_SWITCH_FRAME: Switch frame
> + */
> +enum v4l2_av1_frame_type {
> +	V4L2_AV1_KEY_FRAME = 0,
> +	V4L2_AV1_INTER_FRAME = 1,
> +	V4L2_AV1_INTRA_ONLY_FRAME = 2,
> +	V4L2_AV1_SWITCH_FRAME = 3
> +};
> +
> +/**
> + * enum v4l2_vp9_interpolation_filter - AV1 interpolation filter types
> + *
> + * @V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP: eight tap filter
> + * @V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP_SMOOTH: eight tap smooth filter
> + * @V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP_SHARP: eight tap sharp filter
> + * @V4L2_AV1_INTERPOLATION_FILTER_BILINEAR: bilinear filter
> + * @V4L2_AV1_INTERPOLATION_FILTER_SWITCHABLE: filter selection is signaled at
> + * the block level
> + *
> + * See section 6.8.9 "Interpolation filter semantics" of the AV1 specification
> + * for more details.
> + */
> +enum v4l2_av1_interpolation_filter {
> +	V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP = 0,
> +	V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP_SMOOTH = 1,
> +	V4L2_AV1_INTERPOLATION_FILTER_EIGHTTAP_SHARP = 2,
> +	V4L2_AV1_INTERPOLATION_FILTER_BILINEAR = 3,
> +	V4L2_AV1_INTERPOLATION_FILTER_SWITCHABLE = 4,
> +};
> +
> +/**
> + * enum v4l2_av1_tx_mode - AV1 Tx mode as described in section 6.8.21 "TX mode
> + * semantics" of the AV1 specification.
> + * @V4L2_AV1_TX_MODE_ONLY_4X4: the inverse transform will use only 4x4
> + * transforms
> + * @V4L2_AV1_TX_MODE_LARGEST: the inverse transform will use the largest
> + * transform size that fits inside the block
> + * @V4L2_AV1_TX_MODE_SELECT: the choice of transform size is specified
> + * explicitly for each block.
> + */
> +enum v4l2_av1_tx_mode {
> +	V4L2_AV1_TX_MODE_ONLY_4X4 = 0,
> +	V4L2_AV1_TX_MODE_LARGEST = 1,
> +	V4L2_AV1_TX_MODE_SELECT = 2
> +};
> +
> +#define V4L2_AV1_FRAME_HEADER_FLAG_SHOW_FRAME			BIT(0)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_SHOWABLE_FRAME		BIT(1)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_ERROR_RESILIENT_MODE		BIT(2)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_DISABLE_CDF_UPDATE		BIT(3)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_ALLOW_SCREEN_CONTENT_TOOLS	BIT(4)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_FORCE_INTEGER_MV		BIT(5)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_ALLOW_INTRABC		BIT(6)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_USE_SUPERRES			BIT(7)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_ALLOW_HIGH_PRECISION_MV	BIT(8)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_IS_MOTION_MODE_SWITCHABLE	BIT(9)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_USE_REF_FRAME_MVS		BIT(10)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_DISABLE_FRAME_END_UPDATE_CDF BIT(11)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_UNIFORM_TILE_SPACING		BIT(12)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_ALLOW_WARPED_MOTION		BIT(13)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_REFERENCE_SELECT		BIT(14)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_REDUCED_TX_SET		BIT(15)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_SKIP_MODE_PRESENT		BIT(16)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_FRAME_SIZE_OVERRIDE		BIT(17)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_BUFFER_REMOVAL_TIME_PRESENT	BIT(18)
> +#define V4L2_AV1_FRAME_HEADER_FLAG_FRAME_REFS_SHORT_SIGNALING	BIT(19)
> +
> +#define V4L2_CID_STATELESS_AV1_FRAME_HEADER (V4L2_CID_CODEC_STATELESS_BASE + 406)
> +/**
> + * struct v4l2_ctrl_av1_frame_header - Represents an AV1 Frame Header OBU.
> + *
> + * @tile_info: tile info
> + * @quantization: quantization params
> + * @segmentation: segmentation params
> + * @loop_filter: loop filter params
> + * @cdef: cdef params
> + * @loop_restoration: loop restoration params
> + * @global_motion: global motion params
> + * @film_grain: film grain params
> + * @flags: see V4L2_AV1_FRAME_HEADER_FLAG_{}
> + * @frame_type: specifies the AV1 frame type
> + * @order_hint: specifies OrderHintBits least significant bits of the expected
> + * output order for this frame.
> + * @superres_denom: the denominator for the upscaling ratio.
> + * @upscaled_width: the upscaled width.
> + * @interpolation_filter: specifies the filter selection used for performing
> + * inter prediction.
> + * @tx_mode: specifies how the transform size is determined.
> + * @frame_width_minus_1: add 1 to get the frame's width.
> + * @frame_height_minus_1: add 1 to get the frame's height
> + * @render_width_minus_1: add 1 to get the render width of the frame in luma
> + * samples.
> + * @render_height_minus_1: add 1 to get the render height of the frame in luma
> + * samples.
> + * @current_frame_id: specifies the frame id number for the current frame. Frame
> + * id numbers are additional information that do not affect the decoding
> + * process, but provide decoders with a way of detecting missing reference
> + * frames so that appropriate action can be taken.
> + * @primary_ref_frame: specifies which reference frame contains the CDF values
> + * and other state that should be loaded at the start of the frame.
> + * @buf_removal_time: specifies the frame removal time in units of DecCT clock
> + * ticks counted from the removal time of the last random access point for
> + * operating point opNum.
> + * @refresh_frame_flags: contains a bitmask that specifies which reference frame
> + * slots will be updated with the current frame after it is decoded.
> + * @ref_order_hint: specifies the expected output order hint for each reference
> + * frame.
> + * @last_frame_idx: specifies the reference frame to use for LAST_FRAME.
> + * @gold_frame_idx: specifies the reference frame to use for GOLDEN_FRAME.
> + * refs
> + * @reference_frame_ts: the V4L2 timestamp for each of the reference frames
> + * enumerated in &v4l2_av1_reference_frame. The timestamp refers to the
> + * timestamp field in struct v4l2_buffer. Use v4l2_timeval_to_ns() to convert
> + * the struct timeval to a __u64.
> + * @skip_mode_frame: specifies the frames to use for compound prediction when
> + * skip_mode is equal to 1.
> + */
> +struct v4l2_ctrl_av1_frame_header {
> +	struct v4l2_av1_tile_info tile_info;
> +	struct v4l2_av1_quantization quantization;
> +	struct v4l2_av1_segmentation segmentation;
> +	struct v4l2_av1_loop_filter  loop_filter;
> +	struct v4l2_av1_cdef cdef;
> +	struct v4l2_av1_loop_restoration loop_restoration;
> +	struct v4l2_av1_global_motion global_motion;
> +	struct v4l2_av1_film_grain film_grain;
> +	__u32 flags;
> +	enum v4l2_av1_frame_type frame_type;
> +	__u32 order_hint;
> +	__u8 superres_denom;
> +	__u32 upscaled_width;
> +	enum v4l2_av1_interpolation_filter interpolation_filter;
> +	enum v4l2_av1_tx_mode tx_mode;
> +	__u32 frame_width_minus_1;
> +	__u32 frame_height_minus_1;
> +	__u16 render_width_minus_1;
> +	__u16 render_height_minus_1;
> +
> +	__u32 current_frame_id;
> +	__u8 primary_ref_frame;
> +	__u8 buffer_removal_time[V4L2_AV1_MAX_OPERATING_POINTS];
> +	__u8 refresh_frame_flags;
> +	__u32 ref_order_hint[V4L2_AV1_NUM_REF_FRAMES];
> +	__s8 last_frame_idx;
> +	__s8 gold_frame_idx;
> +	__u64 reference_frame_ts[V4L2_AV1_NUM_REF_FRAMES];
> +	__u8 skip_mode_frame[2];
> +};
> +
> +/**
> + * enum v4l2_stateless_av1_profile - AV1 profiles
> + *
> + * @V4L2_STATELESS_AV1_PROFILE_MAIN: compliant decoders must be able to decode
> + * streams with seq_profile equal to 0.
> + * @V4L2_STATELESS_PROFILE_HIGH: compliant decoders must be able to decode
> + * streams with seq_profile equal to 0.
> + * @V4L2_STATELESS_PROFILE_PROFESSIONAL: compliant decoders must be able to
> + * decode streams with seq_profile equal to 0.
> + *
> + * Conveys the highest profile a decoder can work with.
> + */
> +#define V4L2_CID_STATELESS_AV1_PROFILE (V4L2_CID_CODEC_STATELESS_BASE + 407)
> +enum v4l2_stateless_av1_profile {
> +	V4L2_STATELESS_AV1_PROFILE_MAIN = 0,
> +	V4L2_STATELESS_AV1_PROFILE_HIGH = 1,
> +	V4L2_STATELESS_AV1_PROFILE_PROFESSIONAL = 2,
> +};
> +
> +/**
> + * enum v4l2_stateless_av1_level - AV1 levels
> + *
> + * @V4L2_STATELESS_AV1_LEVEL_2_0: Level 2.0.
> + * @V4L2_STATELESS_AV1_LEVEL_2_1: Level 2.1.
> + * @V4L2_STATELESS_AV1_LEVEL_2_2: Level 2.2.
> + * @V4L2_STATELESS_AV1_LEVEL_2_3: Level 2.3.
> + * @V4L2_STATELESS_AV1_LEVEL_3_0: Level 3.0.
> + * @V4L2_STATELESS_AV1_LEVEL_3_1: Level 3.1.
> + * @V4L2_STATELESS_AV1_LEVEL_3_2: Level 3.2.
> + * @V4L2_STATELESS_AV1_LEVEL_3_3: Level 3.3.
> + * @V4L2_STATELESS_AV1_LEVEL_4_0: Level 4.0.
> + * @V4L2_STATELESS_AV1_LEVEL_4_1: Level 4.1.
> + * @V4L2_STATELESS_AV1_LEVEL_4_2: Level 4.2.
> + * @V4L2_STATELESS_AV1_LEVEL_4_3: Level 4.3.
> + * @V4L2_STATELESS_AV1_LEVEL_5_0: Level 5.0.
> + * @V4L2_STATELESS_AV1_LEVEL_5_1: Level 5.1.
> + * @V4L2_STATELESS_AV1_LEVEL_5_2: Level 5.2.
> + * @V4L2_STATELESS_AV1_LEVEL_5_3: Level 5.3.
> + * @V4L2_STATELESS_AV1_LEVEL_6_0: Level 6.0.
> + * @V4L2_STATELESS_AV1_LEVEL_6_1: Level 6.1.
> + * @V4L2_STATELESS_AV1_LEVEL_6_2: Level 6.2.
> + * @V4L2_STATELESS_AV1_LEVEL_6_3: Level 6.3.
> + * @V4L2_STATELESS_AV1_LEVEL_7_0: Level 7.0.
> + * @V4L2_STATELESS_AV1_LEVEL_7_2: Level 7.2.
> + * @V4L2_STATELESS_AV1_LEVEL_7_3: Level 7.3.
> + *
> + * Conveys the highest level a decoder can work with.
> + */
> +#define V4L2_CID_STATELESS_AV1_LEVEL (V4L2_CID_CODEC_STATELESS_BASE + 408)
> +enum v4l2_stateless_av1_level {
> +	V4L2_STATELESS_AV1_LEVEL_2_0 = 0,
> +	V4L2_STATELESS_AV1_LEVEL_2_1 = 1,
> +	V4L2_STATELESS_AV1_LEVEL_2_2 = 2,
> +	V4L2_STATELESS_AV1_LEVEL_2_3 = 3,
> +
> +	V4L2_STATELESS_AV1_LEVEL_3_0 = 4,
> +	V4L2_STATELESS_AV1_LEVEL_3_1 = 5,
> +	V4L2_STATELESS_AV1_LEVEL_3_2 = 6,
> +	V4L2_STATELESS_AV1_LEVEL_3_3 = 7,
> +
> +	V4L2_STATELESS_AV1_LEVEL_4_0 = 8,
> +	V4L2_STATELESS_AV1_LEVEL_4_1 = 9,
> +	V4L2_STATELESS_AV1_LEVEL_4_2 = 10,
> +	V4L2_STATELESS_AV1_LEVEL_4_3 = 11,
> +
> +	V4L2_STATELESS_AV1_LEVEL_5_0 = 12,
> +	V4L2_STATELESS_AV1_LEVEL_5_1 = 13,
> +	V4L2_STATELESS_AV1_LEVEL_5_2 = 14,
> +	V4L2_STATELESS_AV1_LEVEL_5_3 = 15,
> +
> +	V4L2_STATELESS_AV1_LEVEL_6_0 = 16,
> +	V4L2_STATELESS_AV1_LEVEL_6_1 = 17,
> +	V4L2_STATELESS_AV1_LEVEL_6_2 = 18,
> +	V4L2_STATELESS_AV1_LEVEL_6_3 = 19,
> +
> +	V4L2_STATELESS_AV1_LEVEL_7_0 = 20,
> +	V4L2_STATELESS_AV1_LEVEL_7_1 = 21,
> +	V4L2_STATELESS_AV1_LEVEL_7_2 = 22,
> +	V4L2_STATELESS_AV1_LEVEL_7_3 = 23
> +};
> +
> +/**
> + * enum v4l2_stateless_av1_operating_mode - AV1 operating mode
> + *
> + * @V4L2_STATELESS_AV1_OPERATING_MODE_GENERAL_DECODING: input is a sequence of
> + * OBUs, output is decoded frames)
> + * @V4L2_STATELESS_AV1_OPERATING_MODE_LARGE_SCALE_TILE_DECODING: Large scale
> + * tile decoding (input is a tile list OBU plus additional side information,
> + * output is a decoded frame)
> + *
> + * Conveys the decoding mode the decoder is operating with. The two AV1 decoding
> + * modes are specified in section 7 "Decoding process" of the AV1 specification.
> + */
> +#define V4L2_CID_STATELESS_AV1_OPERATING_MODE (V4L2_CID_CODEC_STATELESS_BASE + 409)
> +enum v4l2_stateless_av1_operating_mode {
> +	V4L2_STATELESS_AV1_OPERATING_MODE_GENERAL_DECODING = 0,
> +	V4L2_STATELESS_AV1_OPERATING_MODE_LARGE_SCALE_TILE_DECODING = 1,
> +};
> +
>  #define V4L2_CID_COLORIMETRY_CLASS_BASE	(V4L2_CTRL_CLASS_COLORIMETRY | 0x900)
>  #define V4L2_CID_COLORIMETRY_CLASS	(V4L2_CTRL_CLASS_COLORIMETRY | 1)
>  
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 7222fc855d6b..d20f8505f980 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -701,6 +701,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_FWHT     v4l2_fourcc('F', 'W', 'H', 'T') /* Fast Walsh Hadamard Transform (vicodec) */
>  #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
>  #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
> +#define V4L2_PIX_FMT_AV1_FRAME	v4l2_fourcc('A', 'V', '1', 'F') /* AV1 parsed frame */
>  
>  /*  Vendor-specific formats   */
>  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
> @@ -1750,6 +1751,13 @@ struct v4l2_ext_control {
>  		struct v4l2_ctrl_mpeg2_sequence __user *p_mpeg2_sequence;
>  		struct v4l2_ctrl_mpeg2_picture __user *p_mpeg2_picture;
>  		struct v4l2_ctrl_mpeg2_quantisation __user *p_mpeg2_quantisation;
> +
> +		struct v4l2_ctrl_av1_sequence __user *p_av1_sequence;
> +		struct v4l2_ctrl_av1_tile_group __user *p_av1_tile_group;
> +		struct v4l2_ctrl_av1_tile_group_entry __user *p_av1_tile_group_entry;
> +		struct v4l2_ctrl_av1_tile_list __user *p_av1_tile_list;
> +		struct v4l2_ctrl_av1_tile_list_entry __user *p_av1_tile_list_entry;
> +		struct v4l2_ctrl_av1_frame_header __user *p_av1_frame_header;
>  		void __user *ptr;
>  	};
>  } __attribute__ ((packed));
> @@ -1814,6 +1822,13 @@ enum v4l2_ctrl_type {
>  	V4L2_CTRL_TYPE_MPEG2_QUANTISATION   = 0x0250,
>  	V4L2_CTRL_TYPE_MPEG2_SEQUENCE       = 0x0251,
>  	V4L2_CTRL_TYPE_MPEG2_PICTURE        = 0x0252,
> +
> +	V4L2_CTRL_TYPE_AV1_SEQUENCE	    = 0x280,
> +	V4L2_CTRL_TYPE_AV1_TILE_GROUP	    = 0x281,
> +	V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY = 0x282,
> +	V4L2_CTRL_TYPE_AV1_TILE_LIST	    = 0x283,
> +	V4L2_CTRL_TYPE_AV1_TILE_LIST_ENTRY  = 0x284,
> +	V4L2_CTRL_TYPE_AV1_FRAME_HEADER	    = 0x285,
>  };
>  
>  /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */

