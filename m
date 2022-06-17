Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009CD54F92D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382589AbiFQO3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiFQO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00EEF4B1FF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655476164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAYVwqMN/CZe6fC+f9RsMLvHlUb8Q6jQz2uIGknDWoM=;
        b=SEwtLNpdrXbYew4TN+GBpOmDx75UUbxosmWArGQWfYZ3mipQdaxQP05cqihZ9bPXTiwRKC
        pJ/OzLo3iU1GJnzEWHNBHRwl30nAkDZdEx3JWIGuUkKMoAlNMHMkGAgbLF5pFfT9edVNUv
        MgVe1aaBP5/XbOF4cgMYSxi2iq8eEAI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-wjrKsoReO4ibwa5joUp36A-1; Fri, 17 Jun 2022 10:29:21 -0400
X-MC-Unique: wjrKsoReO4ibwa5joUp36A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 124AB2932481;
        Fri, 17 Jun 2022 14:29:21 +0000 (UTC)
Received: from [10.22.18.98] (unknown [10.22.18.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E8762026609;
        Fri, 17 Jun 2022 14:29:20 +0000 (UTC)
Message-ID: <b92bdb56-bfed-9cd2-5eb2-0b96a68b21d8@redhat.com>
Date:   Fri, 17 Jun 2022 10:29:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Lockups due to "locking/rwsem: Make handoff bit handling more
 consistent"
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Zhenhua Ma <mazhenhua@xiaomi.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20220617134325.GC30825@techsingularity.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220617134325.GC30825@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 09:43, Mel Gorman wrote:
> Hi Waiman,
>
> I've received reports of lockups happening in kernels including
> commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
> consistent"). The exact symptoms vary but usually it's either a soft lockup
> (older kernel with a backport), the task hanging and never exiting or the
> machine becomes generally unresponsive and ssh is broken.  The problem
> started in 5.16 and reliably bisected to commit d257cc8cb8d5. Reverting
> the patch in 5.16, 5.17 and 5.18 finish the test successfully but I didn't
> test a revert on 5.19-rc2 because of other changes layered on top.
>
> The reproducer is simple -- start pairs of CPU hogs pinned to a CPU with
> different SCHED_RR priorities that run for a few seconds. It does not
> hit every time but usually happens within 10 attempts. On 5.16 at least,
> the tasks failed to exit and kept retrying to exit using the following path
>
> [<0>] rwsem_down_write_slowpath+0x2ad/0x580
> [<0>] unlink_file_vma+0x2c/0x50
> [<0>] free_pgtables+0xbe/0x110
> [<0>] exit_mmap+0xc1/0x220
> [<0>] mmput+0x52/0x110
> [<0>] do_exit+0x2ec/0xb00
> [<0>] do_group_exit+0x2d/0x90
> [<0>] get_signal+0xb6/0x920
> [<0>] arch_do_signal_or_restart+0xba/0x700
> [<0>] exit_to_user_mode_prepare+0xb7/0x230
> [<0>] irqentry_exit_to_user_mode+0x5/0x20
> [<0>] asm_sysvec_apic_timer_interrupt+0x12/0x20
> [<0>] preempt_schedule_thunk+0x16/0x18
> [<0>] rwsem_down_write_slowpath+0x2ad/0x580
> [<0>] unlink_file_vma+0x2c/0x50
> [<0>] free_pgtables+0xbe/0x110
> [<0>] exit_mmap+0xc1/0x220
> [<0>] mmput+0x52/0x110
> [<0>] do_exit+0x2ec/0xb00
> [<0>] do_group_exit+0x2d/0x90
> [<0>] get_signal+0xb6/0x920
> [<0>] arch_do_signal_or_restart+0xba/0x700
> [<0>] exit_to_user_mode_prepare+0xb7/0x230
> [<0>] irqentry_exit_to_user_mode+0x5/0x20
> [<0>] asm_sysvec_apic_timer_interrupt+0x12/0x20
>
> The C file and shell script to run it are attached.
>
Thanks for the reproducer and I will try to reproduce it locally.

It is a known issue that I have receive similar report from an Oracle 
engineer. That is the reason I posted commit 1ee326196c66 
("locking/rwsem: Always try to wake waiters in out_nolock path") that 
was merged in v5.19. I believe it helps but it may not be able to 
eliminate all possible race conditions. To make rwsem behave more like 
before commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling 
more consistent"), I posted a follow-up patch

https://lore.kernel.org/lkml/20220427173124.1428050-1-longman@redhat.com/

But it hasn't gotten review yet.

I will try your reproducer to see if these patches are able to address 
the lockup problem.

Thanks,
Longman

commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
consistent").

