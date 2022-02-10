Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC094B19AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345807AbiBJXk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:40:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345799AbiBJXk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:40:27 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830595F71
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:40:27 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id m8so5668046ilg.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5r/gzaAkgy75rCqFlvPrMs1wcw7KKnaGDY3klmZfIuI=;
        b=fm0i2hSs8fnadbMOheCvaYS79Sd7CX1F06n12cepJ4/C8ZDDyJoMTvbSkbC6HljlFQ
         CMm3YaRXCiY7izDi7nzyLexOXQXJYymrbzD3srdtOj6AbWuWPCAAsODOcPEfgtdcCeq9
         FrSXRA5dGUp0iFzKP7DSJ7Ntb2YEUmQRnHgUo7d0V4CRbDl4CXOZC6TwiAG1Q4ziSCag
         GyGFb76sgKCv+yYQuJ25Jrvc0fGN/v94iSIltLqwgD3gZrLmPTQl+H/B8AnY6BnbJRjx
         7ywMgKmIcWRFBk5vsBYSCAl+yob/KwIP//ylvGkKOiGRLMQnzWJ2cDViq9wWQUD4rZE8
         4Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5r/gzaAkgy75rCqFlvPrMs1wcw7KKnaGDY3klmZfIuI=;
        b=MS6OpXgBVUZ2nH1HiJfzZzCRcbB1XNFqn5RAbOtrGwF9UY9Cu1EuOq5wdQ9H1qkArF
         Vn05WbzYLvuh2er0J1dVnPb8TT3kdIB1sonFnO3ogJx85F29USgWI7K0WkuT9l5wZkEf
         No23U9KK8Aq3s6gVf9FIWJs/5UdiB1CiWznhF7PwGJSBu52jFG2vtNntu8CcyWC/9mu0
         VB1W53Gtzg6JqrJ1EByeb9XfDjZixn3lAvCi+gHCv6hbeGO9sCSvSLYNWY5Iruw+WQtV
         3vxcrG9uMQ04UCG2YrGWDljkhO1Merjd4ZO7tiSS7rWxA0fNrWVsYgQWyPXD8dcKySgj
         4+CA==
X-Gm-Message-State: AOAM5302e79917dgzBnQ1APqRWsFuXOFSkKQxzEFO7WO0RUOlbDq7P3s
        vkJLEvqh9AeTt1cxTYb4XbvcrOVbiHLolw==
X-Google-Smtp-Source: ABdhPJyLhro79jJ3w57du7eysK31wHXhRUklAWC49/k2kVHLqEqjBApmH03mGMDbLgz2LsxsvRUE9A==
X-Received: by 2002:a05:6e02:1a8d:: with SMTP id k13mr5362636ilv.257.1644536426899;
        Thu, 10 Feb 2022 15:40:26 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id q18sm8230178ils.78.2022.02.10.15.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:40:26 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 22/49] sched: replace cpumask_weight with cpumask_empty where appropriate
Date:   Thu, 10 Feb 2022 14:49:06 -0800
Message-Id: <20220210224933.379149-23-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some places, kernel/sched code calls cpumask_weight() to check if
any bit of a given cpumask is set. We can do it more efficiently with
cpumask_empty() because cpumask_empty() stops traversing the cpumask as
soon as it finds first set bit, while cpumask_weight() counts all bits
unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 28d1b7af03dc..ed7b392945b7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8711,7 +8711,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 {
 	int ret = 1;
 
-	if (!cpumask_weight(cur))
+	if (cpumask_empty(cur))
 		return ret;
 
 	ret = dl_cpuset_cpumask_can_shrink(cur, trial);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a7052a29..8478e2a8cd65 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -74,7 +74,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 			break;
 		}
 
-		if (!cpumask_weight(sched_group_span(group))) {
+		if (cpumask_empty(sched_group_span(group))) {
 			printk(KERN_CONT "\n");
 			printk(KERN_ERR "ERROR: empty group\n");
 			break;
-- 
2.32.0

