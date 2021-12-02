Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20A6465B00
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354675AbhLBAhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354452AbhLBAhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:37:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF99C061756;
        Wed,  1 Dec 2021 16:33:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5C83DCE2102;
        Thu,  2 Dec 2021 00:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794F9C53FCD;
        Thu,  2 Dec 2021 00:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405228;
        bh=g+7nuxIfYjwEiU7oMZgIjDo88pW5Hnt4IgPSfwVJ9WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OiXk2jLCde0qI1OXqOk2o6B9/6t9RzBYQHG20UCbJ6slcP5iqdVI4xWwnNDJutBz2
         HdOVRRlljCljuWJITk0rXQbX9PUVoPbhQZeuktSeYsGW/t/IqW8Pn6FhAiIFgJeV+2
         7wNFk20GIB/z4O33ynMM3NTktQfOpzPKRrx7HjX/cjO+Xm0cnIuE+LD8oJF0V8leZt
         1M9UYH9fi3jR5A4y14PMGG8MzRW0THMD3YacHJJuzgsUDZxwIfWQtfaaSPBILApO5w
         WdKG20h4lDA52lgxyDL4w4hrtyZUwSTmAPhzjwViDtCgstoKkacspHAlfhnhl6GVpU
         7XTTFEvLoDIoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 42D7C5C110A; Wed,  1 Dec 2021 16:33:48 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/6] tools/nolibc: x86-64: Use `mov $60,%eax` instead of `mov $60,%rax`
Date:   Wed,  1 Dec 2021 16:33:45 -0800
Message-Id: <20211202003346.3129110-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003322.GA3128775@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003322.GA3128775@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammar.faizi@students.amikom.ac.id>

Note that mov to 32-bit register will zero extend to 64-bit register.
Thus `mov $60,%eax` has the same effect with `mov $60,%rax`. Use the
shorter opcode to achieve the same thing.
```
  b8 3c 00 00 00       	mov    $60,%eax (5 bytes) [1]
  48 c7 c0 3c 00 00 00 	mov    $60,%rax (7 bytes) [2]
```
Currently, we use [2]. Change it to [1] for shorter code.

Signed-off-by: Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index f9afe89ec6f26..4988866af0b58 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -420,7 +420,7 @@ asm(".section .text\n"
     "and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned before call
     "call main\n"               // main() returns the status code, we'll exit with it.
     "mov %eax, %edi\n"          // retrieve exit code (32 bit)
-    "mov $60, %rax\n"           // NR_exit == 60
+    "mov $60, %eax\n"           // NR_exit == 60
     "syscall\n"                 // really exit
     "hlt\n"                     // ensure it does not return
     "");
-- 
2.31.1.189.g2e36527f23

