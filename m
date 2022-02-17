Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF4F4BA4C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbiBQPo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:44:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbiBQPoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:44:55 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BA814091
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:44:35 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 132so5366186pga.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0E9JlSv55Udz7d31hv5lpiU6VWwDB8VKAhZNevzXCs=;
        b=yRKtUo7EWwFSzty1/lI/wG7khNU9AhaEy8TYjtR22apwxHHnz2GSuAmhVM3aV945VV
         mmOf2MlnXQhrREhiFPfUEdqRzkhelCfh/hXphaspizEXniYntuu9dvkSm92kSBPyPKik
         PrH8Jkqc8WaFkQN3Iq/+7N7yw3RUvArygQEe4CyDPd1jylnrtHthsFkiV7c2KH+ET844
         CspHyjYCg86bVQ4CTkINn+hUTodlmdU7XMnT/4leFUNO7d9inxT6Wsl7BrhyUUV5GXuF
         ZXVpKcFWr3W5oILJMqtgUE3feFo/5Dab6Bt7suNT7IScYEirBbKGhuJ7FWoOsjuf5UIx
         KRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0E9JlSv55Udz7d31hv5lpiU6VWwDB8VKAhZNevzXCs=;
        b=zvCoSH0pQ0l6UP9H78M+Rl7nRcmksTNEVgevMCbCdGQDJ0s/HIqNnrwWryzzWBUOA9
         yDGgLOmo3aDoUDxygjk7iXWZdwW2uldYNYjlwHCUVtpddlizWe14WOhVYdzPK3r/jABs
         9rV80XNUMVQRkWrBIwd6olPKQmZmxRsLmLeiGur5mEHA67BVNmweFg4k9a2uWSjmUbj/
         fdBgnqm5B9/vHvzAwhJCtrcpGJK7CJeN3nQrdsAS42cyohdA/VSqAnRaJ72upQMl+DBL
         YlvNLVVvW3ExgtFBwe1AG5FR/htRJIqsJmpGjBu5rOfeCMdo28OxX2ihe+O8Hju5dhuk
         UStA==
X-Gm-Message-State: AOAM532CvjvYaDmTkGipw0G0LUPOgDgPsprz/h3H3OFg+Qd3++saj0Dh
        vt4Sxy6gqU+hzE0+IiwoxyuAxmGGDdnsUA==
X-Google-Smtp-Source: ABdhPJxzUUurSFtJCNWKs4as8Ze+x95ZUmyDEQ4C51KUy8A2qI+sXwvR8P0mTJJYRMxUT/f44U8H7A==
X-Received: by 2002:a63:1f02:0:b0:364:6f52:7ab2 with SMTP id f2-20020a631f02000000b003646f527ab2mr2817581pgf.396.1645112675447;
        Thu, 17 Feb 2022 07:44:35 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id s6sm24108pfk.86.2022.02.17.07.44.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Feb 2022 07:44:35 -0800 (PST)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] sched/fair: favor cpu capacity for idle tasks
Date:   Thu, 17 Feb 2022 23:44:01 +0800
Message-Id: <20220217154403.6497-6-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220217154403.6497-1-wuyun.abel@bytedance.com>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike select_idle_sibling() in which we need to find a
not-so-bad candidate ASAP, the slowpath gives us more
tolerance: ignore sched-idle cpus for idle tasks since
they prefer cpu capacity rather than latency, and besides
spreading out idle tasks also good for latency of normal
tasks.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d8f396e6f41..57f1d8c43228 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6007,6 +6007,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
 static int
 find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
 {
+	bool ignore_si = task_h_idle(p);
 	unsigned long load, min_load = ULONG_MAX;
 	unsigned int min_exit_latency = UINT_MAX;
 	u64 latest_idle_timestamp = 0;
@@ -6025,7 +6026,13 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 		if (!sched_core_cookie_match(rq, p))
 			continue;
 
-		if (sched_idle_cpu(i))
+		/*
+		 * The idle tasks prefer cpu capacity rather than
+		 * latency. Spreading out idle tasks also good for
+		 * latency of normal tasks since they won't suffer
+		 * high cpu wakeup delay.
+		 */
+		if (!ignore_si && sched_idle_cpu(i))
 			return i;
 
 		if (available_idle_cpu(i)) {
-- 
2.11.0

