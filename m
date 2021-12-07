Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE3446BFED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbhLGPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbhLGPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:55:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6618C061574;
        Tue,  7 Dec 2021 07:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Omuu2IL2OK0Xy2Bz2WLuZj2MwATjLBReQ+BfkCIXGQ8=; b=RT8HK855qgvzHgWRlY0lHKikpo
        a19XI/xuH8/aeLDz6I+UuuAkNWQYxdsffiPmWGn96pGzYlxAwt1ymEW34239cr38cZTKw95IIoz5p
        HCnmF8kFXggD0JS3HsAWN+T6gtiIcL9za+i04McRdYkE4N6QPEFv21KNds26BEq7Psmb2u535Yto4
        ZoENft3BqeMwgWQ0rney95iz6a/hCKHK1iR5Yq67rbTqp4oUtUryRn9gXen3XlTfwreEAlvEIOMfy
        /JNB8y3Af8Ueee4eHGMWdw9bMZQTxo/3J+9/8REuxYwH2OEv9O4LnmzVjW5kv5SbOPt+YUAjYEj+l
        utJ4GcXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muckv-002nE3-7v; Tue, 07 Dec 2021 15:51:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 709A3300237;
        Tue,  7 Dec 2021 16:51:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BCB0201CA1F6; Tue,  7 Dec 2021 16:51:48 +0100 (CET)
Date:   Tue, 7 Dec 2021 16:51:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        keescook@chromium.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <Ya+DFKo6JVuu++cX@hirez.programming.kicks-ass.net>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 02:28:22PM +0100, Peter Zijlstra wrote:
> +static inline void refcount_inc(refcount_t *r)
> +{
> +	int one = 1;
> +
> +	asm_volatile_goto (LOCK_PREFIX "xaddl %%eax, %[var]\n\t"
> +			   "addl $1, %%eax\n\t"
> +			   "je %l[cc_zero]\n\t"
> +			   "js %l[cc_error]"
> +			   : : [var] "m" (r->refs.counter), "a" (one)
> +			   : "memory"
> +			   : cc_zero, cc_error);

+       asm_volatile_goto (LOCK_PREFIX "xaddl %[reg], %[var]\n\t"
+                          "addl $1, %[reg]\n\t"
+                          "jz %l[cc_zero]\n\t"
+                          "js %l[cc_error]"
+                          : : [var] "m" (r->refs.counter), [reg] "r" (1)
+                          : "memory"
+                          : cc_zero, cc_error);

Is of course a better implementation, but I'm not sure I actually
understand this code. Afaict: add $1,%[reg], will only set ZF when
%[reg] was -1 such that the result is now 0.

But that's not what the code said; is this GCC going funny in the head
or should I just stop staring at this...
