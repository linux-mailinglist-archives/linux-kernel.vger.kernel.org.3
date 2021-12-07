Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1484346C1F8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbhLGRol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhLGRok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:44:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A11AC061574;
        Tue,  7 Dec 2021 09:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=otMhR6UQUCq1XUdG0Mow4IHQ43JJ0qaMkYpjdyTPD7E=; b=c6tZGk1g8IwPnzH4F2FkBOgNn+
        u5NxkmWSv2WpDIkFMOhT9y3NAzhTAdhlaU/3NOi/2uG2e9eadHvCY3O03jOArgrBqAKkXBTnq4rqv
        aaVH4jD5/GRCLZgMADPxSKhYMt9s/zNzxbt0pXE9/yfKrd9k0A3y+7IKGsg8zG3MOrD7ZUrHYO5jx
        9sWwHPRkRYGmbDzdAMY7yV4xOlhR45ERaAbDeReUDXBTGU5k/TyyUKHIkNJFQ7UVOIwkgB5uU32oL
        fNpW222HjWstShpVaCHJMmVdaZme+0NHecEvdlVbSsvk5mUSoWrkJxwLswnEmQabnSPCYaNeDu1RP
        /btJRDUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mueSg-007bZw-By; Tue, 07 Dec 2021 17:41:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91B2030002F;
        Tue,  7 Dec 2021 18:41:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 789FA20182F4A; Tue,  7 Dec 2021 18:41:05 +0100 (CET)
Date:   Tue, 7 Dec 2021 18:41:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <Ya+csba8U3v3DMVo@hirez.programming.kicks-ass.net>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
 <CAHk-=wjtvUDbbcXw0iqAPn3dmZK+RnqVMFrU9i53HzvPtWx_vw@mail.gmail.com>
 <Ya+RPbdgEn6l6RbS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya+RPbdgEn6l6RbS@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:52:13PM +0100, Peter Zijlstra wrote:
> It's a bit gross, and there seems to be a problem with macro expansion
> of __ofl, but it 'works'.
> 
> ---
> diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
> index 5e754e895767..921ecfd5a40b 100644
> --- a/arch/x86/include/asm/atomic.h
> +++ b/arch/x86/include/asm/atomic.h
> @@ -263,6 +263,22 @@ static __always_inline int arch_atomic_fetch_xor(int i, atomic_t *v)
>  }
>  #define arch_atomic_fetch_xor arch_atomic_fetch_xor
>  
> +#define atomic_dec_and_test_ofl(_v, __ofl)				\
> +({									\
> +	__label__ __zero;						\
> +	__label__ __out;						\
> +	bool __ret = false;						\
> +	asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"		\
> +			   "jz %l[__zero]\n\t"				\
> +			   "jl %l[__ofl]"				\
				%l2

and it works much better...

> +			   : : [var] "m" ((_v)->counter)		\
> +			   : "memory"					\
> +			   : __zero, __ofl);				\
> +	goto __out;							\
> +__zero:	__ret = true;							\
> +__out:	__ret;								\
> +})
