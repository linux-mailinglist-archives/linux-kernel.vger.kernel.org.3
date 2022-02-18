Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9FC4BB6D7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiBRK1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:27:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiBRK1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:27:10 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB55D64F8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:26:54 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x4so6817184plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48kB5lAYgSfFmsICPZUMRy13W44Wv8CdeSdM5zh36Ro=;
        b=W3astCwwAyNQranzslt+8SIVB9svslnNne9hAGV/MpxQw0cP0JbyeBOEZWHKEgcYDw
         eOrC4GquiAZGyMgCCpI9y1/lx0HkTTsehtY3KV73v6w/8qmqjQnPvlTQIvSLjiI0eRu/
         P6UFKhgUola5sBEkHxBF5NPbMKzYmwHN05py0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48kB5lAYgSfFmsICPZUMRy13W44Wv8CdeSdM5zh36Ro=;
        b=YC1eNQ9G0aUIVcjqAqzAUmFveuqs/gkQhfuMJvJlHGZ36dw0iwRxtZsTTPMvv/+Qww
         zqjnBM69klcgM6Ygem3QCLqa5+j4bwb7VPyaEoJN+s7wUpxJy++u8Udfw5jUhj15DSYb
         SRQaRy6XfIAAhKa5mj+Q+TqSaWe7XoCQ+AB8xGWV+QoLgCawqWmt26FSeh3gr5eA3WCi
         IaNX7Bbg+vWFSAaiJHP4Dkt0FTtc8G5yNl8/1gyfnfNd/V0UDQhQ9vnjycCmZMT4GZAQ
         MaNyeZQfpkgW+WHHaESTCDTrEYbYdRxUx6aokk88vV2vDRxB5YzFH2oKprIXHgVMhqto
         Fi0g==
X-Gm-Message-State: AOAM530hZWdwuhaNs1RNB9mtBKr9slV2KOAuGiUmcn5qQTfaGIySKRdw
        fJkJKb9Vqu0jD2/dC+pI7z6XAg==
X-Google-Smtp-Source: ABdhPJw7BKEUMMQFo15QZFrb31FFqmsj+eQYpuHpVdwZyvtZncX1W/2Fxnh8PllN3pxemTfjNuGIkQ==
X-Received: by 2002:a17:902:6902:b0:14d:6aa4:f3f5 with SMTP id j2-20020a170902690200b0014d6aa4f3f5mr6987246plk.20.1645180013550;
        Fri, 18 Feb 2022 02:26:53 -0800 (PST)
Received: from localhost.localdomain ([210.107.197.32])
        by smtp.googlemail.com with ESMTPSA id k13sm2767696pfc.176.2022.02.18.02.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 02:26:53 -0800 (PST)
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     akpm@linux-foundation.org
Cc:     Jonghyeon Kim <tome01@ajou.ac.kr>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/3] mm/damon: Rebase damos watermarks for NUMA systems
Date:   Fri, 18 Feb 2022 19:26:09 +0900
Message-Id: <20220218102611.31895-2-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218102611.31895-1-tome01@ajou.ac.kr>
References: <20220218102611.31895-1-tome01@ajou.ac.kr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For NUMA systems, there is a need to allow damos to select watermark
options for monitoring each NUMA node or whole system free memory. Even
if we do not use NUMA, since the default NUMA node number is 0, we can
monitor the whole system memory without any configuration.

Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 14 ++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 49c4a11ecf20..c0adf1566603 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -170,6 +170,7 @@ enum damos_wmark_metric {
  * @high:	High watermark.
  * @mid:	Middle watermark.
  * @low:	Low watermark.
+ * @node:	NUMA node for the watermarks.
  *
  * If &metric is &DAMOS_WMARK_NONE, the scheme is always active.  Being active
  * means DAMON does monitoring and applying the action of the scheme to
@@ -186,6 +187,7 @@ struct damos_watermarks {
 	unsigned long high;
 	unsigned long mid;
 	unsigned long low;
+	int node;
 
 /* private: */
 	bool activated;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 82e0a4620c4f..290c9c0535ee 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -179,6 +179,7 @@ struct damos *damon_new_scheme(
 	scheme->wmarks.high = wmarks->high;
 	scheme->wmarks.mid = wmarks->mid;
 	scheme->wmarks.low = wmarks->low;
+	scheme->wmarks.node = wmarks->node;
 	scheme->wmarks.activated = true;
 
 	return scheme;
@@ -951,14 +952,15 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	return true;
 }
 
-static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
+static unsigned long damos_wmark_metric_value(struct damos_watermarks wmarks)
 {
-	struct sysinfo i;
+	unsigned long nr_total, nr_free;
 
-	switch (metric) {
+	switch (wmarks.metric) {
 	case DAMOS_WMARK_FREE_MEM_RATE:
-		si_meminfo(&i);
-		return i.freeram * 1000 / i.totalram;
+		nr_total = node_present_pages(wmarks.node);
+		nr_free = sum_zone_node_page_state(wmarks.node, NR_FREE_PAGES);
+		return nr_free * 1000 / nr_total;
 	default:
 		break;
 	}
@@ -976,7 +978,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 	if (scheme->wmarks.metric == DAMOS_WMARK_NONE)
 		return 0;
 
-	metric = damos_wmark_metric_value(scheme->wmarks.metric);
+	metric = damos_wmark_metric_value(scheme->wmarks);
 	/* higher than high watermark or lower than low watermark */
 	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
 		if (scheme->wmarks.activated)
-- 
2.17.1

