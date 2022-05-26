Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7D5534AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbiEZHO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbiEZHOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:14:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECFDD11E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:14:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso999461pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PxeZkmwYfV96KCMYuxRmijxISPSq2e0oV0kOeMtlrUM=;
        b=RSm+3ev0c3wi9ngyYDMgJli7UkvMbmE6FFkhQSsQUyFTvykUs+C5q6Tac/DHMEf2KZ
         kgEX4VjJwLNYKAIuyHnNg/MPpiSLE7aSFS3VVw1SGwhidK9xXWUXukCM7URlV2LzxEe4
         0sm/F6WGfPht++jaqf0W6bbRjIW1Mze7+56AGJOt/FiFNtYNvOEYgOFxLfAZNj2Tu7on
         D2eLBRnk2d6zgr86gSDVncka3t5BF/+rdmC/guKUX6nneWOhqH1kjRSdl8UmPABEBqEF
         oUopp47EqnACLWmhFumAVfrY+77Gd63dWjcci7jxCiGaRwe5HBQ1BX0aMJGhqhUqOziY
         Sx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PxeZkmwYfV96KCMYuxRmijxISPSq2e0oV0kOeMtlrUM=;
        b=LRfHY2a7lz7H2iJ7dFc76B5Z/gTvcxceGktHOsrJ4G6V3FF3NxxmUdLlrVRe/qyqa9
         Vb7yPbLzmn3J5tNztMmdWXRKkvEuLDgMVDIAUPtFXnkmJsvSEpWgn8QAipyHP89Yx+sL
         ZjDBVAMvr+MW354m9nSn0Ooet2DUF4UirmaQTyjhW3mYaZ+5d10GySEK04i2rYFVrUm3
         I2vky7KtSCie7VHnhvzgDfaNN3xnB41nniMbAZ+wbWLftY5x/GmcETs3V7DO8NaXoZcE
         +ihYIE+zsd4TdqyHXskljzNPuw3AIX9hn4+06TBB75Eb3z1GuE30ZNKaHaTxwhafYNBG
         tBAQ==
X-Gm-Message-State: AOAM5307HJ0Y+O45q4Tn7YOdimieM7SSpyY+lhqhLXbqcLqypbYMXQgT
        D+IcbFlzDpDVcgmIkzq14UFPww==
X-Google-Smtp-Source: ABdhPJzN3uazxjTkw1IzQGoEhkLS0CkfbimZC7+yY8XiBel/Cgw+lhFkiNk+YouHfW+2SYFyHhi29g==
X-Received: by 2002:a17:90b:3a85:b0:1e0:548:2bf7 with SMTP id om5-20020a17090b3a8500b001e005482bf7mr1152303pjb.55.1653549259596;
        Thu, 26 May 2022 00:14:19 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id e24-20020aa78c58000000b005184031963bsm640629pfd.85.2022.05.26.00.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 00:14:19 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, odin@uged.al
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 1/2] sched/fair: fix propagate during synchronous attach/detach
Date:   Thu, 26 May 2022 15:13:53 +0800
Message-Id: <20220526071354.6426-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220526071354.6426-1-zhouchengming@bytedance.com>
References: <20220526071354.6426-1-zhouchengming@bytedance.com>
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

When a task moves from/to a cfs_rq, we first detach/attach the load_avg
of se from/to that cfs_rq, then propagate the changes across the tg tree
to make it visible to the root, which did in update_load_avg().

But the current code will break when encountering a on_list cfs_rq,
can't propagate up to the root cfs_rq, that also mismatch with the
comment of propagate_entity_cfs_rq(), which says "Propagate the changes
of the sched_entity across the tg tree to make it visible to the root".

The second problem is that it won't update_load_avg() for throttled
cfs_rq, cause the load changes can't be propagated upwards.

    A
    |
    B  --> throttled cfs_rq
   /
  C

The prop_runnable_sum of C won't be propagated to B, so won't be
propagated to A.

Fixes: 0258bdfaff5b ("sched/fair: Fix unfairness caused by missing load decay")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 523e548c8fdd..5276d05692e0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11303,14 +11303,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		if (!cfs_rq_throttled(cfs_rq)){
-			update_load_avg(cfs_rq, se, UPDATE_TG);
-			list_add_leaf_cfs_rq(cfs_rq);
-			continue;
-		}
-
-		if (list_add_leaf_cfs_rq(cfs_rq))
-			break;
+		update_load_avg(cfs_rq, se, UPDATE_TG);
+		list_add_leaf_cfs_rq(cfs_rq);
 	}
 }
 #else
-- 
2.36.1

