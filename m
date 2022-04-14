Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E9E501B96
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344238AbiDNTKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbiDNTKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DEC7EB0B6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649963277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uv9Qj3cLySglZpILz1Tg747BYV9bj/hX2QO10CjQwo0=;
        b=RAsRoQoQP/oSN7ncZqBiXMoBIOwZB3t8frjZF48wOFUG6F2AFMP79lMqypvu/UpuB2tfh3
        yFytMtdKgmlTZdsx1F2rsO/fV8jVpbMilhNJdkd4q0BTTWghqviKD6TOfIPgFh06ByEwQ2
        Ig5Qw3SgZPSeiB7BkEVqpmMKllBouQI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-cb6joba6O2agJy3-7OElrg-1; Thu, 14 Apr 2022 15:07:56 -0400
X-MC-Unique: cb6joba6O2agJy3-7OElrg-1
Received: by mail-qv1-f72.google.com with SMTP id m15-20020a0562141bcf00b00443ddcd8a0fso5129425qvc.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uv9Qj3cLySglZpILz1Tg747BYV9bj/hX2QO10CjQwo0=;
        b=fB1sQEMtOJe2OLUku7Vvlwka0JUYN03MyWDAcV7rKaj7T86CjGk3KhL3fg5DTfe5OZ
         d8fFcYaukBNKzQ/TBd9Rohu9j4dg3zw5HiZ/2jD8+p6oxVqAkd0VabKOQlSGiWgYpqo4
         cNFcU0aGiElvpcG9CGY3neC72oID972ZnBBTPbKKkWdwpvdAVBw3OlAFxf5Po7MdfRJB
         kN7iNUCc7FOQ27pFjTtv2SWP1pccWSiQ/QVTds8t7I1FG7VIlEZzCR9OrzzLy1lmUUKt
         DVZ1aaV6q2lPO9Avuikc6qozzzo6iBY2oKV+jgrEqYYsx62Gv3lXPSOeXyTv+ytGNiHu
         bZVQ==
X-Gm-Message-State: AOAM532xRtjUsp/KhxNATRPa6YcC04NQez/7fxUI8KugkddY0XH6OwdF
        pA6/PHtZbfG91u2/82JrpN5k9SAwCXWHANFpmGZ0M47XzsPTRgMtseqyIYuKAjLgrD0bnY1gsz4
        QFIltD0dZjq99+rv59I20Zwmu
X-Received: by 2002:ac8:7ca1:0:b0:2ed:f4a:1bb8 with SMTP id z1-20020ac87ca1000000b002ed0f4a1bb8mr2947160qtv.369.1649963275545;
        Thu, 14 Apr 2022 12:07:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx435TXg1mwzy4U6UXp8SD9bkXfcRNCWBOp+MQZn9mMUywZ4VMDfqZvpuPesRIcFZdECBRp3A==
X-Received: by 2002:ac8:7ca1:0:b0:2ed:f4a:1bb8 with SMTP id z1-20020ac87ca1000000b002ed0f4a1bb8mr2947141qtv.369.1649963275296;
        Thu, 14 Apr 2022 12:07:55 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id 193-20020a3703ca000000b0069bf950dd20sm1413370qkd.43.2022.04.14.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:07:54 -0700 (PDT)
Date:   Thu, 14 Apr 2022 12:07:51 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 10/18] objtool: Extricate ibt from stack validation
Message-ID: <20220414190526.klnrtc3behsbxftb@treble>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <44a73f724b51c4a994edc43536b7a7ee5e972b40.1649891421.git.jpoimboe@redhat.com>
 <YlfS7twQVCHGgtCV@hirez.programming.kicks-ass.net>
 <20220414154449.5moa7xsczwybbqhd@treble>
 <YlhN+GFZlycwydSv@hirez.programming.kicks-ass.net>
 <20220414170550.v2jmdfhmz7zbuug6@treble>
 <20220414182505.oirx3znjl7ceozq3@treble>
 <YlhvpGsUFIOLByhp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlhvpGsUFIOLByhp@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 09:01:56PM +0200, Peter Zijlstra wrote:
> > diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
> > index ecb2049c1273..b7dfd60243b7 100644
> > --- a/arch/x86/lib/putuser.S
> > +++ b/arch/x86/lib/putuser.S
> > @@ -48,6 +48,7 @@ SYM_FUNC_START(__put_user_1)
> >  	cmp %_ASM_BX,%_ASM_CX
> >  	jae .Lbad_put_user
> >  SYM_INNER_LABEL(__put_user_nocheck_1, SYM_L_GLOBAL)
> > +	ENDBR
> >  	ASM_STAC
> >  1:	movb %al,(%_ASM_CX)
> >  	xor %ecx,%ecx
> > @@ -62,6 +63,7 @@ SYM_FUNC_START(__put_user_2)
> >  	cmp %_ASM_BX,%_ASM_CX
> >  	jae .Lbad_put_user
> >  SYM_INNER_LABEL(__put_user_nocheck_2, SYM_L_GLOBAL)
> > +	ENDBR
> >  	ASM_STAC
> >  2:	movw %ax,(%_ASM_CX)
> >  	xor %ecx,%ecx
> > @@ -76,6 +78,7 @@ SYM_FUNC_START(__put_user_4)
> >  	cmp %_ASM_BX,%_ASM_CX
> >  	jae .Lbad_put_user
> >  SYM_INNER_LABEL(__put_user_nocheck_4, SYM_L_GLOBAL)
> > +	ENDBR
> >  	ASM_STAC
> >  3:	movl %eax,(%_ASM_CX)
> >  	xor %ecx,%ecx
> > @@ -90,6 +93,7 @@ SYM_FUNC_START(__put_user_8)
> >  	cmp %_ASM_BX,%_ASM_CX
> >  	jae .Lbad_put_user
> >  SYM_INNER_LABEL(__put_user_nocheck_8, SYM_L_GLOBAL)
> > +	ENDBR
> >  	ASM_STAC
> >  4:	mov %_ASM_AX,(%_ASM_CX)
> >  #ifdef CONFIG_X86_32
> 
> Hmm, how did those go missing?

Because the current code only warns about references from .data/.rodata.
This patch changes that.

> > diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> > index 5f87bab4fb8d..b2b2366885a2 100644
> > --- a/arch/x86/lib/retpoline.S
> > +++ b/arch/x86/lib/retpoline.S
> > @@ -31,6 +31,7 @@
> >  	.align RETPOLINE_THUNK_SIZE
> >  SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
> >  	UNWIND_HINT_EMPTY
> > +	ANNOTATE_NOENDBR
> >  
> >  	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
> >  		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
> > @@ -55,7 +56,6 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
> >  
> >  	.align RETPOLINE_THUNK_SIZE
> >  SYM_CODE_START(__x86_indirect_thunk_array)
> > -	ANNOTATE_NOENDBR // apply_retpolines
> >  
> >  #define GEN(reg) THUNK reg
> >  #include <asm/GEN-for-each-reg.h>
> 
> Hmm, where does that come from? Do you have commit be8a096521ca
> ("x86,bpf: Avoid IBT objtool warning")?

Same answer as above, this patch now warns about exported symbols with
missing ENDBR.

-- 
Josh

