Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF26482816
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 19:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiAASCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 13:02:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230259AbiAASCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 13:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641060141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOU7T3r4wefZ6y4v0az6szwM1G6nHEQJA6eIHA1wZGs=;
        b=hEjNTVWReXKZgA2Jg0uQaRs+ViycnLwmw8a6zmmPmbmxIa7JDVGqMt1DE3SzqpaJ1LdVSl
        +P/itX0tBkbZ8qcDFcTBqPMuSJge2UwCCvqFNE7D9baMhqlehJxhjXDtW7OTzUsN0B5OX/
        NQYDD3X61VC7hvkRLvZGdSZLqYiAah4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-yjAXsXbrPtqNS7gZ7wgutg-1; Sat, 01 Jan 2022 13:02:18 -0500
X-MC-Unique: yjAXsXbrPtqNS7gZ7wgutg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CE142F26;
        Sat,  1 Jan 2022 18:02:17 +0000 (UTC)
Received: from [10.22.8.94] (unknown [10.22.8.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5B5B79A22;
        Sat,  1 Jan 2022 18:02:14 +0000 (UTC)
Message-ID: <843bffdd-6c5b-2869-e089-01d180f36a76@redhat.com>
Date:   Sat, 1 Jan 2022 13:02:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [lockdep] UAF read in print_name().
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <77f05c15-81b6-bddd-9650-80d5f23fe330@i-love.sakura.ne.jp>
 <015af849-3571-e9ac-692f-d803aa19f566@redhat.com>
 <f80074eb-58bc-7db7-d945-ef18f7617c4e@i-love.sakura.ne.jp>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <f80074eb-58bc-7db7-d945-ef18f7617c4e@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/21 10:09, Tetsuo Handa wrote:
> On 2021/12/29 12:25, Waiman Long wrote:
>> On 12/28/21 05:49, Tetsuo Handa wrote:
>>> Hello.
>>>
>>> I found using linux-next-20211210 that reading /proc/lockdep after lockdep splat
>>> triggers UAF read access. I think this is a side effect of zapping dependency
>>> information when loop driver's WQ is destroyed. You might want to xchg() the pointer
>>> with a dummy struct containing a static string.
>>>
>>> difference before lockdep splat and after lockdep splat
>>> ----------------------------------------
>>> 8635c8636
>>> < ffff88811561cd28 OPS:      26 FD:  122 BD:    1 +.+.: (wq_completion)loop0
>>> ---
>>>> ffff88811561cd28 OPS:      31 FD:  439 BD:    1 +.+.:  M>^MM-^AM-^HM-^?M-^?
>> Thanks for reporting.
>>
>> Yes, listing locking classes by /proc/lockdep is racy as all_lock_classes is accessed
>> without lock protection. OTOH, we probably can't fix this race as lock hold time will be
>> too long for this case. Atomically xchg the class name is a possible workaround, but we
>> also need to add additional checks as the iteration may also be redirected to
>> free_lock_classes leading to an endless iteration loop.
> Thanks for responding. But is this bug really unfixable?
I am not saying that it is unfixable. I am just saying that we cannot 
guarantee a consistent output of /proc/lockdep as internal data may 
change in the middle of dumping the output.
>
> Please see the following result.
>
> ----------------------------------------
> [root@localhost ~]# uname -r
> 5.16.0-rc4-next-20211210
> [root@localhost ~]# grep loop /proc/lockdep
> [root@localhost ~]# truncate -s 100m testfile
> [root@localhost ~]# losetup -f testfile
> [root@localhost ~]# grep loop /proc/lockdep
> ffffffffa02b73c8 OPS:      17 FD:   34 BD:    1 +.+.: loop_ctl_mutex
> ffff888106fb0528 OPS:     114 FD:  183 BD:    1 +.+.: (wq_completion)loop0
> [root@localhost ~]# losetup -D
> [root@localhost ~]# grep loop /proc/lockdep
> ffffffffa02b73c8 OPS:      17 FD:   34 BD:    1 +.+.: loop_ctl_mutex
> ffffffffa02b7328 OPS:       1 FD:    1 BD:    1 +.+.: loop_validate_mutex
> [root@localhost ~]# losetup -f testfile
> [root@localhost ~]# grep loop /proc/lockdep
> ffffffffa02b73c8 OPS:      18 FD:   34 BD:    1 +.+.: loop_ctl_mutex
> ffffffffa02b7328 OPS:       1 FD:    1 BD:    1 +.+.: loop_validate_mutex
> ffff888106fb1128 OPS:     118 FD:  183 BD:    1 +.+.: (wq_completion)loop0
> [root@localhost ~]# losetup -D
> [root@localhost ~]# grep loop /proc/lockdep
> ffffffffa02b73c8 OPS:      18 FD:   34 BD:    1 +.+.: loop_ctl_mutex
> ffffffffa02b7328 OPS:       2 FD:    1 BD:    1 +.+.: loop_validate_mutex
> [root@localhost ~]# grep debug_locks /proc/lockdep_stats
>   debug_locks:                             1
> [root@localhost ~]#
> ----------------------------------------
>
> We can confirm that the "(wq_completion)loop0" entry disappears when WQ for /dev/loop0 is destroyed.
>
> Then, please see the following reproducer for this lockdep problem. As you can see, there is 10
> seconds between lockdep complained and /proc/lockdep is read. 10 seconds should be enough time
> for erasing the "(wq_completion)loop0" entry.

Thanks for the reproducer.


> ----------------------------------------
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <linux/loop.h>
> #include <sys/sendfile.h>
>
> int main(int argc, char *argv[])
> {
> 	const int file_fd = open("testfile", O_RDWR | O_CREAT, 0600);
> 	ftruncate(file_fd, 1048576);
> 	char filename[128] = { };
> 	const int loop_num = ioctl(open("/dev/loop-control", 3),  LOOP_CTL_GET_FREE, 0);
> 	snprintf(filename, sizeof(filename) - 1, "/dev/loop%d", loop_num);
> 	const int loop_fd_1 = open(filename, O_RDWR);
> 	ioctl(loop_fd_1, LOOP_SET_FD, file_fd);
> 	const int loop_fd_2 = open(filename, O_RDWR);
> 	ioctl(loop_fd_1, LOOP_CLR_FD, 0);
> 	const int sysfs_fd = open("/sys/power/resume", O_RDWR);
> 	sendfile(file_fd, sysfs_fd, 0, 1048576);
> 	sendfile(loop_fd_2, file_fd, 0, 1048576);
> 	write(sysfs_fd, "700", 3);
> 	system("/bin/cat /proc/lockdep > /tmp/lockdep-before-splat"); // Save before "zap on release" forgets the dependency.
> 	close(loop_fd_2);
> 	close(loop_fd_1); // Lockdep complains the circular dependency and turns off.
> 	close(file_fd);
> 	sleep(10);
> 	system("/bin/cat /proc/lockdep > /tmp/lockdep-after-splat"); // Save after "zap on release" forgot the dependency.
> 	return 0;
> }
> ----------------------------------------
>
> If we compare the content of /proc/lockdep before and after, we can confirm that
> the "(wq_completion)loop0" entry does not disappear even after loop device was
> destroyed. (The 'k' is POISON_FREE read out as a string.)
>
> ----------------------------------------
> # diff /tmp/lockdep-before-splat /tmp/lockdep-after-splat | tail | cat -v
> ---
>> ffffffffa02b7328 OPS:       3 FD:    1 BD:   15 +.+.: loop_validate_mutex
> 7403c7411
> < ffffffff826612d8 OPS:       4 FD:  337 BD:    1 .+.+: kn->active#135
> ---
>> ffffffff826612d8 OPS:       4 FD:  338 BD:    1 .+.+: kn->active#135
> 7411c7419
> < ffff88810422b528 OPS:      22 FD:  183 BD:    1 +.+.: (wq_completion)loop0
> ---
>> ffff88810422b528 OPS:      32 FD:  435 BD:    1 +.+.: kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkM-%M-;M-;M-;M-;M-;M-;M-;M-;
> ----------------------------------------
>
> Isn't this a bug that lockdep stopped erasing the dependency chain because
> lockdep was already turned off before start reading /proc/lockdep ?
That could be the case, I need to take a further look into the code.
>
>
> By the way, this "zap on destroy" behavior made it difficult to find a reproducer
> because "at least once during the lifetime of the kernel" part of
>
>    The validator achieves perfect, mathematical 'closure' (proof of locking
>    correctness) in the sense that for every simple, standalone single-task
>    locking sequence that occurred at least once during the lifetime of the
>    kernel, the validator proves it with a 100% certainty that no
>    combination and timing of these locking sequences can cause any class of
>    lock related deadlock. [*]
>
> in Documentation/locking/lockdep-design.txt became no longer applicable?
>
I believe that passage refers to validating usage of locks to make sure 
that any deadlock can be detected. It is not really related to the 
correctness of /proc/lockdep output which is a problem in this 
particular case.

Cheers,
Longman

