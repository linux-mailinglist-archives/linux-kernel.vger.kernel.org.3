Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E1B4F62A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiDFPDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbiDFPC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:02:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509F6AAB5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:46:41 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n18so1723067plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=hWie3mJTAnfpzOXhn4Z/4uIgwysiFcrooHT60DVzybQ=;
        b=CE9K9MT+Rt2kpApicMQngJo7nwda7ou2DtrFamdUZFxlh3kP15ZFuCURNlqhkQmCGY
         2AT2p7oDzXmGjNJgBhxofiTlVwbGL2bESAobC4pPZiIEqg605SXXcDgFou2T6Acy3uno
         QJnZeOHUhwImxP4AKwaD8eEC9R8AntNoAFKgRLD+1PiQikFBcA9KHKWkZ6x8RBW71ddk
         xQpQaYU+zmm7wYRMe0eufz5huUYwBj5SjrudLWccRPZbmsG2S3Rjahtutr9ZdVYLEvHi
         ectsA3dd8F3ivzbXM0WBgO0uM3BnScI145ZmiaJQMxHhcubB6TcTzGgRh4Yh5+26x18B
         Ngdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=hWie3mJTAnfpzOXhn4Z/4uIgwysiFcrooHT60DVzybQ=;
        b=A1Q+IloOcKOt2ZPOxXCMvFolA+uygHHTsMnZh3M358jUwPZ3M8kajgpqjsvziiKS64
         mCYsraTStAdveNJjYktr+hJnYel64dy8O3eK3JZB3rkIhQZzE7W4VVexJRS7eRXQTWz3
         mNFoVMQBfKterKIKfHOoht5tLKVqJIvkstrSTYDD22jraw3+qJwty999A7BrDmJvvoqQ
         7A/8Sf1EquAn6/I8dIdoJOjS/n3tTAaWrKqJn9BFRSSb+jwYltcj8rAOnfCXxb312TJw
         Zxu3LxR9MkK2/rC9i2/NDgOJv3NejRI3HF1wFQmI6QXHA0rb/Vzd6tf4bG7j3pss6LZH
         0uWg==
X-Gm-Message-State: AOAM531txUZ9p3OfgtiRaemFICciSHko4ZskLz4Jq+6Ms+GAskIgLa+k
        XvZp7gGPfc9/2wh0tIYAYoY=
X-Google-Smtp-Source: ABdhPJwNMvr7Ye7f8HN6k8CSNZ1+X2QyzDqvWOQk6MAWcVPOo0giQ96XUCTWCwbkum8M+/VAdkJAhQ==
X-Received: by 2002:a17:902:c40e:b0:154:80a7:95c9 with SMTP id k14-20020a170902c40e00b0015480a795c9mr8546529plk.28.1649245585441;
        Wed, 06 Apr 2022 04:46:25 -0700 (PDT)
Received: from localhost.localdomain ([150.109.127.35])
        by smtp.gmail.com with ESMTPSA id br2-20020a17090b0f0200b001caa0db90d3sm5578684pjb.13.2022.04.06.04.46.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Apr 2022 04:46:24 -0700 (PDT)
From:   zgpeng <zgpeng.linux@gmail.com>
X-Google-Original-From: zgpeng <zgpeng@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Simplify the scene where both local and busiest are group_fully_busy
Date:   Wed,  6 Apr 2022 19:46:20 +0800
Message-Id: <1649245580-27256-1-git-send-email-zgpeng@tencent.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both local and busiest group are group_fully_busy type, because
the avg_load of the group of type group_fully_busy is not calculated, the
avg_load value is equal to 0. In this case, load balancing will not actually 
done, because after a series of calculations in the calculate_imbalance, it 
will be considered that load balance is not required. Therefore,it is not
necessary to enter calculate_imbalance to do some useless work.

Signed-off-by: zgpeng <zgpeng@tencent.com>
Reviewed-by: Samuel Liao <samuelliao@tencent.com>
---
 kernel/sched/fair.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9f75303..cc1d6c4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9634,6 +9634,18 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 			 * busiest doesn't have any tasks waiting to run
 			 */
 			goto out_balanced;
+
+		if (local->group_type == group_fully_busy)
+			/*
+			 * If local group is group_fully_busy, the code goes here,
+			 * the type of busiest group must also be group_fully_busy.
+			 * Because the avg_load of the group_fully_busy type is not
+			 * calculated at present, it is actually equal to 0. In this
+			 * scenario, load balance is not performed. therefore, it can
+			 * be returned directly here, and there is no need to do some
+			 * useless work in calculate_imbalance.
+			 */
+			goto out_balanced;
 	}
 
 force_balance:
-- 
2.9.5

