Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76055B2E53
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiIIFxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIIFxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:53:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF3DC00E3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 22:53:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pj10so570918pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 22:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fNnn9wLK8Hw5NIwUy4nGEsew1EpO470MKUS9ViwkYPA=;
        b=N0iuRf8Tjp2U1euObd/YNC0SPejhZ0Idhojtv157DwpOMO7zpKPXUeBwrzlh1YYcVU
         KOzGhtqbNMiAYfNjOADqG5MvRpyxpgydXN3dFerF3Mzf/PCUFNFM3cf0S/7nprAEOEgB
         8Xewe9KluYQFn6HWd2kKf2g6AdaXag+myWQwTDSaaWNK1+XAl6rpGD1avmUFGtgBTztX
         bnFXCG5jKQck+bOkSAJesNmgrmY03Jlds4qI/R0gDgiGDYMeQZryiAIvsBn8RtN1wrzs
         7kF/AQ8dk6DD601+Dib9J1QSWiRT/C1Zd/egX2bUohIJWYAQmm7xAcR8wUUxLsYYPHNt
         qC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fNnn9wLK8Hw5NIwUy4nGEsew1EpO470MKUS9ViwkYPA=;
        b=PSYv+Iokz05dY6GHES3GFvj2NI3urSHUStayUvfC48Po1R7LvIP6MdDB0UdcvMhim4
         fG1mBStmVaeu3nWys4zOKhRG7g9/9wiSvQ2YO2ki5epFYRa5/oIGNa9pJ7+0hEWY/6aF
         kIuNcsLD7QVcQ7QDFNDdUMG083+9WR4Ff8AYqtWpnD4J9BnpLb3Jp/y9EnnB2A4job2a
         3gIvaHDvktGZgfePfbrv/fnNXQlC8zdmrdHkMzvREhJ3k0IXyOJW7yZNumTbTjfea7R1
         FGxB3M7eVULcuTd7Atrk+3IwepUcddJmX8Y8GGSLOpFxs5rO6ER23RxiLJtPFtuA9xlK
         o0VA==
X-Gm-Message-State: ACgBeo0YGMI1mz673vEIOTIipjmb5MSC6YlaH6ObzH3K84HgfbHtab1Q
        10rh1ac5OHk7MDLSKTaAqICqyQ==
X-Google-Smtp-Source: AA6agR7o05QuyuiUecgvMWqqSXv+iDtcuBax2JBvTYVEVJeZomRC9ggsMz4Xw9Ao7hWisu/Abd1nOQ==
X-Received: by 2002:a17:902:ea0c:b0:176:75a2:625d with SMTP id s12-20020a170902ea0c00b0017675a2625dmr12288617plg.21.1662702810956;
        Thu, 08 Sep 2022 22:53:30 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id y66-20020a636445000000b00421841943dfsm464380pgb.12.2022.09.08.22.53.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2022 22:53:30 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v5 3/5] sched/fair: Skip core update if task pending
Date:   Fri,  9 Sep 2022 13:53:02 +0800
Message-Id: <20220909055304.25171-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909055304.25171-1-wuyun.abel@bytedance.com>
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
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

The function __update_idle_core() considers this cpu is idle so
only checks its siblings to decide whether the resident core is
idle or not and update has_idle_cores hint if necessary. But the
problem is that this cpu might not be idle at that moment any
more, resulting in the hint being misleading.

It's not proper to make this check everywhere in the idle path,
but checking just before core updating can make the has_idle_core
hint more reliable with negligible cost.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7abe188a1533..fad289530e07 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6294,6 +6294,9 @@ void __update_idle_core(struct rq *rq)
 	int core = cpu_of(rq);
 	int cpu;
 
+	if (rq->ttwu_pending)
+		return;
+
 	rcu_read_lock();
 	if (test_idle_cores(core, true))
 		goto unlock;
-- 
2.37.3

