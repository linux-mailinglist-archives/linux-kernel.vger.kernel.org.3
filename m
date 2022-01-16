Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2348FC28
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 11:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiAPKV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 05:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiAPKV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 05:21:27 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF43C061574;
        Sun, 16 Jan 2022 02:21:26 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n92f6-0005Dc-NR; Sun, 16 Jan 2022 11:21:24 +0100
Message-ID: <5bd2dba7-c56f-4d8c-2f28-f2428afdcead@leemhuis.info>
Date:   Sun, 16 Jan 2022 11:21:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: ChipIdea USB regression
Content-Language: en-BS
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, robh@kernel.org
Cc:     peter.chen@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20220114105620.GK18506@ediswmail.ad.cirrus.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220114105620.GK18506@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1642328486;f136cb5b;
X-HE-SMSGID: 1n92f6-0005Dc-NR
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

On 14.01.22 11:56, Charles Keepax wrote:
> Hi guys,
> 
> My Zynq based board stopped booting today, a bisect points to this
> patch:
> 
> commit 0f153a1b8193 ("usb: chipidea: Set the DT node on the child device")

Thanks for the report.

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 0f153a1b8193
#regzbot title usb: chipidea: Zynq based board stopped booting today
#regzbot ignore-activity

Reminder: when fixing the issue, please add a 'Link:' tag with the URL
to the report (the parent of this mail) using the kernel.org redirector,
as explained in 'Documentation/process/submitting-patches.rst'. Regzbot
then will automatically mark the regression as resolved once the fix
lands in the appropriate tree. For more details about regzbot see footer.

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



> It looks like it gets stuck in some sort of boot loop of doom:
> 
> 48 locks held by swapper/0/1:
> #0: 42a2c0d8 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x12c/0x15c
> #1: 42a41cd8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
> #2: 42abdcd8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
> #3: 42abd8d8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
> #4: 42abd4d8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
> #5: 42abd0d8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
> #6: 42b00cd8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
> #7: 42b008d8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
> <snip>
> [<40100af4>] (__irq_svc) from [<40920270>] (_raw_spin_unlock_irqrestore+0x30/0x5c)
> [<40920270>] (_raw_spin_unlock_irqrestore) from [<40433238>] (klist_next+0x84/0xac)
> [<40433238>] (klist_next) from [<40503a5c>] (bus_for_each_drv+0x60/0xbc)
> [<40503a5c>] (bus_for_each_drv) from [<40505ea8>] (__device_attach+0xc4/0x164)
> [<40505ea8>] (__device_attach) from [<405047e0>] (bus_probe_device+0x28/0x84)
> [<405047e0>] (bus_probe_device) from [<405022b8>] (device_add+0x590/0x7c4)
> [<405022b8>] (device_add) from [<4050835c>] (platform_device_add+0xa8/0x1f0)
> [<4050835c>] (platform_device_add) from [<405f329c>] (ci_hdrc_add_device+0x3b4/0x434)
> [<405f329c>] (ci_hdrc_add_device) from [<405f5f0c>] (ci_hdrc_usb2_probe+0x130/0x180)
> [<405f5f0c>] (ci_hdrc_usb2_probe) from [<40507e60>] (platform_probe+0x58/0xa8)
> [<40507e60>] (platform_probe) from [<4050584c>] (really_probe+0x1d8/0x418)
> [<4050584c>] (really_probe) from [<40505c44>] (__driver_probe_device+0x1b8/0x1f0)
> [<40505c44>] (__driver_probe_device) from [<40505ca0>] (driver_probe_device+0x24/0xa4)
> [<40505ca0>] (driver_probe_device) from [<405060b0>] (__device_attach_driver+0xbc/0x110)
> [<405060b0>] (__device_attach_driver) from [<40503aa4>] (bus_for_each_drv+0xa8/0xbc)
> [<40503aa4>] (bus_for_each_drv) from [<40505ea8>] (__device_attach+0xc4/0x164)
> [<40505ea8>] (__device_attach) from [<405047e0>] (bus_probe_device+0x28/0x84)
> [<405047e0>] (bus_probe_device) from [<405022b8>] (device_add+0x590/0x7c4)
> [<405022b8>] (device_add) from [<4050835c>] (platform_device_add+0xa8/0x1f0)
> [<4050835c>] (platform_device_add) from [<405f329c>] (ci_hdrc_add_device+0x3b4/0x434)
> [<405f329c>] (ci_hdrc_add_device) from [<405f5f0c>] (ci_hdrc_usb2_probe+0x130/0x180)
> [<405f5f0c>] (ci_hdrc_usb2_probe) from [<40507e60>] (platform_probe+0x58/0xa8)
> [<40507e60>] (platform_probe) from [<4050584c>] (really_probe+0x1d8/0x418)
> [<4050584c>] (really_probe) from [<40505c44>] (__driver_probe_device+0x1b8/0x1f0)
> [<40505c44>] (__driver_probe_device) from [<40505ca0>] (driver_probe_device+0x24/0xa4)
> [<40505ca0>] (driver_probe_device) from [<405060b0>] (__device_attach_driver+0xbc/0x110)
> [<405060b0>] (__device_attach_driver) from [<40503aa4>] (bus_for_each_drv+0xa8/0xbc)
> [<40503aa4>] (bus_for_each_drv) from [<40505ea8>] (__device_attach+0xc4/0x164)
> [<40505ea8>] (__device_attach) from [<405047e0>] (bus_probe_device+0x28/0x84)
> [<405047e0>] (bus_probe_device) from [<405022b8>] (device_add+0x590/0x7c4)
> [<405022b8>] (device_add) from [<4050835c>] (platform_device_add+0xa8/0x1f0)
> [<4050835c>] (platform_device_add) from [<405f329c>] (ci_hdrc_add_device+0x3b4/0x434)
> [<405f329c>] (ci_hdrc_add_device) from [<405f5f0c>] (ci_hdrc_usb2_probe+0x130/0x180)
> [<405f5f0c>] (ci_hdrc_usb2_probe) from [<40507e60>] (platform_probe+0x58/0xa8)
> [<40507e60>] (platform_probe) from [<4050584c>] (really_probe+0x1d8/0x418)
> [<4050584c>] (really_probe) from [<40505c44>] (__driver_probe_device+0x1b8/0x1f0)
> [<40505c44>] (__driver_probe_device) from [<40505ca0>] (driver_probe_device+0x24/0xa4)
> [<40505ca0>] (driver_probe_device) from [<405060b0>] (__device_attach_driver+0xbc/0x110)
> [<405060b0>] (__device_attach_driver) from [<40503aa4>] (bus_for_each_drv+0xa8/0xbc)
> [<40503aa4>] (bus_for_each_drv) from [<40505ea8>] (__device_attach+0xc4/0x164)
> [<40505ea8>] (__device_attach) from [<405047e0>] (bus_probe_device+0x28/0x84)
> [<405047e0>] (bus_probe_device) from [<405022b8>] (device_add+0x590/0x7c4)
> 
> I will keep poking it today to see if I can figure out more of
> what is actually going wrong, but if any of you guys had any
> thoughts/suggestions or if you want me to provide any additional
> info all of those would be greatly appreciated.
> 
> Thanks,
> Charles

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
