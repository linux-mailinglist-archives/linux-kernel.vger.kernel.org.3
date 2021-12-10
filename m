Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6A8470592
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbhLJQ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:27:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:49136 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241335AbhLJQ07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639153404; x=1670689404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XqLJIz8c71+YvC2YH4KRal9m9EbmegHmjSIoyBG5nsA=;
  b=F3//BExPBXra+ZIEKlVlKpKwdNgyY4l4h/Z4kNI2fWFqm+G8PGTGaNk5
   EAGkOnkINQ4fYSaxyebDdZSpF1rw1kQoE11LDx+ov82/dtoS3+ZiUT2IF
   DefzxtjER9azl/rnT+kYfNlsv5wcmY2DBtd2giMeGd1D1q0KtWxbyyRxn
   hG/sWDDHaZTmf0PClZDWBKpySeJoVhqmYLaaAh9q5pqRvaP6lkVB5GxLu
   5dTkbpViMX9NR4ytS4Wy9RKkSmLgk6Z2SwzM5jCYnOrimyTewSP722HlK
   pyg5zpUsZ1SwL4928GdxYRBgaN0AJu7ALjheesncU6NudNIXbi/CpsH/X
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225647136"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="225647136"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:23:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="503981899"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2021 08:23:16 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] perf intel-pt: Fix error timestamp
Date:   Fri, 10 Dec 2021 18:23:03 +0200
Message-Id: <20211210162303.2288710-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210162303.2288710-1-adrian.hunter@intel.com>
References: <20211210162303.2288710-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An error timestamp shows the last known timestamp for the queue, but this
is not updated on the error path. Fix by setting it.

Fixes: f4aa081949e7b6 ("perf tools: Add Intel PT decoder")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 556a893508da..10c3187e4c5a 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2565,6 +2565,7 @@ static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 				ptq->sync_switch = false;
 				intel_pt_next_tid(pt, ptq);
 			}
+			ptq->timestamp = state->est_timestamp;
 			if (pt->synth_opts.errors) {
 				err = intel_ptq_synth_error(ptq, state);
 				if (err)
-- 
2.25.1

