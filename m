Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1343853D3F4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 01:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349701AbiFCX5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 19:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiFCX5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 19:57:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A6A286FB;
        Fri,  3 Jun 2022 16:56:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so1896782pjb.1;
        Fri, 03 Jun 2022 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0eyMgwIk3CPtPFDkJwbRK4xZhRS0F0NmwDS3qIiC7U=;
        b=h7hibdVw1RJjLOsrW7x70TF8MkUajgOc/Niv5PGZmCXHlxOFvnf3Z1rTU15ei90Ud7
         CbSiZQDSuLBADEeFWbR/qUKtERHpS61W+ZotdqhMmlwlpQGhGKEkt1J3DG0d/eXs6Ko6
         Cwh6pD5da5bVFOFl/Imcbe3lPZtX9m+zWKlI9nUOaT+z/9c6L8xKOvXi1jI0AHgnSPlU
         IMMRsE6A67G8v6H1/hwgJ9UAsIXj0YxZiB6x4G9Yv7EhGn1kSZV5/ik4yZ/Z90OqVWEa
         vFUNZs2thQENXBGv4OBpBoP5pg0OqF/492p/O6ulew/jh50D9AZqbOoIKllluHzkyXc8
         dOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=m0eyMgwIk3CPtPFDkJwbRK4xZhRS0F0NmwDS3qIiC7U=;
        b=lnyeJjWV6wsmS9IBPPp4CdnFM/oaRoOUt1jrl55qLpv8ORd2WINHgWnTsTM0QBkflz
         lMp+9hTjGgioHI/51lXuFbQHaX074WJRj6R/Y5QEcrnAgUtsA/XfTU7qPyDZeShaikh2
         G7SsGASIkIwNa/hUd6In3KYEJhHEBXslUfZQamLuslSdxgB4mGGmDdMD0giJPJ6vJjUg
         pqDVgF94NgV+Qn5hdqxM0aGy5YF60Yg3iBf9WOOlAmiYQQV9ppZ9niWNXnpOC3xkoQJr
         XA6nV6M8iILn5Hj0y2vOeeTlNKJGmhRnf2YlOffyQDbyIvBozC7fkt2oO+9Wmx913bhT
         n8+A==
X-Gm-Message-State: AOAM532hCE0l/QcAedaZwhBffAipI9oFj/WVrQFNeERidJY+HXoS8Hhj
        fZeAmMUT3mrnLBLw3RwZS7c=
X-Google-Smtp-Source: ABdhPJz5LUhit0DcmfnU3RSZ0cjrjxXBYfuUT2yih2Kh5sKe/H1ELT8i6kocpycNtnADJEpntZzPZw==
X-Received: by 2002:a17:90a:5515:b0:1dc:c1f1:59bd with SMTP id b21-20020a17090a551500b001dcc1f159bdmr48375568pji.81.1654300619040;
        Fri, 03 Jun 2022 16:56:59 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:e599:3567:7c60:5f5a])
        by smtp.gmail.com with ESMTPSA id a37-20020a631a65000000b003c14af50626sm5868289pgm.62.2022.06.03.16.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 16:56:58 -0700 (PDT)
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
Subject: [PATCH 1/5] perf lock: Print wait times with unit
Date:   Fri,  3 Jun 2022 16:56:52 -0700
Message-Id: <20220603235656.715800-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220603235656.715800-1-namhyung@kernel.org>
References: <20220603235656.715800-1-namhyung@kernel.org>
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
2.36.1.255.ge46751e96f-goog

