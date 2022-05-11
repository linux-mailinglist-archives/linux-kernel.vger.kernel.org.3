Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED74523B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345332AbiEKRM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbiEKRMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:12:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C2D1595A7;
        Wed, 11 May 2022 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652289144; x=1683825144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PmUQ7d9wEJbUBzDsFN+FiATLacntfGFgKdbPMzYUIig=;
  b=GRV8ZqfDx1I+uOtBEfjf54LQyhe24U2Nv0n/bvImUsY5lPky5qGCoi4l
   Udh7ylXazeRmGEYpL0MKIBz25PaB2B6vihYtz9VjqJuEd5/QFM9xp84sz
   xYmG8JvT9MS6m6tI35FnUvFYbd35i5bQDcecoWygN/lB2/4H8hZ4SdXvA
   7oETvH03WW5plQHmhARH1KprBQWc23XODyN2XvKNOrIObwDY0dEo5u00d
   2gf6bpV4GjeKPFs6Z22b0C8XCzthGu/KIos9+OEtT3DrUh5k0yNS15GhV
   q7yuu6ZRUrd8uviEUATaTWBDFWSoAgvTTZ3kjnmDCF+/aGVEf/69MChCi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="268596068"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="268596068"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="594234097"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2022 10:12:23 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] tools/power/x86/intel-speed-select: Fix warning for perf_cap.cpu
Date:   Wed, 11 May 2022 10:12:08 -0700
Message-Id: <20220511171208.211319-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize perf_cap struct to avoid warning:

  CC      hfi-events.o
In function ‘process_hfi_event’,
    inlined from ‘handle_event’ at hfi-events.c:220:5:
hfi-events.c:184:9: warning: ‘perf_cap.cpu’ may be used
uninitialized [-Wmaybe-uninitialized]
  184 |         process_level_change(perf_cap->cpu);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hfi-events.c: In function ‘handle_event’:
hfi-events.c:193:25: note: ‘perf_cap.cpu’ was declared here
  193 |         struct perf_cap perf_cap;
      |                         ^~~~~~~~

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/hfi-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/hfi-events.c b/tools/power/x86/intel-speed-select/hfi-events.c
index e85676711372..761375062505 100644
--- a/tools/power/x86/intel-speed-select/hfi-events.c
+++ b/tools/power/x86/intel-speed-select/hfi-events.c
@@ -190,7 +190,7 @@ static int handle_event(struct nl_msg *n, void *arg)
 	struct genlmsghdr *genlhdr = genlmsg_hdr(nlh);
 	struct nlattr *attrs[THERMAL_GENL_ATTR_MAX + 1];
 	int ret;
-	struct perf_cap perf_cap;
+	struct perf_cap perf_cap = {0};
 
 	ret = genlmsg_parse(nlh, 0, attrs, THERMAL_GENL_ATTR_MAX, NULL);
 
-- 
2.35.1

