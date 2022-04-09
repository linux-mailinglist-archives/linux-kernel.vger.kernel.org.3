Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA694FA761
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241683AbiDILyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiDILyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:54:36 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FDE811A1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 04:52:30 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nd9dh-0002on-NS; Sat, 09 Apr 2022 13:52:26 +0200
Message-ID: <b685f3d0-da34-531d-1aa9-479accd3e21b@leemhuis.info>
Date:   Sat, 9 Apr 2022 13:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Bug 215734 - shared object loaded very low in memory ARM 32bit
 with kernel 5.17.0
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Kennelly <ckennelly@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <e2b90c55-1a4a-4cf1-2dc7-2b2a4dc7d168@leemhuis.info>
In-Reply-To: <e2b90c55-1a4a-4cf1-2dc7-2b2a4dc7d168@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649505150;11c51eec;
X-HE-SMSGID: 1nd9dh-0002on-NS
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

Hey, what's up here? Was this regressions fixed already?

H.J. Lu: reminder, this is caused by a patch of yours. One that causes
two regressions I track, and it seem neither is getting addressed with
the appropriate urgency. FWIW, the other regression can can be found here:
https://lore.kernel.org/lkml/cb5b81bd-9882-e5dc-cd22-54bdbaaefbbc@leemhuis.info/
https://bugzilla.kernel.org/show_bug.cgi?id=215720

Mike, if you have a minute: '925346c129da' ("fs/binfmt_elf: fix PT_LOAD
p_align values for loaders") in 'next' contains a 'Fixes:' tag for the
culprit of this regression, but I assume it fixes a different issue?

Ciao, Thorsten

#regzbot poke

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
