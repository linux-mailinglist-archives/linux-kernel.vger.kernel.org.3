Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384A6511EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbiD0RmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244216AbiD0Rlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:41:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588F262A14;
        Wed, 27 Apr 2022 10:38:34 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:2c00:b769:f52a:a984] (unknown [IPv6:2a01:e0a:120:3210:2c00:b769:f52a:a984])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3F3731F44BC0;
        Wed, 27 Apr 2022 18:38:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651081111;
        bh=DKHT+3N2E30sQ+PZIQ0blxIyuVP2/Uome7ooaaXpxNA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mmK1gZ/wxcjHozltOtbc3hRng/GwOYfuG/Pnj9Xq2dBsnswthlPxyldLcJrowabzC
         Fi2JheDigb5BfzflWWDexy2+1gNIzpebO8BOM0jyt2vE3ZbyeN4C2DApqp1yizIS14
         BUkQ2WHtPfKs1OUbtPKyAEtO/7G86oBDY3rVmrnUhijupep3tM+jdelh0pDyG+afgx
         KL8ri5g+NpURL3VN4zEMCS5suUjcnTXLs+eHPj+D5ZWH0uXyUN3rNnO5I52WfiFRpm
         PN8Cy5Zeo13kMm8gUuvfUZpXXIOfh8U9PFxrO9n9UH9sosfGWBuy2zVGjfQz+yVu9m
         0cbzH8JuILEbw==
Message-ID: <5091e44e-6b44-be2e-f53e-29368009f30d@collabora.com>
Date:   Wed, 27 Apr 2022 19:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: hantro: HEVC: Fix tile info buffer value
 computation
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jon@nanocrew.net, aford173@gmail.com, kernel@collabora.com
References: <20220427135517.381959-1-benjamin.gaignard@collabora.com>
 <20220427142233.GS2462@kadam>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20220427142233.GS2462@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 27/04/2022 à 16:22, Dan Carpenter a écrit :
> On Wed, Apr 27, 2022 at 03:55:17PM +0200, Benjamin Gaignard wrote:
>> Use pps->column_width_minus1[j] + 1 as value for the tile info buffer
>> instead of pps->column_width_minus1[j + 1].
>> The patch fix DBLK_E_VIXS_2, DBLK_F_VIXS_2, DBLK_G_VIXS_2,
>> SAO_B_MediaTek_5, TILES_A_Cisco_2 and TILES_B_Cisco_1 tests in fluster.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Fixes: cb5dd5a0fa51 ("media: hantro: Introduce G2/HEVC decoder")
>
>> ---
>>   drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>> index bb512389c1a5..ffeb2fbeefd2 100644
>> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>> @@ -74,7 +74,7 @@ static void prepare_tile_info_buffer(struct hantro_ctx *ctx)
>>   					no_chroma = 1;
>>   				for (j = 0, tmp_w = 0; j < num_tile_cols - 1; j++) {
>                                                                          ^^^^
> Is this "- 1" still required?  I would have assumed the "- 1" here was
> connected with the [j + 1].  What is stored in the last element of the
> ->column_width_minus1 array?

No "- 1" comes from the definition of the field in H.265 which is pps->num_tile_columns_minus1
We add 1 to fill the registers so we need the "- 1" in the loop.
Data ordering isn't documented anywhere so that part is directly inspired by
Hantro/G2 proprietary stack.

Regards,
Benjamin

>
>>   					tmp_w += pps->column_width_minus1[j] + 1;
>> -					*p++ = pps->column_width_minus1[j + 1];
>                                                                          ^^^^^
>
>> +					*p++ = pps->column_width_minus1[j] + 1;
>>   					*p++ = h;
>>   					if (i == 0 && h == 1 && ctb_size == 16)
>>   						no_chroma = 1;
> regards,
> dan carpenter
