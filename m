Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54564B02B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiBJB6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:58:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiBJB5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:57:37 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FB92AAB9;
        Wed,  9 Feb 2022 17:42:18 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i186so7640840pfe.0;
        Wed, 09 Feb 2022 17:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fznXHsB7fq3yx1Wr3eNck2JRmWHFRDu7wO8b3fegyhQ=;
        b=K7vtY4fcgIqJ4HJSiqq2au6PruCtlk060uUEezTZDkvdc6kiNQkeRI6Vj+ufMYS0pL
         Hi0m0j8SgtDXsJ4nqR2pQammy4kqnppm5RL5TJAT6gUTjDI1MeTm9k6fbqBwK6aCT9mo
         A/tDrvas/wS8UWIqYZZiE8bBrBToZxZGcmVeM+rVxcEMOF738UiM1V0xRwWQC4z1271n
         yNQOX2SlB2E7nHTegFa7BY7pA9zx/c1F1W21haZ9tnXwhGLbbQRHuXr3v7gNR+CyaRat
         IRx/cVyUnQvH0opQh1z3jXuRmIXVNAWNpUo/zkWexFlwabFOVzo6lo4DZPQkxYd2ljUW
         xgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fznXHsB7fq3yx1Wr3eNck2JRmWHFRDu7wO8b3fegyhQ=;
        b=wd/kDrxt2CdMl3VFOTkE1E0k1JdBY2W85wwuiqj6uOXmGKeLNtC7eP5C/iC2961Eqv
         aYHOz6jz1G9b5c72ZDuNo1VFH84IMF3K70vYWbsdzmVBKG4PO7G5eWisYdbdR3a8PGjB
         OJMcwipfLIGblroOSlWlq0AZ+/FJsJUo427XDJG4Ukn5p2v6iqs4dUDB2h0GFW5UQTtY
         iKJcju9oRC++3o+NbpK3dNVOSZAdbkm9HH9i8q9Ihcz4qByOOYI9+htkbqaWxi/TO1TM
         KVoU9tNdUjdZR9LT/l31wbIb4lKL9hVycTZizD7JOwT5V4Z3m8L0TpWjO1LAS9SOA+OU
         jy7Q==
X-Gm-Message-State: AOAM532Jr8Yipk44O+mncSVY5HGGijgX2mhnP5FJDzqOss7V+z7zKS1J
        XJJB/4WgaVpETNDH9QT4cXRx0b2HiNM=
X-Google-Smtp-Source: ABdhPJyJQcYxSpteE/xAVBfy/rxhoRCgxRtEmG3VtwpT48g1U4W5N6+0o3Iwz6Zbne1VLnM95s1W2g==
X-Received: by 2002:a05:6214:27ce:: with SMTP id ge14mr3327269qvb.24.1644450731816;
        Wed, 09 Feb 2022 15:52:11 -0800 (PST)
Received: from [192.168.1.201] (pool-108-18-137-133.washdc.fios.verizon.net. [108.18.137.133])
        by smtp.googlemail.com with ESMTPSA id f5sm9142922qkp.97.2022.02.09.15.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 15:52:11 -0800 (PST)
Subject: Re: [PATCH] pinctrl: k210: Fix bias-pull-up
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220209182822.640905-1-seanga2@gmail.com>
 <fb3e9786-87e9-6346-cf84-2617adfa5b8d@opensource.wdc.com>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <4911f3a7-fe4b-8eb0-f504-667ee5ea1294@gmail.com>
Date:   Wed, 9 Feb 2022 18:52:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <fb3e9786-87e9-6346-cf84-2617adfa5b8d@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 6:34 PM, Damien Le Moal wrote:
> On 2/10/22 03:28, Sean Anderson wrote:
>> Using bias-pull-up would actually cause the pin to have its pull-down
>> enabled. Fix this.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>>   drivers/pinctrl/pinctrl-k210.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
>> index 49e32684dbb2..1ad61b32ec88 100644
>> --- a/drivers/pinctrl/pinctrl-k210.c
>> +++ b/drivers/pinctrl/pinctrl-k210.c
>> @@ -527,7 +527,7 @@ static int k210_pinconf_set_param(struct pinctrl_dev *pctldev,
>>   	case PIN_CONFIG_BIAS_PULL_UP:
>>   		if (!arg)
>>   			return -EINVAL;
>> -		val |= K210_PC_PD;
>> +		val |= K210_PC_PU;
>>   		break;
>>   	case PIN_CONFIG_DRIVE_STRENGTH:
>>   		arg *= 1000;
> 
> Ooops... My bad :)

(This is in U-Boot as well, so it looks like it's my bad)
