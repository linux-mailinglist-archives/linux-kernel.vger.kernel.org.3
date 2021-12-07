Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F8446B410
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhLGHjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhLGHjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:39:35 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BB6C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:36:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id m24so1409048pgn.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 23:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uy9aBxjfRzjElmmysGja2humLuZRrNVRfxSAdt2XSq4=;
        b=H1cFdFHh0AD2NJn1/ss1XHgvuFz/per+IsAl07TOBbh9PR2A1uA/TnsqBTFp/pNrT1
         fKnGVVYm0035DqiFz7x1nDa8OyhOHxXaxfvSkq5WVgO0X876lt1jgc/Z6Zob+RooHlDj
         PVNZIOoAsEMxF+Y8gRR5+xzoolgibTj2WJKgWF+Mrwj7TjtyDfFrWWj5dIBaQZ0xObxr
         aJGq8xNXhZ41GWr8arlJ/1b6O8fCMVPnRCOP9i+641HsPaprOFyuDFDRU9Cj7LofRs20
         XALhQEArXIg/Jq6v+2I4k4F34zs3+gijRM7lJKo8BD/a5LTDY12Y/JAl91L35fFdIOm9
         XkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uy9aBxjfRzjElmmysGja2humLuZRrNVRfxSAdt2XSq4=;
        b=IGXwpPVu5/0zGXW92tkwtYPsJnWitD17gNX/GtNvNoXZ9veOFhIYlc8Akonf+pgums
         Jh/seyFzMJeTu8wueoo963Sa0L6cvWF7ukDKtWOWQ3ZqEchpj7RO22A+W7bvbIyZXOc9
         dEGEItmwJp8vSsR43+nRmI84pw6k1kI/8P/sCXsYbi5HFE4XMuToSygflU2aebXqWt3J
         uuzFOpf/+DaQwi1PxnLVXYwGmM42Q8cmQ2D3n8adS4jXACuZcryI+94Kyf0vLKVsVDSP
         8kghXYSVkXKehQXwXIymLL3gdlZcibrdLLXdt/B/+UPGT7mw0P4OtmRkt0Biy4bZJV+f
         zZMA==
X-Gm-Message-State: AOAM533ovaYCOq47zDLGAb2eFC4/txmFWDz/jdGIkAKFJv/2JJkCAyfG
        o8cTSriMPs5vFzazYDTN1H2GhtrqnIo=
X-Google-Smtp-Source: ABdhPJxmdw8h7HGR9cthbosJwgPxAxLJvdBHPyYxLsbYCJJCqKFVqkE6rOIRfrZ0kMxk9DpN8aO+ew==
X-Received: by 2002:a63:90c1:: with SMTP id a184mr22482578pge.222.1638862565300;
        Mon, 06 Dec 2021 23:36:05 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id d10sm14559737pfl.139.2021.12.06.23.36.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 23:36:05 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 6/7] workqueue: Remove the cacheline_aligned for nr_running
Date:   Tue,  7 Dec 2021 15:35:42 +0800
Message-Id: <20211207073543.61092-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211207073543.61092-1-jiangshanlai@gmail.com>
References: <20211207073543.61092-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

nr_running is never modified remotely after the schedule callback in
wakeup path is removed.

Rather nr_running is often accessed with other fields in the pool
together, so the cacheline_aligned for nr_running isn't needed.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 256f552e9513..33f1106b4f99 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -154,6 +154,9 @@ struct worker_pool {
 
 	unsigned long		watchdog_ts;	/* L: watchdog timestamp */
 
+	/* The current concurrency level. */
+	atomic_t		nr_running;
+
 	struct list_head	worklist;	/* L: list of pending works */
 
 	int			nr_workers;	/* L: total number of workers */
@@ -177,19 +180,12 @@ struct worker_pool {
 	struct hlist_node	hash_node;	/* PL: unbound_pool_hash node */
 	int			refcnt;		/* PL: refcnt for unbound pools */
 
-	/*
-	 * The current concurrency level.  As it's likely to be accessed
-	 * from other CPUs during try_to_wake_up(), put it in a separate
-	 * cacheline.
-	 */
-	atomic_t		nr_running ____cacheline_aligned_in_smp;
-
 	/*
 	 * Destruction of pool is RCU protected to allow dereferences
 	 * from get_work_pool().
 	 */
 	struct rcu_head		rcu;
-} ____cacheline_aligned_in_smp;
+};
 
 /*
  * The per-pool workqueue.  While queued, the lower WORK_STRUCT_FLAG_BITS
-- 
2.19.1.6.gb485710b

