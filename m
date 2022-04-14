Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3235007B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbiDNIEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiDNIEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:04:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693CE4BB97;
        Thu, 14 Apr 2022 01:02:14 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:aefc:13d9:b947:5c76] (unknown [IPv6:2a01:e0a:120:3210:aefc:13d9:b947:5c76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3BEE71F4769C;
        Thu, 14 Apr 2022 09:02:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649923332;
        bh=RFbpJ1I3WcLfiaLAFsi5mngxuqlpAEWsg+scuunDdh0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h8EFezQvks1gbQPoLnNC7+mQWwxiIL7tgJAYg1wM4DO6W3p04jUnqdzJHFuP+2Eok
         HBMA0Hrhu/0zDNIhPqpZHVxSXgsI19s+v5Dr94Pnmcy5fd5cqL0J2tq9arjY8o5MN8
         1zvdytWoIzP6jfGapogPmuJr8PCtUWUL+zUpISopHYK3HXtnrXGufbdHKk0iFNxoJl
         QjZxU0Wi1fANKP8G2MVXrqcZANK8NQBD+vVXHPrggQgpphrjJdUKyt1nYV3PcHgWen
         D2Lz5+8e5L0mM/eAUmux1YRVefz473o6bgfemDRqlY+nTDEKEoiN7stgTC/cAyw/dJ
         2HMUq7UZmE29A==
Message-ID: <7a32fd89-a90f-d921-1f0b-e0eaeb9db71e@collabora.com>
Date:   Thu, 14 Apr 2022 10:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 06/17] media: uapi: HEVC: Change pic_order_cnt
 definition in v4l2_hevc_dpb_entry
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        sebastian.fricke@collabora.com
References: <20220407152940.738159-1-benjamin.gaignard@collabora.com>
 <20220407152940.738159-7-benjamin.gaignard@collabora.com>
 <34f586efdd6401b509cf11fba75039d5494c4eff.camel@collabora.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <34f586efdd6401b509cf11fba75039d5494c4eff.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 08/04/2022 à 18:33, Nicolas Dufresne a écrit :
> Le jeudi 07 avril 2022 à 17:29 +0200, Benjamin Gaignard a écrit :
>> HEVC specifications say that:
>> "PicOrderCntVal is derived as follows:
>> PicOrderCntVal = PicOrderCntMsb + slice_pic_order_cnt_lsb
>> The value of PicOrderCntVal shall be in the range of −231 to 231 − 1, inclusive."
>>
>> To match with these definitions change __u16 pic_order_cnt[2]
>> into __s32 pic_order_cnt_val.
> You forgot to update the slice_params->slice_pic_order_count.

Thanks it will be in v6

Benjamin

>
> Nicolas
>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>> version 5:
>> - change __u16 pic_order_cnt[2] into __s32 pic_order_cnt_val
>>   drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 4 ++--
>>   drivers/staging/media/hantro/hantro_hevc.c        | 2 +-
>>   drivers/staging/media/hantro/hantro_hw.h          | 4 ++--
>>   drivers/staging/media/sunxi/cedrus/cedrus_h265.c  | 4 ++--
>>   include/media/hevc-ctrls.h                        | 2 +-
>>   5 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>> index c524af41baf5..6f3c774aa3d9 100644
>> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>> @@ -386,7 +386,7 @@ static int set_ref(struct hantro_ctx *ctx)
>>   	 * pic_order_cnt[0] and ignore pic_order_cnt[1] used in field-coding.
>>   	 */
>>   	for (i = 0; i < decode_params->num_active_dpb_entries && i < ARRAY_SIZE(cur_poc); i++) {
>> -		char poc_diff = decode_params->pic_order_cnt_val - dpb[i].pic_order_cnt[0];
>> +		char poc_diff = decode_params->pic_order_cnt_val - dpb[i].pic_order_cnt_val;
>>   
>>   		hantro_reg_write(vpu, &cur_poc[i], poc_diff);
>>   	}
>> @@ -413,7 +413,7 @@ static int set_ref(struct hantro_ctx *ctx)
>>   	dpb_longterm_e = 0;
>>   	for (i = 0; i < decode_params->num_active_dpb_entries &&
>>   	     i < (V4L2_HEVC_DPB_ENTRIES_NUM_MAX - 1); i++) {
>> -		luma_addr = hantro_hevc_get_ref_buf(ctx, dpb[i].pic_order_cnt[0]);
>> +		luma_addr = hantro_hevc_get_ref_buf(ctx, dpb[i].pic_order_cnt_val);
>>   		if (!luma_addr)
>>   			return -ENOMEM;
>>   
>> diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
>> index b6ec86d03d91..fadd40768579 100644
>> --- a/drivers/staging/media/hantro/hantro_hevc.c
>> +++ b/drivers/staging/media/hantro/hantro_hevc.c
>> @@ -54,7 +54,7 @@ static void hantro_hevc_ref_init(struct hantro_ctx *ctx)
>>   }
>>   
>>   dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx,
>> -				   int poc)
>> +				   s32 poc)
>>   {
>>   	struct hantro_hevc_dec_hw_ctx *hevc_dec = &ctx->hevc_dec;
>>   	int i;
>> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
>> index ed018e293ba0..a648c529662b 100644
>> --- a/drivers/staging/media/hantro/hantro_hw.h
>> +++ b/drivers/staging/media/hantro/hantro_hw.h
>> @@ -131,7 +131,7 @@ struct hantro_hevc_dec_hw_ctx {
>>   	struct hantro_aux_buf tile_bsd;
>>   	struct hantro_aux_buf ref_bufs[NUM_REF_PICTURES];
>>   	struct hantro_aux_buf scaling_lists;
>> -	int ref_bufs_poc[NUM_REF_PICTURES];
>> +	s32 ref_bufs_poc[NUM_REF_PICTURES];
>>   	u32 ref_bufs_used;
>>   	struct hantro_hevc_dec_ctrls ctrls;
>>   	unsigned int num_tile_cols_allocated;
>> @@ -337,7 +337,7 @@ int hantro_hevc_dec_init(struct hantro_ctx *ctx);
>>   void hantro_hevc_dec_exit(struct hantro_ctx *ctx);
>>   int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx);
>>   int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
>> -dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, int poc);
>> +dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
>>   int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
>>   void hantro_hevc_ref_remove_unused(struct hantro_ctx *ctx);
>>   size_t hantro_hevc_chroma_offset(const struct v4l2_ctrl_hevc_sps *sps);
>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>> index 44f385be9f6c..d04521ffd920 100644
>> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>> @@ -143,8 +143,8 @@ static void cedrus_h265_frame_info_write_dpb(struct cedrus_ctx *ctx,
>>   	for (i = 0; i < num_active_dpb_entries; i++) {
>>   		int buffer_index = vb2_find_timestamp(vq, dpb[i].timestamp, 0);
>>   		u32 pic_order_cnt[2] = {
>> -			dpb[i].pic_order_cnt[0],
>> -			dpb[i].pic_order_cnt[1]
>> +			dpb[i].pic_order_cnt_val & 0xffff,
>> +			(dpb[i].pic_order_cnt_val >> 16) & 0xffff
>>   		};
>>   
>>   		cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_pic,
>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>> index b3540167df9e..2812778b41f4 100644
>> --- a/include/media/hevc-ctrls.h
>> +++ b/include/media/hevc-ctrls.h
>> @@ -138,7 +138,7 @@ struct v4l2_hevc_dpb_entry {
>>   	__u64	timestamp;
>>   	__u8	flags;
>>   	__u8	field_pic;
>> -	__u16	pic_order_cnt[2];
>> +	__s32	pic_order_cnt_val;
>>   	__u8	padding[2];
>>   };
>>   
