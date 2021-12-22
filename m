Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3247CB84
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbhLVDKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhLVDKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:10:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 19:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/N//Hl0MQgQVCERPieC+DOnf7Id6IS5f33LhshO2Vi4=; b=MtjtpfFQ9n5RIgdVg9cWbV4fND
        0RirIVTXeIOKjfrGLGuhRUUbt5tqeyg05umhUgw+6/pM5XompMxkZLyUlIB8ZJLh8dufZv5YjPxEE
        WZmEvWndsxYDG3R5Z1tPXBxUMwXtxIv1YzNNpc0nYE8123AFgSv6FwA2mIpO4glClQsMMkMQbJBI6
        KQjUkXeXdZpc2IptN9y97puyyWHvC5l/8xXIV/7xjfNDYOdkUKsPU7mG8Jrl+CIwsizP5GGQ2v2SO
        jkI7fnq1PsI4TcArWYfHl6e1A7PmLTkfkWFrxLGRJUGJAYS9XnWgY3prxX0Apg5EESzjX54nRTk2H
        iA4GMcjw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzs1N-0093r0-4h; Wed, 22 Dec 2021 03:10:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] signal: clean up kernel-doc comments
Date:   Tue, 21 Dec 2021 19:10:27 -0800
Message-Id: <20211222031027.29694-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings in kernel/signal.c:

kernel/signal.c:1830: warning: Function parameter or member 'force_coredump' not described in 'force_sig_seccomp'
kernel/signal.c:2873: warning: missing initial short description on line:
 * signal_delivered -

Also add a closing parenthesis to the comments in signal_delivered().

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Richard Weinberger <richard@nod.at>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20211221.orig/kernel/signal.c
+++ linux-next-20211221/kernel/signal.c
@@ -1823,6 +1823,7 @@ int force_sig_perf(void __user *addr, u3
  * force_sig_seccomp - signals the task to allow in-process syscall emulation
  * @syscall: syscall number to send to userland
  * @reason: filter-supplied reason code to send to userland (via si_errno)
+ * @force_coredump: true to trigger a coredump
  *
  * Forces a SIGSYS with a code of SYS_SECCOMP and related sigsys info.
  */
@@ -2870,13 +2871,13 @@ out:
 }
 
 /**
- * signal_delivered - 
+ * signal_delivered - called after signal delivery to update blocked signals
  * @ksig:		kernel signal struct
  * @stepping:		nonzero if debugger single-step or block-step in use
  *
  * This function should be called when a signal has successfully been
  * delivered. It updates the blocked signals accordingly (@ksig->ka.sa.sa_mask
- * is always blocked, and the signal itself is blocked unless %SA_NODEFER
+ * is always blocked), and the signal itself is blocked unless %SA_NODEFER
  * is set in @ksig->ka.sa.sa_flags.  Tracing is notified.
  */
 static void signal_delivered(struct ksignal *ksig, int stepping)
