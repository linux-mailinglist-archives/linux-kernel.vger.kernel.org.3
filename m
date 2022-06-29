Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106A455FF40
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiF2MKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiF2MKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0537017;
        Wed, 29 Jun 2022 05:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AFB361B74;
        Wed, 29 Jun 2022 12:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F43C341C8;
        Wed, 29 Jun 2022 12:10:10 +0000 (UTC)
Message-ID: <26a83f6a-05a1-f67b-2de5-bd67ea50843d@xs4all.nl>
Date:   Wed, 29 Jun 2022 14:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] media: amphion: only insert the first sequence startcode
 for vc1l format
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220628052017.26979-1-ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220628052017.26979-1-ming.qian@nxp.com>
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

On 28/06/2022 07:20, Ming Qian wrote:
> For some formats, the amphion vpu requires startcode
> before sequence and frame, such as vc1, vp8.
> 
> But for V4L2_PIX_FMT_VC1_ANNEX_L, only the first sequence startcode
> is needed, the extra startcode will cause decoding error.
> So after seek, we don't need to insert the sequence startcode.
> 
> In other words, for V4L2_PIX_FMT_VC1_ANNEX_L,
> the vpu doesn't support dynamic resolution change.

Shouldn't V4L2_FMT_FLAG_DYN_RESOLUTION be removed from that format
since it doesn't support this feature?

Regards,

	Hans

> 
> Fixes: 145e936380edb ("media: amphion: implement malone decoder rpc interface")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  drivers/media/platform/amphion/vdec.c       | 1 +
>  drivers/media/platform/amphion/vpu.h        | 1 +
>  drivers/media/platform/amphion/vpu_malone.c | 2 ++
>  drivers/media/platform/amphion/vpu_rpc.h    | 7 ++++++-
>  4 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
> index 09d4f27970ec..51218a41a5ac 100644
> --- a/drivers/media/platform/amphion/vdec.c
> +++ b/drivers/media/platform/amphion/vdec.c
> @@ -731,6 +731,7 @@ static void vdec_stop_done(struct vpu_inst *inst)
>  	vdec->eos_received = 0;
>  	vdec->is_source_changed = false;
>  	vdec->source_change = 0;
> +	inst->total_input_count = 0;
>  	vpu_inst_unlock(inst);
>  }
>  
> diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
> index e56b96a7e5d3..f914de6ed81e 100644
> --- a/drivers/media/platform/amphion/vpu.h
> +++ b/drivers/media/platform/amphion/vpu.h
> @@ -258,6 +258,7 @@ struct vpu_inst {
>  	struct vpu_format cap_format;
>  	u32 min_buffer_cap;
>  	u32 min_buffer_out;
> +	u32 total_input_count;
>  
>  	struct v4l2_rect crop;
>  	u32 colorspace;
> diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
> index c62b49e85060..f4a488bf9880 100644
> --- a/drivers/media/platform/amphion/vpu_malone.c
> +++ b/drivers/media/platform/amphion/vpu_malone.c
> @@ -1314,6 +1314,8 @@ static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
>  	int size = 0;
>  	u8 rcv_seqhdr[MALONE_VC1_RCV_SEQ_HEADER_LEN];
>  
> +	if (scode->inst->total_input_count)
> +		return 0;
>  	scode->need_data = 0;
>  
>  	ret = vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_VC1_SIMPLE, sizeof(rcv_seqhdr));
> diff --git a/drivers/media/platform/amphion/vpu_rpc.h b/drivers/media/platform/amphion/vpu_rpc.h
> index 25119e5e807e..7eb6f01e6ab5 100644
> --- a/drivers/media/platform/amphion/vpu_rpc.h
> +++ b/drivers/media/platform/amphion/vpu_rpc.h
> @@ -312,11 +312,16 @@ static inline int vpu_iface_input_frame(struct vpu_inst *inst,
>  					struct vb2_buffer *vb)
>  {
>  	struct vpu_iface_ops *ops = vpu_core_get_iface(inst->core);
> +	int ret;
>  
>  	if (!ops || !ops->input_frame)
>  		return -EINVAL;
>  
> -	return ops->input_frame(inst->core->iface, inst, vb);
> +	ret = ops->input_frame(inst->core->iface, inst, vb);
> +	if (ret < 0)
> +		return ret;
> +	inst->total_input_count++;
> +	return ret;
>  }
>  
>  static inline int vpu_iface_config_memory_resource(struct vpu_inst *inst,

