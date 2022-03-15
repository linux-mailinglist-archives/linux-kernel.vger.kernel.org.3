Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADF44D9694
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346162AbiCOIpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346091AbiCOIpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E591EEC5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d7so757224wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrlnakmn5fLlGT/co3zd6+O92fe3JgVqL1zsEXzLWMY=;
        b=ekiKDaiPvPmyaAHma2KjNi2hG70kvvZHOu0AyAI+rcQ0NFHAUd9FTfE1W1n4NKORwv
         Ca+W+ConXG7ciFXJIbfopOHifeisT3X0U/fxljw/6xuI4RaLipQJreuQM9qfubp/pgnG
         a4XcQ9sWQm5E3/zxBYwNUlpyHpGkEf6qagmjy3+RxbJzO8m2Qs9MBQmsshMMsTrvZ5s9
         1XxhuW9tqW5Rp5yagzoO26dlL7Q7/WxbJjVuyfaCPRq2AewGqXDRVEvExRh8Gslpj+YH
         45TwrpgqRll3c6QYeMEMC4mnrDyTUJSvNEOKQccGKfL1pOLP0u5WhvOia9ljKdpilQXP
         Peog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vrlnakmn5fLlGT/co3zd6+O92fe3JgVqL1zsEXzLWMY=;
        b=CnwEhpna9IuLfz4qJmeMtIRoHxL9QJkl7eddF2RAh5hzQSd/b+CRyuajsTZz8zk948
         9ghXG91kWfqxZUtkR1hVb9yodihkfWu7JBMENbAJc/1j3absGqHOR74Yv8ppcqy5m34i
         z7iu4D2yyM4lsKgECFCw7Wgd13C4GSKMUDUNvLNT4LqMXSDqDyy6lPTqUZrv/zq4N/GI
         rE7rEhoLux01dBoN8OhYA2TGChrfUAIf67F0UHFgRNWXZR2jxuTBWBfweweHbv9rLq4i
         imNtXtsFePzhArhqxScOo7ED/5ivbvettYgbX7QKNze2X9hSS9bVk/dMWnXRPJS6UCc4
         be5Q==
X-Gm-Message-State: AOAM5326MgDqFvjQgRLLhKDJW2QlYmKtP273boP31ASH6zZG4ggzPTz7
        Y/aS2BUBReV3srjUCwH4y3sEFVXt/EY=
X-Google-Smtp-Source: ABdhPJzQ+XVKQ/F66KPlrLtzGhy9sc21PAGcwHUkbjZgYcq5BBa2K8solVtOhiURc+kyN9CiS+7GoQ==
X-Received: by 2002:a5d:6c67:0:b0:203:bf25:f311 with SMTP id r7-20020a5d6c67000000b00203bf25f311mr5452652wrz.108.1647333836233;
        Tue, 15 Mar 2022 01:43:56 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:43:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/15] sched/headers: Make the <linux/sched/deadline.h> header build standalone
Date:   Tue, 15 Mar 2022 09:42:39 +0100
Message-Id: <20220315084247.40783-8-mingo@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220315084247.40783-1-mingo@kernel.org>
References: <20220315084247.40783-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header depends on various scheduler definitions.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/sched/deadline.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 1aff00b65f3c..7c83d4d5a971 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -6,6 +6,8 @@
  * NORMAL/BATCH tasks.
  */
 
+#include <linux/sched.h>
+
 #define MAX_DL_PRIO		0
 
 static inline int dl_prio(int prio)
-- 
2.32.0

