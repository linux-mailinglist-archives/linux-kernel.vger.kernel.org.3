Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E0A46BA13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhLGLaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhLGL37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:29:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCE8C061574;
        Tue,  7 Dec 2021 03:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7u+20wao+Z/j7Jl6bNd1keoHdxP64ABauWTeem1CusA=; b=buvAWP6Uf2U0OIXRNkizSRld4K
        nDvZYJXpRe60yLlA2JuRPI5FVxL+bf7mxuZ7bz6ozZuK9G8bHK/1XUF5/c2ilEjs75WR1VKLMwZSM
        W09iAAeQ6ruHsebttvyguZveW/+4WmP788oBVmgUELPGHt9zeSB1WoNfN8WgOdw3JyxZSeyjf8cTk
        oFRbaR0W/nZ/WuPBp5PgSmiXrh+qpGsSpbT/yt6JSO9HnmzWvPJDvn/vDwVFDiGYq7v+18AOEniQF
        hihcyQeEZn5ou11qXmP7QY0d2oy5EcqSzJmn6NOTzCHxy4XxToXYArJoM04v37qsDl16iUAdwv+Ii
        Fy0IyB7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muYc4-007H4o-Kk; Tue, 07 Dec 2021 11:26:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC83130032A;
        Tue,  7 Dec 2021 12:26:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 940BB20299B41; Tue,  7 Dec 2021 12:26:24 +0100 (CET)
Date:   Tue, 7 Dec 2021 12:26:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        keescook@chromium.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya2zfVAwh4aQ7KVd@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 10:53:49PM -0800, Christoph Hellwig wrote:

> > +#define req_ref_zero_or_close_to_overflow(req)	\
> > +	((unsigned int) atomic_read(&(req->ref)) + 127u <= 127u)
> > +
> > +static inline bool req_ref_inc_not_zero(struct request *req)
> > +{
> > +	return atomic_inc_not_zero(&req->ref);
> > +}
> > +
> > +static inline bool req_ref_put_and_test(struct request *req)
> > +{
> > +	WARN_ON_ONCE(req_ref_zero_or_close_to_overflow(req));
> > +	return atomic_dec_and_test(&req->ref);
> > +}

So it's just about these two ops, right?

Now, afaict refcount_inc_not_zero() doesn't actually generate terrible
code here's the fast-path of kernel/events/core.c:ring_buffer_get()

refcount_inc_not_zero():

    a9d0:       41 54                   push   %r12
    a9d2:       49 89 fc                mov    %rdi,%r12
    a9d5:       e8 00 00 00 00          call   a9da <ring_buffer_get+0xa>       a9d6: R_X86_64_PLT32    __rcu_read_lock-0x4
    a9da:       4d 8b a4 24 c8 02 00 00         mov    0x2c8(%r12),%r12
    a9e2:       4d 85 e4                test   %r12,%r12
    a9e5:       74 24                   je     aa0b <ring_buffer_get+0x3b>
    a9e7:       41 8b 14 24             mov    (%r12),%edx
    a9eb:       85 d2                   test   %edx,%edx
    a9ed:       74 1c                   je     aa0b <ring_buffer_get+0x3b>
    a9ef:       8d 4a 01                lea    0x1(%rdx),%ecx
*   a9f2:       89 d0                   mov    %edx,%eax
    a9f4:       f0 41 0f b1 0c 24       lock cmpxchg %ecx,(%r12)
    a9fa:       75 32                   jne    aa2e <ring_buffer_get+0x5e>
*   a9fc:       09 ca                   or     %ecx,%edx
*   a9fe:       78 19                   js     aa19 <ring_buffer_get+0x49>
    aa00:       e8 00 00 00 00          call   aa05 <ring_buffer_get+0x35>      aa01: R_X86_64_PLT32    __rcu_read_unlock-0x4
    aa05:       4c 89 e0                mov    %r12,%rax
    aa08:       41 5c                   pop    %r12
    aa0a:       c3                      ret

The * marked instructions are the difference, vs atomic_inc_not_zero():

    a9d0:       41 54                   push   %r12
    a9d2:       49 89 fc                mov    %rdi,%r12
    a9d5:       e8 00 00 00 00          call   a9da <ring_buffer_get+0xa>       a9d6: R_X86_64_PLT32    __rcu_read_lock-0x4
    a9da:       4d 8b a4 24 c8 02 00 00         mov    0x2c8(%r12),%r12
    a9e2:       4d 85 e4                test   %r12,%r12
    a9e5:       74 1e                   je     aa05 <ring_buffer_get+0x35>
    a9e7:       41 8b 04 24             mov    (%r12),%eax
    a9eb:       85 c0                   test   %eax,%eax
    a9ed:       74 16                   je     aa05 <ring_buffer_get+0x35>
    a9ef:       8d 50 01                lea    0x1(%rax),%edx
    a9f2:       f0 41 0f b1 14 24       lock cmpxchg %edx,(%r12)
    a9f8:       75 f1                   jne    a9eb <ring_buffer_get+0x1b>
    a9fa:       e8 00 00 00 00          call   a9ff <ring_buffer_get+0x2f>      a9fb: R_X86_64_PLT32    __rcu_read_unlock-0x4
    a9ff:       4c 89 e0                mov    %r12,%rax
    aa02:       41 5c                   pop    %r12
    aa04:       c3                      ret


Now, ring_buffer_put(), which uses refcount_dec_and_test():

refcount_dec_and_test()

    aa40:       b8 ff ff ff ff          mov    $0xffffffff,%eax
    aa45:       f0 0f c1 07             lock xadd %eax,(%rdi)
    aa49:       83 f8 01                cmp    $0x1,%eax
    aa4c:       74 05                   je     aa53 <ring_buffer_put+0x13>
    aa4e:       85 c0                   test   %eax,%eax
    aa50:       7e 1e                   jle    aa70 <ring_buffer_put+0x30>
    aa52:       c3                      ret

atomic_dec_and_test():

    aa40:       f0 ff 0f                lock decl (%rdi)
    aa43:       75 1d                   jne    aa62 <ring_buffer_put+0x22>

    ...

    aa62:       c3                      ret

Has a larger difference, which is fixable with the below patch, leading
to:


    a9f0:       f0 ff 0f                lock decl (%rdi)
    a9f3:       74 03                   je     a9f8 <ring_buffer_put+0x8>
    a9f5:       7c 1e                   jl     aa15 <ring_buffer_put+0x25>
    a9f7:       c3                      ret


So where exactly is the performance fail? Is it purely the mess made of
refcount_dec_and_test() ?

---

diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
new file mode 100644
index 000000000000..89e1f84f9170
--- /dev/null
+++ b/arch/x86/include/asm/refcount.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_REFCOUNT_H
+#define _ASM_X86_REFCOUNT_H
+
+#define refcount_dec_and_test refcount_dec_and_test
+static inline bool refcount_dec_and_test(refcount_t *r)
+{
+	asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
+			   "jz %l[cc_zero]\n\t"
+			   "jl %l[cc_error]"
+			   : : [var] "m" (r->refs.counter)
+			   : "memory"
+			   : cc_zero, cc_error);
+	return false;
+
+cc_zero:
+	return true;
+
+cc_error:
+	refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
+	return false;
+}
+
+#endif
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index b8a6e387f8f9..776b035e12a1 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -126,6 +126,8 @@ enum refcount_saturation_type {
 
 void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
 
+#include <asm/refcount.h>
+
 /**
  * refcount_set - set a refcount's value
  * @r: the refcount
@@ -328,10 +330,12 @@ static inline __must_check bool __refcount_dec_and_test(refcount_t *r, int *oldp
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
+#ifndef refcount_dec_and_test
 static inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
 	return __refcount_dec_and_test(r, NULL);
 }
+#endif
 
 static inline void __refcount_dec(refcount_t *r, int *oldp)
 {
