Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F844970B9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 10:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiAWJ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 04:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiAWJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 04:28:29 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0060C06173B;
        Sun, 23 Jan 2022 01:28:28 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nBZAc-0002u8-K7; Sun, 23 Jan 2022 10:28:22 +0100
Message-ID: <7672718f-b34e-225d-ff53-1199026728b7@leemhuis.info>
Date:   Sun, 23 Jan 2022 10:28:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [REGRESSION] Bluetooth not working on 5.15+ since "Bluetooth:
 Move shutdown callback before flushing tx and rx queue"
Content-Language: en-BS
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "An, Tedd" <tedd.an@intel.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "andypalmadi@gmail.com" <andypalmadi@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CAJvGw+AJ5dHSb50RtJHnjbhMVQa+rJgYznFV4t-iaO0qx+W-jw@mail.gmail.com>
 <fbc36e8ebdd9222f84322d54d9114f58c225547e.camel@intel.com>
 <e3e7147e-dd4c-59a9-5dba-5ddcd2e3130f@leemhuis.info>
 <38b569e4-2e9f-0155-4a5c-52876e8ca38a@leemhuis.info>
In-Reply-To: <38b569e4-2e9f-0155-4a5c-52876e8ca38a@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1642930108;3c323245;
X-HE-SMSGID: 1nBZAc-0002u8-K7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Top-posting for once, to make this easy accessible to everyone.

Coldolt, could you please check if this regression is still in 5.17-rc1
or 5.16.2? I wonder if this patch fixed things:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.16.y&id=8e8cae520210139aab4b701a822bbefb13b8f007

Ciao, Thorsten

#regzbot poke

On 20.01.22 14:08, Thorsten Leemhuis wrote:
> On 10.12.21 10:16, Thorsten Leemhuis wrote:
>> Hi, this is your Linux kernel regression tracker speaking.
> 
> /me again
> 
>> On 10.12.21 02:10, An, Tedd wrote:
>>> On Fri, 2021-12-10 at 01:36 +0200, coldolt wrote:
>>>> After a restart, bluetooth doesn't work since commit 0ea53674d07f
>>>> "Bluetooth: Move shutdown callback before flushing tx and rx queue"
>>>>
>>>> bluetoothctl doesn't list any controllers and I get the following in
>>>> dmesg | grep -i bluetooth
>>>>
>>>> [    2.634812] Bluetooth: Core ver 2.22
>>>> [    2.634843] NET: Registered PF_BLUETOOTH protocol family
>>>> [    2.634845] Bluetooth: HCI device and connection manager initialized
>>>> [    2.634850] Bluetooth: HCI socket layer initialized
>>>> [    2.634853] Bluetooth: L2CAP socket layer initialized
>>>> [    2.634858] Bluetooth: SCO socket layer initialized
>>>> [    4.077788] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>>>> [    4.077794] Bluetooth: BNEP filters: protocol multicast
>>>> [    4.077799] Bluetooth: BNEP socket layer initialized
>>>> [    4.078219] random: bluetoothd: uninitialized urandom read (4 bytes read)
>>>> [    4.852835] Bluetooth: hci0: Reading Intel version command failed (-110)
>>>> [    4.852838] Bluetooth: hci0: command 0xfc05 tx timeout
>>>>
>>>> However, it works after a cold start or after putting the computer to sleep.
>>>>
>>>> Before 83f2dafe2a62 "Bluetooth: btintel: Refactoring setup routine for
>>>> legacy ROM sku", it always works after a restart, but from that commit
>>>> up until before 0ea53674d07f it either works or doesn't work after a
>>>> restart depending on if before restart it was working or not, meaning
>>>> it stays working or stays not working.
>>>>
>>>> Also on the first restart from before 83f2dafe2a62 into 0ea53674d07f
>>>> or later it works, but then restarting again into 0ea53674d07f or
>>>> later it no longer works. So it seems that 0ea53674d07f and later puts
>>>> the bluetooth in a nonworking state if you restart from it, but before
>>>> 83f2dafe2a62 it puts it back into a working state at startup, and in
>>>> between it doesn't do either, i.e. it stays the way it was.
>>>>
>>>> I have a Dell Latitude E5550 laptop with an Intel 7265 wifi/bluetooth
>>>> card REV=0x210 firmware version 29.4063824552.0 7265D-29. I'm on Arch
>>>> Linux, the problem is still there on 5.16-rc4.
>>>>
>>>> Here is a thread on the Arch Linux forums with several people with the
>>>> same problem, for some of them it got fixed with a kernel update or by
>>>> reloading modules, but not for everybody, including me
>>>> https://bbs.archlinux.org/viewtopic.php?id=271459
>>>>
>>>> #regzbot introduced 0ea53674d07f
>>
>> Many thx for directly getting regzbot involved! :-D
>>
>>> This issue is under investigation to find the root cause and proper solution.
>>
>> Only internally? Or are there any other related public discussions that
>> are relevant to this and thus good to be aware of?
> 
> What's the status here? It looks like there was no progress since 41
> days, which is awfully long even with the festive season in between.
> Could anyone provide a status update please?
> 
> Ciao, Thorsten
> 
> #regzbot poke
> 
> P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
> on my table. I can only look briefly into most of them. Unfortunately
> therefore I sometimes will get things wrong or miss something important.
> I hope that's not the case here; if you think it is, don't hesitate to
> tell me about it in a public reply, that's in everyone's interest.
> 
> BTW, I have no personal interest in this issue, which is tracked using
> regzbot, my Linux kernel regression tracking bot
> (https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
> this mail to get things rolling again and hence don't need to be CC on
> all further activities wrt to this regression.
> 
>>> The downloaded firmware breaks the behavior though, we need to investigate
>>> further to see if it can be fixed in firmware or fix in the driver.
>>
>> The answer from my point is simple: it needs to be fixed in the kernel,
>> not just in the firmware, otherwise people that update the kernel
>> without updating the firmware at the same time will run into a
>> regression -- and that is not acceptable by kernel development standards.
>>
>> Ciao, Thorsten
>>
>> P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
>> on my table. I can only look briefly into most of them. Unfortunately
>> therefore I sometimes will get things wrong or miss something important.
>> I hope that's not the case here; if you think it is, don't hesitate to
>> tell me about it in a public reply. That's in everyone's interest, as
>> what I wrote above might be misleading to everyone reading this; any
>> suggestion I gave they thus might sent someone reading this down the
>> wrong rabbit hole, which none of us wants.
>>
>> BTW, I have no personal interest in this issue, which is tracked using
>> regzbot, my Linux kernel regression tracking bot
>> (https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
>> this mail to get things rolling again and hence don't need to be CC on
>> all further activities wrt to this regression.
