Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880B64D9692
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346112AbiCOIpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346099AbiCOIpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782434CD7D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q20so10770155wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3w0JyGhW5UbKaWUJ77X5B22PP7tPslG3inU2Ek4fp5k=;
        b=XUw5zKpUJIbkciEzU5+6TXccQc9QeqIBID8GeIoKRF9kL688uLSXgx8mYXXXlueleu
         HWs+CZMJSMTyBO89SgMpkAslAMBzjhyyOY5I0+suqnIxffo0nUcx4nUflAlUxd+AHwwB
         tZR+fpVEK0/HSE0vHzBd7NwJgR2GHgYWbhKwBIDOHTRANIc1Xqln3zyEDSp333zCwdpL
         nGOsq98AM7TCeY3i/+hcCG67NgsA1dG1MOUCD0sLnhPHqeaNM3T5qWfVRhbZp1gDi6jj
         y/fisX7BMWei/HKzmvbaUaIwqw6XlW3Qg895Z/ZBfoEbst2er85oSWCraIKKlMRwP6Um
         +8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3w0JyGhW5UbKaWUJ77X5B22PP7tPslG3inU2Ek4fp5k=;
        b=r0C/yHgFOSWr/fMHUK3neqnShTdppVXV2LOVoVzI/5PxxNFyWENwztpgQolg7cYKkG
         dHZhn9u++zlByb5p/TxJ9/Z2KRQEClT09aW4gyXIhLTbPsXWHtb/yLygmafBGpBACCmn
         hXW2d01d5AEhbHuAwF8esLPk1kOzRpARfqBfNe6KjB2mX+NHa/AgIcWr9Rt99XByXGLq
         hihZ2c9/jpJNgfRSxnl08/3bDWrv9aBuEZ6cW8C/b3V7rGU9m0mp4SimVlIqn5OLGRci
         MmkB+j4EjqU/t0DnqttzR3VQXgEalmZyhYezBWEDE0zQtmcMw6Dmjj4kHyRaX5EI2twd
         XJ0g==
X-Gm-Message-State: AOAM533x3vtEFPlpTs/qWfmuhEPPGhA2oxhCSot/i0FExJWbMC/Lx2hx
        0XJ0lHIYeJkT46JB7Lqe2Wd84hDJxEM=
X-Google-Smtp-Source: ABdhPJwR6/iTgf98Ily85ocKNN8hRpNNA+QrYWv1c9xMnSdBOb1iG2G37/26eOWo8JMIpL9Ly/+oGA==
X-Received: by 2002:a05:600c:3b13:b0:389:cf43:da5f with SMTP id m19-20020a05600c3b1300b00389cf43da5fmr2320532wms.201.1647333831802;
        Tue, 15 Mar 2022 01:43:51 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:43:51 -0700 (PDT)
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
Subject: [PATCH 03/15] sched/headers: Add header guard to kernel/sched/stats.h and kernel/sched/autogroup.h
Date:   Tue, 15 Mar 2022 09:42:35 +0100
Message-Id: <20220315084247.40783-4-mingo@kernel.org>
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

Protect against multiple inclusion.

Also include "sched.h" in "stat.h", as it relies on it.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/autogroup.h | 5 +++++
 kernel/sched/stats.h     | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/sched/autogroup.h b/kernel/sched/autogroup.h
index 90fcbfdd70c3..90d69f2c5eaf 100644
--- a/kernel/sched/autogroup.h
+++ b/kernel/sched/autogroup.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KERNEL_SCHED_AUTOGROUP_H
+#define _KERNEL_SCHED_AUTOGROUP_H
+
 #ifdef CONFIG_SCHED_AUTOGROUP
 
 struct autogroup {
@@ -59,3 +62,5 @@ static inline int autogroup_path(struct task_group *tg, char *buf, int buflen)
 }
 
 #endif /* CONFIG_SCHED_AUTOGROUP */
+
+#endif /* _KERNEL_SCHED_AUTOGROUP_H */
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 3a3c826dd83a..edc0d13fc61b 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -1,7 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KERNEL_STATS_H
+#define _KERNEL_STATS_H
 
 #ifdef CONFIG_SCHEDSTATS
 
+#include "sched.h"
+
 extern struct static_key_false sched_schedstats;
 
 /*
@@ -298,3 +302,5 @@ sched_info_switch(struct rq *rq, struct task_struct *prev, struct task_struct *n
 # define sched_info_dequeue(rq, t)	do { } while (0)
 # define sched_info_switch(rq, t, next)	do { } while (0)
 #endif /* CONFIG_SCHED_INFO */
+
+#endif /* _KERNEL_STATS_H */
-- 
2.32.0

