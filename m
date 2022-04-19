Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D26506985
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350918AbiDSLRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350920AbiDSLRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B6FD2B259
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650366873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tI8tC7M7FOnSjVVan7Dl8S2hnr3ClK5HwT08ub3keLk=;
        b=bZyokd9njrfL0d2QhQiFcTE3SSw0LawWJNAd8WJaRzVhwhJ+I49N5Ltg2Eb8quY9f4Sghl
        jVew8WJAcUqjbveEki3jv5OTzjNyhrHlUCSfPKgK4wzX/1tjSwiBSP+DvTfbxgscB6Ozg5
        IH7O78/GKCZbsCaVrmC9016talUXdmE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-GFu8-lcXN6KppcGlGs8tVg-1; Tue, 19 Apr 2022 07:14:32 -0400
X-MC-Unique: GFu8-lcXN6KppcGlGs8tVg-1
Received: by mail-wm1-f69.google.com with SMTP id t187-20020a1c46c4000000b0038ebc45dbfcso2879211wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=tI8tC7M7FOnSjVVan7Dl8S2hnr3ClK5HwT08ub3keLk=;
        b=chyWvbNlE++/kShcdlrmNakD2+nHUL5X5mMBonDZGUQuuSB7qgfoVKyl+7Yg0ZMNmt
         DmKtz+FfM7IbCn3zLjpgJwo1Er6N8kKQ/PACsFE/X7KcxnlVlEepS44FLyIOziBRd1eZ
         +BIv+1DbNJuuaA6W9R3KIp0et2rsqgH2LTZsBk6nbiNSdt0OTV7LNDBUmkv1sPp3KVRD
         n1/PYZBCll/tult31/e8bsF5zJ709L0+tqGe2YddKFg7S9t941Rl+K2n7NWOA9B08S5+
         DbqVoIK7yZ9qGMfqRq0jMKuLrPupg2onD/EsXco0aetu7JSUfQcu/nfJ7N6edreqniiF
         W2bw==
X-Gm-Message-State: AOAM532HkHXajExglrrGB+eQkL3yYhoEyvA1gTsKHDwYm4L2UsHF9qdJ
        OylMYCuTtIAjxAA//thN0LqeNzvH6pgb0EOulwDOR2G5kTxTimktL/QT9ouX2xInsVGgcxo1Ta+
        cYbdDG6p+Wmh4AWWPnE6a5fr1
X-Received: by 2002:a7b:cbd3:0:b0:38e:bc95:5048 with SMTP id n19-20020a7bcbd3000000b0038ebc955048mr15670621wmi.203.1650366871034;
        Tue, 19 Apr 2022 04:14:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw31+3IeKIX4RGpI3eJ6i8AGhxWRNH1+xULyuevom6pT9dOS+6cHlxz7ntNmwSZdUUzV4rb2g==
X-Received: by 2002:a7b:cbd3:0:b0:38e:bc95:5048 with SMTP id n19-20020a7bcbd3000000b0038ebc955048mr15670582wmi.203.1650366870738;
        Tue, 19 Apr 2022 04:14:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id d5-20020a056000186500b0020a8688963bsm8956346wri.89.2022.04.19.04.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 04:14:30 -0700 (PDT)
Message-ID: <21003e7a-01e4-c751-dd41-fce4149d424c@redhat.com>
Date:   Tue, 19 Apr 2022 13:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, surenb@google.com, minchan@kernel.org,
        peterx@redhat.com, sfr@canb.auug.org.au, rcampbell@nvidia.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <87tuapk9n7.fsf@nvdebian.thelocal>
 <5a78dd68-343d-ac57-a698-2cfead8ee366@huawei.com>
 <72cfde7a-61d7-980c-4653-94ae83eb4257@redhat.com>
 <87pmldjxiq.fsf@nvdebian.thelocal>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
In-Reply-To: <87pmldjxiq.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.22 10:08, Alistair Popple wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 19.04.22 09:29, Miaohe Lin wrote:
>>> On 2022/4/19 11:51, Alistair Popple wrote:
>>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>>
>>>>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>>>>> page filled with random data is mapped into user address space. In case
>>>>> of error, a special swap entry indicating swap read fails is set to the
>>>>> page table. So the swapcache page can be freed and the user won't end up
>>>>> with a permanently mounted swap because a sector is bad. And if the page
>>>>> is accessed later, the user process will be killed so that corrupted data
>>>>> is never consumed. On the other hand, if the page is never accessed, the
>>>>> user won't even notice it.
>>>>
>>>> Hi Miaohe,
>>>>> It seems we're not actually using the pfn that gets stored in the special swap
>>>> entry here. Is my understanding correct? If so I think it would be better to use
>>>
>>> Yes, you're right. The pfn is not used now. What we need here is a special swap entry
>>> to do the right things. I think we can change to store some debugging information instead
>>> of pfn if needed in the future.
>>>
>>>> the new PTE markers Peter introduced[1] rather than adding another swap entry
>>>> type.
>>>
>>> IIUC, we should not reuse that swap entry here. From definition:
>>>
>>> PTE markers
>>> `========='
>>> ...
>>> PTE marker is a new type of swap entry that is ony applicable to file
>>> backed memories like shmem and hugetlbfs.  It's used to persist some
>>> pte-level information even if the original present ptes in pgtable are
>>> zapped.
>>>
>>> It's designed for file backed memories while swapin error entry is for anonymous
>>> memories. And there has some differences in processing. So it's not a good idea
>>> to reuse pte markers. Or am I miss something?
>>
>> I tend to agree. As raised in my other reply, maybe we can simply reuse
>> hwpoison entries and update the documentation of them accordingly.
> 
> Unless I've missed something I don't think PTE markers should be restricted
> solely to file backed memory. It's true that the only user of them at the moment
> is UFFD-WP for file backed memory, but PTE markers are just a special swap entry
> same as what is added here.

There is a difference.

What we want here is "there used to be something mapped but it's not
readable anymore. Please fail hard when userspace tries accessing
this.". Just like with hwpoison entries.

What a pte marker expresses is that "here is nothing mapped right now
but we have additional metadata available here. For file-backed memory,
it translates to: If we ever touch this page, lookup the pagecache what
to map here."

In the anonymous memory world, this would map to "populate the zeropage
or a fresh anonymous page on access." and keep the metadata around.

Yes, one might argue that for uffd-wp on anonymous memory it might make
sense to use pte marker as well, when no page has been populated yet.

IIRC, trying to arm uffd-wp when there is nothing populated yet will
simply get ignored.

> 
> That said I don't think there has been any attempt to make PTE markers work for
> anything other than UFFD-WP because it was unclear if there ever would be
> another user.

We discussed using it for softdirty tracking as well.

-- 
Thanks,

David / dhildenb

