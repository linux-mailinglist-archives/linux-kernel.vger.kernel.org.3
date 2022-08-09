Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6158D8C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbiHIMdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbiHIMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:33:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C0D13EA9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660048391; x=1691584391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AS1DJrvxGTVGiiIU2Dc4OFyegI/ZPuQc1/rI4ZZCsnA=;
  b=GCs50U6ln5IKeOv3zd/JB56835pPh4LXHMUntDev36hG7P9e9K5WoP+F
   twLhVVusC2BIz0sgIWIBK+WjS5TJL80CZAoGKfz0wxk6rkhqKLkk8VB2z
   Vg/cz9hUcbfWbmO+f2cgkvNL4giQUGi7XRc2Wza45Lf8MgFQ0TA5ebziB
   BNnVEE/MMYqQELPtrfoJRV4AHoP+A7Kz0mcjkvnluHJYQNPhvxyneh8Sh
   8cm/VcVgkYbtNN9U3B7vXgaUxCbg5EmNRDb++IbR2jZzWS2mkF+Ka3ByR
   PyOBGhq447eaBvKeNCqhJJV2pg92NmwYrfvwELlgxUgfutpcyXy5zo509
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="288386210"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="288386210"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 05:33:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="601434449"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.48.82])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 05:33:09 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf script: Fix reference to perf insert instead of perf inject
Date:   Tue,  9 Aug 2022 15:32:58 +0300
Message-Id: <20220809123258.9086-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amend "perf insert" to "perf inject".

Fixes: e28fb159f116 ("perf script: Add machine_pid and vcpu")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-script.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index c09cc44e50ee..4c95e79e2c39 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -228,7 +228,7 @@ OPTIONS
 	Instruction Trace decoding.
 
 	The machine_pid and vcpu fields are derived from data resulting from using
-	perf insert to insert a perf.data file recorded inside a virtual machine into
+	perf inject to insert a perf.data file recorded inside a virtual machine into
 	a perf.data file recorded on the host at the same time.
 
 	Finally, a user may not set fields to none for all event types.
-- 
2.25.1

