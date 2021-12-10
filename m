Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE24705A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbhLJQbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbhLJQa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:30:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8389FC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=goBZvUrJbFIKdYh0mUnAlbyD23D+gIRZz24eBHtv0Ew=; b=mBRwtQphXwV605XmUKvSG+7F71
        iKQAM6RR+PZ6NjgApnz3BN6rigDtBjHuG0ij0H7Dn7gmMGOOlWU/WalbF3R4VJcPBN0HEUgU4Ec9v
        dsVpVSHqSaapoL3raLHjP02TqWsylU61AJg0pphR5E6X/6pMnJxTHV6QKVLAKMpsqPliXejL8+Fz2
        Szlie/o6iSjbKgeHCeS3wzugWBAiTnegIIVRIQN13E6PSONteEXSNCgXyrKd/9snUWDKCwGeRg2rb
        09YIm/cb5lTGBlhEAZSH5PfL8TFoCgitv4CeMojDZ5rzlPsYzmp3Ueq3CYWI8xRli3Xqx+QBJCYPK
        DvAQ421g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvijl-00ATws-Nu; Fri, 10 Dec 2021 16:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A63C930076D;
        Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 70C582B3CD72C; Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Message-ID: <20211210162313.682094686@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Dec 2021 17:16:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org, axboe@kernel.dk
Subject: [PATCH v2 6/9] refcount: Fix refcount_dec_not_one()
References: <20211210161618.645249719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_dec_not_one() misbehaves when racing against the other
refcount ops, notably it directly compares against REFCOUNT_SATURATED,
even though, through aforementioned races, the value might be slightly
off.

Additionally, when refcount_dec_not_one() is used to decrement zero;
which is valid, because 0 is not one, then it behaves differently from
the other refcount_dec*() functions in that it doesn't call
refcount_warn_saturate().

In order to allow some fuzz around the corners of the positive range,
test for saturation slightly differently.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/refcount.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -81,7 +81,8 @@ bool refcount_dec_not_one(refcount_t *r)
 	unsigned int new, val = atomic_read(&r->refs);
 
 	do {
-		if (unlikely(val == REFCOUNT_SATURATED))
+		/* SAT+SAT/2 < val < SAT-SAT/2 */
+		if (unlikely(val - (REFCOUNT_SATURATED + REFCOUNT_SATURATED/2) < -REFCOUNT_SATURATED))
 			return true;
 
 		if (val == 1)
@@ -89,7 +90,7 @@ bool refcount_dec_not_one(refcount_t *r)
 
 		new = val - 1;
 		if (new > val) {
-			WARN_ONCE(new > val, "refcount_t: underflow; use-after-free.\n");
+			refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
 			return true;
 		}
 


