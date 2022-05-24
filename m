Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D758533283
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbiEXUih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiEXUie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:38:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC1D6C571
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:38:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B32D01F8C4;
        Tue, 24 May 2022 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653424710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axk63yz+qUhcRJi6Yd8PYozsr5heAxMREUYpIa7UBSQ=;
        b=n6m/hQ39agXJkyBDMPqaqYDPbNKtIS0FZ9xr4EidYMoQ2+aaMaNCEiFtHbwBApiDu1H+jm
        t5+JybvXb9HhvmMZKYWW422r0/TRrFvSdA2CemTGgh0no/fKLsfrsH/Oq68CxltyNkOiUN
        YAyJzMCKSF/HEMG0IIH6M5ogtPWCC+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653424710;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axk63yz+qUhcRJi6Yd8PYozsr5heAxMREUYpIa7UBSQ=;
        b=rHiJgglZIp18X/I/sIEU8OeG8CgIOg8Ex/cgDlIpn4x0xrtnlZpxFuuw7DQyQcm95FlJfz
        6UnXdIXVer+A5eDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E1E913ADF;
        Tue, 24 May 2022 20:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qpQCHkZCjWIENAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 24 May 2022 20:38:30 +0000
Message-ID: <1a0a859b-1f25-5136-bb86-9efe68aabbb8@suse.cz>
Date:   Tue, 24 May 2022 22:37:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Memory allocation on speculative fastpaths
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Michel Lespinasse <walken.cr@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
 <YnFSfc8BR8CadOtw@dhcp22.suse.cz>
 <20220503163905.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnF0RyBaBSC1mdKo@casper.infradead.org>
 <CAJuCfpG8mBCV8O=FWwTJj8zfoh68fH9kBraMEjxKUvCyEw2MFw@mail.gmail.com>
 <YnKocgiWrupyFki3@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YnKocgiWrupyFki3@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/22 18:23, Johannes Weiner wrote:
> On Tue, May 03, 2022 at 04:15:46PM -0700, Suren Baghdasaryan wrote:
>> On Tue, May 3, 2022 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> On Tue, May 03, 2022 at 09:39:05AM -0700, Paul E. McKenney wrote:
>>>> On Tue, May 03, 2022 at 06:04:13PM +0200, Michal Hocko wrote:
>>>>> On Tue 03-05-22 08:59:13, Paul E. McKenney wrote:
>>>>>> Hello!
>>>>>>
>>>>>> Just following up from off-list discussions yesterday.
>>>>>>
>>>>>> The requirements to allocate on an RCU-protected speculative fastpath
>>>>>> seem to be as follows:
>>>>>>
>>>>>> 1.        Never sleep.
>>>>>> 2.        Never reclaim.
>>>>>> 3.        Leave emergency pools alone.
>>>>>>
>>>>>> Any others?
>>>>>>
>>>>>> If those rules suffice, and if my understanding of the GFP flags is
>>>>>> correct (ha!!!), then the following GFP flags should cover this:
>>>>>>
>>>>>>   __GFP_NOMEMALLOC | __GFP_NOWARN
>>>>>
>>>>> GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN
>>>>
>>>> Ah, good point on GFP_NOWAIT, thank you!
>>>
>>> Johannes (I think it was?) made the point to me that if we have another
>>> task very slowly freeing memory, a task in this path can take advantage
>>> of that other task's hard work and never go into reclaim.  So the
>>> approach we should take is:
> 
> Right, GFP_NOWAIT can starve out other allocations. It can clear out
> the freelists without the burden of having to do reclaim like
> everybody else wanting memory during a shortage. Including GFP_KERNEL.

FTR, I wonder if this is really true, given the suggested fallback. With
GFP_NOWAIT, you can either see memory (in all applicable zones) as

a) above low_watermark, just go ahead and allocate, as GFP_KERNEL would
b) between min and low watermark, wake up kswapd and allocate, as
GFP_KERNEL would
c) below min watermark, the most interesting. GFP_KERNEL fallbacks to
reclaim. If the GFP_NOWAIT path's fallback also includes reclaim, as
suggested in this thread, how is it really different from GFP_KERNEL?

So am I missing something or is GFP_NOWAIT fastpath with an immediate
fallback that includes reclaim (and not just a retry loop) fundamentally
not different from GFP_KERNEL, regardless of how often we attempt it?

> In smaller doses and/or for privileged purposes (e.g. single-argument
> kfree_rcu ;)), those allocations are fine. But because the context is
> page tables specifically, it would mean that userspace could trigger a
> large number of those and DOS other applications and the kernel.
> 
>>> p4d_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
>>> pud_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
>>> pmd_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
>>>
>>> if (failure) {
>>>   rcu_read_unlock();
>>>   do_reclaim();
>>>   return FAULT_FLAG_RETRY;
>>> }
>>>
>>> ... but all this is now moot since the approach we agreed to yesterday
>>> is:
>>
>> I think the discussion was about the above approach and Johannes
>> suggested to fallback to the normal pagefault handling with mmap_lock
>> locked if PMD does not exist. Please correct me if I misunderstood
>> here.
> 
> Yeah. Either way works, as long as the task is held accountable.
> 

