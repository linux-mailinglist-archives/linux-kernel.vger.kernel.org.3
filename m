Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7806A59F4EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiHXIUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiHXIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:20:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B34857C2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:20:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u22so15015334plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=T5Xd8mmYM32aYWsV+JS4zJF3yib8jGf3ov52iW7dkys=;
        b=2hbOVKhOIJMdq+ESAqgtn9qO5FOZb7JuoMEFLh7q/VunkkOu9QAT5ULHRWLNGQHUmN
         f+BAdie4GiPCPkFWX4K1h+kjjefd+BKv3QZwl+MX/Wi+1tUdoLPaG1DFS88O0FQD8OIe
         MuLXlFlHpQY7LCq6GjLVtMo1aGQRwAoCaEiL9D1wC1vXIIQ6YXzfgWEfJeBvS+brm3jC
         o4YhJAJGyZ5PspBdTHCfEKsF2rRbqlBg6h4ajiQztHfDToeo84tMAeHwNtV8roDKp62a
         RDIJ5oLfbDn9L+m38KS0qIw2WwsB5HKK2qwtDhQAPv3bCGmDIJym1uNeXaJYeGGm1F/9
         J9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=T5Xd8mmYM32aYWsV+JS4zJF3yib8jGf3ov52iW7dkys=;
        b=I/j5GOfzYemO9DAwdiK4ZSQkLdRFe0k02F13UbRfTo2RRaPtH8zEIWAvyuMZvXRomh
         /DonBM9p0KaOR+C/XfkieKO9XXG9EhZpsd22fIbkhoqLfRV+X7B1kAHzsiGdq6A/BKyt
         CmHvr+f8+TeWKSLUD1TT+83oqtblSg2OtCrcIKmKg2+lrRgiKWjvQnn64/kScyF/GLNd
         P0ThP8bSTPIHH3cIPt0FLKddRn5PgYPykFFEvYSfVLSPSqkShT2f/9MdE3JF4RlvN6k7
         nck0ohR9gmAgZ0WNdtiOC57WKNDh1d0Swyagd0JovXcHT6J0wE4PQo10uNGw5+WGOcwc
         hs+A==
X-Gm-Message-State: ACgBeo3NRpsu3oYGe/LP0D9vCI0G1VZhdw0x8OSeCzjcZJ7tZET54TX7
        6rJP2fGYkfyTtKsT3oqIsMZcR0xBitQDbQ==
X-Google-Smtp-Source: AA6agR6mL/3prlPOQPzpJzCgrVHKgCOeio2wkX6dkk2PYa+ddmaiTrx7bTioyVdKpdoD66cL7Zx35Q==
X-Received: by 2002:a17:90a:c78f:b0:1fa:e505:18e6 with SMTP id gn15-20020a17090ac78f00b001fae50518e6mr7359010pjb.23.1661329203483;
        Wed, 24 Aug 2022 01:20:03 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id q31-20020a635c1f000000b00421841943dfsm10486587pgb.12.2022.08.24.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 01:20:03 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
        surenb@google.com
Cc:     gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 04/10] sched/psi: move private helpers to sched/stats.h
Date:   Wed, 24 Aug 2022 16:18:23 +0800
Message-Id: <20220824081829.33748-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824081829.33748-1-zhouchengming@bytedance.com>
References: <20220824081829.33748-1-zhouchengming@bytedance.com>
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

This patch move psi_task_change/psi_task_switch declarations out of
PSI public header, since they are only needed for implementing the
PSI stats tracking in sched/stats.h

psi_task_switch is obvious, psi_task_change can't be public helper
since it doesn't check psi_disabled static key. And there is no
any user now, so put it in sched/stats.h too.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/psi.h  | 4 ----
 kernel/sched/stats.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index dd74411ac21d..fffd229fbf19 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -18,10 +18,6 @@ extern struct psi_group psi_system;
 
 void psi_init(void);
 
-void psi_task_change(struct task_struct *task, int clear, int set);
-void psi_task_switch(struct task_struct *prev, struct task_struct *next,
-		     bool sleep);
-
 void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index baa839c1ba96..c39b467ece43 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -107,6 +107,10 @@ __schedstats_from_se(struct sched_entity *se)
 }
 
 #ifdef CONFIG_PSI
+void psi_task_change(struct task_struct *task, int clear, int set);
+void psi_task_switch(struct task_struct *prev, struct task_struct *next,
+		     bool sleep);
+
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
  * memory stalls. As a result, it has to distinguish between sleeps,
-- 
2.37.2

