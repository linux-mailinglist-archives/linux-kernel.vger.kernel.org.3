Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1706F469804
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245580AbhLFOLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:11:01 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29090 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245637AbhLFOKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:10:22 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J74sw35xcz1DJxB;
        Mon,  6 Dec 2021 22:04:04 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 22:06:52 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 22:06:51 +0800
Message-ID: <71c69735-6064-6b28-eab3-67c36f88e51d@huawei.com>
Date:   Mon, 6 Dec 2021 22:06:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH -next] kfence: fix memory leak when cat kfence objects
Content-Language: en-US
To:     Marco Elver <elver@google.com>, Baokun Li <libaokun1@huawei.com>
CC:     <glider@google.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
References: <20211206133628.2822545-1-libaokun1@huawei.com>
 <CANpmjNOrtcu16zKEjiZbBZJPDKWa6-PM_hw1yNZhXvpZupYgng@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CANpmjNOrtcu16zKEjiZbBZJPDKWa6-PM_hw1yNZhXvpZupYgng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/6 21:29, Marco Elver wrote:
> On Mon, 6 Dec 2021 at 14:24, Baokun Li <libaokun1@huawei.com> wrote:
>> Hulk robot reported a kmemleak problem:
>> -----------------------------------------------------------------------
>> unreferenced object 0xffff93d1d8cc02e8 (size 248):
>>    comm "cat", pid 23327, jiffies 4624670141 (age 495992.217s)
>>    hex dump (first 32 bytes):
>>      00 40 85 19 d4 93 ff ff 00 10 00 00 00 00 00 00  .@..............
>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    backtrace:
>>      [<00000000db5610b3>] seq_open+0x2a/0x80
>>      [<00000000d66ac99d>] full_proxy_open+0x167/0x1e0
>>      [<00000000d58ef917>] do_dentry_open+0x1e1/0x3a0
>>      [<0000000016c91867>] path_openat+0x961/0xa20
>>      [<00000000909c9564>] do_filp_open+0xae/0x120
>>      [<0000000059c761e6>] do_sys_openat2+0x216/0x2f0
>>      [<00000000b7a7b239>] do_sys_open+0x57/0x80
>>      [<00000000e559d671>] do_syscall_64+0x33/0x40
>>      [<000000000ea1fbfd>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> unreferenced object 0xffff93d419854000 (size 4096):
>>    comm "cat", pid 23327, jiffies 4624670141 (age 495992.217s)
>>    hex dump (first 32 bytes):
>>      6b 66 65 6e 63 65 2d 23 32 35 30 3a 20 30 78 30  kfence-#250: 0x0
>>      30 30 30 30 30 30 30 37 35 34 62 64 61 31 32 2d  0000000754bda12-
>>    backtrace:
>>      [<000000008162c6f2>] seq_read_iter+0x313/0x440
>>      [<0000000020b1b3e3>] seq_read+0x14b/0x1a0
>>      [<00000000af248fbc>] full_proxy_read+0x56/0x80
>>      [<00000000f97679d1>] vfs_read+0xa5/0x1b0
>>      [<000000000ed8a36f>] ksys_read+0xa0/0xf0
>>      [<00000000e559d671>] do_syscall_64+0x33/0x40
>>      [<000000000ea1fbfd>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> -----------------------------------------------------------------------
>>
>> I find that we can easily reproduce this problem with the following
>> commands:
>>          `cat /sys/kernel/debug/kfence/objects`
>>          `echo scan > /sys/kernel/debug/kmemleak`
>>          `cat /sys/kernel/debug/kmemleak`
>>
>> The leaked memory is allocated in the stack below:
>> ----------------------------------
>> do_syscall_64
>>    do_sys_open
>>      do_dentry_open
>>        full_proxy_open
>>          seq_open            ---> alloc seq_file
>>    vfs_read
>>      full_proxy_read
>>        seq_read
>>          seq_read_iter
>>            traverse          ---> alloc seq_buf
>> ----------------------------------
>>
>> And it should have been released in the following process:
>> ----------------------------------
>> do_syscall_64
>>    syscall_exit_to_user_mode
>>      exit_to_user_mode_prepare
>>        task_work_run
>>          ____fput
>>            __fput
>>              full_proxy_release  ---> free here
>> ----------------------------------
>>
>> However, the release function corresponding to file_operations is not
>> implemented in kfence. As a result, a memory leak occurs. Therefore,
>> the solution to this problem is to implement the corresponding
>> release function.
>>
>> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

