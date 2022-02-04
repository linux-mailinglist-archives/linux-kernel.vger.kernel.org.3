Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD084A92C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 04:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356815AbiBDD3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 22:29:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236970AbiBDD3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643945374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XY2ChDMo+/yGwR1vFiG3NhPQOgcec0xW5lNtn3nVMtM=;
        b=fjekyYfInklUs0tbOBkfdBtybJIcEf4HMJV/vfgvPRBMZHO1AL/vJeZnxyLs60MRwr7awB
        OTzW7NsJNyBmASWYweqPrPsPc4o50ElfU5Ea+66DWd24q9aUF7WDnzhXOYEwtKeI4EV0rG
        /Z5zXjpUl3yX74JIgwndMTyLAyXCmeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-mR7nj8ecM52g-SleUjP3Xw-1; Thu, 03 Feb 2022 22:29:31 -0500
X-MC-Unique: mR7nj8ecM52g-SleUjP3Xw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A41A814246;
        Fri,  4 Feb 2022 03:29:29 +0000 (UTC)
Received: from [10.22.32.130] (unknown [10.22.32.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E1475D6BA;
        Fri,  4 Feb 2022 03:29:24 +0000 (UTC)
Message-ID: <9f5a1c2a-b0ce-8ebf-b811-5f27be4439f3@redhat.com>
Date:   Thu, 3 Feb 2022 22:29:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] mm/sparsemem: Fix 'mem_section' will never be NULL gcc
 12 warning
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Justin Forbes <jforbes@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20220202003550.698768-1-longman@redhat.com>
 <20220203151157.659f382c76056d883fa80ec6@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220203151157.659f382c76056d883fa80ec6@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/3/22 18:11, Andrew Morton wrote:
> On Tue,  1 Feb 2022 19:35:50 -0500 Waiman Long <longman@redhat.com> wrote:
>
>> The gcc 12 compiler reports a "'mem_section' will never be NULL"
>> warning on the following code:
>>
>>      static inline struct mem_section *__nr_to_section(unsigned long nr)
>>      {
>>      #ifdef CONFIG_SPARSEMEM_EXTREME
>>          if (!mem_section)
>>                  return NULL;
>>      #endif
>>          if (!mem_section[SECTION_NR_TO_ROOT(nr)])
>>                  return NULL;
>>         :
>>
>> It happens with both CONFIG_SPARSEMEM_EXTREME on and off. The mem_section
>> definition is
>>
>>      #ifdef CONFIG_SPARSEMEM_EXTREME
>>      extern struct mem_section **mem_section;
>>      #else
>>      extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
>>      #endif
>>
>> In the CONFIG_SPARSEMEM_EXTREME case, mem_section obviously cannot
>> be NULL, but *mem_section can be if memory hasn't been allocated for
>> the dynamic mem_section[] array yet. In the !CONFIG_SPARSEMEM_EXTREME
>> case, mem_section is a static 2-dimensional array and so the check
>> "!mem_section[SECTION_NR_TO_ROOT(nr)]" doesn't make sense.
>>
>> Fix this warning by checking for "!*mem_section" instead of
>> "!mem_section" and moving the "!mem_section[SECTION_NR_TO_ROOT(nr)]"
>> check up inside the CONFIG_SPARSEMEM_EXTREME block.
>>
>> ...
>>
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -1390,11 +1390,9 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
>>   static inline struct mem_section *__nr_to_section(unsigned long nr)
>>   {
>>   #ifdef CONFIG_SPARSEMEM_EXTREME
>> -	if (!mem_section)
>> +	if (!*mem_section || !mem_section[SECTION_NR_TO_ROOT(nr)])
>>   		return NULL;
>>   #endif
>> -	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
>> -		return NULL;
>>   	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
>>   }
>>   extern size_t mem_section_usage_size(void);
> What does the v1->v2 change do?
>
> --- a/include/linux/mmzone.h~mm-sparsemem-fix-mem_section-will-never-be-null-gcc-12-warning-v2
> +++ a/include/linux/mmzone.h
> @@ -1390,11 +1390,9 @@ static inline unsigned long *section_to_
>   static inline struct mem_section *__nr_to_section(unsigned long nr)
>   {
>   #ifdef CONFIG_SPARSEMEM_EXTREME
> -	if (!*mem_section)
> +	if (!*mem_section || !mem_section[SECTION_NR_TO_ROOT(nr)])
>   		return NULL;
>   #endif
> -	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
> -		return NULL;
>   	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
>   }
>   extern size_t mem_section_usage_size(void);
> _

When !CONFIG_SPARSEMEM_EXTREME, mem_section is really a static 2-D 
array. Since it is not a table of pointers, 
mem_section[SECTION_NR_TO_ROOT(nr)] has no real meaning. That is why the 
compiler is complaining. This check isn't applicable in the 
!CONFIG_SPARSEMEM_EXTREME case, but it is meaningful for 
CONFIG_SPARSEMEM_EXTREME. That is why it is pulled into the 
CONFIG_SPARSEMEM_EXTREME block.

Thanks,
Longman

