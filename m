Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454EA50DE2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbiDYKx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbiDYKxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:53:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2DA6F496;
        Mon, 25 Apr 2022 03:50:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u3so20247956wrg.3;
        Mon, 25 Apr 2022 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tqEMndNZi/OKNdfz1rG66xAmo29YAR2nDbIFZiYUSJA=;
        b=CHjRkfofF3zINo2vMexr7UwqWc3ZT7wy9/uXigv05NN49JlV6fSr9/pLePECJSd/Qo
         9A5QIKP9WHHvquE23IF6GjiIfBi9PUXca66j4fOruNceF/Qq5kBxplxq69Lza0l7D7p/
         Vzqrcv+FEmdhgclG+Rry6A1IWp4c+zHRm1ucGAdGXQ/t69oSnSCyVCcmA6av5EZkUaMf
         pHMqh1i6CBjIkQnRlFBqKDk/Sggj1GK0X/x5nGPSyOpr1t0MPvhiu1k4F/kUkEnT/Q75
         9J4FuuNAV0pk9+X4o+1vj6z/F0uIiZtdCvwHBy6uZfWYutKQL8Or7eg80I7zbPhj8hpq
         //FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tqEMndNZi/OKNdfz1rG66xAmo29YAR2nDbIFZiYUSJA=;
        b=GzCuApQdDgCyy8YeudRcpoiammaQEJ5umae8jVZ2Y5LkaUzb7FL4wkiWQGo5i2wQGH
         k9rr2CZtUIgN3KaiPjwTk7zTp5NygOsIaEQ1EFb5mx3+gKuqmgHAld3UvLfspO5w2UBU
         0wEws6E+I7NLyty9GQUMvkr+EYR4YxCvaapR9kiP22fboMZHDucpPqQZGddF3S5ESXXa
         FRGpkub/p3IV6hvO4SGW/8GuWxITQKzk8wCyYtf8oCwoHFCfQ0IXhuqIg0CDNOaP9bGx
         NIBLHM2XUehRRLBoOrabABEe3DG/v/0NrStO20QqB46GZeuw3G1rgWNVw7FUD9ujRWEs
         kr4g==
X-Gm-Message-State: AOAM531jMzxOhhTnE16vi9X29oJXl26NITmgxcQK01pciFCHn7ILa19U
        iPvZEaqFjukRexOH/fAytiE=
X-Google-Smtp-Source: ABdhPJytLP4Q67vqs3Kg8q3ChLI+iVz+M39ebWpml7bTG89AGDrCGsh10oITG3WA437PGB2/bYTmmQ==
X-Received: by 2002:a05:6000:1e0a:b0:20a:c33e:2834 with SMTP id bj10-20020a0560001e0a00b0020ac33e2834mr13993327wrb.552.1650883814687;
        Mon, 25 Apr 2022 03:50:14 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id k23-20020adfb357000000b0020ad7c36332sm4350095wrd.110.2022.04.25.03.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 03:50:14 -0700 (PDT)
Message-ID: <7f472706-6e25-ee97-13eb-6022ced4bcfb@gmail.com>
Date:   Mon, 25 Apr 2022 12:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/1] pwrap: mediatek: fix FSM timeout issue
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        eddie.huang@mediatek.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, fshao@chromium.org
Cc:     srv_heupstream@mediatek.com, hui.liu@mediatek.com,
        tinghan.shen@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220424025738.32271-1-zhiyong.tao@mediatek.com>
 <20220424025738.32271-2-zhiyong.tao@mediatek.com>
 <862706781d408669cd80e7e041d96a878178283c.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <862706781d408669cd80e7e041d96a878178283c.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/04/2022 04:05, Rex-BC Chen wrote:
> On Sun, 2022-04-24 at 10:57 +0800, Zhiyong Tao wrote:
>> From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
>>
>> Fix pwrap FSM timeout issue which leads the system crash on GFX VSRAM
>> power on.
>> Add a usleep delay to avoid busy read for the H/W status.
>> For avoiding the system behavior(ex. disable interrupt in
>> suspend/resume
>> flow, schedule block task)cause if (time_after()) be turn first,
>> we change it after sleep delay.

I'm not sure what you mean with this sentence. But it sound's like we want to 
paper about some issue. Can you please explain better?

Thanks,
Matthias

>> Fixes: 1f022d84bd19 ("soc: mediatek: Add PMIC wrapper for MT8135 and
>> MT8173 SoCs")
>>
>> Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
>> ---
> 
> Hello Zhiyong,
> 
> IMO, commit messages should be
> 
> Fix pwrap FSM timeout issue....
> ...we change it after sleep delay.
> 
> (=> one blank)
> Fixes: 1f022d84bd19 ("soc: mediatek: Add PMIC wrapper for MT8135 and
> MT8173 SoCs")
> (=> oneline)
> 
> Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
> 
>>   drivers/soc/mediatek/mtk-pmic-wrap.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c
>> b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> index 952bc554f443..ac7139a67e87 100644
>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/regmap.h>
>>   #include <linux/reset.h>
>> +#include <linux/delay.h>
> 
> Sorry, I do not notice this in previous version. It will proper order
> the header in alphabet.
> 
>   #include <linux/delay.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/reset.h>
> 
> BRs,
> Rex
>>   
>>   #define PWRAP_MT8135_BRIDGE_IORD_ARB_EN		0x4
>>   #define PWRAP_MT8135_BRIDGE_WACS3_EN		0x10
>> @@ -1197,10 +1198,13 @@ static int pwrap_wait_for_state(struct
>> pmic_wrapper *wrp,
>>   	timeout = jiffies + usecs_to_jiffies(10000);
>>   
>>   	do {
>> -		if (time_after(jiffies, timeout))
>> -			return fp(wrp) ? 0 : -ETIMEDOUT;
>>   		if (fp(wrp))
>>   			return 0;
>> +
>> +		usleep_range(10, 11);
>> +
>> +		if (time_after(jiffies, timeout))
>> +			return fp(wrp) ? 0 : -ETIMEDOUT;
>>   	} while (1);
>>   }
>>   
> 
