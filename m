Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B71F5A9545
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiIALBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiIALBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:01:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428DB1144CF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662030050; x=1693566050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+COgNiJU60nrHtd5yoDxcybxCHTdKYQtexMUf29NKBA=;
  b=BNg3u820hedk6LcWtUnC/nYpks68wLs+mD2Vi5sUHC1ovH3aFYlSAfw5
   j+BMTB1liC8n5C7z8c8EHnSzXBWzuEMFJcd3DFOsgUeiR7jeRFEOJA/Kd
   j9C3jZTCy5C1PjoiQrPX/n/5s90TQb6xY/Dl/qWHvth2VN9Ztxb85heh6
   xj+Dcozz+yb+tJB9PJBEVWK3eUqb53fFV46FJiT1SnKo3ps34NZFsl2Bc
   K/zAZjAwpU+0T612AsOr1lOy0hAxnt9AG8T2pjc7TF3/p0HMV7trjPVBU
   X4jD5SMOU35ircc8LPRcc1z0RsKejrQL761S071b+OTgTLGRSd90nqjt2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294424792"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="294424792"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:00:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673799633"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.42.13])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:00:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] perf auxtrace: Add itrace option flag d+e to log on error
Date:   Thu,  1 Sep 2022 14:00:29 +0300
Message-Id: <20220901110032.9226-3-adrian.hunter@intel.com>
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

Add flag +e to the itrace d (decoder debug log) option to get output only
on decoding errors.

The log can be very big so reducing the output to where there are decoding
errors can be useful for analyzing errors.

By default, the log size in that case is 16384 bytes, but can be altered by
perf config e.g. perf config itrace.debug-log-buffer-size=30000

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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

