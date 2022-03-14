Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091A54D7FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiCNKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiCNKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:33:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDA843ACE;
        Mon, 14 Mar 2022 03:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50E6660FCD;
        Mon, 14 Mar 2022 10:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14508C340E9;
        Mon, 14 Mar 2022 10:31:59 +0000 (UTC)
Message-ID: <1682f555-f7b8-8830-26ff-8d0c9007d323@xs4all.nl>
Date:   Mon, 14 Mar 2022 11:31:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 2/2] venus: venc: Add support for intra-refresh mode
Content-Language: en-US
To:     quic_dikshita@quicinc.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, ezequiel@collabora.com,
        stanimir.varbanov@linaro.org, quic_vgarodia@quicinc.com,
        quic_majja@quicinc.com, quic_jdas@quicinc.com
References: <1647252574-30451-1-git-send-email-quic_dikshita@quicinc.com>
 <1647252574-30451-3-git-send-email-quic_dikshita@quicinc.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <1647252574-30451-3-git-send-email-quic_dikshita@quicinc.com>
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



On 3/14/22 11:09, quic_dikshita@quicinc.com wrote:
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> Add support for intra-refresh type v4l2 control.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/core.h       |  1 +
>  drivers/media/platform/qcom/venus/venc.c       |  6 +++++-
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 10 ++++++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 7c3bac0..65c0f01 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -260,6 +260,7 @@ struct venc_controls {
>  
>  	u32 header_mode;
>  	bool aud_enable;
> +	u32 intra_refresh_type;
>  	u32 intra_refresh_period;
>  
>  	struct {
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 84bafc3..bff8caf 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -893,8 +893,12 @@ static int venc_set_properties(struct venus_inst *inst)
>  				mbs++;
>  			mbs /= ctr->intra_refresh_period;
>  
> -			intra_refresh.mode = HFI_INTRA_REFRESH_RANDOM;
>  			intra_refresh.cir_mbs = mbs;
> +			if (ctr->intra_refresh_type ==
> +			    V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC)
> +				intra_refresh.mode = HFI_INTRA_REFRESH_CYCLIC;
> +			else
> +				intra_refresh.mode = HFI_INTRA_REFRESH_RANDOM;
>  		}
>  
>  		ptype = HFI_PROPERTY_PARAM_VENC_INTRA_REFRESH;
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index 1ada42d..51f5a572 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -316,6 +316,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:
>  		ctr->mastering = *ctrl->p_new.p_hdr10_mastering;
>  		break;
> +	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE:
> +		ctr->intra_refresh_type = ctrl->val;
> +		break;
>  	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:
>  		ctr->intra_refresh_period = ctrl->val;
>  		break;
> @@ -582,6 +585,13 @@ int venc_ctrl_init(struct venus_inst *inst)
>  				   V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY,
>  				   v4l2_ctrl_ptr_create(NULL));
>  
> +	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
> +			       V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE,
> +			       V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC,
> +			       ~((1 << V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM) |
> +			       (1 << V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC)),

Just set this to 0. All menu items in the range 0..max are used, so nothing
needs to be skipped.

This argument should only be set to a non-0 value if one or more items in
the range 0..max are to be skipped.

After that change you can add my:

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> +			       V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM);
> +
>  	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
>  			  V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,
>  			  ((4096 * 2304) >> 8), 1, 0);
