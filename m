Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED93F4B4FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352839AbiBNMRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:17:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352854AbiBNMRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:17:48 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37888488B4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:17:39 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nJaIN-0007Q1-BJ; Mon, 14 Feb 2022 13:17:31 +0100
Message-ID: <73e05c99-eece-12ff-1755-98c6f3fc6564@leemhuis.info>
Date:   Mon, 14 Feb 2022 13:17:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Regression from 3c196f056666 ("drm/amdgpu: always reset the asic
 in suspend (v2)") on suspend?
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Dominique Dumont <dod@debian.org>, 1005005@bugs.debian.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        Evan Quan <evan.quan@amd.com>, Sasha Levin <sashal@kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <Ygf7KuWyc0d4HIFu@eldamar.lan>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Ygf7KuWyc0d4HIFu@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1644841059;38e70abf;
X-HE-SMSGID: 1nJaIN-0007Q1-BJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[TLDR: I'm adding the regression report below to regzbot, the Linux
kernel regression tracking bot; all text you find below is compiled from
a few templates paragraphs you might have encountered already already
from similar mails.]

Hi, this is your Linux kernel regression tracker speaking.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 3c196f056666
#regzbot title amdgfx: suspend stopped working
#regzbot ignore-activity
#regzbot link: https://bugs.debian.org/1005005

Reminder for developers: when fixing the issue, please add a 'Link:'
tags pointing to the report (the mail quoted above) using
lore.kernel.org/r/, as explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'. This allows the bot to connect
the report with any patches posted or committed to fix the issue; this
again allows the bot to show the current status of regressions and
automatically resolve the issue when the fix hits the right tree.

I'm sending this to everyone that got the initial report, to make them
aware of the tracking. I also hope that messages like this motivate
people to directly get at least the regression mailing list and ideally
even regzbot involved when dealing with regressions, as messages like
this wouldn't be needed then.

Don't worry, I'll send further messages wrt to this regression just to
the lists (with a tag in the subject so people can filter them away), if
they are relevant just for regzbot. With a bit of luck no such messages
will be needed anyway.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.


On 12.02.22 19:23, Salvatore Bonaccorso wrote:
> Hi Alex, hi all
> 
> In Debian we got a regression report from Dominique Dumont, CC'ed in
> https://bugs.debian.org/1005005 that afer an update to 5.15.15 based
> kernel, his machine noe longer suspends correctly, after screen going
> black as usual it comes back. The Debian bug above contians a trace.
> 
> Dominique confirmed that this issue persisted after updating to 5.16.7
> furthermore he bisected the issue and found 
> 
> 	3c196f05666610912645c7c5d9107706003f67c3 is the first bad commit
> 	commit 3c196f05666610912645c7c5d9107706003f67c3
> 	Author: Alex Deucher <alexander.deucher@amd.com>
> 	Date:   Fri Nov 12 11:25:30 2021 -0500
> 
> 	    drm/amdgpu: always reset the asic in suspend (v2)
> 
> 	    [ Upstream commit daf8de0874ab5b74b38a38726fdd3d07ef98a7ee ]
> 
> 	    If the platform suspend happens to fail and the power rail
> 	    is not turned off, the GPU will be in an unknown state on
> 	    resume, so reset the asic so that it will be in a known
> 	    good state on resume even if the platform suspend failed.
> 
> 	    v2: handle s0ix
> 
> 	    Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> 	    Acked-by: Evan Quan <evan.quan@amd.com>
> 	    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 	    Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> 	 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
> 	 1 file changed, 4 insertions(+), 1 deletion(-)
> 
> to be the first bad commit, see https://bugs.debian.org/1005005#34 .
> 
> Does this ring any bell? Any idea on the problem?
> 
> Regards,
> Salvatore

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.
