Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43C949D67F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiA0ABL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiA0ABF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:01:05 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3B7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:01:05 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e16so754755pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=unP+2twZA3OrVPx6WNOyb6deG2PSgw9+yCmy5oJ8xpI=;
        b=eQ+L5Z9MjBgl9fcq2aI541HzzDd54dfAmQydkM9kd67azeHklB6Kv+aNlVhuljfgI1
         pvqgsePHr21yuCsdkInOOxn++Wk3e9mxySrnVV5CR4aV7/5aX3ctMREqXv/FqFvj7N1c
         bMy/3rhaZdKZb0L9TFeq26yCj7M9UNMjrUlq7BaSFbrCcZ9ZNyIfz9H1jtVWPb6UYnqk
         ap7j6od/GwHBGQgx4V2qNf8Wl4qEIKRzic6vID2EQNaOwHDfQb7msqyPeL8kmYMeLvpy
         spoN7+X7S2eG+LeDFkHdL+Y9dDbHILe6UJnCXD7Hfb6MfE2Lj87UKzsYwmWnKt4rf4GC
         tOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=unP+2twZA3OrVPx6WNOyb6deG2PSgw9+yCmy5oJ8xpI=;
        b=qMpjjlsIvKxR6HfX0OjoXhCEsqY+fNGxuiVz1f6JkY9Aa052J+k/fbrOkXaT/3wWG8
         bvc3avGeMTPxuOAw2sAYDT9aqAezOeWzNgggzFXpSt0wbdfsYZ260UX27VQ1WMfSi3PA
         OL6hh7b57nLrNYBPSUJbrvwQcuE7HBWDy9pwT8DUYJ2XUs0n4YVINBTGOe86llMcnxD+
         PxWhnqG6P0jV9cHXDa1xUzurRM/xWCV8Obpn3siAwdrAniiB1plamBuib8aW6szd4duc
         fuTiLplxKmnENwAGMbEfp1ullxsCV24F4uVb/gxqrfTdsAtCNoJI8rlFVPzQleIpZzbv
         pzow==
X-Gm-Message-State: AOAM531pxRDHhoTlIJsAeY/3WPodRa8BcbxA1FuRJRaxIiHtXgwhiyi+
        mBmuclwu0Tt4lkOjxfP1JFE=
X-Google-Smtp-Source: ABdhPJz72cD96I4xpifE84yjtY7n9KXt/vhDJ0z0byTrV7S3r5Jd4tbNJZAfnnnZ+sGJQMqDN5h9/A==
X-Received: by 2002:a63:844a:: with SMTP id k71mr836232pgd.559.1643241664703;
        Wed, 26 Jan 2022 16:01:04 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:e94:fba2:6768:ac75])
        by smtp.gmail.com with ESMTPSA id t24sm3545546pfg.92.2022.01.26.16.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 16:01:04 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 6/6] perf lock: Carefully combine lock stats for discarded entries
Date:   Wed, 26 Jan 2022 16:00:50 -0800
Message-Id: <20220127000050.3011493-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127000050.3011493-1-namhyung@kernel.org>
References: <20220127000050.3011493-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stats from discarded entries should be omitted.  But a lock class may
have both good and bad entries.  If the first entry was bad, we can
zero-fill the stats and only add good stats if any.  The entry can
remove the discard state if it finds a good entry later.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index bbfeba79426a..57b9ebd7118a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -295,6 +295,9 @@ static void combine_lock_stats(struct lock_stat *st)
 			ret = !!st->name - !!p->name;
 
 		if (ret == 0) {
+			if (st->discard)
+				goto out;
+
 			p->nr_acquired += st->nr_acquired;
 			p->nr_contended += st->nr_contended;
 			p->wait_time_total += st->wait_time_total;
@@ -307,6 +310,10 @@ static void combine_lock_stats(struct lock_stat *st)
 			if (p->wait_time_max < st->wait_time_max)
 				p->wait_time_max = st->wait_time_max;
 
+			/* now it got a new !discard record */
+			p->discard = 0;
+
+out:
 			st->combined = 1;
 			return;
 		}
@@ -319,6 +326,15 @@ static void combine_lock_stats(struct lock_stat *st)
 
 	rb_link_node(&st->rb, parent, rb);
 	rb_insert_color(&st->rb, &sorted);
+
+	if (st->discard) {
+		st->nr_acquired = 0;
+		st->nr_contended = 0;
+		st->wait_time_total = 0;
+		st->avg_wait_time = 0;
+		st->wait_time_min = ULLONG_MAX;
+		st->wait_time_max = 0;
+	}
 }
 
 static void insert_to_result(struct lock_stat *st,
-- 
2.35.0.rc0.227.g00780c9af4-goog

