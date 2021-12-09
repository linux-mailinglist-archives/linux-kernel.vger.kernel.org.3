Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7FA46EB55
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbhLIPgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbhLIPgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:36:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A22C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:32:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 94DDACE2693
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDD2C341CF;
        Thu,  9 Dec 2021 15:32:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mvLPD-000Sxi-QU;
        Thu, 09 Dec 2021 10:32:23 -0500
Message-ID: <20211209153223.650040623@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 09 Dec 2021 10:29:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-linus][PATCH 4/5] ftrace: Add cleanup to unregister_ftrace_direct_multi
References: <20211209152908.459494269@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Adding ops cleanup to unregister_ftrace_direct_multi,
so it can be reused in another register call.

Link: https://lkml.kernel.org/r/20211206182032.87248-3-jolsa@kernel.org

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7f0594e28226..be5f6b32a012 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5542,6 +5542,10 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	err = unregister_ftrace_function(ops);
 	remove_direct_functions_hash(hash, addr);
 	mutex_unlock(&direct_mutex);
+
+	/* cleanup for possible another register call */
+	ops->func = NULL;
+	ops->trampoline = 0;
 	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
-- 
2.33.0
