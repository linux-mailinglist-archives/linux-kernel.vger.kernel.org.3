Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DBF48B7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbiAKTtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbiAKTtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:49:13 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F390EC061751
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:49:12 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id y17so433718qtx.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YqrRa12A2dOCgNRdJD8niKrGy7BorSiXU7Pz1gVSSqw=;
        b=sYFJQYLkBAWGCMf7IJC8E0nfk9THaHhkHCaaJUxFXTYOlqpafhhRwpJXn5LZpqqBbk
         eATWyLkamKg+bBaRAVN1gSTqLhaOE+Jny3X+bgRtl3E4O2J/KDY9Rl38HyjtDktOOmp2
         shP6MzJ+xf2Vw52XEUOHpnuHexDLdkPfNWpBijuwk/T0u9ZJaFTmk2Opj4+dh6pXC+pr
         jnZvLVNZrcD82fdVw96ZpbZR0M+aV5lE2113ue4Du6qz/Q55tWnzD7eMpsVKGWzfPPlE
         x2pMXq4jKm1r4Za6xuhXk2sNdsGJeVsYcpkqAYvDoGfAGzFKWGMeQ3GX61FnYGekv9jP
         xxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YqrRa12A2dOCgNRdJD8niKrGy7BorSiXU7Pz1gVSSqw=;
        b=w0BdAjH328xTSkfTyX45UMjsSsjHZ2SqUTDIC7s3VeSVwPXloMGaT4RlhAdXOVov+P
         zACuohytAvCuAY1eQuirDDI4X4O5R6T45Cuya536H9xhRG/4+VB2d6OLTLREAT87ZieP
         kE+n+q33o50W+/OwnWd1FCAVJGeNsSu5u47ACOPMMFP1eQmcEoks8JQegLC2xt7C8nmL
         +RqOUrP/NXqm6sFR6xHc1KjC20JPO++hFqSXeHTIKYDEYY086n8n+C5MgfBpHGlBFsOy
         xC6m7Xy1Algy8SvfLU0LrL2+rsIUNREAIiqgtrxMV9/y8l3Q4imFjUntbTQCKYhRiImS
         Qdgw==
X-Gm-Message-State: AOAM533c2CHd2ZMKhCrLOJgDCD3bdSsG3nwXYVk74ZGgxLOwuMRlDmd6
        v0qIs2ftiXJ0TNpnc5s0SA8O6w==
X-Google-Smtp-Source: ABdhPJxn1aXvwlh12nmUzySizEvQ1SnqQ5KyJRZ/h/ecY76YDViQiteOu3/2rM79//oaZ2lpUdK73A==
X-Received: by 2002:ac8:5b92:: with SMTP id a18mr5081449qta.262.1641930551687;
        Tue, 11 Jan 2022 11:49:11 -0800 (PST)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id j22sm5607330qko.46.2022.01.11.11.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:49:11 -0800 (PST)
Message-ID: <8deeca52c1b482d738c9c888194c84549d00424f.camel@ndufresne.ca>
Subject: Re: [PATCH 1/2] media: v4l2-ctrls: Add intra-refresh type control
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, ezequiel@collabora.com,
        vgarodia@codeaurora.org, stanimir.varbanov@linaro.org
Date:   Tue, 11 Jan 2022 14:49:08 -0500
In-Reply-To: <1641561124-19476-2-git-send-email-quic_dikshita@quicinc.com>
References: <1641561124-19476-1-git-send-email-quic_dikshita@quicinc.com>
         <1641561124-19476-2-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 07 janvier 2022 à 18:42 +0530, Dikshita Agarwal a écrit :
> Add a control to set intra-refresh type.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  .../userspace-api/media/v4l/ext-ctrls-codec.rst    | 27 ++++++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          | 10 ++++++++
>  include/uapi/linux/v4l2-controls.h                 |  6 +++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index e141f0e..ce0201b 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -1180,6 +1180,33 @@ enum v4l2_mpeg_video_h264_entropy_mode -
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
> +    If the client sets this control to ``V4L2_MPEG_VIDEO_INTRA_REFRESH_NONE`` the
> +    V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB control shall not be ignored.
> +    Applicable to H264, H263 and MPEG4 encoder. Possible values are:
> +
> +.. tabularcolumns:: |p{9.6cm}|p{7.9cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_MPEG_VIDEO_INTRA_REFRESH_NONE``
> +      - Intra refresh is disabled.

Slight annoyance, we now have two mechanism to disable intra refresh. Disabling
intra-refresh was previously documented as "Note that this control will not take
effect when V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD control is set to non zero
value."

Perhaps we should drop this and add a similar line in this control documentation
?

> +    * - ``V4L2_MPEG_VIDEO_INTRA_REFRESH_RANDOM``
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
> index 54ca4e6..403c77b 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -572,6 +572,12 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		"VBV/CPB Limit",
>  		NULL,
>  	};
> +	static const char * const intra_refresh_type[] = {
> +		"None"
> +		"Random",
> +		"Cyclic",
> +		NULL,
> +	};
>  
>  	switch (id) {
>  	case V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ:
> @@ -705,6 +711,8 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		return hevc_start_code;
>  	case V4L2_CID_CAMERA_ORIENTATION:
>  		return camera_orientation;
> +	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:
> +		return intra_refresh_type;
>  	default:
>  		return NULL;
>  	}
> @@ -834,6 +842,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_MPEG_VIDEO_DECODER_SLICE_INTERFACE:	return "Decoder Slice Interface";
>  	case V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER:	return "MPEG4 Loop Filter Enable";
>  	case V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB:	return "Number of Intra Refresh MBs";
> +	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:		return "Intra Refresh Type";
>  	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:		return "Intra Refresh Period";
>  	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:		return "Frame Level Rate Control Enable";
>  	case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:			return "H264 MB Level Rate Control";
> @@ -1360,6 +1369,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_STATELESS_H264_DECODE_MODE:
>  	case V4L2_CID_STATELESS_H264_START_CODE:
>  	case V4L2_CID_CAMERA_ORIENTATION:
> +	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:
>  		*type = V4L2_CTRL_TYPE_MENU;
>  		break;
>  	case V4L2_CID_LINK_FREQ:
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index c8e0f84..5429c25 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -443,6 +443,12 @@ enum v4l2_mpeg_video_multi_slice_mode {
>  #define V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES		(V4L2_CID_CODEC_BASE+234)
>  #define V4L2_CID_MPEG_VIDEO_DEC_CONCEAL_COLOR		(V4L2_CID_CODEC_BASE+235)
>  #define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD	(V4L2_CID_CODEC_BASE+236)
> +#define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE		(V4L2_CID_CODEC_BASE+237)
> +enum v4l2_mpeg_video_intra_refresh_type {
> +	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_NONE		= 0,
> +	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_RANDOM	= 1,
> +	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_CYCLIC	= 2,
> +};
>  
>  /* CIDs for the MPEG-2 Part 2 (H.262) codec */
>  #define V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL			(V4L2_CID_CODEC_BASE+270)

