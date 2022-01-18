Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AE34929C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345867AbiARPhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:37:46 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:41909 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238270AbiARPhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:37:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V2CoSVm_1642520260;
Received: from 192.168.2.97(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0V2CoSVm_1642520260)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 23:37:41 +0800
Message-ID: <51520425-dcdf-cae6-65a8-496d89905361@linux.alibaba.com>
Date:   Tue, 18 Jan 2022 23:37:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 3/3] x86/sev: The code for returning to user space is also
 in syscall gap
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
 <20211213042215.3096-4-jiangshanlai@gmail.com> <YbkR36Vpb1h5SlMZ@zn.tnic>
 <YbxhBQg99YCTrYN3@suse.de> <Ybxmsn1wp8NZjXaD@zn.tnic>
 <Ybxt0g+U11hZhbSh@suse.de> <YeaXP51ClhnV8Xfd@zn.tnic>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
In-Reply-To: <YeaXP51ClhnV8Xfd@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/18 18:32, Borislav Petkov wrote:
> On Fri, Dec 17, 2021 at 12:00:34PM +0100, Joerg Roedel wrote:
>> On Fri, Dec 17, 2021 at 11:30:10AM +0100, Borislav Petkov wrote:
>>> I audited the handful instructions in there and didn't find anything
>>> that would cause a #VC...
>>
>> If the hypervisor decides to mess with the code-page for this path
>> while a CPU is executing it. This will cause a #VC on that CPU and that
>> could hit in the syscall return path.
> 
> So I added a CPUID on that return path:
> 
> @@ -213,8 +213,11 @@ syscall_return_via_sysret:
>   
>          popq    %rdi
>          popq    %rsp
> +       cpuid
> 
> 
> It results in the splat below. I.e., we're on the VC2 stack. We've
> landed there because:
> 
>   * If entered from kernel-mode the return stack is validated first, and if it is
>   * not safe to use (e.g. because it points to the entry stack) the #VC handler
>   * will switch to a fall-back stack (VC2) and call a special handler function.
> 

Hello

Thanks for testing.

The log shows that the %rsp is 0x7ffc79fd7e78 before the #VC, which means the
userspace might not be malicious since it might not tamper the %rsp.

If the userspace is not malicious, there is nothing wrong with it when #VC is
on this gap.

If the userspace is malicious and misleads vc_switch_off_ist(), it would harm
the system.

For example, (I haven't test it, I am just imaging it,) if user %rsp were set
to be the kernel #NMI stack, #VC would keep running on #NMI stack, its stack
would be corrupted when a #NMI is delivered since #NMI is not masked.  It would
be more dangerous if the hypervisor connives with the userspace.

I think ip_within_syscall_gap() was designed for avoid using userspace %rsp
albeit it misses the path returning to user space.

Thanks
Lai.

> and what puts us there is, I think:
> 
> vc_switch_off_ist:
>          if (!get_stack_info_noinstr(stack, current, &info) || info.type == STACK_TYPE_ENTRY ||
>              info.type > STACK_TYPE_EXCEPTION_LAST)
>                  sp = __this_cpu_ist_top_va(VC2);
> 
> but I need to stare at this more later to figure it all out properly.
> 
> [    1.372783] Kernel panic - not syncing: Can't handle #VC exception from unsupported context: sp: 0xfffffe0000019f58, prev_sp: 0x7ffc79fd7e78, VC2 stack [0xfffffe0000018000:0xfffffe000001a000]
> [    1.374828] CPU: 0 PID: 1 Comm: init Not tainted 5.16.0+ #6
> [    1.375586] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> [    1.376553] Call Trace:
> [    1.377030]  <#VC2>
> [    1.377462]  dump_stack_lvl+0x48/0x5e
> [    1.378038]  panic+0xfa/0x2c6
> [    1.378570]  kernel_exc_vmm_communication+0x10e/0x160
> [    1.379275]  asm_exc_vmm_communication+0x30/0x60
> [    1.379934] RIP: 0010:syscall_return_via_sysret+0x28/0x2a
> [    1.380669] Code: 00 00 41 5f 41 5e 41 5d 41 5c 5d 5b 5e 41 5a 41 59 41 58 58 5e 5a 5e 48 89 e7 65 48 8b 24 25 04 60 00 00 ff 77 28 ff 37 5f 5c <0f> a2 0f 01 f8 48 0f 07 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00
> [    1.384240] RSP: 0018:00007ffc79fd7e78 EFLAGS: 00010046
> [    1.384977] RAX: 00005555e4b80000 RBX: 0000000000000001 RCX: 00007fc2d978ac17
> [    1.385894] RDX: 0000000000000054 RSI: 00007fc2d9792e09 RDI: 0000000000000000
> [    1.386816] RBP: 00007fc2d97724e0 R08: 00007ffc79fd9fe7 R09: 00007fc2d979ae88
> [    1.387734] R10: 000000000000001c R11: 0000000000000246 R12: 00005555e448e040
> [    1.388647] R13: 000000000000000b R14: 0000000000000000 R15: 00007ffc79fd8119
> [    1.389559]  </#VC2>
> [    1.391521] Kernel Offset: 0x7e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [    1.393015] ---[ end Kernel panic - not syncing: Can't handle #VC exception from unsupported context: sp: 0xfffffe0000019f58, prev_sp: 0x7ffc79fd7e78, VC2 stack [0xfffffe0000018000:0xfffffe000001a000] ]---
> 
> 
