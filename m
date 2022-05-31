Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E57053902D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbiEaMAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344034AbiEaMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8ABD4B876
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653998399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGwek/6vdYkYYLHUigLW7HiiIxESVvwETc14ysV7hYY=;
        b=IJctP2Kl2eQLkDfIEuixupKVkzZ0yf17oZ/nEYYhqAZ676NP4e1b1K/f4IgwkbixiR+cK6
        PVACWkhiAzN+Yao8N1t5CmFKuGMW86ofOiQl9WCewg/TNgndjf73jB6So88JybKrqvk2QS
        nQX2l27uIzpcQxql8QDtuPn0k9cVcF8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-mMfpGoQwMg-Pr1XAS-xlSg-1; Tue, 31 May 2022 07:59:57 -0400
X-MC-Unique: mMfpGoQwMg-Pr1XAS-xlSg-1
Received: by mail-wm1-f72.google.com with SMTP id n18-20020a05600c3b9200b00397335edc7dso1335317wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=PGwek/6vdYkYYLHUigLW7HiiIxESVvwETc14ysV7hYY=;
        b=risPLMDAxJv8CT9LUSPSOV4UOukMVLADwTvvLSuPa9pUCYCvt8nF2FBBdylQDTbn58
         O5JMJhw5ogI5fkes2Ke0OkKsq6tRkXqiNvBsa2tPhZujrFFwxnBYHynlVkqp5a67e1OE
         b0ZRDzTMOCksSb5yt3XJ4QbwDceVxRe1UbCS+r88aAEtwUq8plZHKqJBhJG+gciUDmkQ
         rw4OEj2o0wxqK2GsR01LqAQhfDnz60JYe0EBvctAcoF1VApO2Bf0GfFhv5oMkInumM0b
         AOK8CWp/+Tk3W/hru0obnnCr0tDt1SWaaG3UzsjX6c0NZA+yWtnvwVs0Rp6qA97MktUH
         Y06A==
X-Gm-Message-State: AOAM532G7g52hMUh62R3OYyYewUObsNyyc6Bhp/Bw7JE9hNro7obfMC2
        2t4+SnrEe/x6LV7KX4b7htoBj1jVmATVmb2VuoZzocV8P7OYpUkhsdT1JF6CWjKrJUYwXaJXywl
        8JxOoZIcyZ+qiEVi8WBDXcfSX
X-Received: by 2002:a1c:6a14:0:b0:397:39c4:8ac2 with SMTP id f20-20020a1c6a14000000b0039739c48ac2mr23346013wmc.112.1653998396529;
        Tue, 31 May 2022 04:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMdOdk0HMKlG66DrDiEJOvRunHR/ODdsjln64gd3oH6mSJ68C7FmQc8Slv+Otr7kLBZxLG4A==
X-Received: by 2002:a1c:6a14:0:b0:397:39c4:8ac2 with SMTP id f20-20020a1c6a14000000b0039739c48ac2mr23345999wmc.112.1653998396321;
        Tue, 31 May 2022 04:59:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f100:8096:9368:ba52:a341? (p200300cbc708f10080969368ba52a341.dip0.t-ipconnect.de. [2003:cb:c708:f100:8096:9368:ba52:a341])
        by smtp.gmail.com with ESMTPSA id q12-20020a5d574c000000b002102f90870esm7373917wrw.108.2022.05.31.04.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 04:59:55 -0700 (PDT)
Message-ID: <0724b4c4-15f6-e429-f945-f57c619c7270@redhat.com>
Date:   Tue, 31 May 2022 13:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/4] mm/migration: remove unneeded lock page and
 PageMovable check
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     ying.huang@intel.com, hch@lst.de, dhowells@redhat.com,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com, Minchan Kim <minchan@kernel.org>
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-3-linmiaohe@huawei.com>
 <525298ad-5e6a-2f8d-366d-4dcb7eebd093@redhat.com>
 <f5f933dc-450c-f3ac-34e6-d6dc1d901efd@huawei.com>
 <4cf144a9-fff5-d993-4fcb-7f2dfa6e71bb@redhat.com>
 <924de987-202b-a97e-e6d2-6bdab530f190@huawei.com>
 <c566dc2c-fc70-e410-5272-767fa28cbba4@redhat.com>
 <025d0dc8-a446-b720-14a8-97c041055f48@huawei.com>
 <143ab5dd-85a9-3338-53b7-e46c9060b20e@redhat.com>
 <6ba7e2bd-28c1-53ff-a6b7-072c79714dee@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6ba7e2bd-28c1-53ff-a6b7-072c79714dee@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply, was on vacation.

>>>
>>> But for isolated page, PageLRU is cleared. So when the isolated page is released, __clear_page_lru_flags
>>> won't be called. So we have to clear the PG_active and PG_unevictable here manully. So I think
>>> this code block works. Or am I miss something again?
>>
>> Let's assume the following: page as freed by the owner and we enter
>> unmap_and_move().
>>
>>
>> #1: enter unmap_and_move() // page_count is 1
>> #2: enter isolate_movable_page() // page_count is 1
>> #2: get_page_unless_zero() // page_count is now 2
>> #1: if (page_count(page) == 1) { // does not trigger
>> #2: put_page(page); // page_count is now 1
>> #1: put_page(page); // page_count is now 0 -> freed
>>
>>
>> #1 will trigger __put_page() -> __put_single_page() ->
>> __page_cache_release() will not clear the flags because it's not an LRU
>> page at that point in time, right (-> isolated)?
> 
> Sorry, you're right. I thought the old page will be freed via putback_lru_page which will
> set PageLRU back instead of put_page directly. So if the above race occurs, PG_active and
> PG_unevictable will remain set while page goes to the buddy and check_free_page will complain
> about it. But it seems this is never witnessed?

Maybe

a) we were lucky so far and didn't trigger it
b) the whole code block is dead code because we are missing something
c) we are missing something else :)

> 
>>
>> We did not run that code block that would clear PG_active and
>> PG_unevictable.
>>
>> Which still leaves the questions:
>>
>> a) If PG_active and PG_unevictable was cleared, where?
> 
> For LRU pages, PG_active and PG_unevictable are cleared via __page_cache_release. And for isolated
> (LRU) pages, PG_active and PG_unevictable should be cleared ourselves?
> 
>> b) Why is that code block that conditionally clears the flags of any
>> value and why can't we simply drop it?
>>
> 
> To fix the issue, should we clear PG_active and PG_unevictable unconditionally here?

I wonder if we should simply teach actual freeing code to simply clear
both flags when freeing an isolated page? IOW, to detect "isolated LRU"
is getting freed and fixup?

-- 
Thanks,

David / dhildenb

