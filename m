Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9CF4D7D69
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbiCNIOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCNIOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F2563DE;
        Mon, 14 Mar 2022 01:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 805CF61240;
        Mon, 14 Mar 2022 08:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B507C340F4;
        Mon, 14 Mar 2022 08:13:22 +0000 (UTC)
Message-ID: <f9fa2859-21ae-a8d1-fc62-15b0570e4a20@xs4all.nl>
Date:   Mon, 14 Mar 2022 09:13:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/2] venus: venc: Add support for intra-refresh mode
Content-Language: en-US
To:     quic_dikshita@quicinc.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, ezequiel@collabora.com,
        stanimir.varbanov@linaro.org, quic_vgarodia@quicinc.com,
        quic_majja@quicinc.com, quic_jdas@quicinc.com
References: <1647244809-25340-1-git-send-email-quic_dikshita@quicinc.com>
 <1647244809-25340-3-git-send-email-quic_dikshita@quicinc.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <1647244809-25340-3-git-send-email-quic_dikshita@quicinc.com>
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



On 3/14/22 09:00, quic_dikshita@quicinc.com wrote:
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> Add support for intra-refresh type v4l2 control.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/core.h       | 1 +
>  drivers/media/platform/qcom/venus/venc.c       | 4 +++-
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 8 ++++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 7c3bac0..814ec3c 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -260,6 +260,7 @@ struct venc_controls {
>  
>  	u32 header_mode;
>  	bool aud_enable;
> +	u32 intra_refresh_mode;

To be consistent with the control name rename this field to intra_refresh_type.

>  	u32 intra_refresh_period;
>  
>  	struct {
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 84bafc3..3b38624 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -893,8 +893,10 @@ static int venc_set_properties(struct venus_inst *inst)
>  				mbs++;
>  			mbs /= ctr->intra_refresh_period;
>  
> -			intra_refresh.mode = HFI_INTRA_REFRESH_RANDOM;
>  			intra_refresh.cir_mbs = mbs;
> +			if (ctr->intra_refresh_mode ==
> +			    V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM)
> +				intra_refresh.mode = HFI_INTRA_REFRESH_RANDOM;
>  		}
>  
>  		ptype = HFI_PROPERTY_PARAM_VENC_INTRA_REFRESH;
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index 1ada42d..29dbe3b4 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -316,6 +316,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:
>  		ctr->mastering = *ctrl->p_new.p_hdr10_mastering;
>  		break;
> +	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE:
> +		ctr->intra_refresh_mode = ctrl->val;
> +		break;
>  	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:
>  		ctr->intra_refresh_period = ctrl->val;
>  		break;
> @@ -582,6 +585,11 @@ int venc_ctrl_init(struct venus_inst *inst)
>  				   V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY,
>  				   v4l2_ctrl_ptr_create(NULL));
>  
> +	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
> +			       V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE,
> +			       V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM,
> +			       0, V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM);

The range consists only of RANDOM, is that intended? Why add this control if
there is no choice?

Regards,

	Hans

> +
>  	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
>  			  V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,
>  			  ((4096 * 2304) >> 8), 1, 0);
