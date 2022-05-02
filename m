Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ACB517A88
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiEBXRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiEBXQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:16:56 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9232F021
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:13:23 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220502231321euoutp012a9d215c9867202b28d7d484364bb72e~rbLJWs9wh1644116441euoutp016
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:13:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220502231321euoutp012a9d215c9867202b28d7d484364bb72e~rbLJWs9wh1644116441euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651533201;
        bh=O4SBpucQaaZpy0wlqrx6Q5wqjcA2LOrSDyMwdeMswJM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=BinZEjz2n2c757SILoJMNuElNPjP+vn/I+cWAQagPK2lM9yAsyQOoGdLQ9lPOBHW5
         P4y0GrD+yObuXlOKMY5T9bFH76KOMf3Nd7Mz1Ajg+1q3q/x8S1juPfC1wmjRdGKKdF
         B0Smwjtiyxpsn67wAu2jY9SYx023vWEAJ4ZJmPGI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220502231320eucas1p154014c9e41d9d79fb0616d93cae11686~rbLIVy7Y32165021650eucas1p1k;
        Mon,  2 May 2022 23:13:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 03.51.10009.09560726; Tue,  3
        May 2022 00:13:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220502231320eucas1p13095408ebf98c36f16b5483154e0e8e5~rbLH631U80771507715eucas1p1I;
        Mon,  2 May 2022 23:13:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220502231320eusmtrp249f17587d36192005f388f10e66e14ee~rbLH6NPH81389913899eusmtrp2E;
        Mon,  2 May 2022 23:13:20 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-e3-627065909a8e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C5.85.09404.F8560726; Tue,  3
        May 2022 00:13:19 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220502231319eusmtip1ec77346424a1be48207ed3ba70edf175~rbLHSZP7K0906209062eusmtip1N;
        Mon,  2 May 2022 23:13:19 +0000 (GMT)
Message-ID: <45849b63-d7a8-5cc3-26ad-256a28d09991@samsung.com>
Date:   Tue, 3 May 2022 01:13:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Ym/Z7PYPqvWPEjuL@alley>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djP87oTUguSDO5/FLdoXryezWLblfmM
        Fgtmc1tc3jWHzeL/46+sFvs6HjBZ7N64iM1i86apzA4cHrMbLrJ4tOy7xe7x7tw5do/9c9ew
        e2xeUu+xfstVFo/Pm+QC2KO4bFJSczLLUov07RK4Mn50dbEXnNerODijhaWB8Z1aFyMHh4SA
        icTXa3ldjFwcQgIrGCU+rN/ECuF8YZSY++ozE4TzmVFiwvY/bF2MnGAdyz9fZYRILGeUuLdg
        GTuE85FR4vn1E+wgVbwCdhK7nvcxgtgsAioSq//uZYOIC0qcnPmEBcQWFUiSmLvvHjPIHcIC
        ERJte0NBwswC4hK3nsxnArFFBJQkXs2/ywwRX8Ak0dqQBmKzCRhKdL3tAhvJKaAqsePxOxaI
        GnmJ5q2zmUHukRD4wCHxes0rqKtdJGataWaCsIUlXh3fwg5hy0j83wmyDBQW+RJ/ZxhDhCsk
        rr1ewwxhW0vcOfeLDaSEWUBTYv0ufYiwo8SUX33sEJ18EjfeCkJcwCcxadt0Zogwr0RHmxBE
        tZrErOPr4HYevHCJeQKj0iykIJmF5PdZSH6ZhbB3ASPLKkbx1NLi3PTUYsO81HK94sTc4tK8
        dL3k/NxNjMC0dPrf8U87GOe++qh3iJGJg/EQowQHs5IIb9uGnCQh3pTEyqrUovz4otKc1OJD
        jNIcLErivMmZGxKFBNITS1KzU1MLUotgskwcnFINTLKhL21FT8pPk1h1Pf32zJ8FwjYBEzZ/
        CthX5T1zk7KJz6vm40H+5R0VXRWGB9IvrDq1t/lm/Jo7IjYpVw1eiivPNC5JveowT70+wUYj
        396rdE7tMqlbD5dpLOOdVl3vwHBiMbuYkfaNH7lrPzn2P5I/ovJ/2vnp/o/vLXuUL3rSi9l8
        8dp0drdPTud5Wp955Fc7bxD4dzLOOFFMVi64rjuT1/3zMtVbKyTvnvvb77A/T/1T9Cq57+m1
        bS/ml0Zf0fslmX3Qf62QUdHyu3u1arMePD51r0tRteNUnZewjIHwuoN7b2bbno6wWf2RM2T9
        2Xb1yCeXtn9jCDTu9en9vrTby7TI4ktd5o+LL6JdlViKMxINtZiLihMB/++gQroDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xu7r9qQVJBufPWlg0L17PZrHtynxG
        iwWzuS0u75rDZvH/8VdWi30dD5gsdm9cxGaxedNUZgcOj9kNF1k8WvbdYvd4d+4cu8f+uWvY
        PTYvqfdYv+Uqi8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2
        NimpOZllqUX6dgl6GT+6utgLzutVHJzRwtLA+E6ti5GTQ0LARGL556uMXYxcHEICSxklLhy6
        wgKRkJE4Oa2BFcIWlvhzrYsNxBYSeM8osXQJD4jNK2Anset5HyOIzSKgIrH67142iLigxMmZ
        T8DmiAokSbzY9hyohoNDWCBC4n0vWJhZQFzi1pP5TCC2iICSxKv5d5lBbmAWWMAksW7RGqiD
        XjJLzJ7+G6yKTcBQoustxBGcAqoSOx6/g5pkJtG1tYsRwpaXaN46m3kCo9AsJHfMQrJwFpKW
        WUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMx23Hfm7Zwbjy1Ue9Q4xMHIyHGCU4
        mJVEeNs25CQJ8aYkVlalFuXHF5XmpBYfYjQFBsZEZinR5HxgQsgriTc0MzA1NDGzNDC1NDNW
        Euf1LOhIFBJITyxJzU5NLUgtgulj4uCUamDyYRHa7eudd0qqeoeL6PaCxd4aHF3zPkycuydj
        ZnYtx56Pkg83Rlwvt571+1aLvv/Svqtt9wWFG/2sJ85n+JmT1JmxpswrckLuZZffP+7t2vhx
        v8TfnJC5XXNun3KPyzt39MrSvZ+mPV3D8+mE66WvJXNFuqP9eWbf49oyI/W1shuf9UG5rT/f
        zi/tELWqjGUr37j6z5UHdVabngttWZYUc+LE9BfMXtNrd1y7FaT70fKcZ/MzVZfAnLpXSc7X
        Hge6rmlL9zpbnS3Ltqa9luvnq6XzeC/9mbnjvSzTXa2WfE3nlDajQ7dFz/b72u2IrLiiFsfc
        aFjDp5s3/+vVU8sEd7BqzD44Y52mhGHaZBcTJZbijERDLeai4kQA30i3J1ADAAA=
X-CMS-MailID: 20220502231320eucas1p13095408ebf98c36f16b5483154e0e8e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c
References: <Ymfgis0EAw0Oxoa5@alley> <Ymfwk+X0CHq6ex3s@alley>
        <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
        <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com> <Ymjy3rHRenba7r7R@alley>
        <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
        <87fslyv6y3.fsf@jogness.linutronix.de>
        <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
        <87k0b6blz2.fsf@jogness.linutronix.de>
        <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com> <Ym/Z7PYPqvWPEjuL@alley>
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 02.05.2022 15:17, Petr Mladek wrote:
> On Mon 2022-05-02 11:19:07, Marek Szyprowski wrote:
>> On 30.04.2022 18:00, John Ogness wrote:
>>> On 2022-04-29, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>>> The same issue happens if I boot with init=/bin/bash
>>> Very interesting. Since you are seeing all the output up until you try
>>> doing something, I guess receiving UART data is triggering the issue.
>> Right, this is how it looks like.
>>
>>>> I found something really interesting. When lockup happens, I'm still
>>>> able to log via ssh and trigger any magic sysrq action via
>>>> /proc/sysrq-trigger.
>>> If you boot the system and directly login via ssh (without sending any
>>> data via serial), can you trigger printk output on the UART? For
>>> example, with:
>>>
>>>       echo hello > /dev/kmsg
>>>
>>> (You might need to increase your loglevel to see it.)
>> Data written to /dev/kmsg and all kernel logs were always displayed
>> correctly. Also data written directly to /dev/ttyAML0 is displayed
>> properly on the console. The latter doesn't however trigger the input
>> related activity.
>>
>> It looks that the data read from the uart is delivered only if other
>> activity happens on the kernel console. If I type 'reboot' and press
>> enter, nothing happens immediately. If I type 'date >/dev/ttyAML0' via
>> ssh then, I only see the date printed on the console. However if I type
>> 'date >/dev/kmsg', the the date is printed and reboot happens.
> This is really interesting.
>
> 'date >/dev/kmsg' should be handled like a normal printk().
> It should get pushed to the console using printk kthread,
> that calls call_console_driver() that calls con->write()
> callback. In our case, it should be meson_serial_console_write().
>
> I am not sure if meson_serial_console_write() is used also
> when writing via /dev/ttyAML0.
>
>>>> It turned out that the UART console is somehow blocked, but it
>>>> receives and buffers all the input. For example after issuing "echo
>>>>    >/proc/sysrq-trigger" from the ssh console, the UART console has been
>>>> updated and I see the magic sysrq banner and then all the commands I
>>>> blindly typed in the UART console! However this doesn't unblock the
>>>> console.
>>> sysrq falls back to direct printing. This would imply that the kthread
>>> printer is somehow unable to print.
>>>
>>>> Here is the output of 't' magic sys request:
>>>>
>>>> https://protect2.fireeye.com/v1/url?k=8649f24d-e73258c4-86487902-74fe48600034-a2ca6bb18361467d&q=1&e=1bc4226f-a422-42b9-95e8-128845b8609f&u=https%3A%2F%2Fpastebin.com%2FfjbRuy4f
>>> It looks like the call trace for the printing kthread (pr/ttyAML0) is
>>> corrupt.
>> Right, good catch. For comparison, here is a 't' sysrq result from the
>> 'working' serial console (next-20220429), which happens usually 1 of 4
>> boots:
>>
>> https://protect2.fireeye.com/v1/url?k=610106f1-008a13b6-61008dbe-000babff99aa-11083c39c44861df&q=1&e=2eafad9e-c5d2-4696-9d78-f3b5885256dc&u=https%3A%2F%2Fpastebin.com%2Fmp8zGFbW
> Strange. The backtrace is weird here too:
>
> [   50.514509] task:pr/ttyAML0      state:R  running task     stack:    0 pid:   65 ppid:     2 flags:0x00000008
> [   50.514540] Call trace:
> [   50.514548]  __switch_to+0xe8/0x160
> [   50.514561]  meson_serial_console+0x78/0x118
>
> There should be kthread() and printk_kthread_func() on the stack.
>
> Hmm,  meson_serial_console+0x78/0x118 is weird on its own.
> meson_serial_console is the name of the structure. I would
> expect a name of the .write callback, like
> meson_serial_console_write()

Well, this sounds a bit like a stack corruption. For the reference, I've 
checked what magic sysrq 't' reports for my other test boards:

RaspberryPi4:

[  166.702431] task:pr/ttyS0        state:R stack:    0 pid:   64 
ppid:     2 flags:0x00000008
[  166.711069] Call trace:
[  166.713647]  __switch_to+0xe8/0x160
[  166.717216]  __schedule+0x2f4/0x9f0
[  166.720862]  log_wait+0x0/0x50
[  166.724081] task:vfio-irqfd-clea state:I stack:    0 pid:   65 
ppid:     2 flags:0x00000008
[  166.732698] Call trace:


ARM Juno R1:

[   74.356562] task:pr/ttyAMA0      state:R  running task stack:    0 
pid:   47 ppid:     2 flags:0x00000008
[   74.356605] Call trace:
[   74.356617]  __switch_to+0xe8/0x160
[   74.356637]  amba_console+0x78/0x118
[   74.356657] task:kworker/2:1     state:I stack:    0 pid:   48 
ppid:     2 flags:0x00000008
[   74.356695] Workqueue:  0x0 (mm_percpu_wq)
[   74.356738] Call trace:


QEMU virt/arm64:

[  174.155760] task:pr/ttyAMA0      state:S stack:    0 pid:   26 
ppid:     2 flags:0x00000008
[  174.156305] Call trace:
[  174.156529]  __switch_to+0xe8/0x160
[  174.157131]  0xffff5ebbbfdd62d8


In the last case it doesn't happen always. In the other runs I got the 
following log from QEMU virt/arm64:

[  200.537579] task:pr/ttyAMA0      state:S stack:    0 pid:   26 
ppid:     2 flags:0x00000008
[  200.538121] Call trace:
[  200.538341]  __switch_to+0xe8/0x160
[  200.538583]  __schedule+0x2f4/0x9f0
[  200.538822]  schedule+0x54/0xd0
[  200.539047]  printk_kthread_func+0x2d8/0x3bc
[  200.539301]  kthread+0x118/0x11c
[  200.539523]  ret_from_fork+0x10/0x20


I hope that at least the qemu case will let you to analyze it by 
yourself. I run my test system with the following command:

qemu-system-aarch64 -kernel virt/Image -append "console=ttyAMA0 
root=/dev/vda rootwait" -M virt -cpu cortex-a57 -smp 2 -m 1024 -device 
virtio-blk-device,drive=virtio-blk0 -drive 
file=qemu-virt-rootfs.raw,id=virtio-blk0,if=none,format=raw -netdev 
user,id=user -device virtio-net-device,netdev=user -display none


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

