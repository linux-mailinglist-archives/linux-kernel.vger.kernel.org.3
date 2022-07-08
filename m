Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0731056B4A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbiGHImt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbiGHIms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:42:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3C3823AF;
        Fri,  8 Jul 2022 01:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B42C9626A2;
        Fri,  8 Jul 2022 08:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44C6C341C0;
        Fri,  8 Jul 2022 08:42:44 +0000 (UTC)
Message-ID: <9df23a2d-b5c3-ddd5-8594-afc6f36d2350@xs4all.nl>
Date:   Fri, 8 Jul 2022 10:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] hantro: Remove incorrect HEVC SPS validation
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
References: <20220629195624.45745-1-ezequiel@vanguardiasur.com.ar>
 <20220629195624.45745-2-ezequiel@vanguardiasur.com.ar>
 <20220630050232.bpntbghouslye3l3@basti-XPS-13-9310>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220630050232.bpntbghouslye3l3@basti-XPS-13-9310>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/22 07:02, Sebastian Fricke wrote:
> Hey Ezequiel,
> 
> On 29.06.2022 16:56, Ezequiel Garcia wrote:
>> Currently, the driver tries to validat the HEVC SPS
> 
> s/validat/validate/
> 
>> against the CAPTURE queue format (i.e. the decoded format).
>> This is not correct, because typically the SPS control is set
>> before the CAPTURE queue is negotiated.
>>
>> In addition to this, a format validation in hantro_hevc_dec_prepare_run()
>> is also suboptimal, because hantro_hevc_dec_prepare_run() runs in the context
>> of v4l2_m2m_ops.device_run, as part of a decoding job.
>>
>> Format and control validations should happen before decoding starts,
>> in the context of ioctls such as S_CTRL, S_FMT, or STREAMON.
>>
>> Remove the validation for now.
> 
> Couldn't we add a small wrapper around STREAMON to perform that
> validation? I feel like "remove the validation for now", seems like a
> vague statement.

I agree. Basically two things happen in this patch: two sanity checks
for the SPS control are moved to try_ctrl, and that part looks good.

So that can be a separate patch.

The second part is the removal of the format+control validation, but it
is not clear why removing it altogether is wrong. Shouldn't it still be
done somewhere? And if not, why not?

Regards,

	Hans

> 
> Greetings,
> Sebastian
> 
>>
>> Fixes: 135ad96cb4d6b ("media: hantro: Be more accurate on pixel formats step_width constraints")
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>> ---
>> drivers/staging/media/hantro/hantro_drv.c  | 12 ++++-----
>> drivers/staging/media/hantro/hantro_hevc.c | 30 ----------------------
>> drivers/staging/media/hantro/hantro_hw.h   |  1 -
>> 3 files changed, 6 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
>> index afddf7ac0731..2387ca85ab54 100644
>> --- a/drivers/staging/media/hantro/hantro_drv.c
>> +++ b/drivers/staging/media/hantro/hantro_drv.c
>> @@ -253,11 +253,6 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>>
>> static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>> {
>> -    struct hantro_ctx *ctx;
>> -
>> -    ctx = container_of(ctrl->handler,
>> -               struct hantro_ctx, ctrl_handler);
>> -
>>     if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
>>         const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
>>
>> @@ -273,7 +268,12 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>>     } else if (ctrl->id == V4L2_CID_MPEG_VIDEO_HEVC_SPS) {
>>         const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
>>
>> -        return hantro_hevc_validate_sps(ctx, sps);
>> +        if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
>> +            /* Luma and chroma bit depth mismatch */
>> +            return -EINVAL;
>> +        if (sps->bit_depth_luma_minus8 != 0)
>> +            /* Only 8-bit is supported */
>> +            return -EINVAL;
>>     } else if (ctrl->id == V4L2_CID_STATELESS_VP9_FRAME) {
>>         const struct v4l2_ctrl_vp9_frame *dec_params = ctrl->p_new.p_vp9_frame;
>>
>> diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
>> index bd924896e409..f86c98e19177 100644
>> --- a/drivers/staging/media/hantro/hantro_hevc.c
>> +++ b/drivers/staging/media/hantro/hantro_hevc.c
>> @@ -154,32 +154,6 @@ static int tile_buffer_reallocate(struct hantro_ctx *ctx)
>>     return -ENOMEM;
>> }
>>
>> -int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps)
>> -{
>> -    if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
>> -        /* Luma and chroma bit depth mismatch */
>> -        return -EINVAL;
>> -    if (sps->bit_depth_luma_minus8 != 0)
>> -        /* Only 8-bit is supported */
>> -        return -EINVAL;
>> -
>> -    /*
>> -     * for tile pixel format check if the width and height match
>> -     * hardware constraints
>> -     */
>> -    if (ctx->vpu_dst_fmt->fourcc == V4L2_PIX_FMT_NV12_4L4) {
>> -        if (ctx->dst_fmt.width !=
>> -            ALIGN(sps->pic_width_in_luma_samples, ctx->vpu_dst_fmt->frmsize.step_width))
>> -            return -EINVAL;
>> -
>> -        if (ctx->dst_fmt.height !=
>> -            ALIGN(sps->pic_height_in_luma_samples, ctx->vpu_dst_fmt->frmsize.step_height))
>> -            return -EINVAL;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>> int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx)
>> {
>>     struct hantro_hevc_dec_hw_ctx *hevc_ctx = &ctx->hevc_dec;
>> @@ -203,10 +177,6 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx)
>>     if (WARN_ON(!ctrls->sps))
>>         return -EINVAL;
>>
>> -    ret = hantro_hevc_validate_sps(ctx, ctrls->sps);
>> -    if (ret)
>> -        return ret;
>> -
>>     ctrls->pps =
>>         hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_PPS);
>>     if (WARN_ON(!ctrls->pps))
>> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
>> index a2e0f0836281..5edff0f0be20 100644
>> --- a/drivers/staging/media/hantro/hantro_hw.h
>> +++ b/drivers/staging/media/hantro/hantro_hw.h
>> @@ -359,7 +359,6 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
>> void hantro_hevc_ref_init(struct hantro_ctx *ctx);
>> dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, int poc);
>> int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
>> -int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps);
>>
>>
>> static inline unsigned short hantro_vp9_num_sbs(unsigned short dimension)
>> -- 
>> 2.31.1
>>
