Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7023E52991C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 07:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbiEQFjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 01:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiEQFjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 01:39:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC5A40A35;
        Mon, 16 May 2022 22:39:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c14so15972335pfn.2;
        Mon, 16 May 2022 22:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TmeDSLlFerDAJIQrZiYorWIjVB/zbv81hvFgp+YmBFI=;
        b=SMrcwrT8Q+x18LHAKaAhAW8yMvEo1LFBB3bXjL94YXGieIa7M4DB6ZUh3a/7LESowj
         KwA0QHRj5nw+2RJHQHHSZhZLs7Fqq45OMjOBmeVPkHdxPQdjb4Q29RC9PKWntr9bJgce
         p32Qy0CxgrIwdMi5X36DPwjyyuYJMPuBxQWLoxewHG2CoJSsTkKwqbY19CW8S+yjqIEU
         CS51T4k1EYAcy1bs7+tObnPJ1bFiU1BDD12fzyFJp95MQya8cMOzkItBWShBlrO9dTJF
         9Sa573tl6layKNsbcTYLqcDHOYX3TA0J5Fl4XK5MhFtgBrw5b1AMLZE5cPEToAp5znGy
         Fzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TmeDSLlFerDAJIQrZiYorWIjVB/zbv81hvFgp+YmBFI=;
        b=UsxdVxr1BeL1g062ItQ35BG4UebDQNR8RSpQtqYZQuoICEyyKKgRUI7GphGM+aY9Vw
         YEF3V2PJRxbApXAzl1OdgE+T/JzjB6qo0MD/MtOMud7Q/dwJapeXkAzZ1iCZcJ3KjyyH
         rfHMmA3s6xCn4w5iabKpHLJ6ybeJIHzAqWkjdns+TGQ50W/yHhTxl1Uk1ViDIRG6z7RK
         noiiULE6iHAwpDm+4o4l1it+XPDikd7A8nXGVWngVd1eTr7t9rMWVT5rF9elmy/g9x3W
         9M8ahHQyrOgmJ6yyDBn1MtMUX6E7+qJiq1R744In7I/gOolSgRk4WRnfm/e8z/WBEQDe
         /u4Q==
X-Gm-Message-State: AOAM5319TUqzgtVvuXlpL/iePA4WLZLWja/PfzlFG3mYcj1kcGzmzSv2
        azMdA4T5UuKaRELVpEPBpR1YAozkY3h8WgbU
X-Google-Smtp-Source: ABdhPJwY0bnlcNW0UmxMip7LdXZ9T1tqSz1ZXaZc49zdH968WiBDfcGZdrttIdwlhq+ZPhZDt2W6Ww==
X-Received: by 2002:a65:6805:0:b0:3c1:bb28:6bd4 with SMTP id l5-20020a656805000000b003c1bb286bd4mr18423867pgt.585.1652765980469;
        Mon, 16 May 2022 22:39:40 -0700 (PDT)
Received: from [172.16.10.243] ([219.142.146.170])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b0015e8d4eb22bsm8444341plh.117.2022.05.16.22.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 22:39:39 -0700 (PDT)
Message-ID: <bf778cef-d09a-5fcd-8388-d77690ac87c6@gmail.com>
Date:   Tue, 17 May 2022 13:39:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] Input: sparcspkr: Fix refcount leak in bbc_beep_probe
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220516081018.42728-1-linmq006@gmail.com>
 <YoLLTBALPU1O8VI5@google.com>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <YoLLTBALPU1O8VI5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dmitry

On 2022/5/17 6:08, Dmitry Torokhov wrote:
> Hi 
> On Mon, May 16, 2022 at 12:10:16PM +0400, Miaoqian Lin wrote:
>> of_find_node_by_path() calls of_find_node_opts_by_path(),
>> which returns a node pointer with refcount
>> incremented, we should use of_node_put() on it when done.
>> Add missing of_node_put() to avoid refcount leak.
>>
>> Fixes: 9c1a5077fdca ("input: Rewrite sparcspkr device probing.")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
> Thank you for the patch.
>
>>  drivers/input/misc/sparcspkr.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
>> index fe43e5557ed7..6a86900aa1fb 100644
>> --- a/drivers/input/misc/sparcspkr.c
>> +++ b/drivers/input/misc/sparcspkr.c
>> @@ -206,11 +206,11 @@ static int bbc_beep_probe(struct platform_device *op)
>>  	info = &state->u.bbc;
>>  	info->clock_freq = of_getintprop_default(dp, "clock-frequency", 0);
>>  	if (!info->clock_freq)
>> -		goto out_free;
>> +		goto out_put;
>>  
>>  	info->regs = of_ioremap(&op->resource[0], 0, 6, "bbc beep");
>>  	if (!info->regs)
>> -		goto out_free;
>> +		goto out_put;
>>  
>>  	platform_set_drvdata(op, state);
>>  
>> @@ -218,11 +218,14 @@ static int bbc_beep_probe(struct platform_device *op)
>>  	if (err)
>>  		goto out_clear_drvdata;
>>  
>> +	of_node_put(dp);
>> +
> We do not really need to keep node pointer for that long, how about the
> version of your patch below?
Looks good to me.
> Thanks.
>
