Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310BB4E5BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245370AbiCWXEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241349AbiCWXEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:04:36 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F4ED78
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:03:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso3330423pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ti+rxiaOYBHheWD6I0Cp8uyD8pEA4R+X+NOSPieN6BQ=;
        b=qgbvTcMMh/6mu+PteMwGd50UEkutDrfaSZkYrHbJrVr5gQKUuafiISBiKbKxrC9KZr
         Y11GJN5NJVish+G/nVABKWS1KSqhnUmY8P0qfOe3dtbOI+sPBQvVuH0pohUCGrrk/vbR
         5eU2/FDvwrLnSiULnhx0vCuCRGAzL+aHeztgtOknFJeGZ+oYhHj4GRZ+Ls+Mg0fkuL53
         hbbt2qvd6Rm2TATPFD2kpP6OoPdW8Hrp+ZmZjUKw+Tzcx3Ao2Ltc1ccMBeGlJS04IdVH
         taCSDBjfpo+FQ5BH8KM866TJWkdBph2POFgtYNwQp7gJ7/IPUhbi0pq59y96DsRPFg1P
         nRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ti+rxiaOYBHheWD6I0Cp8uyD8pEA4R+X+NOSPieN6BQ=;
        b=hzIVi2EFPrmKygVQSFpbkNOetlrSoPcXsNfaGWDkavR98Rx0Mdi3KxGNhc1B0XtLcU
         KUIB81kGuUbjL0x5NJY38FwLYgl3hwrOyP4dC/yOjvBg6d6VIiYj154b6lhxe4hV9X/h
         ZphNPHSmc78GoUC/IJhCym7badb1VA/QWNg2iwEFSy3XOsLTZricQfegud0sFwMGk/FX
         +9NFn3ejOg1Wki1mvf5LFh2jgWNll8Yh8jN7UjC1Xxuz+NC8gtqWIe0XVSik0C2Pw7tT
         JhrGnPVSifAJ1oJYgtTu01mN4vSU7YODRcuNpScxq0UW8vxJ8n/Y5TQfok6zhHnIaUvO
         RCRg==
X-Gm-Message-State: AOAM532mS2WsqdmYuMJRzfL7qstEuOQDri89ZwTmyvlWnJLc2MoQck8p
        iTHpy8/f5WvpIKoOd9PsCWc=
X-Google-Smtp-Source: ABdhPJyI1zakfUuJnm2rQSd+VAWKt8LfPitcI9cakRrHqzDVbtS7R5ReHc9Yyh6+PGRjolhrHMUqHQ==
X-Received: by 2002:a17:90a:fcc:b0:1c6:62b5:45c0 with SMTP id 70-20020a17090a0fcc00b001c662b545c0mr2381293pjz.133.1648076584571;
        Wed, 23 Mar 2022 16:03:04 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:3d99:beb8:c76f:446c])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090adac100b001c67cedd84esm637382pjx.42.2022.03.23.16.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 16:03:03 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/3] perf lock: Extend struct lock_key to have print function
Date:   Wed, 23 Mar 2022 16:02:58 -0700
Message-Id: <20220323230259.288494-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220323230259.288494-1-namhyung@kernel.org>
References: <20220323230259.288494-1-namhyung@kernel.org>
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

And use it to print output for each key field.  No functional change
intended and the output should be identical.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 91 ++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 1ebff88bc5ba..c2ecb6acb87d 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -237,9 +237,43 @@ struct lock_key {
 	 * e.g. nr_acquired -> acquired, wait_time_total -> wait_total
 	 */
 	const char		*name;
+	/* header: the string printed on the header line */
+	const char		*header;
+	/* len: the printing width of the field */
+	int			len;
+	/* key: a pointer to function to compare two lock stats for sorting */
 	int			(*key)(struct lock_stat*, struct lock_stat*);
+	/* print: a pointer to function to print a given lock stats */
+	void			(*print)(struct lock_key*, struct lock_stat*);
+	/* list: list entry to link this */
+	struct list_head	list;
 };
 
+#define PRINT_KEY(member)						\
+static void lock_stat_key_print_ ## member(struct lock_key *key,	\
+					   struct lock_stat *ls)	\
+{									\
+	pr_info("%*llu", key->len, (unsigned long long)ls->member);	\
+}
+
+PRINT_KEY(nr_acquired)
+PRINT_KEY(nr_contended)
+PRINT_KEY(avg_wait_time)
+PRINT_KEY(wait_time_total)
+PRINT_KEY(wait_time_max)
+
+static void lock_stat_key_print_wait_time_min(struct lock_key *key,
+					      struct lock_stat *ls)
+{
+	u64 wait_time = ls->wait_time_min;
+
+	if (wait_time == ULLONG_MAX)
+		wait_time = 0;
+
+	pr_info("%*"PRIu64, key->len, wait_time);
+}
+
+
 static const char		*sort_key = "acquired";
 
 static int			(*compare)(struct lock_stat *, struct lock_stat *);
@@ -247,19 +281,20 @@ static int			(*compare)(struct lock_stat *, struct lock_stat *);
 static struct rb_root		sorted; /* place to store intermediate data */
 static struct rb_root		result;	/* place to store sorted data */
 
-#define DEF_KEY_LOCK(name, fn_suffix)	\
-	{ #name, lock_stat_key_ ## fn_suffix }
+static LIST_HEAD(lock_keys);
+
+#define DEF_KEY_LOCK(name, header, fn_suffix, len)			\
+	{ #name, header, len, lock_stat_key_ ## fn_suffix, lock_stat_key_print_ ## fn_suffix, {} }
 struct lock_key keys[] = {
-	DEF_KEY_LOCK(acquired, nr_acquired),
-	DEF_KEY_LOCK(contended, nr_contended),
-	DEF_KEY_LOCK(avg_wait, avg_wait_time),
-	DEF_KEY_LOCK(wait_total, wait_time_total),
-	DEF_KEY_LOCK(wait_min, wait_time_min),
-	DEF_KEY_LOCK(wait_max, wait_time_max),
+	DEF_KEY_LOCK(acquired, "acquired", nr_acquired, 10),
+	DEF_KEY_LOCK(contended, "contended", nr_contended, 10),
+	DEF_KEY_LOCK(avg_wait, "avg wait (ns)", avg_wait_time, 15),
+	DEF_KEY_LOCK(wait_total, "total wait (ns)", wait_time_total, 15),
+	DEF_KEY_LOCK(wait_max, "max wait (ns)", wait_time_max, 15),
+	DEF_KEY_LOCK(wait_min, "min wait (ns)", wait_time_min, 15),
 
 	/* extra comparisons much complicated should be here */
-
-	{ NULL, NULL }
+	{ }
 };
 
 static int select_key(void)
@@ -278,6 +313,16 @@ static int select_key(void)
 	return -1;
 }
 
+static int setup_output_field(void)
+{
+	int i;
+
+	for (i = 0; keys[i].name; i++)
+		list_add_tail(&keys[i].list, &lock_keys);
+
+	return 0;
+}
+
 static void combine_lock_stats(struct lock_stat *st)
 {
 	struct rb_node **rb = &sorted.rb_node;
@@ -753,18 +798,13 @@ static void print_bad_events(int bad, int total)
 static void print_result(void)
 {
 	struct lock_stat *st;
+	struct lock_key *key;
 	char cut_name[20];
 	int bad, total;
 
 	pr_info("%20s ", "Name");
-	pr_info("%10s ", "acquired");
-	pr_info("%10s ", "contended");
-
-	pr_info("%15s ", "avg wait (ns)");
-	pr_info("%15s ", "total wait (ns)");
-	pr_info("%15s ", "max wait (ns)");
-	pr_info("%15s ", "min wait (ns)");
-
+	list_for_each_entry(key, &lock_keys, list)
+		pr_info("%*s ", key->len, key->header);
 	pr_info("\n\n");
 
 	bad = total = 0;
@@ -789,14 +829,10 @@ static void print_result(void)
 			pr_info("%20s ", cut_name);
 		}
 
-		pr_info("%10u ", st->nr_acquired);
-		pr_info("%10u ", st->nr_contended);
-
-		pr_info("%15" PRIu64 " ", st->avg_wait_time);
-		pr_info("%15" PRIu64 " ", st->wait_time_total);
-		pr_info("%15" PRIu64 " ", st->wait_time_max);
-		pr_info("%15" PRIu64 " ", st->wait_time_min == ULLONG_MAX ?
-		       0 : st->wait_time_min);
+		list_for_each_entry(key, &lock_keys, list) {
+			key->print(key, st);
+			pr_info(" ");
+		}
 		pr_info("\n");
 	}
 
@@ -966,6 +1002,9 @@ static int __cmd_report(bool display_info)
 		goto out_delete;
 	}
 
+	if (setup_output_field())
+		goto out_delete;
+
 	if (select_key())
 		goto out_delete;
 
-- 
2.35.1.894.gb6a874cedc-goog

