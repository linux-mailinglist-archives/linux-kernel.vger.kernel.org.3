Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BFE4D73FA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 10:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiCMJaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 05:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiCMJaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 05:30:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F35B24BF4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 01:29:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15A9A212C6;
        Sun, 13 Mar 2022 09:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647163744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TxRoN/SCo8JBsxnAVBwFFNncl4nnOM9zqtVpxRJ+AkY=;
        b=m4/NQSkf5EBTTx9DYFtPAAJeAPwa0EeTYfEpr/ZlWdrPtPwKiAozTkeUD3syqHhrAgqDrL
        sOwtMAam3t4Wtn6NGL0w5IJpvWsqSY3LtYZitYlR962Frv9ZEeEZLh26zs2oxvVOX6P2eS
        Eoxahk+LuCfB8i2JOr98rL3Rgku/o8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647163744;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TxRoN/SCo8JBsxnAVBwFFNncl4nnOM9zqtVpxRJ+AkY=;
        b=FQpqtizeDTZR7QfMWy6elHdtC3qMrTsqJytXvSTmp1iKPu2tI6rmmQSmMX591AFQimVNYd
        Et5i0cm9DsayA5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B288F13A96;
        Sun, 13 Mar 2022 09:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7aQLKl+5LWL0BwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sun, 13 Mar 2022 09:29:03 +0000
Message-ID: <8f499c76-68cb-a2c3-01fd-c8759e2fd317@suse.cz>
Date:   Sun, 13 Mar 2022 10:28:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [mm/page_alloc] 8212a964ee: vm-scalability.throughput 30.5%
 improvement
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        0day robot <lkp@intel.com>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
References: <20220312154321.GC1189@xsang-OptiPlex-9020>
 <15307f8a-c202-75d8-1361-dae0146df734@suse.cz>
 <CANn89i+fM0k+=Qw0M0fso1f-Ya8--5+==gtcWqCpo=Gu-ca1Ow@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CANn89i+fM0k+=Qw0M0fso1f-Ya8--5+==gtcWqCpo=Gu-ca1Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/22 00:26, Eric Dumazet wrote:
> On Sat, Mar 12, 2022 at 10:59 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 3/12/22 16:43, kernel test robot wrote:
>>>
>>>
>>> Greeting,
>>>
>>> FYI, we noticed a 30.5% improvement of vm-scalability.throughput due to commit:
>>>
>>>
>>> commit: 8212a964ee020471104e34dce7029dec33c218a9 ("Re: [PATCH v2] mm/page_alloc: call check_new_pages() while zone spinlock is not held")
>>> url: https://github.com/0day-ci/linux/commits/Mel-Gorman/Re-PATCH-v2-mm-page_alloc-call-check_new_pages-while-zone-spinlock-is-not-held/20220309-203504
>>> patch link: https://lore.kernel.org/lkml/20220309123245.GI15701@techsingularity.net
>>
>> Heh, that's weird. I would expect some improvement from Eric's patch,
>> but this seems to be actually about Mel's "mm/page_alloc: check
>> high-order pages for corruption during PCP operations" applied directly
>> on 5.17-rc7 per the github url above. This was rather expected to make
>> performance worse if anything, so maybe the improvement is due to some
>> unexpected side-effect of different inlining decisions or cache alignment...
>>
> 
> I doubt this has anything to do with inlining or cache alignment.
> 
> I am not familiar with the benchmark, but its name
> (anon-w-rand-hugetlb) hints at hugetlb ?
> 
> After Mel fix, we go over 512 'struct page' to perform sanity checks,
> thus loading into cpu caches the 512 cache lines.

Ah, that's true.

> This caching is done while no lock is held.

But I don't think this is. The test was AFAICS done without your patch,
so the lock is still held in rmqueue(). And it's also held in
rmqueue_bulk() -> check_pcp_refill().

> If after this huge page allocation some mm operation needs to access
> these 512 struct pages,
> while holding a lock, then sure, there is a huge gain.

