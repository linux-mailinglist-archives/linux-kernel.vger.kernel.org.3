Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE6B48991C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiAJNB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:01:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54198 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiAJNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B76C611D3;
        Mon, 10 Jan 2022 13:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A9DC36AE3;
        Mon, 10 Jan 2022 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641819631;
        bh=QdtjSakUg51i/7yyEyIdy/BhlnAD5GLpLw0nBl9BWtA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sUrvm7kg+guo01PWBZZ6D2pT6NQiy0WiChQ5bjmmKaHvcvNE5qH+gdhTWh/MEQ0Db
         0LzkB52pCupbrw8VHsIXUTvKttWbGj9rR52MwXjK0bmdZab6sqDtg23aeeLFwAxYp7
         KGhUxdlS8DdQSs8yJRtR14cFUIJaQieBR7j5iamhoDCmfjew8W/7ftfC4we+Vdu3+5
         Y+A1nvj5dXHdmNnG0riLvj4zj7wX6bKoOaKxi/qjsYm8WQySt9Dadn2hseyBcaW7F4
         SP6WFPu179MDb7oWCed5KAZTWc6eZba+Vsd4l+owlppsgLAyDxthFlINMsNs8llqsr
         0Qp/bNJCMFRQQ==
Date:   Mon, 10 Jan 2022 14:00:27 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        casteyde.christian@free.fr, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [regression] Touchpad is not working after suspend to RAM since
 kernel 5.14 (fwd from b.k.o bug 214667)
In-Reply-To: <12b9a10a-626b-cafd-05d6-cf0a116aa39b@leemhuis.info>
Message-ID: <nycvar.YFH.7.76.2201101359080.28059@cbobk.fhfr.pm>
References: <12b9a10a-626b-cafd-05d6-cf0a116aa39b@leemhuis.info>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021, Thorsten Leemhuis wrote:

> Hi, this is your Linux kernel regression tracker speaking.
> 
> Forwarding a regression reported by Christian Casteyde (CCed) in
> bugzilla.kernel.org which apparently has fallen through the cracks.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=214667
> 
> A few quotes from comments in the ticket:
> 
> > Since Kernel 5.14 (probably 5.14-rc5 indeed) the touchpad does not
> > work anymore after resume from suspend to RAM. Was working with 5.13
> > kernel.
> > 
> > I've bisected the bug, first bad commit is: 
> > b3e29642548258c7cd2cb3326a776fff84cd6b69 is the first bad commit
> > 
> > SC[33mcommit b3e29642548258c7cd2cb3326a776fff84cd6b69ESC[m Merge:
> > 8f4ef88 498d0dd Author: Jiri Kosina <jkosina@suse.cz> Date:   Wed Jun
> > 30 09:15:15 2021 +0200
> > 
> > Merge branch 'for-5.14/multitouch' into for-linus
> > 
> > - patch series that ensures that hid-multitouch driver disables touch
> > and button-press reporting on hid-mt devices during suspend when the
> > device is not configured as a wakeup-source, from Hans de Goede
> > 
> > Seem to be related with the observed behaviour.
> 
> Yes, that's a merge, but it contains code changes, maybe something went
> wrong there.

CCing Hans, as that merge commit brought his series "disable touch and 
button-press during suspend" series.

It's strange though that bisection points to a merge commit and not a 
commit in that series.

> 
> > Update with kernel 5.15-rc7
> > 
> > Still present. However, I noticed dmesg ouput interesting messages
> > telling there is a transfer from the ELAN touchpad while suspended,
> > it failed to suspend, then failed to resume. The interesting thing is
> > if I try to suspend a second time, at resume the touchpad manages to
> > resume. Appending dmesg output for reference.
> 
> 
> > The problem is still present in 5.16-rc7, but indeed it got worse
> > (and indeed is now critical). a) After the first "suspend" tentative
> > (closing the lid), the laptop doesn't suspend (only the screen is
> > blanked) b) When I reopen the lid, the touchpad stays disabled c)
> > When I try to suspend a second time (closing the lid), the system
> > totally freeze (without any info in dmesg) and I need to reset it
> > totally. I'll open a separate bug report for this one, when bisected,
> > and will try to post it to the suspend maintainer together with the
> > mailing list (I'm not accustomed to mailing lists).
> 
> FWIW, Christian did this here:
> https://lore.kernel.org/all/256689953.114854578.1640622738334.JavaMail.root@zimbra40-e7.priv.proxad.net/
> 
> > FYI, if I remember well, reverting this single commit fixed the issue
> > and the diff was making sense (try to disable the touchpad before
> > going to sleep to prevent unexpected event from it while
> > suspending... if I understood well the code).
> 
> To be sure this issue doesn't again fall through the cracks unnoticed,
> I'm adding it to regzbot, my Linux kernel regression tracking bot:
> 
> #regzbot introduced b3e29642548258c7cd2cb3326a776fff84cd6b69ESC
> #regzbot title hid: touchpad is not working after suspend to RAM
> #regzbot from: Christian Casteyde <casteyde.christian@free.fr>
> #regzbot ignore-activity
> 
> Reminder: when fixing the issue, please add a 'Link:' tag with the URL
> to the report (the parent of this mail) using the kernel.org redirector,
> as explained in 'Documentation/process/submitting-patches.rst'. Regzbot
> then will automatically mark the regression as resolved once the fix
> lands in the appropriate tree. For more details about regzbot see footer.
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
> 
> 
> Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat).
> 
> P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
> on my table. I can only look briefly into most of them. Unfortunately
> therefore I sometimes will get things wrong or miss something important.
> I hope that's not the case here; if you think it is, don't hesitate to
> tell me about it in a public reply. That's in everyone's interest, as
> what I wrote above might be misleading to everyone reading this; any
> suggestion I gave thus might sent someone reading this down the wrong
> rabbit hole, which none of us wants.
> 
> BTW, I have no personal interest in this issue, which is tracked using
> regzbot, my Linux kernel regression tracking bot
> (https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
> this mail to get things rolling again and hence don't need to be CC on
> all further activities wrt to this regression.
> 
> ---
> Additional information about regzbot:
> 
> If you want to know more about regzbot, check out its web-interface, the
> getting start guide, and/or the references documentation:
> 
> https://linux-regtracking.leemhuis.info/regzbot/
> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
> 
> The last two documents will explain how you can interact with regzbot
> yourself if your want to.
> 
> Hint for reporters: when reporting a regression it's in your interest to
> tell #regzbot about it in the report, as that will ensure the regression
> gets on the radar of regzbot and the regression tracker. That's in your
> interest, as they will make sure the report won't fall through the
> cracks unnoticed.
> 
> Hint for developers: you normally don't need to care about regzbot once
> it's involved. Fix the issue as you normally would, just remember to
> include a 'Link:' tag to the report in the commit message, as explained
> in Documentation/process/submitting-patches.rst
> That aspect was recently was made more explicit in commit 1f57bd42b77c:
> https://git.kernel.org/linus/1f57bd42b77c
> 

-- 
Jiri Kosina
SUSE Labs

