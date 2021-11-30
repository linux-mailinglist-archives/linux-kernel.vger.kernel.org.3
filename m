Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91492462E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbhK3IED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:04:03 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59977 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbhK3ID6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:03:58 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211130080037euoutp0176fab326b032315fde5b04f7488e4666~8RBjIi2mR0199701997euoutp01O
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:00:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211130080037euoutp0176fab326b032315fde5b04f7488e4666~8RBjIi2mR0199701997euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1638259237;
        bh=cTYca1qZ9PfgKceXdqdf0TdNY5yvra2dH+rNbCMkJRc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Pp4toaTAaaysxfA7pjSugMyR7HMYJrpSHMRUi4pIZqiHjy9PDjbr2EO5RkRHGUVRc
         cUe/yZrZoX5gaHWojIDTE4u3fCJT2Gd1amIUZ8Gm3xJEnHSEZ26DN49pKd5V34Uk0U
         TcOYOor82LcOaYBtxzunLfeQqob0oqYqIJoNhq/I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211130080037eucas1p126494724a8dc31a7c782315caedbc84e~8RBi6n8uz3236132361eucas1p1q;
        Tue, 30 Nov 2021 08:00:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AC.F2.09887.52AD5A16; Tue, 30
        Nov 2021 08:00:37 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211130080037eucas1p135b74852b10a54de5365ba9e91599fdc~8RBimndCj0290802908eucas1p1B;
        Tue, 30 Nov 2021 08:00:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211130080037eusmtrp21875e7b746ad59732df661238c98ee90~8RBil_U4l2198121981eusmtrp2s;
        Tue, 30 Nov 2021 08:00:37 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-e5-61a5da259584
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 52.B7.09404.42AD5A16; Tue, 30
        Nov 2021 08:00:37 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211130080036eusmtip27062fa17a5d992be294087d0c7031a9a~8RBiPzq4H2776927769eusmtip2I;
        Tue, 30 Nov 2021 08:00:36 +0000 (GMT)
Message-ID: <061b9b7a-7a2a-d59c-aadb-d5dfdcc8aad1@samsung.com>
Date:   Tue, 30 Nov 2021 09:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] kernfs: switch global kernfs_rwsem lock to per-fs lock
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <YaUGsn4opaiSO2H8@google.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduzneV3VW0sTDXZME7FoXryezeLyrjls
        Fsu+vme3+LX8KKMDi8emVZ1sHvvnrmH3+LxJLoA5issmJTUnsyy1SN8ugSvjxJGpTAUTdCre
        PElqYPyv3MXIySEhYCIxbf1zdhBbSGAFo8SruUVdjFxA9hdGiU1fNjJCOJ8ZJZadecMK03Gx
        /R0zRGI5o8Slj11MEO0fGSU2PhEDsXkF7CRufP/GAmKzCKhKvPv/jA0iLihxcuYTsLioQJLE
        hBO7wXqFBbwltl34DRZnFhCXuPVkPlhcREBF4s/Tf4wQ8VKJpqPHwI5gEzCU6HrbBTSTg4NT
        QEti1eEqiBJ5ieats8FukxBYyyHxfNkbdoijXSQaXm5lg7CFJV4d3wIVl5H4vxNkF0hDM6PE
        w3Nr2SGcHkaJy00zGCGqrCXunPsFto1ZQFNi/S59iLCjxJM/c5hAwhICfBI33gpCHMEnMWnb
        dGaIMK9ER5sQRLWaxKzj6+DWHrxwiXkCo9IspFCZheT7WUjemYWwdwEjyypG8dTS4tz01GKj
        vNRyveLE3OLSvHS95PzcTYzAZHL63/EvOxiXv/qod4iRiYPxEKMEB7OSCK/3mcWJQrwpiZVV
        qUX58UWlOanFhxilOViUxHlF/jQkCgmkJ5akZqemFqQWwWSZODilGpjmL1m/aIcnR0he5M1v
        rneXVW8SWBRu3ii8M+5PAHtLR8etgLgDkc5CLl1b3c8nnjW2tPCdHlg+2SZCXGbaSrHFT82d
        pc4r3hOvmrT7xselTxYqac7yezbN/Nqx6qud6x7oWBbP/tx4e0q4tpynaMbCIzFS5i/barUC
        695PL9n6KfylKP9658lLN2rqib6eczGuu2uu34vzite2rfiXml4/x8cmYa1lirjN7bf//fz1
        fiYElZ7u2XePSV7g1uYk49J9ezY59ym0zrQQVln08rlagBJjyN+40qAvjVxPldwrPqq2615p
        2/926frf+kkSny433ctN/sT403ab8rdTsw7oZJ/p5ZmmdZXJ8m2zyj0lluKMREMt5qLiRACJ
        cxcplQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7qqt5YmGpxtZbFoXryezeLyrjls
        Fsu+vme3+LX8KKMDi8emVZ1sHvvnrmH3+LxJLoA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
        yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jxJGpTAUTdCrePElqYPyv3MXIySEhYCJxsf0d
        cxcjF4eQwFJGiSf3t7JDJGQkTk5rYIWwhSX+XOtigyh6zyhxZtFCJpAEr4CdxI3v31hAbBYB
        VYl3/5+xQcQFJU7OfAIWFxVIknh6oBMsLizgLbHtwm+wOLOAuMStJ/PB5ogIqEj8efqPESJe
        KrHoww9GiGWPGCW+P1oEVsQmYCjR9RbkCg4OTgEtiVWHqyDqzSS6tnZB9cpLNG+dzTyBUWgW
        kjNmIVk3C0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG0LZjP7fsYFz56qPe
        IUYmDsZDjBIczEoivN5nFicK8aYkVlalFuXHF5XmpBYfYjQFhsVEZinR5HxgDOeVxBuaGZga
        mphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTB1LTFufJHoy2LqeDXz/wWLqNS+
        iIm/OQO2zJlzq6Sg5Nem4xxMaguWbvdobcqT2W1+w7z5denxQ5w/xCZYXNFoZ+hXX7t7+9Hd
        75U9zPpY89qeCNpb3pxa8sLBvjpKsnfx1vNzlJ7kvea43iDudkEuLzZIuUzEXNJq99HXNgby
        jxY3705m5rTiOCNddOndHu/ORYdSV4rmZU1dqzshWPv+RCX/C8J304rSDXa//rfimiITly9j
        S/iRgqeF2qxn5n1j0S1dFzLF567d01V5f/k5yx/LH3KaG8UsYlF1OyRIlfs925QK7oDDVfK8
        V13al3dbzHjqIWswd2Fj+aaF10/4MbelBdxb3+YzZxfnHyWW4oxEQy3mouJEAFq9OV0pAwAA
X-CMS-MailID: 20211130080037eucas1p135b74852b10a54de5365ba9e91599fdc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211126115446eucas1p2e377cf7718c6da6bfe40a016bc0191a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211126115446eucas1p2e377cf7718c6da6bfe40a016bc0191a8
References: <20211118230008.2679780-1-minchan@kernel.org>
        <CGME20211126115446eucas1p2e377cf7718c6da6bfe40a016bc0191a8@eucas1p2.samsung.com>
        <a7464856-486a-a76a-937c-35a426555507@samsung.com>
        <YaUGsn4opaiSO2H8@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29.11.2021 17:58, Minchan Kim wrote:
> On Fri, Nov 26, 2021 at 12:54:45PM +0100, Marek Szyprowski wrote:
>> Hi,
>>
>> On 19.11.2021 00:00, Minchan Kim wrote:
>>> The kernfs implementation has big lock granularity(kernfs_rwsem) so
>>> every kernfs-based(e.g., sysfs, cgroup) fs are able to compete the
>>> lock. It makes trouble for some cases to wait the global lock
>>> for a long time even though they are totally independent contexts
>>> each other.
>>>
>>> A general example is process A goes under direct reclaim with holding
>>> the lock when it accessed the file in sysfs and process B is waiting
>>> the lock with exclusive mode and then process C is waiting the lock
>>> until process B could finish the job after it gets the lock from
>>> process A.
>>>
>>> This patch switches the global kernfs_rwsem to per-fs lock, which
>>> put the rwsem into kernfs_root.
>>>
>>> Suggested-by: Tejun Heo <tj@kernel.org>
>>> Signed-off-by: Minchan Kim <minchan@kernel.org>
>> This patch landed recently in linux-next (20211126) as commit
>> 393c3714081a ("kernfs: switch global kernfs_rwsem lock to per-fs lock").
>> In my tests I've found that it causes the following warning during the
>> system reboot:
>>
>>    =========================
>>    WARNING: held lock freed!
>>    5.16.0-rc2+ #10984 Not tainted
>>    -------------------------
>>    kworker/1:0/18 is freeing memory ffff00004034e200-ffff00004034e3ff,
>> with a lock still held there!
>>    ffff00004034e348 (&root->kernfs_rwsem){++++}-{3:3}, at:
>> __kernfs_remove+0x310/0x37c
>>    3 locks held by kworker/1:0/18:
>>     #0: ffff000040107938 ((wq_completion)cgroup_destroy){+.+.}-{0:0}, at:
>> process_one_work+0x1f0/0x6f0
>>     #1: ffff80000b55bdc0
>> ((work_completion)(&(&css->destroy_rwork)->work)){+.+.}-{0:0}, at:
>> process_one_work+0x1f0/0x6f0
>>     #2: ffff00004034e348 (&root->kernfs_rwsem){++++}-{3:3}, at:
>> __kernfs_remove+0x310/0x37c
>>
>>    stack backtrace:
>>    CPU: 1 PID: 18 Comm: kworker/1:0 Not tainted 5.16.0-rc2+ #10984
>>    Hardware name: Raspberry Pi 4 Model B (DT)
>>    Workqueue: cgroup_destroy css_free_rwork_fn
>>    Call trace:
>>     dump_backtrace+0x0/0x1ac
>>     show_stack+0x18/0x24
>>     dump_stack_lvl+0x8c/0xb8
>>     dump_stack+0x18/0x34
>>     debug_check_no_locks_freed+0x124/0x140
>>     kfree+0xf0/0x3a4
>>     kernfs_put+0x1f8/0x224
>>     __kernfs_remove+0x1b8/0x37c
>>     kernfs_destroy_root+0x38/0x50
>>     css_free_rwork_fn+0x288/0x3d4
>>     process_one_work+0x288/0x6f0
>>     worker_thread+0x74/0x470
>>     kthread+0x188/0x194
>>     ret_from_fork+0x10/0x20
>>
>> Let me know if you need more information or help in reproducing this issue.
> Hi Marek,
>
> Thanks for the report. Could you try this one?
>
> >From 68741aa598ffd4a407d6d5f6b58bc7e7281e6f81 Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Mon, 29 Nov 2021 08:40:15 -0800
> Subject: [PATCH] kernfs: prevent early freeing of root node
>
> Marek reported the warning below.
>
>    =========================
>    WARNING: held lock freed!
>    5.16.0-rc2+ #10984 Not tainted
>    -------------------------
>    kworker/1:0/18 is freeing memory ffff00004034e200-ffff00004034e3ff,
> with a lock still held there!
>    ffff00004034e348 (&root->kernfs_rwsem){++++}-{3:3}, at:
> __kernfs_remove+0x310/0x37c
>    3 locks held by kworker/1:0/18:
>     #0: ffff000040107938 ((wq_completion)cgroup_destroy){+.+.}-{0:0}, at:
> process_one_work+0x1f0/0x6f0
>     #1: ffff80000b55bdc0
> ((work_completion)(&(&css->destroy_rwork)->work)){+.+.}-{0:0}, at:
> process_one_work+0x1f0/0x6f0
>     #2: ffff00004034e348 (&root->kernfs_rwsem){++++}-{3:3}, at:
> __kernfs_remove+0x310/0x37c
>
>    stack backtrace:
>    CPU: 1 PID: 18 Comm: kworker/1:0 Not tainted 5.16.0-rc2+ #10984
>    Hardware name: Raspberry Pi 4 Model B (DT)
>    Workqueue: cgroup_destroy css_free_rwork_fn
>    Call trace:
>     dump_backtrace+0x0/0x1ac
>     show_stack+0x18/0x24
>     dump_stack_lvl+0x8c/0xb8
>     dump_stack+0x18/0x34
>     debug_check_no_locks_freed+0x124/0x140
>     kfree+0xf0/0x3a4
>     kernfs_put+0x1f8/0x224
>     __kernfs_remove+0x1b8/0x37c
>     kernfs_destroy_root+0x38/0x50
>     css_free_rwork_fn+0x288/0x3d4
>     process_one_work+0x288/0x6f0
>     worker_thread+0x74/0x470
>     kthread+0x188/0x194
>     ret_from_fork+0x10/0x20
>
> Since kernfs moves the kernfs_rwsem lock into root, it couldn't hold
> the lock when the root node is tearing down. Thus, get the refcount
> of root node.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Right, this fixes the issue.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   fs/kernfs/dir.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 13cae0ccce74..e6d9772ddb4c 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -961,7 +961,13 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
>    */
>   void kernfs_destroy_root(struct kernfs_root *root)
>   {
> -	kernfs_remove(root->kn);	/* will also free @root */
> +	/*
> +	 *  kernfs_remove holds kernfs_rwsem from the root so the root
> +	 *  shouldn't be freed during the operation.
> +	 */
> +	kernfs_get(root->kn);
> +	kernfs_remove(root->kn);
> +	kernfs_put(root->kn); /* will also free @root */
>   }
>   
>   /**

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

