Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0877A4AB293
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 23:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344992AbiBFWJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 17:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344706AbiBFWIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 17:08:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C556DC061348
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 14:08:48 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id t9so7555790plg.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 14:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=aFsW4oJYjKeOMHpCwLOrqYmCPgdn3u/aN+st8V1n1k0=;
        b=Jo0cdlDv6uybOeKk7VmFcccPwrHxPCx063Hn0O/eWQL+Lm74kSuEzcyx6Hnn8K4jDj
         kkfoIXVF3bITg/OQmP/RJqDdkcaYo0HH2donmBy4aOSQ8uQONkF6b8AQNTUbfzyRBygl
         D6LEk9i56y1f4/hJC9zPSX8bsEjrLHhC9SLndqqAOs7xUM+fOGu/fTH2l12CFifXLKK7
         mrAJdsfZfc2TsA2iBYQNAVO+kXpDg6Zk0NnnisG08fQ4pwgTLyZFuqjj+Be1UUd8EUTA
         MTG8R/tjaJkQN4yrXwoK1oNMwwsvj7Ye13TrSrHvJDgIBHtEP8zV+KC228bK/LqTLHLq
         btbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=aFsW4oJYjKeOMHpCwLOrqYmCPgdn3u/aN+st8V1n1k0=;
        b=keJS0WNqNAnkzQXWUl1axLx3QeZud6pDtPseRYyzTyqDJwybp2POHgFOkzU/PIZpqG
         SoXYQIOviIJH/FKW9mrV+i9qEWUHWIGmx/TNmH6zG8H5WhMrx0hUofbAAnY/xjHHlcK5
         OwV7T905Or+uZcU0+QZroTO0FN+cHOmVjR7hRG9jmLLxIBbDQMsWw93KEjZkQFsuDXJK
         DHumsoi3AD9iFRhm6YJjt1XHpXnj91yh92fWuhRo8YXHhWFDuE57PDixVpgKUsi9m8k6
         FG4mpba5yHLHndUIH57Q/R2DDuaIIOORAoQFaVHFL8aKd/OSkbyBhk86Er5ZxV7Lo6aP
         DPWA==
X-Gm-Message-State: AOAM531ymChGCAwxYrDUzDZCbbPQH++oC82hm/aQJaYyK2A8WJZrGxg3
        fJ8c68fR4JbUtTchnNpszTB15sLYjdo33g==
X-Google-Smtp-Source: ABdhPJyPezlTdmbZLh2UjuPlM5QcVj8Q3m/Z+1MUjZLSlyhnXNwWB6QESyP0vCHlqrDH8V1tgs35eA==
X-Received: by 2002:a17:902:760e:: with SMTP id k14mr13433737pll.11.1644185327962;
        Sun, 06 Feb 2022 14:08:47 -0800 (PST)
Received: from [2620:15c:29:204:dae1:9bee:7b85:4b01] ([2620:15c:29:204:dae1:9bee:7b85:4b01])
        by smtp.gmail.com with ESMTPSA id j10sm9471267pfu.93.2022.02.06.14.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 14:08:47 -0800 (PST)
Date:   Sun, 6 Feb 2022 14:08:47 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Mel Gorman <mgorman@suse.de>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: vmscan: remove deadlock due to throttling failing
 to make progress
In-Reply-To: <20220203100326.GD3301@suse.de>
Message-ID: <ecbe4937-7750-325-c7fa-7df12f4c4554@google.com>
References: <20220203100326.GD3301@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022, Mel Gorman wrote:

> A soft lockup bug in kcompactd was reported in a private bugzilla with
> the following visible in dmesg;
> 
> [15980.045209][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 26s! [kcompactd0:479]
> [16008.044989][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 52s! [kcompactd0:479]
> [16036.044768][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 78s! [kcompactd0:479]
> [16064.044548][   C33] watchdog: BUG: soft lockup - CPU#33 stuck for 104s! [kcompactd0:479]
> 
> The machine had 256G of RAM with no swap and an earlier failed allocation
> indicated that node 0 where kcompactd was run was potentially
> unreclaimable;
> 
> Node 0 active_anon:29355112kB inactive_anon:2913528kB active_file:0kB
>   inactive_file:0kB unevictable:64kB isolated(anon):0kB isolated(file):0kB
>   mapped:8kB dirty:0kB writeback:0kB shmem:26780kB shmem_thp:
>   0kB shmem_pmdmapped: 0kB anon_thp: 23480320kB writeback_tmp:0kB
>   kernel_stack:2272kB pagetables:24500kB all_unreclaimable? yes
> 
> Vlastimil Babka investigated a crash dump and found that a task migrating pages
> was trying to drain PCP lists;
> 
> PID: 52922  TASK: ffff969f820e5000  CPU: 19  COMMAND: "kworker/u128:3"
>  #0 [ffffaf4e4f4c3848] __schedule at ffffffffb840116d
>  #1 [ffffaf4e4f4c3908] schedule at ffffffffb8401e81
>  #2 [ffffaf4e4f4c3918] schedule_timeout at ffffffffb84066e8
>  #3 [ffffaf4e4f4c3990] wait_for_completion at ffffffffb8403072
>  #4 [ffffaf4e4f4c39d0] __flush_work at ffffffffb7ac3e4d
>  #5 [ffffaf4e4f4c3a48] __drain_all_pages at ffffffffb7cb707c
>  #6 [ffffaf4e4f4c3a80] __alloc_pages_slowpath.constprop.114 at ffffffffb7cbd9dd
>  #7 [ffffaf4e4f4c3b60] __alloc_pages at ffffffffb7cbe4f5
>  #8 [ffffaf4e4f4c3bc0] alloc_migration_target at ffffffffb7cf329c
>  #9 [ffffaf4e4f4c3bf0] migrate_pages at ffffffffb7cf6d15
>  10 [ffffaf4e4f4c3cb0] migrate_to_node at ffffffffb7cdb5aa
>  11 [ffffaf4e4f4c3da8] do_migrate_pages at ffffffffb7cdcf26
>  12 [ffffaf4e4f4c3e88] cpuset_migrate_mm_workfn at ffffffffb7b859d2
>  13 [ffffaf4e4f4c3e98] process_one_work at ffffffffb7ac45f3
>  14 [ffffaf4e4f4c3ed8] worker_thread at ffffffffb7ac47fd
>  15 [ffffaf4e4f4c3f10] kthread at ffffffffb7acbdc6
>  16 [ffffaf4e4f4c3f50] ret_from_fork at ffffffffb7a047e2
> 
> The root of the problem is that kcompact0 is not rescheduling on a CPU
> while a task that has isolated a large number of the pages from the
> LRU is waiting on kcompact0 to reschedule so the pages can be released.
> While shrink_inactive_list() only loops once around too_many_isolated,
> reclaim can continue without rescheduling if sc->skipped_deactivate ==
> 1 which could happen if there was no file LRU and the inactive anon list
> was not low.
> 
> Debugged-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Mel Gorman <mgorman@suse.de>

Acked-by: David Rientjes <rientjes@google.com>
