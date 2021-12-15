Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB04475416
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbhLOIIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:08:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:41309 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240726AbhLOIIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639555697; x=1671091697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DEIAKg7PLmiZz6N8rdC7i3kbsB+1VrYolT5OBHT81bA=;
  b=BY7beZkqjsnAZl4XdBERCcW0bKQfauhjqD3pi/DQ6MtMyKGZtZpDY7sZ
   htoi4Xs0Y53xycTgXJEcD3qzZWZuUwtIkvL435YWik1Ur727PJFzO2LLM
   4Odq5/YLxn3Kw5JkdaV5TkNs+H89I+EqVGYDirjbWGxjiCNCEGSDWq5nE
   4sX+O/pTk0+52Dzcw50xNF3bVvQDqaN3HkbGtYr1Z5EXJSogtwuazuE31
   1a/xK5ESu1X1iIHntTOm2ENsqs67ZP98Wu3MLd7lxny2Jk6Xr1kQ40Mlo
   DtkBuG+xQ4JUuelUR9EMysI5rHyGscFXTG3J0hnlo/i9VCWlQT1Mry+Na
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="302550171"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="302550171"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 00:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="505699388"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2021 00:06:40 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/3] perf intel-pt: Fix parsing of VM time correlation arguments
Date:   Wed, 15 Dec 2021 10:06:34 +0200
Message-Id: <20211215080636.149562-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215080636.149562-1-adrian.hunter@intel.com>
References: <20211215080636.149562-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parser did not take ':' into account.

Example:

 Before:

  $ perf record -e intel_pt//u uname
  Linux
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.026 MB perf.data ]
  $ perf inject -i perf.data --vm-time-correlation="dry-run 123"
  $ perf inject -i perf.data --vm-time-correlation="dry-run 123:456"
  Failed to parse VM Time Correlation options
  0x620 [0x98]: failed to process type: 70 [Invalid argument]
  $

 After:

  $ perf inject -i perf.data --vm-time-correlation="dry-run 123:456"
  $

Fixes: e3ff42bdebcfe ("perf intel-pt: Parse VM Time Correlation options and set up decoding")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 10c3187e4c5a..e8613cbda331 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3625,6 +3625,7 @@ static int intel_pt_parse_vm_tm_corr_arg(struct intel_pt *pt, char **args)
 		*args = p;
 		return 0;
 	}
+	p += 1;
 	while (1) {
 		vmcs = strtoull(p, &p, 0);
 		if (errno)
-- 
2.25.1

