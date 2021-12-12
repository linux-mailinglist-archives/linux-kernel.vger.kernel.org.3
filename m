Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA9471795
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhLLB1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhLLB0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:26:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB338C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 17:26:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E48EACE0AE7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 01:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A494FC341D6;
        Sun, 12 Dec 2021 01:26:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mwDdV-000kFN-Qv;
        Sat, 11 Dec 2021 20:26:45 -0500
Message-ID: <20211212012645.674450187@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 11 Dec 2021 20:26:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [for-next][PATCH 06/11] tracing: Use memset_startat helper in trace_iterator_reset()
References: <20211212012617.690710310@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiu Jianfeng <xiujianfeng@huawei.com>

Make use of memset_startat helper to simplify the code, there should be
no functional change as a result of this patch.

Link: https://lkml.kernel.org/r/20211210012245.207489-1-xiujianfeng@huawei.com

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8bd1a815ce90..64a7ec44a635 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1932,14 +1932,7 @@ extern struct trace_iterator *tracepoint_print_iter;
  */
 static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
 {
-	const size_t offset = offsetof(struct trace_iterator, seq);
-
-	/*
-	 * Keep gcc from complaining about overwriting more than just one
-	 * member in the structure.
-	 */
-	memset((char *)iter + offset, 0, sizeof(struct trace_iterator) - offset);
-
+	memset_startat(iter, 0, seq);
 	iter->pos = -1;
 }
 
-- 
2.33.0
