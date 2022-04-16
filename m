Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C1950339D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiDPEpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiDPEpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:45:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B0453721
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:42:41 -0700 (PDT)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nfaGe-0007D9-2O; Sat, 16 Apr 2022 06:42:40 +0200
Message-ID: <e5c8cccd-c9dd-ff80-ae88-b47f70f66c6a@leemhuis.info>
Date:   Sat, 16 Apr 2022 06:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Bug 215734 - shared object loaded very low in memory ARM 32bit
 with kernel 5.17.0 #forregzbot
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e2b90c55-1a4a-4cf1-2dc7-2b2a4dc7d168@leemhuis.info>
In-Reply-To: <e2b90c55-1a4a-4cf1-2dc7-2b2a4dc7d168@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1650084161;c9c55775;
X-HE-SMSGID: 1nfaGe-0007D9-2O
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

#regzbot fixed-by: aeb7923733d100


On 31.03.22 08:17, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and all people that seemed to be relevant
> here. Note, this is the second regression report referencin a commit
> from H.J. Lu as culprit (9630f0d60fec ("fs/binfmt_elf: use PT_LOAD
> p_align values for static PIE")). I forwarded the first one on Monday
> already, but seems nothing happened:
> https://lore.kernel.org/all/cb5b81bd-9882-e5dc-cd22-54bdbaaefbbc@leemhuis.info/
> 
> Anyway, to get back to the latest report. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=215734 :
> 
>>  Jan Palus 2022-03-24 10:17:02 UTC
>>
>> This is a followup to https://sourceware.org/bugzilla/show_bug.cgi?id=28990 where ld.so --verify segfault was reported on binaries > 4MB.
>>
>> It appears that starting with kernel 5.17.0 shared object is loaded in the begging of address space at least on 32-bit ARM:
>>
>> /proc/<pid>/maps just before mmap (5.17):
>> 00400000-00429000 r-xp 00000000 b3:02 393320     /lib/ld-linux-armhf.so.3
>> 00439000-0043c000 rw-p 00029000 b3:02 393320     /lib/ld-linux-armhf.so.3
>> 76ffd000-76ffe000 r-xp 00000000 00:00 0          [sigpage]
>> 76ffe000-76fff000 r--p 00000000 00:00 0          [vvar]
>> 76fff000-77000000 r-xp 00000000 00:00 0          [vdso]
>> 7efdf000-7f000000 rw-p 00000000 00:00 0          [stack]
>> ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]
>>
>> causing segfaults when mmaping large binaries at fixed address 0x10000 (ie done by ld.so --verify used by ldd).
>>
>> By comparison it is not the case for kernel 5.16.8:
>>
>> /proc/<pid>/maps just before mmap (5.16):
>> 76fc4000-76fed000 r-xp 00000000 b3:02 393320     /lib/ld-linux-armhf.so.3
>> 76ffa000-76ffb000 r-xp 00000000 00:00 0          [sigpage]
>> 76ffb000-76ffc000 r--p 00000000 00:00 0          [vvar]
>> 76ffc000-76ffd000 r-xp 00000000 00:00 0          [vdso]
>> 76ffd000-77000000 rw-p 00029000 b3:02 393320     /lib/ld-linux-armhf.so.3
>> 7efdf000-7f000000 rw-p 00000000 00:00 0          [stack]
>> ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]
>>
>> [reply] [−] Comment 1 Jan Palus 2022-03-29 22:14:12 UTC
>>
>> First bad commit appears to be:
>>
>> From: "H.J. Lu" <hjl.tools@gmail.com>
>> Date: Wed, 19 Jan 2022 18:09:40 -0800
>> Subject: fs/binfmt_elf: use PT_LOAD p_align values for static PIE
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9630f0d60fec5fbcaa4435a66f75df1dc9704b66
>>
> 
> Could somebody take a look into this? Or was this discussed somewhere
> else already? Or even fixed?
> 
> 
> Anyway, to get this tracked:
> 
> #regzbot introduced: 9630f0d60fec5fbcaa4435a66f75df1dc9704b6
> #regzbot from: Jan Palus <jpalus@fastmail.com>
> #regzbot title: shared object loaded very low in memory ARM 32bit
> causing segfaults on binaries > 4MB
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215734
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
