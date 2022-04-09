Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5E74FA75E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiDILvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiDILvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:51:42 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75020262D69
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 04:49:35 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nd9av-0008N6-Td; Sat, 09 Apr 2022 13:49:33 +0200
Message-ID: <d79869b9-f50c-2f72-d277-7e98c5c9873f@leemhuis.info>
Date:   Sat, 9 Apr 2022 13:49:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Bug 215720 - brk() regression on AArch64 on static-pie binary --
 issue with ASLR and a guard page?
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Victor Stinner <vstinner@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <cb5b81bd-9882-e5dc-cd22-54bdbaaefbbc@leemhuis.info>
In-Reply-To: <cb5b81bd-9882-e5dc-cd22-54bdbaaefbbc@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649504975;7d8c21ad;
X-HE-SMSGID: 1nd9av-0008N6-Td
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

Hey, what's up here? Or was this regressions fixed already?

H.J. Lu: reminder, this is caused by a patch of yours.

Mike, if you have a minute: '925346c129da' ("fs/binfmt_elf: fix PT_LOAD
p_align values for loaders") in 'next' contains a 'Fixes:' tag for the
culprit of this regression, but I assume it fixes a different issue?

Ciao, Thorsten

#regzbot poke

On 28.03.22 15:21, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and the author of the culprit. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=215720:
> 
>>  Victor Stinner 2022-03-22 02:24:57 UTC
>>
>> Created attachment 300597 [details]
>> empty.c reproducer
>>
>> I found a brk() syscall regression of Linux kernel 5.17 on AArch64.
>>
>> A git bisect found the change "fs/binfmt_elf: use PT_LOAD p_align values for static PIE": commit 9630f0d60fec5fbcaa4435a66f75df1dc9704b66, changed related to the bz#215275.
>>
>> Program to reproduce the bug, empty.c (attached to the issue):
>> ---
>> _Thread_local int var1 = 0;
>> int main() {
>>     volatile int x = 1;
>>     var1 = x;
>>     return 0;
>> }
>> ---
>>
>> Build the program as a static PIE program:
>>
>>     gcc -std=c11 -static-pie -g empty.c -o empty -O2
>>
>> The program fails randomly, it takes 100 to 6000 runs to reproduce the crash.
>>
>> Short shell loop to reproduce the crash:
>> ---
>> $ i=0; while true; do ./empty; rc=$?; i=$(($i + 1)); echo "$i:
>> $(date): $rc"; if [ $rc -ne 0 ]; then break; fi; done
>> (...)
>> 159: Tue Mar 22 01:54:22 CET 2022: 0
>> 160: Tue Mar 22 01:54:22 CET 2022: 0
>> Segmentation fault (core dumped)
>> 161: Tue Mar 22 01:54:22 CET 2022: 139
>> ---
>>
>> Disabling ASLR (write 0 to /proc/sys/kernel/randomize_va_space) works
>> around the bug.
>>
>> Rather than using "empty.c" program, the "ldconfig -V > /dev/null" command can be used: standard static-pie program.
>>
>> strace when the program works:
>> ---
>> brk(NULL)                               = 0xaaaac3961000
>> brk(0xaaaac3961b78)                     = 0xaaaac3961b78
>> ---
>>
>> strace when the bug occurs:
>> ---
>> brk(NULL)                               = 0xaaaabf3c3000
>> brk(0xaaaabf3c3b78)                     = 0xaaaabf3c3000
>> ---
>>
>> The following test of the brk() syscall fails when the bug occurs:
>> ---
>> 	/* Check against existing mmap mappings. */
>> 	next = find_vma(mm, oldbrk);
>> 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
>> 		goto out;
>> ---
>>
>> Note: When the bug occurs, the program crash with SIGSEGV: the glibc __libc_setup_tls() function calls sbrk(2936) to allocate TLS variables, but it doesn't handle the memory allocation failure.
>>
>> Note: At the beginning, I discovered this kernel regression while checking for Python
>> buildbot failures on our Fedora Rawhide AArch64 machine.
>>
>> * Fedora downstream issue: https://bugzilla.redhat.com/show_bug.cgi?id=2066147
>> * Python issue: https://bugs.python.org/issue47078
>>
>> [reply] [−] Comment 1 Victor Stinner 2022-03-22 02:41:00 UTC
>>
>> See also the binutils issue: "p_align in ELF program headers should not exceed section alignment"
>> https://sourceware.org/bugzilla/show_bug.cgi?id=28689
>>
>> See also this old (kernel 4.18) fixed x86-64 kernel bug: "kernel: brk can grow the heap into the area reserved for the stack"
>> https://bugzilla.redhat.com/show_bug.cgi?id=1749633
> 
> 
> Could somebody take a look into this? Or was this discussed somewhere
> else already? Or even fixed?
> 
> Anyway, to get this tracked:
> 
> #regzbot introduced: 9630f0d60fec5fbcaa4435a66f75df1dc9704b66
> #regzbot from: Victor Stinner <vstinner@redhat.com>
> #regzbot title: brk() regression on AArch64 on static-pie binary
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215720
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
