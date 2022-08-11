Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD47590598
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiHKRQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiHKRPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:15:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027322314C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660237491; x=1691773491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gwe/m5biPEWSgjEYgmRoCpmAZ2RbdTSZ059leJBW3I0=;
  b=hOTsI7ifdvvSTigx5iZ2PvBIyWS4NTc//Oyesz+Rgdy9XgeK0Ploxns1
   qDUEUo2sC081/Y5wwzhWrk0GlHL9bzx9TcPcJIg0jQubLSRPVDjYJc1A2
   4dotAjR+Da7sC1UH+EnhDyF4yc8ZzjsUGMzHUJ0kyqSAndkgu1VkxWbWf
   pGX4aNt6yrFcjU6+FDIPxLpNjX8z7Fp8+EHqQSJC8SrWY/r9cIDYu7JNV
   7oxqkKk1JwD6BKWv+DpGr1ZW22OnIHScnSB/RuGgGfDJhJ2+0LBFloJ7r
   Fkj9OZ3OiRuW/MOyCg42PZqnJDlOdDKHjc26h9lKTC8boamSDXzZqRJpI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="290161805"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="290161805"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 10:04:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="602234620"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.35.150])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 10:04:28 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf script: Fix missing guest option documentation
Date:   Thu, 11 Aug 2022 20:04:09 +0300
Message-Id: <20220811170411.84154-2-adrian.hunter@intel.com>
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

perf script documentation is missing several options relating to guests.
Add them.

Fixes: 15a108af1a18 ("perf script: Allow specifying the files to process guest samples")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-script.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 4c95e79e2c39..48ee42a891b6 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -487,6 +487,29 @@ include::itrace.txt[]
 	For itrace only show specified functions and their callees for
 	itrace. Multiple functions can be separated by comma.
 
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
+	$ perf script --guestmount=~/guestmount
+
+--guestkallsyms=<path>::
+	Guest OS /proc/kallsyms file copy. perf reads it to get guest
+	kernel symbols. Users copy it out from guest OS.
+
+--guestmodules=<path>::
+	Guest OS /proc/modules file copy. perf reads it to get guest
+	kernel module information. Users copy it out from guest OS.
+
+--guestvmlinux=<path>::
+	Guest OS kernel vmlinux.
+
 --switch-on EVENT_NAME::
 	Only consider events after this event is found.
 
-- 
2.25.1

