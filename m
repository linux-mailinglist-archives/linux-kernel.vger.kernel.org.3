Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7ED57A2D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiGSPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGSPTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFFFE5005D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658243979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ffkQBPmo/sUddUmEl/R8M8xgmN4+H6cBTKR4B6ndbM=;
        b=WnwxUT91VUzJet3SgYxkt27F/Vhy/Teo2P0cehdyZcEq8qgIWtNWw9a3ecYQVA6kzB148i
        h2k111qxdxEbnalsP8BVPY1L2/QTBEROswJGsbGSZgetwnP23S8BZvEcmyXNd6fAjuNp23
        f7cqdTgdV50WbZKNVEu9YKPlWzmwV40=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-xe9RBe9ONWOvnF6k3ZB4FQ-1; Tue, 19 Jul 2022 11:19:37 -0400
X-MC-Unique: xe9RBe9ONWOvnF6k3ZB4FQ-1
Received: by mail-wm1-f72.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so5540189wmp.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=1ffkQBPmo/sUddUmEl/R8M8xgmN4+H6cBTKR4B6ndbM=;
        b=55r1wqmMZlxJFnOIr0G4vA+80wpLopxSL7dnIa8v93wN/NlynJsWU9IHIkF8dU/Kk7
         94ZlDb9qEiVLIZB/monSZXxrsNj1nczYATBclMtORGg4/b1Q6BuzfK6h4jRyZrj74Ldl
         2H/NwY4FmiqMHNEbBbx6fklER0/2qc3N/oJqDwQvapsyn43eO7FCkVVzLziED549YVLI
         WEt2EU0TNL4VxF185Hd2i9QgrJzULTHUcl95mGQtDrjU9JL6BImnYgjIwiUy7dGoxoJl
         CwT6SRwo/vodJlO82ZQr8AAh4LEiXuPzDu/fMHao/rpM/9JZ66HG+cCBgEz3TzK/AMrF
         7b5g==
X-Gm-Message-State: AJIora9FFlFwZcySkn+4frlC8rFmzxug/CY9mJr/x/+jmtTeUCSXHVwf
        AxFT1mjdIRHA9a4wBQmiRca2GYkws0BBEorbWUaNmfjKJpMCm38RH3Y8bk8gA9cSW8Mibrn8xvn
        NoIxKtC7LDezwMRMHv5ce/84y
X-Received: by 2002:a05:6000:1091:b0:21e:3d13:283d with SMTP id y17-20020a056000109100b0021e3d13283dmr2680769wrw.376.1658243975874;
        Tue, 19 Jul 2022 08:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1so2KooD7kFVghzCwyWiejBTqkj7PcU+kkY0dPiO2+kY+/Q5PrtJbLo80hi8goUOTPKutzPtA==
X-Received: by 2002:a05:6000:1091:b0:21e:3d13:283d with SMTP id y17-20020a056000109100b0021e3d13283dmr2680742wrw.376.1658243975526;
        Tue, 19 Jul 2022 08:19:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:600:7807:c947:bc5a:1aea? (p200300cbc70906007807c947bc5a1aea.dip0.t-ipconnect.de. [2003:cb:c709:600:7807:c947:bc5a:1aea])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600c150400b003a03185231bsm17643705wmg.31.2022.07.19.08.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 08:19:35 -0700 (PDT)
Message-ID: <6fa6b7aa-731e-891c-3efb-a03d6a700efa@redhat.com>
Date:   Tue, 19 Jul 2022 17:19:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org, vbabka@suse.cz,
        minchan@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
 <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
 <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
In-Reply-To: <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.22 16:54, Michal Hocko wrote:
> On Mon 18-07-22 19:28:13, Charan Teja Kalla wrote:
>> Thanks Michal for the comments!!
>>
>> On 7/18/2022 5:20 PM, Michal Hocko wrote:
>>>> The above mentioned race is just one example __but the problem persists
>>>> in the other paths too involving page_ext->flags access(eg:
>>>> page_is_idle())__. Since offline waits till the last reference on the
>>>> page goes down i.e. any path that took the refcount on the page can make
>>>> the memory offline operation to wait. Eg: In the migrate_pages()
>>>> operation, we do take the extra refcount on the pages that are under
>>>> migration and then we do copy page_owner by accessing page_ext. For
>>>>
>>>> Fix those paths where offline races with page_ext access by maintaining
>>>> synchronization with rcu lock.
>>> Please be much more specific about the synchronization. How does RCU
>>> actually synchronize the offlining and access? Higher level description
>>> of all the actors would be very helpful not only for the review but also
>>> for future readers.
>>
>> I will improve the commit message about this synchronization change
>> using RCU's.
> 
> Thanks! The most imporant part is how the exclusion is actual achieved
> because that is not really clear at first sight
> 
> CPU1					CPU2
> lookup_page_ext(PageA)			offlining
> 					  offline_page_ext
> 					    __free_page_ext(addrA)
> 					      get_entry(addrA)
> 					      ms->page_ext = NULL
> 					      synchronize_rcu()
> 					      free_page_ext
> 					        free_pages_exact (now addrA is unusable)
> 					
>   rcu_read_lock()
>   entryA = get_entry(addrA)
>     base + page_ext_size * index # an address not invalidated by the freeing path
>   do_something(entryA)
>   rcu_read_unlock()
> 
> CPU1 never checks ms->page_ext so it cannot bail out early when the
> thing is torn down. Or maybe I am missing something. I am not familiar
> with page_ext much.
> 
>>> Also, more specifically
>>> [...]
>>>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>>>> index 3dc715d..5ccd3ee 100644
>>>> --- a/mm/page_ext.c
>>>> +++ b/mm/page_ext.c
>>>> @@ -299,8 +299,9 @@ static void __free_page_ext(unsigned long pfn)
>>>>  	if (!ms || !ms->page_ext)
>>>>  		return;
>>>>  	base = get_entry(ms->page_ext, pfn);
>>>> -	free_page_ext(base);
>>>>  	ms->page_ext = NULL;
>>>> +	synchronize_rcu();
>>>> +	free_page_ext(base);
>>>>  }
>>> So you are imposing the RCU grace period for each page_ext! This can get
>>> really expensive. Have you tried to measure the effect?
> 
> I was wrong here! This is for each memory section which is not as
> terrible as every single page_ext. This can be still quite a lot memory
> sections in a single memory block (e.g. on ppc memory sections are
> ridiculously small).
> 
>> I didn't really measure the effect. Let me measure it and post these in V2.
> 
> I think it would be much more optimal to split the operation into 2
> phases. Invalidate all the page_ext metadata then synchronize_rcu and
> only then free them all. I am not very familiar with page_ext so I am
> not sure this is easy to be done. Maybe page_ext = NULL can be done in
> the first stage.
> 
>>> Is there any reason why page_ext is freed during offlining rather when
>>> it is hotremoved?
>>
>> This is something I am struggling to get the answer. IMO, this is even
>> wrong design where I don't have page_ext but page. Moving the freeing of
>> page_ext to hotremove path actually solves the problem but somehow this
>> idea didn't liked[1].  copying the excerpt here:
> 
> yes, it certainly adds subtlety to the page_ext thingy. I do agree that
> even situation around struct page is not all that great wrt
> synchronization. We have pfn_to_online_page which even when racy doesn't
> give you a garbage because hotremove happens very rarely or so long
> after offlining that the race window is essentially impractically too
> long for any potential damage. We would have to change a lot to make it
> work "properly". I am not optimistic this is actually feasible.
> 
>>> 3) Change the design where the page_ext is valid as long as the struct
>>> page is alive.
>>
>> :/ Doesn't spark joy."
> 
> I would be wondering why. It should only take to move the callback to
> happen at hotremove. So it shouldn't be very involved of a change. I can
> imagine somebody would be relying on releasing resources when offlining
> memory but is that really the case?

Various reasons:

1) There was a discussion in the past to eventually also use rcu
protection for handling pdn_to_online_page(). So doing it cleanly here
is certainly an improvement.

2) I really dislike having to scatter section online checks all over the
place in page ext code. Once there is a difference between active vs.
stale page ext data things get a bit messy and error prone. This is
already ugly enough in our generic memmap handling code IMHO.

3) Having on-demand allocations, such as KASAN or page ext from the
memory online notifier is at least currently cleaner, because we don't
have to handle each and every subsystem that hooks into that during the
core memory hotadd/remove phase, which primarily only setups the
vmemmap, direct map and memory block devices.


Personally, I think what we have in this patch is quite nice and clean.
But I won't object if it can be similarly done in a clean way from
hot(un)plug code.

That is, I ack this patch but don't object to similarly clean approaches.

-- 
Thanks,

David / dhildenb

