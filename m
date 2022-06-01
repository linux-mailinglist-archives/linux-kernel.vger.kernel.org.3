Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657EE53A29F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352074AbiFAKbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346150AbiFAKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 582075676B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654079489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QV+5ETvQygEH5YoBYyqkv1Jl7HiCxiIOPVVbXZ9TGXg=;
        b=VqtcO/mOOoMVcd8DJYkK5jCrRNegzv5pfxQH+0QA+ixvC79/3YdOhAvFGVzZm1QLW0D/kd
        hhl+HCEbF390UMJjDEo272z957xAbxWPoQW6W6lFdlSAMeUbBm4TaAZVDLHAwKWanmRXcZ
        hwmfTWI4w99Sk2tV0cXufKodt5HofBM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-myaACGGlN0KSHsSAEzCcyQ-1; Wed, 01 Jun 2022 06:31:28 -0400
X-MC-Unique: myaACGGlN0KSHsSAEzCcyQ-1
Received: by mail-wr1-f71.google.com with SMTP id n3-20020a5d5983000000b0021021e3036eso209177wri.19
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=QV+5ETvQygEH5YoBYyqkv1Jl7HiCxiIOPVVbXZ9TGXg=;
        b=5MjTl/vXOE6/f0dch+koN4UVsex4z/4Ml8n/uxLLgvQrbQlXVQ48+Oq1O42ssp0a2B
         3x0FK0l3L03T7qr63ikXabPgJxSmcWN6VeP+F+LwQI3AYOe4ZsNMSyfVCih6UlA4nnDQ
         Luc+R36W6i8sDymU6TGj0616PLDS7+21cpXOQe9GKFu0ldR+4T+LAvmbm+xw+KsNs/cw
         bmg9pEy2r9uB0KzN0RlpYfQzltaYQLg/LaqMiQ6kgfAZK3s6VMrxRVnkdCs82heL57kD
         wbDDLecgNKHGmhx/1TB3i6xC3au/e8S1htwh2f7IGxyRLAFLiIjJy2ZlG2hYYYseypSB
         hMLA==
X-Gm-Message-State: AOAM530BMHpf5rfqqKc2h+aYqHUBAavgxpVcsyi/6hTMLqKaSAxjj87l
        jey4osyXc/2syIQDYRlILQbM6Bk2dLk8gt3QAcVcCuRXKR9sXd3b/tYTUAWTu7yo+fiSUjuPUtS
        0QEgVotM3OAZ1KUAgq89LK/TQ
X-Received: by 2002:a05:6000:18ae:b0:211:40df:c00e with SMTP id b14-20020a05600018ae00b0021140dfc00emr1245210wri.304.1654079487106;
        Wed, 01 Jun 2022 03:31:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKaAL5669d7n89Du4yPCoMqisp9fOjuBI3hStSpyNY7+GUkvOSlya1tZPe+MXRfnCZ5OcBjg==
X-Received: by 2002:a05:6000:18ae:b0:211:40df:c00e with SMTP id b14-20020a05600018ae00b0021140dfc00emr1245183wri.304.1654079486840;
        Wed, 01 Jun 2022 03:31:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id d17-20020a056000115100b0020d0c9c95d3sm1206791wrx.77.2022.06.01.03.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:31:26 -0700 (PDT)
Message-ID: <f6eb98ae-965b-d705-6f7d-c2ee69ce5141@redhat.com>
Date:   Wed, 1 Jun 2022 12:31:25 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/4] mm/migration: remove unneeded lock page and
 PageMovable check
In-Reply-To: <7ca676a9-1f51-47f7-0245-d041d075a440@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.22 14:37, Miaohe Lin wrote:
> On 2022/5/31 19:59, David Hildenbrand wrote:
>> Sorry for the late reply, was on vacation.
> 
> That's all right. Hope you have a great time. ;)
> 
>>
>>>>>
>>>>> But for isolated page, PageLRU is cleared. So when the isolated page is released, __clear_page_lru_flags
>>>>> won't be called. So we have to clear the PG_active and PG_unevictable here manully. So I think
>>>>> this code block works. Or am I miss something again?
>>>>
>>>> Let's assume the following: page as freed by the owner and we enter
>>>> unmap_and_move().
>>>>
>>>>
>>>> #1: enter unmap_and_move() // page_count is 1
>>>> #2: enter isolate_movable_page() // page_count is 1
>>>> #2: get_page_unless_zero() // page_count is now 2
>>>> #1: if (page_count(page) == 1) { // does not trigger
>>>> #2: put_page(page); // page_count is now 1
>>>> #1: put_page(page); // page_count is now 0 -> freed
>>>>
>>>>
>>>> #1 will trigger __put_page() -> __put_single_page() ->
>>>> __page_cache_release() will not clear the flags because it's not an LRU
>>>> page at that point in time, right (-> isolated)?
>>>
>>> Sorry, you're right. I thought the old page will be freed via putback_lru_page which will
>>> set PageLRU back instead of put_page directly. So if the above race occurs, PG_active and
>>> PG_unevictable will remain set while page goes to the buddy and check_free_page will complain
>>> about it. But it seems this is never witnessed?
>>
>> Maybe
>>
>> a) we were lucky so far and didn't trigger it
>> b) the whole code block is dead code because we are missing something
>> c) we are missing something else :)
> 
> I think I found the things we missed in another email [1].
> [1]: https://lore.kernel.org/all/948ea45e-3b2b-e16c-5b8c-4c34de0ea593@huawei.com/
> 
> Paste the main content of [1] here:
> 
> "
> There are 3 cases in unmap_and_move:
> 
> 1.page is freed through "if (page_count(page) == 1)" code block. This works
> as PG_active and PG_unevictable are cleared here.
> 
> 2. Failed to migrate the page. The page won't be release so we don't care about it.

Right, page is un-isolated.

> 
> 3. The page is migrated successfully. The PG_active and PG_unevictable are cleared
> via folio_migrate_flags():
> 
> 	if (folio_test_clear_active(folio)) {
> 		VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
> 		folio_set_active(newfolio);
> 	} else if (folio_test_clear_unevictable(folio))
> 		folio_set_unevictable(newfolio);

Right.

> 
> For the above race case, the page won't be freed through "if (page_count(page) == 1)" code block.
> It will just be migrated and freed via put_page() after folio_migrate_flags() having cleared PG_active
> and PG_unevictable.
> "
> Or Am I miss something again? :)

For #1, I'm still not sure what would happen on a speculative reference.

It's worth summarizing that

a) free_pages_prepare() will clear both flags via page->flags &=
~PAGE_FLAGS_CHECK_AT_PREP;

b) free_pages_prepare() will bail out if any flag is set in
check_free_page().

As we've never seen b) in the wild, this certainly has low priority, and
maybe it really cannot happen right now.

However, maybe really allowing these flags to be set when freeing the
page and removing the "page_count(page) == 1" case from migration code
would be the clean thing to do.

-- 
Thanks,

David / dhildenb

