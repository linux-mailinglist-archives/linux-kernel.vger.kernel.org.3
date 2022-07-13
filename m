Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68625572F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiGMHut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiGMHuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D574B313A4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657698643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UUUAyRjzYTQJMt+N0hTGhBJ/lch625duUKNPGtSQaX4=;
        b=RxKzGtlFqBQxL5g6hDySHpSI/8Cl1YWx4VuZMX2h6VXuHyroT2tJkecROBSq98L/uAhz+1
        1/DaDd7udqJWA5pW8xTFutbqkt+50hA3wnwXpE4bmmMIYGA++dxrvZQn5g3ueEjG3UfNYk
        YLi5PFRVYn65vZ7zs5G53O+5nOwNWYA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-bTeqqciWMX23RezB32E6HA-1; Wed, 13 Jul 2022 03:50:39 -0400
X-MC-Unique: bTeqqciWMX23RezB32E6HA-1
Received: by mail-wm1-f70.google.com with SMTP id a6-20020a05600c348600b003a2d72b7a15so711421wmq.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UUUAyRjzYTQJMt+N0hTGhBJ/lch625duUKNPGtSQaX4=;
        b=yi28+s1tmAsSZ97VJIiC6gmg9VZqHIf6YGrNugJtBUEzd13wlMzPueaMnXTqgGNIjV
         1wEWMaA1asVhIzXMKOxhCDYhXH2kGDT58PuUpK00LLQEf62mQ8Ni1N3Z8FzYiut3CkQH
         ot7de1Ud8IH3MLLulesaJ1XSuZQAG+eiSJlw4qliADLKCa0BkpS2MwEZvXjflFxdhBn7
         XqriN3KIwjzhx9H5vzgLWqLaaY+aNtjr9B+z/+1bWtmgFbOq00BeyV9YFIhb1poGHMFF
         mzzbbEO9sJP3+gyE2T/wmlwgRLTOFs5LJSmQn8k2BY+E/DJY6ugeevfbHpv9CtDEVAmS
         PNCA==
X-Gm-Message-State: AJIora+frCwNeRs5wgD9AAY2Btf/PPY7MOIW0moLhRUgF7xwS6lmFWbd
        TdXyBwnuqI6xsrnSHuMfm1YJ43SfkXlelYkRCNZFJlVwp7yi0rXZKFA2BXB5m1yY2wf5X7G5K9Z
        Ohh9pR/TSHKp7uHY06d9N6PHNkCgwKKC+aEwrsGKvy92zVLTqgVUT0/8pw3B3LDAlgMWhsfeV3x
        iMPzQ=
X-Received: by 2002:a05:6000:12c8:b0:21d:6913:89af with SMTP id l8-20020a05600012c800b0021d691389afmr1868516wrx.546.1657698638250;
        Wed, 13 Jul 2022 00:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tVAaqjUmmT74Sd86HbMQeLDUALnySAzJYvk/gvhv1S4gh1URgjketeKTeNtjKaCdqglG2bdQ==
X-Received: by 2002:a05:6000:12c8:b0:21d:6913:89af with SMTP id l8-20020a05600012c800b0021d691389afmr1868479wrx.546.1657698637897;
        Wed, 13 Jul 2022 00:50:37 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.54.26])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb4a000000b0021db7b0162esm2220413wrs.105.2022.07.13.00.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:50:37 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Date:   Wed, 13 Jul 2022 09:50:14 +0200
Message-Id: <20220713075014.411739-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasks the are being deboosted from SCHED_DEADLINE might enter
enqueue_task_dl() one last time and hit an erroneous BUG_ON condition:
since they are not boosted anymore, the if (is_dl_boosted()) branch is
not taken, but the else if (!dl_prio) is and inside this one we
BUG_ON(!is_dl_boosted), which is of course false (BUG_ON triggered)
otherwise we had entered the if branch above. Long story short, the
current condition doesn't make sense and always leads to triggering of a
BUG.

Fix this by only checking enqueue flags, properly: ENQUEUE_REPLENISH has
to be present, but additional flags are not a problem.

Fixes: 2279f540ea7d ("sched/deadline: Fix priority inheritance with multiple scheduling classes")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5867e186c39a..0447d46f4718 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1703,7 +1703,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		 * the throttle.
 		 */
 		p->dl.dl_throttled = 0;
-		BUG_ON(!is_dl_boosted(&p->dl) || flags != ENQUEUE_REPLENISH);
+		BUG_ON(!(flags & ENQUEUE_REPLENISH));
 		return;
 	}
 
-- 
2.36.1

