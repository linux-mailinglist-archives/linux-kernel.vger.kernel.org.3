Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C0E4C1446
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbiBWNgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiBWNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:36:15 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613BBAB460
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:35:47 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso2229090pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2LkI7viyz1bWHFghD3wcUN6xjIn2SITh0BSW72H7QJE=;
        b=PF7dH7sqNAJ9HacLIQRlA6mnOM9sdkvMnuxXQLkTMEwahp6+WGggIC0t7dyDipeldZ
         Yf3hOya4oCl5Svryds5pBTT8I8o7aOjxzpceH/wRgb2Lhv6aZaalwYkUSu6G3VQ6RS10
         9Ld09dma5WbtyThnTQRg19DlD4qP3KHv5nnpqfX4TrlPpVO2bEGRRB7pjaJFFyUnblHm
         bKiuovctMvsBvcZSpBKl4uyLLLzyzBmipAUuuVD2V+8mn+ohrDEFLy6mV/cRfcDK8K3r
         Isi4O1dE9OEQM1xHqq4TdUEXjAxG+dcOdrtFdzG3ggJEna79QBmbYQyPXG2ZW7fF/ott
         UZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2LkI7viyz1bWHFghD3wcUN6xjIn2SITh0BSW72H7QJE=;
        b=aQELMqQ2fQuH1Sp6xVRtpEYZuUcxMr1uVBaPcyDm6xjAgh+FsAeTlP/y7LVWhkqRUk
         eU3RHlHMqGyDwegzGjjMhaH+DxbFx+lX7i9dliGNu0YlMPzZchDhJwjmGK3enS7pqmDN
         YQCj1f0kt7gJ6pYZR678A1dwe9W1UJnABED/ahfbAbFMpKAVdA3ZvUQSd4QQpMQxsdjK
         4IrzjpyS/iUPW8cG2GwhQIXVjIpBiA+XiqhGCoWWH0GDw0j6YUwLYfdp+6Gqsx1XHhX/
         6fgOO7KYgwIv/NDvNNZotrItfxMEdr5TXLN4evpUR828ueLOlIPSVX+OtpdQWl7C3iel
         k6og==
X-Gm-Message-State: AOAM531bvBZBVqSiI+frNfykbUE9z/asLLTvmtEdqXvfUel40ZozIYYe
        x1EOlCc/tg7Osif7yAjzN7o=
X-Google-Smtp-Source: ABdhPJwCO1kq/O6DcCnEWrp3+fmkJgA5BrNsQuDTU2C6eVjvU1X75VXTpD+XBl2IF/OOVG1hz3wOKw==
X-Received: by 2002:a17:902:ac96:b0:14f:c5f2:3bf1 with SMTP id h22-20020a170902ac9600b0014fc5f23bf1mr11659282plr.126.1645623346778;
        Wed, 23 Feb 2022 05:35:46 -0800 (PST)
Received: from localhost.localdomain ([2404:e801:2003:194c:e139:f336:bd30:d658])
        by smtp.gmail.com with ESMTPSA id t200sm21536122pfc.35.2022.02.23.05.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:35:46 -0800 (PST)
From:   Hao Wu <guoyuanchao1202@gmail.com>
To:     brauner@kernel.org, ebiederm@xmission.com, keescook@chromium.org,
        axboe@kernel.dk, peterz@infradead.org, elver@google.com,
        tglx@linutronix.de, legion@kernel.org
Cc:     linux-kernel@vger.kernel.org, Hao Wu <guoyuanchao1202@gmail.com>
Subject: [PATCH v1] signal.c: repeatedly set the TIF_SIGPENDING flag
Date:   Wed, 23 Feb 2022 21:35:40 +0800
Message-Id: <20220223133540.24230-1-guoyuanchao1202@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recalc_sigpending_and_wake() function calls recalc_sigpending_tsk() and signal_wake_up(),
both of which set the TIF_SIGPENDING flag, so when recalc_sigpending_tsk() returns true,
the TIF_SIGPENDING flag will be set twice.

Maybe we can take away the set TIF_SIGPENDING logic from recalc_sigpending_tsk(),
so that recalc_sigpending_tsk() just determines whether the TIF_SIGPENDING flag needs to be set,
and the actual set TIF_SIGPENDING flag logic is executed outside.

kernel/signal.c:175: recalc_sigpending_and_wake()
kernel/signal.c:154: recalc_sigpending_tsk()

Signed-off-by: Hao Wu <guoyuanchao1202@gmail.com>
---
 kernel/signal.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9b04631acde8..6c5a00cd7e9a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -157,7 +157,6 @@ static bool recalc_sigpending_tsk(struct task_struct *t)
 	    PENDING(&t->pending, &t->blocked) ||
 	    PENDING(&t->signal->shared_pending, &t->blocked) ||
 	    cgroup_task_frozen(t)) {
-		set_tsk_thread_flag(t, TIF_SIGPENDING);
 		return true;
 	}
@@ -181,8 +180,11 @@ void recalc_sigpending_and_wake(struct task_struct *t)
 void recalc_sigpending(void)
 {
-	if (!recalc_sigpending_tsk(current) && !freezing(current))
+	if (recalc_sigpending_tsk(current)) {
+		set_tsk_thread_flag(t, TIF_SIGPENDING);
+	} else if (!freezing(current)) {
 		clear_thread_flag(TIF_SIGPENDING);
+	}
 }
 EXPORT_SYMBOL(recalc_sigpending);
@@ -2325,7 +2327,9 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 	 * So check for any that we should take before resuming user mode.
 	 * This sets TIF_SIGPENDING, but never clears it.
 	 */
-	recalc_sigpending_tsk(current);
+	if (recalc_sigpending_tsk(current)) {
+		set_tsk_thread_flag(t, TIF_SIGPENDING);
+	}
 }
 static void ptrace_do_notify(int signr, int exit_code, int why)
2.32.0

