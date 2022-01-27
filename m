Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1924949D67B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiA0ABE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiA0AA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:00:59 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56871C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:00:59 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 192so1119962pfz.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gr6OHamf/KamqCZ0WcYTNgpdivEzEDFg4GOvJ7a+I8I=;
        b=gL7JYhNBzJb70oZUYlf+Qfy35k1mAZNUtFoVEJTwmebK/bfmg/s+uZmZyBbrlbMchk
         b3I2e4niUg4yWKw52WQPRC9dB4MgruhFzRPG+2XLhuVAKstSAFr20v7HL3LOrZW27eeA
         D5DaajTNBxtmCBBwgF+4m+Bs/Sfae4u/kcx3AY7ZJQlTvvIfxIgtoJDdEbOYfdKiLHb2
         yNoMLwwYo2VZvQwdZhbnUEKZjDaxw1U4BB+pONR6joWqERT7zJHdvcrqRXKzoUN7uHrF
         AqgkZtYe6UA7HHTm4xOurXY5vANekPvSc93VN7roCtBZX4BO7NdwYofrqmkG+Hotud8Y
         hbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gr6OHamf/KamqCZ0WcYTNgpdivEzEDFg4GOvJ7a+I8I=;
        b=5nJF70BlVNUd1xF7pCcjzO1j1NXXGmmvfTmo48oxiFYu/JYBGAZg+6ux2jgnYwxNLo
         L39Mjz/qUbcdFJwUqj/TjlNNiO3qIY+pePMOIWTYiBENKF8LPrmyZ3tYzZ/GmOzBJwBY
         HQkTTEsCcKXXeeyEEYZpPDknoCZvxgzH499H9z0a2KbdL0Gz+NpeHe2SZDICJhO2NPtB
         puKI0QLuOgW5jLdB6FScoG7cqo8UEEDw1m0GuKdZ1Ggmqv5+Q7uvVdCVu9PfODAH0ayj
         oWl+5UDgwcWUNmPX+sgkoDQx3Bn+wv72f+JlqJ4odS66piFyH+f0tJsKYuS2Af2ijtA3
         gyDA==
X-Gm-Message-State: AOAM5339BN8rGMT/+SaVfXePIyUte2tthic5U0VjimdQwGaGVyyjJOPX
        4sTwP5ERtkTwwaMPoAj2lkrmnnfPi2c=
X-Google-Smtp-Source: ABdhPJxbTbnJb4QIeAL2LvYGnmZkVCVDSQeiObHyQVaKu7//+kWTTzOLPnxMcLE1+vb1sLc96mo/dg==
X-Received: by 2002:aa7:9989:: with SMTP id k9mr848884pfh.23.1643241658834;
        Wed, 26 Jan 2022 16:00:58 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:e94:fba2:6768:ac75])
        by smtp.gmail.com with ESMTPSA id t24sm3545546pfg.92.2022.01.26.16.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 16:00:58 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 3/6] perf lock: Sort map info based on class name
Date:   Wed, 26 Jan 2022 16:00:47 -0800
Message-Id: <20220127000050.3011493-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127000050.3011493-1-namhyung@kernel.org>
References: <20220127000050.3011493-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of the random order, sort it by lock class name.

Before:
  # perf lock info -m
  Address of instance: name of class
   0xffffa0d940ac5310: &dentry->d_lockref.lock
   0xffffa0c20b0e1cb0: &dentry->d_lockref.lock
   0xffffa0d8e051cc48: &base->lock
   0xffffa0d94f992110: &anon_vma->rwsem
   0xffffa0d947a4f278: (null)
   0xffffa0c208f6e108: &map->lock
   0xffffa0c213ad32c8: &cfs_rq->removed.lock
   0xffffa0c20d695888: &parent->list_lock
   0xffffa0c278775278: (null)
   0xffffa0c212ad4690: &dentry->d_lockref.lock

After:
  # perf lock info -m
  Address of instance: name of class
   0xffffa0c20d538800: &(&sig->stats_lock)->lock
   0xffffa0c216d4ec40: &(&sig->stats_lock)->lock
   0xffffa1fe4cb04610: &(__futex_data.queues)[i].lock
   0xffffa1fe4cb07750: &(__futex_data.queues)[i].lock
   0xffffa1fe4cb07b50: &(__futex_data.queues)[i].lock
   0xffffa1fe4cb0b850: &(__futex_data.queues)[i].lock
   0xffffa1fe4cb0bcd0: &(__futex_data.queues)[i].lock
   0xffffa1fe4cb0e5d0: &(__futex_data.queues)[i].lock
   0xffffa1fe4cb11ad0: &(__futex_data.queues)[i].lock

Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index c4b5c3d71ae3..8078f7ca826d 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -757,6 +757,21 @@ static void dump_threads(void)
 	}
 }
 
+static int compare_maps(struct lock_stat *a, struct lock_stat *b)
+{
+	int ret;
+
+	if (a->name && b->name)
+		ret = strcmp(a->name, b->name);
+	else
+		ret = !!a->name - !!b->name;
+
+	if (!ret)
+		return a->addr < b->addr;
+	else
+		return ret < 0;
+}
+
 static void dump_map(void)
 {
 	unsigned int i;
@@ -765,9 +780,12 @@ static void dump_map(void)
 	pr_info("Address of instance: name of class\n");
 	for (i = 0; i < LOCKHASH_SIZE; i++) {
 		hlist_for_each_entry(st, &lockhash_table[i], hash_entry) {
-			pr_info(" %#llx: %s\n", (unsigned long long)st->addr, st->name);
+			insert_to_result(st, compare_maps);
 		}
 	}
+
+	while ((st = pop_from_result()))
+		pr_info(" %#llx: %s\n", (unsigned long long)st->addr, st->name);
 }
 
 static int dump_info(void)
-- 
2.35.0.rc0.227.g00780c9af4-goog

