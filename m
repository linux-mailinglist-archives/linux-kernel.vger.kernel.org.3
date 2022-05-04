Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0051A08C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350277AbiEDNXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiEDNXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:23:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CAC2DB;
        Wed,  4 May 2022 06:19:25 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nmEuX-0003kL-2U; Wed, 04 May 2022 15:19:21 +0200
Message-ID: <5fc82f02-be3a-6bb4-0800-aaf19a782655@leemhuis.info>
Date:   Wed, 4 May 2022 15:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Regression: CIFS umount fails since 14302ee33 with some servers
 (exit code 32)
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        Moritz Duge <duge@pre-sense.de>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Aurelien Aptel <aaptel@suse.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
References: <715d745d-5a85-092a-68c2-b9b1dd8ad53e@leemhuis.info>
In-Reply-To: <715d745d-5a85-092a-68c2-b9b1dd8ad53e@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1651670365;372e8ffa;
X-HE-SMSGID: 1nmEuX-0003kL-2U
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

Paul, Moritz, what's the status here? It seems nothing happened at all
since below mail. Was the issue fixed? Or did it fall through the cracks?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

#regzbot poke

On 08.04.22 12:08, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> Paul, it seems a commit authored by you causes a regression:
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and all people that seemed to be relevant
> here. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=215782
> 
>>  Moritz Duge 2022-03-31 16:47:35 UTC
>>
>> With upstream kernel 5.16.9 CIFS umount fails when using certain SMB servers.
>>
>> "umount" returns exit code 32 and the "mount" command still lists the mount as being present.
>> See below for the bad commit I've bisected.
>>
>> The bug has been reproduced multiple times with upstream kernel 5.16.9!
>> But additionally I've done much testing with openSUSE kernels.
>> Here's the openSUSE bugreport:
>> https://bugzilla.opensuse.org/show_bug.cgi?id=1194945
>> Additionally with the same servers there's a problem showing the free space with the "df" command. But I haven't been able to find out if this is really related to the umount problem.
>>
>>
>>
>>
>> = SMB Server =
>>
>> I haven't been able to identify the exact server side settings. But this problem occured with at least this SMB server (with upstream kernel 5.16.9):
>> NetApp (Release 9.7P12) with dfs and CIFS mount options "vers=3.1.1,seal"
>> (quota state unknown)
>>
>> Additionally I've verified the bug with the openSUSE kernel 5.3.18-lp152.72-default and this SMB server:
>> Windows Server 2019 with dfs and quota enabled
>> (no explicit "vers" or "seal" mount options)
>>
>> Additionally the bug appeared with another NetApp SMB server (tested upstream 5.16.9) and two unknown servers (tested only openSUSE-15.2 kernels).
>>
>> Also it looks like the bug may need a setup where the user can only read //server/share/username/ but has no permissions to read //server/share/.
>>
>>
>>
>>
>> = Bad Commit =
>>
>> With the openSUSE kernel I bisected the problem down to this commit (6ae27f2b2) between openSUSE-15.2 kernels 5.3.18-lp152.69.1 and 5.3.18-lp152.72.1.
>> https://github.com/SUSE/kernel/commit/6ae27f2b260e91f16583bbc1ded3147e0f7c5d94
>>
>> This commit is also present in the upstream kernel (14302ee33).
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=14302ee3301b3a77b331cc14efb95bf7184c73cc
>> And it has been merged between 5.11 and 5.12.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=d0df9aabefda4d0a64730087f939f53f91e29ee6
>>
>> As said I can't reproduce this with arbitrary SMB servers. And it's always a time consuming procedure for me to do a test with the affected production SMB servers. But if you're really unhappy with the bisect search on the openSUSE kernel, I can repeat the test with the upstream commit 14302ee33 and it's predecessor.
> 
> 
> Could somebody take a look into this? Or was this discussed somewhere
> else already? Or even fixed?
> 
> Anyway, to get this tracked:
> 
> #regzbot introduced: 14302ee3301b3a77b331cc14
> #regzbot from: Moritz Duge <duge@pre-sense.de>
> #regzbot title: CIFS: umount fails with some servers (exit code 32)
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215782
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
> 
