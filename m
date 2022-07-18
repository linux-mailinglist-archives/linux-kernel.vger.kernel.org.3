Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C8E577EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiGRJuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiGRJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:50:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8462FE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:50:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id g17so8539057plh.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IskrYUTwZ5u1ebt19AyhEL1vhoFuS3Dpla4INxfY6cs=;
        b=bFSDWuWZZmzQ2zV37AFBRmxqzduFyTinMbFnWlSaWenaGE0D8fl5aZ+cEWvVTaL/jt
         s+STrrUcxroQaW4PtgtKgdzBJ4yFOrxYV2OgYPp+xlfh9MfTVdIhecroEIfagALilGIT
         ou5LZRPc4iVmsHBiimQTs+3Go6IgDjl2RIE2B1sGWKJzjicMVJNFfhObLUuy41FlB+3/
         1JdjAtFCgRtaE3Z/Pidle5j/mYJxsCLXVgOOuteCnkr4GsSkFuuYqlltmr1c0J5wMhM9
         5qIp6Bwhx7XFgvv7A/BHtUbpqjhIunqpA2aKf+OTULzBsiA8Fj61a/253sM95QsE8JOf
         sizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IskrYUTwZ5u1ebt19AyhEL1vhoFuS3Dpla4INxfY6cs=;
        b=m7AMJjIwh4d4brxcsk6xQG0jlm/Qn2twsypJm7xg63ZrmcjpgmrBGs3OraEoCfMe5e
         pWgHVQofIbB2nasILLDgGhz5KuMCYkBCFHTXhHrnJU/rndw6Zf9MYOjzDNBc4RiyIJLf
         ppEObNcftkHsP7p5VCEEHHwYqYFPinVe1MBM1sXvP/D2WL+JDZktz8Kgp3O+b3emF4Yz
         Xakvtsqf/ZC5HzPtLS7A6MklDlEJgmfeM3JkPiOnSC9CfgLNi3PzVZy30aX0kePT2uHn
         Ylh5W2kovMfH8TXodt0A0vf/JsciJDbW8TvXW8qAdENC7LKDX0ZJwlv31xh66GsF9cNa
         oMTw==
X-Gm-Message-State: AJIora9Px4xkW1zz+OPpU75KOE6U2jLs/GKnwO//8Ec9Yw84m+5870Gs
        04WwyyDHlYKPCiS4MI/ABv6aYA==
X-Google-Smtp-Source: AGRyM1uhCBFo+SfoWW8MQ4va92GFl07kKEJOEHPfIKPXAsNsPdg3M8sDyGbPv4t1bjXUZo73d0i5HQ==
X-Received: by 2002:a17:902:8505:b0:16c:cf05:dc59 with SMTP id bj5-20020a170902850500b0016ccf05dc59mr15012860plb.125.1658137800349;
        Mon, 18 Jul 2022 02:50:00 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b0016a111c83cdsm9072679plg.119.2022.07.18.02.49.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Jul 2022 02:49:59 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com,
        linux-kernel@vger.kernel.org
Cc:     "zhangpeng.00" <zhangpeng.00@bytedance.com>
Subject: [PATCH] sched/fair: optimize entity_tick()
Date:   Mon, 18 Jul 2022 17:49:37 +0800
Message-Id: <20220718094937.37360-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "zhangpeng.00" <zhangpeng.00@bytedance.com>

entity_tick() will be called to check preemption by calculating each
sched_entity's time_slice in a task group tree from bottom to top.

If a need_resched_flag is set by a checking of a sched_entity,
there is no necessary to check preemption of the sched_entity's
parent and ancestor entity.

So we can test if the need_resched_flag has been set before calling
check_preempt_tick() to avoid unnecessary calculations.

Signed-off-by: zhangpeng.00 <zhangpeng.00@bytedance.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a78d2e3b9d49..ee23afe22ac7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4757,7 +4757,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 		return;
 #endif
 
-	if (cfs_rq->nr_running > 1)
+	if (cfs_rq->nr_running > 1 && !test_tsk_need_resched(rq_of(cfs_rq)->curr))
 		check_preempt_tick(cfs_rq, curr);
 }
 
-- 
2.20.1

