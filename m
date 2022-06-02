Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E2C53B559
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiFBIrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiFBIrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A10AB45042
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654159653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IZUWU1vP6nW4XZ/4rbj0jRx4Rk3cf8SZYUco2pQRSA=;
        b=JBXfPRtWPdPR8AftcYM789SxyGQPYTRNyqMmN+ZGgg/HeLBwMW6D6FugNGPfvSTvQydT3Z
        +ZdvQSSZNWoSUiGkIRQgIw8SIP8qFBktYkrhM9gjAjnUtHmY3dzGAcBQ8uHDMbrowkLXMZ
        DgfIfbHGE+fYVGPDi1BLXyiXwyG6ANY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-9nj3c9lNNnW9k30mI5IP5w-1; Thu, 02 Jun 2022 04:47:32 -0400
X-MC-Unique: 9nj3c9lNNnW9k30mI5IP5w-1
Received: by mail-wm1-f70.google.com with SMTP id j14-20020a05600c1c0e00b003973bf0d146so2505068wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 01:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=7IZUWU1vP6nW4XZ/4rbj0jRx4Rk3cf8SZYUco2pQRSA=;
        b=rNlrCB4FdCigCNNfKdD58BUCbXZEjtbEl/SR8P4Ew6p55593LEDypmyA4P4m+cPdMJ
         FjBi8gFqHakEOpmCmqLX73caXXKQGJTMUyI6jkvfpRuPJHvTWg1zlhORe6vz4yrESIVQ
         nOw80J70W1HFf4oMuQ4zeItQgwX1/iRMVjgQ0jkm5adsAvueufxgOoE2HOsLDdv5hcHp
         l6Uy+qvAW3tO9LvVLlE8hXN0lnD6Vrziwr2L2av9rdEYw6tLJn7GiZGLq/RxcxxnhtLp
         oNeUBroN2UKy2jV+42CQpaO+jf11gp0aifHvZBTZPk9qxJ94G42FAVMj1hFmHi69PvBd
         tGzg==
X-Gm-Message-State: AOAM5310tGNOD1zLg4wXpg/ZFOW5oExV+TlvRPGknekyPjMj3ZHNZwje
        zbuCfQExREB0EopX8aKjxa0GM9uqN3xKEUmugzhKtS5ZYy4y1Om3v3O0er0rXeKHM78OphGQ5z5
        QsVycpVMSjwTdAaDF4Okck9gy
X-Received: by 2002:a05:600c:600a:b0:397:4d8f:2655 with SMTP id az10-20020a05600c600a00b003974d8f2655mr32617280wmb.92.1654159651340;
        Thu, 02 Jun 2022 01:47:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykHk5uzhbNbWMoc/2QZ9JYsRzhbaJMAjTvM/RKb+aM2/6jO99wIzwEHlE9zN89olaRhptulw==
X-Received: by 2002:a05:600c:600a:b0:397:4d8f:2655 with SMTP id az10-20020a05600c600a00b003974d8f2655mr32617257wmb.92.1654159651028;
        Thu, 02 Jun 2022 01:47:31 -0700 (PDT)
Received: from [192.168.178.20] (p57a1a7d6.dip0.t-ipconnect.de. [87.161.167.214])
        by smtp.gmail.com with ESMTPSA id p9-20020adf9d89000000b0020d10a249eesm4326132wre.13.2022.06.02.01.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 01:47:30 -0700 (PDT)
Message-ID: <059fe8fe-bd89-477f-2430-277bb738525b@redhat.com>
Date:   Thu, 2 Jun 2022 10:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
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
 <0724b4c4-15f6-e429-f945-f57c619c7270@redhat.com>
 <7ca676a9-1f51-47f7-0245-d041d075a440@huawei.com>
 <f6eb98ae-965b-d705-6f7d-c2ee69ce5141@redhat.com>
 <a96fab6c-f986-797f-aeb1-5fb8a1b5a4b8@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/4] mm/migration: remove unneeded lock page and
 PageMovable check
In-Reply-To: <a96fab6c-f986-797f-aeb1-5fb8a1b5a4b8@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.22 09:40, Miaohe Lin wrote:
> On 2022/6/1 18:31, David Hildenbrand wrote:
>> On 31.05.22 14:37, Miaohe Lin wrote:
>>> On 2022/5/31 19:59, David Hildenbrand wrote:
>>>> Sorry for the late reply, was on vacation.
>>>
>>> That's all right. Hope you have a great time. ;)
>>>
>>>>
>>>>>>>
>>>>>>> But for isolated page, PageLRU is cleared. So when the isolated page is released, __clear_page_lru_flags
>>>>>>> won't be called. So we have to clear the PG_active and PG_unevictable here manully. So I think
>>>>>>> this code block works. Or am I miss something again?
>>>>>>
>>>>>> Let's assume the following: page as freed by the owner and we enter
>>>>>> unmap_and_move().
>>>>>>
>>>>>>
>>>>>> #1: enter unmap_and_move() // page_count is 1
>>>>>> #2: enter isolate_movable_page() // page_count is 1
>>>>>> #2: get_page_unless_zero() // page_count is now 2
>>>>>> #1: if (page_count(page) == 1) { // does not trigger
>>>>>> #2: put_page(page); // page_count is now 1
>>>>>> #1: put_page(page); // page_count is now 0 -> freed
>>>>>>
>>>>>>
>>>>>> #1 will trigger __put_page() -> __put_single_page() ->
>>>>>> __page_cache_release() will not clear the flags because it's not an LRU
>>>>>> page at that point in time, right (-> isolated)?
>>>>>
>>>>> Sorry, you're right. I thought the old page will be freed via putback_lru_page which will
>>>>> set PageLRU back instead of put_page directly. So if the above race occurs, PG_active and
>>>>> PG_unevictable will remain set while page goes to the buddy and check_free_page will complain
>>>>> about it. But it seems this is never witnessed?
>>>>
>>>> Maybe
>>>>
>>>> a) we were lucky so far and didn't trigger it
>>>> b) the whole code block is dead code because we are missing something
>>>> c) we are missing something else :)
>>>
>>> I think I found the things we missed in another email [1].
>>> [1]: https://lore.kernel.org/all/948ea45e-3b2b-e16c-5b8c-4c34de0ea593@huawei.com/
>>>
>>> Paste the main content of [1] here:
>>>
>>> "
>>> There are 3 cases in unmap_and_move:
>>>
>>> 1.page is freed through "if (page_count(page) == 1)" code block. This works
>>> as PG_active and PG_unevictable are cleared here.
>>>
>>> 2. Failed to migrate the page. The page won't be release so we don't care about it.
>>
>> Right, page is un-isolated.
>>
>>>
>>> 3. The page is migrated successfully. The PG_active and PG_unevictable are cleared
>>> via folio_migrate_flags():
>>>
>>> 	if (folio_test_clear_active(folio)) {
>>> 		VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
>>> 		folio_set_active(newfolio);
>>> 	} else if (folio_test_clear_unevictable(folio))
>>> 		folio_set_unevictable(newfolio);
>>
>> Right.
>>
>>>
>>> For the above race case, the page won't be freed through "if (page_count(page) == 1)" code block.
>>> It will just be migrated and freed via put_page() after folio_migrate_flags() having cleared PG_active
>>> and PG_unevictable.
>>> "
>>> Or Am I miss something again? :)
>>
>> For #1, I'm still not sure what would happen on a speculative reference.
>>
>> It's worth summarizing that
>>
>> a) free_pages_prepare() will clear both flags via page->flags &=
>> ~PAGE_FLAGS_CHECK_AT_PREP;
>>
>> b) free_pages_prepare() will bail out if any flag is set in
>> check_free_page().
>>
>> As we've never seen b) in the wild, this certainly has low priority, and
>> maybe it really cannot happen right now.
>>
>> However, maybe really allowing these flags to be set when freeing the
>> page and removing the "page_count(page) == 1" case from migration code
>> would be the clean thing to do.
> 
> IMHO, check_free_page is used to catch possible problem. There's the comment of PAGE_FLAGS_CHECK_AT_FREE:
> 
> /*
>  * Flags checked when a page is freed.  Pages being freed should not have
>  * these flags set.  If they are, there is a problem.
>  */
> #define PAGE_FLAGS_CHECK_AT_FREE
> 
> There might be an assumption: when page is freed, it shouldn't be an active or unevictable page. It should be
> inactive and evictable. So allowing these flags to be set when freeing the page might not be a good idea?

Yeah, and we'd be lifting that restriction because there is good reason
to do so.

Maybe we *could* special case for isolated pages; however, that adds
runtime overhead. Of course, we could perform different checks for e.g.,
DEBUG_VM vs !DEBUG_VM.

-- 
Thanks,

David / dhildenb

