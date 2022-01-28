Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79BA49F2B3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbiA1E71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiA1E7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:59:25 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D30EC061714;
        Thu, 27 Jan 2022 20:59:24 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nDJM1-0007kV-SD; Fri, 28 Jan 2022 05:59:21 +0100
Message-ID: <47c53a2b-29c1-9e89-f15f-006c1454c249@leemhuis.info>
Date:   Fri, 28 Jan 2022 05:59:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Regression with 5021d709b31b ("tty: serial: Use fifo in 8250
 console driver")
Content-Language: en-BS
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Wander Lairson Costa <wander@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <YfMpk7DM9zA7NfmI@debian>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YfMpk7DM9zA7NfmI@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1643345964;bf48cab5;
X-HE-SMSGID: 1nDJM1-0007kV-SD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[TLDR: I'm adding this regression to regzbot, the Linux kernel
regression tracking bot; most text you find below is compiled from a few
templates paragraphs some of you might have seen already.]

Hi, this is your Linux kernel regression tracker speaking.

Adding the regression mailing list to the list of recipients, as it
should be in the loop for all regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 28.01.22 00:24, Sudip Mukherjee wrote:
> 
> Not sure if this has been reported before but since last few weeks I am
> seeing a problem with the rpi4 serial port on my test setup. The initial
> boot message will be completely garbled as you can see at:
> https://lava.qa.codethink.co.uk/scheduler/job/543#L380.
> The last good boot was https://lava.qa.codethink.co.uk/scheduler/job/540#L390.
> 
> The bisect log:
> 
> # bad: [455e73a07f6e288b0061dfcf4fcf54fa9fe06458] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> # good: [7e7b69654724c72bd3219b71f58937845dca0b2b] Merge tag 'dma-mapping-5.17' of git://git.infradead.org/users/hch/dma-mapping
> git bisect start '455e73a07f6e288b0061dfcf4fcf54fa9fe06458' '7e7b69654724c72bd3219b71f58937845dca0b2b'
> # bad: [342465f5337f7bd5b8bd3b6f939ac12b620cbb43] Merge tag 'tty-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> git bisect bad 342465f5337f7bd5b8bd3b6f939ac12b620cbb43
> # good: [6dc69d3d0d18d587ab9d809fe060ba4417cf0279] Merge tag 'driver-core-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> git bisect good 6dc69d3d0d18d587ab9d809fe060ba4417cf0279
> # good: [e269f7acdc53623769da31135f60afeb3a65eaff] staging: r8188eu: remove the private ioctl "wps_assoc_req_ie"
> git bisect good e269f7acdc53623769da31135f60afeb3a65eaff
> # bad: [ad234e2bac274a43c9fa540bde8cd9f0c627b71f] tty: serial: meson: Drop the legacy compatible strings and clock code
> git bisect bad ad234e2bac274a43c9fa540bde8cd9f0c627b71f
> # good: [c66453ce8af8bac78a72ba4e21fd9a86720127d7] tty: fix kernel-doc in n_tty.c
> git bisect good c66453ce8af8bac78a72ba4e21fd9a86720127d7
> # good: [0882b473b084df31288003b3bee974aabac9dcf9] tty: serial: samsung: Enable console as module
> git bisect good 0882b473b084df31288003b3bee974aabac9dcf9
> # bad: [b4a29b94804c4774f22555651296b838df6ec0e4] serial: 8250: Move Alpha-specific quirk out of the core
> git bisect bad b4a29b94804c4774f22555651296b838df6ec0e4
> # good: [e822b4973f49015e1c6f63b91c8641ed9bfaf229] tty/ldsem: Fix syntax errors in comments
> git bisect good e822b4973f49015e1c6f63b91c8641ed9bfaf229
> # good: [fb09d0ac07725b442b32dbf53f0ab0bea54804e9] tty: Fix the keyboard led light display problem
> git bisect good fb09d0ac07725b442b32dbf53f0ab0bea54804e9
> # bad: [5021d709b31b8a14317998a33cbc78be0de9ab30] tty: serial: Use fifo in 8250 console driver
> git bisect bad 5021d709b31b8a14317998a33cbc78be0de9ab30
> # good: [adbfddc757aec1ed54ccb35c4a7ca9170df827e0] docs/driver-api: Replace a comma in the n_gsm.rst with a double colon
> git bisect good adbfddc757aec1ed54ccb35c4a7ca9170df827e0
> # first bad commit: [5021d709b31b8a14317998a33cbc78be0de9ab30] tty: serial: Use fifo in 8250 console driver
> 
> And, indeed reverting 5021d709b31b ("tty: serial: Use fifo in 8250 console
> driver") on top of 23a46422c561 ("Merge tag 'net-5.17-rc2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net") fixes the problem
> for me.
> 
> This is seen on every boot and I will be happy to test any patch.

Thanks for the report.

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 5021d709b31b
#regzbot title serial: boot message completely garbled with rpi4 serial port
#regzbot ignore-activity

Reminder: when fixing the issue, please add a 'Link:' tag with the URL
to the report (the parent of this mail) as explained in
'Documentation/process/submitting-patches.rst'. Regzbot then will
automatically mark the regression as resolved once the fix lands in the
appropriate tree. For more details about regzbot see footer.

Sending this to everyone that got the initial report, to make all aware
of the tracking. I also hope that messages like this motivate people to
directly get at least the regression mailing list and ideally even
regzbot involved when dealing with regressions, as messages like this
wouldn't be needed then.

Don't worry, I'll send further messages wrt to this regression just to
the lists (with a tag in the subject so people can filter them away), as
long as they are intended just for regzbot. With a bit of luck no such
messages will be needed anyway.

Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat)

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply, that's in everyone's interest.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.

---
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and/or the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
tell #regzbot about it in the report, as that will ensure the regression
gets on the radar of regzbot and the regression tracker. That's in your
interest, as they will make sure the report won't fall through the
cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include a 'Link:' tag to the report in the commit message, as explained
in Documentation/process/submitting-patches.rst
That aspect was recently was made more explicit in commit 1f57bd42b77c:
https://git.kernel.org/linus/1f57bd42b77c
