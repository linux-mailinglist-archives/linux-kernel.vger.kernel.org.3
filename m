Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D225ACCFA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiIEHez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbiIEHep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:34:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6123896
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662363282; x=1693899282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3r43ozO5o3LW7es3yU2gjxRciQTWNjs0tWKqgyuYGBw=;
  b=nZTLU8as9ey69YEleUVU6NSdnnjPIRSGu2BLo1+4DBeolONemwIYhvHR
   VeoyOeb5O6pTNYs2sPJiSz4djSoGTVsYVkH+vIszPwrDlaGCrp9Ypoiyv
   Br60B9xUFxO2qvWFA+Y5ls9d7FWKOWZeK9AL+sr/ZEPT6Yu2qYTCxLhvr
   iAkma/S8HE4vkx5JsyEtVTpbHJDbuaIvg65m141mS3IX+aMX8jKjycg20
   4Zxl2DuqPk8Yg3SEcFsCjk5j3Tp1M5n/FIjHbzRujTy3F7AGO2qSxybAa
   2bkImeJsXjYJ8wd8iuk9NGiwyTwliWfcmKbCGU/7sCRZUDvrhEVhzAlUo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="360283484"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="360283484"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:34:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="609595367"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:34:40 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/6] perf auxtrace: Add itrace option flag d+e to log on error
Date:   Mon,  5 Sep 2022 10:34:20 +0300
Message-Id: <20220905073424.3971-3-adrian.hunter@intel.com>
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

Add flag +e to the itrace d (decoder debug log) option to get output only
on decoding errors.

The log can be very big so reducing the output to where there are decoding
errors can be useful for analyzing errors.

By default, the log size in that case is 16384 bytes, but can be altered by
perf config e.g. perf config itrace.debug-log-buffer-size=30000

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/itrace.txt      |  1 +
 tools/perf/Documentation/perf-config.txt |  7 +++++++
 tools/perf/util/auxtrace.c               | 13 +++++++++++++
 tools/perf/util/auxtrace.h               |  3 +++
 4 files changed, 24 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 6b189669c450..0916bbfe64cb 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -64,6 +64,7 @@
 	debug messages will or will not be logged. Each flag must be preceded
 	by either '+' or '-'. The flags are:
 		a	all perf events
+		e	output only on errors (size configurable - see linkperf:perf-config[1])
 		o	output to stdout
 
 	If supported, the 'q' option may be repeated to increase the effect.
diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 0420e71698ee..39c890ead2dc 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -729,6 +729,13 @@ auxtrace.*::
 		If the directory does not exist or has the wrong file type,
 		the current directory is used.
 
+itrace.*::
+
+	debug-log-buffer-size::
+		Log size in bytes to output when using the option --itrace=d+e
+		Refer 'itrace' option of linkperf:perf-script[1] or
+		linkperf:perf-report[1]. The default is 16384.
+
 daemon.*::
 
 	daemon.base::
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 6edab8a16de6..b59c278fe9ed 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/zalloc.h>
 
+#include "config.h"
 #include "evlist.h"
 #include "dso.h"
 #include "map.h"
@@ -1434,6 +1435,16 @@ static int get_flags(const char **ptr, unsigned int *plus_flags, unsigned int *m
 	}
 }
 
+#define ITRACE_DFLT_LOG_ON_ERROR_SZ 16384
+
+static unsigned int itrace_log_on_error_size(void)
+{
+	unsigned int sz = 0;
+
+	perf_config_scan("itrace.debug-log-buffer-size", "%u", &sz);
+	return sz ?: ITRACE_DFLT_LOG_ON_ERROR_SZ;
+}
+
 /*
  * Please check tools/perf/Documentation/perf-script.txt for information
  * about the options parsed here, which is introduced after this cset,
@@ -1532,6 +1543,8 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 			if (get_flags(&p, &synth_opts->log_plus_flags,
 				      &synth_opts->log_minus_flags))
 				goto out_err;
+			if (synth_opts->log_plus_flags & AUXTRACE_LOG_FLG_ON_ERROR)
+				synth_opts->log_on_error_size = itrace_log_on_error_size();
 			break;
 		case 'c':
 			synth_opts->branches = true;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 6a4fbfd34c6b..cb8e0a01abb6 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -60,6 +60,7 @@ enum itrace_period_type {
 #define AUXTRACE_ERR_FLG_DATA_LOST	(1 << ('l' - 'a'))
 
 #define AUXTRACE_LOG_FLG_ALL_PERF_EVTS	(1 << ('a' - 'a'))
+#define AUXTRACE_LOG_FLG_ON_ERROR	(1 << ('e' - 'a'))
 #define AUXTRACE_LOG_FLG_USE_STDOUT	(1 << ('o' - 'a'))
 
 /**
@@ -110,6 +111,7 @@ enum itrace_period_type {
  * @log_plus_flags: flags to affect what is logged
  * @log_minus_flags: flags to affect what is logged
  * @quick: quicker (less detailed) decoding
+ * @log_on_error_size: size of log to keep for outputting log only on errors
  */
 struct itrace_synth_opts {
 	bool			set;
@@ -155,6 +157,7 @@ struct itrace_synth_opts {
 	unsigned int		log_plus_flags;
 	unsigned int		log_minus_flags;
 	unsigned int		quick;
+	unsigned int		log_on_error_size;
 };
 
 /**
-- 
2.25.1

