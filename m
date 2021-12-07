Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49A346C0FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbhLGQzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhLGQzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:55:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADDAC061574;
        Tue,  7 Dec 2021 08:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Moi9z8LCsmFS3N8iApsShGeAYgyw/DVPYQ5bcaXImA=; b=JYJQjgTAKR2/yVVF7b+CN+Z4Fi
        R7oVIpQtQvMjqIFIH6w+A3h5T7tJ29PIlV3UeNaRMlUy1Bu4Om/Pe7SwtSjzRoxZqUenhtET3LN5V
        2d/8lCOnw/nPJNaGaFVJOrbI/1wwh43diqp3K6ZJcR+qnyRCpATRJLTBqRQGB1zfREjTAW34cKrnh
        P/wDKd0SNxlyl1jj0hBjcHcyZhSyop+8g74HCwhH1N2+Q+YX/TlDoo0yj9IaKxFowog1+BMjymWb8
        OVG779YqLiGw00vbYYBy904HwkEq9TvM4FofSYy2NBa1sthyv0ZOPO6BPuJXhFKkoyK0Yk8kp8xeI
        JcIR5x/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mudhN-007Yf3-FT; Tue, 07 Dec 2021 16:52:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB643300237;
        Tue,  7 Dec 2021 17:52:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6449201CAF60; Tue,  7 Dec 2021 17:52:13 +0100 (CET)
Date:   Tue, 7 Dec 2021 17:52:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <Ya+RPbdgEn6l6RbS@hirez.programming.kicks-ass.net>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
 <CAHk-=wjtvUDbbcXw0iqAPn3dmZK+RnqVMFrU9i53HzvPtWx_vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjtvUDbbcXw0iqAPn3dmZK+RnqVMFrU9i53HzvPtWx_vw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 08:13:38AM -0800, Linus Torvalds wrote:
> On Tue, Dec 7, 2021 at 5:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > +#define refcount_dec_and_test refcount_dec_and_test
> > +static inline bool refcount_dec_and_test(refcount_t *r)
> > +{
> > +       asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
> > +                          "jz %l[cc_zero]\n\t"
> > +                          "jl %l[cc_error]"
> > +                          : : [var] "m" (r->refs.counter)
> > +                          : "memory"
> > +                          : cc_zero, cc_error);
> > +       return false;
> > +
> > +cc_zero:
> > +       return true;
> > +
> > +cc_error:
> > +       refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
> > +       return false;
> > +}
> 
> Please don't add broken arch-specific helpers that are useless for
> anything else than the broken refcount_t use.

I take issue with the broken, but I concede the point.

> Make it return three return values, call it atomic_dec_and_test_ref()
> or something like that, and now people can use it without having to
> use a refcount_t.
> 
> Nobody really wants two different error cases anyway. The fact that
> refcount_warn_saturate() has different cases is only an annoyance.

How about we do something like the unsafe_ uaccess functions and do it
like so?

It's a bit gross, and there seems to be a problem with macro expansion
of __ofl, but it 'works'.

---
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 5e754e895767..921ecfd5a40b 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -263,6 +263,22 @@ static __always_inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 }
 #define arch_atomic_fetch_xor arch_atomic_fetch_xor
 
+#define atomic_dec_and_test_ofl(_v, __ofl)				\
+({									\
+	__label__ __zero;						\
+	__label__ __out;						\
+	bool __ret = false;						\
+	asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"		\
+			   "jz %l[__zero]\n\t"				\
+			   "jl %l[__ofl]"				\
+			   : : [var] "m" ((_v)->counter)		\
+			   : "memory"					\
+			   : __zero, __ofl);				\
+	goto __out;							\
+__zero:	__ret = true;							\
+__out:	__ret;								\
+})
+
 #ifdef CONFIG_X86_32
 # include <asm/atomic64_32.h>
 #else
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index b8a6e387f8f9..f11ce70de2da 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -330,7 +330,15 @@ static inline __must_check bool __refcount_dec_and_test(refcount_t *r, int *oldp
  */
 static inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
+#ifdef atomic_dec_and_test_ofl
+	return atomic_dec_and_test_ofl(&r->refs, __ofl);
+
+__ofl:
+	refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
+	return false;
+#else
 	return __refcount_dec_and_test(r, NULL);
+#endif
 }
 
 static inline void __refcount_dec(refcount_t *r, int *oldp)
