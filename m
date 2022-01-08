Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB780487FD0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiAHAD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiAHADz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:03:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D48C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 16:03:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B34E0B827B9
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 00:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9AEC36AE9;
        Sat,  8 Jan 2022 00:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641600232;
        bh=hE1JBx+LnKCkS09uZwGJ9c57lUnWhsJUSmayJAeW0Xc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LTu0WQosVkpZblvDe8q2lVUw/g2V5ZluNj9YT2OEG5Sniqpa+5EtIU2RJKp4HOri+
         y+oLdkV9twKnLnS+Tm2j0mTSBsdZhMK3KcVsYoIgjFF30WpQ08HugvMmyrUIyczRPy
         yl/iEjYJ7y5bHTAhmKkTu+tnIME3w+LHoJjycST5SjwPAPMachykGfzG2kqtBd6d6y
         kKcLAAIYEfwIZbrUJW/22q+1Q03d56GSwfTqWi3/kTt3NHSFQeJp5+z6WJJUY8HiGa
         ZRbr9EwKN/jNwuVCQQKY6yKF8UDxREgg7MeTnRLnk7MxPwYet4QWaDN4mjFOTkcFPA
         1+mEJ4+JtzcCg==
Message-ID: <5d1a9dff-6319-14a6-ad81-97350a6849af@kernel.org>
Date:   Fri, 7 Jan 2022 16:03:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 2/3] x86/entry/64: Add info about registers on exit
Content-Language: en-US
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        Michael Matz <matz@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>,
        Willy Tarreau <w@1wt.eu>
References: <20220107235210.1339168-1-ammarfaizi2@gnuweeb.org>
 <20220107235210.1339168-3-ammarfaizi2@gnuweeb.org>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220107235210.1339168-3-ammarfaizi2@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/22 15:52, Ammar Faizi wrote:
> There was a controversial discussion about the wording in the System
> V ABI document regarding what registers the kernel is allowed to
> clobber when the userspace executes syscall.
> 
> The resolution of the discussion was reviewing the clobber list in
> the glibc source. For a historical reason in the glibc source, the
> kernel must restore all registers before returning to the userspace
> (except for rax, rcx and r11).
> 
> Link: https://lore.kernel.org/lkml/alpine.LSU.2.20.2110131601000.26294@wotan.suse.de/
> Link: https://gitlab.com/x86-psABIs/x86-64-ABI/-/merge_requests/25
> 
> This adds info about registers on exit.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Michael Matz <matz@suse.de>
> Cc: "H.J. Lu" <hjl.tools@gmail.com>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: x86-ml <x86@kernel.org>
> Cc: lkml <linux-kernel@vger.kernel.org>
> Cc: GNU/Weeb Mailing List <gwml@gnuweeb.org>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
> 
> Quoted the full comment in that file after patched, so it's easier to
> review:
> /*
>   * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
>   *
>   * This is the only entry point used for 64-bit system calls.  The
>   * hardware interface is reasonably well designed and the register to
>   * argument mapping Linux uses fits well with the registers that are
>   * available when SYSCALL is used.
>   *
>   * SYSCALL instructions can be found inlined in libc implementations as
>   * well as some other programs and libraries.  There are also a handful
>   * of SYSCALL instructions in the vDSO used, for example, as a
>   * clock_gettimeofday fallback.
>   *
>   * 64-bit SYSCALL saves rip to rcx, clears rflags.RF, then saves rflags to r11,
>   * then loads new ss, cs, and rip from previously programmed MSRs.
>   * rflags gets masked by a value from another MSR (so CLD and CLAC
>   * are not needed). SYSCALL does not save anything on the stack
>   * and does not change rsp.
>   *
>   * Registers on entry:
>   * rax  system call number
>   * rcx  return address
>   * r11  saved rflags (note: r11 is callee-clobbered register in C ABI)
>   * rdi  arg0
>   * rsi  arg1
>   * rdx  arg2
>   * r10  arg3 (needs to be moved to rcx to conform to C ABI)
>   * r8   arg4
>   * r9   arg5
>   * (note: r12-r15, rbp, rbx are callee-preserved in C ABI)
>   *
>   * Only called from user space.
>   *
>   * Registers on exit:
>   * rax  syscall return value
>   * rcx  return address
>   * r11  rflags
>   *
>   * For a historical reason in the glibc source, the kernel must restore all
>   * registers except the rax (syscall return value) before returning to the
>   * userspace.
>   *
>   * In other words, with respect to the userspace, when the kernel returns
>   * to the userspace, only 3 registers are clobbered, they are rax, rcx,
>   * and r11.
>   *
>   * When user can change pt_regs->foo always force IRET. That is because
>   * it deals with uncanonical addresses better. SYSRET has trouble
>   * with them due to bugs in both AMD and Intel CPUs.
>   */
> 
> ---
> 
>   arch/x86/entry/entry_64.S | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index e432dd075291..1111fff2e05f 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -79,6 +79,19 @@
>    *
>    * Only called from user space.
>    *
> + * Registers on exit:
> + * rax  syscall return value
> + * rcx  return address
> + * r11  rflags
> + *
> + * For a historical reason in the glibc source, the kernel must restore all
> + * registers except the rax (syscall return value) before returning to the
> + * userspace.
> + *
> + * In other words, with respect to the userspace, when the kernel returns
> + * to the userspace, only 3 registers are clobbered, they are rax, rcx,
> + * and r11.
> + *

I would say this much more concisely:

The Linux kernel preserves all registers (even C callee-clobbered 
registers) except for rax, rcx and r11 across system calls, and existing 
user code relies on this behavior.

>    * When user can change pt_regs->foo always force IRET. That is because
>    * it deals with uncanonical addresses better. SYSRET has trouble
>    * with them due to bugs in both AMD and Intel CPUs.
> 

