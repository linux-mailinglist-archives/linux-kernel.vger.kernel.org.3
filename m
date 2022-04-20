Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A50508337
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376652AbiDTITJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346267AbiDTITG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:19:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0402D1EECD;
        Wed, 20 Apr 2022 01:16:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85293B81D77;
        Wed, 20 Apr 2022 08:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D16AC385A1;
        Wed, 20 Apr 2022 08:16:15 +0000 (UTC)
Message-ID: <e45a78c9-ee72-dee1-9b1f-b73c3c572e19@xs4all.nl>
Date:   Wed, 20 Apr 2022 10:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver headers
Content-Language: en-US
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220414053528.31460-1-yuji2.ishikawa@toshiba.co.jp>
 <20220414053528.31460-3-yuji2.ishikawa@toshiba.co.jp>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220414053528.31460-3-yuji2.ishikawa@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 07:35, Yuji Ishikawa wrote:
> Add support to Video Input Interface on Toshiba Visconti Video Input Interface driver.
> The Video Input Interface includes CSI2 receiver, frame grabber and image signal processor.
> Headers in this commit provide definitions of data-structure and hardware registers.
> 
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
> v1 -> v2:
>   - moved driver headers to this patch; to decrease patch size
> ---
>  drivers/media/platform/visconti/hwd_viif.h    |  834 +++++
>  .../platform/visconti/hwd_viif_internal.h     |  361 +++
>  .../media/platform/visconti/hwd_viif_reg.h    | 2802 +++++++++++++++++
>  drivers/media/platform/visconti/viif.h        |  134 +
>  include/uapi/linux/visconti_viif.h            |  356 +++
>  5 files changed, 4487 insertions(+)
>  create mode 100644 drivers/media/platform/visconti/hwd_viif.h
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_internal.h
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_reg.h
>  create mode 100644 drivers/media/platform/visconti/viif.h
>  create mode 100644 include/uapi/linux/visconti_viif.h

<snip>

> diff --git a/include/uapi/linux/visconti_viif.h b/include/uapi/linux/visconti_viif.h
> new file mode 100644
> index 000000000..a235b4d7c
> --- /dev/null
> +++ b/include/uapi/linux/visconti_viif.h
> @@ -0,0 +1,356 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Toshiba Visconti Video Capture Support
> + *
> + * (C) Copyright 2022 TOSHIBA CORPORATION
> + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> + */
> +
> +#ifndef __UAPI_VISCONTI_VIIF_H_
> +#define __UAPI_VISCONTI_VIIF_H_
> +
> +#include <linux/types.h>
> +#include <linux/videodev2.h>
> +
> +/* Private IPCTLs */

Typo: IPCTLs -> IOCTLs

> +#define VIDIOC_VIIF_MAIN_SET_RAWPACK_MODE                                      \
> +	_IOW('V', BASE_VIDIOC_PRIVATE + 1, uint32_t)
> +#define VIDIOC_VIIF_L2_SET_UNDIST                                              \
> +	_IOW('V', BASE_VIDIOC_PRIVATE + 21, struct viif_l2_undist_config)
> +#define VIDIOC_VIIF_L2_SET_ROI                                                 \
> +	_IOW('V', BASE_VIDIOC_PRIVATE + 22, struct viif_l2_roi_config)
> +#define VIDIOC_VIIF_L2_SET_GAMMA                                               \
> +	_IOW('V', BASE_VIDIOC_PRIVATE + 23, struct viif_l2_gamma_config)
> +#define VIDIOC_VIIF_L2_SET_CROP                                                \
> +	_IOW('V', BASE_VIDIOC_PRIVATE + 24, struct viif_l2_crop_config)
> +#define VIDIOC_VIIF_CSI2RX_SET_MBUS_FMT                                        \
> +	_IOW('V', BASE_VIDIOC_PRIVATE + 25, uint32_t)
> +#define VIDIOC_VIIF_CSI2RX_GET_CALIBRATION_STATUS                              \
> +	_IOR('V', BASE_VIDIOC_PRIVATE + 26,                                    \
> +	     struct viif_csi2rx_dphy_calibration_status)
> +#define VIDIOC_VIIF_CSI2RX_GET_ERR_STATUS                                      \
> +	_IOR('V', BASE_VIDIOC_PRIVATE + 27, struct viif_csi2rx_err_status)
> +#define VIDIOC_VIIF_ISP_GET_LAST_CAPTURE_STATUS                                \
> +	_IOR('V', BASE_VIDIOC_PRIVATE + 28, struct viif_isp_capture_status)

We really don't want to introduce private ioctls in a public API. It's hard to
maintain, and you would need very good reasons to go this route.

A better choice is either using compound controls, as is used by stateless codecs:

https://linuxtv.org/downloads/v4l-dvb-apis-new/userspace-api/v4l/ext-ctrls-codec-stateless.html

or streaming metadata, as is done by the rkisp1 driver:

https://linuxtv.org/downloads/v4l-dvb-apis-new/admin-guide/rkisp1.html

In both cases you have to make sure that the data layout is the same regardless
of whether you run on a 32 bit or 64 bit OS. I.e. if the kernel is 64 bit (arm64)
but the application is compiled for 32 bit, then you don't want to have to
convert between the two layouts. The pahole utility is very helpful for checking
this.

Actually, the same issue is present when using private ioctls.

> +
> +/* Enable/Disable flag */
> +#define VIIF_DISABLE (0U)
> +#define VIIF_ENABLE  (1U)
> +
> +/**
> + * enum viif_rawpack_mode - RAW pack mode for ioctl(VIDIOC_VIIF_MAIN_SET_RAWPACK_MODE)
> + *
> + * @VIIF_RAWPACK_DISABLE: RAW pack disable
> + * @VIIF_RAWPACK_MSBFIRST: RAW pack enable (MSB First)
> + * @VIIF_RAWPACK_LSBFIRST: RAW pack enable (LSB First)
> + */
> +enum viif_rawpack_mode {
> +	VIIF_RAWPACK_DISABLE = 0,
> +	VIIF_RAWPACK_MSBFIRST = 2,
> +	VIIF_RAWPACK_LSBFIRST = 3,
> +};
> +
> +/* L2ISP undistortion mode */
> +enum viif_l2_undist_mode {
> +	VIIF_L2_UNDIST_POLY = 0, /* polynomial mode */
> +	VIIF_L2_UNDIST_GRID = 1, /* grid table mode */
> +	VIIF_L2_UNDIST_POLY_TO_GRID = 2, /* polynomial, then grid table mode */
> +	VIIF_L2_UNDIST_GRID_TO_POLY = 3, /* grid table, then polynomial mode */
> +};
> +
> +/**
> + * struct viif_l2_undist - L2ISP UNDIST parameters
> + * for &struct viif_l2_undist_config
> + * @through_mode: 1:enable or 0:disable through mode of undistortion
> + * @roi_mode: :ref:`L2ISP undistortion mode <L2ISP_undistortion_mode>`
> + * @sensor_crop_ofs_h: Horizontal start position of sensor crop area[pixel]
> + *                     [-4296..4296], accuracy: 1/2
> + * @sensor_crop_ofs_v: Vertical start position of sensor crop area[line]
> + *                     [-2360..2360], accuracy: 1/2
> + * @norm_scale: Normalization coefficient for distance from center
> + *              [0..1677721], accuracy: 1/33554432
> + * @valid_r_norm2_poly: Setting target area for polynomial correction
> + *                      [0..0x3FFFFFF], accuracy: 1/33554432
> + * @valid_r_norm2_grid: Setting target area for grid table correction
> + *                      [0..0x3FFFFFF], accuracy: 1/33554432
> + * @roi_write_area_delta: Error adjustment value of forward function and
> + *                        inverse function for pixel position calculation
> + *                        [0..0x7FF], accuracy: 1/1024
> + * @poly_write_g_coef: 10th-order polynomial coefficient for G write pixel position calculation
> + *                     [-2147352576..2147352576], accuracy: 1/131072
> + * @poly_read_b_coef: 10th-order polynomial coefficient for B read pixel position calculation
> + *                    [-2147352576..2147352576], accuracy: 1/131072
> + * @poly_read_g_coef: 10th-order polynomial coefficient for G read pixel position calculation
> + *                    [-2147352576..2147352576], accuracy: 1/131072
> + * @poly_read_r_coef: 10th-order polynomial coefficient for R read pixel position calculation
> + *                    [-2147352576..2147352576], accuracy: 1/131072
> + * @grid_node_num_h: Number of horizontal grids [16..64]
> + * @grid_node_num_v: Number of vertical grids [16..64]
> + * @grid_patch_hsize_inv: Inverse pixel size between horizontal grids
> + *                        [0..0x7FFFFF], accuracy: 1/8388608
> + * @grid_patch_vsize_inv: Inverse pixel size between vertical grids
> + *                        [0..0x7FFFFF], accuracy: 1/8388608
> + */
> +struct viif_l2_undist {
> +	uint32_t through_mode;
> +	uint32_t roi_mode;
> +	int32_t sensor_crop_ofs_h;
> +	int32_t sensor_crop_ofs_v;
> +	uint32_t norm_scale;
> +	uint32_t valid_r_norm2_poly;
> +	uint32_t valid_r_norm2_grid;
> +	uint32_t roi_write_area_delta;
> +	int32_t poly_write_g_coef[11];
> +	int32_t poly_read_b_coef[11];
> +	int32_t poly_read_g_coef[11];
> +	int32_t poly_read_r_coef[11];
> +	uint32_t grid_node_num_h;
> +	uint32_t grid_node_num_v;
> +	uint32_t grid_patch_hsize_inv;
> +	uint32_t grid_patch_vsize_inv;
> +};
> +/**
> + * struct viif_l2_undist_config - L2ISP UNDIST parameters
> + * for :ref:`VIDIOC_VIIF_L2_SET_UNDIST`
> + * @param: &struct viif_l2_undist
> + * @write_g: Write for G Grid table address.
> + *           Table is not transferred if a NULL pointer is set
> + * @read_b: Read for B Grid table address.
> + *          Table is not transferred if a NULL pointer is set
> + * @read_g: Read for G Grid table address.
> + *          Table is not transferred if a NULL pointer is set
> + * @read_r: Read for R Grid table address.
> + *          Table is not transferred if a NULL pointer is set
> + * @size: Table size [byte]. Range: [1024..8192] or 0.
> + *        Should be set to "grid_node_num_h * grid_node_num_v * 4".
> + *        Refer to &struct viif_l2_undist.
> + *        Should set 0 in case NULL is set for all tables.
> + *        Should set size other than 0 in case If other is set in more than one table.
> + *
> + * Application should make sure that the table data is based on HW specification
> + * since this driver does not check the contents of specified grid table.
> + */
> +struct viif_l2_undist_config {
> +	struct viif_l2_undist param;
> +	uint32_t *write_g;
> +	uint32_t *read_b;
> +	uint32_t *read_g;
> +	uint32_t *read_r;

Pointers in a public API are possibly but it really complicates the code.

When using controls this can be done by placing these tables in separate
controls using the upcoming 'Dynamic Array' support.

Patches adding support for that are part of this series:

https://lore.kernel.org/linux-media/20220407152940.738159-1-benjamin.gaignard@collabora.com/T/#t

> +	uint32_t size;
> +};
> +
> +/**
> + * struct viif_l2_roi_config - L2ISP ROI parameters
> + * for :ref:`VIDIOC_VIIF_L2_SET_ROI`
> + * @roi_scale: Scale value for each ROI [32768..131072], accuracy: 1/65536
> + * @roi_scale_inv: Inverse scale value for each ROI [32768..131072], accuracy: 1/65536
> + * @corrected_wo_scale_hsize: Corrected image width for each ROI [pixel] [128..8190]
> + * @corrected_wo_scale_vsize: Corrected image height for each ROI [line] [128..4094]
> + * @corrected_hsize: Corrected and scaled image width for each ROI [pixel] [128..8190]
> + * @corrected_vsize: Corrected and scaled image height for each ROI [line] [128..4094]
> + */
> +struct viif_l2_roi_config {
> +	uint32_t roi_scale;
> +	uint32_t roi_scale_inv;
> +	uint32_t corrected_wo_scale_hsize;
> +	uint32_t corrected_wo_scale_vsize;
> +	uint32_t corrected_hsize;
> +	uint32_t corrected_vsize;
> +};
> +
> +/** enum viif_gamma_mode - Gamma correction mode
> + *
> + * @VIIF_GAMMA_COMPRESSED: compressed table mode
> + * @VIIF_GAMMA_LINEAR: liner table mode

liner -> linear

> + */
> +enum viif_gamma_mode {
> +	VIIF_GAMMA_COMPRESSED = 0,
> +	VIIF_GAMMA_LINEAR = 1,
> +};
> +
> +/**
> + * struct viif_l2_gamma_config - L2ISP gamma correction parameters
> + * for :ref:`VIDIOC_VIIF_L2_SET_GAMMA`
> + * @enable: 1:Enable, 0:Disable settings of L2ISP gamma correction control
> + * @vsplit: Line switching position of first table and second table [line] [0..4094].
> + *          Should set 0 in case 0 is set to @enable
> + * @mode: :ref:`Gamma correction mode <Gamma_correction_mode>`.
> + *        Should set VIIF_GAMMA_COMPRESSED in case 0 is set to @enable
> + * @table: Table address.
> + *         Gamma table is not transferred if a NULL pointer is set to table.
> + *         The size of each table is fixed to 512 bytes.
> + *         [0]: G/Y(1st table), [1]: G/Y(2nd table), [2]: B/U(1st table)
> + *         [3]: B/U(2nd table), [4]: R/V(1st table), [5]: R/V(2nd table)
> + */
> +struct viif_l2_gamma_config {
> +	uint32_t enable;
> +	uint32_t vsplit;
> +	uint32_t mode;
> +	uint16_t *table[6];
> +};
> +
> +/**
> + * struct viif_l2_crop_config - L2ISP Cropping parameters
> + * for :ref:`VIDIOC_VIIF_L2_SET_CROP`
> + * @x: X coordinate position
> + *     (with the upper left corner of the image as the origin)[pixel] [0..8062]
> + * @y: Y coordinate position
> + *     (with the upper left corner of the image as the origin)[Line] [0..3966]
> + * @w: Image width[pixel] [128..8190]
> + * @h: Image height[pixel] [128..4094]
> + */
> +struct viif_l2_crop_config {
> +	uint32_t x;
> +	uint32_t y;
> +	uint32_t w;
> +	uint32_t h;
> +};
> +
> +/**
> + * enum viif_csi2_cal_status - CSI2RX calibration status
> + *
> + * @VIIF_CSI2_CAL_NOT_DONE: Calibration not complete
> + * @VIIF_CSI2_CAL_SUCCESS: Calibration success
> + * @VIIF_CSI2_CAL_FAIL: Calibration failed
> + */
> +enum viif_csi2_cal_status {
> +	VIIF_CSI2_CAL_NOT_DONE = 0,
> +	VIIF_CSI2_CAL_SUCCESS = 1,
> +	VIIF_CSI2_CAL_FAIL = 2,
> +};
> +
> +/**
> + * struct viif_csi2rx_dphy_calibration_status - CSI2-RX D-PHY Calibration
> + * information for :ref:`VIDIOC_VIIF_CSI2RX_GET_CALIBRATION_STATUS`
> + * @term_cal_with_rext: Result of termination calibration with rext
> + * @clock_lane_offset_cal: Result of offset calibration of clock lane
> + * @data_lane0_offset_cal: Result of offset calibration of data lane0
> + * @data_lane1_offset_cal: Result of offset calibration of data lane1
> + * @data_lane2_offset_cal: Result of offset calibration of data lane2
> + * @data_lane3_offset_cal: Result of offset calibration of data lane3
> + * @data_lane0_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane0
> + * @data_lane1_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane1
> + * @data_lane2_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane2
> + * @data_lane3_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane3
> + *
> + * Refer to :ref:`CSI2-RX calibration status <CSI2RX_calibration_status>`
> + * for the definitions of each member
> + */
> +struct viif_csi2rx_dphy_calibration_status {
> +	uint32_t term_cal_with_rext;
> +	uint32_t clock_lane_offset_cal;
> +	uint32_t data_lane0_offset_cal;
> +	uint32_t data_lane1_offset_cal;
> +	uint32_t data_lane2_offset_cal;
> +	uint32_t data_lane3_offset_cal;
> +	uint32_t data_lane0_ddl_tuning_cal;
> +	uint32_t data_lane1_ddl_tuning_cal;
> +	uint32_t data_lane2_ddl_tuning_cal;
> +	uint32_t data_lane3_ddl_tuning_cal;
> +};
> +
> +/**
> + * struct viif_csi2rx_err_status - CSI2RX Error status parameters
> + * for :ref:`VIDIOC_VIIF_CSI2RX_GET_ERR_STATUS`
> + * @err_phy_fatal: D-PHY FATAL error.
> + *                 bit[3]: Start of transmission error on DATA Lane3.
> + *                 bit[2]: Start of transmission error on DATA Lane2.
> + *                 bit[1]: Start of transmission error on DATA Lane1.
> + *                 bit[0]: Start of transmission error on DATA Lane0.
> + * @err_pkt_fatal: Packet FATAL error.
> + *                 bit[16]: Header ECC contains 2 errors, unrecoverable.
> + *                 bit[3]: Checksum error detected on virtual channel 3.
> + *                 bit[2]: Checksum error detected on virtual channel 2.
> + *                 bit[1]: Checksum error detected on virtual channel 1.
> + *                 bit[0]: Checksum error detected on virtual channel 0.
> + * @err_frame_fatal: Frame FATAL error.
> + *                   bit[19]: Last received Frame, in virtual channel 3, has at least one CRC error.
> + *                   bit[18]: Last received Frame, in virtual channel 2, has at least one CRC error.
> + *                   bit[17]: Last received Frame, in virtual channel 1, has at least one CRC error.
> + *                   bit[16]: Last received Frame, in virtual channel 0, has at least one CRC error.
> + *                   bit[11]: Incorrect Frame Sequence detected in virtual channel 3.
> + *                   bit[10]: Incorrect Frame Sequence detected in virtual channel 2.
> + *                   bit[9]: Incorrect Frame Sequence detected in virtual channel 1.
> + *                   bit[8]: Incorrect Frame Sequence detected in virtual channel 0.
> + *                   bit[3]: Error matching Frame Start with Frame End for virtual channel 3.
> + *                   bit[2]: Error matching Frame Start with Frame End for virtual channel 2.
> + *                   bit[1]: Error matching Frame Start with Frame End for virtual channel 1.
> + *                   bit[0]: Error matching Frame Start with Frame End for virtual channel 0.
> + * @err_phy: D-PHY error.
> + *           bit[19]: Escape Entry Error on Data Lane 3.
> + *           bit[18]: Escape Entry Error on Data Lane 2.
> + *           bit[17]: Escape Entry Error on Data Lane 1.
> + *           bit[16]: Escape Entry Error on Data Lane 0.
> + *           bit[3]: Start of Transmission Error on Data Lane 3 (synchronization can still be achieved).
> + *           bit[2]: Start of Transmission Error on Data Lane 2 (synchronization can still be achieved).
> + *           bit[1]: Start of Transmission Error on Data Lane 1 (synchronization can still be achieved).
> + *           bit[0]: Start of Transmission Error on Data Lane 0 (synchronization can still be achieved).
> + * @err_pkt: Packet error.
> + *           bit[19]: Header Error detected and corrected on virtual channel 3.
> + *           bit[18]: Header Error detected and corrected on virtual channel 2.
> + *           bit[17]: Header Error detected and corrected on virtual channel 1.
> + *           bit[16]: Header Error detected and corrected on virtual channel 0.
> + *           bit[3]: Unrecognized or unimplemented data type detected in virtual channel 3.
> + *           bit[2]: Unrecognized or unimplemented data type detected in virtual channel 2.
> + *           bit[1]: Unrecognized or unimplemented data type detected in virtual channel 1.
> + *           bit[0]: Unrecognized or unimplemented data type detected in virtual channel 0.
> + * @err_line: Line error.
> + *            bit[23]: Error in the sequence of lines for vc7 and dt7.
> + *            bit[22]: Error in the sequence of lines for vc6 and dt6.
> + *            bit[21]: Error in the sequence of lines for vc5 and dt5.
> + *            bit[20]: Error in the sequence of lines for vc4 and dt4.
> + *            bit[19]: Error in the sequence of lines for vc3 and dt3.
> + *            bit[18]: Error in the sequence of lines for vc2 and dt2.
> + *            bit[17]: Error in the sequence of lines for vc1 and dt1.
> + *            bit[16]: Error in the sequence of lines for vc0 and dt0.
> + *            bit[7]: Error matching Line Start with Line End for vc7 and dt7.
> + *            bit[6]: Error matching Line Start with Line End for vc6 and dt6.
> + *            bit[5]: Error matching Line Start with Line End for vc5 and dt5.
> + *            bit[4]: Error matching Line Start with Line End for vc4 and dt4.
> + *            bit[3]: Error matching Line Start with Line End for vc3 and dt3.
> + *            bit[2]: Error matching Line Start with Line End for vc2 and dt2.
> + *            bit[1]: Error matching Line Start with Line End for vc1 and dt1.
> + *            bit[0]: Error matching Line Start with Line End for vc0 and dt0.
> + */
> +struct viif_csi2rx_err_status {
> +	uint32_t err_phy_fatal;
> +	uint32_t err_pkt_fatal;
> +	uint32_t err_frame_fatal;
> +	uint32_t err_phy;
> +	uint32_t err_pkt;
> +	uint32_t err_line;
> +};
> +
> +/**
> + * struct viif_l1_info - L1ISP AWB information
> + * for &struct viif_isp_capture_status
> + * @awb_ave_u: U average value of AWB adjustment [pixel]
> + * @awb_ave_v: V average value of AWB adjustment [pixel]
> + * @awb_accumulated_pixel: Accumulated pixel count of AWB adjustment
> + * @awb_gain_r: R gain used in the next frame of AWB adjustment
> + * @awb_gain_g: G gain used in the next frame of AWB adjustment
> + * @awb_gain_b: B gain used in the next frame of AWB adjustment
> + * @awb_status_u: U convergence state of AWB adjustment
> + *                (true: converged, false: not-converged)
> + * @awb_status_v: V convergence state of AWB adjustment
> + *                (true: converged, false: not-converged)
> + */
> +struct viif_l1_info {
> +	uint32_t awb_ave_u;
> +	uint32_t awb_ave_v;
> +	uint32_t awb_accumulated_pixel;
> +	uint32_t awb_gain_r;
> +	uint32_t awb_gain_g;
> +	uint32_t awb_gain_b;
> +	bool awb_status_u;
> +	bool awb_status_v;

bool is not allowed in a userspace API. Use __u32 or something like that instead.

Regards,

	Hans

> +};
> +/**
> + * struct viif_isp_capture_status - L1ISP capture information
> + * for :ref:`VIDIOC_VIIF_ISP_GET_LAST_CAPTURE_STATUS`
> + * @l1_info: L1ISP AWB information. Refer to &struct viif_l1_info
> + */
> +struct viif_isp_capture_status {
> +	struct viif_l1_info l1_info;
> +};
> +
> +#endif /* __UAPI_VISCONTI_VIIF_H_ */

