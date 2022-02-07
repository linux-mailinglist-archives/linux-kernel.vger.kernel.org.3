Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EF44AB727
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbiBGJBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243962AbiBGI7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:59:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3BDC043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:59:16 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 64EC44003A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644224355;
        bh=oEjed3fIhq32IMOHlcIF6oQTrZpj51jzYKSbl17Ied4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=i1uXWK8DdE7DfM0tbjZ00M5sPGlKfgzZxbIb8MoWK4rkimkBJ56amV7964qOFP/Uj
         FOSXUTOszZHzxuRs+CzQnK9RPrre6qmWnNLLWBlf77ELCuAIL/A///TpkOKowBKiEk
         WP37Hdoqk1cI49miuyJXLgmCMtjuqLDwoxsDyx3R7wWLvob77lOjJ1lTIIMqepUqON
         bD05XeqP3sLzQqeS9hG3UPzfPQn6Q+pRjiLBXgZSJ8GXytTmSsdV5nUzEv7tyHtnBb
         R4vW3Qy238mzrx8mrXA3uZJlKhkFQHg6HE+fi9BFKpzcvSnh5zkwjfHqIm8ocmc7TE
         dp0fvAoaLSHRA==
Received: by mail-wm1-f69.google.com with SMTP id l16-20020a7bcf10000000b0034ffdd81e7aso5360567wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 00:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oEjed3fIhq32IMOHlcIF6oQTrZpj51jzYKSbl17Ied4=;
        b=60MrgHzeuH3EgVCJQCEaZOFETLZN38f8lqS3bFyOJHdW0FVa2Bi2qgdYxV0ztoCZwU
         FqjWuyWG997UkYtwIGCg6qzTilfGOsuA8TBdWFp/7W3E307ddlOn/zqiOzyvDc4DTvRQ
         AaVE6jD77ALD9801Ek/LCysxNS4X3x6cWSyHep/UnxPy0PoDuHfkZXUgWbujwKcN63b5
         FVrAgvtYrlf8UI4sk95aSVgsj0PGQGPrW8OlW21AQoWXbB3mDfgAjO7/O4ssnqc73QUk
         E6j/R+7uvkq3TYGoG+8tTt22m5d0dZ9Kb3Yl1l/7TmLwyimh62vhzdMJ1RnH+x9ubtDL
         YuUw==
X-Gm-Message-State: AOAM5307NisrQPy6c5OphpxozIowlvopFnrCdaOQo77O5hRDPrn1J8xU
        kKd4H7HGkgXjDBkYb4IrqTE5RJrqqj+1x+uViIRJwysWWJkszG3cX3SUiUqoxedCWZEN8RqSMww
        nRWDaTHMloCKbMY1Nx4TIwao2pS9bdUbP84KQq/RLxw==
X-Received: by 2002:adf:ce85:: with SMTP id r5mr4374607wrn.343.1644224355111;
        Mon, 07 Feb 2022 00:59:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweatKPbt15m4IWLQ+h0RfaFNSWZUextgkIqFhmsrO4tXSQ63YIb2/Ah2vi0QdAf43JWVr83Q==
X-Received: by 2002:adf:ce85:: with SMTP id r5mr4374592wrn.343.1644224354917;
        Mon, 07 Feb 2022 00:59:14 -0800 (PST)
Received: from [192.168.0.86] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id u11sm3197884wrt.108.2022.02.07.00.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 00:59:14 -0800 (PST)
Message-ID: <4cf27630-31b0-c9f4-ee86-a33ebc49afe2@canonical.com>
Date:   Mon, 7 Feb 2022 09:59:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] memory: mtk-smi: Enable sleep ctrl safety function for
 MT8195
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com
Cc:     matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220204125543.1189151-1-angelogioacchino.delregno@collabora.com>
 <6c360daa-151b-5bb3-5c93-17f90cb693a6@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <6c360daa-151b-5bb3-5c93-17f90cb693a6@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 04:12, Macpaul Lin wrote:
> On 2/4/22 8:55 PM, AngeloGioacchino Del Regno wrote:
>> Enable the sleep ctrl function to wait until all the queued commands
>> are executed before suspending the LARBs, like done for MT8186.
>> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/memory/mtk-smi.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
>> index c22acd3ddd10..86a3d34f418e 100644
>> --- a/drivers/memory/mtk-smi.c
>> +++ b/drivers/memory/mtk-smi.c
>> @@ -351,7 +351,8 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
>>   
>>   static const struct mtk_smi_larb_gen mtk_smi_larb_mt8195 = {
>>   .config_port                = mtk_smi_larb_config_port_gen2_general,
>> -.flags_general            = MTK_SMI_FLAG_THRT_UPDATE | MTK_SMI_FLAG_SW_FLAG,
>> +.flags_general            = MTK_SMI_FLAG_THRT_UPDATE | MTK_SMI_FLAG_SW_FLAG |
>> +      MTK_SMI_FLAG_SLEEP_CTL,
>>   .ostd            = mtk_smi_larb_mt8195_ostd,
>>   };
>>   
>> 
> 
> Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>

Thanks for the review, appreciated!


> ************* MEDIATEK Confidentiality Notice
>  ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe
>  
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

Please work on your email setup, so we won't see such stuff. I know it
is autogenerated by company systems, yet still it should not be put in
public discussion.


Best regards,
Krzysztof
