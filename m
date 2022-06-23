Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FA8557DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiFWOT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiFWOT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:19:26 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58B643EFB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:19:25 -0700 (PDT)
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25NEIvjD019977;
        Thu, 23 Jun 2022 23:18:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Thu, 23 Jun 2022 23:18:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25NEIuEb019970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Jun 2022 23:18:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <225b0c28-8333-9849-0d7b-2a561fb20ccb@I-love.SAKURA.ne.jp>
Date:   Thu, 23 Jun 2022 23:18:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] lib/smp_processor_id: use preemptible() macro
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

preemptible() is unconditional 0 if CONFIG_PREEMPT_COUNT=n, and is
(preempt_count() == 0 && !irqs_disabled()) if CONFIG_PREEMPT_COUNT=y.

Although check_preemption_disabled() depends on CONFIG_PREEMPT_COUNT=y,
the naming implies whether preemption is already disabled. Thus, let's
make check_preemption_disabled() safe even if CONFIG_PREEMPT_COUNT=n.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 lib/smp_processor_id.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 046ac6297c78..5bb0783ce038 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -13,10 +13,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 {
 	int this_cpu = raw_smp_processor_id();
 
-	if (likely(preempt_count()))
-		goto out;
-
-	if (irqs_disabled())
+	if (likely(!preemptible()))
 		goto out;
 
 	if (is_percpu_thread())
-- 
2.18.4
