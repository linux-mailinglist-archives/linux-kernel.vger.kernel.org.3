Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F944D44D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241179AbiCJKkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiCJKkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:40:36 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7574FC64
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:39:35 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nSGCi-0005Cd-2t; Thu, 10 Mar 2022 11:39:32 +0100
Message-ID: <831731e2-6769-3d36-0cdf-721437452fcc@leemhuis.info>
Date:   Thu, 10 Mar 2022 11:39:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Bug 215658 - arch/powerpc/mm/mmu_context.o Assembler messages: Error:
 unrecognized opcode: `dssall' (PowerMac G4)
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1646908775;1ae64f2d;
X-HE-SMSGID: 1nSGCi-0005Cd-2t
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org that afaics nobody
acted upon since it was reported about a week ago, that's why I decided
to forward it to the lists and a few relevant people to the CC. To quote
from the ticket:

> 5.16.12 kernel build for my G4 DP on my Talos II fails with:
> 
> [...]
>   CC      arch/powerpc/mm/init_32.o
>   CC      arch/powerpc/mm/pgtable_32.o
>   CC      arch/powerpc/mm/pgtable-frag.o
>   CC      arch/powerpc/mm/ioremap.o
>   CC      arch/powerpc/mm/ioremap_32.o
>   CC      arch/powerpc/mm/init-common.o
>   CC      arch/powerpc/mm/mmu_context.o
> {standard input}: Assembler messages:
> {standard input}:30: Error: unrecognized opcode: `dssall'
> make[2]: *** [scripts/Makefile.build:287: arch/powerpc/mm/mmu_context.o] Fehler 1
> make[1]: *** [scripts/Makefile.build:549: arch/powerpc/mm] Fehler 2
> make: *** [Makefile:1846: arch/powerpc] Error 2
> 
> This seems to have been introduced by commit d51f86cfd8e378d4907958db77da3074f6dce3ba "powerpc/mm: Switch obsolete dssall to .long"
> 
> Reverting this commit fixes the build for my G4.

Could somebody take a look into this? Or was this discussed somewhere
else already? Or even fixed?

Anyway, to get this tracked:

#regzbot introduced: d51f86cfd8e378d4907958db77da3074f6dce3ba
#regzbot from: Erhard F <erhard_f@mailbox.org>
#regzbot title:  arch/powerpc/mm/mmu_context.o Assembler messages:
Error: unrecognized opcode: `dssall' (PowerMac G4)
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215658

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
