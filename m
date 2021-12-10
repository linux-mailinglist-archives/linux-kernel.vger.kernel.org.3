Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD18B4705A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbhLJQbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbhLJQay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:30:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5449C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bTzrOS1HIZOzAozOdOkpH/8mbo+BJsVElPknNEUVACE=; b=IxlTwUC9RDlT5Vb4HVB483IYJP
        xi31NIm+N9CJOqeIiCVd/BbCABJ69sAC8hj8ovIr26zz7CTV17MWRT4WRtxaFNSMz1c13vUQ45mcs
        IEqvRRts3IZb3u1Vq6PYltIpBtGoPJt6CZtNvUmSQ5TyDbE/4n7t4sYKzeCGoRfrS3gx74DYNMvj+
        oZ+63YuYrIg7fpLI4Lz/JDae7xy5X7U1mIjTpnj3bVuWUSMCDq8BSCtYzER3j6X+vtaEo7CmCfS77
        gtmrgF4YWka8MRSNzPcqrmE54MdXWCQCOqZxz041mShYv45NoWCEpWlT0XjyDK9/LapAH/F4YXFGZ
        n6RU5BEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvijl-00ATwo-88; Fri, 10 Dec 2021 16:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84388300472;
        Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 683672B3CD721; Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Message-ID: <20211210162313.534215085@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Dec 2021 17:16:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org, axboe@kernel.dk
Subject: [PATCH v2 4/9] refcount: Use atomic_*_overflow()
References: <20211210161618.645249719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the shiny new atomic_*_overflow() functions in order to have better
code-gen.

Strictly speaking, these ops operate on [0, INT_MIN] rather than
[0, INT_MAX] but this is harmless. At worst another op finds the
refcount is negative and goes saturate, which is always a possibility
anyway.

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

XXX atomic_dec_and_test_overflow() is strictly stronger ordered than
refcount_dec_and_test() is defined -- Power and Arrghh64 ?

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/refcount.h |   17 +++++++++++++----
 lib/refcount.c           |    5 +++++
 2 files changed, 18 insertions(+), 4 deletions(-)

--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -264,7 +264,10 @@ static inline void __refcount_inc(refcou
  */
 static inline void refcount_inc(refcount_t *r)
 {
-	__refcount_inc(r, NULL);
+	atomic_inc_overflow(&r->refs, Eoverflow);
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
+	return atomic_dec_and_test_overflow(&r->refs, Eoverflow);
+Eoverflow:
+	refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
+	return false;
 }
 
 static inline void __refcount_dec(refcount_t *r, int *oldp)
@@ -340,7 +346,7 @@ static inline void __refcount_dec(refcou
 	if (oldp)
 		*oldp = old;
 
-	if (unlikely(old <= 1))
+	if (unlikely(old - 1 <= 0))
 		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
 }
 
@@ -356,7 +362,10 @@ static inline void __refcount_dec(refcou
  */
 static inline void refcount_dec(refcount_t *r)
 {
-	__refcount_dec(r, NULL);
+	atomic_dec_overflow(&r->refs, Eoverflow);
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


