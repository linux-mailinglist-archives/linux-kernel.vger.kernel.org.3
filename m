Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8AB54D48F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350245AbiFOW2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbiFOW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:27:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219F342A2C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:27:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k7so2220968plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWw7C4svPCcZdVbjnQq6e0MxP579SDS3HW9i9NBQQgI=;
        b=g1MwDX94oK5dCvJVt4n9Q7+WIYHOrbEJ3c4lpr5JN1O+aRMazkZzEDEk5Ph5dNMUEb
         rITtsRlHOWQazdFWh3a44aS/gdIM17J90Sr+Owg0SWYFRymThQgBPYLfTyUX9tA4FpK0
         MxqAWqqOjYze9ZllV6s3P4s2N7BgJRdfokqM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWw7C4svPCcZdVbjnQq6e0MxP579SDS3HW9i9NBQQgI=;
        b=d1acoyQrhDndGIzIk8opVv9KVd++tVXeJHn6Lq8zqcLLau6G+DONiZxr123xCjgpZ3
         msaYtIXLdFoqPXtbWaGfUItiwSZF+DNbO5qUAlYeYhxB2AaAsR/TXwq1Nxwfs/8liJKM
         KwpdB6CeYR2ZHRl8Nj9Iu1kdH/Vch0gLkxPNFNRfuCjkvP+5HBBn0hKvl5JaueaLE6pC
         Xz8XadqeKKDk65Jxlu74xdJsnUfm7rjPNYDu25xYLC+++SMSrTt6n48neZoEcRSuMore
         7msWhb1X9HmqQUKAH99YpBLKHT1WpbVuB+CzIZhUBLmLHALw6/ck/uifGfG/pRLOVXZG
         YphQ==
X-Gm-Message-State: AJIora9+itYNxpZlk4IENwAhE3eLON0Q4uEu4HiI4+vp4xUM1eUhEAQL
        eQkPhXfrYpXaASz6sllislTJhA==
X-Google-Smtp-Source: AGRyM1vc5NUeJeAtQh0U1IylvikvZ87mlFgEYKxVhW0CpA1ax0o5L40V3snxgPcc4vGHBldaOaTZtA==
X-Received: by 2002:a17:90b:3b4c:b0:1e8:5e4d:ed83 with SMTP id ot12-20020a17090b3b4c00b001e85e4ded83mr12595158pjb.19.1655332072591;
        Wed, 15 Jun 2022 15:27:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:342:e7bd:5391:5d5b])
        by smtp.gmail.com with UTF8SMTPSA id p2-20020a62b802000000b00522af870b5dsm147789pfe.56.2022.06.15.15.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 15:27:51 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] sched: Drop outdated compile-optimization comment
Date:   Wed, 15 Jun 2022 15:27:45 -0700
Message-Id: <20220615222745.3371892-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this exists from way back in 2011 (commit 095c0aa83e52
("sched: adjust scheduler cpu power for stolen time")), when there was a
little more aggressive use of #if around these variables. That #if is
gone, and the comment just confuses the reader now. (For one, we don't
call sched_rt_avg_update() directly any more either.)

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 kernel/sched/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bfa7452ca92e..6dbe52d90bef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -679,10 +679,6 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 
 static void update_rq_clock_task(struct rq *rq, s64 delta)
 {
-/*
- * In theory, the compile should just see 0 here, and optimize out the call
- * to sched_rt_avg_update. But I don't trust it...
- */
 	s64 __maybe_unused steal = 0, irq_delta = 0;
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-- 
2.36.1.476.g0c4daa206d-goog

