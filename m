Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404AD50B9DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448560AbiDVOSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448561AbiDVORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:17:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1E0A189
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:15:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so11140711plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OrTV+vKHG9WRBs5wYVMFlDVclc2ptNVvzr3BSJrgrQw=;
        b=DLUPr3Mrol9s6jb3RZJTqcrKP8CqrkjBoKBR4tINnis9V4dAih4Z3ce8OiJ+Wq+Hab
         8n8POr08CCxV5W51U2pcyDX2nLfw+8ZcXlJQ5knVwCQ7FgvVTL9Y8T/R9HBpXkNMQrmA
         zlCDnzU/AOCwzkZGH0F8sFLiXPZi6b8qaBarhEdwL4E49vK4H8jdfnq2MsFRgxkJSHJF
         bDiJHAijIykxyUvXXCA5VW1aGsIQYxyNa+Rcu3tM6D8YRT7Da3hWHAhNE9DPsHTiZbRY
         e6/tPyh4HAU6BPutD2bg4ZQv8vl+bSWWyecmJw2xKfvNwydr0UzJVXHlpjIojkHPYmA+
         w7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OrTV+vKHG9WRBs5wYVMFlDVclc2ptNVvzr3BSJrgrQw=;
        b=YEwO0bno/6FWmlbueYxlII0PJ1j75xfVaoUGV6m9ivDAyzbYcxDbabxolSYGWAbAAf
         IUZhA6qfebjxEo/iJhBbWLT7fRTloOseGQ/ON3POpQXO/R+FFOX9vOPhe8NshcuH5fMI
         mY8pQCPB/eh+dCPQjzOmFmuQ/6KqIYmsimtiExvkXZIkugQ/ttCFBqkgz8/PeBeZsN+Z
         rbZ4Bn9kRYEhJppl+jEWG1Xp20mkzIegG9h+COFO7LppT3euAGhvpUPwatYgDMD8JajA
         kzaQif6Tum2zpZ8nfgvpvF1sV0OrcxFJRpuBU40ih1ftWDhHN4mPXyNDgIpKz6v91iCo
         IXOQ==
X-Gm-Message-State: AOAM532MoHZG5UJMRW4uEqoBHK5+HV391yLKGVIo4U/CE506s7K0vkG6
        ejJ+kxs+ilczIJu5kuF6wn4=
X-Google-Smtp-Source: ABdhPJxbucRQpRtBfAtKgiD4p7RWXqg/vYMGxckPmzgSbfRkbwJoeF8x2zTyLe3nPyaqonO8URY1Tg==
X-Received: by 2002:a17:902:ce91:b0:15a:46bf:e629 with SMTP id f17-20020a170902ce9100b0015a46bfe629mr4906042plg.118.1650636900735;
        Fri, 22 Apr 2022 07:15:00 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id gn8-20020a17090ac78800b001cd4989ff70sm613507pjb.55.2022.04.22.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 07:15:00 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>
Subject: [PATCH] timers/nohz: Low-res tick handler switch to ONESHOT_STOPPED if tick stops
Date:   Sat, 23 Apr 2022 00:14:46 +1000
Message-Id: <20220422141446.915024-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tick_nohz_stop_tick() stops the tick, the the clock event device
is not put into ONESHOT_STOPPED mode. This can lead to spurious timer
interrupts with some clock event device drivers that don't shut down
entirely after firing.

Eliminate these by putting the device into ONESHOT_STOPPED mode at
points where it is not being reprogrammed. When there are no timers
active, then tick_program_event() with KTIME_MAX can be used to stop the
device. When there is a timer active, the device can be stopped at the
next tick (any new timer added by timers will reprogram the tick).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/time/tick-sched.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d257721c68b8..da1a7efa45a4 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -928,6 +928,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	if (unlikely(expires == KTIME_MAX)) {
 		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
 			hrtimer_cancel(&ts->sched_timer);
+		else
+			tick_program_event(KTIME_MAX, 1);
 		return;
 	}
 
@@ -1364,9 +1366,14 @@ static void tick_nohz_handler(struct clock_event_device *dev)
 	tick_sched_do_timer(ts, now);
 	tick_sched_handle(ts, regs);
 
-	/* No need to reprogram if we are running tickless  */
-	if (unlikely(ts->tick_stopped))
+	if (unlikely(ts->tick_stopped)) {
+		/*
+		 * If we are tickless, no need to reprogram, so change the
+		 * clock event device to ONESHOT_STOPPED.
+		 */
+		tick_program_event(KTIME_MAX, 1);
 		return;
+	}
 
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
-- 
2.35.1

