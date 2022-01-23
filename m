Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B0A497493
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbiAWSlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbiAWSlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:00 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1590C061744
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:00 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id nn16-20020a17090b38d000b001b56b2bce31so3335296pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y1tPM2x+LdwD18VwjZck6YxRe2obac2jjzlUu/mgFiM=;
        b=fVijBHEL3gp13HONCJnA7ih2LQ9ToB3knn2X89I+BbqwX9+Qmqrs8TpNzVK2ulM7lB
         eLtmJFXke0X5Cm1JiG8QIg3CDGBuG4rwyTm9xaCmjC2IO6ehozsunIo9HkdfcgRQw6F/
         K2LTk+yI+tlvBlD6Dd1A8kiJO7MdlREWIQ9FiK1a9WmXnMxEUCAe06jNHuBSYqKyHEzv
         XF8onjg6Gt/lrMZVErLMtWr9qNdX1CCpARXqcoL3ueiYM4PQ9UspcRzS+SYvNvTLCBG7
         FnH0GItcXoFe8VRupuNvpvRgHrjh4oc+FeHPjx8JP2nguGysLsxxq6BziCv2BoI5uyBd
         leGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1tPM2x+LdwD18VwjZck6YxRe2obac2jjzlUu/mgFiM=;
        b=ycNwjHqqjoa4FgC6U6a4FB8Mz2wYh/RWa+nmc4r1uNf4wpeVoBrGjBVra/nCTsgNQS
         3C5hmsFLa5mtyJAMYA38nP9BDe7BiVeuLP2JFCkq2uoIKW78aOM3woeJ5pMYF3tO6Nl6
         KMjl1tu4Z6nLBs8YrLK+7dErYItaG1A+4E4Le2QBnEDeXqVM5T8+1/bd6WYDwP5xhK40
         585vlRGivXu++v/JRccP3KkzII2Qw9YkpTyaqfyyWEfp5JZ/2F8w9x4w66VG8wQzDiHi
         Dwk+CbzGqw5A2vwLMEUiPlNzbFZb6XAatM68drxyvp5wR0saWAi1NyMPSkmFk4IVJRGW
         b3gg==
X-Gm-Message-State: AOAM5331eJt5fIrZI1mRUxXHVbwplEy6ICfuyMNKA0rFk/ocKGzVf2JG
        TE5cdS/tRsriy22ZtwMWga8=
X-Google-Smtp-Source: ABdhPJyssPaXQP2/ydapTk0xPZ7dpr7K04kh5u49fDFdhy50p0xc+q9sLR6vNLCbmjW+yBSzz7pdEQ==
X-Received: by 2002:a17:903:124f:b0:149:a740:d8bc with SMTP id u15-20020a170903124f00b00149a740d8bcmr12002122plh.79.1642963260184;
        Sun, 23 Jan 2022 10:41:00 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id v17sm13674760pfu.220.2022.01.23.10.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:59 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 23/54] sched: replace cpumask_weight with cpumask_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:54 -0800
Message-Id: <20220123183925.1052919-24-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some places, kernel/sched code calls cpumask_weight() to check if
any bit of a given cpumask is set. We can do it more efficiently with
cpumask_empty() because cpumask_empty() stops traversing the cpumask as
soon as it finds first set bit, while cpumask_weight() counts all bits
unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e4ae00e52d1..918d0bdc2ea8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8707,7 +8707,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 {
 	int ret = 1;
 
-	if (!cpumask_weight(cur))
+	if (cpumask_empty(cur))
 		return ret;
 
 	ret = dl_cpuset_cpumask_can_shrink(cur, trial);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a7052a29..8478e2a8cd65 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -74,7 +74,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 			break;
 		}
 
-		if (!cpumask_weight(sched_group_span(group))) {
+		if (cpumask_empty(sched_group_span(group))) {
 			printk(KERN_CONT "\n");
 			printk(KERN_ERR "ERROR: empty group\n");
 			break;
-- 
2.30.2

