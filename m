Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C86528B93
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbiEPRGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344165AbiEPRGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB42764F4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652720773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ejIgoWmRxczoYnPHf/4zfggdO1eNy2ArBNlJdHBm7s=;
        b=JqXqeYUIPxzu2G5Io088xXI9Memdd73pI6RsbZxT/vNvA20p0lZYR8dRwf3oObt6g94rq8
        v6JIcLvzgiqWwIMc+femosxXl2dg7ugPd5gDRfSbYkTiff8siAXKXSBauL27Th/+rq9Xwy
        kQw+Qg58rrv1tkJFVuaHD/4qe0irCs8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-DA2UDkNHOZuG7wMW2PMSYQ-1; Mon, 16 May 2022 13:06:12 -0400
X-MC-Unique: DA2UDkNHOZuG7wMW2PMSYQ-1
Received: by mail-qv1-f71.google.com with SMTP id o99-20020a0c906c000000b00456332167ffso8191626qvo.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0ejIgoWmRxczoYnPHf/4zfggdO1eNy2ArBNlJdHBm7s=;
        b=MEQAkqnfApNezGubIfZAqW7NAngQ590hpNJctxgIDt9GLlmle769yVikkn1GwWHUAJ
         EJMo7dWnAB/KrqMKXA+pGi4TpQYqsDvqViivfNrYHmWoL1gScFDD0WUif2oYs0d5TWP4
         ZQyAo51Q++8Uj2axqHGOYsReQ7328cPS+Te54tTLY33UPglUOX3cBpc6m2sMQz+mY5HN
         TuKntt7kmvDr9Fcs/HKdDp/OQr7/x51aOSoonvuw3Qx1wlNpF8BuPccqURrWuGjSxUQ3
         cPzfedPtgL6K8mcABtIaDnKYvBxMCseJXb8c/S7SAgr23inF4GZngWTe5PYH/AVzFrWV
         FkGg==
X-Gm-Message-State: AOAM530uA7tBBQBlQNIZ1EQmH3SuptB2wugWi15dCGaWfW4a00lrPqE/
        7NkmUd87T0lCTDg+7ieNFTy+4uylSjOmmVi7Flwg8OCScU0zJktIi5LjKk6PqpJlx+iBYdLnN7K
        JYrpNbcJ2kawBFJevrJ3XHp6N
X-Received: by 2002:ad4:414a:0:b0:461:ce93:f10c with SMTP id z10-20020ad4414a000000b00461ce93f10cmr5008222qvp.73.1652720770944;
        Mon, 16 May 2022 10:06:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2m47ZgyrUeZFqTNUFcAJdSpDA0fm/ABlQgiRXf+xheTHQc5HQAFHPXDg1aLZY0I0R0QohcA==
X-Received: by 2002:ad4:414a:0:b0:461:ce93:f10c with SMTP id z10-20020ad4414a000000b00461ce93f10cmr5008110qvp.73.1652720769745;
        Mon, 16 May 2022 10:06:09 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m6-20020ac86886000000b002f39b99f6bcsm5973279qtq.86.2022.05.16.10.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 10:06:09 -0700 (PDT)
Subject: Re: [PATCH] misc: rtsx: Set setting_reg2 before use.
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, ndesaulniers@google.com,
        ricky_wu@realtek.com, kai.heng.feng@canonical.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220516130047.3887590-1-trix@redhat.com>
 <YoJ0I/XPoj1B/+mm@dev-arch.thelio-3990X>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d34498ad-0230-7c73-8f1f-9ca59fbf930f@redhat.com>
Date:   Mon, 16 May 2022 10:06:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YoJ0I/XPoj1B/+mm@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/16/22 8:56 AM, Nathan Chancellor wrote:
> On Mon, May 16, 2022 at 09:00:47AM -0400, Tom Rix wrote:
>> The clang build fails with
>> rts5261.c:406:13: error: variable 'setting_reg2' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>>          } else if (efuse_valid == 0) {
>>                     ^~~~~~~~~~~~~~~~
>>
>> setting_reg2 is set in this block
>>    if (efuse_valid == 2 || efuse_valid == 3) {
>> ..
>>    } else if (efuse_valid == 0) {
>>      // default
>> ..
>>    }
>> But efuse_valid can also have a value of 1.
>> Change the 'else if' to 'else' to make the second block the default.
>>
>> Fixes: b1c5f3085149 ("misc: rtsx: add rts5261 efuse function")
>> Signed-off-by: Tom Rix <trix@redhat.com>
> I am not sure if this fix is correct from a functional standpoint (i.e.
> is treating efuse_valid == 1 the same as efuse_valid == 0 correct?) but
> it is better than not handling this value altogether. For what it's
> worth:

I looked at how the code used to work, this seemed better than 
initializing to NULL.

>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> As a side note, it is unfortunate that this change made it into -next
> when there was an outstanding report about this warning:

 From the clang side, this is a build break and my static analysis infra 
goes down.

These build breaks seem to happening every week, is there a precommit 
clang gating test that could be done for -next ?

Tom

>
> https://lore.kernel.org/202205100220.WyAyhKap-lkp@intel.com/
>
>> ---
>>   drivers/misc/cardreader/rts5261.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
>> index 749cc5a46d13..f22634b14dc8 100644
>> --- a/drivers/misc/cardreader/rts5261.c
>> +++ b/drivers/misc/cardreader/rts5261.c
>> @@ -403,7 +403,7 @@ static void rts5261_init_from_hw(struct rtsx_pcr *pcr)
>>   			setting_reg1 = PCR_SETTING_REG4;
>>   			setting_reg2 = PCR_SETTING_REG5;
>>   		}
>> -	} else if (efuse_valid == 0) {
>> +	} else {
>>   		// default
>>   		setting_reg1 = PCR_SETTING_REG1;
>>   		setting_reg2 = PCR_SETTING_REG2;
>> -- 
>> 2.27.0
>>
> Cheers,
> Nathan
>

