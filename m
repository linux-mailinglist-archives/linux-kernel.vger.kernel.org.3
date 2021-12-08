Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E02C46DB59
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbhLHSoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbhLHSoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:44:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B2C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=KRRWcOCysfqXAfyZZUPqjwdCcY8Atk10HH3nh5ZXh7k=; b=LB32mP3u2RVkwZ3Yn49zGgw9mC
        nBZOi6FCh9OHgpSfeYE0FYFPSxbx9sCSU8XTMhtgCfy8rk+8lFUPv1PfMJz//MOL101SNnZlG5qOv
        l8QO7Soeef+oep++i/WjxLyMDK7ro0pbEZDYAkkBcZI3e1UJ2IZwGnfi9rWyLWvhxAPmWHXTlOjAo
        g5UP5KEh5C5sY5o4ZSqc0UzTA04oskcJHVudJBwV3E3qWf2CzWEHweY6g5VMg+cCrZOfJdy5++MJh
        yy+srpEfIacrnRa5agnnGm9cHXZb1dLQ/RmAWK/QOi7VqyA8NqQK0zWPMucLr2ht1hqxQmQDRjpJ5
        ocCHpe0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv1rp-008gCc-Ou; Wed, 08 Dec 2021 18:40:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1CCF3004AD;
        Wed,  8 Dec 2021 19:40:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B764429B30898; Wed,  8 Dec 2021 19:40:34 +0100 (CET)
Message-ID: <20211208183906.703599388@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Dec 2021 19:37:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org
Subject: [RFC][PATCH 5/5] atomic: Document the atomic_{}_ofl() functions
References: <20211208183655.251963904@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Them special, them cause confusion, them needing docs for reading.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/atomic_t.txt |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -44,6 +44,10 @@ The 'full' API consists of (atomic64_ an
   atomic_add_unless(), atomic_inc_not_zero()
   atomic_sub_and_test(), atomic_dec_and_test()
 
+Reference count with overflow (as used by refcount_t):
+
+  atomic_inc_ofl(), atomic_dec_ofl()
+  atomic_dec_and_test_ofl()
 
 Misc:
 
@@ -157,6 +161,22 @@ atomic variable) can be fully ordered an
 visible.
 
 
+Overflow ops:
+
+The atomic_{}_ofl() ops are similar to their !_ofl() bretheren with the
+notable exception that they take a label as their final argument to jump to
+when the atomic op overflows.
+
+Overflow for inc is zero-or-negative on the value prior to increment.
+Overflow for dec is zero-or-negative on the value after the decrement.
+Overflow for dec_and_test is negative on the value after the decrement.
+
+These semantics match the reference count use-case (for which they were
+created). Specifically incrementing from zero is a failure because 0 means the
+object is freed (IOW use-after-free). decrementing to zero is a failure
+because it goes undetected (see dec_and_test) and the object would leak.
+
+
 ORDERING  (go read memory-barriers.txt first)
 --------
 


