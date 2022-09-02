Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BCA5AA665
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiIBDbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbiIBDas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:30:48 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBAFA6C3F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:30:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bh13so862567pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 20:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zDuc296oUyLkm2+WK0v0ZsSxZqcMqtpAHljnuoWPZ4o=;
        b=GodpOnWLNVhpIHJgD0RmFJp/hNptRqUZa/mfcL8Ji9F1pvt1Fjdvge6jvEXHfwVY3n
         vBL6A62ionXTyVoOxurTgNsG6MtSFFFnGWoKm9pK7C7UhRtxhVr6QbwQBC0kJ4ed6VoU
         zVF2MqNWrtd+mGXPbOAE3VIrqzYvKetPXP73csSaN/O1JvEsWW1wiqtXlt09ZrtrvBT8
         N7rVS1LNVF0KZn2EkNdQq/GRkVwqra3J/StMJoJF+CK+ZjyBljHOuQjsTKOtZHF+4LIX
         5MoU7H4RKX/4OpZCKVt9sybEy3XeJa9w1E233CTe62wIb8SptcjQFrCUUhdp8v/+lUGA
         kDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zDuc296oUyLkm2+WK0v0ZsSxZqcMqtpAHljnuoWPZ4o=;
        b=HfIduPr8g5G39yInKbdrPGcQ/aH2aPzxjNlx2YwA+W/ZlTPl/uQoHxZG9Yb98+YyKr
         fnz9daT4V+2P4NcS1S7P8tYq6+a9gZH1JgN83AJ1oVxWUl0mMgBOoCwVHcYaG6uyY0cA
         nbN/1WkJgx7vHRsg4LnylcD83MM3GH24fpWM5xsJFsYGnw9QTO0bckC2nj7ezSASHxkP
         sZe1ZQGz4zbcLcuK64otma5hjVQb3HwgfgqEUGP2rcQ6N400hfpUYVjsy5hCps0AjHrz
         De02V8jrFIfbOaYbV0nsAuy3Ics/pDMApAJiJ77iS1xjkBrg238DrIdR789QSTUGucAG
         Rqfw==
X-Gm-Message-State: ACgBeo2tWcZUqhWFjhXoScuvd5XlghB0+Jn4VZAwfJ/eH4TSF6tQ6Pba
        tE8U0ykrpTkmS9EvOaGbvdMc2w==
X-Google-Smtp-Source: AA6agR4uSFoLEMoNN/mV5oV/edgn2lPw7ZrdLzp9SJOs8qwR+wHxA2SIgDpnzMdf8Z8RKPcGpW7n9Q==
X-Received: by 2002:a65:6a49:0:b0:42c:299d:b0aa with SMTP id o9-20020a656a49000000b0042c299db0aamr19189675pgu.54.1662089445740;
        Thu, 01 Sep 2022 20:30:45 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id w21-20020a634915000000b0042a93b625d4sm325680pga.27.2022.09.01.20.30.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 20:30:45 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v3 2/5] sched/fair: avoid double search on same cpu
Date:   Fri,  2 Sep 2022 11:30:29 +0800
Message-Id: <20220902033032.79846-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220902033032.79846-1-wuyun.abel@bytedance.com>
References: <20220902033032.79846-1-wuyun.abel@bytedance.com>
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

The prev cpu is checked at the beginning of SIS, and it's unlikely
to be idle before the second check in select_idle_smt(). So we'd
better focus on its SMT siblings.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Reviewed-by: Josh Don <joshdon@google.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9657c7de5f57..1ad79aaaaf93 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6355,6 +6355,8 @@ static int select_idle_smt(struct task_struct *p, int target)
 	int cpu;
 
 	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
+		if (cpu == target)
+			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
 	}
-- 
2.31.1

