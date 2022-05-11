Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C83523723
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiEKPXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343580AbiEKPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D5D722404B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652282609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSwu7xqkqoNLt+H1Fs+CQIumcyQcOiTFfolxhe68oB0=;
        b=bGGJXIaxT4eTG53R4qklI3Dc/tE+pP3NP5Cyn91Y58jply+yIltKxyEVhzhKnmTI62Tws/
        ulxV/GAunXDUdSxQybYeLYeYKksO1/NuZxXFUNtragfnWYbqqlDN14eVAf5G/bsWHXHmNV
        ocpfLCjaKFjaXHvT4sdAgzOuZQmaYA4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-KxBzYXLgOU2XJmgfP0SttA-1; Wed, 11 May 2022 11:23:27 -0400
X-MC-Unique: KxBzYXLgOU2XJmgfP0SttA-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so841552wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=QSwu7xqkqoNLt+H1Fs+CQIumcyQcOiTFfolxhe68oB0=;
        b=4CJ5gJoJOuZ6V66YF2J+mPlXEe6dgGkiJQVY7aOBGMzBNqB2HeN7ts8AiQuaGwJcwM
         NlNAtyAuBAjCwIMEbvSRcn1DhoeH4EbcnsT93BoxoxQR3buP7b3W2c55jwehfLjrhew6
         9gvDs+NK9aQ74ACEZpltEYfW0NMjoCJL13P9hkZOxI8IjBii5T/m+sNhJ5/pPbMbzPJR
         pCF8G3f5jI8JqwuMH//W4TqgACR2DBdW1UIe2DNho6Ae/W5zuDm7bu70MRVbDbq7epKC
         QnOzYx4dveT6PAMUIH0iNO1xn7Hj8sDBq9kqilP30FxpL4PuLgWMTtST4wlFT5ut7f/s
         28HA==
X-Gm-Message-State: AOAM533eCHmuZevQGivbndnZkA+IM4oyBBp5EJ10oPTQjXPQZMxUpX2Z
        yj9YDSDL3/wzSwN7yl4Ew0+j8zsXFt1wCKCTMwwcgZNrUPD0FvGOtmTL5WoE1Zbts5xW8t3BiPB
        yHiySg1EUJOtxSLOrmzVNQ0Cc
X-Received: by 2002:a05:6000:144e:b0:20c:ab37:70f3 with SMTP id v14-20020a056000144e00b0020cab3770f3mr23119861wrx.682.1652282606801;
        Wed, 11 May 2022 08:23:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXmrCQHyV0Vzn7S9Pf5AXsxOTUZnIuFnjQeZxtcrP3EcXVkDoAgCyGtUebE34qnyln2EmSPQ==
X-Received: by 2002:a05:6000:144e:b0:20c:ab37:70f3 with SMTP id v14-20020a056000144e00b0020cab3770f3mr23119840wrx.682.1652282606497;
        Wed, 11 May 2022 08:23:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:700:2393:b0f4:ef08:bd51? (p200300cbc70107002393b0f4ef08bd51.dip0.t-ipconnect.de. [2003:cb:c701:700:2393:b0f4:ef08:bd51])
        by smtp.gmail.com with ESMTPSA id i10-20020a5d630a000000b0020c5253d8d4sm1956738wru.32.2022.05.11.08.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 08:23:25 -0700 (PDT)
Message-ID: <4cf144a9-fff5-d993-4fcb-7f2dfa6e71bb@redhat.com>
Date:   Wed, 11 May 2022 17:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     ying.huang@intel.com, hch@lst.de, dhowells@redhat.com,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-3-linmiaohe@huawei.com>
 <525298ad-5e6a-2f8d-366d-4dcb7eebd093@redhat.com>
 <f5f933dc-450c-f3ac-34e6-d6dc1d901efd@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/4] mm/migration: remove unneeded lock page and
 PageMovable check
In-Reply-To: <f5f933dc-450c-f3ac-34e6-d6dc1d901efd@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.22 10:51, Miaohe Lin wrote:
> On 2022/4/29 18:07, David Hildenbrand wrote:
>> On 25.04.22 15:27, Miaohe Lin wrote:
>>> When non-lru movable page was freed from under us, __ClearPageMovable must
>>> have been done. Even if it's not done, ClearPageIsolated here won't hurt
>>> as page will be freed anyway. So we can thus remove unneeded lock page and
>>> PageMovable check here.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>  mm/migrate.c | 8 ++------
>>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index b779646665fe..0fc4651b3e39 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1093,12 +1093,8 @@ static int unmap_and_move(new_page_t get_new_page,
>>>  		/* page was freed from under us. So we are done. */
>>>  		ClearPageActive(page);
>>>  		ClearPageUnevictable(page);
>>> -		if (unlikely(__PageMovable(page))) {
>>> -			lock_page(page);
>>> -			if (!PageMovable(page))
>>> -				ClearPageIsolated(page);
>>> -			unlock_page(page);
>>> -		}
>>> +		if (unlikely(__PageMovable(page)))
>>> +			ClearPageIsolated(page);
>>>  		goto out;
>>>  	}
>>
>> Hm, that code+change raises a couple of questions.
>>
>> We're doing here the same as in putback_movable_pages(). So I guess the
>> difference here is that the caller did release the reference while the
>> page was isolated, while we don't assume the same in
>> putback_movable_pages().
> 
> Agree.
> 
>>
>>
>> Shouldn't whoever owned the page have cleared that? IOW, is it even
>> valid that we see a movable or isolated page here (WARN/BUG?)?
>>
>> At least for balloon compaction, I remember that __PageMovable() is
>> properly cleared before freeing it via balloon_page_delete().
> 
> z3fold, zsmalloc will do __ClearPageMovable when the page is going to be released.
> So I think we shouldn't see a movable page here:
> 
> void __ClearPageMovable(struct page *page)
> {
> 	VM_BUG_ON_PAGE(!PageMovable(page), page);
> 	/*
> 	 * Clear registered address_space val with keeping PAGE_MAPPING_MOVABLE
> 	 * flag so that VM can catch up released page by driver after isolation.
> 	 * With it, VM migration doesn't try to put it back.
> 	 */
> 	page->mapping = (void *)((unsigned long)page->mapping &
> 				PAGE_MAPPING_MOVABLE);
> }
> 
> But it seems there is no guarantee for PageIsolated flag. Or am I miss something?

At least the code we have now:

if (unlikely(__PageMovable(page)))
	ClearPageIsolated(page);

Should be dead code. So PG_isolated could remain set.

If PG_isolated is still set, it will get cleared in the buddy when
freeing the page via

	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;

> 
>>
>>
>> Also, I am not sure how reliable that page count check is here: if we'd
>> have another speculative reference to the page, we might see
>> "page_count(page) > 1" and not take that path, although the previous
>> owner released the last reference.
> 
> IIUC, there should not be such speculative reference. The driver should have taken care
> of it.

How can you prevent any kind of speculative references?

See isolate_movable_page() as an example, which grabs a speculative
reference to then find out that the page is already isolated by someone
else, to then back off.

-- 
Thanks,

David / dhildenb

