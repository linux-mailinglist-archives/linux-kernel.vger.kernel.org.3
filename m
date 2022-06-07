Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A2354018D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbiFGOhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245608AbiFGOhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:37:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00CC6F490
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:37:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so17844710pjm.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yTEzRF0Fii0j65U0iMVU6mgU+ooT0ju4Efd+jfN1Fkc=;
        b=kiZU/IagZGJr2xHwdIHq3pgVvPO5Zmdq+OQmZgbd6BCjH5j9tfiIRAomZje+AkXFrR
         XEnHG+Grkar0rVTMYmu/04fZwtxWLqW6gOIYW8+apxYmyIXKH7oojlHurYurbGWjEcE4
         usLRiVDtk6fxLwJQu8MiJeKalzuFcigb3kGIFkeVlNt22xZoUhJX4Z8pHvfMzWkmHyjH
         V58xVjO142IESi83jb9+L0ZJhzhyZDmhj+fCdQvNHL9BDi4ijwljSq8PtWwSs7VCysyD
         loF4PoFBvtSoW33OSAwuZuftwaEYrHkknXb+qax1ColILLHu0JhQDfJcWyDv+VZe8mIE
         ImDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yTEzRF0Fii0j65U0iMVU6mgU+ooT0ju4Efd+jfN1Fkc=;
        b=ePZ6LRRodsOUcNVbRhuxIaPwhLFDy8dCxF45ghLI7LrNOzo5tkCJItalG5fST+2cJB
         KQp5FXq9uAR+cfVMIn0hABp2jtq1PZU6nMSpHqgcDX1o1TGvU6rh6w3xPRLO5MmtY04n
         5iPC9yMb6kTpw7/EL/Vk6D97V5pu27yOWLrJM0lFESHj3+A1mcdWsXMndGJbbEJ0SfpG
         pYMVRT4FoDwwwfOklfpLiV5occn1szTd56DshRUbk4m8seX9ElX/trk+/57mZtMbf4DN
         ltDB9sSlETbTx8d3KOp0QiBAe1BDhF07g4eG1Trid22d8V7C9ryARDrCllHEM6zIWgfM
         yr6w==
X-Gm-Message-State: AOAM530oRJTg+sM2Iwjux3ngHchQb7JbIZp1I+X85c6XiU/YDOJSJ4y4
        GrtZNZN6zOSwF5e87W7RIcY=
X-Google-Smtp-Source: ABdhPJxCWd53/tQETnzqmpz0aORGbNBgq/XouGG/BejSDhzwEhQ7bJZCat3TVpRqv6gD/GQaAgT+Rw==
X-Received: by 2002:a17:902:6b08:b0:165:fd6:6abd with SMTP id o8-20020a1709026b0800b001650fd66abdmr29352509plk.152.1654612664370;
        Tue, 07 Jun 2022 07:37:44 -0700 (PDT)
Received: from [192.168.1.104] ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001621c48d6c2sm5442897pli.221.2022.06.07.07.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 07:37:43 -0700 (PDT)
Message-ID: <564734af-8627-0046-6460-151d3b325439@gmail.com>
Date:   Tue, 7 Jun 2022 22:37:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/4] mm: kmemleak: kmemleak_*_phys() set address type
 and check PA when scan
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
 <20220603035415.1243913-5-patrick.wang.shcn@gmail.com>
 <Yp4dd2vvO49BRaj3@arm.com>
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
In-Reply-To: <Yp4dd2vvO49BRaj3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/6 23:29, Catalin Marinas wrote:
> On Fri, Jun 03, 2022 at 11:54:15AM +0800, Patrick Wang wrote:
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index 246a70b7218f..62d1ad8f8a44 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -1156,8 +1156,12 @@ EXPORT_SYMBOL(kmemleak_no_scan);
>>   void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
>>   			       gfp_t gfp)
>>   {
>> -	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
>> -		kmemleak_alloc(__va(phys), size, min_count, gfp);
>> +	pr_debug("%s(0x%pa, %zu, %d)\n", __func__, &phys, size, min_count);
>> +
>> +	if (kmemleak_enabled && !min_count)
>> +		/* create object with OBJECT_PHYS flag */
>> +		create_object((unsigned long)phys, size, min_count,
>> +			      gfp, true);
>>   }
> 
> With an early patch, just drop min_count altogether from this API,
> assume 0.

Will do.

> 
>>   EXPORT_SYMBOL(kmemleak_alloc_phys);
>>   
>> @@ -1170,8 +1174,10 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
>>    */
>>   void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
>>   {
>> -	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
>> -		kmemleak_free_part(__va(phys), size);
>> +	pr_debug("%s(0x%pa)\n", __func__, &phys);
>> +
>> +	if (kmemleak_enabled)
>> +		delete_object_part((unsigned long)phys, size, true);
>>   }
>>   EXPORT_SYMBOL(kmemleak_free_part_phys);
>>   
>> @@ -1182,8 +1188,10 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
>>    */
>>   void __ref kmemleak_not_leak_phys(phys_addr_t phys)
>>   {
>> -	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
>> -		kmemleak_not_leak(__va(phys));
>> +	pr_debug("%s(0x%pa)\n", __func__, &phys);
>> +
>> +	if (kmemleak_enabled)
>> +		make_gray_object((unsigned long)phys, true);
>>   }
>>   EXPORT_SYMBOL(kmemleak_not_leak_phys);
> 
> This function doesn't have any callers, so please remove it.

Will do.

Thanks,
Patrick

