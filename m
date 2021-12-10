Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D808047058B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbhLJQ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:27:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:49134 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241087AbhLJQ05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639153402; x=1670689402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H/hr95W+N5hDAufhis0dDI0dcKYNSrhOGZHlFw7XTgI=;
  b=B3xHMURj4KdC1BuXJDGICkoKPVbmaVxc7hPRPOuLhrpehiIWczuvlXgl
   xsogbYZEyEZay2fBoTVVT5ODEd0g9D/PJhbQJq/JWTl3j588zmhXjlPea
   p7Y+OCaORAoHP4HRRUBjvbHfWLh/PVrKTPMRUMCJrQ/YRiRtWxZwH0Dzv
   knFOuENXnCmXiKYOxH6jXeEfO1iGGV8pMJ5Omkit1/wSckOQTytGzhedx
   HhDuNpx5o64my0mVTPl+4RRqxvcVYnYS5Uky+tdumYMmLqpqeO9Fc3N5c
   unBy40pgnOHV5t5T3H7euPV5NsMc/ALNEDZXSnLXBQ8AGd+bE5eYg7xe/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225647108"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="225647108"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:23:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="503981834"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2021 08:23:08 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] perf intel-pt: Fix sync state
Date:   Fri, 10 Dec 2021 18:22:58 +0200
Message-Id: <20211210162303.2288710-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210162303.2288710-1-adrian.hunter@intel.com>
References: <20211210162303.2288710-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When syncing, it may be that branch packet generation is not enabled at
that point, in which case there will not immediately be a control-flow
packet, so some packets before a control flow packet turns up, get ignored.
However, the decoder is in sync as soon as a PSB is found, so the state
should be set accordingly.

Fixes: f4aa081949e7b6 ("perf tools: Add Intel PT decoder")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 6f6f163161a9..bddf98123dc3 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -3608,7 +3608,7 @@ static int intel_pt_sync(struct intel_pt_decoder *decoder)
 	}
 
 	decoder->have_last_ip = true;
-	decoder->pkt_state = INTEL_PT_STATE_NO_IP;
+	decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 
 	err = intel_pt_walk_psb(decoder);
 	if (err)
-- 
2.25.1

