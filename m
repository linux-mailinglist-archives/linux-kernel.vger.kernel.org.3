Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3F65B1649
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiIHIH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiIHIHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:07:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E98D5724
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:07:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z9-20020a17090a468900b001ffff693b27so1584942pjf.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=YzUytPikcty1WYKrU+7GKiUQs4mtIiNZsb2UDVO2dPA=;
        b=cWcRXPvbteaUu350jbBJ1g/PJSCGwmK82zACgnDHTH5LgubfzIPeGbysldTJLebFKZ
         GGq2u+8LRM9actV9+0IkIdAqtvm9R8s+AQc3fyMX1h2b5iyEMFYHdlvenBmtXyPUc8gn
         O1f1sjGXGbvpDMy761SXvQ0fwBdY0/lvAWSIV2nOYX1yYbzqPaH3jizZDE5vWlNabKSv
         QX9RHyGJoFHyS5KsfjzSj+7ffrgB0BslhJcHiRSCAK8oVtSOFbRWSNilEPKVB3Tu7zCI
         hND64WxV5ut8VPa2KGYwD1z6gDfMaUK3ypOXJJGJGUAQQaSg5NzyeyGcoUQl8i1mUDlf
         e60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YzUytPikcty1WYKrU+7GKiUQs4mtIiNZsb2UDVO2dPA=;
        b=wEqbBpw+CDUUNLSsZcN39ZgFaNbU+unMBtjCg4fPvtf4Yin1wuMadXK5pCdIzndJ5w
         R5tUDdW/oHVXL0n5pKefvbv6ONthl2Od7W95n+dZF8gk1lf2ivDgO7DkNW+tT15z0kHT
         jFmMRFv6j7ZDBNsqZmMwkI8KS6SmrTeJ4v8N58XfLz/Yhi6219kI575dOuhV1pOkbX9U
         gM/CfHnqbUQsQ9LqZw4ENw07JZrf0zCrKijmpY1jKcPmT8Czpvk7KpVlUAYeyN2TEV12
         l/diy8RccfuGd6H2/h3V0+YZRzIDbNLQZiaLqqElfv80jhSrHImAz4knHINH2GWuXec+
         SC5Q==
X-Gm-Message-State: ACgBeo12SpcrPCyCjDkqvSUHvuJ4xeayvQAOyAcuDEOexwHdtqAqPfDS
        v/VIt2/+vOYJ/tLDomG18NBHoA==
X-Google-Smtp-Source: AA6agR6oCoelnac7U+zYnru+A9arygx//pWUK1YKaWD/Aum5XbxpdRdj3vrRoHUzTEViWitAe/W2Jg==
X-Received: by 2002:a17:90a:74c5:b0:200:2d89:ef13 with SMTP id p5-20020a17090a74c500b002002d89ef13mr2898386pjl.81.1662624439235;
        Thu, 08 Sep 2022 01:07:19 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id c23-20020aa79537000000b0053bbaab3511sm2146067pfp.172.2022.09.08.01.07.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2022 01:07:19 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Rohit Jain <rohit.k.jain@oracle.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH] sched/fair: Fix misuse of available_idle_cpu()
Date:   Thu,  8 Sep 2022 16:07:02 +0800
Message-Id: <20220908080702.58938-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
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

The function available_idle_cpu() was introduced to distinguish
between the code paths that cares if the vCPU is preempted and
the ones don't care. In general, available_idle_cpu() is used in
selecting cpus for immediate use, e.g. ttwu. While idle_cpu() is
used in the paths that only cares about the cpu is idle or not,
and __update_idle_core() is one of them.

Use idle_cpu() instead in the idle path to make has_idle_core
a better hint.

Fixes: 943d355d7fee (sched/core: Distinguish between idle_cpu() calls based on desired effect, introduce available_idle_cpu())
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index efceb670e755..5a76d814f8bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6302,7 +6302,7 @@ void __update_idle_core(struct rq *rq)
 		if (cpu == core)
 			continue;
 
-		if (!available_idle_cpu(cpu))
+		if (!idle_cpu(cpu))
 			goto unlock;
 	}
 
-- 
2.37.3

