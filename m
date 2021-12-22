Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6670647D007
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbhLVKck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:32:40 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33893 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhLVKch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:32:37 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJqQ455n5zcc7n;
        Wed, 22 Dec 2021 18:32:12 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 18:32:35 +0800
From:   "libaokun (A)" <libaokun1@huawei.com>
Subject: Questions about the patch 054aa8d439b9 ("fget: check that the fd
 still exists after getting a ref to it")
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        <mszeredi@redhat.com>, <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "zhangyi (F)" <yi.zhang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
Message-ID: <58644a55-561d-4a2e-6741-589d013837f1@huawei.com>
Date:   Wed, 22 Dec 2021 18:32:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Wed, 1 Dec 2021 10:06:14 -0800
> Subject: fget: check that the fd still exists after getting a ref to it
>
> Jann Horn points out that there is another possible race wrt Unix domain
> socket garbage collection, somewhat reminiscent of the one fixed in
> commit cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK").
>
> See the extended comment about the garbage collection requirements added
> to unix_peek_fds() by that commit for details.
>
> The race comes from how we can locklessly look up a file descriptor just
> as it is in the process of being closed, and with the right artificial
> timing (Jann added a few strategic 'mdelay(500)' calls to do that), the
> Unix domain socket garbage collector could see the reference count
> decrement of the close() happen before fget() took its reference to the
> file and the file was attached onto a new file descriptor.

I analyzed this CVE and tried to reproduce it.

I guess he triggered it like the stack below.


close_fd                               |
  pick_file                             |
                                        | __fget_files
file = files_lookup_fd_rcu(files, fd); |
                                        | 
rcu_assign_pointer(fdt->fd[fd], NULL);
  filp_close                            |
   fput                                 |
                                        | get_file_rcu_many // ned ref>=1
    fput_many(file, 1);                 |
     file_free(file);                   |
                                        |  return file
                                        |  // read-after-free



If you want to successfully execute the get_file_rcu_many function,

the reference counting of the file is greater than or equal to 1 and

is greater than or equal to 2 after the execution.

However, close releases only one reference count and does not release 
the file,

so read-after-free does not occur. So how is the race triggered here?

The question has been pondered for a long time without any results.

Could I get more details (e.g. reproduction methods or stacks) from you ?

I would appreciate it if you could help me.


> This is all (intentionally) correct on the 'struct file *' side, with
> RCU lookups and lockless reference counting very much part of the
> design. Getting that reference count out of order isn't a problem per
> se.
>
> But the garbage collector can get confused by seeing this situation of
> having seen a file not having any remaining external references and then
> seeing it being attached to an fd.
>
> In commit cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK") the
> fix was to serialize the file descriptor install with the garbage
> collector by taking and releasing the unix_gc_lock.
>
> That's not really an option here, but since this all happens when we are
> in the process of looking up a file descriptor, we can instead simply
> just re-check that the file hasn't been closed in the meantime, and just
> re-do the lookup if we raced with a concurrent close() of the same file
> descriptor.
>
> Reported-and-tested-by: Jann Horn <jannh@google.com>
> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> fs/file.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/fs/file.c b/fs/file.c
> index 8627dacfc4246..ad4a8bf3cf109 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -858,6 +858,10 @@ loop:
> file = NULL;
> else if (!get_file_rcu_many(file, refs))
> goto loop;
> + else if (files_lookup_fd_raw(files, fd) != file) {
> + fput_many(file, refs);
> + goto loop;
> + }
> }
> rcu_read_unlock();
> -- cgit 1.2.3-1.el7

Looking forward to hearing from you.

Thank you!

-- 
With Best Regards,
Baokun Li
.


