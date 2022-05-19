Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADD752DF0E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbiESVTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiESVTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B79B1ED726
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652995144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+qJ8pJJs0G5HYhGLiS4AE7niMtKAcA/2FBv3kqZsAA=;
        b=G0w47FprosVRL05YA6hPz8n3GcAkgyooG5T8Ph8WILnQajn0MBDV6BVD7ywjyNNbhS9icQ
        xLo3GLmJc6nOUtM6dqlnTWCAFxh61zXKfrUehJ2Lmy87qFQN6NcrTo2AFfbyWXM4RKgPlL
        5DHAkL9Jl3eess0zywest3PO+kW+4yY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-QHPMfYdiN5yS9aTcb5yStA-1; Thu, 19 May 2022 17:19:03 -0400
X-MC-Unique: QHPMfYdiN5yS9aTcb5yStA-1
Received: by mail-qk1-f200.google.com with SMTP id g12-20020ae9e10c000000b006a32d9e905bso2887370qkm.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n+qJ8pJJs0G5HYhGLiS4AE7niMtKAcA/2FBv3kqZsAA=;
        b=w2iT03f7fPAZDyrHC5JSAWl1lGrc8CxPUXSWWeolfFs5gXtvWpCJinomV6ewZm9esV
         1hrLfMVyMp/F7Uy+kR4/EPcCQBrH7XyjbIm7F1K0ZxwIxbNxpWfZRhS1h5A6pZxDJOnh
         xMkiwTmqThpjK2eT9IIPcH0k40WrhmmmqkDp5MnSq2VLfy8uRwq6Ky44BrvQOVzbMGIb
         icAli0I3f7fQsFTLw4uTBhStNNQCedB5mmR8IW60Eqx4AnzNAqLweJLxEaM3zOpPxdKU
         BpxTMVIiO5QCE84iadt5XcLa0UiNr0KcOaKdQ8nZr4Ok+Bma6I2aF1AGas2FG4eem/Rx
         iOvg==
X-Gm-Message-State: AOAM532H6bQwKTRGX2yfOUdklppxK6BcYXKj0EyVN/I0i21nu9Ch0VXo
        sw4/UNsD1KmcssQweKYBqyc2Ulr+3/uNVz/wjJaJ2fuTnAW344yc0lKy7CI3gadVQ0iqz5jywkI
        2Fcj2DZDlk8YGN0pF3BcQCY+T
X-Received: by 2002:a05:6214:2389:b0:435:ba04:8f18 with SMTP id fw9-20020a056214238900b00435ba048f18mr5786329qvb.4.1652995143134;
        Thu, 19 May 2022 14:19:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX0Fldd8vk5WoAZtJCJ9/fV9GcJ3gIYbqeL2DsMTBdM1sx6/gnk91p1rko9Wjj8dU/g2cYeg==
X-Received: by 2002:a05:6214:2389:b0:435:ba04:8f18 with SMTP id fw9-20020a056214238900b00435ba048f18mr5786315qvb.4.1652995142893;
        Thu, 19 May 2022 14:19:02 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id b126-20020a37b284000000b0069fc13ce1fcsm1911154qkf.45.2022.05.19.14.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 14:19:02 -0700 (PDT)
Subject: Re: [PATCH] misc: rtsx: Set setting_reg2 before use.
To:     Nathan Chancellor <nathan@kernel.org>,
        Ricky WU <ricky_wu@realtek.com>, miquel.raynal@bootlin.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <20220516130047.3887590-1-trix@redhat.com>
 <YoJ0I/XPoj1B/+mm@dev-arch.thelio-3990X>
 <d34498ad-0230-7c73-8f1f-9ca59fbf930f@redhat.com>
 <CAAd53p57APcectWW-NN_=HE6JkTQRk717cWNZ5iJcP+MtEYjog@mail.gmail.com>
 <bab0c4250147420a842f3e966a8264a6@realtek.com>
 <YoavUdiAJXPqsU7Q@dev-arch.thelio-3990X>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6e3f182e-73ac-9c1d-9fb1-1fb360b1a6cd@redhat.com>
Date:   Thu, 19 May 2022 14:18:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YoavUdiAJXPqsU7Q@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/22 1:57 PM, Nathan Chancellor wrote:
> On Tue, May 17, 2022 at 08:10:17AM +0000, Ricky WU wrote:
>>> -----Original Message-----
>>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> Sent: Tuesday, May 17, 2022 9:53 AM
>>> To: Tom Rix <trix@redhat.com>
>>> Cc: Nathan Chancellor <nathan@kernel.org>; arnd@arndb.de;
>>> gregkh@linuxfoundation.org; ndesaulniers@google.com; Ricky WU
>>> <ricky_wu@realtek.com>; linux-kernel@vger.kernel.org; llvm@lists.linux.dev
>>> Subject: Re: [PATCH] misc: rtsx: Set setting_reg2 before use.
>>>
>>> On Tue, May 17, 2022 at 1:06 AM Tom Rix <trix@redhat.com> wrote:
>>>>
>>>> On 5/16/22 8:56 AM, Nathan Chancellor wrote:
>>>>> On Mon, May 16, 2022 at 09:00:47AM -0400, Tom Rix wrote:
>>>>>> The clang build fails with
>>>>>> rts5261.c:406:13: error: variable 'setting_reg2' is used uninitialized
>>> whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>>>>>>           } else if (efuse_valid == 0) {
>>>>>>                      ^~~~~~~~~~~~~~~~
>>>>>>
>>>>>> setting_reg2 is set in this block
>>>>>>     if (efuse_valid == 2 || efuse_valid == 3) { ..
>>>>>>     } else if (efuse_valid == 0) {
>>>>>>       // default
>>>>>> ..
>>>>>>     }
>>>>>> But efuse_valid can also have a value of 1.
>>>>>> Change the 'else if' to 'else' to make the second block the default.
>>>>>>
>>>>>> Fixes: b1c5f3085149 ("misc: rtsx: add rts5261 efuse function")
>>>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>>> I am not sure if this fix is correct from a functional standpoint (i.e.
>>>>> is treating efuse_valid == 1 the same as efuse_valid == 0 correct?)
>>>>> but it is better than not handling this value altogether. For what
>>>>> it's
>>>>> worth:
>>>> I looked at how the code used to work, this seemed better than
>>>> initializing to NULL.
>>> Or maybe use a single if block?
>>>
>>> u16 setting_reg1 =PCR_SETTING_REG1 , setting_reg2 =
>>> PCR_SETTING_REG2; ...
>>> if ((efuse_valid == 2 || efuse_valid == 3) && (valid != 3) {
>>>      setting_reg1 = PCR_SETTING_REG4;
>>>      setting_reg2 = PCR_SETTING_REG5;
>>> }
>>>
>>> Kai-Heng
>>>
>>>>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>>>>>
>>>>> As a side note, it is unfortunate that this change made it into
>>>>> -next when there was an outstanding report about this warning:
>>>>   From the clang side, this is a build break and my static analysis
>>>> infra goes down.
>>>>
>>>> These build breaks seem to happening every week, is there a precommit
>>>> clang gating test that could be done for -next ?
>>>>
>>>> Tom
>>>>
>>>>> https://lore.kernel.org/202205100220.WyAyhKap-lkp@intel.com/
>>>>>
>>>>>> ---
>>>>>>    drivers/misc/cardreader/rts5261.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/misc/cardreader/rts5261.c
>>>>>> b/drivers/misc/cardreader/rts5261.c
>>>>>> index 749cc5a46d13..f22634b14dc8 100644
>>>>>> --- a/drivers/misc/cardreader/rts5261.c
>>>>>> +++ b/drivers/misc/cardreader/rts5261.c
>>>>>> @@ -403,7 +403,7 @@ static void rts5261_init_from_hw(struct rtsx_pcr
>>> *pcr)
>>>>>>                       setting_reg1 = PCR_SETTING_REG4;
>>>>>>                       setting_reg2 = PCR_SETTING_REG5;
>>>>>>               }
>>>>>> -    } else if (efuse_valid == 0) {
>>>>>> +    } else {
>>>>>>               // default
>>>>>>               setting_reg1 = PCR_SETTING_REG1;
>>>>>>               setting_reg2 = PCR_SETTING_REG2;
>> Sorry for the trouble
>> here can be changed to
>> ...
>> } else if (efuse_valid == 0) {
>> 		// default
>> 		setting_reg1 = PCR_SETTING_REG1;
>> 		setting_reg2 = PCR_SETTING_REG2;
>> } else {
>>   return;
>> }
>> Because other values are invalid
> Tom, were you going to send a v2 of this?

No.

Miquèl has the best fix.

https://lore.kernel.org/lkml/20220518170920.4db16990@xps-13/

Tom


>
> Cheers,
> Nathan
>

