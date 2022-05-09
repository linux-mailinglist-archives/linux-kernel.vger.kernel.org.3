Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A42520110
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbiEIP2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbiEIP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:28:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C12B031C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652109847; x=1683645847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7BI3ZK+h+P3VwEMDxcAP7FNTp6syom8qcPR9b2opId4=;
  b=ghvLdJpK9RGV6otcmeaT4/b4QKCRxS0pP4eJA9cRkMJS8Sl+iQiOO6Fs
   p8kMFyrwgcyHJPFf0VPLykWYB4eRViCR4wwkresKZFb6gTqL3mdrCC0cr
   A3cfFxriqwh+Ksp3R6HGxhfkWWlyz7hqR8+hJ8R8uqhYFp0aWkWXdvhZc
   EWFbskUgQgFy88wlHzsAqlmvfD8U8DiHvt9FMGt/Mit0Zitt96oN1VIWt
   aEgFudMo2ZMmELQQ5CwmPIhZOosTW3cp8ly0aLGnGg3BeyoO01BccZFHU
   hoh+pwOgEd3uUb+geYa7gVs1V4h3x7OXINnUlo6YkVDTtahmwsQtKJ3vt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="294306864"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="294306864"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 08:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="592705398"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2022 08:24:05 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf script: Print Intel ptwrite value as a string if it is ASCII
Date:   Mon,  9 May 2022 18:23:59 +0300
Message-Id: <20220509152400.376613-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509152400.376613-1-adrian.hunter@intel.com>
References: <20220509152400.376613-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be convenient to put a string value into a ptwrite payload as
a quick and easy way to identify what is being printed.

To make that useful, if the Intel ptwrite payload value contains only
printable ASCII characters padded with NULLs, then print it also as a
string.

Using the example program from the "Emulated PTWRITE" section of
tools/perf/Documentation/perf-intel-pt.txt:

 $ echo -n "Hello" | od -t x8
 0000000 0000006f6c6c6548
 0000005
 $ perf record -e intel_pt//u ./eg_ptw 0x0000006f6c6c6548
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.016 MB perf.data ]
 $ perf script --itrace=ew
           eg_ptw 35563 [005] 18256.087338:     ptwrite:  IP: 0 payload: 0x6f6c6c6548 Hello      55e764db5196 perf_emulate_ptwrite+0x16 (/home/user/eg_ptw)
 $

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index cf5eab5431b4..ae6d216df438 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1742,16 +1742,44 @@ static int perf_sample__fprintf_pt_spacing(int len, FILE *fp)
 	return perf_sample__fprintf_spacing(len, 34, fp);
 }
 
+/* If a value contains only printable ASCII characters padded with NULLs */
+static bool ptw_is_prt(u64 val)
+{
+	char c;
+	u32 i;
+
+	for (i = 0; i < sizeof(val); i++) {
+		c = ((char *)&val)[i];
+		if (!c)
+			break;
+		if (!isprint(c) || !isascii(c))
+			return false;
+	}
+	for (; i < sizeof(val); i++) {
+		c = ((char *)&val)[i];
+		if (c)
+			return false;
+	}
+	return true;
+}
+
 static int perf_sample__fprintf_synth_ptwrite(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_ptwrite *data = perf_sample__synth_ptr(sample);
+	char str[sizeof(u64) + 1] = "";
 	int len;
+	u64 val;
 
 	if (perf_sample__bad_synth_size(sample, *data))
 		return 0;
 
-	len = fprintf(fp, " IP: %u payload: %#" PRIx64 " ",
-		     data->ip, le64_to_cpu(data->payload));
+	val = le64_to_cpu(data->payload);
+	if (ptw_is_prt(val)) {
+		memcpy(str, &val, sizeof(val));
+		str[sizeof(val)] = 0;
+	}
+	len = fprintf(fp, " IP: %u payload: %#" PRIx64 " %s ",
+		      data->ip, val, str);
 	return len + perf_sample__fprintf_pt_spacing(len, fp);
 }
 
-- 
2.25.1

