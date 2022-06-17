Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2178654FEE1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383345AbiFQUiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383390AbiFQUiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:38:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08D863BE1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:35:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t2so4798049pld.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toNPfokVsgpWONr2nrnveVXsAIARagbl/IUuAv+O4Ko=;
        b=hA+xaGDwz54dAM0uqTw8TgGCOp4oewGmrxN4W58mj3Jj8V+J1xNsmcbjPNCCF+qq5Z
         OlxHwucZBYHT30zzkQiKbmLZr0h1SVL/ejYRJ+49nEAIw/doxPbBd6IFqiDv4i5FqawV
         oh+o29Lk2prczgMeHDSNDZOJFFX8PJisloExU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toNPfokVsgpWONr2nrnveVXsAIARagbl/IUuAv+O4Ko=;
        b=nAI+nxL1GkTK2/B8j2JAlUMz/cDrTL29edqtgI0ourDew0EcRKI8tHLDKaMmZcTzhk
         MJSBDL5pjx6xWPLx0YSnbefx4sDecEQmXnMYzmBeJMvDYWxDoEclG419qyOPU+PAUXWr
         js8fGbv4w0o3CVi7btAeTpAYe5G8OVOuLchxExyMrg8jTeBn9sHRsMP8xxXEC5Mn60wn
         28F31k/jSboPc5Sr+ZJVM1e/y/FrWik1feoekBaszI81Gf4CXu67i/6TLXajcj1bmV4i
         c7AfCxkP4ccIBv40lywMOCh+9udXVsdzf/VGIhWzr7RkCejbMI6qsxFgUnUfbGzWsgKK
         zBVg==
X-Gm-Message-State: AJIora9sYKlGGhtEUuIdvGL5RPBd8FGpRuSHl+KRJFSjmb3PRiuqhIE6
        SWH/kMdurP0kbo7yfZSWneLZFQ==
X-Google-Smtp-Source: AGRyM1s4LTTl/PO7+dD7Kb+dA+AF1YO8I6lc1HVN6LCSrUnvzHe94BwYRXGRZQch6T90n0fg6mtMeQ==
X-Received: by 2002:a17:902:c411:b0:165:11ed:9287 with SMTP id k17-20020a170902c41100b0016511ed9287mr11524546plk.110.1655498102879;
        Fri, 17 Jun 2022 13:35:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6844:cedc:a28c:44b2])
        by smtp.gmail.com with UTF8SMTPSA id m18-20020a17090b069200b001e2ff3a1221sm3609810pjz.33.2022.06.17.13.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 13:35:02 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] sched: Drop outdated compile-optimization
Date:   Fri, 17 Jun 2022 13:34:58 -0700
Message-Id: <20220617203458.275319-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this exists from way back in 2011 (commit 095c0aa83e52
("sched: adjust scheduler cpu power for stolen time")), when there was a
little more aggressive use of #if around these variables. The comment
mostly serves to confuse the reader, although it may arguably apply to
the (excessive) #ifdef CONFIG_HAVE_SCHED_AVG_IRQ.

Anyway, the #ifdef is not needed, so drop both the comment and the
"optimization." Any modern compiler will realize this block is not
needed (for one, update_irq_load_avg() is an empty function when
!CONFIG_HAVE_SCHED_AVG_IRQ).

Confirmed on:

  x86 gcc 11.2.0 (Debian)
  x86 clang 13.0.1 (Debian)
  aarch64-linux-gnu-gcc 11.2.0 (Debian)

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - drop #ifdef too

 kernel/sched/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bfa7452ca92e..eced503aa670 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -679,10 +679,6 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 
 static void update_rq_clock_task(struct rq *rq, s64 delta)
 {
-/*
- * In theory, the compile should just see 0 here, and optimize out the call
- * to sched_rt_avg_update. But I don't trust it...
- */
 	s64 __maybe_unused steal = 0, irq_delta = 0;
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
@@ -724,10 +720,9 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->clock_task += delta;
 
-#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
 		update_irq_load_avg(rq, irq_delta + steal);
-#endif
+
 	update_rq_clock_pelt(rq, delta);
 }
 
-- 
2.36.1.476.g0c4daa206d-goog

