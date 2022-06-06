Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C8953EC7B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiFFMYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiFFMYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:24:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21E124E1E9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:24:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j6so12546793pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 05:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYpS9cCZe4FR4oc/36kZaTPU77Nit6eHdNRaR5Virrc=;
        b=ZWoYsq1LxjMhfuXkA5IQYKmqfkRcwu6cgLcvwGKJbjmblTsvdiXpTqz9PKNCvNaGwn
         O1aMO1vDjKM7yjozytN4W5opvvBkQSWfPNaGTabDBKXWCJloEiumZ/2n8eum0vJcsl3P
         Yf0WAUOyyPf6kd6BIhGVHqJh43chJbGFEkiulDComCUDhVxpzzyOBv3eq2FGLYc4ryEY
         0SH/AgbTHcM/nmSm70uNpBhJfrAMXHodUlOCkoC/TvnCNt0NHqYzQSwvjdVOuQWDGmwB
         qdKxMebiVTF/4qAL9TC/s7eXKlqJVfhuioAU8zECi/qQVoOm8UGQEqeYmAzZ2ZLTTzQC
         iO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYpS9cCZe4FR4oc/36kZaTPU77Nit6eHdNRaR5Virrc=;
        b=OfDAdTQgfuAMCGkcPZbmMvh5vYK+peA5u3qc6pyQrTtJqrzL3yFXr8Ee04oKTWZ5/S
         HzbpFFlo+Ca3lnLqhBWdfUpZmT0oazypjg+kwmwCJDvbxsCcOsLczAp6TqReUnouEu/O
         RogpjlMjZLWLHXwTyEyErL8i/rJ2UkDKV++NDwTST8wLz3DH8I5N+4angHM4HX8eDf5J
         vt5j5v8CjozHPJwvedrVaVw6WKo/2PbliDTjcHxLaI8qrCdSZXHzcJE1enPqinWKPyji
         6Skf+0nJY+4o56cfpa1qGD/6OEzD8QWkTj2oIBWBi6HiTFY7NO8/0eYIrm6ayzCBUl9W
         TlaQ==
X-Gm-Message-State: AOAM531gW2PpZAdAYEGvq6H04xgTHt8PJ50ABpt40L5GABT/jqWI9r7m
        yS7OaoMk0//jqGyAadpHd2rv/2xZz6+XMQ==
X-Google-Smtp-Source: ABdhPJxxBpQ8X5nfUg/kDSJxFBf/CoG1q5oQrYT5M0W8MtVrlIgei8a8UGrHM2Hm4JNZv6X+g7I+RA==
X-Received: by 2002:a17:902:c941:b0:164:14cb:ce5f with SMTP id i1-20020a170902c94100b0016414cbce5fmr23554092pla.127.1654518266749;
        Mon, 06 Jun 2022 05:24:26 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7850a000000b0051868418b06sm8449860pfn.35.2022.06.06.05.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 05:24:26 -0700 (PDT)
From:   Huichun Feng <foxhoundsk.tw@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org (open list:SCHEDULER),
        jserv@ccns.ncku.edu.tw, Chin-En Lin <shiyn.lin@gmail.com>
Subject: [PATCH] sched/fair: avoid redundant hrtimer check
Date:   Mon,  6 Jun 2022 20:26:12 +0800
Message-Id: <20220606122612.2580930-1-foxhoundsk.tw@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The check is required iff HRTICK is enabled and DOUBLE_TICK is disabled,
avoid the redundant check by adding corresponding sched_feat() .

Signed-off-by: Huichun Feng <foxhoundsk.tw@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9..80cc1a924 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4668,7 +4668,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	/*
 	 * don't let the period tick interfere with the hrtick preemption
 	 */
-	if (!sched_feat(DOUBLE_TICK) &&
+	if (sched_feat(HRTICK) && !sched_feat(DOUBLE_TICK) &&
 			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
 		return;
 #endif
-- 
2.36.1

