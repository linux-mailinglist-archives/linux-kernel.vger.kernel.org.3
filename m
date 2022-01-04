Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC4A4847AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiADSVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbiADSVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:21:02 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5479EC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:21:02 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so364718pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=du0kP2g3DV9DZIF37rK7vx3EiH2Uy3OksrZnmSe6Oic=;
        b=n7dpMBqwTJTQUOKOwmCU3Iaa2isYr0Wt1s9EYydlLX5jTv4QxviavvZTobGHYYb3eg
         pqvHtf+78h4KG6Yp0KIs2XOMzHC8gZEdJztPK54F/IbwCkYtFcPKwxXlraMQv4uOA7d4
         XYN0lng2Vd54tF3oX7i3iiZJYz3OiTApb5s4tMWLyzuxUqez/X7TZfPG428AvU4f4VzS
         19/Kl68djCtX+LDqSGEgfrRijH1HZEbkCO6Gcrbn1TqH37IiFWALkuW5ac8Es0gKAKth
         vGGX5vP7yvfg30f+O95hhPpFNiyXxWt3LyM8y9qSKBEavmnqMciZ2FzIhcdEbpPPOLBQ
         AtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=du0kP2g3DV9DZIF37rK7vx3EiH2Uy3OksrZnmSe6Oic=;
        b=hVIM08j5CsILh1VxGVAnZHhRuF21Yfte4es1nitQVivW+En6UGKPRFEXLLmWzWYa6E
         vsXgocMvbc2ihHt/Y8vbUQYY4gDfnmx3mQS0BKkIYf5Dkk5zTb5hsiZoJA3qqFy5FPeo
         zjxtNPmJ2u0rIsr1HnnViUzIdSu21i3Y/mblOE99bOz5sk44/YfMcZvKos82NyFgc9MU
         EzUZomhiVv7++vvixMUwaEVMfrmcDQnTNYQaDkbyQR8UZxHkikRxHgNKkKll9lsV2tgK
         lJDm/8RCuG0Xd53+ywQHCJ9BNT0UuWQex7FMWHSGIJvTEEb5HQT7Lw3Y3tKS6wyKhkVY
         CLug==
X-Gm-Message-State: AOAM531q9cP3eIs+GfLQEKCUw0vikqIJIRNy5p9mNJn5NIwdwIapnphB
        KXnQelMqpY5gEzwqaX55Dog=
X-Google-Smtp-Source: ABdhPJyZQ4elidmmgIRebnwH7IlofeqFCS34KUOnP+Puk+4rlWjpJ3EM0pWKCCrBdZh9/Ge36jayDg==
X-Received: by 2002:a17:902:9a8b:b0:149:be04:40ab with SMTP id w11-20020a1709029a8b00b00149be0440abmr9261236plp.159.1641320461895;
        Tue, 04 Jan 2022 10:21:01 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:4abf:2548:40ff:6d1])
        by smtp.gmail.com with ESMTPSA id g10sm10097684pfo.103.2022.01.04.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:21:01 -0800 (PST)
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
Date:   Tue,  4 Jan 2022 10:20:51 -0800
Message-Id: <20220104182054.25009-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104182054.25009-1-namhyung@kernel.org>
References: <20220104182054.25009-1-namhyung@kernel.org>
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
2.34.1.448.ga2b2bfdf31-goog

