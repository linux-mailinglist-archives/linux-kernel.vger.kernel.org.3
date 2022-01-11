Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C6048AF61
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbiAKOVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:21:13 -0500
Received: from forward500o.mail.yandex.net ([37.140.190.195]:59498 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241774AbiAKOVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:21:11 -0500
Received: from sas1-49a2f795d8eb.qloud-c.yandex.net (sas1-49a2f795d8eb.qloud-c.yandex.net [IPv6:2a02:6b8:c08:c505:0:640:49a2:f795])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 427B9942363;
        Tue, 11 Jan 2022 17:21:06 +0300 (MSK)
Received: from sas1-37da021029ee.qloud-c.yandex.net (sas1-37da021029ee.qloud-c.yandex.net [2a02:6b8:c08:1612:0:640:37da:210])
        by sas1-49a2f795d8eb.qloud-c.yandex.net (mxback/Yandex) with ESMTP id EikuKe4oJT-L4fOE3jQ;
        Tue, 11 Jan 2022 17:21:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1641910866;
        bh=O4dtUcfS47xQno2hdUMnHIDEsNKgjBtaKVEzsBNYXP8=;
        h=In-Reply-To:References:Date:Subject:To:From:Message-Id:Cc;
        b=F+2B6vkQDohj597k8vuzWQIrElSFb18VybmU4LaN/oUjX7A/ncZpeJsdxmmuVnACL
         u6apa4GdfSspErYvCmLQYl4ZbNZbjjJJpRygR7IyM8oQQBIc7mVTctoJxslR3UJ0QM
         jxwEdW6ygJXzB9v+J1HD59CVMjg34TC9+PN7mHzM=
Authentication-Results: sas1-49a2f795d8eb.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas1-37da021029ee.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id l3U269SIUy-L3Pq5u6g;
        Tue, 11 Jan 2022 17:21:04 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
        linux@yadro.com, Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] perf tools: Add 'm' event modifier for counting machine
Date:   Tue, 11 Jan 2022 17:20:48 +0300
Message-Id: <20220111142054.18733-2-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111142054.18733-1-nikita.shubin@maquefel.me>
References: <20220111142054.18733-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <n.shubin@yadro.com>

Adding 'm' event modifier for machine mode counting.

Any event specified with 'm', will set exclude_machine to zero.

Default behavior is setting exclude_machine to zero, unless kernel or
user specified explicitly.

Adding automated tests.

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
 include/uapi/linux/perf_event.h        |  3 ++-
 tools/include/uapi/linux/perf_event.h  |  3 ++-
 tools/perf/Documentation/perf-list.txt |  1 +
 tools/perf/tests/parse-events.c        | 18 ++++++++++++++++++
 tools/perf/util/evsel.c                |  4 +++-
 tools/perf/util/parse-events.c         | 18 +++++++++++++-----
 tools/perf/util/parse-events.l         |  2 +-
 7 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bd8860eeb291..b70c245664eb 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -409,7 +409,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				exclude_machine:  1, /* don't count M-Mode */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index bd8860eeb291..17f4d3ac10da 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -409,7 +409,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				exclude_machine:  1, /* don't count events in M-Mode */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 4dc8d0af19df..e6d10d95df70 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -53,6 +53,7 @@ counted. The following modifiers exist:
 
  u - user-space counting
  k - kernel counting
+ m - machine counting
  h - hypervisor counting
  I - non idle counting
  G - guest counting (in KVM guests)
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index a508f1dbcb2a..617a66003648 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1323,6 +1323,19 @@ static int test__exclusive_group(struct evlist *evlist)
 
 	return 0;
 }
+
+static int test__checkevent_exclude_machine_modifier(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
+	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+	TEST_ASSERT_VAL("wrong exclude_machine", !evsel->core.attr.exclude_machine);
+	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+
+	return test__checkevent_symbolic_name(evlist);
+}
+
 static int test__checkevent_breakpoint_len(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
@@ -1943,6 +1956,11 @@ static struct evlist_test test__events[] = {
 		.check = test__exclusive_group,
 		.id    = 57,
 	},
+	{
+		.name  = "instructions:m",
+		.check = test__checkevent_exclude_machine_modifier,
+		.id    = 58,
+	},
 };
 
 static struct evlist_test test__events_pmu[] = {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a59fb2ecb84e..a49c995908dc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -542,9 +542,11 @@ static int evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
 			r += scnprintf(bf + r, size - r, "%c", mod);	\
 		} } while(0)
 
-	if (attr->exclude_kernel || attr->exclude_user || attr->exclude_hv) {
+	if (attr->exclude_kernel || attr->exclude_user ||
+	    attr->exclude_hv || attr->exclude_machine) {
 		MOD_PRINT(kernel, 'k');
 		MOD_PRINT(user, 'u');
+		MOD_PRINT(machine, 'm');
 		MOD_PRINT(hv, 'h');
 		exclude_guest_default = true;
 	}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5bfb6f892489..920397e1b959 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1867,6 +1867,7 @@ struct event_modifier {
 	int weak;
 	int exclusive;
 	int bpf_counter;
+	int em;
 };
 
 static int get_event_modifier(struct event_modifier *mod, char *str,
@@ -1874,6 +1875,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 {
 	int eu = evsel ? evsel->core.attr.exclude_user : 0;
 	int ek = evsel ? evsel->core.attr.exclude_kernel : 0;
+	int em = evsel ? evsel->core.attr.exclude_machine : 0;
 	int eh = evsel ? evsel->core.attr.exclude_hv : 0;
 	int eH = evsel ? evsel->core.attr.exclude_host : 0;
 	int eG = evsel ? evsel->core.attr.exclude_guest : 0;
@@ -1884,7 +1886,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	int pinned = evsel ? evsel->core.attr.pinned : 0;
 	int exclusive = evsel ? evsel->core.attr.exclusive : 0;
 
-	int exclude = eu | ek | eh;
+	int exclude = eu | ek | eh | em;
 	int exclude_GH = evsel ? evsel->exclude_GH : 0;
 	int weak = 0;
 	int bpf_counter = 0;
@@ -1894,17 +1896,17 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	while (*str) {
 		if (*str == 'u') {
 			if (!exclude)
-				exclude = eu = ek = eh = 1;
+				exclude = eu = ek = eh = em = 1;
 			if (!exclude_GH && !perf_guest)
 				eG = 1;
 			eu = 0;
 		} else if (*str == 'k') {
 			if (!exclude)
-				exclude = eu = ek = eh = 1;
+				exclude = eu = ek = eh = em = 1;
 			ek = 0;
 		} else if (*str == 'h') {
 			if (!exclude)
-				exclude = eu = ek = eh = 1;
+				exclude = eu = ek = eh = em = 1;
 			eh = 0;
 		} else if (*str == 'G') {
 			if (!exclude_GH)
@@ -1933,6 +1935,10 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 			weak = 1;
 		} else if (*str == 'b') {
 			bpf_counter = 1;
+		} else if (*str == 'm') {
+			if (!exclude)
+				exclude = eu = ek = eh = em = 1;
+			em = 0;
 		} else
 			break;
 
@@ -1958,6 +1964,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 	mod->eH = eH;
 	mod->eG = eG;
 	mod->eI = eI;
+	mod->em = em;
 	mod->precise = precise;
 	mod->precise_max = precise_max;
 	mod->exclude_GH = exclude_GH;
@@ -1979,7 +1986,7 @@ static int check_modifier(char *str)
 	char *p = str;
 
 	/* The sizeof includes 0 byte as well. */
-	if (strlen(str) > (sizeof("ukhGHpppPSDIWeb") - 1))
+	if (strlen(str) > (sizeof("ukmhGHpppPSDIWeb") - 1))
 		return -1;
 
 	while (*p) {
@@ -2011,6 +2018,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 
 		evsel->core.attr.exclude_user   = mod.eu;
 		evsel->core.attr.exclude_kernel = mod.ek;
+		evsel->core.attr.exclude_machine= mod.em;
 		evsel->core.attr.exclude_hv     = mod.eh;
 		evsel->core.attr.precise_ip     = mod.precise;
 		evsel->core.attr.exclude_host   = mod.eH;
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 4efe9872c667..5528a52611de 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -214,7 +214,7 @@ name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
-modifier_event	[ukhpPGHSDIWeb]+
+modifier_event	[ukhpPGHSDIWebm]+
 modifier_bp	[rwx]{1,3}
 
 %%
-- 
2.31.1

