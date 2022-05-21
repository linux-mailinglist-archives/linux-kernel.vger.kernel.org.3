Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BE252FC04
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiEULdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355851AbiEULcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:32:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF3E21AD
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 04:30:58 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nsNJt-00055r-6N; Sat, 21 May 2022 13:30:53 +0200
Message-ID: <6b12a0b4-2f6d-1c35-f2e2-a28022583c47@leemhuis.info>
Date:   Sat, 21 May 2022 13:30:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Linux regressions report for mainline [2022-05-09] (was: Linux
 5.18-rc6)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
 <165209064657.193515.10163777181547077546@leemhuis.info>
 <CAHk-=wj0gHsG6iw3D8ufptm9a_dvTSqrrOFY9WopObbYbyuwnA@mail.gmail.com>
 <54664f6a-b046-1330-e794-cb533e942a94@redhat.com>
 <04f2e08c-4c39-16d3-d785-f36494c6256c@redhat.com>
 <063d7fdb-2d4c-5798-773b-d82b4f0e918a@redhat.com>
 <CAHk-=wjKtV3mT3S=vxgqe__MUzxRrZ7=fopKQtTKOeQJAVyoUQ@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAHk-=wjKtV3mT3S=vxgqe__MUzxRrZ7=fopKQtTKOeQJAVyoUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1653132658;dc06f463;
X-HE-SMSGID: 1nsNJt-00055r-6N
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.22 07:01, Linus Torvalds wrote:
> On Thu, May 19, 2022 at 6:10 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Note this is not part of any pending drm-fixes* pull-reqs yet though.
> 
> It has now hit my tree as part of Dave's drm pull today.

Great, just like Hans I have been watching the progress of that patch
closely. A fix for a regression on the Raspi CM4 also landed in the past
24 hours.

I assume you'll also get the patch "objtool: Fix objtool regression on
x32 systems"
(https://lore.kernel.org/all/165304401319.4207.18392602354110557584.tip-bot2@tip-bot2/

) today or tomorrow.

That leaves the following post-5.17 regressions on my list where no fix
is in sight yet:

* Laptop with Ryzen 4600H fails to resume video
https://lore.kernel.org/stable/2584945.lGaqSPkdTl@geek500.localdomain/
(doesn't look like it first, but this apparently is a post-5.17
regression, as the commit causing it was backported; note, the Laptop
has some other problems with suspend that make the first suspend fail;
Mario is working hard with the reporter to find a fix)

* dpaa2: TSO offload on lx2160a causes fatal exception in interrupt
https://bugzilla.kernel.org/show_bug.cgi?id=215886
Debugging is ongoing, there is a patch now, but it's not clear yet if it
helps.

* the netperf.Throughput_Mbps -18.0% regression that made it into mainline:
https://lore.kernel.org/lkml/20220420013526.GB14333@xsang-OptiPlex-9020/
Didn't follow that one closely, as you were active in the discussion
yourself.

HTH, Ciao, Thorsten
