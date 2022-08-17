Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C934559701A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiHQNnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiHQNnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:43:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F23CBED;
        Wed, 17 Aug 2022 06:43:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso1894967pjk.0;
        Wed, 17 Aug 2022 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ltEvwlF7Mc7Jfl+CVYXmu3T8hQuVRPkB5nZQ2bzNo40=;
        b=dEU0EguborkBx81g9hWug55t3YIcKqs5J0/FrnUJGlrgBQUGhlcAMRJlx3aknSQDTV
         0YgD2F1LyeajruuaTOflPNvR8gvmUK23gfA0tPhWESXkDqdWlzjk8+J9pocDc6w+xYGh
         XCqOHmYse/viFAaGggf8mLxG9UytxejRWc+iDuzT0alTWeSsFMBgxTqKb21tsj5ynI6R
         8NlJL2W6+cE3Z+QXgD82G24uYbJXufyei78rG2IQlsBXPilLF7MauCDvy+OSDmz58ypf
         PejwCi+zUMaM2JblPAMX+iP3KJR+Vpt5Ei8w4o/iL2y7Ki+z6RcFzP6eoprkUTupcIIV
         rAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ltEvwlF7Mc7Jfl+CVYXmu3T8hQuVRPkB5nZQ2bzNo40=;
        b=nXEqs1I1vmEm1MVfQ+Dk2VSgI28MkGsK2Q4fV+v4RGuSGcD2iytMW3E8S5+9pMPEAa
         V5r3+tm6sXy7L33xe+ScXLKgBIQqhH6hqbo6dpFYk+hZQu2oOK2mGg8F/8uvtkNdYkzV
         ERChr61tj+AKuUvwe0X7sezT5klfd4DKPBm9SfDxKC5TSVdfcnWD2KyQ6Q4u4PvSUUiE
         PXPOXrdq1Y3zLFinxi2P4+RZBZ3Kaej8XklemoN7mCUXwRv1GsUMOcEij41fhWuchKxO
         yAakM4q2byhEvtSyY5msYyWupFfV9QjYkgGNNyqGn3vgvS0QMFNY5nops7MXRW02Rc5k
         UXdg==
X-Gm-Message-State: ACgBeo3M48shWwm2ThDwmfuJmqSbA3EmC5wczyi/+juDQTeBW9o6tCpW
        bAc2l10vLwiwTuczAg8fw1M=
X-Google-Smtp-Source: AA6agR7IzL4j/fNNZG2fIpkkOy57Eo5eqFLkF5ehsNbgWZvLivG8647a4lQWujNb/umEnPl7LacACg==
X-Received: by 2002:a17:902:7883:b0:172:935c:7712 with SMTP id q3-20020a170902788300b00172935c7712mr4999396pll.7.1660743817579;
        Wed, 17 Aug 2022 06:43:37 -0700 (PDT)
Received: from instance-20220713-1412.vcn09202155.oraclevcn.com ([168.138.217.33])
        by smtp.gmail.com with ESMTPSA id w1-20020a631601000000b004129741dd9dsm9480651pgl.51.2022.08.17.06.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:43:36 -0700 (PDT)
From:   tcwzxx <tcwzxx@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tcwzxx <tcwzxx@gmail.com>
Subject: [PATCH] perf tool: add skip_not_exec_file_map_events option
Date:   Wed, 17 Aug 2022 13:43:24 +0000
Message-Id: <20220817134324.702278-1-tcwzxx@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When generate the flame graph, the perf-script subcommand will
process all mmap event and add them to the rbtree. The 240,000
mmap region takes about 5 minutes, which is not useful for flame
graph. So add the skip-not-exec-file-map-events option to skip
not PROT_EXEC flag memory regions.

Signed-off-by: tcwzxx <tcwzxx@gmail.com>
---
 tools/perf/builtin-report.c | 2 ++
 tools/perf/builtin-script.c | 3 +++
 tools/perf/util/machine.c   | 3 +++
 tools/perf/util/map.c       | 5 +++++
 tools/perf/util/map.h       | 2 ++
 5 files changed, 15 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 91ed41cc7d88..c28eb9450a66 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1364,6 +1364,8 @@ int cmd_report(int argc, const char **argv)
 		    "Disable raw trace ordering"),
 	OPT_BOOLEAN(0, "skip-empty", &report.skip_empty,
 		    "Do not display empty (or dummy) events in the output"),
+	OPT_BOOLEAN(0, "skip-not-exec-file-map_events", &skip_not_exec_file_map_events,
+		    "skip not exec map events"),
 	OPT_END()
 	};
 	struct perf_data data = {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 13580a9c50b8..e3f4e5e654c9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -32,6 +32,7 @@
 #include "util/time-utils.h"
 #include "util/path.h"
 #include "util/event.h"
+#include "util/map.h"
 #include "ui/ui.h"
 #include "print_binary.h"
 #include "archinsn.h"
@@ -3936,6 +3937,8 @@ int cmd_script(int argc, const char **argv)
 		    "Guest code can be found in hypervisor process"),
 	OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
 		    "Enable LBR callgraph stitching approach"),
+	OPT_BOOLEAN(0, "skip-not-exec-map_events", &skip_not_exec_file_map_events,
+		    "skip not exec map events"),
 	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2a16cae28407..21dde9f9935c 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1904,6 +1904,9 @@ int machine__process_mmap2_event(struct machine *machine,
 	if (thread == NULL)
 		goto out_problem;
 
+	if (skip_not_exec_file_map_events && !(event->mmap2.prot & PROT_EXEC))
+		goto out_problem;
+
 	map = map__new(machine, event->mmap2.start,
 			event->mmap2.len, event->mmap2.pgoff,
 			&dso_id, event->mmap2.prot,
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e0aa4a254583..2b51ca012c91 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -16,6 +16,8 @@
 #include "thread.h"
 #include "vdso.h"
 
+bool skip_not_exec_file_map_events;
+
 static inline int is_android_lib(const char *filename)
 {
 	return strstarts(filename, "/data/app-lib/") ||
@@ -168,6 +170,9 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		if (dso == NULL)
 			goto out_delete;
 
+		if (skip_not_exec_file_map_events && dso__type(dso, machine) == DSO__TYPE_UNKNOWN)
+			goto out_delete;
+
 		map__init(map, start, start + len, pgoff, dso);
 
 		if (anon || no_dso) {
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 3dcfe06db6b3..67b0e0f9f0ae 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -11,6 +11,8 @@
 #include <stdbool.h>
 #include <linux/types.h>
 
+extern bool skip_not_exec_file_map_events;
+
 struct dso;
 struct maps;
 struct machine;
-- 
2.34.1

