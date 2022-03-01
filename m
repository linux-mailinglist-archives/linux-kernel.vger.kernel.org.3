Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA92F4C98DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 00:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiCAXLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 18:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiCAXLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 18:11:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AC5D21E2D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 15:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646176229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dtjFj5tj+NSGL/6JuXVVvD04h8Za4HO6jOAFbynu8C8=;
        b=dPFT6QebrY8vNYvUjd1herq6TL4Nb1rBdR4g9+RgiCGwNgiGxgKZP9F4AxSD2DlXGMvmWM
        Ip1pyvpQvRErzL0cmtYvX/nvNfda5ur57P8jsGoRicXl4zXcmi2NeJeV/ZZu4jHjoeOznf
        BX23q6kllWbjw4ZrJZwWtu2GY2D+mP0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-qNGS6FAbMUSiUR8fjg1Wqg-1; Tue, 01 Mar 2022 18:10:26 -0500
X-MC-Unique: qNGS6FAbMUSiUR8fjg1Wqg-1
Received: by mail-ot1-f71.google.com with SMTP id l3-20020a9d4c03000000b005ad1283cdabso83896otf.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 15:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dtjFj5tj+NSGL/6JuXVVvD04h8Za4HO6jOAFbynu8C8=;
        b=YJarSZIutzRH7qHUOgc8CObWBtnaYHe4iLCrK2c8+UiG9aS/+1Aws5XDLaYNupYhQf
         eklyh3WpMQ/5bn0IrEtxUOlngVRNuzTZg7GPa+2j3fgECvEY4Nfedd75KUd0xKB4r7bF
         ii48EOIaC6pMSdZuOeBBM+At0Nda/z8LZBSV51XCboPpXNzKHq5aIXoEVutgyFfaHIlT
         CUTBibKvhX9bM4xbk5DOPqraV0cJVuhQfGoUgdH+nrahR9V6AJfum9W21GQNL73XFwo5
         0BSumRmYAQqrBE7S9YT7q8v7E0Bf30PB0d12wz66nI8CFgobxWuV5Kzt9ym4NnVeU2wj
         aaLw==
X-Gm-Message-State: AOAM532juJWuFwvGwB+NkLf9evLxg9QcNb7SWdQgr/gQNU4RnkOlK/0+
        NKHMRABugAfZ57kTmpGhLZLkBGNzcFThUYXbsqRAHtSWuGQ/Xe1HfPjKuli9yOw6+4Wa8jC2JxM
        quAziPgWiK/HvvSHZ1kJ7syA3
X-Received: by 2002:aca:60d6:0:b0:2cd:cca:5861 with SMTP id u205-20020aca60d6000000b002cd0cca5861mr15011595oib.151.1646176225934;
        Tue, 01 Mar 2022 15:10:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjH4FGf5xnqYEnpXSwAscwzYOrRsN2zUqj5KBrz+XfEzs3xHUtF57j9O8nudl5BkQOYhszdQ==
X-Received: by 2002:aca:60d6:0:b0:2cd:cca:5861 with SMTP id u205-20020aca60d6000000b002cd0cca5861mr15011578oib.151.1646176225647;
        Tue, 01 Mar 2022 15:10:25 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::b])
        by smtp.gmail.com with ESMTPSA id 35-20020a9d0026000000b005ad363440a2sm6933051ota.64.2022.03.01.15.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 15:10:25 -0800 (PST)
Date:   Tue, 1 Mar 2022 15:10:22 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 00/39] x86: Kernel IBT
Message-ID: <20220301231022.5jb7rkzgpe7mwwku@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224202602.3gvz5tnxvwb4maod@treble>
 <Yhj1oFcTl2RnghBz@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yhj1oFcTl2RnghBz@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 04:28:32PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 24, 2022 at 12:26:02PM -0800, Josh Poimboeuf wrote:
> 
> > Bricked my SPR:
> > 
> > [   21.602888] jump_label: Fatal kernel bug, unexpected op at sched_clock_stable+0x4/0x20 [0000000074a0db20] (eb 06 b8 01 00 != eb 0a 00 00 00)) size:2 type:0
> 
> > ffffffff81120a70 <sched_clock_stable>:
> > ffffffff81120a70:       f3 0f 1e fa             endbr64
> > ffffffff81120a74:       eb 06                   jmp    ffffffff81120a7c <sched_clock_stable+0xc>
> > ffffffff81120a76:       b8 01 00 00 00          mov    $0x1,%eax
> > ffffffff81120a7b:       c3                      retq
> > ffffffff81120a7c:       f3 0f 1e fa             endbr64
> > ffffffff81120a80:       31 c0                   xor    %eax,%eax
> > ffffffff81120a82:       c3                      retq
> > ffffffff81120a83:       66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
> > ffffffff81120a8a:       00 00 00 00
> > ffffffff81120a8e:       66 90                   xchg   %ax,%ax
> 
> This is due to you having a very old (and arguably buggy) compiler :-( I
> can reproduce with gcc-8.4 and gcc-9.4, my gcc-10.3 compiler no longer
> generates daft code like that, nor do any later.
> 
> That said, I can fix objtool to also re-write jumps to in-the-middle
> ENDBR like this, but then I do get a bunch of:
> 
> OBJTOOL vmlinux.o
> vmlinux.o: warning: objtool: displacement doesn't fit
> vmlinux.o: warning: objtool: ep_insert()+0xbc5: Direct IMM jump to ENDBR; cannot fix
> vmlinux.o: warning: objtool: displacement doesn't fit
> vmlinux.o: warning: objtool: configfs_depend_prep()+0x76: Direct IMM jump to ENDBR; cannot fix
> vmlinux.o: warning: objtool: displacement doesn't fit
> vmlinux.o: warning: objtool: request_key_and_link()+0x17b: Direct IMM jump to ENDBR; cannot fix
> vmlinux.o: warning: objtool: displacement doesn't fit
> vmlinux.o: warning: objtool: blk_mq_poll()+0x2e0: Direct IMM jump to ENDBR; cannot fix
> 
> The alternative is only skipping endbr at +0 I suppose, lemme go try
> that with the brand spanking new skip_endbr() function.
> 
> Yep,.. that seems to cure things. It noaw boats when build with old
> crappy compilers too.
> 
> 
> --- a/arch/x86/include/asm/ibt.h
> +++ b/arch/x86/include/asm/ibt.h
> @@ -47,6 +47,8 @@ static inline bool is_endbr(unsigned int
>  	return val == gen_endbr();
>  }
>  
> +extern void *skip_endbr(void *);
> +
>  extern __noendbr u64 ibt_save(void);
>  extern __noendbr void ibt_restore(u64 save);
>  
> @@ -71,6 +73,7 @@ extern __noendbr void ibt_restore(u64 sa
>  #define __noendbr
>  
>  static inline bool is_endbr(unsigned int val) { return false; }
> +static inline void *skip_endbr(void *addr) { return addr; }
>  
>  static inline u64 ibt_save(void) { return 0; }
>  static inline void ibt_restore(u64 save) { }
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -112,10 +112,7 @@ void __text_gen_insn(void *buf, u8 opcod
>  	OPTIMIZER_HIDE_VAR(addr);
>  	OPTIMIZER_HIDE_VAR(dest);
>  
> -#ifdef CONFIG_X86_KERNEL_IBT
> -	if (is_endbr(*(u32 *)dest))
> -		dest += 4;
> -#endif
> +	dest = skip_endbr((void *)dest);
>  
>  	insn->opcode = opcode;
>  
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -620,6 +620,19 @@ __noendbr void ibt_restore(u64 save)
>  	}
>  }
>  
> +
> +void *skip_endbr(void *addr)
> +{
> +	unsigned long size, offset;
> +
> +	if (is_endbr(*(unsigned int *)addr) &&
> +	    kallsyms_lookup_size_offset((unsigned long)addr, &size, &offset) &&
> +	    !offset)
> +		addr += 4;
> +
> +	return addr;
> +}
> +
>  #endif
>  
>  static __always_inline void setup_cet(struct cpuinfo_x86 *c)
> @@ -636,7 +649,10 @@ static __always_inline void setup_cet(st
>  	if (!ibt_selftest()) {
>  		pr_err("IBT selftest: Failed!\n");
>  		setup_clear_cpu_cap(X86_FEATURE_IBT);
> +		return;
>  	}
> +
> +	pr_info("CET detected: Indirect Branch Tracking enabled\n");

This is a little excessive on my 192 CPUs :-)

It also messes with the pr_cont()s in announce_cpu():

[    3.733446] x86: Booting SMP configuration:
[    3.734342] .... node  #0, CPUs:          #1
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    3.770955]    #2
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    3.802979]    #3
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    3.835459]    #4
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    3.866826]    #5
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    3.898690]    #6
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    3.930355]    #7
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    3.961493]    #8
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    3.993500]    #9
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    4.024952]   #10
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    4.056491]   #11
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    4.087493]   #12
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    4.118907]   #13
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    4.150494]   #14
[    3.534902] CET detected: Indirect Branch Tracking enabled
[    4.181425]   #15


-- 
Josh

