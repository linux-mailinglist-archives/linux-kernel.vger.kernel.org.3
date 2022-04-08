Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234474F8F32
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiDHHMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiDHHMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:12:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40DBCB59;
        Fri,  8 Apr 2022 00:10:18 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:da49:7795:4c90:2fa7] (unknown [IPv6:2a01:e0a:120:3210:da49:7795:4c90:2fa7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1CA471F46BDC;
        Fri,  8 Apr 2022 08:10:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649401816;
        bh=+bt/YbyiPOyPA87cqGdJcjVhlj/E13EpsXMdgA+VOXw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VWR3yI+rKqTJgWHZqownCRQbMWjSSD6PMSTe9XbtHsOcLhPWkcnaS/rDz2jakyahR
         vdzBSTntXU4yAhnQeQ58NUgEWNvOeaf768WCowqj1GrZ1i8QI1i0P5Dx4uaFaA3uSy
         +E6w2XSgyuDcRE33Ex3d1tAD4ZfbgOBYDgkhh48ujz5YYNSijVVH/5CnKgmkeeecN0
         FSrO4ftVlJvLRR6Z7WIHpX4xejf440OFYEHTgyZPDf+hs7LeBhjn08pHjnb2SMuOPN
         zB/eN87dmZ66D+nKc4uZr/CcRLRGiHxgdL9vGGI6aNOix6dRjx8rNl4Zbi5X9zXHy0
         cZTZWhvq0B5Qw==
Message-ID: <a7c4a405-faf8-c02b-d9af-f6566725c5a2@collabora.com>
Date:   Fri, 8 Apr 2022 09:10:13 +0200
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
 <b137de92ea0a6ecc3aa8ff39f6a1fc96b071b3e4.camel@collabora.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <b137de92ea0a6ecc3aa8ff39f6a1fc96b071b3e4.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 07/04/2022 à 22:51, Nicolas Dufresne a écrit :
> Le jeudi 07 avril 2022 à 17:29 +0200, Benjamin Gaignard a écrit :
>> HEVC specifications say that:
>> "PicOrderCntVal is derived as follows:
>> PicOrderCntVal = PicOrderCntMsb + slice_pic_order_cnt_lsb
>> The value of PicOrderCntVal shall be in the range of −231 to 231 − 1, inclusive."
> Did you mean 2^31 ?

yes it is 2^31

>> To match with these definitions change __u16 pic_order_cnt[2]
>> into __s32 pic_order_cnt_val.
>>
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
> Was this strictly needed ? Isn't int always same as s32 ?

could be, but like this I'm sure it is fine in all cases

>
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
> This is confusing, it gives the impression that pic_order_cnt_val contains TOP
> and BOTTOM field pic_order_cnt, which isn't the case. This is just the full pic
> order count value for this reference.
>
> This is confusing me, most HEVC decoder don't really know about fields. They
> will instead happily produce half height frames, and we should support this in
> the form of ALTERNATE or SEQ interlacing output.
>
> While it seems like Allwinner HW maybe support interleaved output, there I would
> not find any userland that would implement this, hence proving that it works.
> Overall, interlaced HEVC (a very niche use case) should be studied, and we
> should ensure that alternate/seq interlacing is possible, since a lot of HW will
> only offer this.

In GST code pic_order_cnt[0] and pic_order_cnt[1] had the same value so Cedrus
driver always put the same value in this register.
I haven't any clue of want the hardware expect here.
Maybe some maintainers can explain what we should set on these fields.

Benjamin

>
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
