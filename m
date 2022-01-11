Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C12348A96C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348951AbiAKIfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:35:11 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16700 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348936AbiAKIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:35:10 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JY3nd5JmvzZf5t;
        Tue, 11 Jan 2022 16:31:33 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 16:35:08 +0800
Subject: Re: Questions about the patch 054aa8d439b9 ("fget: check that the fd
 still exists after getting a ref to it")
To:     Jann Horn <jannh@google.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <mszeredi@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <58644a55-561d-4a2e-6741-589d013837f1@huawei.com>
 <CAG48ez0Xz=22u4tCwt9s8WqmOvtFB3ajbaiyt1MWkAtytu0wUQ@mail.gmail.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <6cefad75-9e7e-1cf8-22ad-bbee8a105933@huawei.com>
Date:   Tue, 11 Jan 2022 16:35:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0Xz=22u4tCwt9s8WqmOvtFB3ajbaiyt1MWkAtytu0wUQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/1/10 17:09, Jann Horn 写道:
> On Wed, Dec 22, 2021 at 11:32 AM libaokun (A) <libaokun1@huawei.com> wrote:
>>> From: Linus Torvalds <torvalds@linux-foundation.org>
>>> Date: Wed, 1 Dec 2021 10:06:14 -0800
>>> Subject: fget: check that the fd still exists after getting a ref to it
>>>
>>> Jann Horn points out that there is another possible race wrt Unix domain
>>> socket garbage collection, somewhat reminiscent of the one fixed in
>>> commit cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK").
>>>
>>> See the extended comment about the garbage collection requirements added
>>> to unix_peek_fds() by that commit for details.
>>>
>>> The race comes from how we can locklessly look up a file descriptor just
>>> as it is in the process of being closed, and with the right artificial
>>> timing (Jann added a few strategic 'mdelay(500)' calls to do that), the
>>> Unix domain socket garbage collector could see the reference count
>>> decrement of the close() happen before fget() took its reference to the
>>> file and the file was attached onto a new file descriptor.
>> I analyzed this CVE and tried to reproduce it.
>>
>> I guess he triggered it like the stack below.
>>
>>
>> close_fd                               |
>>    pick_file                             |
>>                                          | __fget_files
>> file = files_lookup_fd_rcu(files, fd); |
>>                                          |
>> rcu_assign_pointer(fdt->fd[fd], NULL);
>>    filp_close                            |
>>     fput                                 |
>>                                          | get_file_rcu_many // ned ref>=1
>>      fput_many(file, 1);                 |
>>       file_free(file);                   |
>>                                          |  return file
>>                                          |  // read-after-free
> The race is more complicated than that; you also need to add unix_gc()
> to the race. And if you want to get to memory corruption, you need one
> or two more races involving unix_stream_read_generic() on top of that.
>
>> If you want to successfully execute the get_file_rcu_many function,
>>
>> the reference counting of the file is greater than or equal to 1 and
>>
>> is greater than or equal to 2 after the execution.
>>
>> However, close releases only one reference count and does not release
>> the file,
>>
>> so read-after-free does not occur. So how is the race triggered here?
> This bug does not lead to a UAF of the file, it leads to a locking
> inconsistency between the unix stream read path and the GC.
>
>> The question has been pondered for a long time without any results.
>>
>> Could I get more details (e.g. reproduction methods or stacks) from you ?
> See https://bugs.chromium.org/p/project-zero/issues/detail?id=2247 for
> the original bug report. I'm also working on a more detailed blog
> post, but that isn't finished yet.
> .

Thank you very much for your reply!

With your help, I have understood the problem and successfully 
reproduced it.

Thanks a million!

-- 
With Best Regards,
Baokun Li

