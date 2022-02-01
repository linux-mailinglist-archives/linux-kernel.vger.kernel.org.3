Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7C44A68DC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243031AbiBAX7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbiBAX7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:59:41 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F121C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 15:59:41 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n32so17282935pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 15:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pTZ3bVNwyGr0I6KCecwpk4q7omHPmVlpoXWo92UK+BQ=;
        b=VJDrPKs3JJ3JyjEdFMptkHnkiQgE8DFx0U7leGypaLH1eZ+CL/VQtlNrRhEWfDVc/+
         3hnv7eK4e3NE6E4JYLWfgXTRKU7XY9yzMcU4MTjp9RNhnsKEA0p0xG6qDbXVLdnhnmQc
         w/ik5Co1PH1C2oqQZokC4GeJf93llNRGLpBh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pTZ3bVNwyGr0I6KCecwpk4q7omHPmVlpoXWo92UK+BQ=;
        b=XTJ6IqVDH9AZEdTO137AXk6tFw4vGlavNRO2mkF0wLTJuDM8jTQF8eLTAsHmHs4M7q
         DVvQk+ZBUfH8M8b47q+SNfS2jUhLxX0w+R9HXhBAiBEjHuMGpH82NQQkyv26iURyMSp6
         H4Rgur/LiaLckm6bcBci67QpR9ucN+68eA6BpBqlFNyM0PdRd0oQF35PnkjRQVFgK3Sg
         KJJPbDxSiBe7rznqyFhlL0yzVO7DL7kMP1l1njaCE6z5t7sTCWxsY/2+gyADn4epZL81
         VAghrnqUA0slaUAY8FfsXGwFEkPezSqtak7lAdtM1C3pW07kqGEnZgzZGVAPS9c7P0lR
         K05A==
X-Gm-Message-State: AOAM5318sALc4dOf6mQGKdeLrL/sEre3FcDBhXw4PetgaZZtn0hRzPmZ
        kPx6QwxqPBBilP0fwkoZBHQ4wA==
X-Google-Smtp-Source: ABdhPJzYYnjku+oiOCGhXn3CrFssKCulCgN1NlnldRS31rM9bTCTung6/ijkx2nM9qCDv1hYCJqljA==
X-Received: by 2002:a63:9149:: with SMTP id l70mr22479215pge.555.1643759980611;
        Tue, 01 Feb 2022 15:59:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f12sm18007181pfj.37.2022.02.01.15.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 15:59:40 -0800 (PST)
Date:   Tue, 1 Feb 2022 15:59:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: Stackleak vs noinstr (Was: [GIT pull] objtool/core for v5.16-rc1)
Message-ID: <202202011558.DAAF17D@keescook>
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864563.3357115.8793939214537874196.tglx@xen13>
 <CAHk-=wgNzL3AaVNruwLv=kcGXi1EbJN9CZC6GoRY66t6WFcfGg@mail.gmail.com>
 <YYDwJORywW2FjprP@hirez.programming.kicks-ass.net>
 <YYD/bpLabfumrvL+@hirez.programming.kicks-ass.net>
 <YYENAKB0igNFnFmK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYENAKB0igNFnFmK@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 11:03:44AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 02, 2021 at 10:05:50AM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 02, 2021 at 09:00:36AM +0100, Peter Zijlstra wrote:
> > > On Mon, Nov 01, 2021 at 01:44:39PM -0700, Linus Torvalds wrote:
> > 
> > > >     do_machine_check()+0x27: call to stackleak_track_stack ...
> > > >     do_syscall_64()+0x9: call to stackleak_track_stack ...
> > > >     do_int80_syscall_32()+0x9: call to stackleak_track_stack ...
> > > >     exc_general_protection()+0x22: call to stackleak_track_stack ...
> > > >     fixup_bad_iret()+0x20: call to stackleak_track_stack ...
> > > >     .entry.text+0x10e6: call to stackleak_erase ...
> > > >     .entry.text+0x143: call to stackleak_erase ...
> > > >     .entry.text+0x17d9: call to stackleak_erase ...
> > > > 
> > > > most seem to be about the stackleak thing,
> > > 
> > > Right, I recently ran into this and hacen't yet had time to look into
> > > it. I suspect my normal build box doesn't have the GCC plugin crud
> > > enabled or somesuch.
> > > 
> > > I think the GCC stackleak plugin needs fixing, specifically it needs a
> > > function attribute such that it will not emit instrumentation in noinstr
> > > functions. I'll go chase down the developer of that thing.
> > 
> > Alexander, is there any way to make this plugin grow a function
> > attribute which we can add to noinstr ? There's a strict requirement the
> > compiler doesn't add extra code to noinstr functions these days.
> > 
> > We'll 'soon' be running noinstr C code before switching to kernel page
> > tables even.
> 
> Using my pre-release GCC-12 compiler (the only one I have with plugin
> crud enabled apparently), the below seems to work.
> 
> Having the plugin gate on section name seems a lot hacky, but given it's
> already doing that, one more doesn't hurt.
> 
> ---
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index ce161a8e8d97..135866ca8878 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -48,7 +48,7 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
>  #define skip_erasing()	false
>  #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
>  
> -asmlinkage void notrace stackleak_erase(void)
> +asmlinkage noinstr void stackleak_erase(void)
>  {
>  	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
>  	unsigned long kstack_ptr = current->lowest_stack;
> @@ -102,7 +102,6 @@ asmlinkage void notrace stackleak_erase(void)
>  	/* Reset the 'lowest_stack' value for the next syscall */
>  	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
>  }
> -NOKPROBE_SYMBOL(stackleak_erase);
>  
>  void __used __no_caller_saved_registers notrace stackleak_track_stack(void)
>  {
> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
> index e9db7dcb3e5f..07688a1c686b 100644
> --- a/scripts/gcc-plugins/stackleak_plugin.c
> +++ b/scripts/gcc-plugins/stackleak_plugin.c
> @@ -446,6 +446,8 @@ static bool stackleak_gate(void)
>  			return false;
>  		if (!strncmp(TREE_STRING_POINTER(section), ".meminit.text", 13))
>  			return false;
> +		if (!strncmp(TREE_STRING_POINTER(section), ".noinstr.text", 13))
> +			return false;
>  	}
>  
>  	return track_frame_size >= 0;

Did this ever turn into a real patch? I don't see anything in -next for
it, so I assume it's still needed.

-- 
Kees Cook
