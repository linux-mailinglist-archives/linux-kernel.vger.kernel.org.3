Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECB05ACCDB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiIEHeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiIEHel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:34:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DB7B7EA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662363280; x=1693899280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lN3H2eUTHjErr7UO1n9h/C3YoVj1ZkePl50qb0ZlvHE=;
  b=By1f4By9wrc7yAUj/oPPv8SjLQIHEYPDqBOKvyftApwaz2PFRz/hhigh
   h59WDmTfAptTsTd/ZzdNvL3+H+X2jr6DPgX8FHVOZIA7+Xn5tiMuRaNzC
   wPoAanizB2eiX8kEySnpF65iXcbnbi6kbd4ge7AQVWTjOHOF7kBMTpq5T
   MA5Hte/UJ7uZMsngmeogL2d931qc7KOsVeHDMv0J0xR6HKbd9af0gPIQR
   nHnp8YTBIsQ/9GKanIVx73fMvcJNNaAfyShNA5Mi0PfqoRFgfeFO5QNau
   pJfvie3YXcsqOpPz1dcgxZMHGgepgrvXnS0V22cR+r2+zkEExH6SDtGG0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="360283464"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="360283464"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:34:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="609595355"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:34:38 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/6] perf tools: Add perf_config_scan()
Date:   Mon,  5 Sep 2022 10:34:19 +0300
Message-Id: <20220905073424.3971-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905073424.3971-1-adrian.hunter@intel.com>
References: <20220905073424.3971-1-adrian.hunter@intel.com>
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
Reviewed-by: Andi Kleen <ak@linux.intel.com>
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

