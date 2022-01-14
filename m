Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50C148E168
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbiANAMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbiANAMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:12:21 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1858AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:12:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d10-20020a17090a498a00b001b33bc40d01so6423590pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umbTELPkoXqx61qKq0eSrSv/ete9EM8A+7G0MjXg6Xw=;
        b=il4pD8ElB/KgP8gENQztb5zxXdR8K5yrRBl0wh4ngUyvaum8gfHYgvu77Xf7Z93k4r
         RmuLB2WnXXE/tspq0XSvAO1bABelXdLLbZ3OWlIRgAB9QoT6AJGsfhqwxmPUKRxXYiSn
         SupJHgWXdZ7w4ZXhQ+hL8YfNnXhNxEatnL1+hGXqdDYhIuIMM6DEYeBpaAdfyxobbBbo
         xbOMKXeTA78HBE7R3ktCiav8W9FPPH2TAngDR6ceuNdrHiBXO9W0zZOSMVbRMa3aw8gU
         IWb5ToXNBvtakEU5Z8k4PgB47Iqh//uCx5PiAEb0+1hvCy6QB8my/iB7f9lEeJwrkKU5
         NY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umbTELPkoXqx61qKq0eSrSv/ete9EM8A+7G0MjXg6Xw=;
        b=Ph8kBQ9rXOdSXc7koWovtqAIyvEzgj4KzSQQAfSmzb2I67rmRq5TkgiXwyCmIDyH8B
         u6bsDKKUR1H2kguvIa+xeFJN1rc0Ljdfedns8rRkF3VT6s6b0U9tL5+H2bwY8rdSw7Fy
         +XqXUEzFwXqc88wwHpyXYrfL1Aq5RAZUbBBUEQFJd/T2X5S3/kHpH86b3XKpEgq7Qo7F
         rr8snd4GJL5BlidU12rh1zu6QkoWjO8pWpgW+ByjsXUutf5y73Kebpa49Tpg2tCxIauy
         76m3LSP64E+c0fTeMJ6HssZypVWgqjh6jnEsSvgelO+GxZad6JhVgXR0uvVlx1FAVDi8
         OtVw==
X-Gm-Message-State: AOAM5302e/33MnsIxFdNjHjEIXYr3U+t/n+pH95m8Q3COTImnJkEQhF4
        yR106s3cWDAY3n1YycRoYsU=
X-Google-Smtp-Source: ABdhPJwkDCJk9x1FSAKjjbCeQhq8UILvZPr8rOUUk/6RXdnex5pA1WLPojhqzMHMjLmHvMMTkYZn7g==
X-Received: by 2002:a17:90b:4c50:: with SMTP id np16mr7849463pjb.208.1642119140618;
        Thu, 13 Jan 2022 16:12:20 -0800 (PST)
Received: from localhost.localdomain (192.243.120.57.16clouds.com. [192.243.120.57])
        by smtp.gmail.com with ESMTPSA id b6sm3876771pfm.170.2022.01.13.16.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 16:12:20 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     mingo@redhat.com
Cc:     davidcomponentone@gmail.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] sched/fair: fix boolreturn.cocci warning
Date:   Fri, 14 Jan 2022 08:12:07 +0800
Message-Id: <190b5c2f2f2fb9cc775fce8daed72bf893be48a4.1642065293.git.davidcomponentone@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The coccinelle report
./kernel/sched/fair.c:9726:9-10:
WARNING: return of 0/1 in function 'imbalanced_active_balance'
with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa378df..354a36c1ab69 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9723,9 +9723,9 @@ imbalanced_active_balance(struct lb_env *env)
 	 */
 	if ((env->migration_type == migrate_task) &&
 	    (sd->nr_balance_failed > sd->cache_nice_tries+2))
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 static int need_active_balance(struct lb_env *env)
-- 
2.30.2

