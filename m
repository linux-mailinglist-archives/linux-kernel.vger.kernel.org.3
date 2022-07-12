Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4F571467
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiGLIWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiGLIV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:21:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A842EA5E41
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so10678888pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPCKm2gvds2lzYICLyS9Zh4eZd8vzB/7YXbaR5AiWlU=;
        b=UDYGJcUnyrLKSaNyp+xCZcL78T71vqVdok+I4gDUp2YoeH8l2Jy9VbsqZiNUqN3oG/
         DC/URdM8RLJtJaiExWX1K1mvXC2FKtHenFA/Mn0QwTdKA/nrpA5Rfm+8ICHAXB6tfJKx
         +FXQcoX1GIf/iqNy6+LRuW2ySoNDTI+94dmiAzHH0UkLY/AIL9cqHBtbDWsCUYwn0npz
         NoESXMEIfQYWgotxBh7wc7UP9w0YtMInEcxvfBYL7rdOIWMll98b1FqaaEvt4xJ0zlJS
         s67mSkZsvNdWS99YeEjPIm/oxaXyScceiYokNnIbKybpRaV8jN2bmJ1Iur42bqet1Bjz
         C25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPCKm2gvds2lzYICLyS9Zh4eZd8vzB/7YXbaR5AiWlU=;
        b=2+b6DBq5QEDo0l11s7nC5WaKAIH85jiRx8v+QQSpqBoiUXk/hom+JmTYKnPmoREEGt
         dAkYCeWlBk85CFWNIp1egti5wJXVJY8M6cbY6WE182lI3GrEuQgrYca9sauV4hMCfAuk
         PaCmRsIC9zGBcdRelMKe2BNiy77IYaQhY5kJwVi27YldfU6V/W9VEtApTod07CoXE9ER
         jUZYMQd9fHgU3n56igCOjPIaXHjBhze8PROJ9UEGrKZNSDLfEFHVfzRPynbzVc7o95gS
         PWPQHq5U4UUH58WjZjc0PVGuyUkYkLjbEeXd2CQ3MdSwsi9G+szBxXNEG6kX8d4R3hbE
         zTGQ==
X-Gm-Message-State: AJIora9o9G1HwVy4XEz1eqphv1RhCP9c+R52YkyRIL2Uum2o0mjpBEul
        0usnnj+qa8axyACzEAN5YYUM0g==
X-Google-Smtp-Source: AGRyM1tz42o+WaTRfkEaUNwlnpnYrB+aHELcH4+k0om9CWtRYZ0yw5NlBrTUrmE96pex26mOLNVhhQ==
X-Received: by 2002:a17:903:244c:b0:16c:594b:3f4a with SMTP id l12-20020a170903244c00b0016c594b3f4amr3429526pls.145.1657614087265;
        Tue, 12 Jul 2022 01:21:27 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s13-20020aa78bcd000000b0050dc762816dsm6114428pfd.71.2022.07.12.01.21.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:21:27 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH 4/5] sched/fair: avoid double search on same cpu
Date:   Tue, 12 Jul 2022 16:20:35 +0800
Message-Id: <20220712082036.5130-5-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220712082036.5130-1-wuyun.abel@bytedance.com>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
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
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0d7e8555bcf9..e4cf000604fc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6344,6 +6344,8 @@ static int select_idle_smt(struct task_struct *p, int target)
 	int cpu;
 
 	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
+		if (cpu == target)
+			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
 	}
-- 
2.31.1

