Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F945A1068
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiHYM14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241057AbiHYM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:27:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718EDB2CD1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:27:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bs25so24426986wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=3bBUsI0/teu1SGpGTa+Jbt56cw9thfDxAuVHauIJcr4=;
        b=wDcdvn9n+ukcoBqV1qJlvuH5bk4MBjNC0WGzpX+j68yBvwUlNF45KAf1BfBuI8A4jB
         adSZf4/KKaWAVAnKxv/HWdUemw/1Uc3nnNBFm3EOmvihVsrAuopXeBjJ+CM4UJ41axnO
         nL0vIAeOWwV4Q+XsFIBLWjvtBuG0v1bLDkA4PMof6vi6QJh4LVzWSxfGX53J1LqmkNF4
         9pb6MMfSgV2OwiFio512IB9WZEf//+LiIgDtAzr44uYjlSBTzt2+D1rVl15fSIeColnF
         7ZJs/KvCsSK1xtKBneh4XfdhWw5Lz/+0xud+/FjKc+2XKJMvfi7QpGY4qC+eg1W5Taul
         fiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=3bBUsI0/teu1SGpGTa+Jbt56cw9thfDxAuVHauIJcr4=;
        b=1YpnnuZXGaU74hv71v8TF/j0mI35UUrWm68dNoc8MiqKS8G/tK2vQn58s0/zr2z/eH
         V2wAVyJ0Pia2d9Usl+LtPky2g1lmxP94+KkmrzwmeA6VoN52F6lmuMvKhwz14UoSanLp
         5G2Y9nLT2hdaZzDfnRGORyzNAMNRCfetviLUoiycAKO+wbb+Rd8AouUojkDhUbyqscpF
         5WDMdgPODexmabqNwYwgsmOKdfwkaJFjwRRljcJeQo61rH4k5p2/0fPQ2FOV2pqBJ7BL
         41nost3kINEKoYrykeRG4EccXawpG0C3ovrEbGaVLt5DA2DNXPpIhPmiXOKvSy6VyypE
         ef2g==
X-Gm-Message-State: ACgBeo2rKN4t+n7YPi7on5FOK7tRzuF7bzyRINpP3NfF0hPcfb1j7ZnO
        kB82RFmk5D7ldxhSVOnm4+zJdw==
X-Google-Smtp-Source: AA6agR7wn5PGajPD4/BbEjbqGbOm6JA3c4Unu2o8aL5mYu4gaY6cWdew2B7umdMm4FwK2sp4GgtsCw==
X-Received: by 2002:a5d:64cf:0:b0:220:6d8e:1db0 with SMTP id f15-20020a5d64cf000000b002206d8e1db0mr2081414wri.564.1661430456817;
        Thu, 25 Aug 2022 05:27:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:55dd:3519:10d3:b07b])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003a5ee64cc98sm5417809wmr.33.2022.08.25.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 05:27:35 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     zhangqiao22@huawei.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/4] sched/fair: move call to list_last_entry() in detach_tasks
Date:   Thu, 25 Aug 2022 14:27:25 +0200
Message-Id: <20220825122726.20819-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220825122726.20819-1-vincent.guittot@linaro.org>
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the call to list_last_entry() in detach_tasks() after testing
loop_max and loop_break.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6972a1a29a48..260a55ac462f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8047,8 +8047,6 @@ static int detach_tasks(struct lb_env *env)
 		if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
 			break;
 
-		p = list_last_entry(tasks, struct task_struct, se.group_node);
-
 		env->loop++;
 		/*
 		 * We've more or less seen every task there is, call it quits
@@ -8065,6 +8063,8 @@ static int detach_tasks(struct lb_env *env)
 			break;
 		}
 
+		p = list_last_entry(tasks, struct task_struct, se.group_node);
+
 		if (!can_migrate_task(p, env))
 			goto next;
 
-- 
2.17.1

