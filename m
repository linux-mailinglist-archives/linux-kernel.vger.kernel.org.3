Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249BE58665E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiHAIay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiHAIav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45F3813F0A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659342649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5SVYDNCbGfXDgjbhPnDxlhZIe7nXKFMtGTA2pRBTKME=;
        b=hhftLPFr3xsYPmO0D9UO5mYgc43bMNsvoCJgDJL5dHVdvm2JVkjWjMFp2yEb2fQtoXfapJ
        VTP8Fs51DDJ0TFToyf0WC8uh44GqWmE1sFcWljSaT6DtbvwSVIMCwkK7rqyH1JF+4Dg6zV
        PiCbiXneFyQjjVvbvCfJIA3brYK7SFE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-msshHn_zPda7PZbH9_mD7g-1; Mon, 01 Aug 2022 04:30:48 -0400
X-MC-Unique: msshHn_zPda7PZbH9_mD7g-1
Received: by mail-wm1-f69.google.com with SMTP id p2-20020a05600c1d8200b003a3262d9c51so7796053wms.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 01:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=5SVYDNCbGfXDgjbhPnDxlhZIe7nXKFMtGTA2pRBTKME=;
        b=kizkszynzGxfOa0rGK4UbY72QvJXLuSGEN8GgJZoLbdfFVoFT4cpv9vxTpTvu9iSpH
         j1y+SMf40iW34hgnw524Q0E3w1yXGG8LS1BOeAPVAh2mxiDT+VYu9M06aExqU6yzeScN
         Al42E1wK5z8Svp6GRKZy0H7+nd6RNsxJTHIFNzCJ1Sl8b0Rt+1pRK5YBeEdS2IwrY76r
         NPmRbe+mjIIv+NQUSEFTgZWDowP7lHLqFQsWWbnCeIyTejzrIMIPMDs1/EuIwn0jJGM1
         b17L6BkWNFr63DUyO8s1ChGq6xvghkKpFiRQpn3SMTQvCP3mdjHK/lcMNoH1nx+ZTfTZ
         I2gQ==
X-Gm-Message-State: ACgBeo1w0WnVJM0e4U+Zsz/HLfLOI5Wd08dFiREZAbqAVFQXUDKhQ/o3
        pNZYr4pmk1Uq0uvt48Y0p96tEzBc11SOKBmn92YkPHSKcZ2H6YNn2aT10eQORugET0QYZ1gX5gX
        ov0YOj8GJDrhsaqD5xCsIU9fE
X-Received: by 2002:a05:6000:178f:b0:21e:98ee:f1e6 with SMTP id e15-20020a056000178f00b0021e98eef1e6mr9475777wrg.405.1659342647074;
        Mon, 01 Aug 2022 01:30:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6qu7G6pTzZeQnCXr8qYDHyx221WdF+lE+hgTXRyolp+O873cegrvd4YSD4rUluGmRhJjjnXA==
X-Received: by 2002:a05:6000:178f:b0:21e:98ee:f1e6 with SMTP id e15-20020a056000178f00b0021e98eef1e6mr9475750wrg.405.1659342646720;
        Mon, 01 Aug 2022 01:30:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6900:6d08:8df1:dd2c:bf00? (p200300cbc70469006d088df1dd2cbf00.dip0.t-ipconnect.de. [2003:cb:c704:6900:6d08:8df1:dd2c:bf00])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm11208492wrv.11.2022.08.01.01.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 01:30:46 -0700 (PDT)
Message-ID: <3fc8a61b-ad70-8092-9197-4920e0897593@redhat.com>
Date:   Mon, 1 Aug 2022 10:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, quic_pkondeti@quicinc.com,
        pasha.tatashin@soleen.com, sjpark@amazon.de, sieberf@amazon.com,
        shakeelb@google.com, dhowells@redhat.com, willy@infradead.org,
        liuting.0x7c00@bytedance.com, minchan@kernel.org,
        Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
 <6168cf49-bf75-2ebb-ab55-30de473835e3@redhat.com>
 <a26ce299-aed1-b8ad-711e-a49e82bdd180@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a26ce299-aed1-b8ad-711e-a49e82bdd180@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.22 11:53, Charan Teja Kalla wrote:
> Thanks David for the inputs!!
> 
> On 7/27/2022 10:59 PM, David Hildenbrand wrote:
>>> Fix those paths where offline races with page_ext access by maintaining
>>> synchronization with rcu lock and is achieved in 3 steps:
>>> 1) Invalidate all the page_ext's of the sections of a memory block by
>>> storing a flag in the LSB of mem_section->page_ext.
>>>
>>> 2) Wait till all the existing readers to finish working with the
>>> ->page_ext's with synchronize_rcu(). Any parallel process that starts
>>> after this call will not get page_ext, through lookup_page_ext(), for
>>> the block parallel offline operation is being performed.
>>>
>>> 3) Now safely free all sections ->page_ext's of the block on which
>>> offline operation is being performed.
>>>
>>> Thanks to David Hildenbrand for his views/suggestions on the initial
>>> discussion[1] and Pavan kondeti for various inputs on this patch.
>>>
>>> FAQ's:
>>> Q) Should page_ext_[get|put]() needs to be used for every page_ext
>>> access?
>>> A) NO, the synchronization is really not needed in all the paths of
>>> accessing page_ext. One case is where extra refcount is taken on a
>>> page for which memory block, this pages falls into, offline operation is
>>> being performed. This extra refcount makes the offline operation not to
>>> succeed hence the freeing of page_ext.  Another case is where the page
>>> is already being freed and we do reset its page_owner.
>>>
>>> Some examples where the rcu_lock is not taken while accessing the
>>> page_ext are:
>>> 1) In migration (where we also migrate the page_owner information), we
>>> take the extra refcount on the source and destination pages and then
>>> start the migration. This extra refcount makes the test_pages_isolated()
>>> function to fail thus retry the offline operation.
>>>
>>> 2) In free_pages_prepare(), we do reset the page_owner(through page_ext)
>>> which again doesn't need the protection to access because the page is
>>> already freeing (through only one path).
>>>
>>> So, users need not to use page_ext_[get|put]() when they are sure that
>>> extra refcount is taken on a page preventing the offline operation.
>>>
>>> Q) Why can't the page_ext is freed in the hot_remove path, where memmap
>>> is also freed ?
>>>
>>> A) As per David's answers, there are many reasons and a few are:
>>> 1) Discussions had happened in the past to eventually also use rcu
>>> protection for handling pfn_to_online_page(). So doing it cleanly here
>>> is certainly an improvement.
>>>
>>> 2) It's not good having to scatter section online checks all over the
>>> place in page ext code. Once there is a difference between active vs.
>>> stale page ext data things get a bit messy and error prone. This is
>>> already ugly enough in our generic memmap handling code.
>>>
>>> 3) Having on-demand allocations, such as KASAN or page ext from the
>>> memory online notifier is at least currently cleaner, because we don't
>>> have to handle each and every subsystem that hooks into that during the
>>> core memory hotadd/remove phase, which primarily only setups the
>>> vmemmap, direct map and memory block devices.
>>>
>>> [1] https://lore.kernel.org/linux-mm/59edde13-4167-8550-86f0-11fc67882107@quicinc.com/
>>>
>> I guess if we care about the synchronize_rcu() we could go crazy with
>> temporary allocations for data-to-free + call_rcu().
> 
> IMO, single synchronize_rcu() call overhead shouldn't be cared
> especially if the memory offline operation it self is expected to
> complete in seconds. On the Snapdragon system, I can see the lowest it
> can complete in 3-4secs for a complete memory block of size 512M. And
> agree that this time depends on lot of other factors too but wanted to
> raise a point that it is really not a path where tiny optimizations
> should be strictly considered. __Please help in correcting me If I am
> really downplaying the scenario here__.

I agree that we should optimize only if we find this to be an issue.

> 
> But then I moved to single synchronize_rcu() just to avoid any visible
> effects that can cause by multiple synchronize_rcu() for a single memory
> block with lot of sections.

Makes sense.

> 
> Having said that, I am open to go for call_rcu() and infact it will be a
> much simple change where I can do the freeing of page_ext in the
> __free_page_ext() itself which is called for every section there by
> avoid the extra tracking flag PAGE_EXT_INVALID.
>       ...........
>         WRITE_ONCE(ms->page_ext, NULL);
> 	call_rcu(rcu_head, fun); // Free in fun()
>        .............
> 
> Or your opinion is to use call_rcu () only once in place of
> synchronize_rcu() after invalidating all the page_ext's of memory block?


Yeah, that would be an option. And if you fail to allocate a temporary
buffer to hold the data-to-free (structure containing rcu_head), the
slower fallback path would be synchronize_rcu().

But again, I'm also not sure if we have to optimize here right now.


-- 
Thanks,

David / dhildenb

