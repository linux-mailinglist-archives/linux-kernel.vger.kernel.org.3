Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A3B4BD752
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbiBUHMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:12:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345922AbiBUHMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:12:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C21108
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:11:54 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nM2rQ-00080n-1L; Mon, 21 Feb 2022 08:11:52 +0100
Message-ID: <49f945f4-a8ea-825b-8c45-64c8a767631e@leemhuis.info>
Date:   Mon, 21 Feb 2022 08:11:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Regression in CIFS due to a change to improve maintainability and
 security (was: Re: Linux regressions report for mainline [2022-02-20])
Content-Language: en-BS
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <164538626369.148226.6844131057670577043@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <164538626369.148226.6844131057670577043@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1645427514;1ec9f2ba;
X-HE-SMSGID: 1nM2rQ-00080n-1L
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Linus!

On 20.02.22 20:51, Regzbot (on behalf of Thorsten Leemhuis) wrote:
> Hi, Thorsten here, with a quick preface before the latest report from
> regzbot. From my side things seem to look normal right now; in fact
> quite a few mainline regression that I've been tracking got resolved in
> the past few days (I removed two from the report that are fixed by
> changes in the git tags Borislav and Dmitry asked you to pull this
> weekend; guess you will merge them later today).
> [...]

Those as expected got merged, great. But I forgot to mention one thing
in my preface: there is a regression introduced in the 5.15 cycle where
I'd like to hear your option, as it's one of those tricky issues that
might need a judgement call, as it's security related.

The culprit here is 76a3c92ec9e0 ("cifs: remove support for NTLM and
weaker authentication algorithms"), which as of now afaics cleanly
reverts in mainline. As the title indicates, it's a change to remove
code in the interest of maintainability and security, but it seems some
people are now unable to access CIFS 1.0 shares on some devices (like
the media player "mede8er med600x3"). For details see:

https://lore.kernel.org/lkml/CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf%2BwThmR72YTg@mail.gmail.com/

[some backstory can also be found in the two bug tickets linked there,
which show the reporter is not the only one that ran into the
regression; see for example
https://bugzilla.kernel.org/show_bug.cgi?id=215375#c13 ]

I recently brought "should this be reverted" up in the discussion and
this is what Ronnie (who authored 76a3c92ec9e0) replied in
https://lore.kernel.org/lkml/CAN05THQbR4d55kx6MEHGcn-iLZKJG1C0vhq19wfo=NrB6q1Apg@mail.gmail.com/

> Right now you can likely just revert it. Maybe in the next kernel too.
> But in a kernel not too far into the future some of the crypto primitives that
> this depended on will simply not exist any more in the linux kernel
> and will not be
> available through the standard api.
> 
> At that point it is no longer a matter of just reverting the patch but
> a matter of
> re-importing an equivalent crypto replacement and port cifs.ko to its new api.
> 
> That is a lot of work and maintenance for something that is obsolete.

I also asked the reporter if win11 still is able to access the device,
and this is what he replied in
https://lore.kernel.org/lkml/CAJjP=Bus1_ce4vbHXpiou1WrSe8a61U1NzGm4XvN5fYCPGNikA@mail.gmail.com/

> Thorsten: the only group policy modification I have on my win11
> machine (which was
> loaded fresh not too long ago) is to enable insecure guest logins,
> which is obviously
> required for samba shares where the share allows a guest login without
> any password.
> I have to enable this to browse the shares on my Gentoo machine from the win11
> machine anyway.

Now I'm a bit unsure what the best way forward is here; if you have one
and want to share it, could you please do so in above thread (it's on
LKML, subject is "Possible regression: unable to mount CIFS 1.0 shares
from older machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c"), as
that where everybody is CCed. tia!

Ciao, Thorsten
