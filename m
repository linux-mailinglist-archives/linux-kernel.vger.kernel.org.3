Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3EB5781B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiGRMJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiGRMJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:09:19 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C2FDE2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:08:49 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso23012588fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SJp1q6XJR6dWugl7INyRf6dofrjwqu21++Nv2wqMW3M=;
        b=cE7M0Le1tSAGbGcrlSggeXY0y9LTHbcIIk3Iqy4k8VglLhovX5RxkiCh4QpsDEnH/B
         ft3q8I8czp3+JTGvlD181UGX0CyE2hKksgBtChxhxg6Z6tu5MjC6vmq6q6M/C9Ghmdm7
         Qq3g/geOnQUy7RnR0TurDmTIbjLWXi5TaYZ6CA8Atwg+2+bcGSWyFf62GGWewumW0GRM
         SpLzjA8mSbU7+aOEgKcpkrh3N6QhWvHsoFNNEnj3+1JfZzUcDFfs75HWKmsfFwWun/UA
         5ZnpjnGtzF8vj+kQK0kIZAb5AkPhpxrDHgImytWG9LwGnhYrOIv311Q7tnzpfVPV+dWD
         1vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SJp1q6XJR6dWugl7INyRf6dofrjwqu21++Nv2wqMW3M=;
        b=lAT7L3/cyNcdPWNBnX+Mjd0cVaSQQZDlh4JUUwEAz/Wnsow1mt2s5mqRFrjXmuQSW7
         5YLMFtf4t5Q1TF7UnVspf1UAfmxpbCvtn64/PXp3JnXfXCjxHJay9BUY2WK3oMdkDI9Q
         eon+8FWo+lhoJzKAe8fTBpvWOfgt5ba/00DFkfIbh9yRtFukE+anOfO6CF6XS7N5t3nm
         gIPRQ5JM05kInbtbP8PakLzGTbnPrAq67tIbbmbi0IVlmxpjvVEIuQwzRtEfHxSqo+Hi
         Qs5Oxl1NQ+wDnJodUS+pLgAuNvm8FKQj6Pt9IYmJ4bnc1aU6SiZu+H3trXn0hFvOCtWR
         YwAg==
X-Gm-Message-State: AJIora/lOse434+nSxlXciantAP/FIVZKIOA/8YLSCubiwkkyCH1l+T0
        oO4Q7Hyz4FQFIHd0JDN3kONXOg==
X-Google-Smtp-Source: AGRyM1v5lt+xpMi5RRnjhUp/8kHGdPVxIcx8yOKnAV0q5Q81rMdFBEGoE3nE4a9U/h1ZBjdKdFeARw==
X-Received: by 2002:a05:6871:611:b0:10c:4bc0:88b9 with SMTP id w17-20020a056871061100b0010c4bc088b9mr13880800oan.81.1658146122843;
        Mon, 18 Jul 2022 05:08:42 -0700 (PDT)
Received: from eze-laptop ([186.13.97.222])
        by smtp.gmail.com with ESMTPSA id l24-20020a056830155800b0061c8bca21d8sm1041786otp.2.2022.07.18.05.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 05:08:42 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:08:36 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH] hantro: Remove incorrect HEVC SPS validation
Message-ID: <YtVNRG99emUfdE52@eze-laptop>
References: <20220629195624.45745-1-ezequiel@vanguardiasur.com.ar>
 <20220629195624.45745-2-ezequiel@vanguardiasur.com.ar>
 <20220630050232.bpntbghouslye3l3@basti-XPS-13-9310>
 <9df23a2d-b5c3-ddd5-8594-afc6f36d2350@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9df23a2d-b5c3-ddd5-8594-afc6f36d2350@xs4all.nl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Fri, Jul 08, 2022 at 10:42:43AM +0200, Hans Verkuil wrote:
> 
> 
> On 6/30/22 07:02, Sebastian Fricke wrote:
> > Hey Ezequiel,
> > 
> > On 29.06.2022 16:56, Ezequiel Garcia wrote:
> >> Currently, the driver tries to validat the HEVC SPS
> > 
> > s/validat/validate/
> > 
> >> against the CAPTURE queue format (i.e. the decoded format).
> >> This is not correct, because typically the SPS control is set
> >> before the CAPTURE queue is negotiated.
> >>
> >> In addition to this, a format validation in hantro_hevc_dec_prepare_run()
> >> is also suboptimal, because hantro_hevc_dec_prepare_run() runs in the context
> >> of v4l2_m2m_ops.device_run, as part of a decoding job.
> >>
> >> Format and control validations should happen before decoding starts,
> >> in the context of ioctls such as S_CTRL, S_FMT, or STREAMON.
> >>
> >> Remove the validation for now.
> > 
> > Couldn't we add a small wrapper around STREAMON to perform that
> > validation? I feel like "remove the validation for now", seems like a
> > vague statement.
> 
> I agree. Basically two things happen in this patch: two sanity checks
> for the SPS control are moved to try_ctrl, and that part looks good.
> 
> So that can be a separate patch.
> 
> The second part is the removal of the format+control validation, but it
> is not clear why removing it altogether is wrong. Shouldn't it still be
> done somewhere? And if not, why not?
> 

Sorry for the delayed reply. After giving this format+control validation
more thought, I believe the V4L2 API provides a natural way of handling.

When the format is negotiated in TRY_FMT, the control needs to be used
to offer a valid resolution.

The driver is capable of negotiating the resolution of the stream
using the control information, instead of failing.

I'll send a v2 with a new proposal.

Thanks,
Ezequiel

> Regards,
> 
> 	Hans
> 
> > 
> > Greetings,
> > Sebastian
> > 
> >>
> >> Fixes: 135ad96cb4d6b ("media: hantro: Be more accurate on pixel formats step_width constraints")
> >> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> >> ---
> >> drivers/staging/media/hantro/hantro_drv.c  | 12 ++++-----
> >> drivers/staging/media/hantro/hantro_hevc.c | 30 ----------------------
> >> drivers/staging/media/hantro/hantro_hw.h   |  1 -
> >> 3 files changed, 6 insertions(+), 37 deletions(-)
> >>
> >> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> >> index afddf7ac0731..2387ca85ab54 100644
> >> --- a/drivers/staging/media/hantro/hantro_drv.c
> >> +++ b/drivers/staging/media/hantro/hantro_drv.c
> >> @@ -253,11 +253,6 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
> >>
> >> static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
> >> {
> >> -    struct hantro_ctx *ctx;
> >> -
> >> -    ctx = container_of(ctrl->handler,
> >> -               struct hantro_ctx, ctrl_handler);
> >> -
> >>     if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
> >>         const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
> >>
> >> @@ -273,7 +268,12 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
> >>     } else if (ctrl->id == V4L2_CID_MPEG_VIDEO_HEVC_SPS) {
> >>         const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
> >>
> >> -        return hantro_hevc_validate_sps(ctx, sps);
> >> +        if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
> >> +            /* Luma and chroma bit depth mismatch */
> >> +            return -EINVAL;
> >> +        if (sps->bit_depth_luma_minus8 != 0)
> >> +            /* Only 8-bit is supported */
> >> +            return -EINVAL;
> >>     } else if (ctrl->id == V4L2_CID_STATELESS_VP9_FRAME) {
> >>         const struct v4l2_ctrl_vp9_frame *dec_params = ctrl->p_new.p_vp9_frame;
> >>
> >> diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
> >> index bd924896e409..f86c98e19177 100644
> >> --- a/drivers/staging/media/hantro/hantro_hevc.c
> >> +++ b/drivers/staging/media/hantro/hantro_hevc.c
> >> @@ -154,32 +154,6 @@ static int tile_buffer_reallocate(struct hantro_ctx *ctx)
> >>     return -ENOMEM;
> >> }
> >>
> >> -int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps)
> >> -{
> >> -    if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
> >> -        /* Luma and chroma bit depth mismatch */
> >> -        return -EINVAL;
> >> -    if (sps->bit_depth_luma_minus8 != 0)
> >> -        /* Only 8-bit is supported */
> >> -        return -EINVAL;
> >> -
> >> -    /*
> >> -     * for tile pixel format check if the width and height match
> >> -     * hardware constraints
> >> -     */
> >> -    if (ctx->vpu_dst_fmt->fourcc == V4L2_PIX_FMT_NV12_4L4) {
> >> -        if (ctx->dst_fmt.width !=
> >> -            ALIGN(sps->pic_width_in_luma_samples, ctx->vpu_dst_fmt->frmsize.step_width))
> >> -            return -EINVAL;
> >> -
> >> -        if (ctx->dst_fmt.height !=
> >> -            ALIGN(sps->pic_height_in_luma_samples, ctx->vpu_dst_fmt->frmsize.step_height))
> >> -            return -EINVAL;
> >> -    }
> >> -
> >> -    return 0;
> >> -}
> >> -
> >> int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx)
> >> {
> >>     struct hantro_hevc_dec_hw_ctx *hevc_ctx = &ctx->hevc_dec;
> >> @@ -203,10 +177,6 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx)
> >>     if (WARN_ON(!ctrls->sps))
> >>         return -EINVAL;
> >>
> >> -    ret = hantro_hevc_validate_sps(ctx, ctrls->sps);
> >> -    if (ret)
> >> -        return ret;
> >> -
> >>     ctrls->pps =
> >>         hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_PPS);
> >>     if (WARN_ON(!ctrls->pps))
> >> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> >> index a2e0f0836281..5edff0f0be20 100644
> >> --- a/drivers/staging/media/hantro/hantro_hw.h
> >> +++ b/drivers/staging/media/hantro/hantro_hw.h
> >> @@ -359,7 +359,6 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
> >> void hantro_hevc_ref_init(struct hantro_ctx *ctx);
> >> dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, int poc);
> >> int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
> >> -int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps);
> >>
> >>
> >> static inline unsigned short hantro_vp9_num_sbs(unsigned short dimension)
> >> -- 
> >> 2.31.1
> >>
