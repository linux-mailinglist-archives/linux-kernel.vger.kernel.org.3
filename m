Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A3504919
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiDQS7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbiDQS7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:59:38 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1D635877;
        Sun, 17 Apr 2022 11:57:02 -0700 (PDT)
Received: from integral2.. (unknown [36.80.217.41])
        by gnuweeb.org (Postfix) with ESMTPSA id CD9D17E3BA;
        Sun, 17 Apr 2022 18:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1650221821;
        bh=RFtg7BoSogQqJ3qbQ59LPrzum9EvKnWpLcNv0rGtvq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cqHbTrLAEbwlpZUNB52HM3REYAh3Vg6BVvtWRrGWcCn3b/+Rdd1582v5khnfX3+D6
         RTgo/tCZ8fVu7ezeYhY/seTU28SSIHYjJYvVEPUEZ4Um68TCUYcKR9hBmU3jSqwqlV
         om+uCh1u/EkwJyxzMCKg0l5Zvcr8XvwnSr3QuzdsQfR+z4chfFWvqsyfUzpfOZ97jD
         KonQKsW9nojWeqZ+OZwMftBynbjx2d1FmTkgD/96nQa8tKruNz8wlCw0GIYugmxO7w
         9O2R9lj79n5kmE8qHAFdh9/Ychv3JoUI4Uq4eP4IR626zmMN87Xfvm6mBZZlqpoPj/
         qKKHTPTUR/3Gg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Trace Devel Mailing List 
        <linux-trace-devel@vger.kernel.org>
Subject: [RESEND PATCH 1/2] tracing: Return -EINVAL if WARN_ON(!glob) triggered in event_hist_trigger_parse()
Date:   Mon, 18 Apr 2022 01:56:29 +0700
Message-Id: <20220417185630.199062-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220417185630.199062-1-ammarfaizi2@gnuweeb.org>
References: <20220417185630.199062-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If `WARN_ON(!glob)` is ever triggered, we will still continue executing
the next lines. This will trigger the more serious problem, a NULL
pointer dereference bug.

Just return -EINVAL if @glob is NULL.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 kernel/trace/trace_events_hist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 44db5ba9cabb..0b99ad68e3fa 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6186,7 +6186,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	lockdep_assert_held(&event_mutex);
 
-	WARN_ON(!glob);
+	if (WARN_ON(!glob))
+		return -EINVAL;
 
 	if (strlen(glob)) {
 		hist_err_clear();
-- 
Ammar Faizi

