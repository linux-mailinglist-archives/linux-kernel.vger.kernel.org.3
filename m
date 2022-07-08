Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526A756B93A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiGHMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbiGHMGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:06:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863FD9B1AE;
        Fri,  8 Jul 2022 05:06:18 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:3cab:61a1:2b1f:896b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C834066019D4;
        Fri,  8 Jul 2022 13:06:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657281977;
        bh=UrV6h7ZLOo6BU9EXi6wPtNcUw9UEElPuNmAijmZcASk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4uCo9D1eip2Lg9Si7IjoAykplvr8algemZRSsCBQY8XFvgKs8cqdA7h+iNv2QVQx
         U+bv6K1Ybao1ik8n+4womLw2ZXhAXNrRBEjMXFk1k5w4AC9YT9L65l50TatLwiWFji
         QA+YEu+IErF7W/NOlp8TQePJWWF9MsQExIHIgq9SMybXpaMeZMvWmhIgq3e+9AgJZn
         2VFD61u4AwjOBh9B6UWOEwg1HsimxG51MKQsdcnZD0cqmdsPwv6LundCwLPqo56RyJ
         /6Ot3i1E1LAOaE9IcANFlgGzM7oRtpbxEEGOejVa163RHtD3RIPTnRjWskJA97j/AU
         /DRgdcQpBrlig==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v12 17/17] media: uapi: move HEVC stateless controls out of staging
Date:   Fri,  8 Jul 2022 14:05:54 +0200
Message-Id: <20220708120554.495495-18-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220708120554.495495-1-benjamin.gaignard@collabora.com>
References: <20220708120554.495495-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HEVC uAPI is used by 2 mainline drivers (Hantro, Cedrus)
and at least 2 out-of-tree drivers (rkvdec, RPi).
The uAPI has been reviewed so it is time to make it 'public' by
un-staging it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../media/v4l/ext-ctrls-codec-stateless.rst   | 899 +++++++++++++++++
 .../media/v4l/ext-ctrls-codec.rst             | 903 ------------------
 .../media/v4l/pixfmt-compressed.rst           |   2 +-
 .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
 include/media/hevc-ctrls.h                    | 474 ---------
 include/media/v4l2-ctrls.h                    |   6 -
 include/uapi/linux/v4l2-controls.h            | 459 +++++++++
 include/uapi/linux/videodev2.h                |   5 +
 8 files changed, 1384 insertions(+), 1384 deletions(-)
 delete mode 100644 include/media/hevc-ctrls.h

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
index bee73065e993..31720b658ca2 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
@@ -2048,3 +2048,902 @@ This structure contains all loop filter related parameters. See sections
       - 0x2
       - When set, the bitstream contains additional syntax elements that
         specify which mode and reference frame deltas are to be updated.
+
+.. _v4l2-codec-stateless-hevc:
+
+``V4L2_CID_STATELESS_HEVC_SPS (struct)``
+    Specifies the Sequence Parameter Set fields (as extracted from the
+    bitstream) for the associated HEVC slice data.
+    These bitstream parameters are defined according to :ref:`hevc`.
+    They are described in section 7.4.3.2 "Sequence parameter set RBSP
+    semantics" of the specification.
+
+.. c:type:: v4l2_ctrl_hevc_sps
+
+.. raw:: latex
+
+    \small
+
+.. tabularcolumns:: |p{1.2cm}|p{9.2cm}|p{6.9cm}|
+
+.. cssclass:: longtable
+
+.. flat-table:: struct v4l2_ctrl_hevc_sps
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - __u8
+      - ``video_parameter_set_id``
+      - Specifies the value of the vps_video_parameter_set_id of the active VPS
+        as described in section "7.4.3.2.1 General sequence parameter set RBSP semantics"
+        of H.265 specifications.
+    * - __u8
+      - ``seq_parameter_set_id``
+      - Provides an identifier for the SPS for reference by other syntax elements
+        as described in section "7.4.3.2.1 General sequence parameter set RBSP semantics"
+        of H.265 specifications.
+    * - __u16
+      - ``pic_width_in_luma_samples``
+      - Specifies the width of each decoded picture in units of luma samples.
+    * - __u16
+      - ``pic_height_in_luma_samples``
+      - Specifies the height of each decoded picture in units of luma samples.
+    * - __u8
+      - ``bit_depth_luma_minus8``
+      - This value plus 8 specifies the bit depth of the samples of the luma array.
+    * - __u8
+      - ``bit_depth_chroma_minus8``
+      - This value plus 8 specifies the bit depth of the samples of the chroma arrays.
+    * - __u8
+      - ``log2_max_pic_order_cnt_lsb_minus4``
+      - Specifies the value of the variable MaxPicOrderCntLsb.
+    * - __u8
+      - ``sps_max_dec_pic_buffering_minus1``
+      - This value plus 1 specifies the maximum required size of the decoded picture buffer for
+        the coded video sequence (CVS).
+    * - __u8
+      - ``sps_max_num_reorder_pics``
+      - Indicates the maximum allowed number of pictures.
+    * - __u8
+      - ``sps_max_latency_increase_plus1``
+      - Used to signal MaxLatencyPictures, which indicates the maximum number of
+        pictures that can precede any picture in output order and follow that
+        picture in decoding order.
+    * - __u8
+      - ``log2_min_luma_coding_block_size_minus3``
+      - This value plus 3 specifies the minimum luma coding block size.
+    * - __u8
+      - ``log2_diff_max_min_luma_coding_block_size``
+      - Specifies the difference between the maximum and minimum luma coding block size.
+    * - __u8
+      - ``log2_min_luma_transform_block_size_minus2``
+      - This value plus 2 specifies the minimum luma transform block size.
+    * - __u8
+      - ``log2_diff_max_min_luma_transform_block_size``
+      - Specifies the difference between the maximum and minimum luma transform block size.
+    * - __u8
+      - ``max_transform_hierarchy_depth_inter``
+      - Specifies the maximum hierarchy depth for transform units of coding units coded
+        in inter prediction mode.
+    * - __u8
+      - ``max_transform_hierarchy_depth_intra``
+      - Specifies the maximum hierarchy depth for transform units of coding units coded in
+        intra prediction mode.
+    * - __u8
+      - ``pcm_sample_bit_depth_luma_minus1``
+      - This value plus 1 specifies the number of bits used to represent each of PCM sample values of the
+        luma component.
+    * - __u8
+      - ``pcm_sample_bit_depth_chroma_minus1``
+      - Specifies the number of bits used to represent each of PCM sample values of
+        the chroma components.
+    * - __u8
+      - ``log2_min_pcm_luma_coding_block_size_minus3``
+      - Plus 3 specifies the minimum size of coding blocks.
+    * - __u8
+      - ``log2_diff_max_min_pcm_luma_coding_block_size``
+      - Specifies the difference between the maximum and minimum size of coding blocks.
+    * - __u8
+      - ``num_short_term_ref_pic_sets``
+      - Specifies the number of st_ref_pic_set() syntax structures included in the SPS.
+    * - __u8
+      - ``num_long_term_ref_pics_sps``
+      - Specifies the number of candidate long-term reference pictures that are
+        specified in the SPS.
+    * - __u8
+      - ``chroma_format_idc``
+      - Specifies the chroma sampling.
+    * - __u8
+      - ``sps_max_sub_layers_minus1``
+      - This value plus 1 specifies the maximum number of temporal sub-layers.
+    * - __u64
+      - ``flags``
+      - See :ref:`Sequence Parameter Set Flags <hevc_sps_flags>`
+
+.. raw:: latex
+
+    \normalsize
+
+.. _hevc_sps_flags:
+
+``Sequence Parameter Set Flags``
+
+.. raw:: latex
+
+    \small
+
+.. cssclass:: longtable
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - ``V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE``
+      - 0x00000001
+      -
+    * - ``V4L2_HEVC_SPS_FLAG_SCALING_LIST_ENABLED``
+      - 0x00000002
+      -
+    * - ``V4L2_HEVC_SPS_FLAG_AMP_ENABLED``
+      - 0x00000004
+      -
+    * - ``V4L2_HEVC_SPS_FLAG_SAMPLE_ADAPTIVE_OFFSET``
+      - 0x00000008
+      -
+    * - ``V4L2_HEVC_SPS_FLAG_PCM_ENABLED``
+      - 0x00000010
+      -
+    * - ``V4L2_HEVC_SPS_FLAG_PCM_LOOP_FILTER_DISABLED``
+      - 0x00000020
+      -
+    * - ``V4L2_HEVC_SPS_FLAG_LONG_TERM_REF_PICS_PRESENT``
+      - 0x00000040
+      -
+    * - ``V4L2_HEVC_SPS_FLAG_SPS_TEMPORAL_MVP_ENABLED``
+      - 0x00000080
+      -
+    * - ``V4L2_HEVC_SPS_FLAG_STRONG_INTRA_SMOOTHING_ENABLED``
+      - 0x00000100
+      -
+
+.. raw:: latex
+
+    \normalsize
+
+``V4L2_CID_STATELESS_HEVC_PPS (struct)``
+    Specifies the Picture Parameter Set fields (as extracted from the
+    bitstream) for the associated HEVC slice data.
+    These bitstream parameters are defined according to :ref:`hevc`.
+    They are described in section 7.4.3.3 "Picture parameter set RBSP
+    semantics" of the specification.
+
+.. c:type:: v4l2_ctrl_hevc_pps
+
+.. tabularcolumns:: |p{1.2cm}|p{8.6cm}|p{7.5cm}|
+
+.. cssclass:: longtable
+
+.. flat-table:: struct v4l2_ctrl_hevc_pps
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - __u8
+      - ``pic_parameter_set_id``
+      - Identifies the PPS for reference by other syntax elements.
+    * - __u8
+      - ``num_extra_slice_header_bits``
+      - Specifies the number of extra slice header bits that are present
+        in the slice header RBSP for coded pictures referring to the PPS.
+    * - __u8
+      - ``num_ref_idx_l0_default_active_minus1``
+      - This value plus 1 specifies the inferred value of num_ref_idx_l0_active_minus1.
+    * - __u8
+      - ``num_ref_idx_l1_default_active_minus1``
+      - This value plus 1 specifies the inferred value of num_ref_idx_l1_active_minus1.
+    * - __s8
+      - ``init_qp_minus26``
+      - This value plus 26 specifies the initial value of SliceQp Y for each slice
+        referring to the PPS.
+    * - __u8
+      - ``diff_cu_qp_delta_depth``
+      - Specifies the difference between the luma coding tree block size
+        and the minimum luma coding block size of coding units that
+        convey cu_qp_delta_abs and cu_qp_delta_sign_flag.
+    * - __s8
+      - ``pps_cb_qp_offset``
+      - Specifies the offsets to the luma quantization parameter Cb.
+    * - __s8
+      - ``pps_cr_qp_offset``
+      - Specifies the offsets to the luma quantization parameter Cr.
+    * - __u8
+      - ``num_tile_columns_minus1``
+      - This value plus 1 specifies the number of tile columns partitioning the picture.
+    * - __u8
+      - ``num_tile_rows_minus1``
+      - This value plus 1 specifies the number of tile rows partitioning the picture.
+    * - __u8
+      - ``column_width_minus1[20]``
+      - This value plus 1 specifies the width of the i-th tile column in units of
+        coding tree blocks.
+    * - __u8
+      - ``row_height_minus1[22]``
+      - This value plus 1 specifies the height of the i-th tile row in units of coding
+        tree blocks.
+    * - __s8
+      - ``pps_beta_offset_div2``
+      - Specifies the default deblocking parameter offsets for beta divided by 2.
+    * - __s8
+      - ``pps_tc_offset_div2``
+      - Specifies the default deblocking parameter offsets for tC divided by 2.
+    * - __u8
+      - ``log2_parallel_merge_level_minus2``
+      - This value plus 2 specifies the value of the variable Log2ParMrgLevel.
+    * - __u8
+      - ``padding[4]``
+      - Applications and drivers must set this to zero.
+    * - __u64
+      - ``flags``
+      - See :ref:`Picture Parameter Set Flags <hevc_pps_flags>`
+
+.. _hevc_pps_flags:
+
+``Picture Parameter Set Flags``
+
+.. raw:: latex
+
+    \small
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - ``V4L2_HEVC_PPS_FLAG_DEPENDENT_SLICE_SEGMENT_ENABLED``
+      - 0x00000001
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT``
+      - 0x00000002
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_SIGN_DATA_HIDING_ENABLED``
+      - 0x00000004
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_CABAC_INIT_PRESENT``
+      - 0x00000008
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_CONSTRAINED_INTRA_PRED``
+      - 0x00000010
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_TRANSFORM_SKIP_ENABLED``
+      - 0x00000020
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_CU_QP_DELTA_ENABLED``
+      - 0x00000040
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT``
+      - 0x00000080
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_WEIGHTED_PRED``
+      - 0x00000100
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_WEIGHTED_BIPRED``
+      - 0x00000200
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_TRANSQUANT_BYPASS_ENABLED``
+      - 0x00000400
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_TILES_ENABLED``
+      - 0x00000800
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED``
+      - 0x00001000
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED``
+      - 0x00002000
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_PPS_LOOP_FILTER_ACROSS_SLICES_ENABLED``
+      - 0x00004000
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_OVERRIDE_ENABLED``
+      - 0x00008000
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_PPS_DISABLE_DEBLOCKING_FILTER``
+      - 0x00010000
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_LISTS_MODIFICATION_PRESENT``
+      - 0x00020000
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_SLICE_SEGMENT_HEADER_EXTENSION_PRESENT``
+      - 0x00040000
+      -
+    * - ``V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT``
+      - 0x00080000
+      - Specifies the presence of deblocking filter control syntax elements in
+        the PPS
+    * - ``V4L2_HEVC_PPS_FLAG_UNIFORM_SPACING``
+      - 0x00100000
+      - Specifies that tile column boundaries and likewise tile row boundaries
+        are distributed uniformly across the picture
+
+.. raw:: latex
+
+    \normalsize
+
+``V4L2_CID_STATELESS_HEVC_SLICE_PARAMS (struct)``
+    Specifies various slice-specific parameters, especially from the NAL unit
+    header, general slice segment header and weighted prediction parameter
+    parts of the bitstream.
+    These bitstream parameters are defined according to :ref:`hevc`.
+    They are described in section 7.4.7 "General slice segment header
+    semantics" of the specification.
+    This control is a dynamically sized 1-dimensional array,
+    V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
+
+.. c:type:: v4l2_ctrl_hevc_slice_params
+
+.. raw:: latex
+
+    \scriptsize
+
+.. tabularcolumns:: |p{5.4cm}|p{6.8cm}|p{5.1cm}|
+
+.. cssclass:: longtable
+
+.. flat-table:: struct v4l2_ctrl_hevc_slice_params
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - __u32
+      - ``bit_size``
+      - Size (in bits) of the current slice data.
+    * - __u32
+      - ``data_byte_offset``
+      - Offset (in byte) to the video data in the current slice data.
+    * - __u32
+      - ``num_entry_point_offsets``
+      - Specifies the number of entry point offset syntax elements in the slice header.
+        When the driver supports it, the ``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS``
+        must be set.
+    * - __u8
+      - ``nal_unit_type``
+      - Specifies the coding type of the slice (B, P or I).
+    * - __u8
+      - ``nuh_temporal_id_plus1``
+      - Minus 1 specifies a temporal identifier for the NAL unit.
+    * - __u8
+      - ``slice_type``
+      -
+	(V4L2_HEVC_SLICE_TYPE_I, V4L2_HEVC_SLICE_TYPE_P or
+	V4L2_HEVC_SLICE_TYPE_B).
+    * - __u8
+      - ``colour_plane_id``
+      - Specifies the colour plane associated with the current slice.
+    * - __s32
+      - ``slice_pic_order_cnt``
+      - Specifies the picture order count.
+    * - __u8
+      - ``num_ref_idx_l0_active_minus1``
+      - This value plus 1 specifies the maximum reference index for reference picture list 0
+        that may be used to decode the slice.
+    * - __u8
+      - ``num_ref_idx_l1_active_minus1``
+      - This value plus 1 specifies the maximum reference index for reference picture list 1
+        that may be used to decode the slice.
+    * - __u8
+      - ``collocated_ref_idx``
+      - Specifies the reference index of the collocated picture used for
+        temporal motion vector prediction.
+    * - __u8
+      - ``five_minus_max_num_merge_cand``
+      - Specifies the maximum number of merging motion vector prediction
+        candidates supported in the slice subtracted from 5.
+    * - __s8
+      - ``slice_qp_delta``
+      - Specifies the initial value of QpY to be used for the coding blocks in the slice.
+    * - __s8
+      - ``slice_cb_qp_offset``
+      - Specifies a difference to be added to the value of pps_cb_qp_offset.
+    * - __s8
+      - ``slice_cr_qp_offset``
+      - Specifies a difference to be added to the value of pps_cr_qp_offset.
+    * - __s8
+      - ``slice_act_y_qp_offset``
+      - Specifies the offset to the luma of quantization parameter qP derived in section 8.6.2
+    * - __s8
+      - ``slice_act_cb_qp_offset``
+      - Specifies the offset to the cb of quantization parameter qP derived in section 8.6.2
+    * - __s8
+      - ``slice_act_cr_qp_offset``
+      - Specifies the offset to the cr of quantization parameter qP derived in section 8.6.2
+    * - __s8
+      - ``slice_beta_offset_div2``
+      - Specifies the deblocking parameter offsets for beta divided by 2.
+    * - __s8
+      - ``slice_tc_offset_div2``
+      - Specifies the deblocking parameter offsets for tC divided by 2.
+    * - __u8
+      - ``pic_struct``
+      - Indicates whether a picture should be displayed as a frame or as one or more fields.
+    * - __u32
+      - ``slice_segment_addr``
+      - Specifies the address of the first coding tree block in the slice segment.
+    * - __u8
+      - ``ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
+      - The list of L0 reference elements as indices in the DPB.
+    * - __u8
+      - ``ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
+      - The list of L1 reference elements as indices in the DPB.
+    * - __u16
+      - ``short_term_ref_pic_set_size``
+      - Specifies the size, in bits, of the short-term reference picture set, described as st_ref_pic_set()
+        in the specification, included in the slice header or SPS (section 7.3.6.1).
+    * - __u16
+      - ``long_term_ref_pic_set_size``
+      - Specifies the size, in bits, of the long-term reference picture set include in the slice header
+        or SPS. It is the number of bits in the conditional block if(long_term_ref_pics_present_flag)
+        in section 7.3.6.1 of the specification.
+    * - __u8
+      - ``padding``
+      - Applications and drivers must set this to zero.
+    * - struct :c:type:`v4l2_hevc_pred_weight_table`
+      - ``pred_weight_table``
+      - The prediction weight coefficients for inter-picture prediction.
+    * - __u64
+      - ``flags``
+      - See :ref:`Slice Parameters Flags <hevc_slice_params_flags>`
+
+.. raw:: latex
+
+    \normalsize
+
+.. _hevc_slice_params_flags:
+
+``Slice Parameters Flags``
+
+.. raw:: latex
+
+    \scriptsize
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_LUMA``
+      - 0x00000001
+      -
+    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_CHROMA``
+      - 0x00000002
+      -
+    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_TEMPORAL_MVP_ENABLED``
+      - 0x00000004
+      -
+    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_MVD_L1_ZERO``
+      - 0x00000008
+      -
+    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_CABAC_INIT``
+      - 0x00000010
+      -
+    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_COLLOCATED_FROM_L0``
+      - 0x00000020
+      -
+    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_USE_INTEGER_MV``
+      - 0x00000040
+      -
+    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_DEBLOCKING_FILTER_DISABLED``
+      - 0x00000080
+      -
+    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED``
+      - 0x00000100
+      -
+    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT``
+      - 0x00000200
+      -
+
+.. raw:: latex
+
+    \normalsize
+
+``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
+    Specifies entry point offsets in bytes.
+    This control is a dynamically sized array. The number of entry point
+    offsets is reported by the ``elems`` field.
+    This bitstream parameter is defined according to :ref:`hevc`.
+    They are described in section 7.4.7.1 "General slice segment header
+    semantics" of the specification.
+
+``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
+    Specifies the HEVC scaling matrix parameters used for the scaling process
+    for transform coefficients.
+    These matrix and parameters are defined according to :ref:`hevc`.
+    They are described in section 7.4.5 "Scaling list data semantics" of
+    the specification.
+
+.. c:type:: v4l2_ctrl_hevc_scaling_matrix
+
+.. raw:: latex
+
+    \scriptsize
+
+.. tabularcolumns:: |p{5.4cm}|p{6.8cm}|p{5.1cm}|
+
+.. cssclass:: longtable
+
+.. flat-table:: struct v4l2_ctrl_hevc_scaling_matrix
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - __u8
+      - ``scaling_list_4x4[6][16]``
+      - Scaling list is used for the scaling process for transform
+        coefficients. The values on each scaling list are expected
+        in raster scan order.
+    * - __u8
+      - ``scaling_list_8x8[6][64]``
+      - Scaling list is used for the scaling process for transform
+        coefficients. The values on each scaling list are expected
+        in raster scan order.
+    * - __u8
+      - ``scaling_list_16x16[6][64]``
+      - Scaling list is used for the scaling process for transform
+        coefficients. The values on each scaling list are expected
+        in raster scan order.
+    * - __u8
+      - ``scaling_list_32x32[2][64]``
+      - Scaling list is used for the scaling process for transform
+        coefficients. The values on each scaling list are expected
+        in raster scan order.
+    * - __u8
+      - ``scaling_list_dc_coef_16x16[6]``
+      - Scaling list is used for the scaling process for transform
+        coefficients. The values on each scaling list are expected
+        in raster scan order.
+    * - __u8
+      - ``scaling_list_dc_coef_32x32[2]``
+      - Scaling list is used for the scaling process for transform
+        coefficients. The values on each scaling list are expected
+        in raster scan order.
+
+.. raw:: latex
+
+    \normalsize
+
+.. c:type:: v4l2_hevc_dpb_entry
+
+.. raw:: latex
+
+    \small
+
+.. tabularcolumns:: |p{1.0cm}|p{4.2cm}|p{12.1cm}|
+
+.. flat-table:: struct v4l2_hevc_dpb_entry
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - __u64
+      - ``timestamp``
+      - Timestamp of the V4L2 capture buffer to use as reference, used
+        with B-coded and P-coded frames. The timestamp refers to the
+	``timestamp`` field in struct :c:type:`v4l2_buffer`. Use the
+	:c:func:`v4l2_timeval_to_ns()` function to convert the struct
+	:c:type:`timeval` in struct :c:type:`v4l2_buffer` to a __u64.
+    * - __u8
+      - ``flags``
+      - Long term flag for the reference frame
+        (V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE). The flag is set as
+        described in the ITU HEVC specification chapter "8.3.2 Decoding
+        process for reference picture set".
+    * - __u8
+      - ``field_pic``
+      - Whether the reference is a field picture or a frame.
+        See :ref:`HEVC dpb field pic Flags <hevc_dpb_field_pic_flags>`
+    * - __s32
+      - ``pic_order_cnt_val``
+      - The picture order count of the current picture.
+    * - __u8
+      - ``padding[2]``
+      - Applications and drivers must set this to zero.
+
+.. raw:: latex
+
+    \normalsize
+
+.. _hevc_dpb_field_pic_flags:
+
+``HEVC dpb field pic Flags``
+
+.. raw:: latex
+
+    \scriptsize
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_FRAME``
+      - 0
+      - (progressive) Frame
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_FIELD``
+      - 1
+      - Top field
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_FIELD``
+      - 2
+      - Bottom field
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM``
+      - 3
+      - Top field, bottom field, in that order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP``
+      - 4
+      - Bottom field, top field, in that order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM_TOP``
+      - 5
+      - Top field, bottom field, top field repeated, in that order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP_BOTTOM``
+      - 6
+      - Bottom field, top field, bottom field repeated, in that order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_FRAME_DOUBLING``
+      - 7
+      - Frame doubling
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_FRAME_TRIPLING``
+      - 8
+      - Frame tripling
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_PREVIOUS_BOTTOM``
+      - 9
+      - Top field paired with previous bottom field in output order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_PREVIOUS_TOP``
+      - 10
+      - Bottom field paired with previous top field in output order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_NEXT_BOTTOM``
+      - 11
+      - Top field paired with next bottom field in output order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_NEXT_TOP``
+      - 12
+      - Bottom field paired with next top field in output order
+
+.. c:type:: v4l2_hevc_pred_weight_table
+
+.. raw:: latex
+
+    \footnotesize
+
+.. tabularcolumns:: |p{0.8cm}|p{10.6cm}|p{5.9cm}|
+
+.. flat-table:: struct v4l2_hevc_pred_weight_table
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - __s8
+      - ``delta_luma_weight_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
+      - The difference of the weighting factor applied to the luma
+        prediction value for list 0.
+    * - __s8
+      - ``luma_offset_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
+      - The additive offset applied to the luma prediction value for list 0.
+    * - __s8
+      - ``delta_chroma_weight_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2]``
+      - The difference of the weighting factor applied to the chroma
+        prediction value for list 0.
+    * - __s8
+      - ``chroma_offset_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2]``
+      - The difference of the additive offset applied to the chroma
+        prediction values for list 0.
+    * - __s8
+      - ``delta_luma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
+      - The difference of the weighting factor applied to the luma
+        prediction value for list 1.
+    * - __s8
+      - ``luma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
+      - The additive offset applied to the luma prediction value for list 1.
+    * - __s8
+      - ``delta_chroma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2]``
+      - The difference of the weighting factor applied to the chroma
+        prediction value for list 1.
+    * - __s8
+      - ``chroma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2]``
+      - The difference of the additive offset applied to the chroma
+        prediction values for list 1.
+    * - __u8
+      - ``luma_log2_weight_denom``
+      - The base 2 logarithm of the denominator for all luma weighting
+        factors.
+    * - __s8
+      - ``delta_chroma_log2_weight_denom``
+      - The difference of the base 2 logarithm of the denominator for
+        all chroma weighting factors.
+    * - __u8
+      - ``padding[6]``
+      - Applications and drivers must set this to zero.
+
+.. raw:: latex
+
+    \normalsize
+
+``V4L2_CID_STATELESS_HEVC_DECODE_MODE (enum)``
+    Specifies the decoding mode to use. Currently exposes slice-based and
+    frame-based decoding but new modes might be added later on.
+    This control is used as a modifier for V4L2_PIX_FMT_HEVC_SLICE
+    pixel format. Applications that support V4L2_PIX_FMT_HEVC_SLICE
+    are required to set this control in order to specify the decoding mode
+    that is expected for the buffer.
+    Drivers may expose a single or multiple decoding modes, depending
+    on what they can support.
+
+.. c:type:: v4l2_stateless_hevc_decode_mode
+
+.. raw:: latex
+
+    \small
+
+.. tabularcolumns:: |p{9.4cm}|p{0.6cm}|p{7.3cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - ``V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED``
+      - 0
+      - Decoding is done at the slice granularity.
+        The OUTPUT buffer must contain a single slice.
+    * - ``V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED``
+      - 1
+      - Decoding is done at the frame granularity.
+        The OUTPUT buffer must contain all slices needed to decode the
+        frame.
+
+.. raw:: latex
+
+    \normalsize
+
+``V4L2_CID_STATELESS_HEVC_START_CODE (enum)``
+    Specifies the HEVC slice start code expected for each slice.
+    This control is used as a modifier for V4L2_PIX_FMT_HEVC_SLICE
+    pixel format. Applications that support V4L2_PIX_FMT_HEVC_SLICE
+    are required to set this control in order to specify the start code
+    that is expected for the buffer.
+    Drivers may expose a single or multiple start codes, depending
+    on what they can support.
+
+.. c:type:: v4l2_stateless_hevc_start_code
+
+.. tabularcolumns:: |p{9.2cm}|p{0.6cm}|p{7.5cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - ``V4L2_STATELESS_HEVC_START_CODE_NONE``
+      - 0
+      - Selecting this value specifies that HEVC slices are passed
+        to the driver without any start code. The bitstream data should be
+        according to :ref:`hevc` 7.3.1.1 General NAL unit syntax, hence
+        contains emulation prevention bytes when required.
+    * - ``V4L2_STATELESS_HEVC_START_CODE_ANNEX_B``
+      - 1
+      - Selecting this value specifies that HEVC slices are expected
+        to be prefixed by Annex B start codes. According to :ref:`hevc`
+        valid start codes can be 3-bytes 0x000001 or 4-bytes 0x00000001.
+
+.. raw:: latex
+
+    \normalsize
+
+``V4L2_CID_MPEG_VIDEO_BASELAYER_PRIORITY_ID (integer)``
+    Specifies a priority identifier for the NAL unit, which will be applied to
+    the base layer. By default this value is set to 0 for the base layer,
+    and the next layer will have the priority ID assigned as 1, 2, 3 and so on.
+    The video encoder can't decide the priority id to be applied to a layer,
+    so this has to come from client.
+    This is applicable to H264 and valid Range is from 0 to 63.
+    Source Rec. ITU-T H.264 (06/2019); G.7.4.1.1, G.8.8.1.
+
+``V4L2_CID_MPEG_VIDEO_LTR_COUNT (integer)``
+    Specifies the maximum number of Long Term Reference (LTR) frames at any
+    given time that the encoder can keep.
+    This is applicable to the H264 and HEVC encoders.
+
+``V4L2_CID_MPEG_VIDEO_FRAME_LTR_INDEX (integer)``
+    After setting this control the frame that will be queued next
+    will be marked as a Long Term Reference (LTR) frame
+    and given this LTR index which ranges from 0 to LTR_COUNT-1.
+    This is applicable to the H264 and HEVC encoders.
+    Source Rec. ITU-T H.264 (06/2019); Table 7.9
+
+``V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES (bitmask)``
+    Specifies the Long Term Reference (LTR) frame(s) to be used for
+    encoding the next frame queued after setting this control.
+    This provides a bitmask which consists of bits [0, LTR_COUNT-1].
+    This is applicable to the H264 and HEVC encoders.
+
+``V4L2_CID_STATELESS_HEVC_DECODE_PARAMS (struct)``
+    Specifies various decode parameters, especially the references picture order
+    count (POC) for all the lists (short, long, before, current, after) and the
+    number of entries for each of them.
+    These parameters are defined according to :ref:`hevc`.
+    They are described in section 8.3 "Slice decoding process" of the
+    specification.
+
+.. c:type:: v4l2_ctrl_hevc_decode_params
+
+.. cssclass:: longtable
+
+.. flat-table:: struct v4l2_ctrl_hevc_decode_params
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - __s32
+      - ``pic_order_cnt_val``
+      - PicOrderCntVal as described in section 8.3.1 "Decoding process
+        for picture order count" of the specification.
+    * - __u16
+      - ``short_term_ref_pic_set_size``
+      - Specifies the size, in bits, of the short-term reference picture set, of the first slice
+        described as st_ref_pic_set() in the specification, included in the slice header
+        or SPS (section 7.3.6.1).
+    * - __u16
+      - ``long_term_ref_pic_set_size``
+      - Specifies the size, in bits, of the long-term reference picture set, of the first slice
+        included in the slice header or SPS. It is the number of bits in the conditional block
+        if(long_term_ref_pics_present_flag) in section 7.3.6.1 of the specification.
+    * - __u8
+      - ``num_active_dpb_entries``
+      - The number of entries in ``dpb``.
+    * - __u8
+      - ``num_poc_st_curr_before``
+      - The number of reference pictures in the short-term set that come before
+        the current frame.
+    * - __u8
+      - ``num_poc_st_curr_after``
+      - The number of reference pictures in the short-term set that come after
+        the current frame.
+    * - __u8
+      - ``num_poc_lt_curr``
+      - The number of reference pictures in the long-term set.
+    * - __u8
+      - ``poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
+      - PocStCurrBefore as described in section 8.3.2 "Decoding process for reference
+        picture set": provides the index of the short term before references in DPB array.
+    * - __u8
+      - ``poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
+      - PocStCurrAfter as described in section 8.3.2 "Decoding process for reference
+        picture set": provides the index of the short term after references in DPB array.
+    * - __u8
+      - ``poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
+      - PocLtCurr as described in section 8.3.2 "Decoding process for reference
+        picture set": provides the index of the long term references in DPB array.
+    * - struct :c:type:`v4l2_hevc_dpb_entry`
+      - ``dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
+      - The decoded picture buffer, for meta-data about reference frames.
+    * - __u64
+      - ``flags``
+      - See :ref:`Decode Parameters Flags <hevc_decode_params_flags>`
+
+.. _hevc_decode_params_flags:
+
+``Decode Parameters Flags``
+
+.. cssclass:: longtable
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - ``V4L2_HEVC_DECODE_PARAM_FLAG_IRAP_PIC``
+      - 0x00000001
+      -
+    * - ``V4L2_HEVC_DECODE_PARAM_FLAG_IDR_PIC``
+      - 0x00000002
+      -
+    * - ``V4L2_HEVC_DECODE_PARAM_FLAG_NO_OUTPUT_OF_PRIOR``
+      - 0x00000004
+      -
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index aa8264af461d..2a165ae063fb 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2658,906 +2658,3 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     Indicates whether to generate SPS and PPS at every IDR. Setting it to 0
     disables generating SPS and PPS at every IDR. Setting it to one enables
     generating SPS and PPS at every IDR.
-
-.. _v4l2-mpeg-hevc:
-
-``V4L2_CID_STATELESS_HEVC_SPS (struct)``
-    Specifies the Sequence Parameter Set fields (as extracted from the
-    bitstream) for the associated HEVC slice data.
-    These bitstream parameters are defined according to :ref:`hevc`.
-    They are described in section 7.4.3.2 "Sequence parameter set RBSP
-    semantics" of the specification.
-
-.. c:type:: v4l2_ctrl_hevc_sps
-
-.. raw:: latex
-
-    \small
-
-.. tabularcolumns:: |p{1.2cm}|p{9.2cm}|p{6.9cm}|
-
-.. cssclass:: longtable
-
-.. flat-table:: struct v4l2_ctrl_hevc_sps
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - __u8
-      - ``video_parameter_set_id``
-      - Specifies the value of the vps_video_parameter_set_id of the active VPS
-        as described in section "7.4.3.2.1 General sequence parameter set RBSP semantics"
-        of H.265 specifications.
-    * - __u8
-      - ``seq_parameter_set_id``
-      - Provides an identifier for the SPS for reference by other syntax elements
-        as described in section "7.4.3.2.1 General sequence parameter set RBSP semantics"
-        of H.265 specifications.
-    * - __u16
-      - ``pic_width_in_luma_samples``
-      - Specifies the width of each decoded picture in units of luma samples.
-    * - __u16
-      - ``pic_height_in_luma_samples``
-      - Specifies the height of each decoded picture in units of luma samples.
-    * - __u8
-      - ``bit_depth_luma_minus8``
-      - This value plus 8 specifies the bit depth of the samples of the luma array.
-    * - __u8
-      - ``bit_depth_chroma_minus8``
-      - This value plus 8 specifies the bit depth of the samples of the chroma arrays.
-    * - __u8
-      - ``log2_max_pic_order_cnt_lsb_minus4``
-      - This value plus 4 specifies the value of the variable MaxPicOrderCntLsb.
-    * - __u8
-      - ``sps_max_dec_pic_buffering_minus1``
-      - This value plus 1 specifies the maximum required size of the decoded picture buffer for
-        the codec video sequence.
-    * - __u8
-      - ``sps_max_num_reorder_pics``
-      - Indicates the maximum allowed number of pictures.
-    * - __u8
-      - ``sps_max_latency_increase_plus1``
-      - Not equal to 0 is used to compute the value of SpsMaxLatencyPictures array.
-    * - __u8
-      - ``log2_min_luma_coding_block_size_minus3``
-      - This value plus 3 specifies the minimum luma coding block size.
-    * - __u8
-      - ``log2_diff_max_min_luma_coding_block_size``
-      - Specifies the difference between the maximum and minimum luma coding block size.
-    * - __u8
-      - ``log2_min_luma_transform_block_size_minus2``
-      - This value plus 2 specifies the minimum luma transform block size.
-    * - __u8
-      - ``log2_diff_max_min_luma_transform_block_size``
-      - Specifies the difference between the maximum and minimum luma transform block size.
-    * - __u8
-      - ``max_transform_hierarchy_depth_inter``
-      - Specifies the maximum hierarchy depth for transform units of coding units coded
-        in inter prediction mode.
-    * - __u8
-      - ``max_transform_hierarchy_depth_intra``
-      - Specifies the maximum hierarchy depth for transform units of coding units coded in
-        intra prediction mode.
-    * - __u8
-      - ``pcm_sample_bit_depth_luma_minus1``
-      - This value plus 1 specifies the number of bits used to represent each of PCM sample
-        values of the luma component.
-    * - __u8
-      - ``pcm_sample_bit_depth_chroma_minus1``
-      - This value plus 1 specifies the number of bits used to represent each of PCM sample
-        values of the chroma components.
-    * - __u8
-      - ``log2_min_pcm_luma_coding_block_size_minus3``
-      - This value plus 3 specifies the minimum size of coding blocks.
-    * - __u8
-      - ``log2_diff_max_min_pcm_luma_coding_block_size``
-      - Specifies the difference between the maximum and minimum size of coding blocks.
-    * - __u8
-      - ``num_short_term_ref_pic_sets``
-      - Specifies the number of st_ref_pic_set() syntax structures included in the SPS.
-    * - __u8
-      - ``num_long_term_ref_pics_sps``
-      - Specifies the number of candidate long-term reference pictures that are
-        specified in the SPS.
-    * - __u8
-      - ``chroma_format_idc``
-      - Specifies the chroma sampling.
-    * - __u8
-      - ``sps_max_sub_layers_minus1``
-      - This value plus 1 specifies the maximum number of temporal sub-layers.
-    * - __u64
-      - ``flags``
-      - See :ref:`Sequence Parameter Set Flags <hevc_sps_flags>`
-
-.. raw:: latex
-
-    \normalsize
-
-.. _hevc_sps_flags:
-
-``Sequence Parameter Set Flags``
-
-.. raw:: latex
-
-    \small
-
-.. cssclass:: longtable
-
-.. flat-table::
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - ``V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE``
-      - 0x00000001
-      -
-    * - ``V4L2_HEVC_SPS_FLAG_SCALING_LIST_ENABLED``
-      - 0x00000002
-      -
-    * - ``V4L2_HEVC_SPS_FLAG_AMP_ENABLED``
-      - 0x00000004
-      -
-    * - ``V4L2_HEVC_SPS_FLAG_SAMPLE_ADAPTIVE_OFFSET``
-      - 0x00000008
-      -
-    * - ``V4L2_HEVC_SPS_FLAG_PCM_ENABLED``
-      - 0x00000010
-      -
-    * - ``V4L2_HEVC_SPS_FLAG_PCM_LOOP_FILTER_DISABLED``
-      - 0x00000020
-      -
-    * - ``V4L2_HEVC_SPS_FLAG_LONG_TERM_REF_PICS_PRESENT``
-      - 0x00000040
-      -
-    * - ``V4L2_HEVC_SPS_FLAG_SPS_TEMPORAL_MVP_ENABLED``
-      - 0x00000080
-      -
-    * - ``V4L2_HEVC_SPS_FLAG_STRONG_INTRA_SMOOTHING_ENABLED``
-      - 0x00000100
-      -
-
-.. raw:: latex
-
-    \normalsize
-
-``V4L2_CID_STATELESS_HEVC_PPS (struct)``
-    Specifies the Picture Parameter Set fields (as extracted from the
-    bitstream) for the associated HEVC slice data.
-    These bitstream parameters are defined according to :ref:`hevc`.
-    They are described in section 7.4.3.3 "Picture parameter set RBSP
-    semantics" of the specification.
-
-.. c:type:: v4l2_ctrl_hevc_pps
-
-.. tabularcolumns:: |p{1.2cm}|p{8.6cm}|p{7.5cm}|
-
-.. cssclass:: longtable
-
-.. flat-table:: struct v4l2_ctrl_hevc_pps
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - __u8
-      - ``pic_parameter_set_id``
-      - Identifies the PPS for reference by other syntax elements.
-    * - __u8
-      - ``num_extra_slice_header_bits``
-      - Specifies the number of extra slice header bits that are present
-        in the slice header RBSP for coded pictures referring to the PPS.
-    * - __u8
-      - ``num_ref_idx_l0_default_active_minus1``
-      - This value plus 1 specifies the inferred value of num_ref_idx_l0_active_minus1.
-    * - __u8
-      - ``num_ref_idx_l1_default_active_minus1``
-      - This value plus 1 specifies the inferred value of num_ref_idx_l1_active_minus1.
-    * - __s8
-      - ``init_qp_minus26``
-      - This value plus 26 specifies the initial value of SliceQp Y for each slice
-        referring to the PPS.
-    * - __u8
-      - ``diff_cu_qp_delta_depth``
-      - Specifies the difference between the luma coding tree block size
-        and the minimum luma coding block size of coding units that
-        convey cu_qp_delta_abs and cu_qp_delta_sign_flag.
-    * - __s8
-      - ``pps_cb_qp_offset``
-      - Specifies the offsets to the luma quantization parameter Cb.
-    * - __s8
-      - ``pps_cr_qp_offset``
-      - Specifies the offsets to the luma quantization parameter Cr.
-    * - __u8
-      - ``num_tile_columns_minus1``
-      - This value plus 1 specifies the number of tile columns partitioning the picture.
-    * - __u8
-      - ``num_tile_rows_minus1``
-      - This value plus 1 specifies the number of tile rows partitioning the picture.
-    * - __u8
-      - ``column_width_minus1[20]``
-      - Plus 1 specifies the width of each tile column in units of
-        coding tree blocks.
-    * - __u8
-      - ``row_height_minus1[22]``
-      - This value plus 1 specifies the height of each tile row in units of coding
-        tree blocks.
-    * - __s8
-      - ``pps_beta_offset_div2``
-      - Specifies the default deblocking parameter offsets for beta divided by 2.
-    * - __s8
-      - ``pps_tc_offset_div2``
-      - Specifies the default deblocking parameter offsets for tC divided by 2.
-    * - __u8
-      - ``log2_parallel_merge_level_minus2``
-      - Plus 2 specifies the value of the variable Log2ParMrgLevel.
-    * - __u8
-      - ``padding[4]``
-      - Applications and drivers must set this to zero.
-    * - __u64
-      - ``flags``
-      - See :ref:`Picture Parameter Set Flags <hevc_pps_flags>`
-
-.. _hevc_pps_flags:
-
-``Picture Parameter Set Flags``
-
-.. raw:: latex
-
-    \small
-
-.. flat-table::
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - ``V4L2_HEVC_PPS_FLAG_DEPENDENT_SLICE_SEGMENT_ENABLED``
-      - 0x00000001
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT``
-      - 0x00000002
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_SIGN_DATA_HIDING_ENABLED``
-      - 0x00000004
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_CABAC_INIT_PRESENT``
-      - 0x00000008
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_CONSTRAINED_INTRA_PRED``
-      - 0x00000010
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_TRANSFORM_SKIP_ENABLED``
-      - 0x00000020
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_CU_QP_DELTA_ENABLED``
-      - 0x00000040
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT``
-      - 0x00000080
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_WEIGHTED_PRED``
-      - 0x00000100
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_WEIGHTED_BIPRED``
-      - 0x00000200
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_TRANSQUANT_BYPASS_ENABLED``
-      - 0x00000400
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_TILES_ENABLED``
-      - 0x00000800
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED``
-      - 0x00001000
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED``
-      - 0x00002000
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_PPS_LOOP_FILTER_ACROSS_SLICES_ENABLED``
-      - 0x00004000
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_OVERRIDE_ENABLED``
-      - 0x00008000
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_PPS_DISABLE_DEBLOCKING_FILTER``
-      - 0x00010000
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_LISTS_MODIFICATION_PRESENT``
-      - 0x00020000
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_SLICE_SEGMENT_HEADER_EXTENSION_PRESENT``
-      - 0x00040000
-      -
-    * - ``V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT``
-      - 0x00080000
-      - Specifies the presence of deblocking filter control syntax elements in
-        the PPS
-    * - ``V4L2_HEVC_PPS_FLAG_UNIFORM_SPACING``
-      - 0x00100000
-      - Specifies that tile column boundaries and likewise tile row boundaries
-        are distributed uniformly across the picture
-
-.. raw:: latex
-
-    \normalsize
-
-``V4L2_CID_STATELESS_HEVC_SLICE_PARAMS (struct)``
-    Specifies various slice-specific parameters, especially from the NAL unit
-    header, general slice segment header and weighted prediction parameter
-    parts of the bitstream.
-    These bitstream parameters are defined according to :ref:`hevc`.
-    They are described in section 7.4.7 "General slice segment header
-    semantics" of the specification.
-    This control is a dynamically sized 1-dimensional array,
-    V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
-
-.. c:type:: v4l2_ctrl_hevc_slice_params
-
-.. raw:: latex
-
-    \scriptsize
-
-.. tabularcolumns:: |p{5.4cm}|p{6.8cm}|p{5.1cm}|
-
-.. cssclass:: longtable
-
-.. flat-table:: struct v4l2_ctrl_hevc_slice_params
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - __u32
-      - ``bit_size``
-      - Size (in bits) of the current slice data.
-    * - __u32
-      - ``data_byte_offset``
-      - Offset (in bytes) to the video data in the current slice data.
-    * - __u32
-      - ``num_entry_point_offsets``
-      - Specifies the number of entry point offset syntax elements in the slice header.
-        When the driver supports it, the ``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS``
-        must be set.
-    * - __u8
-      - ``nal_unit_type``
-      - Specifies the coding type of the slice (B, P or I).
-    * - __u8
-      - ``nuh_temporal_id_plus1``
-      - This value minus 1 specifies a temporal identifier for the NAL unit.
-    * - __u8
-      - ``slice_type``
-      -
-	(V4L2_HEVC_SLICE_TYPE_I, V4L2_HEVC_SLICE_TYPE_P or
-	V4L2_HEVC_SLICE_TYPE_B).
-    * - __u8
-      - ``colour_plane_id``
-      - Specifies the colour plane associated with the current slice.
-    * - __s32
-      - ``slice_pic_order_cnt``
-      - Specifies the picture order count.
-    * - __u8
-      - ``num_ref_idx_l0_active_minus1``
-      - This value plus 1 specifies the maximum reference index for
-        reference picture list 0 that may be used to decode the slice.
-    * - __u8
-      - ``num_ref_idx_l1_active_minus1``
-      - This value plus 1 specifies the maximum reference index for
-        reference picture list 1 that may be used to decode the slice.
-    * - __u8
-      - ``collocated_ref_idx``
-      - Specifies the reference index of the collocated picture used for
-        temporal motion vector prediction.
-    * - __u8
-      - ``five_minus_max_num_merge_cand``
-      - Specifies the maximum number of merging motion vector prediction
-        candidates supported in the slice subtracted from 5.
-    * - __s8
-      - ``slice_qp_delta``
-      - Specifies the initial value of QpY to be used for the coding blocks in the slice.
-    * - __s8
-      - ``slice_cb_qp_offset``
-      - Specifies a difference to be added to the value of pps_cb_qp_offset.
-    * - __s8
-      - ``slice_cr_qp_offset``
-      - Specifies a difference to be added to the value of pps_cr_qp_offset.
-    * - __s8
-      - ``slice_act_y_qp_offset``
-      - Screen content extension parameters.
-    * - __s8
-      - ``slice_act_cb_qp_offset``
-      - Screen content extension parameters.
-    * - __s8
-      - ``slice_act_cr_qp_offset``
-      - Screen content extension parameters.
-    * - __s8
-      - ``slice_beta_offset_div2``
-      - Specifies the deblocking parameter offsets for beta divided by 2.
-    * - __s8
-      - ``slice_tc_offset_div2``
-      - Specifies the deblocking parameter offsets for tC divided by 2.
-    * - __u8
-      - ``pic_struct``
-      - Indicates whether a picture should be displayed as a frame or as one or more fields.
-    * - __u32
-      - ``slice_segment_addr``
-      - Specifies the address of the first coding tree block in the slice segment.
-    * - __u8
-      - ``ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
-      - The list of L0 reference elements as indices in the DPB.
-    * - __u8
-      - ``ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
-      - The list of L1 reference elements as indices in the DPB.
-    * - __u16
-      - ``short_term_ref_pic_set_size``
-      - Specifies the size, in bits, of the short-term reference picture set, described as st_ref_pic_set()
-        in the specification, included in the slice header or SPS (section 7.3.6.1).
-    * - __u16
-      - ``long_term_ref_pic_set_size``
-      - Specifies the size, in bits, of the long-term reference picture set include in the slice header
-        or SPS. It is the number of bits in the conditional block if(long_term_ref_pics_present_flag)
-        in section 7.3.6.1 of the specification.
-    * - __u8
-      - ``padding``
-      - Applications and drivers must set this to zero.
-    * - struct :c:type:`v4l2_hevc_pred_weight_table`
-      - ``pred_weight_table``
-      - The prediction weight coefficients for inter-picture prediction.
-    * - __u64
-      - ``flags``
-      - See :ref:`Slice Parameters Flags <hevc_slice_params_flags>`
-
-.. raw:: latex
-
-    \normalsize
-
-.. _hevc_slice_params_flags:
-
-``Slice Parameters Flags``
-
-.. raw:: latex
-
-    \scriptsize
-
-.. flat-table::
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_LUMA``
-      - 0x00000001
-      -
-    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_CHROMA``
-      - 0x00000002
-      -
-    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_TEMPORAL_MVP_ENABLED``
-      - 0x00000004
-      -
-    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_MVD_L1_ZERO``
-      - 0x00000008
-      -
-    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_CABAC_INIT``
-      - 0x00000010
-      -
-    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_COLLOCATED_FROM_L0``
-      - 0x00000020
-      -
-    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_USE_INTEGER_MV``
-      - 0x00000040
-      -
-    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_DEBLOCKING_FILTER_DISABLED``
-      - 0x00000080
-      -
-    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED``
-      - 0x00000100
-      -
-    * - ``V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT``
-      - 0x00000200
-      -
-
-.. raw:: latex
-
-    \normalsize
-
-``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
-    Specifies entry point offsets in bytes.
-    This control is a dynamically sized array. The number of entry point
-    offsets is reported by the ``elems`` field.
-    This bitstream parameter is defined according to :ref:`hevc`.
-    They are described in section 7.4.7.1 "General slice segment header
-    semantics" of the specification.
-
-``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
-    Specifies the HEVC scaling matrix parameters used for the scaling process
-    for transform coefficients.
-    These matrix and parameters are defined according to :ref:`hevc`.
-    They are described in section 7.4.5 "Scaling list data semantics" of
-    the specification.
-
-.. c:type:: v4l2_ctrl_hevc_scaling_matrix
-
-.. raw:: latex
-
-    \scriptsize
-
-.. tabularcolumns:: |p{5.4cm}|p{6.8cm}|p{5.1cm}|
-
-.. cssclass:: longtable
-
-.. flat-table:: struct v4l2_ctrl_hevc_scaling_matrix
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - __u8
-      - ``scaling_list_4x4[6][16]``
-      - Scaling list is used for the scaling process for transform
-        coefficients. The values on each scaling list are expected
-        in raster scan order.
-    * - __u8
-      - ``scaling_list_8x8[6][64]``
-      - Scaling list is used for the scaling process for transform
-        coefficients. The values on each scaling list are expected
-        in raster scan order.
-    * - __u8
-      - ``scaling_list_16x16[6][64]``
-      - Scaling list is used for the scaling process for transform
-        coefficients. The values on each scaling list are expected
-        in raster scan order.
-    * - __u8
-      - ``scaling_list_32x32[2][64]``
-      - Scaling list is used for the scaling process for transform
-        coefficients. The values on each scaling list are expected
-        in raster scan order.
-    * - __u8
-      - ``scaling_list_dc_coef_16x16[6]``
-      - Scaling list is used for the scaling process for transform
-        coefficients. The values on each scaling list are expected
-        in raster scan order.
-    * - __u8
-      - ``scaling_list_dc_coef_32x32[2]``
-      - Scaling list is used for the scaling process for transform
-        coefficients. The values on each scaling list are expected
-        in raster scan order.
-
-.. raw:: latex
-
-    \normalsize
-
-.. c:type:: v4l2_hevc_dpb_entry
-
-.. raw:: latex
-
-    \small
-
-.. tabularcolumns:: |p{1.0cm}|p{4.2cm}|p{12.1cm}|
-
-.. flat-table:: struct v4l2_hevc_dpb_entry
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - __u64
-      - ``timestamp``
-      - Timestamp of the V4L2 capture buffer to use as reference, used
-        with B-coded and P-coded frames. The timestamp refers to the
-	``timestamp`` field in struct :c:type:`v4l2_buffer`. Use the
-	:c:func:`v4l2_timeval_to_ns()` function to convert the struct
-	:c:type:`timeval` in struct :c:type:`v4l2_buffer` to a __u64.
-    * - __u8
-      - ``flags``
-      - Long term flag for the reference frame
-        (V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE). The flag is set as
-        described in the ITU HEVC specification chapter "8.3.2 Decoding
-        process for reference picture set".
-    * - __u8
-      - ``field_pic``
-      - Whether the reference is a field picture or a frame.
-        See :ref:`HEVC dpb field pic Flags <hevc_dpb_field_pic_flags>`
-    * - __s32
-      - ``pic_order_cnt_val``
-      - The picture order count of the current picture.
-    * - __u8
-      - ``padding[2]``
-      - Applications and drivers must set this to zero.
-
-.. raw:: latex
-
-    \normalsize
-
-.. _hevc_dpb_field_pic_flags:
-
-``HEVC dpb field pic Flags``
-
-.. raw:: latex
-
-    \scriptsize
-
-.. flat-table::
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_FRAME``
-      - 0
-      - (progressive) Frame
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_FIELD``
-      - 1
-      - Top field
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_FIELD``
-      - 2
-      - Bottom field
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM``
-      - 3
-      - Top field, bottom field, in that order
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP``
-      - 4
-      - Bottom field, top field, in that order
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM_TOP``
-      - 5
-      - Top field, bottom field, top field repeated, in that order
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP_BOTTOM``
-      - 6
-      - Bottom field, top field, bottom field repeated, in that order
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_FRAME_DOUBLING``
-      - 7
-      - Frame doubling
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_FRAME_TRIPLING``
-      - 8
-      - Frame tripling
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_PREVIOUS_BOTTOM``
-      - 9
-      - Top field paired with previous bottom field in output order
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_PREVIOUS_TOP``
-      - 10
-      - Bottom field paired with previous top field in output order
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_NEXT_BOTTOM``
-      - 11
-      - Top field paired with next bottom field in output order
-    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_NEXT_TOP``
-      - 12
-      - Bottom field paired with next top field in output order
-
-.. c:type:: v4l2_hevc_pred_weight_table
-
-.. raw:: latex
-
-    \footnotesize
-
-.. tabularcolumns:: |p{0.8cm}|p{10.6cm}|p{5.9cm}|
-
-.. flat-table:: struct v4l2_hevc_pred_weight_table
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - __s8
-      - ``delta_luma_weight_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
-      - The difference of the weighting factor applied to the luma
-        prediction value for list 0.
-    * - __s8
-      - ``luma_offset_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
-      - The additive offset applied to the luma prediction value for list 0.
-    * - __s8
-      - ``delta_chroma_weight_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2]``
-      - The difference of the weighting factor applied to the chroma
-        prediction value for list 0.
-    * - __s8
-      - ``chroma_offset_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2]``
-      - The difference of the additive offset applied to the chroma
-        prediction values for list 0.
-    * - __s8
-      - ``delta_luma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
-      - The difference of the weighting factor applied to the luma
-        prediction value for list 1.
-    * - __s8
-      - ``luma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
-      - The additive offset applied to the luma prediction value for list 1.
-    * - __s8
-      - ``delta_chroma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2]``
-      - The difference of the weighting factor applied to the chroma
-        prediction value for list 1.
-    * - __s8
-      - ``chroma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2]``
-      - The difference of the additive offset applied to the chroma
-        prediction values for list 1.
-    * - __u8
-      - ``luma_log2_weight_denom``
-      - The base 2 logarithm of the denominator for all luma weighting
-        factors.
-    * - __s8
-      - ``delta_chroma_log2_weight_denom``
-      - The difference of the base 2 logarithm of the denominator for
-        all chroma weighting factors.
-    * - __u8
-      - ``padding[6]``
-      - Applications and drivers must set this to zero.
-
-.. raw:: latex
-
-    \normalsize
-
-``V4L2_CID_STATELESS_HEVC_DECODE_MODE (enum)``
-    Specifies the decoding mode to use. Currently exposes slice-based and
-    frame-based decoding but new modes might be added later on.
-    This control is used as a modifier for V4L2_PIX_FMT_HEVC_SLICE
-    pixel format. Applications that support V4L2_PIX_FMT_HEVC_SLICE
-    are required to set this control in order to specify the decoding mode
-    that is expected for the buffer.
-    Drivers may expose a single or multiple decoding modes, depending
-    on what they can support.
-
-    .. note::
-
-       This menu control is not yet part of the public kernel API and
-       it is expected to change.
-
-.. c:type:: v4l2_stateless_hevc_decode_mode
-
-.. raw:: latex
-
-    \small
-
-.. tabularcolumns:: |p{9.4cm}|p{0.6cm}|p{7.3cm}|
-
-.. flat-table::
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - ``V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED``
-      - 0
-      - Decoding is done at the slice granularity.
-        The OUTPUT buffer must contain a single slice.
-    * - ``V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED``
-      - 1
-      - Decoding is done at the frame granularity.
-        The OUTPUT buffer must contain all slices needed to decode the
-        frame. The OUTPUT buffer must also contain both fields.
-
-.. raw:: latex
-
-    \normalsize
-
-``V4L2_CID_STATELESS_HEVC_START_CODE (enum)``
-    Specifies the HEVC slice start code expected for each slice.
-    This control is used as a modifier for V4L2_PIX_FMT_HEVC_SLICE
-    pixel format. Applications that support V4L2_PIX_FMT_HEVC_SLICE
-    are required to set this control in order to specify the start code
-    that is expected for the buffer.
-    Drivers may expose a single or multiple start codes, depending
-    on what they can support.
-
-    .. note::
-
-       This menu control is not yet part of the public kernel API and
-       it is expected to change.
-
-.. c:type:: v4l2_stateless_hevc_start_code
-
-.. tabularcolumns:: |p{9.2cm}|p{0.6cm}|p{7.5cm}|
-
-.. flat-table::
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - ``V4L2_STATELESS_HEVC_START_CODE_NONE``
-      - 0
-      - Selecting this value specifies that HEVC slices are passed
-        to the driver without any start code. The bitstream data should be
-        according to :ref:`hevc` 7.3.1.1 General NAL unit syntax, hence
-        contains emulation prevention bytes when required.
-    * - ``V4L2_STATELESS_HEVC_START_CODE_ANNEX_B``
-      - 1
-      - Selecting this value specifies that HEVC slices are expected
-        to be prefixed by Annex B start codes. According to :ref:`hevc`
-        valid start codes can be 3-bytes 0x000001 or 4-bytes 0x00000001.
-
-``V4L2_CID_MPEG_VIDEO_BASELAYER_PRIORITY_ID (integer)``
-    Specifies a priority identifier for the NAL unit, which will be applied to
-    the base layer. By default this value is set to 0 for the base layer,
-    and the next layer will have the priority ID assigned as 1, 2, 3 and so on.
-    The video encoder can't decide the priority id to be applied to a layer,
-    so this has to come from client.
-    This is applicable to H264 and valid Range is from 0 to 63.
-    Source Rec. ITU-T H.264 (06/2019); G.7.4.1.1, G.8.8.1.
-
-``V4L2_CID_MPEG_VIDEO_LTR_COUNT (integer)``
-    Specifies the maximum number of Long Term Reference (LTR) frames at any
-    given time that the encoder can keep.
-    This is applicable to the H264 and HEVC encoders.
-
-``V4L2_CID_MPEG_VIDEO_FRAME_LTR_INDEX (integer)``
-    After setting this control the frame that will be queued next
-    will be marked as a Long Term Reference (LTR) frame
-    and given this LTR index which ranges from 0 to LTR_COUNT-1.
-    This is applicable to the H264 and HEVC encoders.
-    Source Rec. ITU-T H.264 (06/2019); Table 7.9
-
-``V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES (bitmask)``
-    Specifies the Long Term Reference (LTR) frame(s) to be used for
-    encoding the next frame queued after setting this control.
-    This provides a bitmask which consists of bits [0, LTR_COUNT-1].
-    This is applicable to the H264 and HEVC encoders.
-
-``V4L2_CID_STATELESS_HEVC_DECODE_PARAMS (struct)``
-    Specifies various decode parameters, especially the references picture order
-    count (POC) for all the lists (short, long, before, current, after) and the
-    number of entries for each of them.
-    These parameters are defined according to :ref:`hevc`.
-    They are described in section 8.3 "Slice decoding process" of the
-    specification.
-
-.. c:type:: v4l2_ctrl_hevc_decode_params
-
-.. cssclass:: longtable
-
-.. flat-table:: struct v4l2_ctrl_hevc_decode_params
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - __s32
-      - ``pic_order_cnt_val``
-      - PicOrderCntVal as described in section 8.3.1 "Decoding process
-        for picture order count" of the specification.
-    * - __u16
-      - ``short_term_ref_pic_set_size``
-      - Specifies the size, in bits, of the short-term reference picture set, of the first slice
-        described as st_ref_pic_set() in the specification, included in the slice header
-        or SPS (section 7.3.6.1).
-    * - __u16
-      - ``long_term_ref_pic_set_size``
-      - Specifies the size, in bits, of the long-term reference picture set, of the first slice
-        included in the slice header or SPS. It is the number of bits in the conditional block
-        if(long_term_ref_pics_present_flag) in section 7.3.6.1 of the specification.
-    * - __u8
-      - ``num_active_dpb_entries``
-      - The number of entries in ``dpb``.
-    * - __u8
-      - ``num_poc_st_curr_before``
-      - The number of reference pictures in the short-term set that come before
-        the current frame.
-    * - __u8
-      - ``num_poc_st_curr_after``
-      - The number of reference pictures in the short-term set that come after
-        the current frame.
-    * - __u8
-      - ``num_poc_lt_curr``
-      - The number of reference pictures in the long-term set.
-    * - __u8
-      - ``poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
-      - PocStCurrBefore as described in section 8.3.2 "Decoding process for reference
-        picture set": provides the index of the short term before references in DPB array.
-    * - __u8
-      - ``poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
-      - PocStCurrAfter as described in section 8.3.2 "Decoding process for reference
-        picture set": provides the index of the short term after references in DPB array.
-    * - __u8
-      - ``poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
-      - PocLtCurr as described in section 8.3.2 "Decoding process for reference
-        picture set": provides the index of the long term references in DPB array.
-    * - struct :c:type:`v4l2_hevc_dpb_entry`
-      - ``dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
-      - The decoded picture buffer, for meta-data about reference frames.
-    * - __u64
-      - ``flags``
-      - See :ref:`Decode Parameters Flags <hevc_decode_params_flags>`
-
-.. _hevc_decode_params_flags:
-
-``Decode Parameters Flags``
-
-.. cssclass:: longtable
-
-.. flat-table::
-    :header-rows:  0
-    :stub-columns: 0
-    :widths:       1 1 2
-
-    * - ``V4L2_HEVC_DECODE_PARAM_FLAG_IRAP_PIC``
-      - 0x00000001
-      -
-    * - ``V4L2_HEVC_DECODE_PARAM_FLAG_IDR_PIC``
-      - 0x00000002
-      -
-    * - ``V4L2_HEVC_DECODE_PARAM_FLAG_NO_OUTPUT_OF_PRIOR``
-      - 0x00000004
-      -
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index c352d91a73d8..506dd3c98884 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -212,7 +212,7 @@ Compressed Formats
         ``V4L2_CID_MPEG_VIDEO_HEVC_SPS``,
         ``V4L2_CID_MPEG_VIDEO_HEVC_PPS``, and
         ``V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS``.
-	See the :ref:`associated Codec Control IDs <v4l2-mpeg-hevc>`.
+	See the :ref:`associated Codec Control IDs <v4l2-codec-stateless-hevc>`.
 	Buffers associated with this pixel format must contain the appropriate
 	number of macroblocks to decode a full corresponding frame.
     * .. _V4L2-PIX-FMT-FWHT:
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
index 29971a45a2d4..892cfeb8b988 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
@@ -249,6 +249,26 @@ still cause this situation.
       - ``p_hdr10_mastering``
       - A pointer to a struct :c:type:`v4l2_ctrl_hdr10_mastering_display`. Valid if this control is
         of type ``V4L2_CTRL_TYPE_HDR10_MASTERING_DISPLAY``.
+    * - struct :c:type:`v4l2_ctrl_hevc_sps` *
+      - ``p_hevc_sps``
+      - A pointer to a struct :c:type:`v4l2_ctrl_hevc_sps`. Valid if this
+        control is of type ``V4L2_CTRL_TYPE_HEVC_SPS``.
+    * - struct :c:type:`v4l2_ctrl_hevc_pps` *
+      - ``p_hevc_pps``
+      - A pointer to a struct :c:type:`v4l2_ctrl_hevc_pps`. Valid if this
+        control is of type ``V4L2_CTRL_TYPE_HEVC_PPS``.
+    * - struct :c:type:`v4l2_ctrl_hevc_slice_params` *
+      - ``p_hevc_slice_params``
+      - A pointer to a struct :c:type:`v4l2_ctrl_hevc_slice_params`. Valid if this
+        control is of type ``V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS``.
+    * - struct :c:type:`v4l2_ctrl_hevc_scaling_matrix` *
+      - ``p_hevc_scaling_matrix``
+      - A pointer to a struct :c:type:`v4l2_ctrl_hevc_scaling_matrix`. Valid if this
+        control is of type ``V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX``.
+    * - struct :c:type:`v4l2_ctrl_hevc_decode_params` *
+      - ``p_hevc_decode_params``
+      - A pointer to a struct :c:type:`v4l2_ctrl_hevc_decode_params`. Valid if this
+        control is of type ``V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS``.
     * - void *
       - ``ptr``
       - A pointer to a compound type which can be an N-dimensional array
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
deleted file mode 100644
index c89029b3c5da..000000000000
--- a/include/media/hevc-ctrls.h
+++ /dev/null
@@ -1,474 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * These are the HEVC state controls for use with stateless HEVC
- * codec drivers.
- *
- * It turns out that these structs are not stable yet and will undergo
- * more changes. So keep them private until they are stable and ready to
- * become part of the official public API.
- */
-
-#ifndef _HEVC_CTRLS_H_
-#define _HEVC_CTRLS_H_
-
-#include <linux/videodev2.h>
-
-#define V4L2_CID_STATELESS_HEVC_SPS		(V4L2_CID_CODEC_BASE + 1008)
-#define V4L2_CID_STATELESS_HEVC_PPS		(V4L2_CID_CODEC_BASE + 1009)
-#define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS	(V4L2_CID_CODEC_BASE + 1010)
-#define V4L2_CID_STATELESS_HEVC_SCALING_MATRIX	(V4L2_CID_CODEC_BASE + 1011)
-#define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE + 1012)
-#define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 1015)
-#define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
-#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_BASE + 1017)
-
-enum v4l2_stateless_hevc_decode_mode {
-	V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
-	V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
-};
-
-enum v4l2_stateless_hevc_start_code {
-	V4L2_STATELESS_HEVC_START_CODE_NONE,
-	V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
-};
-
-#define V4L2_HEVC_SLICE_TYPE_B	0
-#define V4L2_HEVC_SLICE_TYPE_P	1
-#define V4L2_HEVC_SLICE_TYPE_I	2
-
-#define V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE		(1ULL << 0)
-#define V4L2_HEVC_SPS_FLAG_SCALING_LIST_ENABLED			(1ULL << 1)
-#define V4L2_HEVC_SPS_FLAG_AMP_ENABLED				(1ULL << 2)
-#define V4L2_HEVC_SPS_FLAG_SAMPLE_ADAPTIVE_OFFSET		(1ULL << 3)
-#define V4L2_HEVC_SPS_FLAG_PCM_ENABLED				(1ULL << 4)
-#define V4L2_HEVC_SPS_FLAG_PCM_LOOP_FILTER_DISABLED		(1ULL << 5)
-#define V4L2_HEVC_SPS_FLAG_LONG_TERM_REF_PICS_PRESENT		(1ULL << 6)
-#define V4L2_HEVC_SPS_FLAG_SPS_TEMPORAL_MVP_ENABLED		(1ULL << 7)
-#define V4L2_HEVC_SPS_FLAG_STRONG_INTRA_SMOOTHING_ENABLED	(1ULL << 8)
-
-/**
- * struct v4l2_ctrl_hevc_sps - ITU-T Rec. H.265: Sequence parameter set
- *
- * @video_parameter_set_id: specifies the value of the
- *			    vps_video_parameter_set_id of the active VPS
- * @seq_parameter_set_id: provides an identifier for the SPS for
- *			  reference by other syntax elements
- * @pic_width_in_luma_samples: specifies the width of each decoded picture
- *			       in units of luma samples
- * @pic_height_in_luma_samples: specifies the height of each decoded picture
- *				in units of luma samples
- * @bit_depth_luma_minus8: this value plus 8 specifies the bit depth of the
- *                         samples of the luma array
- * @bit_depth_chroma_minus8: this value plus 8 specifies the bit depth of the
- *                           samples of the chroma arrays
- * @log2_max_pic_order_cnt_lsb_minus4: this value plus 4 specifies the value
- *                                     of the variable MaxPicOrderCntLsb
- * @sps_max_dec_pic_buffering_minus1: this value plus 1 specifies the maximum
- *                                    required size of the decoded picture
- *                                    buffer for the codec video sequence
- * @sps_max_num_reorder_pics: indicates the maximum allowed number of pictures
- * @sps_max_latency_increase_plus1: not equal to 0 is used to compute the
- *				    value of SpsMaxLatencyPictures array
- * @log2_min_luma_coding_block_size_minus3: this value plus 3 specifies the
- *                                          minimum luma coding block size
- * @log2_diff_max_min_luma_coding_block_size: specifies the difference between
- *					      the maximum and minimum luma
- *					      coding block size
- * @log2_min_luma_transform_block_size_minus2: this value plus 2 specifies the
- *                                             minimum luma transform block size
- * @log2_diff_max_min_luma_transform_block_size: specifies the difference between
- *						 the maximum and minimum luma
- *						 transform block size
- * @max_transform_hierarchy_depth_inter: specifies the maximum hierarchy
- *					 depth for transform units of
- *					 coding units coded in inter
- *					 prediction mode
- * @max_transform_hierarchy_depth_intra: specifies the maximum hierarchy
- *					 depth for transform units of
- *					 coding units coded in intra
- *					 prediction mode
- * @pcm_sample_bit_depth_luma_minus1: this value plus 1 specifies the number of
- *                                    bits used to represent each of PCM sample
- *                                    values of the luma component
- * @pcm_sample_bit_depth_chroma_minus1: this value plus 1 specifies the number
- *                                      of bits used to represent each of PCM
- *                                      sample values of the chroma components
- * @log2_min_pcm_luma_coding_block_size_minus3: this value plus 3 specifies the
- *                                              minimum size of coding blocks
- * @log2_diff_max_min_pcm_luma_coding_block_size: specifies the difference between
- *						  the maximum and minimum size of
- *						  coding blocks
- * @num_short_term_ref_pic_sets: specifies the number of st_ref_pic_set()
- *				 syntax structures included in the SPS
- * @num_long_term_ref_pics_sps:	specifies the number of candidate long-term
- *				reference pictures that are specified in the SPS
- * @chroma_format_idc: specifies the chroma sampling
- * @sps_max_sub_layers_minus1: this value plus 1 specifies the maximum number
- *                             of temporal sub-layers
- * @reserved: padding field. Should be zeroed by applications.
- * @flags: see V4L2_HEVC_SPS_FLAG_{}
- */
-struct v4l2_ctrl_hevc_sps {
-	__u8	video_parameter_set_id;
-	__u8	seq_parameter_set_id;
-	__u16	pic_width_in_luma_samples;
-	__u16	pic_height_in_luma_samples;
-	__u8	bit_depth_luma_minus8;
-	__u8	bit_depth_chroma_minus8;
-	__u8	log2_max_pic_order_cnt_lsb_minus4;
-	__u8	sps_max_dec_pic_buffering_minus1;
-	__u8	sps_max_num_reorder_pics;
-	__u8	sps_max_latency_increase_plus1;
-	__u8	log2_min_luma_coding_block_size_minus3;
-	__u8	log2_diff_max_min_luma_coding_block_size;
-	__u8	log2_min_luma_transform_block_size_minus2;
-	__u8	log2_diff_max_min_luma_transform_block_size;
-	__u8	max_transform_hierarchy_depth_inter;
-	__u8	max_transform_hierarchy_depth_intra;
-	__u8	pcm_sample_bit_depth_luma_minus1;
-	__u8	pcm_sample_bit_depth_chroma_minus1;
-	__u8	log2_min_pcm_luma_coding_block_size_minus3;
-	__u8	log2_diff_max_min_pcm_luma_coding_block_size;
-	__u8	num_short_term_ref_pic_sets;
-	__u8	num_long_term_ref_pics_sps;
-	__u8	chroma_format_idc;
-	__u8	sps_max_sub_layers_minus1;
-
-	__u8	reserved[6];
-	__u64	flags;
-};
-
-#define V4L2_HEVC_PPS_FLAG_DEPENDENT_SLICE_SEGMENT_ENABLED	(1ULL << 0)
-#define V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT			(1ULL << 1)
-#define V4L2_HEVC_PPS_FLAG_SIGN_DATA_HIDING_ENABLED		(1ULL << 2)
-#define V4L2_HEVC_PPS_FLAG_CABAC_INIT_PRESENT			(1ULL << 3)
-#define V4L2_HEVC_PPS_FLAG_CONSTRAINED_INTRA_PRED		(1ULL << 4)
-#define V4L2_HEVC_PPS_FLAG_TRANSFORM_SKIP_ENABLED		(1ULL << 5)
-#define V4L2_HEVC_PPS_FLAG_CU_QP_DELTA_ENABLED			(1ULL << 6)
-#define V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT	(1ULL << 7)
-#define V4L2_HEVC_PPS_FLAG_WEIGHTED_PRED			(1ULL << 8)
-#define V4L2_HEVC_PPS_FLAG_WEIGHTED_BIPRED			(1ULL << 9)
-#define V4L2_HEVC_PPS_FLAG_TRANSQUANT_BYPASS_ENABLED		(1ULL << 10)
-#define V4L2_HEVC_PPS_FLAG_TILES_ENABLED			(1ULL << 11)
-#define V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED		(1ULL << 12)
-#define V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED	(1ULL << 13)
-#define V4L2_HEVC_PPS_FLAG_PPS_LOOP_FILTER_ACROSS_SLICES_ENABLED (1ULL << 14)
-#define V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_OVERRIDE_ENABLED	(1ULL << 15)
-#define V4L2_HEVC_PPS_FLAG_PPS_DISABLE_DEBLOCKING_FILTER	(1ULL << 16)
-#define V4L2_HEVC_PPS_FLAG_LISTS_MODIFICATION_PRESENT		(1ULL << 17)
-#define V4L2_HEVC_PPS_FLAG_SLICE_SEGMENT_HEADER_EXTENSION_PRESENT (1ULL << 18)
-#define V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT	(1ULL << 19)
-#define V4L2_HEVC_PPS_FLAG_UNIFORM_SPACING			(1ULL << 20)
-
-/**
- * struct v4l2_ctrl_hevc_pps - ITU-T Rec. H.265: Picture parameter set
- *
- * @pic_parameter_set_id: identifies the PPS for reference by other
- *			  syntax elements
- * @num_extra_slice_header_bits: specifies the number of extra slice header
- *				 bits that are present in the slice header RBSP
- *				 for coded pictures referring to the PPS.
- * @num_ref_idx_l0_default_active_minus1: this value plus 1 specifies the inferred
- *                                        value of num_ref_idx_l0_active_minus1
- * @num_ref_idx_l1_default_active_minus1: this value plus 1 specifies the inferred
- *                                        value of num_ref_idx_l1_active_minus1
- * @init_qp_minus26: this value plus 26 specifies the initial value of SliceQp Y
- *                   for each slice referring to the PPS
- * @diff_cu_qp_delta_depth: specifies the difference between the luma coding
- *			    tree block size and the minimum luma coding block
- *			    size of coding units that convey cu_qp_delta_abs
- *			    and cu_qp_delta_sign_flag
- * @pps_cb_qp_offset: specify the offsets to the luma quantization parameter Cb
- * @pps_cr_qp_offset: specify the offsets to the luma quantization parameter Cr
- * @num_tile_columns_minus1: this value plus 1 specifies the number of tile columns
- *			     partitioning the picture
- * @num_tile_rows_minus1: this value plus 1 specifies the number of tile rows
- *                        partitioning the picture
- * @column_width_minus1: this value plus 1 specifies the width of each tile column
- *                       in units of coding tree blocks
- * @row_height_minus1: this value plus 1 specifies the height of each tile row in
- *		       units of coding tree blocks
- * @pps_beta_offset_div2: specify the default deblocking parameter offsets for
- *			  beta divided by 2
- * @pps_tc_offset_div2: specify the default deblocking parameter offsets for tC
- *			divided by 2
- * @log2_parallel_merge_level_minus2: this value plus 2 specifies the value of
- *                                    the variable Log2ParMrgLevel
- * @reserved: padding field. Should be zeroed by applications.
- * @flags: see V4L2_HEVC_PPS_FLAG_{}
- */
-struct v4l2_ctrl_hevc_pps {
-	__u8	pic_parameter_set_id;
-	__u8	num_extra_slice_header_bits;
-	__u8	num_ref_idx_l0_default_active_minus1;
-	__u8	num_ref_idx_l1_default_active_minus1;
-	__s8	init_qp_minus26;
-	__u8	diff_cu_qp_delta_depth;
-	__s8	pps_cb_qp_offset;
-	__s8	pps_cr_qp_offset;
-	__u8	num_tile_columns_minus1;
-	__u8	num_tile_rows_minus1;
-	__u8	column_width_minus1[20];
-	__u8	row_height_minus1[22];
-	__s8	pps_beta_offset_div2;
-	__s8	pps_tc_offset_div2;
-	__u8	log2_parallel_merge_level_minus2;
-	__u8	reserved;
-	__u64	flags;
-};
-
-#define V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE	0x01
-
-#define V4L2_HEVC_SEI_PIC_STRUCT_FRAME				0
-#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_FIELD			1
-#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_FIELD			2
-#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM			3
-#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP			4
-#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM_TOP			5
-#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP_BOTTOM		6
-#define V4L2_HEVC_SEI_PIC_STRUCT_FRAME_DOUBLING			7
-#define V4L2_HEVC_SEI_PIC_STRUCT_FRAME_TRIPLING			8
-#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_PREVIOUS_BOTTOM	9
-#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_PREVIOUS_TOP	10
-#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_NEXT_BOTTOM		11
-#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_NEXT_TOP		12
-
-#define V4L2_HEVC_DPB_ENTRIES_NUM_MAX		16
-
-/**
- * struct v4l2_hevc_dpb_entry - HEVC decoded picture buffer entry
- *
- * @timestamp: timestamp of the V4L2 capture buffer to use as reference.
- * @flags: long term flag for the reference frame
- * @field_pic: whether the reference is a field picture or a frame.
- * @reserved: padding field. Should be zeroed by applications.
- * @pic_order_cnt_val: the picture order count of the reference.
- */
-struct v4l2_hevc_dpb_entry {
-	__u64	timestamp;
-	__u8	flags;
-	__u8	field_pic;
-	__u16	reserved;
-	__s32	pic_order_cnt_val;
-};
-
-/**
- * struct v4l2_hevc_pred_weight_table - HEVC weighted prediction parameters
- *
- * @delta_luma_weight_l0: the difference of the weighting factor applied
- *			  to the luma prediction value for list 0
- * @luma_offset_l0: the additive offset applied to the luma prediction value
- *		    for list 0
- * @delta_chroma_weight_l0: the difference of the weighting factor applied
- *			    to the chroma prediction values for list 0
- * @chroma_offset_l0: the difference of the additive offset applied to
- *		      the chroma prediction values for list 0
- * @delta_luma_weight_l1: the difference of the weighting factor applied
- *			  to the luma prediction value for list 1
- * @luma_offset_l1: the additive offset applied to the luma prediction value
- *		    for list 1
- * @delta_chroma_weight_l1: the difference of the weighting factor applied
- *			    to the chroma prediction values for list 1
- * @chroma_offset_l1: the difference of the additive offset applied to
- *		      the chroma prediction values for list 1
- * @luma_log2_weight_denom: the base 2 logarithm of the denominator for
- *			    all luma weighting factors
- * @delta_chroma_log2_weight_denom: the difference of the base 2 logarithm
- *				    of the denominator for all chroma
- *				    weighting factors
- */
-struct v4l2_hevc_pred_weight_table {
-	__s8	delta_luma_weight_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__s8	luma_offset_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__s8	delta_chroma_weight_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
-	__s8	chroma_offset_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
-
-	__s8	delta_luma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__s8	luma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__s8	delta_chroma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
-	__s8	chroma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
-
-	__u8	luma_log2_weight_denom;
-	__s8	delta_chroma_log2_weight_denom;
-};
-
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_LUMA		(1ULL << 0)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_CHROMA		(1ULL << 1)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_TEMPORAL_MVP_ENABLED	(1ULL << 2)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_MVD_L1_ZERO			(1ULL << 3)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_CABAC_INIT			(1ULL << 4)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_COLLOCATED_FROM_L0		(1ULL << 5)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_USE_INTEGER_MV		(1ULL << 6)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_DEBLOCKING_FILTER_DISABLED (1ULL << 7)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED (1ULL << 8)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL << 9)
-
-/**
- * struct v4l2_ctrl_hevc_slice_params - HEVC slice parameters
- *
- * This control is a dynamically sized 1-dimensional array,
- * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
- *
- * @bit_size: size (in bits) of the current slice data
- * @data_byte_offset: offset (in bytes) to the video data in the current slice data
- * @num_entry_point_offsets: specifies the number of entry point offset syntax
- *			     elements in the slice header.
- * @nal_unit_type: specifies the coding type of the slice (B, P or I)
- * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier for the NAL unit
- * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
- * @colour_plane_id: specifies the colour plane associated with the current slice
- * @slice_pic_order_cnt: specifies the picture order count
- * @num_ref_idx_l0_active_minus1: this value plus 1 specifies the maximum reference
- *                                index for reference picture list 0 that may be
- *                                used to decode the slice
- * @num_ref_idx_l1_active_minus1: this value plus 1 specifies the maximum reference
- *                                index for reference picture list 1 that may be
- *                                used to decode the slice
- * @collocated_ref_idx: specifies the reference index of the collocated picture used
- *			for temporal motion vector prediction
- * @five_minus_max_num_merge_cand: specifies the maximum number of merging
- *				   motion vector prediction candidates supported in
- *				   the slice subtracted from 5
- * @slice_qp_delta: specifies the initial value of QpY to be used for the coding
- *		    blocks in the slice
- * @slice_cb_qp_offset: specifies a difference to be added to the value of pps_cb_qp_offset
- * @slice_cr_qp_offset: specifies a difference to be added to the value of pps_cr_qp_offset
- * @slice_act_y_qp_offset: screen content extension parameters
- * @slice_act_cb_qp_offset: screen content extension parameters
- * @slice_act_cr_qp_offset: screen content extension parameters
- * @slice_beta_offset_div2: specify the deblocking parameter offsets for beta divided by 2
- * @slice_tc_offset_div2: specify the deblocking parameter offsets for tC divided by 2
- * @pic_struct: indicates whether a picture should be displayed as a frame or as one or
- *		more fields
- * @reserved0: padding field. Should be zeroed by applications.
- * @slice_segment_addr: specifies the address of the first coding tree block in
- *			the slice segment
- * @ref_idx_l0: the list of L0 reference elements as indices in the DPB
- * @ref_idx_l1: the list of L1 reference elements as indices in the DPB
- * @short_term_ref_pic_set_size: specifies the size of short-term reference
- *				 pictures included in the SPS
- * @long_term_ref_pic_set_size: specifies the size of long-term reference
- *				picture include in the SPS
- * @pred_weight_table: the prediction weight coefficients for inter-picture
- *		       prediction
- * @reserved1: padding field. Should be zeroed by applications.
- * @flags: see V4L2_HEVC_SLICE_PARAMS_FLAG_{}
- */
-struct v4l2_ctrl_hevc_slice_params {
-	__u32	bit_size;
-	__u32	data_byte_offset;
-	__u32	num_entry_point_offsets;
-	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
-	__u8	nal_unit_type;
-	__u8	nuh_temporal_id_plus1;
-
-	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
-	__u8	slice_type;
-	__u8	colour_plane_id;
-	__s32	slice_pic_order_cnt;
-	__u8	num_ref_idx_l0_active_minus1;
-	__u8	num_ref_idx_l1_active_minus1;
-	__u8	collocated_ref_idx;
-	__u8	five_minus_max_num_merge_cand;
-	__s8	slice_qp_delta;
-	__s8	slice_cb_qp_offset;
-	__s8	slice_cr_qp_offset;
-	__s8	slice_act_y_qp_offset;
-	__s8	slice_act_cb_qp_offset;
-	__s8	slice_act_cr_qp_offset;
-	__s8	slice_beta_offset_div2;
-	__s8	slice_tc_offset_div2;
-
-	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI message */
-	__u8	pic_struct;
-
-	__u8	reserved0[3];
-	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
-	__u32	slice_segment_addr;
-	__u8	ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u8	ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u16	short_term_ref_pic_set_size;
-	__u16	long_term_ref_pic_set_size;
-
-	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction parameter */
-	struct v4l2_hevc_pred_weight_table pred_weight_table;
-
-	__u8	reserved1[2];
-	__u64	flags;
-};
-
-#define V4L2_HEVC_DECODE_PARAM_FLAG_IRAP_PIC		0x1
-#define V4L2_HEVC_DECODE_PARAM_FLAG_IDR_PIC		0x2
-#define V4L2_HEVC_DECODE_PARAM_FLAG_NO_OUTPUT_OF_PRIOR  0x4
-
-/**
- * struct v4l2_ctrl_hevc_decode_params - HEVC decode parameters
- *
- * @pic_order_cnt_val: picture order count
- * @short_term_ref_pic_set_size: specifies the size of short-term reference
- *				 pictures set included in the SPS of the first slice
- * @long_term_ref_pic_set_size: specifies the size of long-term reference
- *				pictures set include in the SPS of the first slice
- * @num_active_dpb_entries: the number of entries in dpb
- * @num_poc_st_curr_before: the number of reference pictures in the short-term
- *			    set that come before the current frame
- * @num_poc_st_curr_after: the number of reference pictures in the short-term
- *			   set that come after the current frame
- * @num_poc_lt_curr: the number of reference pictures in the long-term set
- * @poc_st_curr_before: provides the index of the short term before references
- *			in DPB array
- * @poc_st_curr_after: provides the index of the short term after references
- *		       in DPB array
- * @poc_lt_curr: provides the index of the long term references in DPB array
- * @reserved: padding field. Should be zeroed by applications.
- * @dpb: the decoded picture buffer, for meta-data about reference frames
- * @flags: see V4L2_HEVC_DECODE_PARAM_FLAG_{}
- */
-struct v4l2_ctrl_hevc_decode_params {
-	__s32	pic_order_cnt_val;
-	__u16	short_term_ref_pic_set_size;
-	__u16	long_term_ref_pic_set_size;
-	__u8	num_active_dpb_entries;
-	__u8	num_poc_st_curr_before;
-	__u8	num_poc_st_curr_after;
-	__u8	num_poc_lt_curr;
-	__u8	poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u8	poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u8	poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u8	reserved[4];
-	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u64	flags;
-};
-
-/**
- * struct v4l2_ctrl_hevc_scaling_matrix - HEVC scaling lists parameters
- *
- * @scaling_list_4x4: scaling list is used for the scaling process for
- *		      transform coefficients. The values on each scaling
- *		      list are expected in raster scan order
- * @scaling_list_8x8: scaling list is used for the scaling process for
- *		      transform coefficients. The values on each scaling
- *		      list are expected in raster scan order
- * @scaling_list_16x16: scaling list is used for the scaling process for
- *			transform coefficients. The values on each scaling
- *			list are expected in raster scan order
- * @scaling_list_32x32:	scaling list is used for the scaling process for
- *			transform coefficients. The values on each scaling
- *			list are expected in raster scan order
- * @scaling_list_dc_coef_16x16: scaling list is used for the scaling process
- *				for transform coefficients. The values on each
- *				scaling list are expected in raster scan order.
- * @scaling_list_dc_coef_32x32:	scaling list is used for the scaling process
- *				for transform coefficients. The values on each
- *				scaling list are expected in raster scan order.
- */
-struct v4l2_ctrl_hevc_scaling_matrix {
-	__u8	scaling_list_4x4[6][16];
-	__u8	scaling_list_8x8[6][64];
-	__u8	scaling_list_16x16[6][64];
-	__u8	scaling_list_32x32[2][64];
-	__u8	scaling_list_dc_coef_16x16[6];
-	__u8	scaling_list_dc_coef_32x32[2];
-};
-
-#endif
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index f4105de8a8d2..00828a4f9404 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -13,12 +13,6 @@
 #include <linux/videodev2.h>
 #include <media/media-request.h>
 
-/*
- * Include the stateless codec compound control definitions.
- * This will move to the public headers once this API is fully stable.
- */
-#include <media/hevc-ctrls.h>
-
 /* forward references */
 struct file;
 struct poll_table_struct;
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index dfff69ed88f7..5f46bf4a570c 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -1997,6 +1997,465 @@ struct v4l2_ctrl_mpeg2_quantisation {
 	__u8	chroma_non_intra_quantiser_matrix[64];
 };
 
+#define V4L2_CID_STATELESS_HEVC_SPS		(V4L2_CID_CODEC_STATELESS_BASE + 400)
+#define V4L2_CID_STATELESS_HEVC_PPS		(V4L2_CID_CODEC_STATELESS_BASE + 401)
+#define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS	(V4L2_CID_CODEC_STATELESS_BASE + 402)
+#define V4L2_CID_STATELESS_HEVC_SCALING_MATRIX	(V4L2_CID_CODEC_STATELESS_BASE + 403)
+#define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_STATELESS_BASE + 404)
+#define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_STATELESS_BASE + 405)
+#define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_STATELESS_BASE + 406)
+#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_STATELESS_BASE + 407)
+
+enum v4l2_stateless_hevc_decode_mode {
+	V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
+	V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
+};
+
+enum v4l2_stateless_hevc_start_code {
+	V4L2_STATELESS_HEVC_START_CODE_NONE,
+	V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
+};
+
+#define V4L2_HEVC_SLICE_TYPE_B	0
+#define V4L2_HEVC_SLICE_TYPE_P	1
+#define V4L2_HEVC_SLICE_TYPE_I	2
+
+#define V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE		(1ULL << 0)
+#define V4L2_HEVC_SPS_FLAG_SCALING_LIST_ENABLED			(1ULL << 1)
+#define V4L2_HEVC_SPS_FLAG_AMP_ENABLED				(1ULL << 2)
+#define V4L2_HEVC_SPS_FLAG_SAMPLE_ADAPTIVE_OFFSET		(1ULL << 3)
+#define V4L2_HEVC_SPS_FLAG_PCM_ENABLED				(1ULL << 4)
+#define V4L2_HEVC_SPS_FLAG_PCM_LOOP_FILTER_DISABLED		(1ULL << 5)
+#define V4L2_HEVC_SPS_FLAG_LONG_TERM_REF_PICS_PRESENT		(1ULL << 6)
+#define V4L2_HEVC_SPS_FLAG_SPS_TEMPORAL_MVP_ENABLED		(1ULL << 7)
+#define V4L2_HEVC_SPS_FLAG_STRONG_INTRA_SMOOTHING_ENABLED	(1ULL << 8)
+
+/**
+ * struct v4l2_ctrl_hevc_sps - ITU-T Rec. H.265: Sequence parameter set
+ *
+ * @video_parameter_set_id: specifies the value of the
+ *			vps_video_parameter_set_id of the active VPS
+ * @seq_parameter_set_id: provides an identifier for the SPS for
+ *			  reference by other syntax elements
+ * @pic_width_in_luma_samples:	specifies the width of each decoded picture
+ *				in units of luma samples
+ * @pic_height_in_luma_samples: specifies the height of each decoded picture
+ *				in units of luma samples
+ * @bit_depth_luma_minus8: this value plus 8specifies the bit depth of the
+ *                         samples of the luma array
+ * @bit_depth_chroma_minus8: this value plus 8 specifies the bit depth of the
+ *                           samples of the chroma arrays
+ * @log2_max_pic_order_cnt_lsb_minus4: this value plus 4 specifies the value of
+ *                                     the variable MaxPicOrderCntLsb
+ * @sps_max_dec_pic_buffering_minus1: this value plus 1 specifies the maximum
+ *                                    required size of the decoded picture
+ *                                    buffer for the codec video sequence
+ * @sps_max_num_reorder_pics: indicates the maximum allowed number of pictures
+ * @sps_max_latency_increase_plus1: not equal to 0 is used to compute the
+ *				    value of SpsMaxLatencyPictures array
+ * @log2_min_luma_coding_block_size_minus3: plus 3 specifies the minimum
+ *					    luma coding block size
+ * @log2_diff_max_min_luma_coding_block_size: specifies the difference between
+ *					      the maximum and minimum luma
+ *					      coding block size
+ * @log2_min_luma_transform_block_size_minus2: plus 2 specifies the minimum luma
+ *					       transform block size
+ * @log2_diff_max_min_luma_transform_block_size: specifies the difference between
+ *						 the maximum and minimum luma
+ *						 transform block size
+ * @max_transform_hierarchy_depth_inter: specifies the maximum hierarchy
+ *					 depth for transform units of
+ *					 coding units coded in inter
+ *					 prediction mode
+ * @max_transform_hierarchy_depth_intra: specifies the maximum hierarchy
+ *					 depth for transform units of
+ *					 coding units coded in intra
+ *					 prediction mode
+ * @pcm_sample_bit_depth_luma_minus1: this value plus 1 specifies the number of
+ *                                    bits used to represent each of PCM sample
+ *                                    values of the luma component
+ * @pcm_sample_bit_depth_chroma_minus1: this value plus 1 specifies the number
+ *                                      of bits used to represent each of PCM
+ *                                      sample values of the chroma components
+ * @log2_min_pcm_luma_coding_block_size_minus3: this value plus 3 specifies the
+ *                                              minimum size of coding blocks
+ * @log2_diff_max_min_pcm_luma_coding_block_size: specifies the difference between
+ *						  the maximum and minimum size of
+ *						  coding blocks
+ * @num_short_term_ref_pic_sets: specifies the number of st_ref_pic_set()
+ *				 syntax structures included in the SPS
+ * @num_long_term_ref_pics_sps: specifies the number of candidate long-term
+ *				reference pictures that are specified in the SPS
+ * @chroma_format_idc: specifies the chroma sampling
+ * @sps_max_sub_layers_minus1: this value plus 1 specifies the maximum number
+ *                             of temporal sub-layers
+ * @reserved: padding field. Should be zeroed by applications.
+ * @flags: see V4L2_HEVC_SPS_FLAG_{}
+ */
+struct v4l2_ctrl_hevc_sps {
+	__u8	video_parameter_set_id;
+	__u8	seq_parameter_set_id;
+	__u16	pic_width_in_luma_samples;
+	__u16	pic_height_in_luma_samples;
+	__u8	bit_depth_luma_minus8;
+	__u8	bit_depth_chroma_minus8;
+	__u8	log2_max_pic_order_cnt_lsb_minus4;
+	__u8	sps_max_dec_pic_buffering_minus1;
+	__u8	sps_max_num_reorder_pics;
+	__u8	sps_max_latency_increase_plus1;
+	__u8	log2_min_luma_coding_block_size_minus3;
+	__u8	log2_diff_max_min_luma_coding_block_size;
+	__u8	log2_min_luma_transform_block_size_minus2;
+	__u8	log2_diff_max_min_luma_transform_block_size;
+	__u8	max_transform_hierarchy_depth_inter;
+	__u8	max_transform_hierarchy_depth_intra;
+	__u8	pcm_sample_bit_depth_luma_minus1;
+	__u8	pcm_sample_bit_depth_chroma_minus1;
+	__u8	log2_min_pcm_luma_coding_block_size_minus3;
+	__u8	log2_diff_max_min_pcm_luma_coding_block_size;
+	__u8	num_short_term_ref_pic_sets;
+	__u8	num_long_term_ref_pics_sps;
+	__u8	chroma_format_idc;
+	__u8	sps_max_sub_layers_minus1;
+
+	__u8	reserved[6];
+	__u64	flags;
+};
+
+#define V4L2_HEVC_PPS_FLAG_DEPENDENT_SLICE_SEGMENT_ENABLED	(1ULL << 0)
+#define V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT			(1ULL << 1)
+#define V4L2_HEVC_PPS_FLAG_SIGN_DATA_HIDING_ENABLED		(1ULL << 2)
+#define V4L2_HEVC_PPS_FLAG_CABAC_INIT_PRESENT			(1ULL << 3)
+#define V4L2_HEVC_PPS_FLAG_CONSTRAINED_INTRA_PRED		(1ULL << 4)
+#define V4L2_HEVC_PPS_FLAG_TRANSFORM_SKIP_ENABLED		(1ULL << 5)
+#define V4L2_HEVC_PPS_FLAG_CU_QP_DELTA_ENABLED			(1ULL << 6)
+#define V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT	(1ULL << 7)
+#define V4L2_HEVC_PPS_FLAG_WEIGHTED_PRED			(1ULL << 8)
+#define V4L2_HEVC_PPS_FLAG_WEIGHTED_BIPRED			(1ULL << 9)
+#define V4L2_HEVC_PPS_FLAG_TRANSQUANT_BYPASS_ENABLED		(1ULL << 10)
+#define V4L2_HEVC_PPS_FLAG_TILES_ENABLED			(1ULL << 11)
+#define V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED		(1ULL << 12)
+#define V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED	(1ULL << 13)
+#define V4L2_HEVC_PPS_FLAG_PPS_LOOP_FILTER_ACROSS_SLICES_ENABLED (1ULL << 14)
+#define V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_OVERRIDE_ENABLED	(1ULL << 15)
+#define V4L2_HEVC_PPS_FLAG_PPS_DISABLE_DEBLOCKING_FILTER	(1ULL << 16)
+#define V4L2_HEVC_PPS_FLAG_LISTS_MODIFICATION_PRESENT		(1ULL << 17)
+#define V4L2_HEVC_PPS_FLAG_SLICE_SEGMENT_HEADER_EXTENSION_PRESENT (1ULL << 18)
+#define V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT	(1ULL << 19)
+#define V4L2_HEVC_PPS_FLAG_UNIFORM_SPACING			(1ULL << 20)
+
+/**
+ * struct v4l2_ctrl_hevc_pps - ITU-T Rec. H.265: Picture parameter set
+ *
+ * @pic_parameter_set_id: identifies the PPS for reference by other
+ *			  syntax elements
+ * @num_extra_slice_header_bits: specifies the number of extra slice header
+ *				 bits that are present in the slice header RBSP
+ *				 for coded pictures referring to the PPS.
+ * @num_ref_idx_l0_default_active_minus1: this value plus 1 specifies the
+ *                                        inferred value of num_ref_idx_l0_active_minus1
+ * @num_ref_idx_l1_default_active_minus1: this value plus 1 specifies the
+ *                                        inferred value of num_ref_idx_l1_active_minus1
+ * @init_qp_minus26: this value plus 26 specifies the initial value of SliceQp Y for
+ *		     each slice referring to the PPS
+ * @diff_cu_qp_delta_depth: specifies the difference between the luma coding
+ *			    tree block size and the minimum luma coding block
+ *			    size of coding units that convey cu_qp_delta_abs
+ *			    and cu_qp_delta_sign_flag
+ * @pps_cb_qp_offset: specify the offsets to the luma quantization parameter Cb
+ * @pps_cr_qp_offset: specify the offsets to the luma quantization parameter Cr
+ * @num_tile_columns_minus1: this value plus 1 specifies the number of tile columns
+ *			     partitioning the picture
+ * @num_tile_rows_minus1: this value plus 1 specifies the number of tile rows partitioning
+ *			  the picture
+ * @column_width_minus1: this value plus 1 specifies the width of the each tile column in
+ *			 units of coding tree blocks
+ * @row_height_minus1: this value plus 1 specifies the height of the each tile row in
+ *		       units of coding tree blocks
+ * @pps_beta_offset_div2: specify the default deblocking parameter offsets for
+ *			  beta divided by 2
+ * @pps_tc_offset_div2: specify the default deblocking parameter offsets for tC
+ *			divided by 2
+ * @log2_parallel_merge_level_minus2: this value plus 2 specifies the value of
+ *                                    the variable Log2ParMrgLevel
+ * @reserved: padding field. Should be zeroed by applications.
+ * @flags: see V4L2_HEVC_PPS_FLAG_{}
+ */
+struct v4l2_ctrl_hevc_pps {
+	__u8	pic_parameter_set_id;
+	__u8	num_extra_slice_header_bits;
+	__u8	num_ref_idx_l0_default_active_minus1;
+	__u8	num_ref_idx_l1_default_active_minus1;
+	__s8	init_qp_minus26;
+	__u8	diff_cu_qp_delta_depth;
+	__s8	pps_cb_qp_offset;
+	__s8	pps_cr_qp_offset;
+	__u8	num_tile_columns_minus1;
+	__u8	num_tile_rows_minus1;
+	__u8	column_width_minus1[20];
+	__u8	row_height_minus1[22];
+	__s8	pps_beta_offset_div2;
+	__s8	pps_tc_offset_div2;
+	__u8	log2_parallel_merge_level_minus2;
+	__u8	reserved;
+	__u64	flags;
+};
+
+#define V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE	0x01
+
+#define V4L2_HEVC_SEI_PIC_STRUCT_FRAME				0
+#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_FIELD			1
+#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_FIELD			2
+#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM			3
+#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP			4
+#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM_TOP			5
+#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP_BOTTOM		6
+#define V4L2_HEVC_SEI_PIC_STRUCT_FRAME_DOUBLING			7
+#define V4L2_HEVC_SEI_PIC_STRUCT_FRAME_TRIPLING			8
+#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_PREVIOUS_BOTTOM	9
+#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_PREVIOUS_TOP	10
+#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_NEXT_BOTTOM		11
+#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_NEXT_TOP		12
+
+#define V4L2_HEVC_DPB_ENTRIES_NUM_MAX		16
+
+/**
+ * struct v4l2_hevc_dpb_entry - HEVC decoded picture buffer entry
+ *
+ * @timestamp: timestamp of the V4L2 capture buffer to use as reference.
+ * @flags: long term flag for the reference frame
+ * @field_pic: whether the reference is a field picture or a frame.
+ * @reserved: padding field. Should be zeroed by applications.
+ * @pic_order_cnt_val: the picture order count of the current picture.
+ */
+struct v4l2_hevc_dpb_entry {
+	__u64	timestamp;
+	__u8	flags;
+	__u8	field_pic;
+	__u16	reserved;
+	__s32	pic_order_cnt_val;
+};
+
+/**
+ * struct v4l2_hevc_pred_weight_table - HEVC weighted prediction parameters
+ *
+ * @delta_luma_weight_l0: the difference of the weighting factor applied
+ *			  to the luma prediction value for list 0
+ * @luma_offset_l0: the additive offset applied to the luma prediction value
+ *		    for list 0
+ * @delta_chroma_weight_l0: the difference of the weighting factor applied
+ *			    to the chroma prediction values for list 0
+ * @chroma_offset_l0: the difference of the additive offset applied to
+ *		      the chroma prediction values for list 0
+ * @delta_luma_weight_l1: the difference of the weighting factor applied
+ *			  to the luma prediction value for list 1
+ * @luma_offset_l1: the additive offset applied to the luma prediction value
+ *		    for list 1
+ * @delta_chroma_weight_l1: the difference of the weighting factor applied
+ *			    to the chroma prediction values for list 1
+ * @chroma_offset_l1: the difference of the additive offset applied to
+ *		      the chroma prediction values for list 1
+ * @luma_log2_weight_denom: the base 2 logarithm of the denominator for
+ *			    all luma weighting factors
+ * @delta_chroma_log2_weight_denom: the difference of the base 2 logarithm
+ *				    of the denominator for all chroma
+ *				    weighting factors
+ */
+struct v4l2_hevc_pred_weight_table {
+	__s8	delta_luma_weight_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__s8	luma_offset_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__s8	delta_chroma_weight_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
+	__s8	chroma_offset_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
+
+	__s8	delta_luma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__s8	luma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__s8	delta_chroma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
+	__s8	chroma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
+
+	__u8	luma_log2_weight_denom;
+	__s8	delta_chroma_log2_weight_denom;
+};
+
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_LUMA		(1ULL << 0)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_CHROMA		(1ULL << 1)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_TEMPORAL_MVP_ENABLED	(1ULL << 2)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_MVD_L1_ZERO			(1ULL << 3)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_CABAC_INIT			(1ULL << 4)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_COLLOCATED_FROM_L0		(1ULL << 5)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_USE_INTEGER_MV		(1ULL << 6)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_DEBLOCKING_FILTER_DISABLED (1ULL << 7)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED (1ULL << 8)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL << 9)
+
+/**
+ * struct v4l2_ctrl_hevc_slice_params - HEVC slice parameters
+ *
+ * This control is a dynamically sized 1-dimensional array,
+ * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
+ *
+ * @bit_size: size (in bits) of the current slice data
+ * @data_byte_offset: offset (in bytes) to the video data in the current slice data
+ * @num_entry_point_offsets: specifies the number of entry point offset syntax
+ *			     elements in the slice header.
+ * @nal_unit_type: specifies the coding type of the slice (B, P or I)
+ * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier for the NAL unit
+ * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
+ * @colour_plane_id: specifies the colour plane associated with the current slice
+ * @slice_pic_order_cnt: specifies the picture order count
+ * @num_ref_idx_l0_active_minus1: this value plus 1 specifies the maximum
+ *                                reference index for reference picture list 0
+ *                                that may be used to decode the slice
+ * @num_ref_idx_l1_active_minus1: this value plus 1 specifies the maximum
+ *                                reference index for reference picture list 1
+ *                                that may be used to decode the slice
+ * @collocated_ref_idx: specifies the reference index of the collocated picture used
+ *			for temporal motion vector prediction
+ * @five_minus_max_num_merge_cand: specifies the maximum number of merging
+ *				   motion vector prediction candidates supported in
+ *				   the slice subtracted from 5
+ * @slice_qp_delta: specifies the initial value of QpY to be used for the coding
+ *		    blocks in the slice
+ * @slice_cb_qp_offset: specifies a difference to be added to the value of pps_cb_qp_offset
+ * @slice_cr_qp_offset: specifies a difference to be added to the value of pps_cr_qp_offset
+ * @slice_act_y_qp_offset: screen content extension parameters
+ * @slice_act_cb_qp_offset: screen content extension parameters
+ * @slice_act_cr_qp_offset: screen content extension parameters
+ * @slice_beta_offset_div2: specify the deblocking parameter offsets for beta divided by 2
+ * @slice_tc_offset_div2: specify the deblocking parameter offsets for tC divided by 2
+ * @pic_struct: indicates whether a picture should be displayed as a frame or as one or
+ *		more fields
+ * @reserved0: padding field. Should be zeroed by applications.
+ * @slice_segment_addr: specifies the address of the first coding tree block in
+ *			the slice segment
+ * @ref_idx_l0: the list of L0 reference elements as indices in the DPB
+ * @ref_idx_l1: the list of L1 reference elements as indices in the DPB
+ * @short_term_ref_pic_set_size: specifies the size of short-term reference
+ *				 pictures set included in the SPS
+ * @long_term_ref_pic_set_size: specifies the size of long-term reference
+ *				pictures set include in the SPS
+ * @pred_weight_table: the prediction weight coefficients for inter-picture
+ *		       prediction
+ * @reserved1: padding field. Should be zeroed by applications.
+ * @flags: see V4L2_HEVC_SLICE_PARAMS_FLAG_{}
+ */
+struct v4l2_ctrl_hevc_slice_params {
+	__u32	bit_size;
+	__u32	data_byte_offset;
+	__u32	num_entry_point_offsets;
+
+	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
+	__u8	nal_unit_type;
+	__u8	nuh_temporal_id_plus1;
+
+	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
+	__u8	slice_type;
+	__u8	colour_plane_id;
+	__s32	slice_pic_order_cnt;
+	__u8	num_ref_idx_l0_active_minus1;
+	__u8	num_ref_idx_l1_active_minus1;
+	__u8	collocated_ref_idx;
+	__u8	five_minus_max_num_merge_cand;
+	__s8	slice_qp_delta;
+	__s8	slice_cb_qp_offset;
+	__s8	slice_cr_qp_offset;
+	__s8	slice_act_y_qp_offset;
+	__s8	slice_act_cb_qp_offset;
+	__s8	slice_act_cr_qp_offset;
+	__s8	slice_beta_offset_div2;
+	__s8	slice_tc_offset_div2;
+
+	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI message */
+	__u8	pic_struct;
+
+	__u8	reserved0[3];
+	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
+	__u32	slice_segment_addr;
+	__u8	ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__u8	ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__u16	short_term_ref_pic_set_size;
+	__u16	long_term_ref_pic_set_size;
+
+	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction parameter */
+	struct v4l2_hevc_pred_weight_table pred_weight_table;
+
+	__u8	reserved1[2];
+	__u64	flags;
+};
+
+#define V4L2_HEVC_DECODE_PARAM_FLAG_IRAP_PIC		0x1
+#define V4L2_HEVC_DECODE_PARAM_FLAG_IDR_PIC		0x2
+#define V4L2_HEVC_DECODE_PARAM_FLAG_NO_OUTPUT_OF_PRIOR  0x4
+
+/**
+ * struct v4l2_ctrl_hevc_decode_params - HEVC decode parameters
+ *
+ * @pic_order_cnt_val: picture order count
+ * @short_term_ref_pic_set_size: specifies the size of short-term reference
+ *				 pictures set included in the SPS of the first slice
+ * @long_term_ref_pic_set_size: specifies the size of long-term reference
+ *				pictures set include in the SPS of the first slice
+ * @num_active_dpb_entries: the number of entries in dpb
+ * @num_poc_st_curr_before: the number of reference pictures in the short-term
+ *			    set that come before the current frame
+ * @num_poc_st_curr_after: the number of reference pictures in the short-term
+ *			   set that come after the current frame
+ * @num_poc_lt_curr: the number of reference pictures in the long-term set
+ * @poc_st_curr_before: provides the index of the short term before references
+ *			in DPB array
+ * @poc_st_curr_after: provides the index of the short term after references
+ *		       in DPB array
+ * @poc_lt_curr: provides the index of the long term references in DPB array
+ * @reserved: padding field. Should be zeroed by applications.
+ * @dpb: the decoded picture buffer, for meta-data about reference frames
+ * @flags: see V4L2_HEVC_DECODE_PARAM_FLAG_{}
+ */
+struct v4l2_ctrl_hevc_decode_params {
+	__s32	pic_order_cnt_val;
+	__u16	short_term_ref_pic_set_size;
+	__u16	long_term_ref_pic_set_size;
+	__u8	num_active_dpb_entries;
+	__u8	num_poc_st_curr_before;
+	__u8	num_poc_st_curr_after;
+	__u8	num_poc_lt_curr;
+	__u8	poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__u8	poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__u8	poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__u8	reserved[4];
+	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__u64	flags;
+};
+
+/**
+ * struct v4l2_ctrl_hevc_scaling_matrix - HEVC scaling lists parameters
+ *
+ * @scaling_list_4x4: scaling list is used for the scaling process for
+ *		      transform coefficients. The values on each scaling
+ *		      list are expected in raster scan order
+ * @scaling_list_8x8: scaling list is used for the scaling process for
+ *		      transform coefficients. The values on each scaling
+ *		      list are expected in raster scan order
+ * @scaling_list_16x16:	scaling list is used for the scaling process for
+ *			transform coefficients. The values on each scaling
+ *			list are expected in raster scan order
+ * @scaling_list_32x32:	scaling list is used for the scaling process for
+ *			transform coefficients. The values on each scaling
+ *			list are expected in raster scan order
+ * @scaling_list_dc_coef_16x16:	scaling list is used for the scaling process
+ *				for transform coefficients. The values on each
+ *				scaling list are expected in raster scan order.
+ * @scaling_list_dc_coef_32x32:	scaling list is used for the scaling process
+ *				for transform coefficients. The values on each
+ *				scaling list are expected in raster scan order.
+ */
+struct v4l2_ctrl_hevc_scaling_matrix {
+	__u8	scaling_list_4x4[6][16];
+	__u8	scaling_list_8x8[6][64];
+	__u8	scaling_list_16x16[6][64];
+	__u8	scaling_list_32x32[2][64];
+	__u8	scaling_list_dc_coef_16x16[6];
+	__u8	scaling_list_dc_coef_32x32[2];
+};
+
 #define V4L2_CID_COLORIMETRY_CLASS_BASE	(V4L2_CTRL_CLASS_COLORIMETRY | 0x900)
 #define V4L2_CID_COLORIMETRY_CLASS	(V4L2_CTRL_CLASS_COLORIMETRY | 1)
 
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index e0d19a6b5bc7..5a73b92ffe4d 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1769,6 +1769,11 @@ struct v4l2_ext_control {
 		struct v4l2_ctrl_mpeg2_quantisation __user *p_mpeg2_quantisation;
 		struct v4l2_ctrl_vp9_compressed_hdr __user *p_vp9_compressed_hdr_probs;
 		struct v4l2_ctrl_vp9_frame __user *p_vp9_frame;
+		struct v4l2_ctrl_hevc_sps __user *p_hevc_sps;
+		struct v4l2_ctrl_hevc_pps __user *p_hevc_pps;
+		struct v4l2_ctrl_hevc_slice_params __user *p_hevc_slice_params;
+		struct v4l2_ctrl_hevc_scaling_matrix __user *p_hevc_scaling_matrix;
+		struct v4l2_ctrl_hevc_decode_params __user *p_hevc_decode_params;
 		void __user *ptr;
 	};
 } __attribute__ ((packed));
-- 
2.32.0

