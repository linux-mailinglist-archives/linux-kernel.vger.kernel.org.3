Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B8453A9E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355372AbiFAPZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354236AbiFAPZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:25:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E70A8BD1F;
        Wed,  1 Jun 2022 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654097113; x=1685633113;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cuiu5bkkuNGS2g0qXunvWh7wgqyPsgxaTEeKucvEWzw=;
  b=YrL7ct9djUmMPaQB/393OTn4TatagGR8X4cB/7JVCazk+myZb/4lObyG
   aee8Guke8ztyI4TGQG+cErmwPBG/04qaCH1SXwBrJRVSGGVmot6P+aY8T
   JihGz8cKUUitkmkVGOws+B7HYsOstI5MVf+k4/RfyBPGNbIKMdmafwtb4
   ixxPV/UFbNP4/ZQCZil9Fi5GOfkT80zq89SepFmxuknKTLIbPyPFt2G0v
   CtpFp8MSGIZBT8mMu3ZKa9DWJNxSp74BnxCuPqEsGyQM9Agwmz/D2wUZ/
   XaG7J4sc2Q7pIQVSgi/5ZOMvjYTCBh1irVcOCvxhPNEbH5tjKKQO+BkFL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275636055"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="275636055"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:25:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="720829541"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jun 2022 08:25:09 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH] perf evlist: Extend arch_evsel__must_be_in_group to support hybrid systems
Date:   Wed,  1 Jun 2022 23:25:44 +0800
Message-Id: <20220601152544.1842447-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

For the hybrid system, the "slots" event changes to "cpu_core/slots/", need
extend API arch_evsel__must_be_in_group() to support hybrid systems.

In the origin code, for hybrid system event "cpu_core/slots/", the output
of the API arch_evsel__must_be_in_group() is "false" (in fact,it should be
"true"). Currently only one API evsel__remove_from_group() calls it. In
evsel__remove_from_group(), it adds the second condition to check, so the
output of evsel__remove_from_group() still is correct. That's the reason
why there isn't an instant error. I'd like to fix the issue found in API
arch_evsel__must_be_in_group() in case someone else using the function in
the other place.

Fixes: d98079c05b5a ("perf evlist: Keep topdown counters in weak group")
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 88306183d629..ff4561b7b600 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -57,6 +57,6 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 		return false;
 
 	return evsel->name &&
-		(!strcasecmp(evsel->name, "slots") ||
+		(strcasestr(evsel->name, "slots") ||
 		 strcasestr(evsel->name, "topdown"));
 }
-- 
2.25.1

