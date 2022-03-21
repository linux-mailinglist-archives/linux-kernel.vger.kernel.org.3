Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B494E2A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349178AbiCUOQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351394AbiCUOK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D1E51788DB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647871565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VG0h6aZGi/DKotr1u/FQ4KTyRHDeLftG2T0kmjcokAs=;
        b=F5Fb3WNEns8GJ0/OScu9wtKvNQUvoMP9ETAmV6e3yQPpceAVrEE8jk5QWzluzX6DZGuNFm
        9wrhIAUnzEKvNn5D2CJ/QeqPQAcYTPvMxYSmDfzhTYRal/Cr3dtWVVByFZbQsls++uaEb2
        n/mdUBgLUJ3hHDW0QXlGizFXzDtQrfo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-DZu6IUACPGmIGEyRGeaKLQ-1; Mon, 21 Mar 2022 10:06:04 -0400
X-MC-Unique: DZu6IUACPGmIGEyRGeaKLQ-1
Received: by mail-qv1-f72.google.com with SMTP id 33-20020a0c8024000000b0043d17ffb0bdso11652851qva.18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VG0h6aZGi/DKotr1u/FQ4KTyRHDeLftG2T0kmjcokAs=;
        b=u8rUNjTCDFzzO6UfyyiVwoPs6lzDhncOL5x+AvSsXoU9g/UmHtTTH3jIFtBHVgnTDn
         JZLv/EddSHVHfCbXYV96acQ1PPAPwCSbTV+WVcKxqOZAiZuSSI6vHQHwSor9sQVeR1ha
         e/sNncYxUH4v2PObnOg70b12GjnOYXAHa28V0TwV24kwvvGoBrowaMnXw/ogiOMDC3zt
         Ygs95uPpeXvsI5zPkW0DCrMvD/RVTk4xJxUlxYxyhoaw/cEHQ5LR1xmXZ8PEniuvLFZr
         GG+5EB+y7/RoFwpg7RJ+9q8BWyZ98Tj9lRWwf5MQg34DUtJJROm4KPMGOMAo9S/sN++I
         d5nw==
X-Gm-Message-State: AOAM531+cJRv65In31Lhzqv2O0ldVbhEapap7f9I9CPML4pxKH6DHWyA
        saJXjS394aFTwlyC+qYiVjqw37m3iBfi5ulc2IPPhAn7SKbpRIOB5oNWSbCa/OIV06hsR5QVaeS
        vOiLTl0Hu1h6AG410nc6fHYHu
X-Received: by 2002:a05:6214:20c6:b0:440:f78c:4ad with SMTP id 6-20020a05621420c600b00440f78c04admr13176165qve.112.1647871563402;
        Mon, 21 Mar 2022 07:06:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNogMKYOxmGdk0YIgGRQvxb9KrtAJefEDo+vvNMGUuVX+R+sy5QoO9FAlecHBkxwBde1eN3w==
X-Received: by 2002:a05:6214:20c6:b0:440:f78c:4ad with SMTP id 6-20020a05621420c600b00440f78c04admr13176133qve.112.1647871562990;
        Mon, 21 Mar 2022 07:06:02 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm10538034qta.76.2022.03.21.07.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 07:06:02 -0700 (PDT)
Subject: Re: [PATCH v2] livepatch: Reorder to use before freeing a pointer
To:     Joe Lawrence <joe.lawrence@redhat.com>, jpoimboe@redhat.com,
        jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220320015143.2208591-1-trix@redhat.com>
 <3ee9826e-b770-d015-0251-e9770172d973@redhat.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b4b347ea-5b12-223a-86f5-c13aee714f08@redhat.com>
Date:   Mon, 21 Mar 2022 07:05:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3ee9826e-b770-d015-0251-e9770172d973@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/21/22 6:39 AM, Joe Lawrence wrote:
> On 3/19/22 9:51 PM, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this issue
>> livepatch-shadow-fix1.c:113:2: warning: Use of
>>    memory after it is freed
>>    pr_info("%s: dummy @ %p, prevented leak @ %p\n",
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> The pointer is freed in the previous statement.
>> Reorder the pr_info to report before the free.
>>
>> Similar issue in livepatch-shadow-fix2.c
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>> v2: Fix similar issue in livepatch-shadow-fix2.c
>>
>>   samples/livepatch/livepatch-shadow-fix1.c | 2 +-
>>   samples/livepatch/livepatch-shadow-fix2.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
>> index 918ce17b43fda..6701641bf12d4 100644
>> --- a/samples/livepatch/livepatch-shadow-fix1.c
>> +++ b/samples/livepatch/livepatch-shadow-fix1.c
>> @@ -109,9 +109,9 @@ static void livepatch_fix1_dummy_leak_dtor(void *obj, void *shadow_data)
>>   	void *d = obj;
>>   	int **shadow_leak = shadow_data;
>>   
>> -	kfree(*shadow_leak);
>>   	pr_info("%s: dummy @ %p, prevented leak @ %p\n",
>>   			 __func__, d, *shadow_leak);
>> +	kfree(*shadow_leak);
>>   }
>>   
>>   static void livepatch_fix1_dummy_free(struct dummy *d)
>> diff --git a/samples/livepatch/livepatch-shadow-fix2.c b/samples/livepatch/livepatch-shadow-fix2.c
>> index 29fe5cd420472..361046a4f10cf 100644
>> --- a/samples/livepatch/livepatch-shadow-fix2.c
>> +++ b/samples/livepatch/livepatch-shadow-fix2.c
>> @@ -61,9 +61,9 @@ static void livepatch_fix2_dummy_leak_dtor(void *obj, void *shadow_data)
>>   	void *d = obj;
>>   	int **shadow_leak = shadow_data;
>>   
>> -	kfree(*shadow_leak);
>>   	pr_info("%s: dummy @ %p, prevented leak @ %p\n",
>>   			 __func__, d, *shadow_leak);
>> +	kfree(*shadow_leak);
>>   }
>>   
>>   static void livepatch_fix2_dummy_free(struct dummy *d)
>>
> Hi Tom,
>
> Ordering doesn't matter for the example, so let's clean up the static
> analysis.
>
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
>
> But for my sanity, isn't this a false positive?  There shouldn't be harm
> in printing the pointer itself, even after what it points to has been
> freed, i.e.
>
> 	int *i = malloc(sizeof(*i));
> 	free(i);
> 	printf("%p\n", i);      << ok
> 	printf("%d\n", *i);     << NOT ok
>
> But I suppose clang doesn't know that the passed pointer isn't getting
> dereferenced by the function, so it throws up a warning?  Just curious
> what your experience has been with respect to these reports.

The analysis it good for static functions, for extern functions it has 
nothing to analyze so a worst case is assumed.

I agree this is likely a false positive.

Tom

>
> Thanks,

