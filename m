Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F5554CEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356403AbiFOQcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355065AbiFOQcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:32:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C759BD6;
        Wed, 15 Jun 2022 09:32:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o17so10860171pla.6;
        Wed, 15 Jun 2022 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=699rWlf8ZBCdGGluADa4SdNzlDCHvmdVNZAg0YxDlWs=;
        b=ZTDKwDaMAWnsr2/N1QFyPRYGFPs4EJbumJ2reRI52uFklyqAbdigh50qx8bK5/e2aq
         kWa7Owy79RUVmEduAWHNqMBRUgf2sgtHiu75tzZ0zBQMKkohBi5K25K03YuVGtPN+2Bw
         RzNuBxyLu0kvvcp6FRDfAnki7C0vnOohH/MU0u5CoQpfDmOz6037QcdEveOBMqjAnKU6
         4rxx8Cs//umKvFeGdAp/Dy7xlkg/oxUjMoVZTnXjkxOm9bt9OdLS5aeqWie7NqJCiRVK
         WSisroKXeSw5DZHMGpObAC9EwBMXsbLgDWXAX4qoKKq0Es9PtVWw7Z9qtIShogiAocr0
         3wKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=699rWlf8ZBCdGGluADa4SdNzlDCHvmdVNZAg0YxDlWs=;
        b=CyiJy/DhwoEsDmPybeK3MrpTHMB44PBp0OKHjLhFG1jTBrG4oZ3G3HXpDXR6qVF7i+
         lf+5jHkqEg7jvjF2IO2r/1yj2b/7ACGKH2bOPG4RTyIxfE+lRUux9V0QsGOf4aM7lraA
         p1kTQYKxL1jl5YoEISbBetXT+K8ctxi86qIH0Co1tVfkLbQaTY6GTtpJxJGA5mFlRQg/
         9qelVSYGHLqG+dW6yi7ZLIbMqBFwXuZr11sK0xSxHBxTUmT7nAqPIjG2h359TrRBIBiC
         ctlG/GFkeeN91j2vx4W7v+F19t/rZjvSbCLeAvBLlhaDI+QR8gYDtNDVH9w62r4rv99N
         jz5Q==
X-Gm-Message-State: AJIora8qKQZ8ulUggfdwh2+MhXxdIztGvb1mH36EfoYNaH0G0qov7FBV
        vvJMBRZiNxInQcK3kylU+Gs=
X-Google-Smtp-Source: AGRyM1uWS8skkxtd2vlS3Xhu4R22mi0pWALn9RQ+8j+yzYv0Zpcx9PbgSkSQwXmpDuSHrsdrYHpkbQ==
X-Received: by 2002:a17:902:dac3:b0:164:13b2:4914 with SMTP id q3-20020a170902dac300b0016413b24914mr565342plx.135.1655310747095;
        Wed, 15 Jun 2022 09:32:27 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:6b99:92ca:1efa:c0fb])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b00168bffd39a1sm9583881plk.143.2022.06.15.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:32:26 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 1/7] perf lock: Print wait times with unit
Date:   Wed, 15 Jun 2022 09:32:16 -0700
Message-Id: <20220615163222.1275500-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615163222.1275500-1-namhyung@kernel.org>
References: <20220615163222.1275500-1-namhyung@kernel.org>
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

Currently it only prints the time in nsec but it's a bit hard to read
and takes longer in the screen.  We can change it to use different
units and keep the number small to save the space.

Before:
  $ perf lock report

                Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns)

        jiffies_lock        433         32            2778           88908           13570             692
   &lruvec->lru_lock        747          5           11254           56272           18317            1412
      slock-AF_INET6          7          1           23543           23543           23543           23543
    &newf->file_lock        706         15            1025           15388            2279             618
      slock-AF_INET6          8          1           10379           10379           10379           10379
         &rq->__lock       2143          5            2037           10185            3462             939

After:
                Name   acquired  contended     avg wait   total wait     max wait     min wait

        jiffies_lock        433         32      2.78 us     88.91 us     13.57 us       692 ns
   &lruvec->lru_lock        747          5     11.25 us     56.27 us     18.32 us      1.41 us
      slock-AF_INET6          7          1     23.54 us     23.54 us     23.54 us     23.54 us
    &newf->file_lock        706         15      1.02 us     15.39 us      2.28 us       618 ns
      slock-AF_INET6          8          1     10.38 us     10.38 us     10.38 us     10.38 us
         &rq->__lock       2143          5      2.04 us     10.19 us      3.46 us       939 ns

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 48 ++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 23a33ac15e68..57e396323d05 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -251,6 +251,31 @@ struct lock_key {
 	struct list_head	list;
 };
 
+static void lock_stat_key_print_time(unsigned long long nsec, int len)
+{
+	static const struct {
+		float base;
+		const char *unit;
+	} table[] = {
+		{ 1e9 * 3600, "h " },
+		{ 1e9 * 60, "m " },
+		{ 1e9, "s " },
+		{ 1e6, "ms" },
+		{ 1e3, "us" },
+		{ 0, NULL },
+	};
+
+	for (int i = 0; table[i].unit; i++) {
+		if (nsec < table[i].base)
+			continue;
+
+		pr_info("%*.2f %s", len - 3, nsec / table[i].base, table[i].unit);
+		return;
+	}
+
+	pr_info("%*llu %s", len - 3, nsec, "ns");
+}
+
 #define PRINT_KEY(member)						\
 static void lock_stat_key_print_ ## member(struct lock_key *key,	\
 					   struct lock_stat *ls)	\
@@ -258,11 +283,18 @@ static void lock_stat_key_print_ ## member(struct lock_key *key,	\
 	pr_info("%*llu", key->len, (unsigned long long)ls->member);	\
 }
 
+#define PRINT_TIME(member)						\
+static void lock_stat_key_print_ ## member(struct lock_key *key,	\
+					   struct lock_stat *ls)	\
+{									\
+	lock_stat_key_print_time((unsigned long long)ls->member, key->len);	\
+}
+
 PRINT_KEY(nr_acquired)
 PRINT_KEY(nr_contended)
-PRINT_KEY(avg_wait_time)
-PRINT_KEY(wait_time_total)
-PRINT_KEY(wait_time_max)
+PRINT_TIME(avg_wait_time)
+PRINT_TIME(wait_time_total)
+PRINT_TIME(wait_time_max)
 
 static void lock_stat_key_print_wait_time_min(struct lock_key *key,
 					      struct lock_stat *ls)
@@ -272,7 +304,7 @@ static void lock_stat_key_print_wait_time_min(struct lock_key *key,
 	if (wait_time == ULLONG_MAX)
 		wait_time = 0;
 
-	pr_info("%*"PRIu64, key->len, wait_time);
+	lock_stat_key_print_time(wait_time, key->len);
 }
 
 
@@ -291,10 +323,10 @@ static const char		*output_fields;
 struct lock_key keys[] = {
 	DEF_KEY_LOCK(acquired, "acquired", nr_acquired, 10),
 	DEF_KEY_LOCK(contended, "contended", nr_contended, 10),
-	DEF_KEY_LOCK(avg_wait, "avg wait (ns)", avg_wait_time, 15),
-	DEF_KEY_LOCK(wait_total, "total wait (ns)", wait_time_total, 15),
-	DEF_KEY_LOCK(wait_max, "max wait (ns)", wait_time_max, 15),
-	DEF_KEY_LOCK(wait_min, "min wait (ns)", wait_time_min, 15),
+	DEF_KEY_LOCK(avg_wait, "avg wait", avg_wait_time, 12),
+	DEF_KEY_LOCK(wait_total, "total wait", wait_time_total, 12),
+	DEF_KEY_LOCK(wait_max, "max wait", wait_time_max, 12),
+	DEF_KEY_LOCK(wait_min, "min wait", wait_time_min, 12),
 
 	/* extra comparisons much complicated should be here */
 	{ }
-- 
2.36.1.476.g0c4daa206d-goog

