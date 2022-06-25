Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0035555A609
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 04:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiFYCXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 22:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiFYCXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 22:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 098D92ED61
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 19:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656123809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCWKjmH3S606alzAuT30BfDYuE+xUjQ3Ss4cIJMJC04=;
        b=DKQA2fU+bl8hiiFCY6LH6z7O/ACKkKfvLNsgKvDxqY3ZGuhdgUZGfiMU7qg4LSo0PKjpLf
        2TeKeKgnCoScWXGO7AgO8k5ar43cuEA4jf0E7XbPIJ2itCOCDiLQbTAJFUC+ExkNMHGG2U
        QBRV1rcSMYvyrG2Mq9/OCbIUL83KD8E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-5-KqqrD0O9OjxJXyysP5UQ-1; Fri, 24 Jun 2022 22:23:25 -0400
X-MC-Unique: 5-KqqrD0O9OjxJXyysP5UQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F1048F40C5;
        Sat, 25 Jun 2022 02:23:25 +0000 (UTC)
Received: from [10.22.8.37] (unknown [10.22.8.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 663E81121314;
        Sat, 25 Jun 2022 02:23:24 +0000 (UTC)
Message-ID: <f2cbe809-4337-bf9b-d003-7e47ff893248@redhat.com>
Date:   Fri, 24 Jun 2022 22:23:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] locking/rtmutex: Limit # of lock stealing for non-RT
 waiters
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
References: <20220621193641.609712-1-longman@redhat.com>
 <YrRriHsAdxPwEnWW@linutronix.de>
 <be4db8af-7855-1f54-c2f2-947577b71f94@redhat.com>
 <YrVczgIdWoOpVX1D@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YrVczgIdWoOpVX1D@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/22 02:42, Sebastian Andrzej Siewior wrote:
> On 2022-06-23 10:41:17 [-0400], Waiman Long wrote:
>> On 6/23/22 09:32, Sebastian Andrzej Siewior wrote:
>>> Do you have more insight on how this was tested/ created? Based on that,
>>> systemd and a random kworker waited on a lock for more than 10 minutes.
>> The hang happens when our QE team run thier kernel tier 1 test which, I
>> think, lasts several hours. The hang happens in some runs but not all of
>> them. So it is kind of opportunistic. Mike should be able to provide a
>> better idea about frequency and so on.
> So we talk here about 64+ CPU or more than that?

The bug report that I saw showed 2 hangs in two different one-socket 
4-core 8-thread systems. So they are not 64+ cpus. Of course, the more 
cpus that we have, the more chance we will get into trouble.


>
>>> I added a trace-printk each time a non-RT waiter got the lock stolen,
>>> kicked a kernel build and a package upgrade and took a look at the stats
>>> an hour later:
>>> - sh got its lock stolen 3416 times. I didn't lock the pid so I can't
>>>     look back and check how long it waited since the first time.
>>> - the median average of stolen locks is 173.
>> Maybe we should also more lock stealing per waiter than the 10 that I used
>> in the patch. I am open to suggestion to what is a good value to use.
> I have no idea either. I just looked at a run to see what the number
> actually are. I have no numbers in terms of performance. So what most
> likely happens is that on an unlock operation the waiter gets a wake-up
> but before he gets a chance to acquire the lock, it is already taken and
> he goes back to sleep again. While this looks painful it might be better
> performance wise because the other task was able to acquire the lock
> without waiting. But then it is not fair and this happens.
> One thing that I'm curious about is, what lock is it (one or two global
> hot spots or many). And how to benchmark this…

The hang can happen in different places. Like

[ 1873.205398] INFO: task pool-restraintd:122206 blocked for more than 
622 seconds.
[ 1873.205400]       Tainted: G        W  OE  X --------- --- 
5.14.0-104.rt21.104.el9.x86_64 #1
[ 1873.205401] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1873.205402] task:pool-restraintd state:D stack:    0 pid:122206 
ppid:     1 flags:0x00000000
[ 1873.205405] Call Trace:
[ 1873.205407]  __schedule+0x21c/0x5b0
[ 1873.205410]  ? migrate_enable+0xcd/0x140
[ 1873.205413]  schedule+0x46/0xc0
[ 1873.205415]  rt_mutex_slowlock_block.constprop.0+0x30/0x150
[ 1873.205418]  __rt_mutex_slowlock.constprop.0+0x6b/0xe0
[ 1873.205421]  __rwbase_read_lock+0x9c/0xe0
[ 1873.205425]  do_madvise+0x109/0x9c0
[ 1873.205429]  ? syscall_exit_to_user_mode+0x12/0x30
[ 1873.205432]  ? do_syscall_64+0x69/0x80
[ 1873.205434]  __x64_sys_madvise+0x28/0x30
[ 1873.205436]  do_syscall_64+0x5c/0x80
[ 1873.205438]  ? fpregs_restore_userregs+0x53/0x100
[ 1873.205442]  ? exit_to_user_mode_prepare+0xda/0xe0
[ 1873.205445]  ? syscall_exit_to_user_mode+0x12/0x30
[ 1873.205447]  ? do_syscall_64+0x69/0x80
[ 1873.205449]  ? do_syscall_64+0x69/0x80
[ 1873.205452]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1873.205455] RIP: 0033:0x7f35f5a93f5b
[ 1873.205457] RSP: 002b:00007f35f4a48e18 EFLAGS: 00000206 ORIG_RAX: 
000000000000001c
[ 1873.205460] RAX: ffffffffffffffda RBX: 00007f35f4a49640 RCX: 
00007f35f5a93f5b
[ 1873.205461] RDX: 0000000000000004 RSI: 00000000007fb000 RDI: 
00007f35f4249000
[ 1873.205463] RBP: 00007f35f4249000 R08: 00007f35ec0026c0 R09: 
0000000000000005
[ 1873.205464] R10: 0000000000000008 R11: 0000000000000206 R12: 
00007f35f4a49640
[ 1873.205466] R13: 0000000000000000 R14: 00007f35f5af4560 R15: 
0000000000000000

or

[ 1872.559562] INFO: task auditd:926 blocked for more than 622 seconds.
[ 1872.559563]       Tainted: G        W        --------- --- 
5.14.0-103.rt21.103.el9.x86_64 #1
[ 1872.559563] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1872.559564] task:auditd          state:D stack:    0 pid:  926 
ppid:     1 flags:0x00000000
[ 1872.559565] Call Trace:
[ 1872.559566]  __schedule+0x21c/0x5b0
[ 1872.559568]  schedule+0x46/0xc0
[ 1872.559569]  rt_mutex_slowlock_block.constprop.0+0x30/0x150
[ 1872.559570]  __rt_mutex_slowlock.constprop.0+0x6b/0xe0
[ 1872.559572]  __rwbase_read_lock+0x9c/0xe0
[ 1872.559574]  xlog_cil_commit+0x30/0x190 [xfs]
[ 1872.559631]  __xfs_trans_commit+0xb0/0x320 [xfs]
[ 1872.559686]  xfs_vn_update_time+0x12c/0x240 [xfs]
[ 1872.559741]  file_update_time+0xea/0x140
[ 1872.559744]  ? rwbase_write_lock+0xde/0x1b0
[ 1872.559746]  xfs_file_write_checks+0x247/0x310 [xfs]
[ 1872.559799]  xfs_file_buffered_write+0x76/0x2c0 [xfs]
[ 1872.559852]  ? update_load_avg+0x80/0x7d0
[ 1872.559855]  new_sync_write+0x11f/0x1b0
[ 1872.559858]  vfs_write+0x25a/0x2f0
[ 1872.559860]  ksys_write+0x65/0xe0
[ 1872.559862]  do_syscall_64+0x5c/0x80
[ 1872.559864]  ? fpregs_restore_userregs+0x12/0x100
[ 1872.559866]  ? exit_to_user_mode_prepare+0xda/0xe0
[ 1872.559868]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1872.559870] RIP: 0033:0x7f4bf7545d9f
[ 1872.559872] RSP: 002b:00007ffce95c2920 EFLAGS: 00000293 ORIG_RAX: 
0000000000000001
[ 1872.559874] RAX: ffffffffffffffda RBX: 0000000000000111 RCX: 
00007f4bf7545d9f
[ 1872.559874] RDX: 0000000000000111 RSI: 0000559015de18f0 RDI: 
0000000000000005
[ 1872.559875] RBP: 0000559015de18f0 R08: 0000000000000000 R09: 
00007f4bf75b74e0
[ 1872.559876] R10: 00007f4bf75b73e0 R11: 0000000000000293 R12: 
0000000000000111
[ 1872.559877] R13: 0000559015dd9310 R14: 0000000000000111 R15: 
00007f4bf75fb9e0

Since it is causing 25-50% of our test jobs to fail, we really want to 
get it fixed ASAP.

Regards,
Longman

