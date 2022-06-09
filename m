Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CA8544694
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiFIIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242484AbiFIIxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:53:00 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FEB1447A6;
        Thu,  9 Jun 2022 01:51:47 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id s12so38888307ejx.3;
        Thu, 09 Jun 2022 01:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=SXRFuRSOer0UTWqXklwZQzcqdPi/nxqTmlZiGWPV4ZU=;
        b=GYMHiulDbcN3cmGz4FKnX9FSbT75uZLGViASYny1A722tIGFEEL36aEleXraPN4uJr
         tNqPH3oGiJS0pA6vrdkyrKMIKWUoxQQqQ9vuEjh6EiNVwv5/xQz1GmBK+PkKSgP/h1x3
         g+W84kya6l0P9v4e6k3yNJZPNi7VMLzRuQwwkUf6bYOkZf1ZNoKZuyaXMbA2ev4KO1xm
         4Xrp57z9JHYR2wPjpEu5DGiw8Y+fu8ktnHFs4MBpqH31dxFOwB4Uj9nO2RJwAOtkLWOh
         XEyeU02HkBO0GWAhz7rjowdjOTmLulzZxrJz7F1yP6w1nofZzPb2T2AJNDQgana4Zs10
         KUpg==
X-Gm-Message-State: AOAM533jqAJRCcn1L1JNMe3KefB4NmWo4gfouYpYyNqqEgRZaHPUbbSk
        fnCDUiTs9XxQL5aE9G61MgWNFmK2z8li9g==
X-Google-Smtp-Source: ABdhPJy24B6wAVUvxzfMFJIXDhUQZl1sg3OvoUK9EjDNt5l4YigCWvxb8gag30hbyoDGFGvTAlku1g==
X-Received: by 2002:a17:906:4787:b0:711:d085:88a3 with SMTP id cw7-20020a170906478700b00711d08588a3mr17209001ejc.118.1654764706280;
        Thu, 09 Jun 2022 01:51:46 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id w2-20020a056402268200b0042ddd08d5f8sm14680854edd.2.2022.06.09.01.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 01:51:45 -0700 (PDT)
Message-ID: <926a95c0-3d0b-4dec-4894-3fd756d565a4@kernel.org>
Date:   Thu, 9 Jun 2022 10:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 16/36] tty/vt: consolemap: check put_user() in
 con_get_unimap()
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-16-jslaby@suse.cz>
 <5bf366cc45334bb9a9c3d186ef8d6933@AcuMS.aculab.com>
 <9780cd63-5cf3-7ee0-4866-160b9de0a3e8@kernel.org>
In-Reply-To: <9780cd63-5cf3-7ee0-4866-160b9de0a3e8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 06. 22, 10:11, Jiri Slaby wrote:
> On 08. 06. 22, 10:02, David Laight wrote:
>> From: Jiri Slaby
>>> Sent: 07 June 2022 11:49
>>>
>>> Only the return value of copy_to_user() is checked in con_get_unimap().
>>> Do the same for put_user() of the count too.
>>>
>>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>>> ---
>>>   drivers/tty/vt/consolemap.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
>>> index 831450f2bfd1..92b5dddb00d9 100644
>>> --- a/drivers/tty/vt/consolemap.c
>>> +++ b/drivers/tty/vt/consolemap.c
>>> @@ -813,7 +813,8 @@ int con_get_unimap(struct vc_data *vc, ushort ct, 
>>> ushort __user *uct,
>>>       console_unlock();
>>>       if (copy_to_user(list, unilist, min(ect, ct) * sizeof(*unilist)))
>>>           ret = -EFAULT;
>>> -    put_user(ect, uct);
>>> +    if (put_user(ect, uct))
>>> +        ret = -EFAULT;
>>>       kvfree(unilist);
>>>       return ret ? ret : (ect <= ct) ? 0 : -ENOMEM;
>>>   }
>>
>> How is the user expected to check the result of this code?
>>
>> AFAICT -ENOMEM is returned if either kmalloc() fails or
>> the user buffer is too short?
>> Looks pretty hard to detect which.
> 
> Agreed. The code is far from perfect. We might try to return ENOSPC and 
> watch what breaks.

brltty and kbd (see below) would break at least:
https://sources.debian.org/src/brltty/6.4-6/Drivers/Screen/Linux/screen.c/#L875

brltty apparently relies exactly on ENOMEM, increases buffer if that 
error is returned, and retries.

So I don't think we can change that ENOMEM to anything else.

>> I've not looked at the effect of all the patches, but setting
>> 'ret = -ENOMEM' and breaking the loop when the array is too
>> small would simplify things.

That would break kbd for example:
https://sources.debian.org/src/kbd/2.3.0-3/src/libkfont/kdmapop.c/?hl=154#L159

GIO_UNIMAP is called with zero count to actually find out the count...

So apart from the original patch which checks the return value of 
put_user, we cannot do anything else. (Except decoupling the "?:" to 
make it more readable.)

thanks,
-- 
js
suse labs
