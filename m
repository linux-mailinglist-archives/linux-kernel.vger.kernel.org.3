Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B772D52FFC4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 00:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347344AbiEUWTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 18:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347080AbiEUWTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 18:19:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE414EF60
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 15:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE233B8013C
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 22:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FBCC385A9;
        Sat, 21 May 2022 22:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653171566;
        bh=ngKViRklTPe3qp0sAQn1sxccZmlTT0C88H2AvrRNxUo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L4efQY4wXKZ8fdSNY/3SLLvQHMVzrVR7J+HE4uOULF4ZB3pYnzzQpy60rtACo9wdm
         2gqoFPuV2LKMa49z77cF3A8Jq+GIucTFmb9GuLTiyKd2WRwgG3YPnbxVC74I0cQSy0
         UR0O12vuW+cGohFhTy65ov3l17Y3+XYr5PWH0nozTIaSRnoiTb92VPubAYXoqOXh1K
         494I9lkz40huR8XXobXAbMtAK+pkgWWk9WnR2pU/9Zr+DxWEgNRFgz2qmqpTH5tdyD
         ei0SjP+3jNjjDT5ektRqNchgieZjzyrUvDxPFZiFA/2P+YCEx0FJxKXKWABf3qxl7u
         ED/uCgM1KwRcA==
Message-ID: <64d0da08-6ffd-4bce-bc66-5097913937b4@kernel.org>
Date:   Sat, 21 May 2022 15:19:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 0/6] Introduce Copy-On-Write to Page Table
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Chih-En Lin <shiyn.lin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <d1810538-9b4c-7f19-852f-7f6d255533c7@redhat.com>
 <YolHr1GwfA++i9jj@casper.infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <YolHr1GwfA++i9jj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/22 13:12, Matthew Wilcox wrote:
> On Sat, May 21, 2022 at 06:07:27PM +0200, David Hildenbrand wrote:
>> I'm missing the most important point: why do we care and why should we
>> care to make our COW/fork implementation even more complicated?
>>
>> Yes, we might save some page tables and we might reduce the fork() time,
>> however, which specific workload really benefits from this and why do we
>> really care about that workload? Without even hearing about an example
>> user in this cover letter (unless I missed it), I naturally wonder about
>> relevance in practice.
> 
> As I get older (and crankier), I get less convinced that fork() is
> really the right solution for implementing system().  I feel that a
> better model is to create a process with zero threads, but have an fd
> to it.  Then manipulate the child process through its fd (eg mmap
> ld.so, open new fds in that process's fdtable, etc).  Closing the fd
> launches a new thread in the process (ensuring nobody has an fd to a
> running process, particularly one which is setuid).

Heh, I learned serious programming on Windows, and I thought fork() was 
entertaining, cool, and a bad idea when I first learned about it.  (I 
admit I did think the fact that POSIX fork and exec had many fewer 
arguments than CreateProcess was a good thing.)  Don't even get me 
started on setuid -- if I had my way, distros would set NO_NEW_PRIVS on 
boot for the entire system.

I can see a rather different use for this type of shared-pagetable 
technology, though: monstrous MAP_SHARED mappings.  For database and 
some VM users, multiple processes will map the same file.  If there was 
a way to ensure appropriate alignment (or at least encourage it) and a 
way to handle mappings that don't cover the whole file, then having 
multiple mappings share the same page tables could be a decent 
efficiently gain.  This doesn't even need COW -- it's "just" pagetable 
sharing.

It's probably a pipe dream, but I like to imagine that the bookkeeping 
that would enable this would also enable a much less ad-hoc concept of 
who owns which pagetable page.  Then things like x86's KPTI LDT mappings 
would be less disgusting under the hood.

Android would probably like a similar feature for MAP_ANONYMOUS or that 
could otherwise enable Zygote to share paging structures (ideally 
without fork(), although that's my dream, not necessarily Android's). 
This is more complex, since COW is involved.  Also possibly less 
valuable -- possibly the entire benefit and then some would be achieved 
by using huge pages for Zygote and arranging for CoWing one normal-size 
page out of a hugepage COW mapping to only COW the one page.

--Andy
