Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEF74C3376
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiBXRUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBXRUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:20:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EDE829EBB7;
        Thu, 24 Feb 2022 09:20:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C16C1476;
        Thu, 24 Feb 2022 09:20:08 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.37.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 692EB3F70D;
        Thu, 24 Feb 2022 09:20:06 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] perf: Set build-id using build-id header on new mmap records
Date:   Thu, 24 Feb 2022 17:19:55 +0000
Message-Id: <20220224171955.862983-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220224171955.862983-1-james.clark@arm.com>
References: <20220224171955.862983-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMAP records that occur after the build-id header is parsed do not have
their build-id set even if the filename matches an entry from the
header. Set the build-id on these dsos as long as the MMAP record
doesn't have its own build-id set.

This fixes an issue with off target analysis where the local version of
a dso is loaded rather than one from ~/.debug via a build-id.

Reported-by: Denis Nikitin <denik@chromium.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/dso.h    |  1 +
 tools/perf/util/header.c |  1 +
 tools/perf/util/map.c    | 16 ++++++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 011da3924fc1..3a9fd4d389b5 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -167,6 +167,7 @@ struct dso {
 	enum dso_load_errno	load_errno;
 	u8		 adjust_symbols:1;
 	u8		 has_build_id:1;
+	u8		 header_build_id:1;
 	u8		 has_srcline:1;
 	u8		 hit:1;
 	u8		 annotate_warned:1;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 6da12e522edc..571d73d4f976 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2200,6 +2200,7 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
 
 		build_id__init(&bid, bev->data, size);
 		dso__set_build_id(dso, &bid);
+		dso->header_build_id = 1;
 
 		if (dso_space != DSO_SPACE__USER) {
 			struct kmod_path m = { .name = NULL, };
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 1803d3887afe..4ae91e491e23 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -127,7 +127,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 
 	if (map != NULL) {
 		char newfilename[PATH_MAX];
-		struct dso *dso;
+		struct dso *dso, *header_bid_dso;
 		int anon, no_dso, vdso, android;
 
 		android = is_android_lib(filename);
@@ -185,7 +185,19 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 
 		if (build_id__is_defined(bid))
 			dso__set_build_id(dso, bid);
-
+		else {
+			/*
+			 * If the mmap event had no build ID, search for an existing dso from the
+			 * build ID header by name. Otherwise only the dso loaded at the time of
+			 * reading the header will have the build ID set and all future mmaps will
+			 * have it missing.
+			 */
+			header_bid_dso = __dsos__find(&machine->dsos, filename, false);
+			if (header_bid_dso && header_bid_dso->header_build_id) {
+				dso__set_build_id(dso, &header_bid_dso->bid);
+				dso->header_build_id = 1;
+			}
+		}
 		dso__put(dso);
 	}
 	return map;
-- 
2.28.0

