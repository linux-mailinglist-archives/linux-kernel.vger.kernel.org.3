Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015FD4B65EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiBOIVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:21:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiBOIV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:21:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9AD9BBB0;
        Tue, 15 Feb 2022 00:21:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8B02B81801;
        Tue, 15 Feb 2022 08:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122EEC340EC;
        Tue, 15 Feb 2022 08:21:14 +0000 (UTC)
Message-ID: <20ace4b3-5002-4edb-642b-bbb1952f3591@xs4all.nl>
Date:   Tue, 15 Feb 2022 09:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 1/2] media: v4l2-ctrls: Add intra-refresh type control
Content-Language: en-US
To:     Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ezequiel@collabora.com, vgarodia@codeaurora.org,
        stanimir.varbanov@linaro.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
References: <1643019119-8309-1-git-send-email-dikshita@qti.qualcomm.com>
 <1643019119-8309-2-git-send-email-dikshita@qti.qualcomm.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <1643019119-8309-2-git-send-email-dikshita@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dikshita,

Some comments below:

On 1/24/22 11:11, Dikshita Agarwal wrote:
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> Add a control to set intra-refresh type.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  .../userspace-api/media/v4l/ext-ctrls-codec.rst    | 23 ++++++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  9 +++++++++
>  include/uapi/linux/v4l2-controls.h                 |  5 +++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index e141f0e..54b42e1 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -1180,6 +1180,29 @@ enum v4l2_mpeg_video_h264_entropy_mode -
>      is set to non zero value.
>      Applicable to H264, H263 and MPEG4 encoder.
>  
> +``V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE (enum)``
> +
> +enum v4l2_mpeg_video_intra_refresh_type -
> +    Sets the type of intra refresh. The period to refresh
> +    the whole frame is specified by V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD.
> +    Note if the client sets this control to either ``V4L2_MPEG_VIDEO_INTRA_REFRESH_RANDOM``
> +    or ``V4L2_MPEG_VIDEO_INTRA_REFRESH_CYCLIC`` the ``V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB``
> +    control shall be ignored.

Since this control has only two possible values, that would mean that, if this control
is present, then REFRESH_MB is always ignored.

It seems to me that you need a third option here that specifically selects the REFRESH_MB
method.

Also, this needs to be documented as well in REFRESH_MB (i.e. it is ignored if this TYPE
control is present and is set to something other than REFRESH_MB).

> +    Applicable to H264, H263 and MPEG4 encoder. Possible values are:
> +
> +.. tabularcolumns:: |p{9.6cm}|p{7.9cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_MPEG_VIDEO_INTRA_REFRESH_RANDOM``

I think you should add _TYPE after REFRESH in these names to clearly specify
that this is setting the refresh *type*.

> +      - The whole frame is completely refreshed randomly
> +      after the specified period.
> +    * - ``V4L2_MPEG_VIDEO_INTRA_REFRESH_CYCLIC``
> +      - The whole frame MBs are completely refreshed in cyclic order
> +      after the specified period.
> +
>  ``V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD (integer)``
>      Intra macroblock refresh period. This sets the period to refresh
>      the whole frame. In other words, this defines the number of frames
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index 54ca4e6..f13f587 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -572,6 +572,11 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		"VBV/CPB Limit",
>  		NULL,
>  	};
> +	static const char * const intra_refresh_type[] = {
> +		"Random",
> +		"Cyclic",
> +		NULL,
> +	};
>  
>  	switch (id) {
>  	case V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ:
> @@ -705,6 +710,8 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		return hevc_start_code;
>  	case V4L2_CID_CAMERA_ORIENTATION:
>  		return camera_orientation;
> +	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:
> +		return intra_refresh_type;
>  	default:
>  		return NULL;
>  	}
> @@ -834,6 +841,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_MPEG_VIDEO_DECODER_SLICE_INTERFACE:	return "Decoder Slice Interface";
>  	case V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER:	return "MPEG4 Loop Filter Enable";
>  	case V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB:	return "Number of Intra Refresh MBs";
> +	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:		return "Intra Refresh Type";
>  	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:		return "Intra Refresh Period";
>  	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:		return "Frame Level Rate Control Enable";
>  	case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:			return "H264 MB Level Rate Control";
> @@ -1360,6 +1368,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_STATELESS_H264_DECODE_MODE:
>  	case V4L2_CID_STATELESS_H264_START_CODE:
>  	case V4L2_CID_CAMERA_ORIENTATION:
> +	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:
>  		*type = V4L2_CTRL_TYPE_MENU;
>  		break;
>  	case V4L2_CID_LINK_FREQ:
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index c8e0f84..9650b71 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -443,6 +443,11 @@ enum v4l2_mpeg_video_multi_slice_mode {
>  #define V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES		(V4L2_CID_CODEC_BASE+234)
>  #define V4L2_CID_MPEG_VIDEO_DEC_CONCEAL_COLOR		(V4L2_CID_CODEC_BASE+235)
>  #define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD	(V4L2_CID_CODEC_BASE+236)
> +#define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE		(V4L2_CID_CODEC_BASE+237)
> +enum v4l2_mpeg_video_intra_refresh_type {
> +	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_RANDOM	= 0,
> +	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_CYCLIC	= 1,
> +};
>  
>  /* CIDs for the MPEG-2 Part 2 (H.262) codec */
>  #define V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL			(V4L2_CID_CODEC_BASE+270)

Regards,

	Hans
