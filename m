Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877CE5A9548
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiIALBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiIALAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:00:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0CE112EE1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662030048; x=1693566048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4JuSa0rA3IYfbc1uPjs5ktJOF53Z7JxjEPKEsf3ZhHw=;
  b=RINQbBnvgmiWHEMw8mFxMRQFzaOV9cI1NkqKxfa14gc0w/jAa7D7gfgk
   TdiwCWfboSgHSDhGvA1MOsWBIncWiaiu6rOkrCbJ8PkAJaeDEXvHE5fnC
   edeJ19tSM9olNvbJlJw7ssH6tjHDgIv3/LFfz+plxxKd/ZKNH2y4q3UF5
   BoPmt2lisU8cACSL7T/AMOrIMKHSQW5e429zzF5q3nVZWkn2lEJDjEIIn
   WgKK6qLYTw+aveEWLgMP+krYNrf43e9P7BSj9ILCzjL9Ed0+fT+tN50BY
   Xzb7RN1Ixq45f5iJ3h6ivTf2lpSeKGYzINhWMUsV5lHStZntJ4UPShkKx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294424787"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="294424787"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:00:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673799618"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.42.13])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:00:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] perf tools: Add perf_config_scan()
Date:   Thu,  1 Sep 2022 14:00:28 +0300
Message-Id: <20220901110032.9226-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901110032.9226-1-adrian.hunter@intel.com>
References: <20220901110032.9226-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify getting a single config value, add a function to scan a config
variable.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/config.c | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/config.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 60ce5908c664..3f2ae19a1dd4 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -908,3 +908,34 @@ void set_buildid_dir(const char *dir)
 	/* for communicating with external commands */
 	setenv("PERF_BUILDID_DIR", buildid_dir, 1);
 }
+
+struct perf_config_scan_data {
+	const char *name;
+	const char *fmt;
+	va_list args;
+	int ret;
+};
+
+static int perf_config_scan_cb(const char *var, const char *value, void *data)
+{
+	struct perf_config_scan_data *d = data;
+
+	if (!strcmp(var, d->name))
+		d->ret = vsscanf(value, d->fmt, d->args);
+
+	return 0;
+}
+
+int perf_config_scan(const char *name, const char *fmt, ...)
+{
+	struct perf_config_scan_data d = {
+		.name = name,
+		.fmt = fmt,
+	};
+
+	va_start(d.args, fmt);
+	perf_config(perf_config_scan_cb, &d);
+	va_end(d.args);
+
+	return d.ret;
+}
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index 2fd77aaff4d2..2e5e808928a5 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -29,6 +29,7 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 
 int perf_default_config(const char *, const char *, void *);
 int perf_config(config_fn_t fn, void *);
+int perf_config_scan(const char *name, const char *fmt, ...) __scanf(2, 3);
 int perf_config_set(struct perf_config_set *set,
 		    config_fn_t fn, void *data);
 int perf_config_int(int *dest, const char *, const char *);
-- 
2.25.1

