Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766C04D9695
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346117AbiCOIpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346091AbiCOIpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAD06469
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so1047450wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tH2GvQq/KqMNcn2198cqxL2zSXD8McSQV3coSRC1vhc=;
        b=pfrQ05wXNqGkPMexWzyKTBcZgb+4KxdZoU/M8cPb1E38WDTUJe3U7HiaUkSOF8MJUE
         tudi64Mvm2u7nzjLG+i0QIqPD8xMLx5gGEyqMBeTs/o5bx0egkTVFnudyc91CqPAGRJD
         JD+q3AVQjmgJLded5ba/8D6IW89WX9mQGcoplWUojJgW9OInaSiMxy71CjIdxgkc5lRG
         zSuHmqdw1GQVVb/B+k0jM0HmGZsjNbMqCbbou1OYw16xJxVwISj7QV9W/7BMVODD9JHC
         Z5pwhObOLyHSHrZj5YwBd8VdFT0RRSWYiR2Mo3Ub04GRqsW8kUAquAjnmOf2kra6UjQR
         Y6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tH2GvQq/KqMNcn2198cqxL2zSXD8McSQV3coSRC1vhc=;
        b=voOTAviyrLCfR8v8R7q6hUk/DdjrLccTU6okCzDJiJpXSw4o36vL0ahhN/I0f26tWw
         unpFXY37nxmVoc5CoDdpqiGM8Amr9zaKuXJDMzRHI7TTajHyYSK3GNcgTW3OYQJMKqtW
         dKr66gh+S75OGrt+fg6pILWX9GIDKWwhzsO1Ii9s+HpZuTdMKywHp8sHN06sEqRsMPpT
         8tG77ebDd+3tZlmn6ldr5tQd/PxwOQ6CXPBuMRMbLa18QLvGkF/yAMx1oYcd+UESatum
         e56lpDrq7xp3Te0JAGSIIT2QW7SN+Hmv7rrTztlEGzCQWVWlIXCz6gaWka4N6KRw5QXR
         dWpg==
X-Gm-Message-State: AOAM530zMgu87D5fayH/ARmLiidExU77V9GPB8Z+kyIUb4RCffGDcXKs
        O6BYile1cJoX0RBRogRXSiQfIiHhHoM=
X-Google-Smtp-Source: ABdhPJz/RqNiHb1jrS036WTXH0qA6BZ03+m5BMQSXqjbUEJX5YBSVqTfMB/RupGeCvGDMHM85JieuA==
X-Received: by 2002:a05:600c:5c7:b0:389:9cf2:53b4 with SMTP id p7-20020a05600c05c700b003899cf253b4mr2344804wmd.114.1647333830505;
        Tue, 15 Mar 2022 01:43:50 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:43:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 02/15] sched/headers: Add header guard to kernel/sched/sched.h
Date:   Tue, 15 Mar 2022 09:42:34 +0100
Message-Id: <20220315084247.40783-3-mingo@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220315084247.40783-1-mingo@kernel.org>
References: <20220315084247.40783-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the canonical header guard naming of the full path to the header.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3da5718cd641..eab4a18f71c2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2,6 +2,9 @@
 /*
  * Scheduler internal types and methods:
  */
+#ifndef _KERNEL_SCHED_SCHED_H
+#define _KERNEL_SCHED_SCHED_H
+
 #include <linux/sched.h>
 
 #include <linux/sched/autogroup.h>
@@ -3137,3 +3140,4 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
+#endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.32.0

