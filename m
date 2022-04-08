Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D585D4F968F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiDHNWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiDHNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:22:27 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC16275;
        Fri,  8 Apr 2022 06:20:21 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ncoXB-0002lO-KS; Fri, 08 Apr 2022 15:20:17 +0200
Message-ID: <9af2d249-91e7-4871-59c8-704823118e48@leemhuis.info>
Date:   Fri, 8 Apr 2022 15:20:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Nico Schottelius <nico-bugzilla.kernel.org@schottelius.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Regression: Mouse gets sluggish after suspend/resume and power usage
 significant higher after resume
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649424023;a304c49a;
X-HE-SMSGID: 1ncoXB-0002lO-KS
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org that afaics nobody
acted upon since it was reported about a week ago, that's why I decided
to forward it to the lists and all people that seemed to be relevant
here. To quote from https://bugzilla.kernel.org/show_bug.cgi?id=215747 :

>  Nico Schottelius 2022-03-26 19:27:06 UTC
> 
> Created attachment 300619 [details]
> dmesg
> 
> TL;DR:
> 
> Suspending and resume makes the ELAN0670:00 trackpad sluggish (very hard to move the pointer) and the energy usage of the notebook is about 3 times higher than before suspend.
> 
> Background:
> 
> 
> On a Lenovo X1 Nano the trackpad works fine until suspend/resume.The estimated battery runtime PRIOR to suspend/resume is 8h 43m. After suspend resume it drops to 2h 20m instantly.
> 
> There seems to be a firmware error in the iwlwifi card show in the attached dmesg, but I am not sure whether "that's enough" to cause both symptoms.
> 
> Kernel is from Alpine Linux, which is basically stock upstream afaics.

See later comments for more details. In one of them the reporter states
he's pretty sure that it didn't happen with 5.13.

Not sure if this is input, PM, bluetooth, or something else. But sounds
like a problem in the input code to me (you have to start somewhere...).

Could somebody take a look into this? Or was this discussed somewhere
else already? Or even fixed?

Anyway, to get this tracked:

#regzbot introduced: v5.13..v5.15.31	
#regzbot from: Nico Schottelius  <nico-bugzilla.kernel.org@schottelius.org>
#regzbot title: input: Mouse gets sluggish after suspend/resume and
power usage significant higher after resume
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215747

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

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
