Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAEF4673DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379542AbhLCJXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351316AbhLCJXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:23:23 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E39EC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 01:20:00 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g19so2311774pfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 01:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=jYAv0iWmWBE455h4D1IoUIYFZpKUBtbS2GMUOFjDnlE=;
        b=kRYjEoBxRWU78OrMfvBtdKgvs6qE/KJjO3fy91csgbbJWqzmiiAdqT5p6zDn7yo0YL
         bb9R4uXRxa2eOdhpGBbZOZHnduqW+4MjxSNmI9u0AJGrykeAyqGJSjPtWQ37188QV/s3
         oEhBfj73LjJMFw06iSe8nL6pLjcZB4xsuMq856NXbpwVoOj1quy8KM0oarCMF8ogWuxU
         8Mar2BNjwyEmHB+0eytQrCDl0TcUq4/Rgck3Zoi+FklpoWhP4xqSDjs4x8ZwN/jr5p3m
         2IMsEgjAxZN5nDLAOLq9AY8ZvWYHh/2t6XlwrsdMeDx/9ZacZ1JBVjXjGYq+58pZJZtf
         4nCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=jYAv0iWmWBE455h4D1IoUIYFZpKUBtbS2GMUOFjDnlE=;
        b=2+WBNI+1w7xZcs6I017kHpguOPn8zCpg3fITVoFbhL2vwvR+iNZb1PFu7N8WVdXxe/
         xs2e2IFMsnzfRhCsa4k6IPP1sGJQgojtYSl84jhc/WRLFaSwOgIrftON07uosGC34yH2
         r7xWnbkIE0Ec5/yJIR4oVHFmoS75okjHgQH3jZctjX0A6grIZyt5/vpW+GDEwPN+Hysn
         6aGwrG2MiiR9SxWoCoBLrzl7qoU7S9ELHMhWWiXLUulq4dgOck4iM0fQTHe0gE41pVxt
         iExu7S1A0jniJIcmFe+uzLx31BfpKOd28aMbK22JfEK8UFc+9CRKGQ9VwAoZQ2kJaMa9
         Ry8w==
X-Gm-Message-State: AOAM533Ba5ko0JfcQk1sEQSWFbBe7ECDKi1uK//p8DyqjbALV9vZGkZT
        bpUhAccBhyfKwJPgORctyoo=
X-Google-Smtp-Source: ABdhPJyKFkn8+whNJapWOI58OhVFjpnY70TICL+9MQy4V3v/NORKVWagAb4THUVQq+VWQ2MOvZmbDw==
X-Received: by 2002:a63:6c81:: with SMTP id h123mr3766011pgc.313.1638523199638;
        Fri, 03 Dec 2021 01:19:59 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d19sm2602423pfv.199.2021.12.03.01.19.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Dec 2021 01:19:59 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: count swap_writepage into PSI_IO STALL
Date:   Fri,  3 Dec 2021 17:19:40 +0800
Message-Id: <1638523180-4884-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

We would like to count swap_writepage into PSI_IO STALL time. There are
two reasons for doing so:
1. Swap_writepage introduces non-productive times. especially under the
   scenario of RAM based swap device.
2. High swappiness value will lead to more anon pages to be swap out.
3. IO pressure is inconsistent to PGSWPOUT.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/psi.h |  6 ++++++
 kernel/sched/psi.c  | 15 +++++++++++++++
 mm/vmscan.c         | 10 ++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 65eb147..6eb3a6f 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -23,6 +23,9 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
+void psi_iostall_enter(void);
+void psi_iostall_leave(void);
+
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
 
 #ifdef CONFIG_CGROUPS
@@ -45,6 +48,9 @@ static inline void psi_init(void) {}
 static inline void psi_memstall_enter(unsigned long *flags) {}
 static inline void psi_memstall_leave(unsigned long *flags) {}
 
+static inline void psi_iostall_enter(void) {}
+static inline void psi_iostall_leave(void) {}
+
 #ifdef CONFIG_CGROUPS
 static inline int psi_cgroup_alloc(struct cgroup *cgrp)
 {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 923a0d6..643b48c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -958,6 +958,21 @@ void psi_memstall_leave(unsigned long *flags)
 	rq_unlock_irq(rq, &rf);
 }
 
+void psi_iostall_enter(void)
+{
+	if (static_branch_likely(&psi_disabled))
+		return;
+
+	psi_task_change(current, 0, TSK_IOWAIT);
+}
+
+void psi_iostall_leave(void)
+{
+	if (static_branch_likely(&psi_disabled))
+		return;
+
+	psi_task_change(current, TSK_IOWAIT, 0);
+}
 #ifdef CONFIG_CGROUPS
 int psi_cgroup_alloc(struct cgroup *cgroup)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 74296c2..798907b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1072,7 +1072,17 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
 		};
 
 		SetPageReclaim(page);
+
+		/*
+		 * For the ram based swap device, there is no chance for reclaim
+		 * context sleeping on the congested IO while it really introduce
+		 * non-productive time. So count the period into PSI_IO.
+		 * Don't worry about the file page, just counting it in as it has
+		 * less chance to be here.
+		 */
+		psi_iostall_enter();
 		res = mapping->a_ops->writepage(page, &wbc);
+		psi_iostall_leave();
 		if (res < 0)
 			handle_write_error(mapping, page, res);
 		if (res == AOP_WRITEPAGE_ACTIVATE) {
-- 
1.9.1

