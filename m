Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6724EB0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbiC2Prs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbiC2Pro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:47:44 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C34C3B3D4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:45:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c2so15152159pga.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zysooMn8IJ98VrrDS0WMswXwEoXCxIeE5qgjfz/kBk0=;
        b=tP53GDW0V6xO3Mc6lQ9a/ywqGjPQrFBuXylv2E+lWz1fyum/gB3R0xzsKhs8Qcny5w
         Bp5hw/OO2KHU9LnnO2++npNbSOm6AvfiZjg2XW59Ze415jjONWFRfBRQ2zvXQ1u/eHQO
         XpgfAMAa75Lerlc4uCJXdT8LRg43l4wUEbLCZ2Rspjhnb9/ZzSpFyxL0KqY6+63TTqQ3
         slhWFTfgGIHBfRCPg13N56XKxv/iJ8XMX20oe3NcthQCiENRu0GyxZC67yrthteVdlQk
         Q4Edw4TyDf56JBRFblClP2GXYJ7S8wXKtTv8uuIv84jsm1F8Re5nf42DEy+/q0e7dEdT
         B1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zysooMn8IJ98VrrDS0WMswXwEoXCxIeE5qgjfz/kBk0=;
        b=WdTy612EP0YE4dAZ/KizCOjxo+EDQFZoddkWUqEeqnHdJ9sKKvHyCD4xhX5r7ojhbC
         c+uW5bIP2UP+8rR4cboHnN+3GFtu+8FpQdZIDRjzyN6oL/lh4lgSfc37NWL0UxK+Uyt3
         4TnewvJ7sHO0RZV9ghMxq2TU2eU4aX/BOnHeMn52YX5XVEwDHd7Cxkfez3EcbPnA8Kx1
         FEzy0XJeAVfTRqO/TAphNc6PrCfKAU0wJfKVyZIhkgFal78Yn1QCbPQm6yHo+NUTICXP
         wWWAlW6nQgJ/LrMFBH1JHiaswYgA8Ff8O/FhfAqqeZAoLVybKI64KLPk+AUOcJvrLjVm
         9r8g==
X-Gm-Message-State: AOAM533xzb0praM5aU3xgdmpCNXJOcCIYH93zMdM6PLo1Roe0RakzqDn
        2bSqqjBiMxd6klb0u1ZMG+pWUA==
X-Google-Smtp-Source: ABdhPJzc/ykja27CyhJnywo1svS553ci+1IAjRy0v1iRDw+KcTufkHUAhz0uSj45kr4a+uoaDKbRkQ==
X-Received: by 2002:a63:2ad0:0:b0:398:31d7:9955 with SMTP id q199-20020a632ad0000000b0039831d79955mr2400322pgq.198.1648568758750;
        Tue, 29 Mar 2022 08:45:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e65:74c0:705b:241a:6dc0:a4ac])
        by smtp.gmail.com with ESMTPSA id u19-20020a056a00125300b004fafa43330csm17930733pfi.163.2022.03.29.08.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:45:58 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 2/4] perf/core: Use perf_cgroup_info->active to check if cgroup is active
Date:   Tue, 29 Mar 2022 23:45:21 +0800
Message-Id: <20220329154523.86438-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329154523.86438-1-zhouchengming@bytedance.com>
References: <20220329154523.86438-1-zhouchengming@bytedance.com>
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

Since we use perf_cgroup_set_timestamp() to start cgroup time and
set active to 1, then use update_cgrp_time_from_cpuctx() to stop
cgroup time and set active to 0.

We can use info->active directly to check if cgroup is active.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d50f45012c05..dd985c77bc37 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -780,7 +780,6 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
 static inline void update_cgrp_time_from_event(struct perf_event *event)
 {
 	struct perf_cgroup_info *info;
-	struct perf_cgroup *cgrp;
 
 	/*
 	 * ensure we access cgroup data only when needed and
@@ -789,14 +788,12 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 	if (!is_cgroup_event(event))
 		return;
 
-	cgrp = perf_cgroup_from_task(current, event->ctx);
+	info = this_cpu_ptr(event->cgrp->info);
 	/*
 	 * Do not update time when cgroup is not active
 	 */
-	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
-		info = this_cpu_ptr(event->cgrp->info);
+	if (info->active)
 		__update_cgrp_time(info, perf_clock(), true);
-	}
 }
 
 static inline void
-- 
2.35.1

