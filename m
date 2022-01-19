Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE14C49431D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357585AbiASWjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240151AbiASWjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:39:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48BEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:39:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y4-20020a5b0f44000000b00611862e546dso7777066ybr.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=45dhDA3feWqNpDPvomIIP6qc6Pon+uWRob8KlPh13n8=;
        b=TSEXxN9I/MY4H600FoFO/FhpkvGjxygS/3VLLz/hgDE1yQT9ZA6oQYG8NCFrfk5eeG
         Nf8f4pR5DD4V8fLYGckS8kUOVsnlqn3I0up5uuPc5eavc1+Z9Gko66hCoZILDMOzwnqf
         MXk3cE+apBx8gSOjSMl893JDUWZ5rjMB1w7Y0gtSagfZgvW8m9LNApJJVTOdT5kPsFZ3
         wXKyFtfw1CvhGLSCUUFGq8LQY9JBmxYUt8HBtG59dSGaTG7gjwbnD2+M7QyRozDfCRmL
         fSopEIzh9Veg8rYo2+UA40ep7JU2rW9pY/y3P2wHUjx3Cvk8+Dee1GzFlAyhbomAfFZF
         0V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=45dhDA3feWqNpDPvomIIP6qc6Pon+uWRob8KlPh13n8=;
        b=0/4kJfHOlJMqtmc9xfGodSOiSkUpBayTZjg8SuMTe01Q+WwGcD8mMNJ0xZzLa9owTM
         ROs/kTBnj0Z5jIseuHkP+cZlXcWpF0+86zd9iCGCxgJt9P5/ufd37dvdxghcC3+uuFcF
         CRGdljTBRdS7CbxA5hJVFyCVpMRv8fD7dNTDe3at7EZvo2xl9dZGNfKFewLnVEVIBLmT
         5TE3h0rcAGhkZdBgF2uU5pu/6MYbCqaluxqvDAKlPNSVkoTBcxgZJX13z8xs4aSPUPCN
         kK/Lo57ZIJAznSOcKsetq6+hV1jWSwm03wXimDdzWbw5cN3OiR81D8l2wpYcNTO3BhyW
         XgcA==
X-Gm-Message-State: AOAM5312TkZSYrZu52hj6ZGnZMlx/sQhejwHZKtzl0QZYsHzCbRDVGFz
        0YfZCydCAuI1dFFz8/pZOYAvGhCIz/Q=
X-Google-Smtp-Source: ABdhPJwJBDzmAJNW8LkzS5uKcaUlorDgOVco2nO06x6ETG9/6gEcZOccRt83xP5AJjDi/kehWwanvbCzo0Y=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:5c51:e66a:40e8:adec])
 (user=surenb job=sendgmr) by 2002:a5b:911:: with SMTP id a17mr34646303ybq.379.1642631986975;
 Wed, 19 Jan 2022 14:39:46 -0800 (PST)
Date:   Wed, 19 Jan 2022 14:39:39 -0800
In-Reply-To: <20220119223940.787748-1-surenb@google.com>
Message-Id: <20220119223940.787748-2-surenb@google.com>
Mime-Version: 1.0
References: <20220119223940.787748-1-surenb@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 1/2] psi: Fix "no previous prototype" warnings when CONFIG_CGROUPS=n
From:   Suren Baghdasaryan <surenb@google.com>
To:     hannes@cmpxchg.org
Cc:     peterz@infradead.org, mingo@redhat.com, ebiggers@kernel.org,
        tj@kernel.org, willy@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_CGROUPS is disabled psi code generates the following warnings:

kernel/sched/psi.c:1112:21: warning: no previous prototype for 'psi_trigger_create' [-Wmissing-prototypes]
    1112 | struct psi_trigger *psi_trigger_create(struct psi_group *group,
         |                     ^~~~~~~~~~~~~~~~~~
kernel/sched/psi.c:1182:6: warning: no previous prototype for 'psi_trigger_destroy' [-Wmissing-prototypes]
    1182 | void psi_trigger_destroy(struct psi_trigger *t)
         |      ^~~~~~~~~~~~~~~~~~~
kernel/sched/psi.c:1249:10: warning: no previous prototype for 'psi_trigger_poll' [-Wmissing-prototypes]
    1249 | __poll_t psi_trigger_poll(void **trigger_ptr,
         |          ^~~~~~~~~~~~~~~~

Change declarations of these functions in the header to provide the
prototypes even when they are unused.

Fixes: 0e94682b73bf ("psi: introduce psi monitor")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/psi.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index f8ce53bfdb2a..7f7d1d88c3bb 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -25,18 +25,17 @@ void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
-
-#ifdef CONFIG_CGROUPS
-int psi_cgroup_alloc(struct cgroup *cgrp);
-void psi_cgroup_free(struct cgroup *cgrp);
-void cgroup_move_task(struct task_struct *p, struct css_set *to);
-
 struct psi_trigger *psi_trigger_create(struct psi_group *group,
 			char *buf, size_t nbytes, enum psi_res res);
 void psi_trigger_destroy(struct psi_trigger *t);
 
 __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 			poll_table *wait);
+
+#ifdef CONFIG_CGROUPS
+int psi_cgroup_alloc(struct cgroup *cgrp);
+void psi_cgroup_free(struct cgroup *cgrp);
+void cgroup_move_task(struct task_struct *p, struct css_set *to);
 #endif
 
 #else /* CONFIG_PSI */
-- 
2.34.1.703.g22d0c6ccf7-goog

