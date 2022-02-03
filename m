Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9A44A8C00
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353620AbiBCSzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:55:19 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51954 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiBCSzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:55:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F02821136;
        Thu,  3 Feb 2022 18:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643914517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+zZ5QPQnn/PzBqqi/3+iDyk+WbF7qUGCzewb/ZOF+E=;
        b=DQvbzdAEC7l89QmuI/HKHmz/v3YSQSdHYd6aglas8c704+e0RFCg7AIuFz59wFAe32YA1o
        ZcbhCCpbyikEV9pkejCHflTDgMVVgRidDe/WzOVJd6kdmgzVdofo0bZBDbwcc1BxtiRAI3
        9dqFyBG/k90XpjRxen2VhAFOFdpN2Ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643914517;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+zZ5QPQnn/PzBqqi/3+iDyk+WbF7qUGCzewb/ZOF+E=;
        b=NF7OnzrwsYmd9pNrszcm3zFnJAI9WKrybhaOrQxHiWTTEyE38W4M0odtux42AkH4DBWYKP
        rKwyQBZLrKKGSHBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C988139FE;
        Thu,  3 Feb 2022 18:55:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sv+bHRUl/GHpZQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Feb 2022 18:55:17 +0000
Message-ID: <78c631c3-d316-b77c-0e24-e08d5214710d@suse.cz>
Date:   Thu, 3 Feb 2022 19:55:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] mm: vmscan: remove deadlock due to throttling failing to
 make progress
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220203100326.GD3301@suse.de>
 <2472c281-436c-d5f5-61d8-e5192e912ff1@suse.cz>
In-Reply-To: <2472c281-436c-d5f5-61d8-e5192e912ff1@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 19:53, Vlastimil Babka wrote:
> On 2/3/22 11:03, Mel Gorman wrote:
>> A soft lockup bug in kcompactd was reported in a private bugzilla with
>> the following visible in dmesg;
>> 
>> [15980.045209][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 26s! [kcompactd0:479]
>> [16008.044989][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 52s! [kcompactd0:479]
>> [16036.044768][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 78s! [kcompactd0:479]
>> [16064.044548][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 104s! [kcompactd0:479]
>> 
>> The machine had 256G of RAM with no swap and an earlier failed allocation
>> indicated that node 0 where kcompactd was run was potentially
>> unreclaimable;
>> 
>> Node 0 active_anon:29355112kB inactive_anon:2913528kB active_file:0kB
>>   inactive_file:0kB unevictable:64kB isolated(anon):0kB isolated(file):0kB
>>   mapped:8kB dirty:0kB writeback:0kB shmem:26780kB shmem_thp:
>>   0kB shmem_pmdmapped: 0kB anon_thp: 23480320kB writeback_tmp:0kB
>>   kernel_stack:2272kB pagetables:24500kB all_unreclaimable? yes
>> 
>> Vlastimil Babka investigated a crash dump and found that a task migrating pages
>> was trying to drain PCP lists;
>> 
>> PID: 52922  TASK: ffff969f820e5000  CPU: 19  COMMAND: "kworker/u128:3"
>>  #0 [ffffaf4e4f4c3848] __schedule at ffffffffb840116d
>>  #1 [ffffaf4e4f4c3908] schedule at ffffffffb8401e81
>>  #2 [ffffaf4e4f4c3918] schedule_timeout at ffffffffb84066e8
>>  #3 [ffffaf4e4f4c3990] wait_for_completion at ffffffffb8403072
>>  #4 [ffffaf4e4f4c39d0] __flush_work at ffffffffb7ac3e4d
>>  #5 [ffffaf4e4f4c3a48] __drain_all_pages at ffffffffb7cb707c
>>  #6 [ffffaf4e4f4c3a80] __alloc_pages_slowpath.constprop.114 at ffffffffb7cbd9dd
>>  #7 [ffffaf4e4f4c3b60] __alloc_pages at ffffffffb7cbe4f5
>>  #8 [ffffaf4e4f4c3bc0] alloc_migration_target at ffffffffb7cf329c
>>  #9 [ffffaf4e4f4c3bf0] migrate_pages at ffffffffb7cf6d15
>>  10 [ffffaf4e4f4c3cb0] migrate_to_node at ffffffffb7cdb5aa
>>  11 [ffffaf4e4f4c3da8] do_migrate_pages at ffffffffb7cdcf26
>>  12 [ffffaf4e4f4c3e88] cpuset_migrate_mm_workfn at ffffffffb7b859d2
>>  13 [ffffaf4e4f4c3e98] process_one_work at ffffffffb7ac45f3
>>  14 [ffffaf4e4f4c3ed8] worker_thread at ffffffffb7ac47fd
>>  15 [ffffaf4e4f4c3f10] kthread at ffffffffb7acbdc6
>>  16 [ffffaf4e4f4c3f50] ret_from_fork at ffffffffb7a047e2
>> 
>> The root of the problem is that kcompact0 is not rescheduling on a CPU
>> while a task that has isolated a large number of the pages from the
>> LRU is waiting on kcompact0 to reschedule so the pages can be released.
>> While shrink_inactive_list() only loops once around too_many_isolated,
>> reclaim can continue without rescheduling if sc->skipped_deactivate ==
>> 1 which could happen if there was no file LRU and the inactive anon list
>> was not low.
>> 
>> Debugged-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Mel Gorman <mgorman@suse.de>
> 
> Fixes: d818fca1cac3 ("mm/vmscan: throttle reclaim and compaction when too
> may pages are isolated")

And Cc: stable for 5.16.y sake

> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


