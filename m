Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F9A4923E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiARKk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiARKk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:40:26 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74704C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 02:40:26 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id i7-20020a17090a4b8700b001b4d486d9c2so1293614pjh.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 02:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=69DwjfMjzmf/AfXmnX+bsAUeKxZaOoNzZ3bIdAfPGMI=;
        b=opIuoYaqtSYw6OdTB0wfs5HX5bdoHOzR03F+uG4vjYBlMKq9aChQ9AQGL7RjUBdCfG
         NKELFOfdnR790bqNjuyr8kS+9y0ZR5TGIb5EMFwNwLTHH/0TDXj9sV2gg6+Kz9ayVRF7
         E6Ei+8HRpwKU/OasIW039tRjOamn/B3C9Qv2pCyLclNkDZYS+u3ZS9nOAawRN60pedZP
         UAQ8U1VAYrgPybdyr96mqAwT3KI1IUS1YgZ57KeOohH3PLjmJHitI/GYzIbzXQwt8L8u
         2upSu4nUyBZEDfg2uqsp+e4HzcTr5OHf2GEeuMx4lO2IADbKzh9aIp5k/7859xS/0yox
         GWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=69DwjfMjzmf/AfXmnX+bsAUeKxZaOoNzZ3bIdAfPGMI=;
        b=w+88164k7p9Txj5oGLFjv1oW727z1Kjfgiq0J6s40CgrMAX81qXqfQPqxK6RmHB2uh
         amrMH9pEVdjzVpFRX6Qwzqa6jhY+YOvtqpMWEJpVBn8nMKj2vWUrQHJ42MvRELgKJqgx
         T0UCVFgqcqPYIRZZlbM+C48IvMFY08gIYK47/vaeg67jBIL7Q2CUCpmjkppIlubQC+7g
         QfdrcsG6eJLqyjXtbKgZvVr5v7dNHBauDG3Z9/Ganl/PLFKy/45LhTaRzDloWGXWvHgH
         kMxWLVv/fyeMWK+ynH16/Yt83PS09nnRASqyZYhA+W47123op8YwWvJwoyXM1mAa12kH
         WkFw==
X-Gm-Message-State: AOAM5323fL6yp1ZZcU8zAlcur18EvyqK0WRLFB/3dP6yfETbwt4YFTRw
        /eyLF/XxsJ/LTLXxLLBILVjp5bES+gc1xg==
X-Google-Smtp-Source: ABdhPJxGAs9HhjxAbkmFEDtmQ5xCX5NN3VHLZOT59Cfx5kBMc/aXOIHFRTt7VrUl3yp+Iw9X7pdOCQ==
X-Received: by 2002:a17:902:6841:b0:149:6791:5a4f with SMTP id f1-20020a170902684100b0014967915a4fmr26641604pln.123.1642502425705;
        Tue, 18 Jan 2022 02:40:25 -0800 (PST)
Received: from [0.0.0.0] ([209.97.166.32])
        by smtp.gmail.com with ESMTPSA id m18sm5011395pfk.180.2022.01.18.02.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 02:40:25 -0800 (PST)
Subject: Re: [PATCH v2 RESEND] m68k/kernel: array out of bound access in
 process_uboot_commandline
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <9775e266-5fee-b0e9-7fa3-b602ec4b7796 () gmail ! com>
 <a7483172-09dc-21ad-d674-25b7015156fd@linux-m68k.org>
From:   Hangyu Hua <hbh25y@gmail.com>
Message-ID: <c9238f43-406f-3a75-c469-7d8ad30f88f3@gmail.com>
Date:   Tue, 18 Jan 2022 18:40:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a7483172-09dc-21ad-d674-25b7015156fd@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg


On 2022/1/18 下午4:26, Greg Ungerer wrote:
> Hi Hangyu,
> 
> On 18/1/22 12:18 pm, Hangyu Hua wrote:
>> Hi Greg,
>>
>> On 2022/1/17 下午12:03, Greg Ungerer wrote:
>>> Hi Hangyu,
>>>
>>> On 13/1/22 11:58 am, Hangyu Hua wrote:
>>>> When the size of commandp >= size, array out of bound write occurs
>>>> because
>>>> len == 0.
>>>>
>>>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>>>> ---
>>>>    arch/m68k/kernel/uboot.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
>>>> index 928dbd33fc4a..63eaf3c3ddcd 100644
>>>> --- a/arch/m68k/kernel/uboot.c
>>>> +++ b/arch/m68k/kernel/uboot.c
>>>> @@ -101,5 +101,6 @@ __init void process_uboot_commandline(char
>>>> *commandp, int size)
>>>>        }
>>>>        parse_uboot_commandline(commandp, len);
>>>> -    commandp[len - 1] = 0;
>>>> +    if (len > 0)
>>>> +        commandp[len - 1] = 0;
>>>>    }
>>>>
>>>
>>> I am not convinced this is wrong for the reason you think it is.
>>> Looking at the code in its entirety:
>>>
>>> __init void process_uboot_commandline(char *commandp, int size)
>>> {
>>>           int len, n;
>>>
>>>           n = strnlen(commandp, size);
>>>           commandp += n;
>>>           len = size - n;
>>>           if (len) {
>>>                   /* Add the whitespace separator */
>>>                   *commandp++ = ' ';
>>>                   len--;
>>>           }
>>>
>>>           parse_uboot_commandline(commandp, len);
>>>           commandp[len - 1] = 0;
>>> }
>>>
>>>
>>> "commandp" is moved based on the return of the strnlen(). So in the
>>> case of commandp actually being full of valid characters (so n == size,
>>> and thus len == 0) the commandp technically points outside of its
>>> real size at that point. But "command[[len - 1]" would actually be
>>> pointing to the last char in the original commandp array (so the 
>>> original
>>> commandp[size - 1]). Well at least if you are happy with the use of
>>> negative array indexes.
>>>
>>
>> You mean this is a friendly out of bound beacause "command[[len - 1]"
>> pointing to the last char in the original commandp array. I used to
>> think command[[len - 1] = 0 may be a zero-terminated for command. You
>> can see my discussion with Andreas Schwab and my patch v1 in
>>
>> https://lore.kernel.org/all/CAOo-nLJG71QqqD0-cJDyH0rY2VTx1eO9nHVQ5MCe8J0iiME_vw@mail.gmail.com/ 
>>
>>
>> But this still be a out of bound write because "commandp" is a macro
>> definition with a fixed size.
> 
> No, "commandp" is not a macro, it is a parameter to this function, is a 
> char pointer.
> It points into a char array of size "size" (which will be non-zero).
> It is modified during execution of this function.
> I don't see an out-of-bound write here.
> 

I am sorry i make a mistake in here. What i want to express is that 
setup_arch call parse_uboot_commandline with m68k_command_line or 
command_line.The definitions of m68k_command_line and command_line
are:

char __initdata command_line[COMMAND_LINE_SIZE];
static char m68k_command_line[CL_SIZE] __initdata;

And I undertand what you mean. You are right. There isn't a out-of-bound.

> 
>>> Clearly this could be structured better. There is no point in calling
>>> parse_uboot_commandline() if len == 0, or even if len == 1, since you
>>> cannot add anymore to the command line, it is full.
>>>
>> I think it is no point too. But the caller (setup_arch()) don't check
>> the size of "commandp" before call parse_uboot_commandline(). Instead we
>> do this in parse_uboot_commandline(). So it may be better to move these
>> checks to the caller ?
> 
> No, I don't think so. The caller doesn't care if it is already full.
> And the common case is that process_uboot_commandline() is empty
> when CONFIG_UBOOT is not enabled.
> 
> Regards
> Greg
> 
> 

Thanks
