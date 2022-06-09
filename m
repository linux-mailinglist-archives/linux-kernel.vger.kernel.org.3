Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3CD544359
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiFIF47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiFIF45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:56:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332122AC5B;
        Wed,  8 Jun 2022 22:56:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y196so20200250pfb.6;
        Wed, 08 Jun 2022 22:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0eyMgwIk3CPtPFDkJwbRK4xZhRS0F0NmwDS3qIiC7U=;
        b=TzgG5VqfYuCYVvUCv6XhOkxOnAu75fHbbbLfYh4fbXKwGqbZtZSdzN+wLtCKGd32YJ
         aay+C94a8bsfv8u3ZwTMlPn17tjTBQAskqkqAcRjiXvWsKzdKItc41yUUEa2MpKNyDNj
         Fg97Rcb5ardzecWBV7k3C1HlX/+7bkrlUyhps/s9msTEWvOrLkaxSMQGwdZaQKm77fqn
         3j49U3hbvj4Dip1+pszEDaufA6/bKG1bIpjpMcJ62cUvgzl94QD7IjTJ/k+r4BpSOQ0C
         Wttde7cuQ7q8C9CzErM797sQgVw7nEfOVNpp+o92CF071foYrjMQu2jq/rJzVOhV7WMa
         YOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=m0eyMgwIk3CPtPFDkJwbRK4xZhRS0F0NmwDS3qIiC7U=;
        b=JZxAFDwb40AgYCvEGzT9LSvFMf6fqmmy4wfT1EUCIC1eIdv3yZzEQFR2MBa4r5Djlj
         PIL1rJw7IY/aQ0XOX4OGIZdRrEunErGUkE/+k3B6Qli3q5RpUYiChbg0YLERqHJqkqs+
         KKGIpQlR/OZ5BDM3C4t/wUDHHLtT804IWUdxQU7cscMkq+B2jQt1fmzYTTP6jeK88J4M
         WOffdQI7SLPjU7nh1A2KkNbY7td38eBcJk2JRMLTM1Nu+oYs4o6ZIDEDZbH+/Jmc4UDV
         513/y2SyV4OF5nFsO8Ph+MIoHgZnWcvsb1LD9pXMzCei6wCldHaJ1WojlCKiuPqY0FYh
         /D/g==
X-Gm-Message-State: AOAM532nn5HU5MxZDnnW30oKgOKF6IFKTDdMKn5TF9avVKE959Eu5bSl
        oRWb4Yiusr35wWBHQdcEsYWgJuuohPYqow==
X-Google-Smtp-Source: ABdhPJxS1vEgV2iXzVy2mU3BLc4te2TrAxkypg1G+0tcT/wXmqVzkDCXIDqewKFHi2IjRyNNH2MkKg==
X-Received: by 2002:a05:6a00:855:b0:51c:27dc:b5c0 with SMTP id q21-20020a056a00085500b0051c27dcb5c0mr16768481pfk.47.1654754215606;
        Wed, 08 Jun 2022 22:56:55 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:2c32:ceaf:ea06:c5de])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0016196bcf743sm9502413plk.275.2022.06.08.22.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 22:56:55 -0700 (PDT)
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
Date:   Wed,  8 Jun 2022 22:56:46 -0700
Message-Id: <20220609055652.938821-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609055652.938821-1-namhyung@kernel.org>
References: <20220609055652.938821-1-namhyung@kernel.org>
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

