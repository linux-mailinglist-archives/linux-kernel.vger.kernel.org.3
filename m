Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B950246DB5D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbhLHSo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbhLHSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:44:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B42C061A32
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+sVfjPtpwPAMy+dbo/hcfOqb9oGUxiwSxjJQRsOF0Mc=; b=flAeM452CclmCfKOgoc+rmbriK
        7lqcC/Kn//dnMbpPSilg4qRCELMxJ46yyk9jFaLn2qRb6p43lnZBdxQtahe5/aXyIYlj3Va5S96OM
        BwejkSlsAqFhDpy5qQrhBsiFKUnxmZjRudlzwpSMUeIb/WEOr3y+6PFz04Ob7QY6o+XW7DP2jneKz
        DMh8bgQyXtda9Xvql7GNpJ52zE2rfNuhdCvK5gzvcDuBedSQfVHqi0xKfNYEfQJQJmP7n/Y80JahM
        cX3QIooHrAecfYPBv9zDKHZ2lZEphTA0gl0tEw/QvSHiXyzNqh0ig+Mxt13uOOPNUMIzPyGFjQVVG
        8x5WSsOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv1ro-000E8m-Va; Wed, 08 Dec 2021 18:40:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1E0F300362;
        Wed,  8 Dec 2021 19:40:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ABC7029B191F7; Wed,  8 Dec 2021 19:40:34 +0100 (CET)
Message-ID: <20211208183906.468934357@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Dec 2021 19:36:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org
Subject: [RFC][PATCH 2/5] refcount: Use atomic_*_ofl()
References: <20211208183655.251963904@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the shiny new atomic_*_ofl() functions in order to have better
code-gen.

Notably refcount_inc() case no longer distinguishes between
inc-from-zero and inc-negative in the fast path, this improves
code-gen:

    4b88:       b8 01 00 00 00          mov    $0x1,%eax
    4b8d:       f0 0f c1 43 28          lock xadd %eax,0x28(%rbx)
    4b92:       85 c0                   test   %eax,%eax
    4b94:       74 1b                   je     4bb1 <alloc_perf_context+0xf1>
    4b96:       8d 50 01                lea    0x1(%rax),%edx
    4b99:       09 c2                   or     %eax,%edx
    4b9b:       78 20                   js     4bbd <alloc_perf_context+0xfd>

to:

    4768:       b8 01 00 00 00          mov    $0x1,%eax
    476d:       f0 0f c1 43 28          lock xadd %eax,0x28(%rbx)
    4772:       85 c0                   test   %eax,%eax
    4774:       7e 14                   jle    478a <alloc_perf_context+0xea>


without sacrificing on functionality; the only thing that suffers is
the reported error condition, which might now 'spuriously' report
'saturated' instead of 'inc-from-zero'.

refcount_dec_and_test() is also improved:

    aa40:       b8 ff ff ff ff          mov    $0xffffffff,%eax
    aa45:       f0 0f c1 07             lock xadd %eax,(%rdi)
    aa49:       83 f8 01                cmp    $0x1,%eax
    aa4c:       74 05                   je     aa53 <ring_buffer_put+0x13>
    aa4e:       85 c0                   test   %eax,%eax
    aa50:       7e 1e                   jle    aa70 <ring_buffer_put+0x30>
    aa52:       c3                      ret

to:

    a980:       b8 ff ff ff ff          mov    $0xffffffff,%eax
    a985:       f0 0f c1 07             lock xadd %eax,(%rdi)
    a989:       83 e8 01                sub    $0x1,%eax
    a98c:       78 20                   js     a9ae <ring_buffer_put+0x2e>
    a98e:       74 01                   je     a991 <ring_buffer_put+0x11>
    a990:       c3                      ret

XXX atomic_dec_and_test_ofl() is strictly stronger ordered than
refcount_dec_and_test() is defined -- Power and Arrghh64 ?

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/refcount.h |   15 ++++++++++++---
 lib/refcount.c           |    5 +++++
 2 files changed, 17 insertions(+), 3 deletions(-)

--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -264,7 +264,10 @@ static inline void __refcount_inc(refcou
  */
 static inline void refcount_inc(refcount_t *r)
 {
-	__refcount_inc(r, NULL);
+	atomic_inc_ofl(&r->refs, Eoverflow);
+	return;
+Eoverflow:
+	refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
 }
 
 static inline __must_check bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
@@ -330,7 +333,10 @@ static inline __must_check bool __refcou
  */
 static inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
-	return __refcount_dec_and_test(r, NULL);
+	return atomic_dec_and_test_ofl(&r->refs, Eoverflow);
+Eoverflow:
+	refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
+	return false;
 }
 
 static inline void __refcount_dec(refcount_t *r, int *oldp)
@@ -356,7 +362,10 @@ static inline void __refcount_dec(refcou
  */
 static inline void refcount_dec(refcount_t *r)
 {
-	__refcount_dec(r, NULL);
+	atomic_dec_ofl(&r->refs, Eoverflow);
+	return;
+Eoverflow:
+	refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
 }
 
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -12,8 +12,13 @@
 
 void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
 {
+	int old = refcount_read(r);
 	refcount_set(r, REFCOUNT_SATURATED);
 
+	/* racy; who cares */
+	if (old == 1 && t == REFCOUNT_ADD_OVF)
+		t = REFCOUNT_ADD_UAF;
+
 	switch (t) {
 	case REFCOUNT_ADD_NOT_ZERO_OVF:
 		REFCOUNT_WARN("saturated; leaking memory");


