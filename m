Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF646525303
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356603AbiELQvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiELQu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA3742A259
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652374252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+p6OI7zn/vpRqcJ7qfqifgvime/Tmxv85qu8UfmxWKE=;
        b=F+f6im4Tu6aGXMmPmmwCbyOe0P1RG2nEWjicPbA/s8msPbwPHdSbxqmp/KojDiw5MIDEM2
        nNGT2WdvDcbdbIf8KabDKVql6KdS1oPAsZrasmOREsXGFdTa8pdstY4tfMLa8XgFm2FiuN
        Ow8zZkiRtu/lAxFw4/0TWiczWx+fDDg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-QOkR_1FMMcmDPwswhNiLNg-1; Thu, 12 May 2022 12:50:51 -0400
X-MC-Unique: QOkR_1FMMcmDPwswhNiLNg-1
Received: by mail-wr1-f71.google.com with SMTP id o18-20020adfcf12000000b0020cdc76ea11so2256338wrj.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=+p6OI7zn/vpRqcJ7qfqifgvime/Tmxv85qu8UfmxWKE=;
        b=BsBNfdd/FmVcuFmKZAFjdIU3P6D6xKSuGCxk6KINcxmQ3hS5ABrggOXVOh9u3Xu/KC
         2LCfesOssx5+zsZpw2IFwRC5L1GDlITUWJrA1u3oKdU0qQp/O4eSmK/E0+H4X4hz+IxS
         a45xSSK76/5rh4S3jYxG3d4a0G23rM6WULMj2wMqIYoNmMNmjU1ogwY9HeJemAdt1KPs
         NqIYQNLIlLil651DFi/DlrKWRZeVhXvpNGb0WRrChezNHyVUbxEfolHOHyX5tNjfOtxk
         UcOl64xZM2anOkpwpoLYU4kEuP+97B0C0AKCXliQYGEMv3fFvnz4LgEket59ampqOQov
         xQvA==
X-Gm-Message-State: AOAM530adEOOkW78IZsni61sGfFsFQMG8PasxgSp1up/YybONm0Z2Wrc
        TENsO4+PHZfcQ4WCCFHvnT1ToQOEVoxSuxDHFwadD6dsg9Rx+2JKIrRA23iKBnoud2yRJ0VTF3z
        TUqtNhmbt5ct7sI7O8keF43QN
X-Received: by 2002:adf:fd0b:0:b0:20a:ea57:6dab with SMTP id e11-20020adffd0b000000b0020aea576dabmr487049wrr.175.1652374250309;
        Thu, 12 May 2022 09:50:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnvmQ2U1mcnaCl3Vxt0Dt94h0FDX3TxaFPWjOIhzkRSc34WG1eU02oMl1mjemI7hVPw/Dgjw==
X-Received: by 2002:adf:fd0b:0:b0:20a:ea57:6dab with SMTP id e11-20020adffd0b000000b0020aea576dabmr487022wrr.175.1652374249940;
        Thu, 12 May 2022 09:50:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c218500b003942a244ec1sm209451wme.6.2022.05.12.09.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 09:50:49 -0700 (PDT)
Message-ID: <143ab5dd-85a9-3338-53b7-e46c9060b20e@redhat.com>
Date:   Thu, 12 May 2022 18:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/4] mm/migration: remove unneeded lock page and
 PageMovable check
In-Reply-To: <025d0dc8-a446-b720-14a8-97c041055f48@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.22 15:26, Miaohe Lin wrote:
> On 2022/5/12 15:10, David Hildenbrand wrote:
>>>> If PG_isolated is still set, it will get cleared in the buddy when
>>>> freeing the page via
>>>>
>>>> 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
>>>
>>> Yes, check_free_page only complains about flags belonging to PAGE_FLAGS_CHECK_AT_FREE and PG_isolated
>>> will be cleared in the buddy when freeing the page. But it might not be a good idea to reply on this ?
>>> IMHO, it should be better to clear the PG_isolated explicitly ourselves.
>>
>> I think we can pretty much rely on this handling in the buddy :)
> 
> So is the below code change what you're suggesting?
> 
> 	if (page_count(page) == 1) {
> 		/* page was freed from under us. So we are done. */
> 		ClearPageActive(page);
> 		ClearPageUnevictable(page);
> -		if (unlikely(__PageMovable(page)))
> -			ClearPageIsolated(page);
> 		goto out;
> 	}

Yeah, unless I am missing something important :)

>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> Also, I am not sure how reliable that page count check is here: if we'd
>>>>>> have another speculative reference to the page, we might see
>>>>>> "page_count(page) > 1" and not take that path, although the previous
>>>>>> owner released the last reference.
>>>>>
>>>>> IIUC, there should not be such speculative reference. The driver should have taken care
>>>>> of it.
>>>>
>>>> How can you prevent any kind of speculative references?
>>>>
>>>> See isolate_movable_page() as an example, which grabs a speculative
>>>> reference to then find out that the page is already isolated by someone
>>>> else, to then back off.
>>>
>>> You're right. isolate_movable_page will be an speculative references case. But the page count check here
>>> is just an optimization. If we encounter speculative references, it still works with useless effort of
>>> migrating to be released page.
>>
>>
>> Not really. The issue is that PAGE_FLAGS_CHECK_AT_FREE contains
>> PG_active and PG_unevictable.
>>
>> We only clear those 2 flags if "page_count(page) == 1". Consequently,
>> with a speculative reference, we'll run into the check_free_page_bad()
>> when dropping the last reference.
> 
> It seems if a speculative reference happens after the "page_count(page) == 1" check,
> it's ok because we cleared the PG_active and PG_unevictable. And if it happens before
> the check, this code block is skipped and the page will be freed after migration. The
> PG_active and PG_unevictable will be correctly cleared when page is actually freed via
> __folio_clear_active. (Please see below comment)
> 
>>
>> This is just shaky. Special casing on "page_count(page) == 1" for
>> detecting "was this freed by the owner" is not 100% water proof.
>>
>> In an ideal world, we'd just get rid of that whole block of code and let
>> the actual freeing code clear PG_active and PG_unevictable. But that
>> would require changes to free_pages_prepare().
>>
>>
>> Now I do wonder, if we ever even have PG_active or PG_unevictable still
>> set when the page was freed by the owner in this code. IOW, maybe that
>> is dead code as well and we can just remove the whole shaky
>> "page_count(page) == 1" code block.
> 
> Think about below common scene: Anonymous page is actively used by the sole owner process, so it
> will have PG_active set. Then process exited while vm tries to migrate that page. So the page
> should have refcnt == 1 while PG_active is set? Note normally PG_active should be cleared when
> the page is released:
> 
> __put_single_page
>   PageLRU
>     __clear_page_lru_flags
>       __folio_clear_active
>       __folio_clear_unevictable
> 
> But for isolated page, PageLRU is cleared. So when the isolated page is released, __clear_page_lru_flags
> won't be called. So we have to clear the PG_active and PG_unevictable here manully. So I think
> this code block works. Or am I miss something again?

Let's assume the following: page as freed by the owner and we enter
unmap_and_move().


#1: enter unmap_and_move() // page_count is 1
#2: enter isolate_movable_page() // page_count is 1
#2: get_page_unless_zero() // page_count is now 2
#1: if (page_count(page) == 1) { // does not trigger
#2: put_page(page); // page_count is now 1
#1: put_page(page); // page_count is now 0 -> freed


#1 will trigger __put_page() -> __put_single_page() ->
__page_cache_release() will not clear the flags because it's not an LRU
page at that point in time, right (-> isolated)?

We did not run that code block that would clear PG_active and
PG_unevictable.

Which still leaves the questions:

a) If PG_active and PG_unevictable was cleared, where?
b) Why is that code block that conditionally clears the flags of any
value and why can't we simply drop it?

-- 
Thanks,

David / dhildenb

