Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0594F46DB5B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbhLHSoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbhLHSoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:44:19 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83234C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cBw3gkSwNefU+NCrSZEFoP5CwMgF8YIcIrt6UcHw7KU=; b=ntJHQl/N8WL3W+sViSm/6rDcjG
        wxAvFv6yPSWl3G7hSMsF1C7dLlVUBQ16ge25LOko9VOoQkxkYx+sAKAenuAz+rBte22sRza8RlxD9
        e4XpU5Ff+3uy+/p20CMrOyNdrx2IV9ibu5wX8MlAZn8+BckzNzbVK+JB+LKJgnU2tgvoyVodN9UjP
        /RJPKpwB5+DL759+s1L3EP+WEq56JjGIphlfpHK19ClInO0R+O3SAZoKOQ667cNsjyCbJW6vfs4QQ
        Yvy23Xk0OnmmQQdRuW5ao8IM9IDeUdmzVB8Jhffk07/GerVYaNS1XNyynoZa3ZlAknXT0JRCamc3p
        sNHQB6zA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv1ro-000E8l-VP; Wed, 08 Dec 2021 18:40:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CADC730041D;
        Wed,  8 Dec 2021 19:40:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AE5A029B191FF; Wed,  8 Dec 2021 19:40:34 +0100 (CET)
Message-ID: <20211208183906.548393311@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Dec 2021 19:36:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org
Subject: [RFC][PATCH 3/5] refcount: Improve out-of-line code-gen
References: <20211208183655.251963904@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a number of ops to tail-call refcount_warn_saturate() in order
to generate smaller out-of-line code.

   text    data     bss     dec     hex filename
  97341    4985    1116  103442   19412 defconfig-build/kernel/events/core.o
  97299    4985    1116  103400   193e8 defconfig-build/kernel/events/core.o

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/refcount.h |    9 ++++-----
 lib/refcount.c           |    4 +++-
 2 files changed, 7 insertions(+), 6 deletions(-)

--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -124,7 +124,7 @@ enum refcount_saturation_type {
 	REFCOUNT_DEC_LEAK,
 };
 
-void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
+bool refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
 
 /**
  * refcount_set - set a refcount's value
@@ -160,7 +160,7 @@ static inline __must_check bool __refcou
 		*oldp = old;
 
 	if (unlikely(old < 0 || old + i < 0))
-		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
+		return refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
 
 	return old;
 }
@@ -283,7 +283,7 @@ static inline __must_check bool __refcou
 	}
 
 	if (unlikely(old < 0 || old - i < 0))
-		refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
+		return refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
 
 	return false;
 }
@@ -335,8 +335,7 @@ static inline __must_check bool refcount
 {
 	return atomic_dec_and_test_ofl(&r->refs, Eoverflow);
 Eoverflow:
-	refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
-	return false;
+	return refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
 }
 
 static inline void __refcount_dec(refcount_t *r, int *oldp)
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -10,7 +10,7 @@
 
 #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
 
-void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
+bool refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
 {
 	int old = refcount_read(r);
 	refcount_set(r, REFCOUNT_SATURATED);
@@ -38,6 +38,8 @@ void refcount_warn_saturate(refcount_t *
 	default:
 		REFCOUNT_WARN("unknown saturation event!?");
 	}
+
+	return false;
 }
 EXPORT_SYMBOL(refcount_warn_saturate);
 


