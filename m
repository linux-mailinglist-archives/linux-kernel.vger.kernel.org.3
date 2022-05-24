Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DA8532487
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiEXHzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiEXHzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:55:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17438722C
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653378915; x=1684914915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wlVX3TF3v9W6UCNas3Sk52q6mw1x+2oACY9LNZJEDXk=;
  b=V/5Om1kxErbxTyQnfySAYaUiaKvJSvP6uste0b5sru0OweSVZafu1POQ
   Cs7c3SPaU2gBQLWk1eKgrn8GaUrkpvR2IZ1eBYh6P7NowzmEWH9o/K971
   RzG56cX42GX+Y43ImkBhd7cUH7kfsvXifm8dIjr5twXz9wZhoQ5J5jlrf
   7lkC4v9/J9ulwGBgQiioUG2Bnrk1yjf0SCBC1wSBqgmgIie3IoMMUuTdA
   Yy1VDauc5YlQebayB0l7MU2Z7rcchANbCgrNvnHhRnKg/NE9M3aRD/72l
   dpQMJwnClg90DnbXA2YzW0Ey3ZulnibPpC4SEij+F85IzLumMDwzAzjUL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273455439"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273455439"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717072384"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.210])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:13 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 05/15] perf evlist: Add evlist__add_dummy_on_all_cpus()
Date:   Tue, 24 May 2022 10:54:26 +0300
Message-Id: <20220524075436.29144-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524075436.29144-1-adrian.hunter@intel.com>
References: <20220524075436.29144-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add evlist__add_dummy_on_all_cpus() to enable creating a system-wide dummy
event that sets up the system-wide maps before map propagation.

For convenience, add evlist__add_aux_dummy() so that the logic can be used
whether or not the event needs to be system-wide.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evlist.c | 45 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  5 +++++
 2 files changed, 50 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index efad0e691045..48af7d379d82 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -264,6 +264,51 @@ int evlist__add_dummy(struct evlist *evlist)
 	return 0;
 }
 
+static void evlist__add_on_all_cpus(struct evlist *evlist, struct evsel *evsel)
+{
+	evsel->core.system_wide = true;
+
+	/*
+	 * All CPUs.
+	 *
+	 * Note perf_event_open() does not accept CPUs that are not online, so
+	 * in fact this CPU list will include only all online CPUs.
+	 */
+	perf_cpu_map__put(evsel->core.own_cpus);
+	evsel->core.own_cpus = perf_cpu_map__new(NULL);
+	perf_cpu_map__put(evsel->core.cpus);
+	evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
+
+	/* No threads */
+	perf_thread_map__put(evsel->core.threads);
+	evsel->core.threads = perf_thread_map__new_dummy();
+
+	evlist__add(evlist, evsel);
+}
+
+struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
+{
+	struct evsel *evsel = evlist__dummy_event(evlist);
+
+	if (!evsel)
+		return NULL;
+
+	evsel->core.attr.exclude_kernel = 1;
+	evsel->core.attr.exclude_guest = 1;
+	evsel->core.attr.exclude_hv = 1;
+	evsel->core.attr.freq = 0;
+	evsel->core.attr.sample_period = 1;
+	evsel->no_aux_samples = true;
+	evsel->name = strdup("dummy:u");
+
+	if (system_wide)
+		evlist__add_on_all_cpus(evlist, evsel);
+	else
+		evlist__add(evlist, evsel);
+
+	return evsel;
+}
+
 static int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
 {
 	struct evsel *evsel, *n;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 4062f5aebfc1..1bde9ccf4e7d 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -114,6 +114,11 @@ int arch_evlist__add_default_attrs(struct evlist *evlist);
 struct evsel *arch_evlist__leader(struct list_head *list);
 
 int evlist__add_dummy(struct evlist *evlist);
+struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
+static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
+{
+	return evlist__add_aux_dummy(evlist, true);
+}
 
 int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
 			 evsel__sb_cb_t cb, void *data);
-- 
2.25.1

