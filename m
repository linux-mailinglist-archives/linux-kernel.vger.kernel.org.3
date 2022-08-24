Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8160159F450
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiHXH2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiHXH2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:28:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6098269F4D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661326121; x=1692862121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q3tbz1NaUEC/rY8ldWb5Y5evI0RmSTZjOIOG8xF0v8Q=;
  b=FDvsw6EJCWPW7GGSwb10QwsB8/N5ooyKN8mAmlEsCyZuwliHf2uaT4wP
   QU51SYnJGne/jxWBsnXuJwdbhyCDR7Q57xXshtUudF23rxfMI7uXxS3bk
   HRa738CCiOVReGcka9TAZOi535Bd0km26kqQlBpE0FsL//2BT08hCraVj
   X2E+8lAeNgQCt6yIJ3ey0N6xQM4aclnptHgxNTMSnrYTf7AZVaAdyU/ae
   y5L0weq/HBAvsrb7b9qa2BGlbX3QwmX8rLpBnjSVc05KiTAoAs4lRrAFd
   jLr6FTNRTpAgGPsNyxc7z9HxRYHmOssfzWutUWAecgAUFzxDtZNFp75BQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="295173945"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="295173945"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 00:28:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="605939141"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 00:28:38 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] perf record: Fix way of handling non-perf-event pollfds
Date:   Wed, 24 Aug 2022 10:28:10 +0300
Message-Id: <20220824072814.16422-2-adrian.hunter@intel.com>
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

perf record __cmd_record() does not poll evlist pollfds. Instead it polls
thread_data[0].pollfd. That happens whether or not threads are being used.

perf record duplicates evlist mmap pollfds as needed for separate threads.
The non-perf-event represented by evlist->ctl_fd has to handled separately,
which is done explicitly, duplicating it into the thread_data[0] pollfds.
That approach neglects any other non-perf-event file descriptors. Currently
there is also done_fd which needs the same handling.

Add a new generalized approach.

Add fdarray_flag__non_perf_event to identify the file descriptors that
need the special handling. For those cases, also keep a mapping of the
evlist pollfd index and thread pollfd index, so that the evlist revents
can be updated.

Although this patch adds the new handling, it does not take it into use.
There is no functional change, but it is the precursor to a fix, so is
marked as a fix.

Fixes: 415ccb58f68a ("perf record: Introduce thread specific data array")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/api/fd/array.h    |  5 ++-
 tools/perf/builtin-record.c | 80 +++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
index 60ad197c8ee9..5c01f7b05dfb 100644
--- a/tools/lib/api/fd/array.h
+++ b/tools/lib/api/fd/array.h
@@ -31,8 +31,9 @@ struct fdarray {
 };
 
 enum fdarray_flags {
-	fdarray_flag__default	    = 0x00000000,
-	fdarray_flag__nonfilterable = 0x00000001
+	fdarray_flag__default		= 0x00000000,
+	fdarray_flag__nonfilterable	= 0x00000001,
+	fdarray_flag__non_perf_event	= 0x00000002,
 };
 
 void fdarray__init(struct fdarray *fda, int nr_autogrow);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4713f0f3a6cf..e0be48c47f65 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -143,6 +143,11 @@ static const char *thread_spec_tags[THREAD_SPEC__MAX] = {
 	"undefined", "cpu", "core", "package", "numa", "user"
 };
 
+struct pollfd_index_map {
+	int evlist_pollfd_index;
+	int thread_pollfd_index;
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -171,6 +176,9 @@ struct record {
 	int			nr_threads;
 	struct thread_mask	*thread_masks;
 	struct record_thread	*thread_data;
+	struct pollfd_index_map	*index_map;
+	size_t			index_map_sz;
+	size_t			index_map_cnt;
 };
 
 static volatile int done;
@@ -1074,6 +1082,70 @@ static void record__free_thread_data(struct record *rec)
 	zfree(&rec->thread_data);
 }
 
+static int record__map_thread_evlist_pollfd_indexes(struct record *rec,
+						    int evlist_pollfd_index,
+						    int thread_pollfd_index)
+{
+	size_t x = rec->index_map_cnt;
+
+	if (realloc_array_as_needed(rec->index_map, rec->index_map_sz, x, NULL))
+		return -ENOMEM;
+	rec->index_map[x].evlist_pollfd_index = evlist_pollfd_index;
+	rec->index_map[x].thread_pollfd_index = thread_pollfd_index;
+	rec->index_map_cnt += 1;
+	return 0;
+}
+
+static int record__update_evlist_pollfd_from_thread(struct record *rec,
+						    struct evlist *evlist,
+						    struct record_thread *thread_data)
+{
+	struct pollfd *e_entries = evlist->core.pollfd.entries;
+	struct pollfd *t_entries = thread_data->pollfd.entries;
+	int err = 0;
+	size_t i;
+
+	for (i = 0; i < rec->index_map_cnt; i++) {
+		int e_pos = rec->index_map[i].evlist_pollfd_index;
+		int t_pos = rec->index_map[i].thread_pollfd_index;
+
+		if (e_entries[e_pos].fd != t_entries[t_pos].fd ||
+		    e_entries[e_pos].events != t_entries[t_pos].events) {
+			pr_err("Thread and evlist pollfd index mismatch\n");
+			err = -EINVAL;
+			continue;
+		}
+		e_entries[e_pos].revents = t_entries[t_pos].revents;
+	}
+	return err;
+}
+
+static int record__dup_non_perf_events(struct record *rec,
+				       struct evlist *evlist,
+				       struct record_thread *thread_data)
+{
+	struct fdarray *fda = &evlist->core.pollfd;
+	int i, ret;
+
+	for (i = 0; i < fda->nr; i++) {
+		if (!(fda->priv[i].flags & fdarray_flag__non_perf_event))
+			continue;
+		ret = fdarray__dup_entry_from(&thread_data->pollfd, i, fda);
+		if (ret < 0) {
+			pr_err("Failed to duplicate descriptor in main thread pollfd\n");
+			return ret;
+		}
+		pr_debug2("thread_data[%p]: pollfd[%d] <- non_perf_event fd=%d\n",
+			  thread_data, ret, fda->entries[i].fd);
+		ret = record__map_thread_evlist_pollfd_indexes(rec, i, ret);
+		if (ret < 0) {
+			pr_err("Failed to map thread and evlist pollfd indexes\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
 static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
 {
 	int t, ret;
@@ -1121,6 +1193,11 @@ static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
 				 thread_data[t].pipes.msg[0]);
 		} else {
 			thread_data[t].tid = gettid();
+
+			ret = record__dup_non_perf_events(rec, evlist, &thread_data[t]);
+			if (ret < 0)
+				goto out_free;
+
 			if (evlist->ctl_fd.pos == -1)
 				continue;
 			ret = fdarray__dup_entry_from(&thread_data[t].pollfd, evlist->ctl_fd.pos,
@@ -2530,6 +2607,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 					    record__thread_munmap_filtered, NULL) == 0)
 				draining = true;
 
+			err = record__update_evlist_pollfd_from_thread(rec, rec->evlist, thread);
+			if (err)
+				goto out_child;
 			evlist__ctlfd_update(rec->evlist,
 				&thread->pollfd.entries[thread->ctlfd_pos]);
 		}
-- 
2.25.1

