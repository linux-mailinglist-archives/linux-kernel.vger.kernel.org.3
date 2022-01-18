Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC294923C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiARKce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:32:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38590 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232429AbiARKce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:32:34 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED3791EC056A;
        Tue, 18 Jan 2022 11:32:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642501949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gBSntYkr/iYFc7zvrENU0LC5tsYQd8u4PJ959TEVEw0=;
        b=sHIOH7LYZloIB1dv2y75TIA7lJRgd774uwOOoT41rZvRnhlC6AIj/sx2W7LUfEDlN+27Qj
        3ln0OgyA/C1XDpXyMIa5OyEBsG8dZTfrCz1vZbqw4TFobqCtshBxsCGiriOAHLn3kSDGEe
        H4RiORpMLBZNCwZECfTKrKCGPjoVkwM=
Date:   Tue, 18 Jan 2022 11:32:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: The code for returning to user space is
 also in syscall gap
Message-ID: <YeaXP51ClhnV8Xfd@zn.tnic>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
 <20211213042215.3096-4-jiangshanlai@gmail.com>
 <YbkR36Vpb1h5SlMZ@zn.tnic>
 <YbxhBQg99YCTrYN3@suse.de>
 <Ybxmsn1wp8NZjXaD@zn.tnic>
 <Ybxt0g+U11hZhbSh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ybxt0g+U11hZhbSh@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:00:34PM +0100, Joerg Roedel wrote:
> On Fri, Dec 17, 2021 at 11:30:10AM +0100, Borislav Petkov wrote:
> > I audited the handful instructions in there and didn't find anything
> > that would cause a #VC...
> 
> If the hypervisor decides to mess with the code-page for this path
> while a CPU is executing it. This will cause a #VC on that CPU and that
> could hit in the syscall return path.

So I added a CPUID on that return path:

@@ -213,8 +213,11 @@ syscall_return_via_sysret:
 
        popq    %rdi
        popq    %rsp
+       cpuid


It results in the splat below. I.e., we're on the VC2 stack. We've
landed there because:

 * If entered from kernel-mode the return stack is validated first, and if it is
 * not safe to use (e.g. because it points to the entry stack) the #VC handler
 * will switch to a fall-back stack (VC2) and call a special handler function.

and what puts us there is, I think:

vc_switch_off_ist:
        if (!get_stack_info_noinstr(stack, current, &info) || info.type == STACK_TYPE_ENTRY ||
            info.type > STACK_TYPE_EXCEPTION_LAST)
                sp = __this_cpu_ist_top_va(VC2);

but I need to stare at this more later to figure it all out properly.

[    1.372783] Kernel panic - not syncing: Can't handle #VC exception from unsupported context: sp: 0xfffffe0000019f58, prev_sp: 0x7ffc79fd7e78, VC2 stack [0xfffffe0000018000:0xfffffe000001a000]
[    1.374828] CPU: 0 PID: 1 Comm: init Not tainted 5.16.0+ #6
[    1.375586] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[    1.376553] Call Trace:
[    1.377030]  <#VC2>
[    1.377462]  dump_stack_lvl+0x48/0x5e
[    1.378038]  panic+0xfa/0x2c6
[    1.378570]  kernel_exc_vmm_communication+0x10e/0x160
[    1.379275]  asm_exc_vmm_communication+0x30/0x60
[    1.379934] RIP: 0010:syscall_return_via_sysret+0x28/0x2a
[    1.380669] Code: 00 00 41 5f 41 5e 41 5d 41 5c 5d 5b 5e 41 5a 41 59 41 58 58 5e 5a 5e 48 89 e7 65 48 8b 24 25 04 60 00 00 ff 77 28 ff 37 5f 5c <0f> a2 0f 01 f8 48 0f 07 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00
[    1.384240] RSP: 0018:00007ffc79fd7e78 EFLAGS: 00010046
[    1.384977] RAX: 00005555e4b80000 RBX: 0000000000000001 RCX: 00007fc2d978ac17
[    1.385894] RDX: 0000000000000054 RSI: 00007fc2d9792e09 RDI: 0000000000000000
[    1.386816] RBP: 00007fc2d97724e0 R08: 00007ffc79fd9fe7 R09: 00007fc2d979ae88
[    1.387734] R10: 000000000000001c R11: 0000000000000246 R12: 00005555e448e040
[    1.388647] R13: 000000000000000b R14: 0000000000000000 R15: 00007ffc79fd8119
[    1.389559]  </#VC2>
[    1.391521] Kernel Offset: 0x7e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    1.393015] ---[ end Kernel panic - not syncing: Can't handle #VC exception from unsupported context: sp: 0xfffffe0000019f58, prev_sp: 0x7ffc79fd7e78, VC2 stack [0xfffffe0000018000:0xfffffe000001a000] ]---


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
