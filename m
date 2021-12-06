Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC078468FD1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 05:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhLFEHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 23:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbhLFEHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 23:07:38 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F02C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 20:04:10 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638763447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dGjgdzBYYF9EMfW6W3cfmNG2OVlzRl92fF7r93XzqXM=;
        b=QwTv8Eg7yDS6h0ZOnjIf1j5dKOwDM+7mfmbPfY8UIshqtlu4DzwIRLNSf30cOcb1PHvJ8e
        X/KFr4t3H0Vap0iwKLkQteZS5GhXECIPXe0mgq2la6+Ka530QpRYlANlKv7xXkacz64AQ3
        E8e7bRP66POtsWg93Jnp2MX9hRizlc8=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] completion: introduce complete_put() helper function
Date:   Mon,  6 Dec 2021 12:03:19 +0800
Message-Id: <20211206040319.7063-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many cases where it is necessary to decrease refcount and test,
then called complete(). So introduce complete_put() helper function.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/completion.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index a778554f9dad..dcb737f1edc2 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -38,6 +38,13 @@ void complete(struct completion *x)
 }
 EXPORT_SYMBOL(complete);
 
+void complete_put(refcount_t *r, struct completion *x)
+{
+	if (refcount_dec_and_test(r))
+		complete(x);
+}
+EXPORT_SYMBOL(complete_put);
+
 /**
  * complete_all: - signals all threads waiting on this completion
  * @x:  holds the state of this particular completion
-- 
2.32.0

