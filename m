Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0622A51576C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350262AbiD2V4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbiD2V4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23AF526549
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651269204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5dL+o3dgd3I+9BIcoV5xXMdVohBoY9zXkOYhggaRAJs=;
        b=fTGaOxxVzwzQn1oaVSac0DSm8r6vD4QoXDw2J6xK09drB/RS7bbXe9oURjuFrVa/weFxq3
        VubQNy7HFekJi5lkU1MxpMz1azr/uozKhgit05piMgGfjwQ6mqwJsWFQmGeS2i8F+bmO7Q
        5LTZ+l+mdcISHxwZnidIOzKAJe++OKc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-6UD6hjP8MB6UuOJKIP2_cg-1; Fri, 29 Apr 2022 17:53:22 -0400
X-MC-Unique: 6UD6hjP8MB6UuOJKIP2_cg-1
Received: by mail-qv1-f69.google.com with SMTP id u19-20020ad449b3000000b004523cc11b95so6898908qvx.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5dL+o3dgd3I+9BIcoV5xXMdVohBoY9zXkOYhggaRAJs=;
        b=IGppgO9XI0Bpt2DztsC37Ii/3TM54wcyS4ruzTY2c91Cgaxo/+UHIQB4rAC6t8AH+P
         POZdDbqueRUmaP9JVRll8G2Ii5goBMzc4nblwrUN3nVQdIXf3pLkVoDeGUt2X447PoLH
         /eIQZtbirqTWSWengr4u3FdT9e4Tjtmo2tWXppPuQ1FQKmlABIo4DxhQyQnAJ+K22rqD
         BFBW9OUJQpdigFPQ25NEdikjuKhHPSXq2nLRR+xyUG75+IGM1jbaSDKc/AoLRI1r+/72
         mzxu6wBl8udNmCmTyWCqEYyiP2KKjMhZUbONOFMXS/czxyn+J6nDRrO+FE3cFMZG+3LH
         joyA==
X-Gm-Message-State: AOAM53124XiseRSdEGXkq8qzs1XvuegcRFdu8G0Z9dyPatXW8aO4ab0s
        xAHP+ZEegrxI2/S2KcbeqjFpFm+enXzEWa4AGlxacKtkdLyv+ocjqpq0SxD3afUg39dioYyHKv2
        nqCma9Vdx4gZjRSeTPMQRlwCO
X-Received: by 2002:ad4:5c4a:0:b0:456:4edb:3c04 with SMTP id a10-20020ad45c4a000000b004564edb3c04mr1102257qva.26.1651269202321;
        Fri, 29 Apr 2022 14:53:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxs1mKAj2S/GRwUA5T8JwTzq2WNqyq+Z79pYJA3JIatEtin5n5zKAoSze1+UBoGV2za9ShDXg==
X-Received: by 2002:ad4:5c4a:0:b0:456:4edb:3c04 with SMTP id a10-20020ad45c4a000000b004564edb3c04mr1102244qva.26.1651269202123;
        Fri, 29 Apr 2022 14:53:22 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id b6-20020ac844c6000000b002f39b99f6c3sm252481qto.93.2022.04.29.14.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:53:21 -0700 (PDT)
Date:   Fri, 29 Apr 2022 14:53:19 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Message-ID: <20220429215319.m5tasgmu4t3yrx77@treble>
References: <20220429092024.GT2731@worktop.programming.kicks-ass.net>
 <20220429201325.d5kifdezdru2i3lp@treble>
 <YmxXG3Teg0gJ5PVh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmxXG3Teg0gJ5PVh@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 11:22:35PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 29, 2022 at 01:13:25PM -0700, Josh Poimboeuf wrote:
> > Can use _ASM_PTR here, and objtool.h needs synced to tools.
> 
> Here goes..
> 
> ---
> Subject: objtool: Fix STACK_FRAME_NON_STANDARD reloc type
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Apr 26 17:08:53 CEST 2022
> 
> STACK_FRAME_NON_STANDARD results in inconsistent relocation types
> depending on .c or .S usage:
> 
>   Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x3c01090 contains 5 entries:
>   Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>   0000000000000000  00020c2200000002 R_X86_64_PC32          0000000000047b40 do_suspend_lowlevel + 0
>   0000000000000008  0002461e00000001 R_X86_64_64            00000000000480a0 machine_real_restart + 0
>   0000000000000010  0000001400000001 R_X86_64_64            0000000000000000 .rodata + b3d4
>   0000000000000018  0002444600000002 R_X86_64_PC32          00000000000678a0 __efi64_thunk + 0
>   0000000000000020  0002659d00000001 R_X86_64_64            0000000000113160 __crash_kexec + 0
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/objtool.h       |    2 +-
>  tools/include/linux/objtool.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/objtool.h
> +++ b/include/linux/objtool.h
> @@ -137,7 +137,7 @@ struct unwind_hint {
>  
>  .macro STACK_FRAME_NON_STANDARD func:req
>  	.pushsection .discard.func_stack_frame_non_standard, "aw"
> -		.long \func - .
> +	_ASM_PTR \func
>  	.popsection
>  .endm

This file needs to include <asm/asm.h>, otherwise you get:

arch/x86/kernel/acpi/wakeup_64.S: Assembler messages:
arch/x86/kernel/acpi/wakeup_64.S:132: Error: no such instruction: `_asm_ptr do_suspend_lowlevel'


-- 
Josh

