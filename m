Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC964FEE1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 06:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiDMETN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 00:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiDMETM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 00:19:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB11527B3A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:16:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s2so913814pfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZBllIzgXnhQlZt5tsrHiajScj0Xm9TSurwplkvTqsY=;
        b=YPk3QHqaGq/UVEVrWH0HKM4jww3/AO9CJWNksWYocYbfi0vc9vKwHSwztQ8eP78QvS
         mDlBpcIxSg9Dra1655cNHueHxcuoWfOF55v5NUxIa380zOtFfXFgedgKAgds9piG7dv7
         7ZVKT4c/XicUZskfxEfnx1CffD1Hl9bznVi5SCfcLqgtg1Kn/qiqOhSOtKKqmujQGQgq
         Rw5ROck8dJC5AKd6ET516kkwsEtlwWw4+FWtiqVkL6Y1id5SPNgeaPdosoQKHDG0W7Pq
         /piafzUXk/j2X6255DBoTyMZwA96T4eC4NjYDNzx9zMj1aEpXr3tfP3Z4VrZAQRikwhY
         TY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZBllIzgXnhQlZt5tsrHiajScj0Xm9TSurwplkvTqsY=;
        b=W6GNuAjRXsijU4fPX63CzOTsFypeMbjBCIbQ4TqGNxyf6+FWIXSJjpBakD1DpnDj0i
         3nctohG6oyuZ+QTOQ1BiDd/xW9dfClNDobJhJbOrz+Cx8JwqmrE9nAP9D0CREl20x/jV
         72Y1AFPxueq2KwSTPdRTb6sfCpXN9P7HJ+N658KW9MO55WNsKtZLzZZ14/0D85cR6fzf
         8RuC+KOeD8jMRAZ5hDvrglSuimm03ScrzqzTCIJ99fHH52+j4wgBNHODS8PkcyZhQt2N
         9yAXgJMOlND4dA9PEXRploMOvEhvvEZZ+VHctX3CJ/RP3vvx6+bzhHOJdY9nkoZ9vTSV
         DHpA==
X-Gm-Message-State: AOAM533P9qji/Hv0CMa4DcL/+MIAQiFDcD8OVM9ePOZLfaapRJMjPNV5
        9KYWp0xwfe70DMvwMFwNtXvl4w==
X-Google-Smtp-Source: ABdhPJwBKbx5Xz1Ibds0+dRNv6tMOcdkiD/XGibrhFuhnHIaGyHj4HGms56rTtBf60na45buh9k1Xw==
X-Received: by 2002:a63:50b:0:b0:39d:aa9e:7071 with SMTP id 11-20020a63050b000000b0039daa9e7071mr2848909pgf.116.1649823410243;
        Tue, 12 Apr 2022 21:16:50 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6a:b120:34cc:12c7:4dba:84fc])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7888b000000b00505bc0b970csm10063909pfe.181.2022.04.12.21.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 21:16:49 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] sched/fair: update tg->load_avg and se->load in throttle_cfs_rq()
Date:   Wed, 13 Apr 2022 12:16:27 +0800
Message-Id: <20220413041627.41521-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
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

We use update_load_avg(cfs_rq, se, 0) in throttle_cfs_rq(), so the
cfs_rq->tg_load_avg_contrib and task_group->load_avg won't be updated
even when the cfs_rq's load_avg has changed.

And we also don't call update_cfs_group(se), so the se->load won't
be updated too.

Change to use update_load_avg(cfs_rq, se, UPDATE_TG) and add
update_cfs_group(se) in throttle_cfs_rq(), like we do in
dequeue_task_fair().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..b37dc1db7be7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4936,8 +4936,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (!se->on_rq)
 			goto done;
 
-		update_load_avg(qcfs_rq, se, 0);
+		update_load_avg(qcfs_rq, se, UPDATE_TG);
 		se_update_runnable(se);
+		update_cfs_group(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
 			idle_task_delta = cfs_rq->h_nr_running;
-- 
2.35.1

