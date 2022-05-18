Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A7E52C2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241641AbiERSuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbiERSuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:50:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8732EA17
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:50:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ck4so1275885ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqI2+xUvKnWcIdSP6yP4fejkeLxIn1EuNN3syEENFFE=;
        b=ku0RmPMoWqvIQqEw7XKved+GSKuUfRade7blj4kfDUDuPWoOiPGgOjCbSoHSzCn9R6
         S+HsJ3PMaJ9qIpGRIkp7qCyCRFU5BjNDyAeg9M0u315lzErTSZ/wqPxH6ibHPU65aM6r
         xhnKdhx7o+yN4xzdu+2R62ATJrYY/NZYGtfSmZWP0EYGzEpvzlfiaVrk5/0FP8bYyv0t
         s6yPe5UT6mwoaKnLahx7w0IotyxuMnwFWjjF9Kt5LZjjFnx8mafw3rso8GVCTkIR7oSY
         YadjW6svAKOLhv8NH/AhtzAPr4a3lOTFpDZrNSYuy+FGoHayRF2qqEAMQMbNwhzAho+X
         vlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqI2+xUvKnWcIdSP6yP4fejkeLxIn1EuNN3syEENFFE=;
        b=l3s85XCc7vtiB5ADlOHlwhMnSI+d3WpaPxy7iDFboDtcoVlj7dfTOVN3rld23u8tjh
         pqcvCWc4bNzWUcyf7FGwnvY6vjwWn0xSRsxqH0d8y9hhx5HafvXD+rJVZqGklPfEWZTr
         YWkiBk3uWFhKRC6U89eqOIsO5UJoz7kbYKKoIINsEZ9lsPcgHVKHiIw/pTIWrLa84JH0
         aMs/Z82KeF16epJTqXNyFxQPeXJNamrD+/TqCeZkilmB/ssuBpnPkudqwOAjgzHnKZy1
         aqTPILad1/jXh8mUbMJVsa8j+HiSaN7GTNU1JaegrEFeEEwhGopwyws6S6TSbY91TPiz
         svPg==
X-Gm-Message-State: AOAM5310gCmh9WsrRBCMVIwamc44XzjEFL41OAh4Ha9XRRZwinC3qakE
        4OU3+igEXnc1jXwtg28zGGTuxAPqDn1/kw==
X-Google-Smtp-Source: ABdhPJwVRPW7HZvyZ26jxm0P3qXxTBvjoAoK5+NSeQQ+iz1Mg9/hFPy50tr8cQrpXctlskSrLqzFYA==
X-Received: by 2002:a17:907:1b0c:b0:6fe:25bf:b3e5 with SMTP id mp12-20020a1709071b0c00b006fe25bfb3e5mr844547ejc.689.1652899811358;
        Wed, 18 May 2022 11:50:11 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906008400b006fe8a4ec62fsm961343ejc.4.2022.05.18.11.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:50:10 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH] sched/clock: Use try_cmpxchg64 in sched_clock_{local,remote}
Date:   Wed, 18 May 2022 20:49:53 +0200
Message-Id: <20220518184953.3446778-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Use try_cmpxchg64 instead of cmpxchg64 (*ptr, old, new) != old in
sched_clock_{local,remote}. x86 cmpxchg returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
---
Patch requires commits 0aa7be05d83cc584da0782405e8007e351dfb6cc
and c2df0a6af177b6c06a859806a876f92b072dc624 from tip.git
---
 kernel/sched/clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index d9272d9061a3..e374c0c923da 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -287,7 +287,7 @@ notrace static u64 sched_clock_local(struct sched_clock_data *scd)
 	clock = wrap_max(clock, min_clock);
 	clock = wrap_min(clock, max_clock);
 
-	if (cmpxchg64(&scd->clock, old_clock, clock) != old_clock)
+	if (!try_cmpxchg64(&scd->clock, &old_clock, clock))
 		goto again;
 
 	return clock;
@@ -349,7 +349,7 @@ notrace static u64 sched_clock_remote(struct sched_clock_data *scd)
 		val = remote_clock;
 	}
 
-	if (cmpxchg64(ptr, old_val, val) != old_val)
+	if (!try_cmpxchg64(ptr, &old_val, val))
 		goto again;
 
 	return val;
-- 
2.35.1

