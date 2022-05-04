Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153EA519737
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbiEDGJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344955AbiEDGJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:09:02 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD0462F3
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 23:05:27 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220504060524euoutp01de4b634467e6472a1a5579a9832aa0ad~r0cMRF9A72662326623euoutp01E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:05:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220504060524euoutp01de4b634467e6472a1a5579a9832aa0ad~r0cMRF9A72662326623euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651644324;
        bh=FLkg9ETFDgnlpeJtxVurNjsTUL6YEB4yBZbwGabFcc4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=N2vR0IZfzM6oy7ecAoLdFIPMKHetY5CjDkrtsxXj5TIgCxpEKEHkgD8SSUNS68twt
         HLXSySvCwUr+/+HaQtg4TgBlrGjM0sAS2m3N8Bo51PexqUIwKcks7O1nXQmXFervzB
         fNLA4OHoAU064NDYC+BnkUSINHMIIhcZC3IAD7fQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220504060523eucas1p2136677eb9dc8bd0a63cfb872012adc81~r0cL3hJue2468624686eucas1p21;
        Wed,  4 May 2022 06:05:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 48.E2.10009.3A712726; Wed,  4
        May 2022 07:05:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220504060523eucas1p23233e44717698588e1826a2538a6e087~r0cLduXBT0341203412eucas1p2M;
        Wed,  4 May 2022 06:05:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220504060523eusmtrp1cff08ec52161c1b1b22049f0c6655813~r0cLc6hj30193301933eusmtrp1P;
        Wed,  4 May 2022 06:05:23 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-07-627217a3bc80
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7F.87.09522.3A712726; Wed,  4
        May 2022 07:05:23 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220504060522eusmtip11b2d2e9be9eaf763d0d9a9561a7db10a~r0cK2_97p1848518485eusmtip1k;
        Wed,  4 May 2022 06:05:22 +0000 (GMT)
Message-ID: <05f3f8bf-1fab-f48f-e581-479c6fa123ca@samsung.com>
Date:   Wed, 4 May 2022 08:05:22 +0200
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
In-Reply-To: <YnDQYIWLZMjOPKK5@alley>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djP87qLxYuSDHbfUbFoXryezWLblfmM
        Fgtmc1tc3jWHzeL/46+sFvs6HjBZ7N64iM1i86apzA4cHrMbLrJ4tOy7xe7x7tw5do/9c9ew
        e2xeUu+xfstVFo/Pm+QC2KO4bFJSczLLUov07RK4Mpa/LyxYZlCx4v5R1gbGT+pdjBwcEgIm
        EgvWuXQxcnIICaxglLgxOwTC/sIocfRBCYT9mVHi4sM0EBukvPfFd5YuRi6g+HJGiQdH1zNC
        OB8ZJf5s2cEEUsUrYCfRevMBC4jNIqAicfp1ByNEXFDi5MwnYHFRgSSJufvuMYMcISwQIdG2
        NxQkzCwgLnHryXywMSICShKv5t9lhogvYJJobQA7gk3AUKLrbRcbiM0poCrRsb2VEaJGXqJ5
        62xmkHskBD5wSFw5cZ4F4moXiddfnrJD2MISr45vgbJlJE5P7mGBBES+xN8ZxhDhColrr9cw
        Q9jWEnfO/WIDKWEW0JRYv0sfIuwoMeVXHztEJ5/EjbeCEBfwSUzaNp0ZIswr0dEmBFGtJjHr
        +Dq4nQcvXGKewKg0CylIZiH5fRaSX2Yh7F3AyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/
        dxMjMB2d/nf80w7Gua8+6h1iZOJgPMQowcGsJMLrvLQgSYg3JbGyKrUoP76oNCe1+BCjNAeL
        kjhvcuaGRCGB9MSS1OzU1ILUIpgsEwenVANT6+716w9P0Gj425/jEix/7ejNxyIXtgjs+vLm
        mri+1pkJBc8XPfAQdLkW0qwiNWnHhqMxBU80FdPNao3/ru2Yk7D253TxMrmTTQLWu0M/F7We
        Lfynu6bzqdXUbxphATbbF7GKbtf778p8jFlBLlv55BWu9ve5F276M0/8wP7e+2+jnGWCJ/cX
        36rrs49NU58WsWV5r2Sp6idZkRU+E4SmJToeKsrL/lV4yTz6Kt+hQH6vQ2rGP58JfA3YLBtz
        c3JHYcqaOb8Oyy2OEExdmLf1p/OzV4d0Cj5fZun1OnFgysasDenzTxnfvsgVuv1M1h2bi7VX
        NnHbmKX1/li7KPbz7MBrb01W1zFmqsT8PF90QomlOCPRUIu5qDgRAIaTb2a2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7qLxYuSDB5/YLdoXryezWLblfmM
        Fgtmc1tc3jWHzeL/46+sFvs6HjBZ7N64iM1i86apzA4cHrMbLrJ4tOy7xe7x7tw5do/9c9ew
        e2xeUu+xfstVFo/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTt
        bFJSczLLUov07RL0Mpa/LyxYZlCx4v5R1gbGT+pdjJwcEgImEr0vvrOA2EICSxkljp/ggYjL
        SJyc1sAKYQtL/LnWxdbFyAVU855RYvrPN2wgCV4BO4nWmw/AmlkEVCROv+5ghIgLSpyc+QQs
        LiqQJPFi23OgOAeHsECExPtesDCzgLjErSfzmUBsEQEliVfz7zKDzGcWWMAksW7RGkaIZc0s
        Eu2337ODVLEJGEp0ve0CW8wpoCrRsb2VEWKSmUTX1i4oW16ieets5gmMQrOQ3DELycJZSFpm
        IWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzAatx37uXkH47xXH/UOMTJxMB5ilOBg
        VhLhdV5akCTEm5JYWZValB9fVJqTWnyI0RQYGBOZpUST84HpIK8k3tDMwNTQxMzSwNTSzFhJ
        nNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgWnF6egWFcGbbVJHtEsNPwYzHbQrZek22ls07d29
        hU6X/ggzhanFCBQVH/u0a9ra9J3xNf/zOnV2yH3T73cNDJtbzcJiu9Au+7rSd8l0mf995QEH
        IyM3bIp57x2/QNxm1lYpppqLQdsrnz6/9rFG4vb3zcbHzRtc/lrNksmcdvjj3eXPwn2fTFF6
        pK7yKe7n/YbXOW+2hekHzb58R2jVj8RFb1kmL1WT4J2gYV9ntXOD52LbJ5UfmZZ5T5gkdUx9
        doQZ9157r29GnS8Y+Msd5j48wrspe1auFktdhPSEpheHHd6IPrXbXvnnXZvM16vFfDMOaW00
        ejDP+uTB5CvrE2a53HEKObCZ3/N+UdeD5yeVWIozEg21mIuKEwHYfSBDTwMAAA==
X-CMS-MailID: 20220504060523eucas1p23233e44717698588e1826a2538a6e087
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c
References: <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
        <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com> <Ymjy3rHRenba7r7R@alley>
        <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
        <87fslyv6y3.fsf@jogness.linutronix.de>
        <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
        <87k0b6blz2.fsf@jogness.linutronix.de>
        <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com> <Ym/Z7PYPqvWPEjuL@alley>
        <45849b63-d7a8-5cc3-26ad-256a28d09991@samsung.com> <YnDQYIWLZMjOPKK5@alley>
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03.05.2022 08:49, Petr Mladek wrote:
> On Tue 2022-05-03 01:13:19, Marek Szyprowski wrote:
>> On 02.05.2022 15:17, Petr Mladek wrote:
>>> On Mon 2022-05-02 11:19:07, Marek Szyprowski wrote:
>>>> On 30.04.2022 18:00, John Ogness wrote:
>>>>> On 2022-04-29, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>>>>> The same issue happens if I boot with init=/bin/bash
>>>>> Very interesting. Since you are seeing all the output up until you try
>>>>> doing something, I guess receiving UART data is triggering the issue.
>>>> Right, this is how it looks like.
>>>>
>>>>>> I found something really interesting. When lockup happens, I'm still
>>>>>> able to log via ssh and trigger any magic sysrq action via
>>>>>> /proc/sysrq-trigger.
>>>>> If you boot the system and directly login via ssh (without sending any
>>>>> data via serial), can you trigger printk output on the UART? For
>>>>> example, with:
>>>>>
>>>>>        echo hello > /dev/kmsg
>>>>>
>>>>> (You might need to increase your loglevel to see it.)
>>>> Data written to /dev/kmsg and all kernel logs were always displayed
>>>> correctly. Also data written directly to /dev/ttyAML0 is displayed
>>>> properly on the console. The latter doesn't however trigger the input
>>>> related activity.
>>>>
>>>> It looks that the data read from the uart is delivered only if other
>>>> activity happens on the kernel console. If I type 'reboot' and press
>>>> enter, nothing happens immediately. If I type 'date >/dev/ttyAML0' via
>>>> ssh then, I only see the date printed on the console. However if I type
>>>> 'date >/dev/kmsg', the the date is printed and reboot happens.
>>> This is really interesting.
>>>
>>> 'date >/dev/kmsg' should be handled like a normal printk().
>>> It should get pushed to the console using printk kthread,
>>> that calls call_console_driver() that calls con->write()
>>> callback. In our case, it should be meson_serial_console_write().
>>>
>>> I am not sure if meson_serial_console_write() is used also
>>> when writing via /dev/ttyAML0.
>>>
>>>>>> It turned out that the UART console is somehow blocked, but it
>>>>>> receives and buffers all the input. For example after issuing "echo
>>>>>>     >/proc/sysrq-trigger" from the ssh console, the UART console has been
>>>>>> updated and I see the magic sysrq banner and then all the commands I
>>>>>> blindly typed in the UART console! However this doesn't unblock the
>>>>>> console.
>>>>> sysrq falls back to direct printing. This would imply that the kthread
>>>>> printer is somehow unable to print.
>>>>>
>>>>>> Here is the output of 't' magic sys request:
>>>>>>
>>>>>> https://protect2.fireeye.com/v1/url?k=8649f24d-e73258c4-86487902-74fe48600034-a2ca6bb18361467d&q=1&e=1bc4226f-a422-42b9-95e8-128845b8609f&u=https%3A%2F%2Fpastebin.com%2FfjbRuy4f
>>>>> It looks like the call trace for the printing kthread (pr/ttyAML0) is
>>>>> corrupt.
>>>> Right, good catch. For comparison, here is a 't' sysrq result from the
>>>> 'working' serial console (next-20220429), which happens usually 1 of 4
>>>> boots:
>>>>
>>>> https://protect2.fireeye.com/v1/url?k=610106f1-008a13b6-61008dbe-000babff99aa-11083c39c44861df&q=1&e=2eafad9e-c5d2-4696-9d78-f3b5885256dc&u=https%3A%2F%2Fpastebin.com%2Fmp8zGFbW
>>> Strange. The backtrace is weird here too:
>>>
>>> [   50.514509] task:pr/ttyAML0      state:R  running task     stack:    0 pid:   65 ppid:     2 flags:0x00000008
>>> [   50.514540] Call trace:
>>> [   50.514548]  __switch_to+0xe8/0x160
>>> [   50.514561]  meson_serial_console+0x78/0x118
>>>
>>> There should be kthread() and printk_kthread_func() on the stack.
>>>
>>> Hmm,  meson_serial_console+0x78/0x118 is weird on its own.
>>> meson_serial_console is the name of the structure. I would
>>> expect a name of the .write callback, like
>>> meson_serial_console_write()
>> Well, this sounds a bit like a stack corruption. For the reference, I've
>> checked what magic sysrq 't' reports for my other test boards:
>>
>> RaspberryPi4:
>>
>> [  166.702431] task:pr/ttyS0        state:R stack:    0 pid:   64
>> ppid:     2 flags:0x00000008
>> [  166.711069] Call trace:
>> [  166.713647]  __switch_to+0xe8/0x160
>> [  166.717216]  __schedule+0x2f4/0x9f0
>> [  166.720862]  log_wait+0x0/0x50
>> [  166.724081] task:vfio-irqfd-clea state:I stack:    0 pid:   65
>> ppid:     2 flags:0x00000008
>> [  166.732698] Call trace:
>>
>>
>> ARM Juno R1:
>>
>> [   74.356562] task:pr/ttyAMA0      state:R  running task stack:    0
>> pid:   47 ppid:     2 flags:0x00000008
>> [   74.356605] Call trace:
>> [   74.356617]  __switch_to+0xe8/0x160
>> [   74.356637]  amba_console+0x78/0x118
>> [   74.356657] task:kworker/2:1     state:I stack:    0 pid:   48
>> ppid:     2 flags:0x00000008
>> [   74.356695] Workqueue:  0x0 (mm_percpu_wq)
>> [   74.356738] Call trace:
>>
>>
>> QEMU virt/arm64:
>>
>> [  174.155760] task:pr/ttyAMA0      state:S stack:    0 pid:   26
>> ppid:     2 flags:0x00000008
>> [  174.156305] Call trace:
>> [  174.156529]  __switch_to+0xe8/0x160
>> [  174.157131]  0xffff5ebbbfdd62d8
> You mentioned in the other mail that the other boards work as
> expected. I mean that console gets stuck only on the meson board.
> Is it true, please?

Right. Even on Meson based boards the console is operational about 1 of 
4 boots.


> The stack looks really weird. But another weird thing is that
> even the meson board is able to show the messages, for example,
> using echo hello >/dev/kmsg. It suggests that the kthreads
> somehow work.
>
> There is also a possibility that this code path is optimized
> some special way and the unwinder has troubles to show
> the stack correctly.

I doubt that this is a result of the compiler's optimization. See my 
logs from QEMU's virt machine. I've managed to capture 2 states of 
ttyAMA0 task. One shows some kind of stack corruption imho. It doesn't 
happen always though.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

