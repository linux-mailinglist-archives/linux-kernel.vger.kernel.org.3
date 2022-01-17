Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3C3490C26
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbiAQQKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:10:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51384 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbiAQQJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:09:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F99360F6D;
        Mon, 17 Jan 2022 16:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B67DC36AEF;
        Mon, 17 Jan 2022 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642435794;
        bh=ubLJ8zz+8eHFt3h+XlUNz0LmFutPStnoY3JZl/R2y0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qj39zzVuLpO8szOsubUtMREPkqTKG59CvCBBGJHrcP7bEf8KH6eoWlOPoi8GgYPct
         kUvBOTT9kKSoxDpSqddmIkXEe1tYXZnzm52q8MKW1JQJ7YSF2WyCSkG5O97CLuUJ7F
         M1vhr3bbVgRh6FaL6BLionH6OadAn23gaYxZidUZmFmHXtqI3DztEFeAac4lPdoOS0
         vxu8rX7/hkOpgL1Ee7+Ox8xlJgbWLVNx9ivW4R01Q5qo1rFDyw9Y0iJd+CjGo4ExkB
         WrTiTUTNtHvlMk7SRoA7ZUZsv7Sx3zahhyKJuzy+cAEPPUWPAZeGf64/biniicP0fa
         icnt86qlS1JLg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 3/4] perf evlist: No need to setup affinities when enabling events for pid targets
Date:   Mon, 17 Jan 2022 13:09:30 -0300
Message-Id: <20220117160931.1191712-4-acme@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117160931.1191712-1-acme@kernel.org>
References: <20220117160931.1191712-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When the target is a pid, not started by 'perf stat' we need to enable
the events, and in that case there is no need to setup affinities as we
use a dummy CPU map, with just one entry set to -1.

So stop doing it to avoid this needless call to sched_getaffinity():

  # strace -ke sched_getaffinity perf stat -e cycles -p 241957 sleep 1
  <SNIP>
  sched_getaffinity(0, 512, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]) = 8
   > /usr/lib64/libc-2.33.so(sched_getaffinity@@GLIBC_2.3.4+0x1a) [0xe6eea]
   > /var/home/acme/bin/perf(affinity__setup+0x6a) [0x5329ca]
   > /var/home/acme/bin/perf(__evlist__enable.constprop.0+0x23) [0x4b9693]
   > /var/home/acme/bin/perf(enable_counters+0x14d) [0x42de5d]
   > /var/home/acme/bin/perf(cmd_stat+0x2358) [0x4310c8]
   > /var/home/acme/bin/perf(run_builtin+0x6a) [0x4a2cfa]
   > /var/home/acme/bin/perf(main+0x612) [0x40f8c2]
   > /usr/lib64/libc-2.33.so(__libc_start_main+0xd4) [0x27b74]
   > /var/home/acme/bin/perf(_start+0x2d) [0x40fadd]
  <SNIP>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6e88d404b5b3e96f..ae6d4363da76ec56 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -487,12 +487,16 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
 	struct evlist_cpu_iterator evlist_cpu_itr;
-	struct affinity affinity;
+	struct affinity saved_affinity, *affinity = NULL;
 
-	if (affinity__setup(&affinity) < 0)
-		return;
+	// See explanation in evlist__close()
+	if (!cpu_map__is_dummy(evlist->core.cpus)) {
+		if (affinity__setup(&saved_affinity) < 0)
+			return;
+		affinity = &saved_affinity;
+	}
 
-	evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+	evlist__for_each_cpu(evlist_cpu_itr, evlist, affinity) {
 		pos = evlist_cpu_itr.evsel;
 		if (evsel__strcmp(pos, evsel_name))
 			continue;
@@ -500,7 +504,7 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
 			continue;
 		evsel__enable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
 	}
-	affinity__cleanup(&affinity);
+	affinity__cleanup(affinity);
 	evlist__for_each_entry(evlist, pos) {
 		if (evsel__strcmp(pos, evsel_name))
 			continue;
-- 
2.34.1

