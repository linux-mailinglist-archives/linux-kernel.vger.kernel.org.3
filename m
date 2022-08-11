Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B78459059A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiHKRQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbiHKRPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:15:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF09913CD6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660237492; x=1691773492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AlFzoFKeimTAoqlg1xyanI/s9pf5w2ZyBR8pX5BSkwc=;
  b=lVxuHQHATmbdxsRLJz/b4RtIZsGwRiSHu7qzQLHJ11SRlhDwPceG9wxX
   04AkIYWCf5SU6prIWa6hjY9oPrimSKx4IbhHbBmCLg0DUs9Q0iU0hVuf/
   KTf4SyRfR8AffmLnTwMtUCBzIosYsQfrxHi0cMOMOExtM+gSG7vCcGtVv
   RuA8Ml2Du3cBfxmBmHXqe/ElP81vGG7Ciul/14/UwKGts7EiQqNVYO1AE
   CqsaJzp3vsUJdj9Z+cyPzxj2hiPOZNVnGHangbDWxN/MU1WfubwVuZqK6
   Ev+xHcBH2HzWOiMjsT8Azr508HY9eyHkywfbr2fZDOIV3efiIOfjd2qBB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="290161818"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="290161818"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 10:04:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="602234628"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.35.150])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 10:04:30 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf inject: Fix missing guestmount option documentation
Date:   Thu, 11 Aug 2022 20:04:10 +0300
Message-Id: <20220811170411.84154-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811170411.84154-1-adrian.hunter@intel.com>
References: <20220811170411.84154-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf inject documentation is missing the guestmount option. Add it.

Fixes: 97406a7e4fa6 ("perf inject: Add support for injecting guest sideband events")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-inject.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index 646aa31586ed..c741ca2107b1 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -102,6 +102,18 @@ include::itrace.txt[]
 	should be used, and also --buildid-all and --switch-events may be
 	useful.
 
+--guestmount=<path>::
+	Guest OS root file system mount directory. Users mount guest OS
+	root directories under <path> by a specific filesystem access method,
+	typically, sshfs.
+	For example, start 2 guest OS, one's pid is 8888 and the other's is 9999:
+[verse]
+	$ mkdir \~/guestmount
+	$ cd \~/guestmount
+	$ sshfs -o allow_other,direct_io -p 5551 localhost:/ 8888/
+	$ sshfs -o allow_other,direct_io -p 5552 localhost:/ 9999/
+	$ perf inject --guestmount=~/guestmount
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-archive[1],
-- 
2.25.1

