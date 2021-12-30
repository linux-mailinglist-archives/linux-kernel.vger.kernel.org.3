Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55E481D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbhL3PJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:09:58 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55257 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhL3PJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:09:57 -0500
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BUF9Nfg031254;
        Fri, 31 Dec 2021 00:09:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Fri, 31 Dec 2021 00:09:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BUF9Mdr031172
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Dec 2021 00:09:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <f80074eb-58bc-7db7-d945-ef18f7617c4e@i-love.sakura.ne.jp>
Date:   Fri, 31 Dec 2021 00:09:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [lockdep] UAF read in print_name().
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <77f05c15-81b6-bddd-9650-80d5f23fe330@i-love.sakura.ne.jp>
 <015af849-3571-e9ac-692f-d803aa19f566@redhat.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <015af849-3571-e9ac-692f-d803aa19f566@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/29 12:25, Waiman Long wrote:
> On 12/28/21 05:49, Tetsuo Handa wrote:
>> Hello.
>>
>> I found using linux-next-20211210 that reading /proc/lockdep after lockdep splat
>> triggers UAF read access. I think this is a side effect of zapping dependency
>> information when loop driver's WQ is destroyed. You might want to xchg() the pointer
>> with a dummy struct containing a static string.
>>
>> difference before lockdep splat and after lockdep splat
>> ----------------------------------------
>> 8635c8636
>> < ffff88811561cd28 OPS:      26 FD:  122 BD:    1 +.+.: (wq_completion)loop0
>> ---
>>> ffff88811561cd28 OPS:      31 FD:  439 BD:    1 +.+.:  M>^MM-^AM-^HM-^?M-^?
> 
> Thanks for reporting.
> 
> Yes, listing locking classes by /proc/lockdep is racy as all_lock_classes is accessed
> without lock protection. OTOH, we probably can't fix this race as lock hold time will be
> too long for this case. Atomically xchg the class name is a possible workaround, but we
> also need to add additional checks as the iteration may also be redirected to
> free_lock_classes leading to an endless iteration loop.

Thanks for responding. But is this bug really unfixable?

Please see the following result.

----------------------------------------
[root@localhost ~]# uname -r
5.16.0-rc4-next-20211210
[root@localhost ~]# grep loop /proc/lockdep
[root@localhost ~]# truncate -s 100m testfile
[root@localhost ~]# losetup -f testfile
[root@localhost ~]# grep loop /proc/lockdep
ffffffffa02b73c8 OPS:      17 FD:   34 BD:    1 +.+.: loop_ctl_mutex
ffff888106fb0528 OPS:     114 FD:  183 BD:    1 +.+.: (wq_completion)loop0
[root@localhost ~]# losetup -D
[root@localhost ~]# grep loop /proc/lockdep
ffffffffa02b73c8 OPS:      17 FD:   34 BD:    1 +.+.: loop_ctl_mutex
ffffffffa02b7328 OPS:       1 FD:    1 BD:    1 +.+.: loop_validate_mutex
[root@localhost ~]# losetup -f testfile
[root@localhost ~]# grep loop /proc/lockdep
ffffffffa02b73c8 OPS:      18 FD:   34 BD:    1 +.+.: loop_ctl_mutex
ffffffffa02b7328 OPS:       1 FD:    1 BD:    1 +.+.: loop_validate_mutex
ffff888106fb1128 OPS:     118 FD:  183 BD:    1 +.+.: (wq_completion)loop0
[root@localhost ~]# losetup -D
[root@localhost ~]# grep loop /proc/lockdep
ffffffffa02b73c8 OPS:      18 FD:   34 BD:    1 +.+.: loop_ctl_mutex
ffffffffa02b7328 OPS:       2 FD:    1 BD:    1 +.+.: loop_validate_mutex
[root@localhost ~]# grep debug_locks /proc/lockdep_stats
 debug_locks:                             1
[root@localhost ~]#
----------------------------------------

We can confirm that the "(wq_completion)loop0" entry disappears when WQ for /dev/loop0 is destroyed.

Then, please see the following reproducer for this lockdep problem. As you can see, there is 10
seconds between lockdep complained and /proc/lockdep is read. 10 seconds should be enough time
for erasing the "(wq_completion)loop0" entry.

----------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/loop.h>
#include <sys/sendfile.h>

int main(int argc, char *argv[])
{
	const int file_fd = open("testfile", O_RDWR | O_CREAT, 0600);
	ftruncate(file_fd, 1048576);
	char filename[128] = { };
	const int loop_num = ioctl(open("/dev/loop-control", 3),  LOOP_CTL_GET_FREE, 0);
	snprintf(filename, sizeof(filename) - 1, "/dev/loop%d", loop_num);
	const int loop_fd_1 = open(filename, O_RDWR);
	ioctl(loop_fd_1, LOOP_SET_FD, file_fd);
	const int loop_fd_2 = open(filename, O_RDWR);
	ioctl(loop_fd_1, LOOP_CLR_FD, 0);
	const int sysfs_fd = open("/sys/power/resume", O_RDWR);
	sendfile(file_fd, sysfs_fd, 0, 1048576);
	sendfile(loop_fd_2, file_fd, 0, 1048576);
	write(sysfs_fd, "700", 3);
	system("/bin/cat /proc/lockdep > /tmp/lockdep-before-splat"); // Save before "zap on release" forgets the dependency.
	close(loop_fd_2);
	close(loop_fd_1); // Lockdep complains the circular dependency and turns off.
	close(file_fd);
	sleep(10);
	system("/bin/cat /proc/lockdep > /tmp/lockdep-after-splat"); // Save after "zap on release" forgot the dependency.
	return 0;
}
----------------------------------------

If we compare the content of /proc/lockdep before and after, we can confirm that
the "(wq_completion)loop0" entry does not disappear even after loop device was
destroyed. (The 'k' is POISON_FREE read out as a string.)

----------------------------------------
# diff /tmp/lockdep-before-splat /tmp/lockdep-after-splat | tail | cat -v
---
> ffffffffa02b7328 OPS:       3 FD:    1 BD:   15 +.+.: loop_validate_mutex
7403c7411
< ffffffff826612d8 OPS:       4 FD:  337 BD:    1 .+.+: kn->active#135
---
> ffffffff826612d8 OPS:       4 FD:  338 BD:    1 .+.+: kn->active#135
7411c7419
< ffff88810422b528 OPS:      22 FD:  183 BD:    1 +.+.: (wq_completion)loop0
---
> ffff88810422b528 OPS:      32 FD:  435 BD:    1 +.+.: kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkM-%M-;M-;M-;M-;M-;M-;M-;M-;
----------------------------------------

Isn't this a bug that lockdep stopped erasing the dependency chain because
lockdep was already turned off before start reading /proc/lockdep ?



By the way, this "zap on destroy" behavior made it difficult to find a reproducer
because "at least once during the lifetime of the kernel" part of

  The validator achieves perfect, mathematical 'closure' (proof of locking
  correctness) in the sense that for every simple, standalone single-task
  locking sequence that occurred at least once during the lifetime of the
  kernel, the validator proves it with a 100% certainty that no
  combination and timing of these locking sequences can cause any class of
  lock related deadlock. [*]

in Documentation/locking/lockdep-design.txt became no longer applicable?

