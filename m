Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E551E59F44E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiHXH25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiHXH2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:28:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E55F9353F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661326126; x=1692862126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ymNBeq5PNnzjxJsogOGJR+feFiumi+DIqlDgOH2VXUc=;
  b=QvxBvIbXDPQXG44hjoFbYATlfKLSweO0pq3N8RO96un1PCAcdmpv7OZz
   fbRc+gyeCV5b7U/NoxlUNpF5UIzSagZNLx+TV0RFzXsak5KZu5g0Dt34J
   mzxGO+evucDvMSro3VreOBH/+FbRDcXpv4D7mODjRFyx3pu4uDjwMvkIs
   nSTcruROTjqbOOwmSYqXC0EdlJh50TGQKwQYLv8ekngy/qHYoW3dgcnY2
   8zvCEDO4PF1r0Kdb1bBxAkO5qKBYn0bsaa74eprLZAxb77Ri6ABubIsT5
   qU8VF42chtdC13T2gybGn3pJ0WvVPeAjxYKbbY/tQIa2zIPY4uUJF1zNQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="295173969"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="295173969"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 00:28:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="605939162"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 00:28:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] perf record: Change evlist->ctl_fd to use fdarray_flag__non_perf_event
Date:   Wed, 24 Aug 2022 10:28:12 +0300
Message-Id: <20220824072814.16422-4-adrian.hunter@intel.com>
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

Patch "perf record: Fix way of handling non-perf-event pollfds" added a
generic way to handle non-perf-event file descriptors like evlist->ctl_fd.
Use it instead of handling evlist->ctl_fd separately.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 15 +--------------
 tools/perf/util/evlist.c    | 19 ++-----------------
 tools/perf/util/evlist.h    |  1 -
 3 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e0be48c47f65..cefb3028f565 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1198,18 +1198,7 @@ static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
 			if (ret < 0)
 				goto out_free;
 
-			if (evlist->ctl_fd.pos == -1)
-				continue;
-			ret = fdarray__dup_entry_from(&thread_data[t].pollfd, evlist->ctl_fd.pos,
-						      &evlist->core.pollfd);
-			if (ret < 0) {
-				pr_err("Failed to duplicate descriptor in main thread pollfd\n");
-				goto out_free;
-			}
-			thread_data[t].ctlfd_pos = ret;
-			pr_debug2("thread_data[%p]: pollfd[%d] <- ctl_fd=%d\n",
-				 thread_data, thread_data[t].ctlfd_pos,
-				 evlist->core.pollfd.entries[evlist->ctl_fd.pos].fd);
+			thread_data[t].ctlfd_pos = -1; /* Not used */
 		}
 	}
 
@@ -2610,8 +2599,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			err = record__update_evlist_pollfd_from_thread(rec, rec->evlist, thread);
 			if (err)
 				goto out_child;
-			evlist__ctlfd_update(rec->evlist,
-				&thread->pollfd.entries[thread->ctlfd_pos]);
 		}
 
 		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 0b2222d05577..4c5e6e9f8d11 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1898,7 +1898,8 @@ int evlist__initialize_ctlfd(struct evlist *evlist, int fd, int ack)
 	}
 
 	evlist->ctl_fd.pos = perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN,
-						     fdarray_flag__nonfilterable);
+						     fdarray_flag__nonfilterable |
+						     fdarray_flag__non_perf_event);
 	if (evlist->ctl_fd.pos < 0) {
 		evlist->ctl_fd.pos = -1;
 		pr_err("Failed to add ctl fd entry: %m\n");
@@ -2148,22 +2149,6 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 	return err;
 }
 
-int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update)
-{
-	int ctlfd_pos = evlist->ctl_fd.pos;
-	struct pollfd *entries = evlist->core.pollfd.entries;
-
-	if (!evlist__ctlfd_initialized(evlist))
-		return 0;
-
-	if (entries[ctlfd_pos].fd != update->fd ||
-	    entries[ctlfd_pos].events != update->events)
-		return -1;
-
-	entries[ctlfd_pos].revents = update->revents;
-	return 0;
-}
-
 struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 351ba2887a79..3a464585d397 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -418,7 +418,6 @@ void evlist__close_control(int ctl_fd, int ctl_fd_ack, bool *ctl_fd_close);
 int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
 int evlist__finalize_ctlfd(struct evlist *evlist);
 bool evlist__ctlfd_initialized(struct evlist *evlist);
-int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update);
 int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
 int evlist__ctlfd_ack(struct evlist *evlist);
 
-- 
2.25.1

