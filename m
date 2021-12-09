Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6789C46EB4C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbhLIPgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239682AbhLIPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:36:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBCAC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:32:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8EB0B8251E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8EBC341CE;
        Thu,  9 Dec 2021 15:32:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mvLPD-000SxA-KM;
        Thu, 09 Dec 2021 10:32:23 -0500
Message-ID: <20211209153223.466366175@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 09 Dec 2021 10:29:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-linus][PATCH 3/5] ftrace: Use direct_ops hash in unregister_ftrace_direct
References: <20211209152908.459494269@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Now when we have *direct_multi interface the direct_functions
hash is no longer owned just by direct_ops. It's also used by
any other ftrace_ops passed to *direct_multi interface.

Thus to find out that we are unregistering the last function
from direct_ops, we need to check directly direct_ops's hash.

Link: https://lkml.kernel.org/r/20211206182032.87248-2-jolsa@kernel.org

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 30bc880c3849..7f0594e28226 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5217,6 +5217,7 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 {
 	struct ftrace_direct_func *direct;
 	struct ftrace_func_entry *entry;
+	struct ftrace_hash *hash;
 	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
@@ -5225,7 +5226,8 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 	if (!entry)
 		goto out_unlock;
 
-	if (direct_functions->count == 1)
+	hash = direct_ops.func_hash->filter_hash;
+	if (hash->count == 1)
 		unregister_ftrace_function(&direct_ops);
 
 	ret = ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
-- 
2.33.0
