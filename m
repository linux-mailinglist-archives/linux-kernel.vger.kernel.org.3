Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F75550353
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 09:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiFRHLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 03:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiFRHLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 03:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 671E73EBBD
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 00:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655536259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3149uVzRocbxaxAqir48oOLcGTAbi4K048Ex/Bn/8OQ=;
        b=JE2lBkrsRlEIrACpEFnLLo3YFAxPuFKOW4QpZT3uPZBsCLlbTEyXXvRbZLnVFLpKTPHAqI
        XWudfjlAg3DxCwbic78Wx9SwN3GM6kPawoYZbtTWaLzWPp0nZKoqFNNDGEbctLh2B6nEYI
        kK1Pwm9bbn1HVb8ObbteJpmUltzJPOs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-5RapYP48MsOZVEI3K5xVNQ-1; Sat, 18 Jun 2022 03:10:57 -0400
X-MC-Unique: 5RapYP48MsOZVEI3K5xVNQ-1
Received: by mail-wm1-f70.google.com with SMTP id m23-20020a05600c3b1700b0039c6e3c169aso3227803wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 00:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=3149uVzRocbxaxAqir48oOLcGTAbi4K048Ex/Bn/8OQ=;
        b=vivu58qT2Pr7VkJ8kHuesz6C/ky7f/xnmGa2J1sP6n6sVDhR2u2rwvtycBQF5bewEB
         iE6HxiGOrYZIHwGHdvIva6/o+zctwml7mmWR6LeweI+3FgWsJFpc8rpecLmKgGUL7Xkd
         rEFqPiTzYPcxP6FH/QWqMpM2K/a9HdDqwyetJ2vIK8uonm/pnUbWxN7vopBQbDZm7Red
         00ukutMXJleDVEowrF26xFjG6AyD8sKHuC9ekVU98wwpjNN4mGkiJmQ2InpR0EPOFUXq
         //Iwe45pULMLRIYrgB+tlAV1ZX5S6iq1D8HcDnKxZqnmzpGCJpAAhSTJxHMkGtUGUj36
         rvfg==
X-Gm-Message-State: AJIora/GPlHV0vBAoWSbJp1sYP1LBdoxOwIl6/JKv3BnGw16JnfZDjDr
        0pgjsP8RSEIahUXNoxTc0gNZq7oVuexkpUSbv9voYKPsvWUhql65VIzR3E/uqa8eG6KOhmApQ54
        vG/1lWG2IzoHiBUweh8bu5IPA
X-Received: by 2002:a05:6000:147:b0:214:7d6e:cb1d with SMTP id r7-20020a056000014700b002147d6ecb1dmr12393514wrx.650.1655536256661;
        Sat, 18 Jun 2022 00:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vrRuJwSp8aqKDGBROF8vdma/TXYjyesDiLAmNqZAKXd3mH1xxa4KIbb0ZZ/KCt1NyfunNVBg==
X-Received: by 2002:a05:6000:147:b0:214:7d6e:cb1d with SMTP id r7-20020a056000014700b002147d6ecb1dmr12393487wrx.650.1655536256366;
        Sat, 18 Jun 2022 00:10:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:5000:9bb2:aead:a175:9777? (p200300cbc71e50009bb2aeada1759777.dip0.t-ipconnect.de. [2003:cb:c71e:5000:9bb2:aead:a175:9777])
        by smtp.gmail.com with ESMTPSA id bg26-20020a05600c3c9a00b0039c45fc58c4sm8022592wmb.21.2022.06.18.00.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 00:10:55 -0700 (PDT)
Message-ID: <24fd3f78-f7e5-a1dc-cad0-15ff826744a9@redhat.com>
Date:   Sat, 18 Jun 2022 09:10:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/3] mm/swapfile: make security_vm_enough_memory_mm()
 work as expected
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-2-linmiaohe@huawei.com>
 <76e468b4-c6ac-426c-7ec9-99c620e08cda@redhat.com>
 <a4b6b2bd-f56c-4f28-6fcc-7ce2f741dd4a@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a4b6b2bd-f56c-4f28-6fcc-7ce2f741dd4a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.06.22 04:43, Miaohe Lin wrote:
> On 2022/6/17 15:33, David Hildenbrand wrote:
>> On 08.06.22 16:40, Miaohe Lin wrote:
>>> security_vm_enough_memory_mm() checks whether a process has enough memory
>>> to allocate a new virtual mapping. And total_swap_pages is considered as
>>> available memory while swapoff tries to make sure there's enough memory
>>> that can hold the swapped out memory. But total_swap_pages contains the
>>> swap space that is being swapoff. So security_vm_enough_memory_mm() will
>>> success even if there's no memory to hold the swapped out memory because
>>
>> s/success/succeed/
> 
> OK. Thanks.
> 
>>
>>> total_swap_pages always greater than or equal to p->pages.
>>>
>>> In order to fix it, p->pages should be retracted from total_swap_pages
>>
>> s/retracted/subtracted/
> 
> OK. Thanks.
> 
>>
>>> first and then check whether there's enough memory for inuse swap pages.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/swapfile.c | 10 +++++++---
>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index ec4c1b276691..d2bead7b8b70 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -2398,6 +2398,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>>>  	struct filename *pathname;
>>>  	int err, found = 0;
>>>  	unsigned int old_block_size;
>>> +	unsigned int inuse_pages;
>>>  
>>>  	if (!capable(CAP_SYS_ADMIN))
>>>  		return -EPERM;
>>> @@ -2428,9 +2429,13 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>>>  		spin_unlock(&swap_lock);
>>>  		goto out_dput;
>>>  	}
>>> -	if (!security_vm_enough_memory_mm(current->mm, p->pages))
>>> -		vm_unacct_memory(p->pages);
>>> +
>>> +	total_swap_pages -= p->pages;
>>> +	inuse_pages = READ_ONCE(p->inuse_pages);
>>> +	if (!security_vm_enough_memory_mm(current->mm, inuse_pages))
>>> +		vm_unacct_memory(inuse_pages);
>>>  	else {
>>> +		total_swap_pages += p->pages;
>>
>> That implies that whenever we fail in security_vm_enough_memory_mm(),
>> that other concurrent users might see a wrong total_swap_pages.
>>
>> Assume 4 GiB memory and 8 GiB swap. Let's assume 10 GiB are in use.
>>
>> Temporarily, we'd have
>>
>> CommitLimit    4 GiB
>> Committed_AS  10 GiB
> 
> IIUC, even if without this change, the other concurrent users if come after vm_acct_memory()
> is done in __vm_enough_memory(), they might see
> 
> CommitLimit   12 GiB (4 GiB memory + 8GiB total swap)
> Committed_AS  18 GiB (10 GiB in use + 8GiB swap space to swapoff)
> 
> Or am I miss something?
> 

I think you are right!

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

