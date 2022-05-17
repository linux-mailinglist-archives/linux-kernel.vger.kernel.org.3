Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191BE529E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245040AbiEQJmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239753AbiEQJll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:41:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356CB3DA68
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:41:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6C4FE1F4444E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652780492;
        bh=PPIgkaWPk15dgyzq/HkLMqHpY+oCN4E+hy9YI/AB2gQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SZZBfKPMKBju08Lyb4AOiSQs6ZlnukomJCj4jXKLU2mNyz8OITOLZzAA4hJVeGhRR
         sySdPoksQFofTHDPdCT8We/pIPDYG8aa7/+T15Wv6ILq7X8k9UIIS/k3/rVKMc4xtM
         SMiHBMBSzHtFrBmFqLLieAj6+CJyFPJveZN421psOX1TRGHL0I+SviNhejNig4u+zJ
         KI04i3GQFvMDTu0aZNUqF+HcExc4UaRtIC0lFCBJ6fGt41pdRd6MMowsZqv+caa3tl
         wEbTLEiSTGcpxOFsF351xVItZjDn2S5vSnLo+HdtELq3qTXpxsmJDU5/1B+vwREv74
         8MUO+yL7LHvPQ==
Message-ID: <9f197c69-fe04-b636-afb7-8474763c8a3a@collabora.com>
Date:   Tue, 17 May 2022 11:41:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 1/5] soc: mediatek: pwrap: Use readx_poll_timeout()
 instead of custom function
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com
References: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
 <20220516124659.69484-2-angelogioacchino.delregno@collabora.com>
 <f8acbc75-970c-62fb-ad0d-914e512104a7@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <f8acbc75-970c-62fb-ad0d-914e512104a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/22 11:25, Matthias Brugger ha scritto:
> 
> 
> On 16/05/2022 14:46, AngeloGioacchino Del Regno wrote:
>> Function pwrap_wait_for_state() is a function that polls an address
>> through a helper function, but this is the very same operation that
>> the readx_poll_timeout macro means to do.
>> Convert all instances of calling pwrap_wait_for_state() to instead
>> use the read_poll_timeout macro.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> ---
>>   drivers/soc/mediatek/mtk-pmic-wrap.c | 60 +++++++++++++++-------------
>>   1 file changed, 33 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c 
>> b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> index bf39a64f3ecc..54a5300ab72b 100644
>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> @@ -13,6 +13,9 @@
>>   #include <linux/regmap.h>
>>   #include <linux/reset.h>
>> +#define PWRAP_POLL_DELAY_US    10
>> +#define PWRAP_POLL_TIMEOUT_US    10000
>> +
>>   #define PWRAP_MT8135_BRIDGE_IORD_ARB_EN        0x4
>>   #define PWRAP_MT8135_BRIDGE_WACS3_EN        0x10
>>   #define PWRAP_MT8135_BRIDGE_INIT_DONE3        0x14
>> @@ -1241,27 +1244,14 @@ static bool pwrap_is_fsm_idle_and_sync_idle(struct 
>> pmic_wrapper *wrp)
>>           (val & PWRAP_STATE_SYNC_IDLE0);
>>   }
>> -static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
>> -        bool (*fp)(struct pmic_wrapper *))
>> -{
>> -    unsigned long timeout;
>> -
>> -    timeout = jiffies + usecs_to_jiffies(10000);
>> -
>> -    do {
>> -        if (time_after(jiffies, timeout))
>> -            return fp(wrp) ? 0 : -ETIMEDOUT;
>> -        if (fp(wrp))
>> -            return 0;
>> -    } while (1);
>> -}
>> -
>>   static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>>   {
>> +    bool tmp;
>>       int ret;
>>       u32 val;
>> -    ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
>> +    ret = readx_poll_timeout(pwrap_is_fsm_idle, wrp, tmp, tmp,
> 
> hm, if we make the cond (tmp > 0) that would help to understand the code. At least 
> I had to think about it for a moment. But I leave it to you if you think it's worth 
> the effort.
> 

I would prefer size over readability in this case... if we do (tmp > 0), it would
be incorrect to keep tmp as a `bool`, we would have to set it as an integer var,
which is unnecessarily bigger (that's the reason why I wrote it like so!).

Another way to increase human readability would be to do (tmp == true), but it
looks a bit weird to me, doesn't it?
If you disagree about that looking weird, though, I can go with that one, perhaps!

Cheers,
Angelo
