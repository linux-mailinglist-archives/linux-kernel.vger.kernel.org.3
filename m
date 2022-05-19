Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36EF52D9EC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbiESQMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241083AbiESQL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:11:58 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCABAFB1D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:11:55 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p74so2639117iod.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z9JuQdbnyix/Cw2s/uS/02pnjmPQ42SuLyLty1YjLH8=;
        b=Aa841zG4DYWnqVq5zJHLVf9PcPp8NoKgOR8vVxN68li1B198TGkNUKfJDQDPqq3PKF
         9auRyny2CyM0KAeiww1FQQGBl7uh04eAyUO8LDra0c4R69+3DCcpNw9vcyxjrkXwh6FH
         3u8GKzljCq+yRdESJki4sDv1msi3XokEKEgQx0y4B2KMkDmXuAEqAePA0lfp4I7BJgKF
         ch/EaBfy8ujyLEOOK7eXG6grUpIGZ5Dfuak53cjVJ4w9XaXpRWDTCyxQCYyK+MbwBYUo
         L9U4QhjPxExwRhkXneBV5PeyVWZWFwR0AwdbQu19vjfm/V3J4cdxg4jMA7jXNsGQuMyN
         1OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z9JuQdbnyix/Cw2s/uS/02pnjmPQ42SuLyLty1YjLH8=;
        b=rPcdPdXRP/TKKmN4gdGolnREHYuZ6VuZ4csIzb5t0yXXlel6ZN+PGUTBj4IAQdBwXb
         9op4vQJPi6Fg3JXLfgjQjmLUdGGH5KXjU6A1gsqcxLdmuVMzYVUqxQ17aHvZQFileRqg
         eLmYrSzWecg2bGJFF0bC9hnGKWKl7Thh9QJzAZR+vJ0S0MatLMFZn/QjrlDqzHsOGvOE
         V20THEZk2Aexm/6THgo8crLP3ZSleOOPv+7+k9w/p+IcAKMplFzMqEF4hOmYMvUeZtfW
         ZqVqRmipHMgibkYVI/OJQPgl1/4g00eIb0Asl2SIZRDq4KSzeKnQH1rDzhX4MSfO3PV4
         nT4g==
X-Gm-Message-State: AOAM530wyUul0p51wsVCgFZdHRsIK1rt7VFha9AZk32ew83YvvitoHed
        DStX2miTQtiCdzNDEmmnBAQ=
X-Google-Smtp-Source: ABdhPJwWqjwfIJd8j6I/+9ff9Vz6fKNxGW4RFWDoJajx/RLpilS9EvjwcwZailmSGC+66ruuR5yL1g==
X-Received: by 2002:a05:6602:1501:b0:65a:c412:2eeb with SMTP id g1-20020a056602150100b0065ac4122eebmr2811315iow.29.1652976715359;
        Thu, 19 May 2022 09:11:55 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id g8-20020a05660203c800b0065a47e16f64sm823862iov.54.2022.05.19.09.11.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2022 09:11:55 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>
Subject: [PATCH] sched: Dump stacktrace when some task failed to stop
Date:   Fri, 20 May 2022 00:11:25 +0800
Message-Id: <20220519161125.41144-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

Some processes may not be stopped, such as workqueue workers.

Add this dump_stack to easily figure out which process caused the problems.

Before this change:

<4>[  517.545889] ------------[ cut here ]------------
<4>[  517.545901] Dying CPU not properly vacated!
<4>[  517.546366] ---[ end trace 0000000000000002 ]---
<4>[  518.546831] CPU6 enqueued tasks (2 total):
<4>[  518.546855] 	pid: 49, name: migration/6
<4>[  518.547010] 	pid: 6231, name: kworker/6:0

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 53596842f0d8..de6b5320e4d7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9416,7 +9416,14 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
 			continue;
 
 		printk("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);
+		if (p != current)
+			sched_show_task(p);
 	}
+	/*
+	 * We need the stack of each cpu to analyze who is blocking the
+	 * current cpu scheduling
+	 */
+	trigger_all_cpu_backtrace();
 }
 
 int sched_cpu_dying(unsigned int cpu)
-- 
2.24.3 (Apple Git-128)

