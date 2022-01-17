Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52D8490B43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbiAQPPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:15:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4421 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbiAQPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:15:44 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JcwPh0kmhz67fK4;
        Mon, 17 Jan 2022 23:12:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 17 Jan 2022 16:15:42 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 15:15:38 +0000
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kjain@linux.ibm.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 3/3] perf test: Add parse-events test for aliases with hyphens
Date:   Mon, 17 Jan 2022 23:10:15 +0800
Message-ID: <1642432215-234089-4-git-send-email-john.garry@huawei.com>
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

Add a test which allows us to test parsing an event alias with hyphens.

Since these events typically do not exist on most host systems, add the
alias to the fake pmu.

Function perf_pmu__test_parse_init() has terms added to match known test
aliases.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/tests/parse-events.c | 49 +++++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.c  | 42 ++++++++++++++++++++++------
 2 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index a508f1dbcb2a..e71efadb24f5 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2069,6 +2069,31 @@ static int test_event(struct evlist_test *e)
 	return ret;
 }
 
+static int test_event_fake_pmu(const char *str)
+{
+	struct parse_events_error err;
+	struct evlist *evlist;
+	int ret;
+
+	evlist = evlist__new();
+	if (!evlist)
+		return -ENOMEM;
+
+	parse_events_error__init(&err);
+	perf_pmu__test_parse_init();
+	ret = __parse_events(evlist, str, &err, &perf_pmu__fake);
+	if (ret) {
+		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
+			 str, ret, err.str);
+		parse_events_error__print(&err, str);
+	}
+
+	parse_events_error__exit(&err);
+	evlist__delete(evlist);
+
+	return ret;
+}
+
 static int test_events(struct evlist_test *events, unsigned cnt)
 {
 	int ret1, ret2 = 0;
@@ -2276,6 +2301,26 @@ static int test_pmu_events_alias(char *event, char *alias)
 	return test_event(&e);
 }
 
+static int test_pmu_events_alias2(void)
+{
+	static const char events[][30] = {
+			"event-hyphen",
+			"event-two-hyph",
+	};
+	unsigned long i;
+	int ret = 0;
+
+	for (i = 0; i < ARRAY_SIZE(events); i++) {
+		ret = test_event_fake_pmu(&events[i][0]);
+		if (ret) {
+			pr_err("check_parse_fake %s failed\n", &events[i][0]);
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static int test__parse_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret1, ret2 = 0;
@@ -2313,6 +2358,10 @@ do {							\
 			return ret;
 	}
 
+	ret1 = test_pmu_events_alias2();
+	if (!ret2)
+		ret2 = ret1;
+
 	ret1 = test_terms(test__terms, ARRAY_SIZE(test__terms));
 	if (!ret2)
 		ret2 = ret1;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 879f606e07e6..9739b05b999e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1697,6 +1697,15 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			}
 		}
 	}
+
+	if (parse_state->fake_pmu) {
+		if (!parse_events_add_pmu(parse_state, list, str, head,
+					  true, true)) {
+			pr_debug("%s -> %s/%s/\n", str, "fake_pmu", str);
+			ok++;
+		}
+	}
+
 out_err:
 	if (ok)
 		*listp = list;
@@ -2168,23 +2177,38 @@ static void perf_pmu__parse_init(void)
  */
 int perf_pmu__test_parse_init(void)
 {
-	struct perf_pmu_event_symbol *list;
+	struct perf_pmu_event_symbol *list, *tmp, symbols[] = {
+		{(char *)"read", PMU_EVENT_SYMBOL},
+		{(char *)"event", PMU_EVENT_SYMBOL_PREFIX},
+		{(char *)"two", PMU_EVENT_SYMBOL_SUFFIX},
+		{(char *)"hyphen", PMU_EVENT_SYMBOL_SUFFIX},
+		{(char *)"hyph", PMU_EVENT_SYMBOL_SUFFIX2},
+	};
+	unsigned long i, j;
 
-	list = malloc(sizeof(*list) * 1);
+	tmp = list = malloc(sizeof(*list) * ARRAY_SIZE(symbols));
 	if (!list)
 		return -ENOMEM;
 
-	list->type   = PMU_EVENT_SYMBOL;
-	list->symbol = strdup("read");
-
-	if (!list->symbol) {
-		free(list);
-		return -ENOMEM;
+	for (i = 0; i < ARRAY_SIZE(symbols); i++, tmp++) {
+		tmp->type = symbols[i].type;
+		tmp->symbol = strdup(symbols[i].symbol);
+		if (!list->symbol)
+			goto err_free;
 	}
 
 	perf_pmu_events_list = list;
-	perf_pmu_events_list_num = 1;
+	perf_pmu_events_list_num = ARRAY_SIZE(symbols);
+
+	qsort(perf_pmu_events_list, ARRAY_SIZE(symbols),
+	      sizeof(struct perf_pmu_event_symbol), comp_pmu);
 	return 0;
+
+err_free:
+	for (j = 0, tmp = list; j < i; j++, tmp++)
+		free(tmp->symbol);
+	free(list);
+	return -ENOMEM;
 }
 
 enum perf_pmu_event_symbol_type
-- 
2.26.2

