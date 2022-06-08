Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70A4542D17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiFHKUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbiFHKSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:18:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC7ED120A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654682721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wz+Ze0Cgd0YCjeuy2qnvuOXb2LvyK0B5KAWLdIayw2s=;
        b=RnXAXMjtkXS5JKck/POcdDZAor5QFovnYHup1EX1w74eTPhZ6b8t9BpqRpuHHZ8CwVwKNH
        BZ6WN3HYggndPoNhkC3rNjWE1xNJA48Ccbe/qWyenTAUunaROZc0gGk88R7VsohB+MbIWC
        O4vGkVeYO9+yE/jxHWgjykcBDuvJ44I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-wRff_zSXMi27iIH1CINJcQ-1; Wed, 08 Jun 2022 06:05:20 -0400
X-MC-Unique: wRff_zSXMi27iIH1CINJcQ-1
Received: by mail-wm1-f69.google.com with SMTP id bg40-20020a05600c3ca800b00394779649b1so14181654wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 03:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=wz+Ze0Cgd0YCjeuy2qnvuOXb2LvyK0B5KAWLdIayw2s=;
        b=SYkhK8UgTCRs7GCfC4z3u5exjYX3sue3tYsd1SkC6t8QOcnAP4S1o+zUafjDwNL2c6
         dKT0xoHyoen3vyQ9UJPbYvD6JKCFGWT5aIP1TRt4mhdyFzlaGQWYlqYxCCYiJGab7hhP
         kCdDeqU6EjkjlUzbaIpKIOi0LupTfDlvVXaMbU+qMJXx25YzTQVUetAR64hV2/hrj2Rg
         BsI65UazCBvsBnToBX46dydJ6x2aCv8nx0xzdoyIYfLWaYtDTOjIrFJ834coDU8xW/hu
         eK7wYNn58zGl6xNUe935YZR3zHRZcC4FGrYMHUdq+ybU+61vZJwhtPVYrB+2nMjBLxuu
         IVFQ==
X-Gm-Message-State: AOAM533snfSCpSdU1zx0Kn/Dt4uMjgKh6+b6c8JgiNxiZgLW2j5oCvMi
        yWBbsHbfynTnDTzh+mLgjpJ+3pAqGHp4iKixP1LvDspj2apnZJbGHFYzTE6Y23OCAz8QItMdf5f
        EVVMbT2j4QOki9t3S0a/WEsp2
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id c13-20020a5d414d000000b00213be000a35mr25965657wrq.97.1654682719316;
        Wed, 08 Jun 2022 03:05:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLGuQwmVMW4pZZeGZ95ClHIeCii1CvGlFxu5BCC6E0yllfRq4Y9hUs1iWS3i9Ns9v/po+j9Q==
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id c13-20020a5d414d000000b00213be000a35mr25965636wrq.97.1654682719016;
        Wed, 08 Jun 2022 03:05:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ad00:db2:4c6:8f3a:2ec4? (p200300cbc705ad000db204c68f3a2ec4.dip0.t-ipconnect.de. [2003:cb:c705:ad00:db2:4c6:8f3a:2ec4])
        by smtp.gmail.com with ESMTPSA id y6-20020adfee06000000b0021004d7d75asm21147724wrn.84.2022.06.08.03.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:05:17 -0700 (PDT)
Message-ID: <56f013a8-b585-4683-a998-83ea0dc53d95@redhat.com>
Date:   Wed, 8 Jun 2022 12:05:16 +0200
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
 <0724b4c4-15f6-e429-f945-f57c619c7270@redhat.com>
 <7ca676a9-1f51-47f7-0245-d041d075a440@huawei.com>
 <f6eb98ae-965b-d705-6f7d-c2ee69ce5141@redhat.com>
 <a96fab6c-f986-797f-aeb1-5fb8a1b5a4b8@huawei.com>
 <059fe8fe-bd89-477f-2430-277bb738525b@redhat.com>
 <4b13e16e-1b66-d49a-da0b-7b29c0be8ace@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <4b13e16e-1b66-d49a-da0b-7b29c0be8ace@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.22 04:20, Miaohe Lin wrote:
> On 2022/6/2 16:47, David Hildenbrand wrote:
>> On 02.06.22 09:40, Miaohe Lin wrote:
>>> On 2022/6/1 18:31, David Hildenbrand wrote:
>>>> On 31.05.22 14:37, Miaohe Lin wrote:
>>>>> On 2022/5/31 19:59, David Hildenbrand wrote:
>>>>>> Sorry for the late reply, was on vacation.
>>>>>
>>>>> That's all right. Hope you have a great time. ;)
>>>>>
>>>>>>
>>>>>>>>>
>>>>>>>>> But for isolated page, PageLRU is cleared. So when the isolated page is released, __clear_page_lru_flags
>>>>>>>>> won't be called. So we have to clear the PG_active and PG_unevictable here manully. So I think
>>>>>>>>> this code block works. Or am I miss something again?
>>>>>>>>
>>>>>>>> Let's assume the following: page as freed by the owner and we enter
>>>>>>>> unmap_and_move().
>>>>>>>>
>>>>>>>>
>>>>>>>> #1: enter unmap_and_move() // page_count is 1
>>>>>>>> #2: enter isolate_movable_page() // page_count is 1
>>>>>>>> #2: get_page_unless_zero() // page_count is now 2
>>>>>>>> #1: if (page_count(page) == 1) { // does not trigger
>>>>>>>> #2: put_page(page); // page_count is now 1
>>>>>>>> #1: put_page(page); // page_count is now 0 -> freed
>>>>>>>>
>>>>>>>>
>>>>>>>> #1 will trigger __put_page() -> __put_single_page() ->
>>>>>>>> __page_cache_release() will not clear the flags because it's not an LRU
>>>>>>>> page at that point in time, right (-> isolated)?
>>>>>>>
>>>>>>> Sorry, you're right. I thought the old page will be freed via putback_lru_page which will
>>>>>>> set PageLRU back instead of put_page directly. So if the above race occurs, PG_active and
>>>>>>> PG_unevictable will remain set while page goes to the buddy and check_free_page will complain
>>>>>>> about it. But it seems this is never witnessed?
>>>>>>
>>>>>> Maybe
>>>>>>
>>>>>> a) we were lucky so far and didn't trigger it
>>>>>> b) the whole code block is dead code because we are missing something
>>>>>> c) we are missing something else :)
>>>>>
>>>>> I think I found the things we missed in another email [1].
>>>>> [1]: https://lore.kernel.org/all/948ea45e-3b2b-e16c-5b8c-4c34de0ea593@huawei.com/
>>>>>
>>>>> Paste the main content of [1] here:
>>>>>
>>>>> "
>>>>> There are 3 cases in unmap_and_move:
>>>>>
>>>>> 1.page is freed through "if (page_count(page) == 1)" code block. This works
>>>>> as PG_active and PG_unevictable are cleared here.
>>>>>
>>>>> 2. Failed to migrate the page. The page won't be release so we don't care about it.
>>>>
>>>> Right, page is un-isolated.
>>>>
>>>>>
>>>>> 3. The page is migrated successfully. The PG_active and PG_unevictable are cleared
>>>>> via folio_migrate_flags():
>>>>>
>>>>> 	if (folio_test_clear_active(folio)) {
>>>>> 		VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
>>>>> 		folio_set_active(newfolio);
>>>>> 	} else if (folio_test_clear_unevictable(folio))
>>>>> 		folio_set_unevictable(newfolio);
>>>>
>>>> Right.
>>>>
>>>>>
>>>>> For the above race case, the page won't be freed through "if (page_count(page) == 1)" code block.
>>>>> It will just be migrated and freed via put_page() after folio_migrate_flags() having cleared PG_active
>>>>> and PG_unevictable.
>>>>> "
>>>>> Or Am I miss something again? :)
>>>>
>>>> For #1, I'm still not sure what would happen on a speculative reference.
>>>>
>>>> It's worth summarizing that
>>>>
>>>> a) free_pages_prepare() will clear both flags via page->flags &=
>>>> ~PAGE_FLAGS_CHECK_AT_PREP;
>>>>
>>>> b) free_pages_prepare() will bail out if any flag is set in
>>>> check_free_page().
>>>>
>>>> As we've never seen b) in the wild, this certainly has low priority, and
>>>> maybe it really cannot happen right now.
>>>>
>>>> However, maybe really allowing these flags to be set when freeing the
>>>> page and removing the "page_count(page) == 1" case from migration code
>>>> would be the clean thing to do.
>>>
>>> IMHO, check_free_page is used to catch possible problem. There's the comment of PAGE_FLAGS_CHECK_AT_FREE:
>>>
>>> /*
>>>  * Flags checked when a page is freed.  Pages being freed should not have
>>>  * these flags set.  If they are, there is a problem.
>>>  */
>>> #define PAGE_FLAGS_CHECK_AT_FREE
>>>
>>> There might be an assumption: when page is freed, it shouldn't be an active or unevictable page. It should be
>>> inactive and evictable. So allowing these flags to be set when freeing the page might not be a good idea?
>>
>> Yeah, and we'd be lifting that restriction because there is good reason
>> to do so.
>>
>> Maybe we *could* special case for isolated pages; however, that adds
>> runtime overhead. Of course, we could perform different checks for e.g.,
>> DEBUG_VM vs !DEBUG_VM.
> 
> I found there is one assumption about PG_active and PG_unevictable, i.e. in __folio_clear_lru_flags:
> 
> 	/* this shouldn't happen, so leave the flags to bad_page() */
> 	if (folio_test_active(folio) && folio_test_unevictable(folio))
> 		return;
> 
> If PG_active and PG_unevictable are both set, this case will be caught in the bad_page() via check_free_page().
> There might be some other assumptions about PG_active and PG_unevictable. So I think it's not safe to lift that
> restriction.
> 
> But maybe we could limit this check within DEBUG_VM as you suggested. Am I supposed to do it?

Well, if you want, you can look into ways of cleaning that up and
removing the "if there is more than one reference, the owner hasn't
freed the page" condition, because there are corner cases where the
owner might have freed the page but speculative references keep the
refcount temporarily incremented.

-- 
Thanks,

David / dhildenb

