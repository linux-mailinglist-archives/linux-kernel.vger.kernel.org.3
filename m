Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2FC488C21
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiAITqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiAITq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:46:28 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8533C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 11:46:27 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n6e93-0000ko-HL; Sun, 09 Jan 2022 20:46:25 +0100
Message-ID: <5fa1a2ba-f9f3-7f27-6909-1c4c38f6f331@leemhuis.info>
Date:   Sun, 9 Jan 2022 20:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Linux regressions report for mainline [2022-01-09]
Content-Language: en-BS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <164175418046.1037107.9730034714816887497@leemhuis.info>
 <CAHk-=wi8gSsM7-+fx-iSoKGHtgrgN==NcQtRikYfiFmv8gjbnQ@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAHk-=wi8gSsM7-+fx-iSoKGHtgrgN==NcQtRikYfiFmv8gjbnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1641757587;d729b19d;
X-HE-SMSGID: 1n6e93-0000ko-HL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.01.22 20:20, Linus Torvalds wrote:
> On Sun, Jan 9, 2022 at 10:51 AM Regzbot (on behalf of Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> 5-10% increase in IO latencies with nohz balance patch
> 
> This one is clearly not rootcaused, but even the reporter isn't sure
> what triggered it.  It was bisected to that mentioned patch, but even
> that bisection result isn't really entirely certain.
> 
> So this one will remain pending, I'm afraid.

Yeah. I'm a bit unsure how to handle such cases better in regzbot. I
consider marking them manually as "needinfo", "blurry", "ambiguous", or
something like that. Then regzbot can put them into a separate section
or mark them somehow.

>> pm: laptop totally freezes when going to hibernation

This is one I'd for now consider "ambiguous" for now.

>> drm: amdgpu: s0ix suspend stopped working
> 
> Something clearly not great in amdgpu suspend/resume land. The reports
> are not fully clear, with even the bisection being questionable.

This afaics should help soon for the second case:

https://lore.kernel.org/all/BL1PR12MB5157F21C23A020052FF5C13BE24C9@BL1PR12MB5157.namprd12.prod.outlook.com/
https://lore.kernel.org/all/20220106163054.13781-3-mario.limonciello@amd.com/

Regzbot didn't pick up this patch automatically (and I forgot to point
it towards it...), as support for tracking regressions mainly handled in
bug trackers is still missing. It's pretty high on my todo list, but
nevertheless it might take a few weeks before I get to that, as real
world forces me to focus on a few other things first (some regzbot
related, some not). That's why I have not much time left currently to
work on regzbot's code. :-/

> But from the previous cycle reports:
> 
>> =========================================================================================
>> previous cycle (v5.14..v5.15), culprit identified, with activity in the past three months
>> =========================================================================================
>>
>> drm: amdgpu: NUC8i7HVKVA crashes during system suspend
> 
> This one isn't questionable, and Len sent me the revert he's been
> using on his system for a long time. So I applied it.
> 
> Maybe it's related, maybe it's not.

Thx for letting me know. This was a issue mainly discussed in
bugzilla.kernel.org and another area where regzbot is missing a feature:
to detect activity and patches there. On my todo list, too. But one step
at a time...

Ciao, Thorsten
