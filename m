Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD62580347
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbiGYREq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiGYREk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:04:40 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200A41D32B;
        Mon, 25 Jul 2022 10:04:39 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:34794)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oG1VW-00DJGN-Hv; Mon, 25 Jul 2022 11:04:38 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:60902 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oG1VV-000BTE-CQ; Mon, 25 Jul 2022 11:04:38 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kbuild@vger.kernel.org
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
Date:   Mon, 25 Jul 2022 12:04:30 -0500
In-Reply-To: <20220725083904.56552-1-huangjie.albert@bytedance.com> (Albert
        Huang's message of "Mon, 25 Jul 2022 16:38:52 +0800")
Message-ID: <8735epf7j5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oG1VV-000BTE-CQ;;;mid=<8735epf7j5.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/2kczJ4XYA0lOcB5AL9pRg/30yBi3yeu0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Albert Huang <huangjie.albert@bytedance.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 575 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 10 (1.7%), parse: 1.01
        (0.2%), extract_message_metadata: 13 (2.3%), get_uri_detail_list: 2.6
        (0.5%), tests_pri_-1000: 22 (3.8%), tests_pri_-950: 1.16 (0.2%),
        tests_pri_-900: 0.98 (0.2%), tests_pri_-90: 83 (14.5%), check_bayes:
        82 (14.2%), b_tokenize: 11 (2.0%), b_tok_get_all: 13 (2.3%),
        b_comp_prob: 3.9 (0.7%), b_tok_touch_all: 49 (8.5%), b_finish: 0.89
        (0.2%), tests_pri_0: 427 (74.3%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 3.0 (0.5%), poll_dns_idle: 1.09 (0.2%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 10 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/4] faster kexec reboot
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Huang <huangjie.albert@bytedance.com> writes:

> From: "huangjie.albert" <huangjie.albert@bytedance.com>
>
> In many time-sensitive scenarios, we need a shorter time to restart 
> the kernel. However, in the current kexec fast restart code, there 
> are many places in the memory copy operation, verification operation 
> and decompression operation, which take more time than 500ms. Through 
> the following patch series. machine_kexec-->start_kernel only takes
> 15ms

Is this a tiny embedded device you are taking the timings of?

How are you handling driver shutdown and restart?  I would expect those
to be a larger piece of the puzzle than memory.

My desktop can do something like 128GiB/s.  Which would suggest that
copying 128MiB of kernel+initrd would take perhaps 10ms.  The SHA256
implementation may not be tuned so that could be part of the performance
issue.  The SHA256 hash has a reputation for having fast
implementations.  I chose SHA256 originally simply because it has more
bits so it makes the odds of detecting an error higher.


If all you care about is booting a kernel as fast as possible it make
make sense to have a large reserved region of memory like we have for
the kexec on panic kernel.  If that really makes sense I recommend
adding a second kernel command line option and a reserving second region
of reserved memory.  That makes telling if the are any conflicts simple.


I am having a hard time seeing how anyone else would want these options.
Losing megabytes of memory simply because you might reboot using kexec
seems like the wrong side of a trade-off.

The CONFIG_KEXEC_PURGATORY_SKIP_SIG option is very misnamed.  It is not
signature verification that is happening it is a hash verification.
There are not encrypted bits at play.  Instead there is a check to
ensure that the kernel has not been corrupted by in-flight DMA that some
driver forgot to shut down.

So you are building a version of kexec that if something goes wrong it
could very easily eat your data, or otherwise do some very bad things
that are absolutely non-trivial to debug.

That the decision to skip the sha256 hash that prevents corruption is
happening at compile time, instead of at run-time, will guarantee the
option is simply not available on any general purpose kernel
configuration.  Given how dangerous it is to skip the hash verification
it is probably not a bad thing overall, but it is most definitely
something that will make maintenance more difficult.


If done well I don't see why anyone would mind a uncompressed kernel
but I don't see what the advantage of what you are doing is over using
vmlinux is the build directory.  It isn't a bzImage but it is the
uncompressed kernel.

As I proof of concept I think what you are doing goes a way to showing
that things can be improved.  My overall sense is that improving things
the way you are proposing does not help the general case and simply adds
to the maintenance burden.

Eric

>
> How to measure time:
>
> c code:
> uint64_t current_cycles(void)
> {
>     uint32_t low, high;
>     asm volatile("rdtsc" : "=a"(low), "=d"(high));
>     return ((uint64_t)low) | ((uint64_t)high << 32);
> }
> assembly code:
>        pushq %rax
>        pushq %rdx
>        rdtsc
>        mov   %eax,%eax
>        shl   $0x20,%rdx
>        or    %rax,%rdx
>        movq  %rdx,0x840(%r14)
>        popq  %rdx
>        popq  %rax
> the timestamp may store in boot_params or kexec control page, so we can
> get the all timestamp after kernel boot up.
>
> huangjie.albert (4):
>   kexec: reuse crash kernel reserved memory for normal kexec
>   kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
>   x86: Support the uncompressed kernel to speed up booting
>   x86: boot: avoid memory copy if kernel is uncompressed
>
>  arch/x86/Kconfig                   | 10 +++++++++
>  arch/x86/boot/compressed/Makefile  |  5 ++++-
>  arch/x86/boot/compressed/head_64.S |  8 +++++--
>  arch/x86/boot/compressed/misc.c    | 35 +++++++++++++++++++++++++-----
>  arch/x86/purgatory/purgatory.c     |  7 ++++++
>  include/linux/kexec.h              |  9 ++++----
>  include/uapi/linux/kexec.h         |  2 ++
>  kernel/kexec.c                     | 19 +++++++++++++++-
>  kernel/kexec_core.c                | 16 ++++++++------
>  kernel/kexec_file.c                | 20 +++++++++++++++--
>  scripts/Makefile.lib               |  5 +++++
>  11 files changed, 114 insertions(+), 22 deletions(-)
