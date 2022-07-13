Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ACE573CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbiGMSoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiGMSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:44:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2DB2872C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:44:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so5131729pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g4Up8vaLk3b7wjar4iUpkOugA6Vjg6aW9wmzcqklAvM=;
        b=iiA5sW+5/4fFvsxKvRA26Y/sEuJ3WvvU6tn5AItoTngPgsfcbG8b7OOuu/PetLTtwf
         y0zP15XC4Xun04poKH6ksyaRmp/L6WwG8o76QeD3q6Sq5Gsaor5FAiXRRwrHC1SDE3FC
         SoHK+0Ps9WOT1tzSO2Gl9mgbiCxOAe/+DNZw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g4Up8vaLk3b7wjar4iUpkOugA6Vjg6aW9wmzcqklAvM=;
        b=6PTvDbieps4abOZA04uqtcT9iMEaSdgIeq5EZY9u0ef4ESDpZi2KTwztGXfTZ9Tzmu
         kXijim6do6EPyxH7WXkwC15lIeG+Q6R0iQTLVEXzYeLNnhlP5+vkrV7QukECxjmC++H4
         gblzO/XeNqWt/poBPU1WphusIlz4EAX6ymRkt35qO8X7hAo5d93vIxoqfXobrecpbHda
         PR+qBz+fKtfAhga0tDoBvZGWMgAkkW5vMMAdiMTCBmXsqK3iuS890jmxCm89wagRW552
         ZtTb/HqlUD9WeZHsmsHT89OfKW1m51Powx5rulc61CHCOxsNE4R4GmgabzK04dj9AeDN
         rAmg==
X-Gm-Message-State: AJIora+tZVAMRDyn3gMiIU6hqSzdKFl0u2egArYwx6lyxpOpI5h33A/B
        Q4286S7HwKXR96tp7WEe+SEpJw==
X-Google-Smtp-Source: AGRyM1t9TSQLYDSHgbqKe3tAPMyAp7UmlBPMP155GPj1w6BMwvxzr1HAysw0MX3nlmaA6hoDKDFWAw==
X-Received: by 2002:a17:902:d2d1:b0:16c:223e:a3db with SMTP id n17-20020a170902d2d100b0016c223ea3dbmr4438366plc.37.1657737855962;
        Wed, 13 Jul 2022 11:44:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b0016a0fe1a1fbsm9263904plf.220.2022.07.13.11.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 11:44:15 -0700 (PDT)
Date:   Wed, 13 Jul 2022 11:44:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [x86,static_call]  ee88d363d1:
 WARNING:at_arch/x86/kernel/alternative.c:#apply_returns
Message-ID: <202207131136.AFA428CA@keescook>
References: <Ys58BxHxoDZ7rfpr@xsang-OptiPlex-9020>
 <Ys66hwtFcGbYmoiZ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys66hwtFcGbYmoiZ@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 02:28:55PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 13, 2022 at 04:02:15PM +0800, kernel test robot wrote:
> 
> > [   22.065014][    T0] ------------[ cut here ]------------
> > [ 22.066738][ T0] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:557 apply_returns (arch/x86/kernel/alternative.c:557 (discriminator 1)) 
> > [   22.069534][    T0] Modules linked in:
> > [   22.070738][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc4-00008-gee88d363d156 #1
> > [   22.072739][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> > [ 22.074741][ T0] RIP: 0010:apply_returns (arch/x86/kernel/alternative.c:557 (discriminator 1)) 
> > [ 22.076739][ T0] Code: ff ff 74 cb 48 83 c5 04 49 39 ee 0f 87 81 fe ff ff e9 22 ff ff ff 0f 0b 48 83 c5 04 49 39 ee 0f 87 6d fe ff ff e9 0e ff ff ff <0f> 0b 48 83 c5 04 49 39 ee 0f 87 59 fe ff ff e9 fa fe ff ff 48 89
> > All code
> > ========
> >    0:	ff                   	(bad)  
> >    1:	ff 74 cb 48          	pushq  0x48(%rbx,%rcx,8)
> >    5:	83 c5 04             	add    $0x4,%ebp
> >    8:	49 39 ee             	cmp    %rbp,%r14
> >    b:	0f 87 81 fe ff ff    	ja     0xfffffffffffffe92
> >   11:	e9 22 ff ff ff       	jmpq   0xffffffffffffff38
> >   16:	0f 0b                	ud2    
> >   18:	48 83 c5 04          	add    $0x4,%rbp
> >   1c:	49 39 ee             	cmp    %rbp,%r14
> >   1f:	0f 87 6d fe ff ff    	ja     0xfffffffffffffe92
> >   25:	e9 0e ff ff ff       	jmpq   0xffffffffffffff38
> >   2a:*	0f 0b                	ud2    		<-- trapping instruction
> >   2c:	48 83 c5 04          	add    $0x4,%rbp
> >   30:	49 39 ee             	cmp    %rbp,%r14
> >   33:	0f 87 59 fe ff ff    	ja     0xfffffffffffffe92
> >   39:	e9 fa fe ff ff       	jmpq   0xffffffffffffff38
> >   3e:	48                   	rex.W
> >   3f:	89                   	.byte 0x89
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	0f 0b                	ud2    
> >    2:	48 83 c5 04          	add    $0x4,%rbp
> >    6:	49 39 ee             	cmp    %rbp,%r14
> >    9:	0f 87 59 fe ff ff    	ja     0xfffffffffffffe68
> >    f:	e9 fa fe ff ff       	jmpq   0xffffffffffffff0e
> >   14:	48                   	rex.W
> >   15:	89                   	.byte 0x89
> > [   22.078738][    T0] RSP: 0000:ffffffffa2807dc0 EFLAGS: 00010202
> > [   22.080737][    T0] RAX: 0000000000000000 RBX: ffffffffa1b8fe05 RCX: 0000000000000000
> > [   22.082546][    T0] RDX: 000000000000000f RSI: ffffffffa184a3e0 RDI: ffffffffa1b8fe05
> > [   22.083738][    T0] RBP: ffffffffa42851e8 R08: 0000000000000001 R09: ffffffffa1b8fe05
> > [   22.086491][    T0] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa1b8fe00
> > [   22.087738][    T0] R13: dffffc0000000000 R14: ffffffffa4299890 R15: 1ffffffff4500fbb
> > [   22.089739][    T0] FS:  0000000000000000(0000) GS:ffff888396600000(0000) knlGS:0000000000000000
> > [   22.091743][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   22.093738][    T0] CR2: ffff88843ffff000 CR3: 00000003a562a000 CR4: 00000000000006f0
> > [   22.095753][    T0] Call Trace:
> > [   22.097742][    T0]  <TASK>
> > [ 22.098765][ T0] ? rwlock_bug+0xc0/0xc0 
> > [ 22.100230][ T0] ? apply_retpolines (arch/x86/kernel/alternative.c:538) 
> > [ 22.101791][ T0] ? int3_exception_notify (arch/x86/kernel/alternative.c:849) 
> > [ 22.103261][ T0] ? check_bugs (arch/x86/kernel/cpu/bugs.c:149) 
> > [ 22.104751][ T0] alternative_instructions (arch/x86/kernel/alternative.c:932) 
> > [ 22.106766][ T0] check_bugs (arch/x86/kernel/cpu/bugs.c:159) 
> > [ 22.108244][ T0] start_kernel (init/main.c:1132) 
> > [ 22.109747][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358) 
> > [   22.111300][    T0]  </TASK>
> > [   22.112742][    T0] irq event stamp: 87769
> > [ 22.113741][ T0] hardirqs last enabled at (87781): __up_console_sem (arch/x86/include/asm/irqflags.h:45 (discriminator 1) arch/x86/include/asm/irqflags.h:80 (discriminator 1) arch/x86/include/asm/irqflags.h:138 (discriminator 1) kernel/printk/printk.c:264 (discriminator 1)) 
> > [ 22.115740][ T0] hardirqs last disabled at (87794): __up_console_sem (kernel/printk/printk.c:262 (discriminator 1)) 
> > [ 22.117739][ T0] softirqs last enabled at (2774): cgroup_idr_alloc+0x5b/0x1c0 
> > [ 22.119739][ T0] softirqs last disabled at (2772): cgroup_idr_alloc+0x2e/0x1c0 
> > [   22.121741][    T0] ---[ end trace 0000000000000000 ]---
> 
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index d6858533e6e5..ff309e829192 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -555,8 +555,10 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
>  			dest = addr + insn.length + insn.immediate.value;
>  
>  		if (__static_call_fixup(addr, op, dest) ||
> -		    WARN_ON_ONCE(dest != &__x86_return_thunk))
> +		    WARN_ON_ONCE(dest != &__x86_return_thunk)) {
> +			printk("XXX: %pS %pS : %*ph", addr, dest, 5, addr);
>  			continue;
> +		}
>  
>  		DPRINTK("return thunk at: %pS (%px) len: %d to: %pS",
>  			addr, addr, insn.length,
> 
> Gets me:
> 
> [    2.559091][    T0] ---[ end trace 0000000000000000 ]---
> [    2.561092][    T0] XXX: lkdtm_rodata_do_nothing+0x0/0x1240 lkdtm_rodata_do_nothing+0x5/0x1240 : e9 00 00 00 00
> 
> which is a result of:
> 
> drivers/misc/lkdtm/Makefile:OBJCOPYFLAGS_rodata_objcopy.o   := \
> drivers/misc/lkdtm/Makefile:                        --rename-section .noinstr.text=.rodata,alloc,readonly,load,contents
> 
> which makes that:
> 
> 0000000000000000 <lkdtm_rodata_do_nothing>:
>    0:   e9 00 00 00 00          jmp    5 <lkdtm_rodata_do_nothing+0x5>  1: R_X86_64_PLT32       __x86_return_thunk-0x4
> 
> remains unresolved.
> 
> Kees, what's up with that thing, this is 'weird' at best.

Whee. Yeah, this is a regression test for validating that the .data
section is not executable. It's designed to be arch-agnostic to avoid
needing to know how to return from a function call.

Is there some way for this to opt out of the thunk and leave it a bare
"ret"?

-- 
Kees Cook
