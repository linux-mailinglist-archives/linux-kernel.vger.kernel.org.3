Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3977D59F44F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiHXH2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHXH2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:28:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4F8696DC
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661326123; x=1692862123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sMAI0paEwMNkWOpIvOSga/g7PIdnTgXjKKnkRCyvU/E=;
  b=F1ACD/BjcJq+KD8pVr9Fg7KwFh5VQ+ky00RHa+1XuQV6OP8vdi5jgHzg
   qwlGIkE+ZiHzFEmzX/MvrJIn4svAsLjNjXQ/YjQqlCBz+BQQAaWjEe1vT
   lCgVB03OjkmOEmaks3G5DccEIFacazWrzqB9E0uD8S+3OxaCCYe+ngBzr
   SeI5/fmUebsmaFLh21lHPcy1zdPrIz6KD2Qb1GPFJ7B/MGYEV1Jmxo8FO
   KK+MFUsLqpS6ZTkTPtA7nfE3aA4NfBVW0IvrFSedwqRDeWFkPr9rvqkNy
   XtIoCSHQWaRGJ9EP6mqL0yC79zkNBpo0pR/9SRVebSPGmbtOnL9bVPLcl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="295173956"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="295173956"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 00:28:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="605939150"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 00:28:41 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] perf record: Fix done_fd wakeup event
Date:   Wed, 24 Aug 2022 10:28:11 +0300
Message-Id: <20220824072814.16422-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824072814.16422-1-adrian.hunter@intel.com>
References: <20220824072814.16422-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

evlist__add_wakeup_eventfd() calls perf_evlist__add_pollfd() to add a
non-perf-event to the evlist pollfds. Since commit 415ccb58f68a
("perf record: Introduce thread specific data array") that doesn't work
because evlist pollfs is not polled and done_fd is not duplicated into
thread-data.

Patch "perf record: Fix way of handling non-perf-event pollfds" added a new
approach that ensures file descriptors like done_fd are handled correctly
by flagging them as fdarray_flag__non_perf_event.

Fix by flagging done_fd as fdarray_flag__non_perf_event.

Example:

 Before:

  $ sleep 3 & perf record -vv -p $!
  ...
  thread_data[0x55f44bd34140]: pollfd[0] <- event_fd=5
  thread_data[0x55f44bd34140]: pollfd[1] <- event_fd=6
  thread_data[0x55f44bd34140]: pollfd[2] <- event_fd=7
  thread_data[0x55f44bd34140]: pollfd[3] <- event_fd=8
  thread_data[0x55f44bd34140]: pollfd[4] <- event_fd=9
  thread_data[0x55f44bd34140]: pollfd[5] <- event_fd=10
  thread_data[0x55f44bd34140]: pollfd[6] <- event_fd=11
  thread_data[0x55f44bd34140]: pollfd[7] <- event_fd=12
  ...

 After:

  $ sleep 3 & perf record -vv -p $!
  ...
  thread_data[0x55a8ded89140]: pollfd[0] <- event_fd=5
  thread_data[0x55a8ded89140]: pollfd[1] <- event_fd=6
  thread_data[0x55a8ded89140]: pollfd[2] <- event_fd=7
  thread_data[0x55a8ded89140]: pollfd[3] <- event_fd=8
  thread_data[0x55a8ded89140]: pollfd[4] <- event_fd=9
  thread_data[0x55a8ded89140]: pollfd[5] <- event_fd=10
  thread_data[0x55a8ded89140]: pollfd[6] <- event_fd=11
  thread_data[0x55a8ded89140]: pollfd[7] <- event_fd=12
  thread_data[0x55a8ded89140]: pollfd[8] <- non_perf_event fd=4
  ...

This patch depends on "perf record: Fix way of handling non-perf-event
pollfds".

Fixes: 415ccb58f68a ("perf record: Introduce thread specific data array")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evlist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 48167f3941a6..0b2222d05577 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -608,7 +608,8 @@ int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
 int evlist__add_wakeup_eventfd(struct evlist *evlist, int fd)
 {
 	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN,
-				       fdarray_flag__nonfilterable);
+				       fdarray_flag__nonfilterable |
+				       fdarray_flag__non_perf_event);
 }
 #endif
 
-- 
2.25.1

