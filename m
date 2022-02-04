Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF064A9A56
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiBDNvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359094AbiBDNve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:34 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DB4C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:51:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id e6so5140353pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 05:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jv+1OmXtq7K+DesUXAvsMwR+pbzMT8EaUquwRsw8P1w=;
        b=k1VUyxVms4sQJMDeZ2D5pmurOg1fSQ8xquL1QIhyqL8rIZizg8PasccYo1eWWzKDzi
         y8LTWj3d/DbmgV5lF9Xg6DtTq4BStjnhB/5dvVXrC2SBrkxEfvrqMyxdA+z1NkmBG+at
         0F37rzV+FxleMELbtw45SKDKQyFgK8NT9kmB5lbEyGkP7HqLaLJb0hINRIZnimovmBlB
         H0srfNL9Q1+MQOxqZCOK4O6T/UcF9o2SP4va27CLyyWsalzm6E2xTYKSvYiDzIeOYpSL
         a0nw3lQJNehoOWPikNvb7gaIVcX8uxqCO4xLKCt+GyNhBr0LRvR8DZ4alQxV4nFYFPQp
         R1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jv+1OmXtq7K+DesUXAvsMwR+pbzMT8EaUquwRsw8P1w=;
        b=4UaDfWx9viBUIJHQnDG6dzFjux2vKgTaz4LZ2QKreShkNt49Y9v5F88pqgYPuiONPG
         kJhKwci2ELpZEtUbnMBXskdA9Uf/sKeI7tV15pxLMCNJzuGi3bW0C/qe0+hWAPoa3XYf
         eRRC43RCLs/FoiXdJA7A85p9/XYW7tJrZnz8YxUYuDNrKAbw8cYH6P9SW40NnlVpxNO1
         X9cl5qyvMBg3QliKCL1X6Auo4dlGpiSmvnrZ9mYZ3W2mNp1G6Vzo9YA+g6F3cWe8Ej87
         rOXQXBq6fuZUGI4OtASPumQ56IzxbbLe7UbCJju6bTpGSnaWV5anvHKGApLvARNnwTGS
         hF7g==
X-Gm-Message-State: AOAM5316S3xt8ceJCX0ZyyMG08AonFx3JRn0k+tn8LngsGhCdcuePFqw
        NFXPHBmE2vrm0JKAZ42rO+suFA==
X-Google-Smtp-Source: ABdhPJx/XYFD3O/Lx16uh03/xIMBlys471qWZKbIAGTGwKweGLijHoTj4ObsGkqbSS/36TwwZ4ZMAQ==
X-Received: by 2002:a63:3285:: with SMTP id y127mr2457121pgy.32.1643982693736;
        Fri, 04 Feb 2022 05:51:33 -0800 (PST)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id 13sm2668131pfm.161.2022.02.04.05.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:33 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, codalist@coda.cs.cmu.edu,
        linux-audit@redhat.com
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 5/5] taskstats: Use task_is_in_init_pid_ns()
Date:   Fri,  4 Feb 2022 21:50:51 +0800
Message-Id: <20220204135051.60639-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204135051.60639-1-leo.yan@linaro.org>
References: <20220204135051.60639-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open code with task_is_in_init_pid_ns() for checking root PID
namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Balbir Singh <bsingharora@gmail.com>
---
 kernel/taskstats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 2b4898b4752e..f570d8e1f001 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -284,7 +284,7 @@ static int add_del_listener(pid_t pid, const struct cpumask *mask, int isadd)
 	if (current_user_ns() != &init_user_ns)
 		return -EINVAL;
 
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
 	if (isadd == REGISTER) {
-- 
2.25.1

