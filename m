Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034F555368E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353032AbiFUPp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352963AbiFUPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:45:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E82CDF9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:45:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q18so1463548pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OWhFlfb7htu6GkBaA4Mx/y+kkp9dgnA8oMsdLeGvVP4=;
        b=c6prXg1haWwA7WpvwaKzDQZgCjgs9JXMgmPigpP8RHm05OMDhD0Je49FYBNS1E+0Ob
         m+Abi2jouRVTZQvqeosJZ6ynu6gjNHBe0J7FmQAnjEZTFLl4mJuJbuE3cVjXLGrPyrbO
         5cpfxPVq8kmqhG0AiLuMuAnZFOwHUaKUPAWjFlCCr2pjaFXkUimwxnA9Su3j9/65/idR
         9wuNj5akbPblJw5kFl7XjG8MJIY2xR8XhjO3RWSooemvebuAGYajfPydTrt3bipoDc24
         qBW7QvPCa3iOjKOPBbL0fCJsgSq+CUy2SfJuBQyBj5Bs9/eJ6GzC4Z3TM+0V5OreCG/e
         oq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OWhFlfb7htu6GkBaA4Mx/y+kkp9dgnA8oMsdLeGvVP4=;
        b=C7w5hFwSNB//VsluPW7tN+iWvwhezWoTfzhRH2WBbEP87nasdnU1OLm9lsHrRfQSZq
         lNjfFAFlRZOTEi/7zpJ9jbkidcLu96GUqDEXOq0wnrLKQ8tD7thtaCxjk5Ja6Ao0HQos
         PabSmSxSN+pWD80oN8rsgiul9x7Mgpnh3Ngdk8P1ZNjqlr7Xb6Xsepx023WQ+7V+9Wjx
         Loi4oZK60kYjZjWWFKH8kzsmNvlZL1VcnVUCBf156KbdlBYUZdePzDBAm6Ewi1+Lg/hx
         TJZ8PkrAKB46bcUdu0fzMVdyV/MU55BM5H505BmwEwZ3ExDK5Km2RLa39Gmxi0Y1oueP
         cBug==
X-Gm-Message-State: AJIora836RPE5ptJzi3yARiKhi1k8brpcyVXE0mq2yJDBXTPx0Mw90UD
        g8ZHu2kdt9GZ9+i8JIuFHn4=
X-Google-Smtp-Source: AGRyM1vU51mTDKyzyq9D/HRZ1f7BgtUk8K41/2hVVbbgIP7x+VA9WMRPVVpdp4Q/4tJr2vfDvkTsxQ==
X-Received: by 2002:a17:903:2584:b0:169:a2b9:b428 with SMTP id jb4-20020a170903258400b00169a2b9b428mr24622284plb.170.1655826351748;
        Tue, 21 Jun 2022 08:45:51 -0700 (PDT)
Received: from pc ([103.142.140.127])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709029a9300b001696751796asm9631627plp.139.2022.06.21.08.45.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jun 2022 08:45:51 -0700 (PDT)
Date:   Tue, 21 Jun 2022 23:45:40 +0800
From:   Zhaoyu Liu <zackary.liu.pro@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kuyo.chang@mediatek.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/pelt: simplify load_sum assignment code in
 attach_entity_load_avg()
Message-ID: <20220621154530.GA29721@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 40f5aa4c5eae ("sched/pelt: Fix attach_entity_load_avg() corner case"),
these code was committed:
	if (se_weight(se) < se->avg.load_sum)
		se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se));
	else
		se->avg.load_sum = 1;

they could be replace with:
	se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se)) ?: 1;

to make the code cleaner.

Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
---
 kernel/sched/fair.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 78795a997d9c..ed32f66bbd3d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3881,10 +3881,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	se->avg.runnable_sum = se->avg.runnable_avg * divider;
 
 	se->avg.load_sum = se->avg.load_avg * divider;
-	if (se_weight(se) < se->avg.load_sum)
-		se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se));
-	else
-		se->avg.load_sum = 1;
+	se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se)) ?: 1;
 
 	enqueue_load_avg(cfs_rq, se);
 	cfs_rq->avg.util_avg += se->avg.util_avg;
-- 
2.17.1

