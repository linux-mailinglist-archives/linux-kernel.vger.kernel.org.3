Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE2478E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhLQOqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhLQOqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:46:24 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1841C061574;
        Fri, 17 Dec 2021 06:46:24 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1myEV3-00026J-Qv; Fri, 17 Dec 2021 15:46:21 +0100
Message-ID: <dca67eb4-d007-2fa0-e0c2-b21d124967f1@leemhuis.info>
Date:   Fri, 17 Dec 2021 15:46:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-BS
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Brandon Nielsen <nielsenb@jetfuse.net>,
        Imre Deak <imre.deak@intel.com>
Cc:     linux-fbdev@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        amd-gfx@lists.freedesktop.org, pjones@redhat.com,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8a27c986-4767-bd29-2073-6c4ffed49bba@jetfuse.net>
 <962fe0af-a080-fc0d-15f3-203166ff4584@leemhuis.info>
Subject: Re: [Bug Report] Desktop monitor sleep regression
In-Reply-To: <962fe0af-a080-fc0d-15f3-203166ff4584@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1639752384;bc6e67f6;
X-HE-SMSGID: 1myEV3-00026J-Qv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added some CCs Geert added in his reply

On 07.12.21 08:20, Thorsten Leemhuis wrote:
> 
> [TLDR: adding this regression to regzbot; most of this mail is compiled
> from a few templates paragraphs some of you might have seen already.]
> 
> Hi, this is your Linux kernel regression tracker speaking.

/me again

What's up here? We are getting close to rc6, but there afaics wasn't any
reply of substance since the report ten days ago. Hence:

Could anybody please comment on this? Imre Deak, the commit Brandon
found in the bisection contains a patch of yours, do you maybe have an
idea what's up here?

Ciao, Thorsten

#regzbot poke

> Adding the regression mailing list to the list of recipients, as it
> should be in the loop for all regressions, as explained here:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> 
> Also adding the authors and reviewers of the culprit and two appropriate
> mailing lists.
> 
> On 07.12.21 01:21, Brandon Nielsen wrote:
>> Monitors no longer sleep properly on my system (dual monitor connected
>> via DP->DVI, amdgpu, x86_64). The monitors slept properly on 5.14, but
>> stopped during the 5.15 series. I have also filed this bug on the kernel
>> bugzilla[0] and downstream[1].
>>
>> I have performed a bisect, first "bad" commit to master is
>> 55285e21f04517939480966164a33898c34b2af2[1], the same change made it
>> into the 5.15 branch as e3b39825ed0813f787cb3ebdc5ecaa5131623647.
> 
> TWIMC: That was for 5.15.3
> 
>> I have
>> verified the issue exists in latest master
>> (a51e3ac43ddbad891c2b1a4f3aa52371d6939570).
>>
>> Steps to reproduce:
>>
>>   1. Boot system (Fedora Workstation 35 in this case)
>>   2. Log in
>>   3. Lock screen (after a few seconds, monitors will enter power save
>> "sleep" state with backlight off)
>>   4. Wait (usually no more than 30 seconds, sometimes up to a few minutes)
>>   5. Observe monitor leaving "sleep" state (backlight comes back on),
>> but nothing is displayed
>>
>> [0] - https://bugzilla.kernel.org/show_bug.cgi?id=215203
>> [1] - https://bugzilla.redhat.com/show_bug.cgi?id=2028613
> 
> To be sure this issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, my Linux kernel regression tracking bot:
> 
> #regzbot ^introduced 55285e21f04517939480966164a33898c34b2af2
> #regzbot title fbdev/efifb: Monitors no longer sleep (amdgpu dual
> monitor setup)
> #regzbot ignore-activity
> 
> Reminder: when fixing the issue, please add a 'Link:' tag with the URL
> to the report (the parent of this mail), then regzbot will automatically
> mark the regression as resolved once the fix lands in the appropriate
> tree. For more details about regzbot see footer.
> 
> Sending this to everyone that got the initial report, to make all aware
> of the tracking. I also hope that messages like this motivate people to
> directly get at least the regression mailing list and ideally even
> regzbot involved when dealing with regressions, as messages like this
> wouldn't be needed then.
> 
> Don't worry, I'll send further messages wrt to this regression just to
> the lists (with a tag in the subject so people can filter them away), as
> long as they are intended just for regzbot. With a bit of luck no such
> messages will be needed anyway.
> 
> Ciao, Thorsten, your Linux kernel regression tracker.
> 
> P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
> on my table. I can only look briefly into most of them. Unfortunately
> therefore I sometimes will get things wrong or miss something important.
> I hope that's not the case here; if you think it is, don't hesitate to
> tell me about it in a public reply. That's in everyone's interest, as
> what I wrote above might be misleading to everyone reading this; any
> suggestion I gave they thus might sent someone reading this down the
> wrong rabbit hole, which none of us wants.
> 
> BTW, I have no personal interest in this issue, which is tracked using
> regzbot, my Linux kernel regression tracking bot
> (https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
> this mail to get things rolling again and hence don't need to be CC on
> all further activities wrt to this regression.
> 
