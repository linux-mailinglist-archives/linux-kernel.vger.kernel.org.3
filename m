Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DA655713B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 05:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiFWC46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242323AbiFWCzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:55:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5177463A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:55:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so1240491pjj.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OaXOvKIb2IXOCvwDea71lPRpJNnoFZ+3gnAGlvTkOvQ=;
        b=Qo/ALMK5LlOSLHYWAJCZb42Y6mAbMWIvkFbKlARVvkwfE8T22/KnaUV+/f28eLvgdD
         oHZxXTGvaWVGEIWXl1iYYn2bCpA60sbnydmlou3XPVs12L9J4Dyx0UfW1X0mGttX8OVb
         F97umf2lof7IaAYVbOm0A+bU60yW7BvlgHo0ZeJZxgBvfcZSbUnAn27tv687+i5r3hzj
         MglJIu/4+27jlkoHtBOXH0PmdAcNyfTx3E7NfzEAAoEiyqGJRGbEkb3SSRx3UWbjGQ2m
         WqdBkX8e1Fgtwphz+KRxlTI01ix8ljAXYcVwzyGl2l5oMidHAok6izop9RIIpltl/Fti
         +Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OaXOvKIb2IXOCvwDea71lPRpJNnoFZ+3gnAGlvTkOvQ=;
        b=nKwAZ50vfj6cL73AWQtRlHNLhzS1Rf/a9Icbtg0+SI0Wt4y3pN5mBbGGNX0AcELv6/
         KyegONoU4YlXEn6XNETBE6UYHFD8TBwv4/vHWDzMloYWUNa2ST/cPZfwMb0tKNqpVcUn
         7k8EdtPON8Z1OOd7htfH6xXWzroegxWt4njVLoPORkEdGK2WngC0eRwL8tUBRsSCZuBH
         7cxv5dhFQLZfA9HXba6K56V75/om8PT6JWdpEVeEIwYUovl37sX/7hqWTHtPHBTrK0d8
         +XuOptgLi+YxJ7QyT8dwfkKO1MKc0swtxjnwSOMEkO6PitMwfe++BtEECoiI/8QrAftE
         6lSA==
X-Gm-Message-State: AJIora9ZCFYgBlNlDrzNhWSLBkfI8N5qDQB0n0whiWW3liF9iO1nVodA
        1zFp7Qghy7VlWgKj77W1dcU=
X-Google-Smtp-Source: AGRyM1uuz9WGaHHbPpAhRvvNzyQ4Mk1eduo6TKMJ8t0sHlCtF+RPkesfCLaytxxk2RJEPoX2aqmimw==
X-Received: by 2002:a17:902:930c:b0:167:8960:2c39 with SMTP id bc12-20020a170902930c00b0016789602c39mr37161491plb.33.1655952907791;
        Wed, 22 Jun 2022 19:55:07 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902a70a00b001624b1e1a7bsm1598943plq.250.2022.06.22.19.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 19:55:06 -0700 (PDT)
Message-ID: <fe6fe929-578e-5828-7886-3fe69b9d3a6a@gmail.com>
Date:   Thu, 23 Jun 2022 10:55:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm: bridge: sii8620: fix possible off-by-one
Content-Language: en-US
To:     Andrzej Hajda <andrzej.hajda@intel.com>, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, architt@codeaurora.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220518065856.18936-1-hbh25y@gmail.com>
 <dc52f807-f4bc-13d6-7b9e-81b4fe94a6e0@intel.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <dc52f807-f4bc-13d6-7b9e-81b4fe94a6e0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/18 15:57, Andrzej Hajda wrote:
> 
> 
> On 18.05.2022 08:58, Hangyu Hua wrote:
>> The next call to sii8620_burst_get_tx_buf will result in off-by-one
>> When ctx->burst.tx_count + size == ARRAY_SIZE(ctx->burst.tx_buf). The 
>> same
>> thing happens in sii8620_burst_get_rx_buf.
>>
>> This patch also change tx_count and tx_buf to rx_count and rx_buf in
>> sii8620_burst_get_rx_buf. It is unreasonable to check tx_buf's size and
>> use rx_buf.
>>
>> Fixes: e19e9c692f81 ("drm/bridge/sii8620: add support for burst eMSC 
>> transmissions")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
> 
> Regards
> Andrzej
>> ---
>>   drivers/gpu/drm/bridge/sil-sii8620.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c 
>> b/drivers/gpu/drm/bridge/sil-sii8620.c
>> index ec7745c31da0..ab0bce4a988c 100644
>> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
>> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
>> @@ -605,7 +605,7 @@ static void *sii8620_burst_get_tx_buf(struct 
>> sii8620 *ctx, int len)
>>       u8 *buf = &ctx->burst.tx_buf[ctx->burst.tx_count];
>>       int size = len + 2;
>> -    if (ctx->burst.tx_count + size > ARRAY_SIZE(ctx->burst.tx_buf)) {
>> +    if (ctx->burst.tx_count + size >= ARRAY_SIZE(ctx->burst.tx_buf)) {
>>           dev_err(ctx->dev, "TX-BLK buffer exhausted\n");
>>           ctx->error = -EINVAL;
>>           return NULL;
>> @@ -622,7 +622,7 @@ static u8 *sii8620_burst_get_rx_buf(struct sii8620 
>> *ctx, int len)
>>       u8 *buf = &ctx->burst.rx_buf[ctx->burst.rx_count];
>>       int size = len + 1;
>> -    if (ctx->burst.tx_count + size > ARRAY_SIZE(ctx->burst.tx_buf)) {
>> +    if (ctx->burst.rx_count + size >= ARRAY_SIZE(ctx->burst.rx_buf)) {
>>           dev_err(ctx->dev, "RX-BLK buffer exhausted\n");
>>           ctx->error = -EINVAL;
>>           return NULL;
> 

Hi guys,

Another patches for this module that I submitted at the same time as
this one have been merged. Is this patch forgotten to merge?

Thanks,
Hangyu
