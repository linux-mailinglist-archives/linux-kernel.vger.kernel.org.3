Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B88F5429F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiFHIxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiFHIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:52:49 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014262A3065;
        Wed,  8 Jun 2022 01:11:14 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id s12so32648938ejx.3;
        Wed, 08 Jun 2022 01:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a3rjwlyE45AJ6OeyU142mWoMW1Ef/bHAk4SW+m+tkuU=;
        b=uJF8/KjatTx1L7E0DgoF83z7jOw/InD7/RMc8BQBGMHxdobyio2V5CnYfmbGCbTGu0
         A1ijMJ7Vf2Qa1NhbMzuo31i6tXMerUB/UJqL0Qz5CrQhEuwtH0Et8MiiIyp5ikOoDFdx
         3PTLcG4RcOlqbcJb2tK1DN0giZu8k8dqDe9cQqm7eHL6UuoJbhUExQa+01EAPCUrQQ43
         mYAnubqe/TFUPnGl/zDKvWQqDDyft9Es1DUozLqKw7ifDZrxoiBHjGnfLMS+LtcvSZoL
         OXadNdcFtTmifKAkS3swKH9R+4n8xwtT/1NJrbBtnAd18Yz0lhOw8XNXLsKbjko2q11q
         wSsQ==
X-Gm-Message-State: AOAM5311sAX5zxJCRnOhoM60BFyicK7lHdT9dC9Q1iJAfq2x5X06GSF/
        ipYQQtMPutFaz09T9PleAG/M6jNBEpKEQg==
X-Google-Smtp-Source: ABdhPJwWdIWaWqRdFSCPq4aE30zMINGszIDk07yzO7IRrNUsDH0PcZ4Mhsnzl6CPDu1hsB/7AJV17A==
X-Received: by 2002:a17:907:968a:b0:711:f093:3a84 with SMTP id hd10-20020a170907968a00b00711f0933a84mr3359465ejc.603.1654675873511;
        Wed, 08 Jun 2022 01:11:13 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id p19-20020a056402155300b0042617ba638esm11907960edx.24.2022.06.08.01.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:11:13 -0700 (PDT)
Message-ID: <9780cd63-5cf3-7ee0-4866-160b9de0a3e8@kernel.org>
Date:   Wed, 8 Jun 2022 10:11:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 16/36] tty/vt: consolemap: check put_user() in
 con_get_unimap()
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-16-jslaby@suse.cz>
 <5bf366cc45334bb9a9c3d186ef8d6933@AcuMS.aculab.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <5bf366cc45334bb9a9c3d186ef8d6933@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 06. 22, 10:02, David Laight wrote:
> From: Jiri Slaby
>> Sent: 07 June 2022 11:49
>>
>> Only the return value of copy_to_user() is checked in con_get_unimap().
>> Do the same for put_user() of the count too.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>   drivers/tty/vt/consolemap.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
>> index 831450f2bfd1..92b5dddb00d9 100644
>> --- a/drivers/tty/vt/consolemap.c
>> +++ b/drivers/tty/vt/consolemap.c
>> @@ -813,7 +813,8 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
>>   	console_unlock();
>>   	if (copy_to_user(list, unilist, min(ect, ct) * sizeof(*unilist)))
>>   		ret = -EFAULT;
>> -	put_user(ect, uct);
>> +	if (put_user(ect, uct))
>> +		ret = -EFAULT;
>>   	kvfree(unilist);
>>   	return ret ? ret : (ect <= ct) ? 0 : -ENOMEM;
>>   }
> 
> How is the user expected to check the result of this code?
> 
> AFAICT -ENOMEM is returned if either kmalloc() fails or
> the user buffer is too short?
> Looks pretty hard to detect which.

Agreed. The code is far from perfect. We might try to return ENOSPC and 
watch what breaks. (And decouple the double "?:" operator as it makes 
things only worse.)

> I've not looked at the effect of all the patches, but setting
> 'ret = -ENOMEM' and breaking the loop when the array is too
> small would simplify things.

Note that the patches try NOT to change the behavior in any way. If they 
do, it's likely a bug. They are first front cleanup. Definitely more to 
come. Either from me, or others -- patches welcome ;).

thanks,
-- 
js
suse labs
