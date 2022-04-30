Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BE7515E64
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382865AbiD3Ow5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382873AbiD3Owz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03D3534BB8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651330165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOdz1ctG8DsfhQ/t3Bd0GmW9//GLUrDpBS4J4wmHKpE=;
        b=bbzTG6W3r5qQ5Z8OYrNcOHjjEiI434/yh4C3gJlAYiEGNqm4KQPjvSGsPmG8S2L7h74Mmk
        jVZD57+reUZY2uYXZK6ZoJlDdFmEXt9M6GjGz2alsCvIw//FNNFvhmymhlmEUsPJysz3bI
        JDX0M0NdjJQS/m2yjd832DpAUoF5ekQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-DSITve_JPbSPnZvH9jI53w-1; Sat, 30 Apr 2022 10:49:24 -0400
X-MC-Unique: DSITve_JPbSPnZvH9jI53w-1
Received: by mail-qv1-f72.google.com with SMTP id a12-20020a056214062c00b0045a7b4a1a29so704395qvx.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VOdz1ctG8DsfhQ/t3Bd0GmW9//GLUrDpBS4J4wmHKpE=;
        b=jrK8Ia6mqMce/38pU8Fj7ocy7rF9xAJAXOSIMS+9QbZf5XLMin/piQ080AExopkQOs
         4/SbpZxPHuezeb0ebAbbViyMFUT/lVt+cvyA+qhHUd07okaTToxJST7CNaDebaeAOuBt
         aVh2MUSwaxcn5D3kTYpY0/L01WNXvSaZdgAGEzsS95459dDe4dZTIxbwUmoNjJOucboK
         jvsa7+wvzLti2x/WoMkQu5kHxu5cXvbXivt6pQ3R+wIFbMMAMVvjF+cuIvrrawYPo4uM
         fGJJVjWeBK7+KW1dG0yw6Vvbhw0Sn7SrpcXcP98YKE6A4XPSWF2iRs1Ryr/9FpDaeU2Y
         tbxQ==
X-Gm-Message-State: AOAM530J2oceFuSAazT4uQzPZhkJAUunbm7/Wdu6madJHAoxGjv0KyVV
        LFErmVj3Pbdc2jwJ5Clt3idY4b4QRxiM9JFXK67uB2Cerem/0lcXXunDGgh3EVkK1Mut1GOvEfc
        i/DDTZRC2BGximqOuu9hsJ+fAyGcC6iTWPKmnaIs8UPzQHd5VtyD1KXFwKsHWVDsAAzllCdw=
X-Received: by 2002:a37:f50b:0:b0:680:dee3:e59d with SMTP id l11-20020a37f50b000000b00680dee3e59dmr2911337qkk.729.1651330163283;
        Sat, 30 Apr 2022 07:49:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzP2zV4X0CVFZZpyp9P4jtRx4/60L99V/JkcXscgJ7XrWASvOBkPEjf+mcNg4ZX/ZPygqtOyQ==
X-Received: by 2002:a37:f50b:0:b0:680:dee3:e59d with SMTP id l11-20020a37f50b000000b00680dee3e59dmr2911320qkk.729.1651330163006;
        Sat, 30 Apr 2022 07:49:23 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bb4-20020a05622a1b0400b002e218c3d4c6sm1133195qtb.2.2022.04.30.07.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 07:49:22 -0700 (PDT)
Subject: Re: [PATCH] tools/power turbostat: close file after use
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220430141557.1065405-1-trix@redhat.com>
 <20220430141947.GA5101@chenyu5-mobl1>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d71b4f7d-70db-efb3-4eb8-93cf96ab7519@redhat.com>
Date:   Sat, 30 Apr 2022 07:49:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220430141947.GA5101@chenyu5-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/30/22 7:19 AM, Chen Yu wrote:
> On Sat, Apr 30, 2022 at 10:15:57AM -0400, Tom Rix wrote:
>> The cppcheck reports this issue
>> turbostat.c:2039]: (error) Resource leak: fp
>>
>> When the fscanf fails an error is returned without closing fp.
>> Move the fclose so even if the fscanf fails, the file will be closed.
>>
>> Fixes: eae97e053fe3 ("tools/power turbostat: Support thermal throttle count print")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   tools/power/x86/turbostat/turbostat.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
>> index ede31a4287a0..2e9a751af260 100644
>> --- a/tools/power/x86/turbostat/turbostat.c
>> +++ b/tools/power/x86/turbostat/turbostat.c
>> @@ -2035,9 +2035,9 @@ int get_core_throt_cnt(int cpu, unsigned long long *cnt)
>>   	if (!fp)
>>   		return -1;
>>   	ret = fscanf(fp, "%lld", &tmp);
>> +	fclose(fp);
>>   	if (ret != 1)
>>   		return -1;
>> -	fclose(fp);
>>   	*cnt = tmp;
>>   
>>   	return 0;
>> --
> Thank you Tom, and Colin has proposed a fix here:
> https://lore.kernel.org/lkml/20220426131607.1520483-1-colin.i.king@gmail.com/

Obviously I approve of Colin's fix :)

If it is not too much trouble, please add

Reviewed-by: Tom Rix <trix@redhat.com>

If it is already on its way to linux-next, don't worry about it.

Thanks,

Tom

>
> thanks,
> Chenyu
>

