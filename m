Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890345B2BEA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 04:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiIICCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 22:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIICCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:02:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F17E9BB7B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 19:02:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e5so293923pfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 19:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=foPxCX6VLJ9B+8nDtwn3UiII8jTDVry0sGuJiFsdc7w=;
        b=jbdPvMyHwvPar/AdBxG9kQhbdLM5EgNmI6zFroWElLZnIxopPf6hfVNCvskM0rB8Dr
         Bycmx9bHub+ICIPdGPVFtiSyqCyRwt/MIqU9JWZ/KDhwDeoF6J7vo2Et7Qrw2w7FoIZ3
         tieDQuMIPCoyZ+cvzcigLltoNfSVFT4VgzVHxDJli8Dp/0zuivR2Vb0Gei5VoyfjZn5q
         cpx5Cnrun24KI0BebIHtkXC7qPFUU3vLzJVJnFaen2VcIxqt7R3bmun5xMeHJqDplmZe
         Ma2zKBJFpzJbw+2GEtL2YP0LmQU7yddOSlxFEXPzOq/g7CC0RDnkgDHQw/TsDRiqOGcA
         +oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=foPxCX6VLJ9B+8nDtwn3UiII8jTDVry0sGuJiFsdc7w=;
        b=scZg2GR6wyM1CK/35mF1RJ5P3XA1pR8mLxAEY1LFj7BVjgiXti5AkCZ6s4EX3asZX4
         CONFuhFXwhkKjqWnsD6A2jKYDsuoBf2aD+QSh8orwl3xPQm7tU+deiBCzev2FKk23H/2
         zDq5eEaGhSCgujq8z6/aPlxdnNYiZQxHWzLPRRCuIB53HrxWuVV5ldElvpiH3m2YcS63
         LstJ2RDiy/RXzhAQdYCFg51cFh+Z0JAidigNu4a2ee4+U1T884PkHBHv9BjWOR16KhXy
         PViaoj89EHU5CJC3S4A1cPPPH5uqD4QzpkVS0gyhqJPGwSBuHbl4D0aTcxc9Dc6wFn0f
         sFWA==
X-Gm-Message-State: ACgBeo1Pzxv6QLGVdxPPF0UWwnGzlFoWbVZPYDtLDpzZJj4JiSwEH8t5
        28Z0Ah9azvPOaM6Sdv33h70=
X-Google-Smtp-Source: AA6agR6AamZKFaJCNBKOCxwSyKMe5Kbze5qsvU2r5M4OI2+9oVkyiJIK7It/78nP+ZWGTLcKYx7JRA==
X-Received: by 2002:a63:5a0b:0:b0:434:4748:4e7a with SMTP id o11-20020a635a0b000000b0043447484e7amr10211259pgb.561.1662688965993;
        Thu, 08 Sep 2022 19:02:45 -0700 (PDT)
Received: from [192.168.50.247] ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c20200b00177f3c40f9bsm200827pll.68.2022.09.08.19.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 19:02:45 -0700 (PDT)
Message-ID: <df1ae3ff-3d16-9e82-8234-82913e054444@gmail.com>
Date:   Fri, 9 Sep 2022 10:02:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] tty: vt: add a bounds checking in vt_do_kdgkb_ioctl()
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
        changlianzhi@uniontech.com, dmitry.torokhov@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20220908075403.27930-1-hbh25y@gmail.com>
 <6236da54-c651-9dc7-f5ce-824be96b3e9d@kernel.org>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <6236da54-c651-9dc7-f5ce-824be96b3e9d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/2022 16:10, Jiri Slaby wrote:
> On 08. 09. 22, 9:54, Hangyu Hua wrote:
>> As array_index_nospec's comments indicate，a bounds checking need to add
>> before calling array_index_nospec.
>>
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   drivers/tty/vt/keyboard.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
>> index be8313cdbac3..b9845455df79 100644
>> --- a/drivers/tty/vt/keyboard.c
>> +++ b/drivers/tty/vt/keyboard.c
>> @@ -2067,6 +2067,9 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry 
>> __user *user_kdgkb, int perm)
>>       if (get_user(kb_func, &user_kdgkb->kb_func))
>>           return -EFAULT;
>> +    if (kb_func >= MAX_NR_FUNC)
> 
> kb_func is unsigned char and MAX_NR_FUNC is 256. So this should be 
> eliminated by the compiler anyway.
> 
> But the check might be a good idea if we ever decide to support more 
> keys. But will/can we? I am not so sure, so adding it right now is kind 
> of superfluous. In any way we'd need to introduce a completely different 
> iterface/ioctls.

If you say so, I think greg should be right. We don't need any bounds 
checking here. It may be a good idea to delete redundant
array_index_nospec. Do i need to make a new patch?

> 
>> +        return -EFAULT;
> 
> EINVAL would be more appropriate, IMO.
> 
>> +
>>       kb_func = array_index_nospec(kb_func, MAX_NR_FUNC);
>>       switch (cmd) {
> 
> thanks,

Thanks,
Hangyu
