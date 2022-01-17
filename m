Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5191E490B41
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiAQPPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:15:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4419 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbiAQPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:15:37 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JcwNc0cMjz67Psy;
        Mon, 17 Jan 2022 23:11:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 17 Jan 2022 16:15:35 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 15:15:31 +0000
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kjain@linux.ibm.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/3] perf parse-events: Support event alias in form foo-bar-baz
Date:   Mon, 17 Jan 2022 23:10:13 +0800
Message-ID: <1642432215-234089-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1642432215-234089-1-git-send-email-john.garry@huawei.com>
References: <1642432215-234089-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Event aliasing for events whose name in the form foo-bar-baz is not
supported, while foo-bar, foo_bar_baz, and other combinations are, i.e.
two hyphens are not supported.

The HiSilicon D06 platform has events in such form:

$ ./perf list sdir-home-migrate 
  
List of pre-defined events (to be used in -e): 
  
uncore hha:
  sdir-home-migrate 
 [Unit: hisi_sccl,hha]  

$ sudo ./perf stat -e sdir-home-migrate  
event syntax error: 'sdir-home-migrate'  
                        \___ parser error  
Run 'perf list' for a list of valid events  
  
 Usage: perf stat [<options>] [<command>]
  
 -e, --event <event>event selector. use 'perf list' to list available events

To support, add an extra PMU event symbol type for "baz", and add a new
rule in the bison file.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/parse-events.c | 25 +++++++++++++++++++++++--
 tools/perf/util/parse-events.h |  1 +
 tools/perf/util/parse-events.l |  2 ++
 tools/perf/util/parse-events.y | 17 +++++++++++++++--
 4 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index acf20ce98ce9..879f606e07e6 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2098,8 +2098,17 @@ static void perf_pmu__parse_init(void)
 	pmu = NULL;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		list_for_each_entry(alias, &pmu->aliases, list) {
-			if (strchr(alias->name, '-'))
+			char *tmp = strchr(alias->name, '-');
+
+			if (tmp) {
+				char *tmp2 = NULL;
+
+				tmp2 = strchr(tmp + 1, '-');
 				len++;
+				if (tmp2)
+					len++;
+			}
+
 			len++;
 		}
 	}
@@ -2119,8 +2128,20 @@ static void perf_pmu__parse_init(void)
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			struct perf_pmu_event_symbol *p = perf_pmu_events_list + len;
 			char *tmp = strchr(alias->name, '-');
+			char *tmp2 = NULL;
 
-			if (tmp != NULL) {
+			if (tmp)
+				tmp2 = strchr(tmp + 1, '-');
+			if (tmp2) {
+				SET_SYMBOL(strndup(alias->name, tmp - alias->name),
+						PMU_EVENT_SYMBOL_PREFIX);
+				p++;
+				tmp++;
+				SET_SYMBOL(strndup(tmp, tmp2 - tmp), PMU_EVENT_SYMBOL_SUFFIX);
+				p++;
+				SET_SYMBOL(strdup(++tmp2), PMU_EVENT_SYMBOL_SUFFIX2);
+				len += 3;
+			} else if (tmp) {
 				SET_SYMBOL(strndup(alias->name, tmp - alias->name),
 						PMU_EVENT_SYMBOL_PREFIX);
 				p++;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c7fc93f54577..a38b8b160e80 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -53,6 +53,7 @@ enum perf_pmu_event_symbol_type {
 	PMU_EVENT_SYMBOL,		/* normal style PMU event */
 	PMU_EVENT_SYMBOL_PREFIX,	/* prefix of pre-suf style event */
 	PMU_EVENT_SYMBOL_SUFFIX,	/* suffix of pre-suf style event */
+	PMU_EVENT_SYMBOL_SUFFIX2,	/* suffix of pre-suf2 style event */
 };
 
 struct perf_pmu_event_symbol {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 4efe9872c667..5b6e4b5249cf 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -149,6 +149,8 @@ static int pmu_str_check(yyscan_t scanner, struct parse_events_state *parse_stat
 			return PE_PMU_EVENT_PRE;
 		case PMU_EVENT_SYMBOL_SUFFIX:
 			return PE_PMU_EVENT_SUF;
+		case PMU_EVENT_SYMBOL_SUFFIX2:
+			return PE_PMU_EVENT_SUF2;
 		case PMU_EVENT_SYMBOL:
 			return parse_state->fake_pmu
 				? PE_PMU_EVENT_FAKE : PE_KERNEL_PMU_EVENT;
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 174158982fae..be8c51770051 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -69,7 +69,7 @@ static void inc_group_count(struct list_head *list,
 %token PE_NAME_CACHE_TYPE PE_NAME_CACHE_OP_RESULT
 %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
 %token PE_ERROR
-%token PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
+%token PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_PMU_EVENT_SUF2 PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
 %type <num> PE_VALUE
@@ -87,7 +87,7 @@ static void inc_group_count(struct list_head *list,
 %type <str> PE_MODIFIER_EVENT
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
-%type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
+%type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_PMU_EVENT_SUF2 PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
 %type <str> PE_DRV_CFG_TERM
 %type <str> event_pmu_name
 %destructor { free ($$); } <str>
@@ -372,6 +372,19 @@ PE_KERNEL_PMU_EVENT opt_pmu_config
 	$$ = list;
 }
 |
+PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF '-' PE_PMU_EVENT_SUF2 sep_dc
+{
+	struct list_head *list;
+	char pmu_name[128];
+	snprintf(pmu_name, sizeof(pmu_name), "%s-%s-%s", $1, $3, $5);
+	free($1);
+	free($3);
+	free($5);
+	if (parse_events_multi_pmu_add(_parse_state, pmu_name, NULL, &list) < 0)
+		YYABORT;
+	$$ = list;
+}
+|
 PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
 {
 	struct list_head *list;
-- 
2.26.2

