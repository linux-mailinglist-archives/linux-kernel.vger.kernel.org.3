Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BF84E5BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345373AbiCWXEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242839AbiCWXEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:04:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101B32DE8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:03:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id h19so1580560pfv.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMMDCHA3Iyy/QwFc9kLFZocDlfrWm0gw7qw8ORPG4hk=;
        b=O8G4ulrjv5h8bRyER8e3dbSE35yK1zcjpepACkbfmod5irrGOpABg/dr091a4l/Ph6
         IiPevbw0GimBGcolRAArMRTIqrl4CpCO47mT8d07561uJvUO+1JIDoEHT+r5lxCKsdSF
         0L38mLOsIL+7uYImUQTQ2zgLeTsQjPOHRPicmu7RI+koX1L0hHoS1rindqPUkzCOI1bm
         yCuX/0QS9geql3mVlYAQErfi6Hd7y64+lIAreVg3SSrv/lKgXCaDGm0cXhcRfWcl708X
         CqX4KM7W2MtmsTis7Phbtgc6Qcpp+fA/50R0GI7l1AFEmgmX9mmkcSXRZNeRvjlHEVV8
         pu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nMMDCHA3Iyy/QwFc9kLFZocDlfrWm0gw7qw8ORPG4hk=;
        b=rXwbcAFoL/5Xn+jIVLSHK3mVjViriX8nUBhLP0zZrtpfZADYUtfMGh0unCXQhoCZg9
         LFjzRnucW+V6BMDtOdkbTvotkGo6pXNdG/GB9gCUo+Mn0GqLGOVkpmf1yK0Di/ToVICY
         eWCMkva+KgjFMLuBEkLB3gjL9vf401EKMgvTK3g0i5X/xH26WMz+qmwCDXXdeWc5rlzr
         NCT6vDUAm+F7aFr+uwo9uaeVecLKvAeoCt9+84QwRs1TelN2vxO0PQBKxsyrlF1cMm2Z
         ZdP3yCwNuwAjB/Jc3/WPFNN6G7SCZG4AwWI4/+RPsbmRB2YXgYr5JjYIbQE3HbK+kZIE
         vBmQ==
X-Gm-Message-State: AOAM531gnKnWFG6jgEXR4tsE3UxqsA6C+iowdGPJtpHLCP7YU5VzO4y4
        AkPNadPEjseqUPcDM/hvf/Y=
X-Google-Smtp-Source: ABdhPJwuO/9uGli2jLyZsvjZxiaJjey5Ry1LGzGOKxyT1e6vKj3buSfojE6WOx5VVO6AKvooPUL4BA==
X-Received: by 2002:a65:6713:0:b0:382:3e2e:9ae9 with SMTP id u19-20020a656713000000b003823e2e9ae9mr1642193pgf.469.1648076586298;
        Wed, 23 Mar 2022 16:03:06 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:3d99:beb8:c76f:446c])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090adac100b001c67cedd84esm637382pjx.42.2022.03.23.16.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 16:03:05 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 3/3] perf lock: Add -F/--field option to control output
Date:   Wed, 23 Mar 2022 16:02:59 -0700
Message-Id: <20220323230259.288494-3-namhyung@kernel.org>
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

The -F/--field option is to customize output field.

  $ perf lock report -F contended,wait_max -k avg_wait
                  Name  contended   max wait (ns)   avg wait (ns)

        slock-AF_INET6          1           23543           23543
     &lruvec->lru_lock          5           18317           11254
        slock-AF_INET6          1           10379           10379
            rcu_node_1          1            2104            2104
   &dentry->d_lockr...          1            1844            1844
   &dentry->d_lockr...          1            1672            1672
      &newf->file_lock         15            2279            1025
   &dentry->d_lockr...          1             792             792

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt |  6 +++
 tools/perf/builtin-lock.c              | 55 +++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index f5eb95788969..b43222229807 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -54,6 +54,12 @@ REPORT OPTIONS
         Sorting key. Possible values: acquired (default), contended,
 	avg_wait, wait_total, wait_max, wait_min.
 
+-F::
+--field=<value>::
+        Output fields. By default it shows all the fields but users can
+	customize that using this.  Possible values: acquired, contended,
+	avg_wait, wait_total, wait_max, wait_min.
+
 -c::
 --combine-locks::
 	Merge lock instances in the same class (based on name).
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index c2ecb6acb87d..a7089760a7de 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -282,6 +282,7 @@ static struct rb_root		sorted; /* place to store intermediate data */
 static struct rb_root		result;	/* place to store sorted data */
 
 static LIST_HEAD(lock_keys);
+static const char		*output_fields;
 
 #define DEF_KEY_LOCK(name, header, fn_suffix, len)			\
 	{ #name, header, len, lock_stat_key_ ## fn_suffix, lock_stat_key_print_ ## fn_suffix, {} }
@@ -304,23 +305,65 @@ static int select_key(void)
 	for (i = 0; keys[i].name; i++) {
 		if (!strcmp(keys[i].name, sort_key)) {
 			compare = keys[i].key;
+
+			/* selected key should be in the output fields */
+			if (list_empty(&keys[i].list))
+				list_add_tail(&keys[i].list, &lock_keys);
+
 			return 0;
 		}
 	}
 
 	pr_err("Unknown compare key: %s\n", sort_key);
-
 	return -1;
 }
 
-static int setup_output_field(void)
+static int add_output_field(struct list_head *head, char *name)
 {
 	int i;
 
+	for (i = 0; keys[i].name; i++) {
+		if (strcmp(keys[i].name, name))
+			continue;
+
+		/* prevent double link */
+		if (list_empty(&keys[i].list))
+			list_add_tail(&keys[i].list, head);
+
+		return 0;
+	}
+
+	pr_err("Unknown output field: %s\n", name);
+	return -1;
+}
+
+static int setup_output_field(const char *str)
+{
+	char *tok, *tmp, *orig;
+	int i, ret = 0;
+
+	/* no output field given: use all of them */
+	if (str == NULL) {
+		for (i = 0; keys[i].name; i++)
+			list_add_tail(&keys[i].list, &lock_keys);
+		return 0;
+	}
+
 	for (i = 0; keys[i].name; i++)
-		list_add_tail(&keys[i].list, &lock_keys);
+		INIT_LIST_HEAD(&keys[i].list);
 
-	return 0;
+	orig = tmp = strdup(str);
+	if (orig == NULL)
+		return -ENOMEM;
+
+	while ((tok = strsep(&tmp, ",")) != NULL){
+		ret = add_output_field(&lock_keys, tok);
+		if (ret < 0)
+			break;
+	}
+	free(orig);
+
+	return ret;
 }
 
 static void combine_lock_stats(struct lock_stat *st)
@@ -1002,7 +1045,7 @@ static int __cmd_report(bool display_info)
 		goto out_delete;
 	}
 
-	if (setup_output_field())
+	if (setup_output_field(output_fields))
 		goto out_delete;
 
 	if (select_key())
@@ -1090,6 +1133,8 @@ int cmd_lock(int argc, const char **argv)
 	const struct option report_options[] = {
 	OPT_STRING('k', "key", &sort_key, "acquired",
 		    "key for sorting (acquired / contended / avg_wait / wait_total / wait_max / wait_min)"),
+	OPT_STRING('F', "field", &output_fields, NULL,
+		    "output fields (acquired / contended / avg_wait / wait_total / wait_max / wait_min)"),
 	/* TODO: type */
 	OPT_BOOLEAN('c', "combine-locks", &combine_locks,
 		    "combine locks in the same class"),
-- 
2.35.1.894.gb6a874cedc-goog

