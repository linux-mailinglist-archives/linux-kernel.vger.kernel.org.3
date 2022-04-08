Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA7E4F928F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiDHKKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiDHKK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:10:28 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13623BA50;
        Fri,  8 Apr 2022 03:08:24 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nclXN-0003iK-As; Fri, 08 Apr 2022 12:08:17 +0200
Message-ID: <715d745d-5a85-092a-68c2-b9b1dd8ad53e@leemhuis.info>
Date:   Fri, 8 Apr 2022 12:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Moritz Duge <duge@pre-sense.de>,
        Aurelien Aptel <aaptel@suse.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
To:     "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Subject: Regression: CIFS umount fails since 14302ee33 with some servers (exit
 code 32)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649412504;6f8dbe02;
X-HE-SMSGID: 1nclXN-0003iK-As
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

Paul, it seems a commit authored by you causes a regression:

I noticed a regression report in bugzilla.kernel.org that afaics nobody
acted upon since it was reported about a week ago, that's why I decided
to forward it to the lists and all people that seemed to be relevant
here. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=215782

>  Moritz Duge 2022-03-31 16:47:35 UTC
> 
> With upstream kernel 5.16.9 CIFS umount fails when using certain SMB servers.
> 
> "umount" returns exit code 32 and the "mount" command still lists the mount as being present.
> See below for the bad commit I've bisected.
> 
> The bug has been reproduced multiple times with upstream kernel 5.16.9!
> But additionally I've done much testing with openSUSE kernels.
> Here's the openSUSE bugreport:
> https://bugzilla.opensuse.org/show_bug.cgi?id=1194945
> Additionally with the same servers there's a problem showing the free space with the "df" command. But I haven't been able to find out if this is really related to the umount problem.
> 
> 
> 
> 
> = SMB Server =
> 
> I haven't been able to identify the exact server side settings. But this problem occured with at least this SMB server (with upstream kernel 5.16.9):
> NetApp (Release 9.7P12) with dfs and CIFS mount options "vers=3.1.1,seal"
> (quota state unknown)
> 
> Additionally I've verified the bug with the openSUSE kernel 5.3.18-lp152.72-default and this SMB server:
> Windows Server 2019 with dfs and quota enabled
> (no explicit "vers" or "seal" mount options)
> 
> Additionally the bug appeared with another NetApp SMB server (tested upstream 5.16.9) and two unknown servers (tested only openSUSE-15.2 kernels).
> 
> Also it looks like the bug may need a setup where the user can only read //server/share/username/ but has no permissions to read //server/share/.
> 
> 
> 
> 
> = Bad Commit =
> 
> With the openSUSE kernel I bisected the problem down to this commit (6ae27f2b2) between openSUSE-15.2 kernels 5.3.18-lp152.69.1 and 5.3.18-lp152.72.1.
> https://github.com/SUSE/kernel/commit/6ae27f2b260e91f16583bbc1ded3147e0f7c5d94
> 
> This commit is also present in the upstream kernel (14302ee33).
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=14302ee3301b3a77b331cc14efb95bf7184c73cc
> And it has been merged between 5.11 and 5.12.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=d0df9aabefda4d0a64730087f939f53f91e29ee6
> 
> As said I can't reproduce this with arbitrary SMB servers. And it's always a time consuming procedure for me to do a test with the affected production SMB servers. But if you're really unhappy with the bisect search on the openSUSE kernel, I can repeat the test with the upstream commit 14302ee33 and it's predecessor.


Could somebody take a look into this? Or was this discussed somewhere
else already? Or even fixed?

Anyway, to get this tracked:

#regzbot introduced: 14302ee3301b3a77b331cc14
#regzbot from: Moritz Duge <duge@pre-sense.de>
#regzbot title: CIFS: umount fails with some servers (exit code 32)
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215782

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
