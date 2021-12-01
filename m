Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4992D46493F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347320AbhLAIDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:03:25 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:38827 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbhLAIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:03:24 -0500
Received: by mail-wm1-f49.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso21511083wms.3;
        Wed, 01 Dec 2021 00:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=COLb+tD9tUlJqRA3EmYnXbmZWIsvi9bMrsPhaY8Ollw=;
        b=LluDtRd07NuiAjJZ3UbhbX+vIP+Q78RTo4DVuUcqR6ReJ/oTeEAKIFCMhVgPrVxl1Q
         Vpd+v/RMQj+z+hIT1NyIR+dT7ueDEk4/voECmaNwGirJvXcTtF1qmgduF5hykwRd/TG4
         FMM3v1JjP3kOCp0wmSKuvzbuUVfk/AIAH8/A2es1xaPZQQ7S4zFPntfdDbRQfUWDTJJT
         RK4qhNqcDzyEP0+tY1Dtl13Rb6CpCsew8jlL96aDWANb5+3YYIh1vKg+tHsSjDcO978d
         t+c8N/NprDCVDVxH6G2loUaMVchbrXI+l0ue9AadkYGKxurViBBYTvE2SAn6B0gryUS+
         ZjoQ==
X-Gm-Message-State: AOAM533zKCQZb2LkC1kZFSLynncOcpOW2gxpYLvWBwjusyvpPwmL+26V
        ksQUAhOzAf0Ecj8xS3s3ouA=
X-Google-Smtp-Source: ABdhPJwBjqG8PuzEUvkS7dzMT3rCTtsKUVlZt7OW5M1KGohXkvSn2n6pp59uMUojrWGFTBFe+CTyRw==
X-Received: by 2002:a05:600c:4f4b:: with SMTP id m11mr4829671wmq.151.1638345602659;
        Wed, 01 Dec 2021 00:00:02 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id m17sm18035071wrz.22.2021.12.01.00.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 00:00:02 -0800 (PST)
Message-ID: <f81a6434-9f38-947e-02a8-9a9191285e52@kernel.org>
Date:   Wed, 1 Dec 2021 09:00:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/3] x86: mm: add x86_64 support for page table check
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, pjt@google.com, weixugc@google.com,
        gthelen@google.com, mingo@redhat.com, corbet@lwn.net,
        will@kernel.org, rppt@kernel.org, keescook@chromium.org,
        tglx@linutronix.de, peterz@infradead.org, masahiroy@kernel.org,
        samitolvanen@google.com, dave.hansen@linux.intel.com,
        x86@kernel.org, frederic@kernel.org, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
 <20211123214814.3756047-4-pasha.tatashin@soleen.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211123214814.3756047-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 11. 21, 22:48, Pasha Tatashin wrote:
> Add page table check hooks into routines that modify user page tables.

Hi,

I bisected to this as this causes crashes during modules load:
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD 6d615067 P4D 6d615067 PUD 6d616063 PMD 800000006d2001e1
Oops: 0003 [#1] PREEMPT SMP PTI
CPU: 0 PID: 6189 Comm: modprobe Kdump: loaded Tainted: G          I E 
   5.16.0-rc2-next-20211129-vanilla #3 
83846a405f0e3937f5c8dfbc7d449622b8f46369
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be 
filled by O.E.M., BIOS SDBLI944.86P 05/08/2007
RIP: 0010:jump_label_module_notify (kernel/jump_label.c:370 
kernel/jump_label.c:670 kernel/jump_label.c:748)
Code: 00 48 8b 43 08 a8 02 0f 85 e9 00 00 00 48 83 e0 fc 48 c7 02 00 00 
00 00 48 89 42 08 48 8b 43 08 83 e0 03 48 09 c2 48 83 ca 02 <48> 89 53 
08 4d 89 66 10 49 89 6e 08 48 8b 43 08 a8 02 0f 84 98 00
All code
========
    0:	00 48 8b             	add    %cl,-0x75(%rax)
    3:	43 08 a8 02 0f 85 e9 	rex.XB or %bpl,-0x167af0fe(%r8)
    a:	00 00                	add    %al,(%rax)
    c:	00 48 83             	add    %cl,-0x7d(%rax)
    f:	e0 fc                	loopne 0xd
   11:	48 c7 02 00 00 00 00 	movq   $0x0,(%rdx)
   18:	48 89 42 08          	mov    %rax,0x8(%rdx)
   1c:	48 8b 43 08          	mov    0x8(%rbx),%rax
   20:	83 e0 03             	and    $0x3,%eax
   23:	48 09 c2             	or     %rax,%rdx
   26:	48 83 ca 02          	or     $0x2,%rdx
   2a:*	48 89 53 08          	mov    %rdx,0x8(%rbx)		<-- trapping 
instruction
   2e:	4d 89 66 10          	mov    %r12,0x10(%r14)
   32:	49 89 6e 08          	mov    %rbp,0x8(%r14)
   36:	48 8b 43 08          	mov    0x8(%rbx),%rax
   3a:	a8 02                	test   $0x2,%al
   3c:	0f                   	.byte 0xf
   3d:	84                   	.byte 0x84
   3e:	98                   	cwtl
	...

Code starting with the faulting instruction
===========================================
    0:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    4:	4d 89 66 10          	mov    %r12,0x10(%r14)
    8:	49 89 6e 08          	mov    %rbp,0x8(%r14)
    c:	48 8b 43 08          	mov    0x8(%rbx),%rax
   10:	a8 02                	test   $0x2,%al
   12:	0f                   	.byte 0xf
   13:	84                   	.byte 0x84
   14:	98                   	cwtl
	...
RSP: 0018:ffffaf4dc051fbe8 EFLAGS: 00010282
RAX: 0000000000000001 RBX: ffffffff931ee760 RCX: 0000000000000001
RDX: ffff9d1aa7d43883 RSI: ffffffff91c50aa0 RDI: ffffffff931ee760
RBP: ffffffffc0782000 R08: 0000000000000020 R09: 0000000000000000
R10: ffff9d1aa7d43880 R11: 0000000000000000 R12: ffffffffc079a980
R13: ffffffffc0784080 R14: ffff9d1aa7d43ca0 R15: ffffffffc0782008
FS:  00007f87104b8740(0000) GS:ffff9d1b45c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff931ee768 CR3: 000000010fdce000 CR4: 00000000000006f0
Call Trace:
  <TASK>
blocking_notifier_call_chain_robust (kernel/notifier.c:83 
kernel/notifier.c:118 kernel/notifier.c:283 kernel/notifier.c:271)
load_module (./include/linux/notifier.h:198 kernel/module.c:3923 
kernel/module.c:4100)
__do_sys_finit_module (kernel/module.c:4224)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113)

> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   arch/x86/Kconfig               |  1 +
>   arch/x86/include/asm/pgtable.h | 29 +++++++++++++++++++++++++++--
>   2 files changed, 28 insertions(+), 2 deletions(-)
> 

regards,
-- 
js
suse labs
