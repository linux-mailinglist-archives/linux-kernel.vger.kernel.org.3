Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3800A523EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347715AbiEKUUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347686AbiEKUTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:19:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2C2239D8E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:19:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fv2so3240537pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gw0Wy/q20wEZd72lzxD2a0cUuCarQEEakePN17Bh29I=;
        b=ErQThYIf24YWagDeM8IZdV77fNmIH8MVxfnwE+zwvUi11262Mv5M9J9uGR9j4Y01e2
         nM/GIe4fwnl7y5kl6kWHmAk+YMuFN2OJh8DjY17hzWWzYxRjMf7qf/bdi3Nkua5220VR
         vB2m10/ou/LIxDWxnxWQ0o2d/HtWPjorXV5oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gw0Wy/q20wEZd72lzxD2a0cUuCarQEEakePN17Bh29I=;
        b=o2jVcy+azypUGZeWIBGsh3Gv2Med2D+07KbcBU8jAhWIK/oALfTbaRgD73J/ORUseD
         ZsbtK/4etBxqDI+J1NBYgNlArocEqNlzyaO1ZmR45ZYINxL+Hccqto+Wembb5FqH0Z3s
         fEdaFon3fD4UOF8gPTn7qToS2qpQPn2w0lIuuMqQT+d3xS1DheYIgwmwPQtk1F3+zAzL
         0yAIpniY2jyQQ5dXTMlG6MHVUrDSsR97tdamoqmt8L0gKbsr1UOMtY4ujmgMo1JOqFS+
         94LMVeWo8vps3c1fhdPp0XbOAGH1OX+t1TU7X6bCbJ1LqoM9jD0qlrNJB+hP/CyQWrTU
         KPDQ==
X-Gm-Message-State: AOAM533x0eqhZOuPu1D2wZasX/AGyHjNW8swc1qXb2+t2wOAQ5t7MdLM
        AWU3Ds/AN7zfn31dKj86DPiPHw==
X-Google-Smtp-Source: ABdhPJwgCPJuzeIZbUoJFQnwWW4mzTiy/xhRt63UDwPNrpwk8vjx7kJz23BXc4wMqpPu1j8rzx43aA==
X-Received: by 2002:a17:90b:3646:b0:1d8:15c5:464b with SMTP id nh6-20020a17090b364600b001d815c5464bmr7264403pjb.63.1652300393282;
        Wed, 11 May 2022 13:19:53 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:193f:f17a:ab0d:1f83])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78045000000b0050dd876f5f8sm2161306pfm.49.2022.05.11.13.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 13:19:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2] timers: Provide a better debugobjects hint for delayed works
Date:   Wed, 11 May 2022 13:19:51 -0700
Message-Id: <20220511201951.42408-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With debugobjects enabled the timer hint for freeing of active timers
embedded inside delayed works is always the same, i.e. the hint is
delayed_work_timer_fn, even though the function the delayed work is
going to run can be wildly different depending on what work was queued.
Enabling workqueue debugobjects doesn't help either because the delayed
work isn't considered active until it is actually queued to run on a
workqueue. If the work is freed while the timer is pending the work
isn't considered active so we don't get any information from workqueue
debugobjects.

Special case delayed works in the timer debugobjects hint logic so that
the delayed work function is returned instead of the
delayed_work_timer_fn. This will help us understand what delayed work
was pending that got freed. Apply the same treatment for
kthread_delayed_work because it follows the same pattern.

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Feel free to reassign authorship to tglx.

Changes from v1 (https://lore.kernel.org/r/20220504223148.644228-1-swboyd@chromium.org):
 * Use counter proposed patch from tglx
 * Deref function pointer to get proper hint
 * Add 't' the function pointer to make checkpatch quiet

 kernel/time/timer.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9dd2a39cb3b0..8637990a3842 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -615,9 +615,39 @@ static void internal_add_timer(struct timer_base *base, struct timer_list *timer
 
 static const struct debug_obj_descr timer_debug_descr;
 
+struct timer_hint {
+	void	(*function)(struct timer_list *t);
+	long	offset;
+};
+
+#define TIMER_HINT(fn, container, timr, hintfn)			\
+	{							\
+		.function = fn,					\
+		.offset	  = offsetof(container, hintfn) -	\
+			    offsetof(container, timr)		\
+	}
+
+static const struct timer_hint timer_hints[] = {
+	TIMER_HINT(delayed_work_timer_fn,
+		   struct delayed_work, timer, work.func),
+	TIMER_HINT(kthread_delayed_work_timer_fn,
+		   struct kthread_delayed_work, timer, work.func),
+};
+
 static void *timer_debug_hint(void *addr)
 {
-	return ((struct timer_list *) addr)->function;
+	struct timer_list *timer = addr;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(timer_hints); i++) {
+		if (timer_hints[i].function == timer->function) {
+			void (**fn)(void) = addr + timer_hints[i].offset;
+
+			return *fn;
+		}
+	}
+
+	return timer->function;
 }
 
 static bool timer_is_static_object(void *addr)

base-commit: 672c0c5173427e6b3e2a9bbb7be51ceeec78093a
-- 
https://chromeos.dev

