Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C13F4E97EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbiC1NXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243115AbiC1NXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:23:03 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C855DE5F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:21:22 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nYpJA-0008Oi-58; Mon, 28 Mar 2022 15:21:20 +0200
Message-ID: <cb5b81bd-9882-e5dc-cd22-54bdbaaefbbc@leemhuis.info>
Date:   Mon, 28 Mar 2022 15:21:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Victor Stinner <vstinner@redhat.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Bug 215720 - brk() regression on AArch64 on static-pie binary --
 issue with ASLR and a guard page?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1648473682;77d6f0c8;
X-HE-SMSGID: 1nYpJA-0008Oi-58
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
to forward it to the lists and the author of the culprit. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=215720:

>  Victor Stinner 2022-03-22 02:24:57 UTC
> 
> Created attachment 300597 [details]
> empty.c reproducer
> 
> I found a brk() syscall regression of Linux kernel 5.17 on AArch64.
> 
> A git bisect found the change "fs/binfmt_elf: use PT_LOAD p_align values for static PIE": commit 9630f0d60fec5fbcaa4435a66f75df1dc9704b66, changed related to the bz#215275.
> 
> Program to reproduce the bug, empty.c (attached to the issue):
> ---
> _Thread_local int var1 = 0;
> int main() {
>     volatile int x = 1;
>     var1 = x;
>     return 0;
> }
> ---
> 
> Build the program as a static PIE program:
> 
>     gcc -std=c11 -static-pie -g empty.c -o empty -O2
> 
> The program fails randomly, it takes 100 to 6000 runs to reproduce the crash.
> 
> Short shell loop to reproduce the crash:
> ---
> $ i=0; while true; do ./empty; rc=$?; i=$(($i + 1)); echo "$i:
> $(date): $rc"; if [ $rc -ne 0 ]; then break; fi; done
> (...)
> 159: Tue Mar 22 01:54:22 CET 2022: 0
> 160: Tue Mar 22 01:54:22 CET 2022: 0
> Segmentation fault (core dumped)
> 161: Tue Mar 22 01:54:22 CET 2022: 139
> ---
> 
> Disabling ASLR (write 0 to /proc/sys/kernel/randomize_va_space) works
> around the bug.
> 
> Rather than using "empty.c" program, the "ldconfig -V > /dev/null" command can be used: standard static-pie program.
> 
> strace when the program works:
> ---
> brk(NULL)                               = 0xaaaac3961000
> brk(0xaaaac3961b78)                     = 0xaaaac3961b78
> ---
> 
> strace when the bug occurs:
> ---
> brk(NULL)                               = 0xaaaabf3c3000
> brk(0xaaaabf3c3b78)                     = 0xaaaabf3c3000
> ---
> 
> The following test of the brk() syscall fails when the bug occurs:
> ---
> 	/* Check against existing mmap mappings. */
> 	next = find_vma(mm, oldbrk);
> 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
> 		goto out;
> ---
> 
> Note: When the bug occurs, the program crash with SIGSEGV: the glibc __libc_setup_tls() function calls sbrk(2936) to allocate TLS variables, but it doesn't handle the memory allocation failure.
> 
> Note: At the beginning, I discovered this kernel regression while checking for Python
> buildbot failures on our Fedora Rawhide AArch64 machine.
> 
> * Fedora downstream issue: https://bugzilla.redhat.com/show_bug.cgi?id=2066147
> * Python issue: https://bugs.python.org/issue47078
> 
> [reply] [−] Comment 1 Victor Stinner 2022-03-22 02:41:00 UTC
> 
> See also the binutils issue: "p_align in ELF program headers should not exceed section alignment"
> https://sourceware.org/bugzilla/show_bug.cgi?id=28689
> 
> See also this old (kernel 4.18) fixed x86-64 kernel bug: "kernel: brk can grow the heap into the area reserved for the stack"
> https://bugzilla.redhat.com/show_bug.cgi?id=1749633


Could somebody take a look into this? Or was this discussed somewhere
else already? Or even fixed?

Anyway, to get this tracked:

#regzbot introduced: 9630f0d60fec5fbcaa4435a66f75df1dc9704b66
#regzbot from: Victor Stinner <vstinner@redhat.com>
#regzbot title: brk() regression on AArch64 on static-pie binary
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215720

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
