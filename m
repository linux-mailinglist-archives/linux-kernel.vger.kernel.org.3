Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B40490C27
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbiAQQKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbiAQQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:09:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6B0C061574;
        Mon, 17 Jan 2022 08:09:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB54F61113;
        Mon, 17 Jan 2022 16:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8159BC36AE7;
        Mon, 17 Jan 2022 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642435796;
        bh=LZwn1ndSplo/urrra+IACTj986KAuq6IFBR0er5UYCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cl6tipUcpsWOrfI1eKIkXk+GNJLDJ6qBH17gp56f0j+/CKaI7rVq+c0KKrElqCI5P
         GfwmKX5JhmUUWxb/JuL3qNyoBxIvoSP31Q4okJrz010h4h4l9URushK7tHAjH+v943
         5qET9SCobqVDOBq2ou4SzN2WF8OUaWwH6DF4MxePqhi5zAcqfBuqu09JAD0YRE6PhZ
         9jfdouEju8OdxPm29CtaVYvKsloMc+ybkl/liJ/VJitFkmJqONaOHJPWVpdZR5v8m2
         Da4RGtv5KNY3uPTAN3Up6DoOu91u8jYhm/YAtoYhy8n4NsvFGf3dVKr/eKqHIgMIVt
         U4xmY1EtPiVgg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 4/4] perf evlist: No need to setup affinities when disabling events for pid targets
Date:   Mon, 17 Jan 2022 13:09:31 -0300
Message-Id: <20220117160931.1191712-5-acme@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117160931.1191712-1-acme@kernel.org>
References: <20220117160931.1191712-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When the target is a pid, not started by 'perf stat' we need to disable
the events, and in that case there is no need to setup affinities as we
use a dummy CPU map, with just one entry set to -1.

So stop doing it to avoid this needless call to sched_getaffinity():

  # strace -ke sched_getaffinity perf stat -e cycles -p 241957 sleep 1
  <SNIP>
  sched_getaffinity(0, 512, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]) = 8
   > /usr/lib64/libc-2.33.so(sched_getaffinity@@GLIBC_2.3.4+0x1a) [0xe6eea]
   > /var/home/acme/bin/perf(affinity__setup+0x6a) [0x532a2a]
   > /var/home/acme/bin/perf(__evlist__disable.constprop.0+0x27) [0x4b9827]
   > /var/home/acme/bin/perf(cmd_stat+0x29b5) [0x431725]
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
index ae6d4363da76ec56..eaad04e1672a4752 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -430,15 +430,19 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
 	struct evlist_cpu_iterator evlist_cpu_itr;
-	struct affinity affinity;
+	struct affinity saved_affinity, *affinity = NULL;
 	bool has_imm = false;
 
-	if (affinity__setup(&affinity) < 0)
-		return;
+	// See explanation in evlist__close()
+	if (!cpu_map__is_dummy(evlist->core.cpus)) {
+		if (affinity__setup(&saved_affinity) < 0)
+			return;
+		affinity = &saved_affinity;
+	}
 
 	/* Disable 'immediate' events last */
 	for (int imm = 0; imm <= 1; imm++) {
-		evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+		evlist__for_each_cpu(evlist_cpu_itr, evlist, affinity) {
 			pos = evlist_cpu_itr.evsel;
 			if (evsel__strcmp(pos, evsel_name))
 				continue;
@@ -454,7 +458,7 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 			break;
 	}
 
-	affinity__cleanup(&affinity);
+	affinity__cleanup(affinity);
 	evlist__for_each_entry(evlist, pos) {
 		if (evsel__strcmp(pos, evsel_name))
 			continue;
-- 
2.34.1

