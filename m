Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8D54F71FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiDGCUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbiDGCUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:20:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D5330578
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:18:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b15so4182583pfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 19:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMqs142C79vFrLXC+QBoQwS0fbh6NzXeL+DxLUz/iWU=;
        b=S4wWSBr4uHDyLUKNx6OMSOpuaxTftRb20mAJucp4z85BhJrZsU0uhgKZuXmRvGigoK
         pnfUxKxijMA3v3knEwQc4taODjGzc5E4fbC9H+Cj/FF1AbKf4cQ7RXzOVoqtaqJV0DnW
         lSdB8Y80rypinN/aJQGWxHwRtgPKVyUoCcYcmdDz4uI/IPaj/V/qcSlSK+0PkDjAWvPd
         OscAkoRotJ8rW8oTG5+GZhwkqM1PaCQtIA5FNn6SbOgMwq2O6v7W3DUI+d3KrVOtJRTa
         ye2o39rrD6/K6zUQ9SPrppb4OCf5cQqxJOxddmdV0g6d8tc1Tpq27pP0ozougMeGK1bO
         Xc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMqs142C79vFrLXC+QBoQwS0fbh6NzXeL+DxLUz/iWU=;
        b=2T9QJ3q6Brq70CZbcdEpRZ+NS4x+ZXsgBX1dgImWW/Ca8s+YvYzlAQqm3tKmIAbgf7
         VVnaF0DzDDGV8z0UUtJhh9qg3fr9n6u43Owjd4LGTzqdaiS0qB6+FpBxg70bcfSSM5aP
         7jJsdXVVFQSu+qkLtMV1rXqobRFTJbyhC5kYRPRJVILpVN/e2GVVwalV9aVPAucGo9BQ
         JTuVeMV3VR+cf5Kf340zbDFQBGBUu7OsZuu/yeUgYHMUi72Pm9VrJJlnXvj4tVeTKvQR
         2NibIouGWgz9vD2fM2LWJcXCKXIu30NkIMNwxtRtM7zaI6W6Qep/s40+tHX8Yz2LS3z+
         xlHQ==
X-Gm-Message-State: AOAM530EM84IkzPLKLW7IN3qUzt4kCpLEHhsgWsyJtFzXHWQWZmhEAa9
        L3H6/9D5gmbm1SclSGv5bNS2Gw==
X-Google-Smtp-Source: ABdhPJzUZO9G509xPs+hZK/w6w9W7xoIt7i27X24/dKcvYJ7PkWPFOviocgIHStLWrVvx1F7Q3KJ/Q==
X-Received: by 2002:a63:4405:0:b0:382:173c:1b97 with SMTP id r5-20020a634405000000b00382173c1b97mr9417419pga.532.1649297885996;
        Wed, 06 Apr 2022 19:18:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6c:f010:ec92:b46d:e5a7:1343])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a0026ca00b004fb266fb186sm20847353pfw.73.2022.04.06.19.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 19:18:05 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 2/2] sched/fair: Delete useless condition in tg_unthrottle_up()
Date:   Thu,  7 Apr 2022 10:17:29 +0800
Message-Id: <20220407021729.16655-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407021729.16655-1-zhouchengming@bytedance.com>
References: <20220407021729.16655-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fully decayed cfs_rq is impossible to have queued entities,
the first condition "!cfs_rq_is_decayed(cfs_rq)" is enough
to cover.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e6fa5d1141b4..17c13c38b1c2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4850,7 +4850,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 					     cfs_rq->throttled_clock_task;
 
 		/* Add cfs_rq with load or one or more already running entities to the list */
-		if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
+		if (!cfs_rq_is_decayed(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
-- 
2.35.1

