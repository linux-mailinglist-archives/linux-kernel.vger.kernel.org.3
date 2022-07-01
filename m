Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9A8562F63
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiGAJD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiGAJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:03:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3CA1571A;
        Fri,  1 Jul 2022 02:03:23 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:2a18:eef7:517c:3467] (unknown [IPv6:2a01:e0a:120:3210:2a18:eef7:517c:3467])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 099BA66015B2;
        Fri,  1 Jul 2022 10:03:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656666201;
        bh=HeVABiQifDKZmsejKzWKuWsrRSudGKBJZ7pqrByEerQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nwQ+wI922KmSe3X33SneWndU3TbI/sjRvPQJ8Dr5Xx5e+O3qg5hog/1NfrfSZLLa+
         uiofarX6QER7SRj2Socni4uPTSAQWRCqvBlpKKJW9qGo5lGcEk2o08vW2y1EogP2yf
         Er5jCtdTUH1iSLSOQe/5IZo2K3fmdvkTD8DY16m2Bto4fPs3QeAcL2Otxzd/KusWTh
         +5WhbyviowG4guFPNMai5QO1z1hlQI4fVdmiSKw2/rCJl+CsdHNDVuFp5LAVwrEHsh
         QhTDO0SZt/zk+9K5tTKjKTU+cWKKVLKpaDNBmWwyxA41gdiPS+vybDFYccNgp4oEzr
         H6JM/1lzE99Gw==
Message-ID: <37145626-1a7e-2aba-4f3c-4d0574729a41@collabora.com>
Date:   Fri, 1 Jul 2022 11:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/7] media: hantro: HEVC: Fix chroma offset computation
Content-Language: en-US
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
References: <20220617115802.396442-1-benjamin.gaignard@collabora.com>
 <20220617115802.396442-4-benjamin.gaignard@collabora.com>
 <Yr60jj4OOAM6plWC@aptenodytes>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <Yr60jj4OOAM6plWC@aptenodytes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 01/07/2022 à 10:47, Paul Kocialkowski a écrit :
> Hi Benjamin,
>
> On Fri 17 Jun 22, 13:57, Benjamin Gaignard wrote:
>> The chroma offset depends of the bitstream depth.
>> Make sure that ctx->bit_depth is used to compute it.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>> index 9eac133bda68..8407ad45b7b7 100644
>> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>> @@ -12,7 +12,7 @@
>>   
>>   static size_t hantro_hevc_chroma_offset(struct hantro_ctx *ctx)
>>   {
>> -	return ctx->dst_fmt.width * ctx->dst_fmt.height;
>> +	return ctx->dst_fmt.width * ctx->dst_fmt.height * ctx->bit_depth / 8;
> Is this a case for DIV_ROUND_UP or are you sure the rounded-down size is always
> sufficient?

No need of DIV_ROUND_UP here because it could affect the chroma offset when
using decoder tiled format and add extra bytes between luma and chroma planes.

Regards,
Benjamin

> Cheers,
>
> Paul
>
>>   }
>>   
>>   static size_t hantro_hevc_motion_vectors_offset(struct hantro_ctx *ctx)
>> -- 
>> 2.32.0
>>
