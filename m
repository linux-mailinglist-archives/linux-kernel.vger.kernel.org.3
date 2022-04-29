Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730C951554A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380650AbiD2UQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380635AbiD2UQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C38AD5578
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651263210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LEO+jXhVnL6Htz/zGboNc4ko3feoLnFAUu/5535hSf4=;
        b=LnacSPiRl6SfL+W6JpZ2b9arVpszer4TGibdCrxE1+qHzQDGip8UFkV+yweIqagbLdi4OY
        iiUGI2seRWeaD/7z3UCS//LaagJdROkIypAopj+1EeANOeawM80BpjAIj7LqmBYwF8E2WL
        lkp26XPKzmEDEBZdU6pplS+oPBNT1RM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-m9mt3faMM5-YEARc0r6aMw-1; Fri, 29 Apr 2022 16:13:29 -0400
X-MC-Unique: m9mt3faMM5-YEARc0r6aMw-1
Received: by mail-qk1-f197.google.com with SMTP id x25-20020a05620a14b900b0069ec20bb022so5940130qkj.19
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LEO+jXhVnL6Htz/zGboNc4ko3feoLnFAUu/5535hSf4=;
        b=v/YEOEzGV9BI+t6JWllQ2LKUngKReC3l3E9tjVeDtp0/vWhCoEpP30dIIWsbCWHXs9
         cfMiKWDYNE5riNitY0TeU38kygt1MY0nhrTZ8A9nNZzP97ytY6w4McKOPT+Yk0/0OJ+r
         6TElWXhbQtGdn2iDS3OQ/LP1fGC9OO5LuE86GXcjG/vLZOIL8uy8+F9o1WOtIrChwFCp
         MXJOEeJ20TcvUAc+gKXt2oNBOezSQBzP587tI4IMP8rp/SMv69eFP2fs+Iqqz7kzE/iM
         2Fm9Yl8aCwOjxThlgOf6R9ca/+ybI1N2a2DTad5kzrX6bH/97YOZf/YE9KdZPkDQ8SUd
         OywA==
X-Gm-Message-State: AOAM530bAhpb7Kp4n6j/qGQYUNqXKCxcG5573eHuc4HTSg0QFII8H7zn
        0d3d+zzrYgxblXegX4zg/4ZQCpVX/yY0ZudIIMo9HeNzkFAXXuyM+uOVuAZzZ8X2EbPb8hNyu3+
        PHgR0bktXTl6mqnSNrpdLWsAr
X-Received: by 2002:a37:9bd6:0:b0:69f:805e:d1a1 with SMTP id d205-20020a379bd6000000b0069f805ed1a1mr618637qke.404.1651263208463;
        Fri, 29 Apr 2022 13:13:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhzgETqUmEhdgpMXtu4bir2xUDCwJFqueJ+hLRNlVaEy5xG31lEI/dr+kCcybCH5iR5e1WVw==
X-Received: by 2002:a37:9bd6:0:b0:69f:805e:d1a1 with SMTP id d205-20020a379bd6000000b0069f805ed1a1mr618624qke.404.1651263208238;
        Fri, 29 Apr 2022 13:13:28 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id z4-20020ac86b84000000b002f39b99f677sm91602qts.17.2022.04.29.13.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:13:27 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:13:25 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Message-ID: <20220429201325.d5kifdezdru2i3lp@treble>
References: <20220429092024.GT2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429092024.GT2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 11:20:24AM +0200, Peter Zijlstra wrote:
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
>  include/linux/objtool.h |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/objtool.h
> +++ b/include/linux/objtool.h
> @@ -137,7 +137,11 @@ struct unwind_hint {
>  
>  .macro STACK_FRAME_NON_STANDARD func:req
>  	.pushsection .discard.func_stack_frame_non_standard, "aw"
> -		.long \func - .
> +#ifdef CONFIG_64BIT
> +		.quad \func
> +#else
> +		.long \func
> +#endif
>  	.popsection
>  .endm

Can use _ASM_PTR here, and objtool.h needs synced to tools.

-- 
Josh

