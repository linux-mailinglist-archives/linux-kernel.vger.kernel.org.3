Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2921351EC31
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 10:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiEHIdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 04:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiEHIdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 04:33:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA542B87C
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 01:29:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s14so11304893plk.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 01:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7UCpbCYGemt9Aa/Zw4e1HeL9KMk2vOHpzpuPbbac9aU=;
        b=W58G+8OdHxU0j/pFN3mIvPOnRpk6BIqcuZSfqNuZZzoFVmecuaGfMsMDt+G1bLgLl8
         LPm9jP88QfIEHAmcnigel+Qk2ayRkL43IeIN5NtRftZTKEo8VI+sg0RLcHFghTCiYcsC
         ZeM4dXARwFAQ6PXK7FqxmriJ13nlEXu/NkCxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7UCpbCYGemt9Aa/Zw4e1HeL9KMk2vOHpzpuPbbac9aU=;
        b=o3UHGe/5jtTdpbxkE4rb6ZYm8kwM0BlFDLtfsfA7V7M2SIyOzOm1f+Za4pWJto/TA5
         ptATtxtIN2YmhXXuRnCvYIKAiHLdwjnMx5KfPeihfwWX1epSN0K77YFlGmLgotNib5D5
         4RCqzlLkHduuaf0Vgh0Ta1BdHG39lf68ZQmAjQKdWHmHZ5u0vacUN5Fk/ykUk0qMj5u4
         0EMIBClrz6t5kwSKws42hPU1Ebzmu7y76/Kd26/EuFrY+h0rvcFiVtBzb+NY99pJ9jnT
         Z9Vv6DkK8e27aPMsxyho/aodWFisVquoVZTCZGrcexnt6osxsB+8UjyX9r++q5A1sfcd
         LRbw==
X-Gm-Message-State: AOAM533dK8ic23KAszyJPBGQDtPd8/KL31t3RkNBgRU4YFbGykYtuM3E
        S/0FatloXIU+G/blX06eREdrUw==
X-Google-Smtp-Source: ABdhPJzz3DdtjpDiA9nuocex1g3T4DDVDvtdQZmJSz9srhqnxKLq8HLOaBRLGOvv7xfL0IgOG8cEEQ==
X-Received: by 2002:a17:90a:ee84:b0:1d9:27f3:eeeb with SMTP id i4-20020a17090aee8400b001d927f3eeebmr21028863pjz.66.1651998554410;
        Sun, 08 May 2022 01:29:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b187-20020a62cfc4000000b0050dc76281eesm6219927pfg.200.2022.05.08.01.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 01:29:13 -0700 (PDT)
Date:   Sun, 8 May 2022 01:29:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
Message-ID: <202205080033.82AB3703C3@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com>
 <20220429013704.4n4lmadpstdioe7a@treble>
 <d82459b887bcaf9181ad836051e2d16b@overdrivepizza.com>
 <20220503220244.vyz5flk3gg3y6rbw@treble>
 <YnJTYzralOhGGmED@hirez.programming.kicks-ass.net>
 <YnKx5a9WvJ1UhWPm@google.com>
 <YnLDGcJGKfqi5+8w@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnLDGcJGKfqi5+8w@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 08:16:57PM +0200, Peter Zijlstra wrote:
> 	FineIBT						kCFI
> 
> __fineibt_\hash:
> 	xor	\hash, %r10	# 7
> 	jz	1f		# 2
> 	ud2			# 2
> 1:	ret			# 1
> 	int3			# 1
> 
> 
> __cfi_\sym:					__cfi_\sym:
> 							int3; int3				# 2
> 	endbr			# 4			mov	\hash, %eax			# 5
> 	call	__fineibt_\hash	# 5			int3; int3				# 2
> \sym:						\sym:
> 	...						...
> 
> 
> caller:						caller:
> 	movl	\hash, %r10d	# 6			cmpl	\hash, -6(%r11)			# 8
> 	sub	$9, %r11	# 4			je	1f				# 2
> 	call	*%r11		# 3			ud2					# 2
> 	.nop 4			# 4 (or fixup r11)	call	__x86_indirect_thunk_r11	# 5

This looks good!

And just to double-check my understanding here... \sym is expected to
start with endbr with IBT + kCFI?


Random extra thoughts... feel free to ignore. :) Given that both CFI
schemes depend on an attacker not being able to construct an executable
memory region that either starts with endbr (for FineIBT) or starts with
hash & 2 bytes (for kCFI), we should likely take another look at where
the kernel uses PAGE_KERNEL_EXEC.

It seems non-specialized use is entirely done via module_alloc(). Obviously
modules need to stay as-is. So we're left with other module_alloc()
callers: BPF JIT, ftrace, and kprobes.

Perhaps enabling CFI should tie bpf_jit_harden (which performs constant
blinding) to the value of bpf_jit_enable? (i.e. either use BPF VM which
reads from non-exec memory, or use BPF JIT with constant blinding.)

I *think* all the kprobes and ftrace stuff ends up using constructed
direct calls, though, yes? So if we did bounds checking, we could
"exclude" them as well as the BPF JIT. Though I'm not sure how
controllable the content written to the kprobes and ftrace regions are,
though?

For exclusion, we could separate actual modules from the other
module_alloc() users by maybe allocating in opposite directions from the
randomized offset and check indirect calls against the kernel text bounds
and the new modules-only bounds. Sounds expensive, though. Maybe PKS,
but I can't imagine 2 MSR writes per indirect call would be fast. Hmm...

-- 
Kees Cook
