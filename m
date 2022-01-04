Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41974847B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbiADSVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbiADSVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:21:10 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3D9C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:21:06 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f8so23346519pgf.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fz20zPwtW6K20yLuSaMR18ADC6qHoTxZWwTE71o/muY=;
        b=gR2nlKtw6PBb01OYu4n4BLKq1JnlWZAmM4nMtGujhZJkkcHp9P27SluPRbGa5BrAGo
         daBou9AfWQEyt7zmLl/K2dTQuaUrydmvyUocVVl0jzIsYjokFC8Tnvu2lafx8uixatX3
         wGzu/sIaCGexWhyUfPzhFFaLROGOoRAGqUR1f5cLIcD95ktnisKYvX5menA9R2yDa0yP
         Ypf9p3qwZu0qZfzY0hA9QmHHupww7DFVNxfsKtP48w9LGEYK/CgLxV5TlsxNV7K5kNgw
         O86YwJk58fL4XVPOu6PO3Rp4p7DBodZKipMpPQFRQM0tJp1n/JnDKDlq9CJx3H2IZVE8
         KQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fz20zPwtW6K20yLuSaMR18ADC6qHoTxZWwTE71o/muY=;
        b=Q+bOr91Dly1Fl5Zi7REqHc0FWhTm6kTlYizxVQAeJBROHxN+yIA/ZvbbN8dw496+bS
         nfYsHj/KTXzyPX5MyhdBtA+x6eQS+1Nrp3WKF+CcbPOa0kk5HNitsNkLYO2+sOhjar+n
         yWJM894EuOxMeX+Nosn17grPCfojh2nCL9PAjL+ChXMmP2PxDJSa5D2WSAUH+7IUMgJ1
         CJx5CKSzIXtimx4+HGOY/tugLEDC3Wj/RZNpYEHfjdDWl2VnMJeH3rMI+t9pzvQr7Aqm
         od0urixvjv98OH8cEVe6yEu4wCRqvqqYnksFt85jD9K0Hqxb+kUlwIzzQgPwYvoacmKO
         u+jQ==
X-Gm-Message-State: AOAM530cfn9L5ywM4BLqk087z3H350yHM9vnFXocATxxrBt/B80ryrNJ
        fs9gsYmgusZOvpXwzCsczYs=
X-Google-Smtp-Source: ABdhPJxlQ9nxNr+pbbCeCulywVIT1xgNeYBYDXmydEBnMKYIbV27eY5bON8dX/TWFkk/h6OGg2scjw==
X-Received: by 2002:a63:ad48:: with SMTP id y8mr15868741pgo.495.1641320466051;
        Tue, 04 Jan 2022 10:21:06 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:4abf:2548:40ff:6d1])
        by smtp.gmail.com with ESMTPSA id g10sm10097684pfo.103.2022.01.04.10.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:21:05 -0800 (PST)
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
Date:   Tue,  4 Jan 2022 10:20:54 -0800
Message-Id: <20220104182054.25009-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104182054.25009-1-namhyung@kernel.org>
References: <20220104182054.25009-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stats from discarded entries should be omitted.  But a lock class may
have both good and bad entries.  If the first entry was bad, we can
zero-fill the stats and only add good stats if any.  The entry can
remove the discard state if it finds a good entry later.

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
2.34.1.448.ga2b2bfdf31-goog

