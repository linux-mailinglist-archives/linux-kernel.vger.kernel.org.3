Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB424705A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbhLJQbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbhLJQay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:30:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF525C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gd4pNOYaTpcMSYQB2RoohQTDEYLcoFhRZ4vKdv7colA=; b=XffBzkMHnSJQbQfi5O2IbJLEmM
        +/xVTaC285oDArNI8+IHU4DVBklzDhGWhmuKG+sIn7s8iva1ZONUMec/7BdtVC7mrgQlBM07jk0pz
        IROXKAEhKM5PnDxA3nmpQdLcOER4BaBIq2+p941tJWIB5H4pgJELE6s7Nfhf77HyR1DDijCP2GpgD
        hiBFPeYVLBCp/KcB8wgt5+bedN5S5m5p47RXT1ixj99mNf+XrpCIc9CwQs4PsMG8HDprmAb6z9t7F
        ffB2qnE0ev3R2xcs7uW+Mg1y78rJpXYhLbYvk/Y8Jgl02f1sHTZdr1U/wk+6pW3EW0DTnBkFPC64+
        MN2+lRaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvijm-000aWZ-Ko; Fri, 10 Dec 2021 16:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6388300728;
        Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7B7F82BF1A848; Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Message-ID: <20211210162313.951869207@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Dec 2021 17:16:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org, axboe@kernel.dk
Subject: [PATCH v2 9/9] refcount: Optimize __refcount_add_not_zero(.i=1)
References: <20211210161618.645249719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the same off-by-one on the target range that refcount_inc()
already has by only testing the new value for overflow when the
increment is not constant-1.

Improves code-gen, for the common case from:

    a887:       41 8b 14 24             mov    (%r12),%edx
    a88b:       83 fa ff                cmp    $0xffffffff,%edx
    a88e:       74 1f                   je     a8af <ring_buffer_get+0x3f>
    a890:       8d 4a 01                lea    0x1(%rdx),%ecx
    a893:       89 d0                   mov    %edx,%eax
    a895:       f0 41 0f b1 0c 24       lock cmpxchg %ecx,(%r12)
    a89b:       75 35                   jne    a8d2 <ring_buffer_get+0x62>
    a89d:       83 c2 02                add    $0x2,%edx
    a8a0:       09 ca                   or     %ecx,%edx
    a8a2:       78 19                   js     a8bd <ring_buffer_get+0x4d>

to:

    a887:       41 8b 04 24             mov    (%r12),%eax
    a88b:       83 f8 ff                cmp    $0xffffffff,%eax
    a88e:       74 1a                   je     a8aa <ring_buffer_get+0x3a>
    a890:       8d 50 01                lea    0x1(%rax),%edx
    a893:       f0 41 0f b1 14 24       lock cmpxchg %edx,(%r12)
    a899:       75 f0                   jne    a88b <ring_buffer_get+0x1b>
    a89b:       85 d2                   test   %edx,%edx
    a89d:       78 19                   js     a8b8 <ring_buffer_get+0x48>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/refcount.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -161,7 +161,7 @@ static inline __must_check bool __refcou
 	if (oldp)
 		*oldp = old;
 
-	if (unlikely(old < 0 || old + i < 0))
+	if (unlikely(old < 0 || (!(__builtin_constant_p(i) && i == 1) && old + i < 0)))
 		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
 
 	return old;


