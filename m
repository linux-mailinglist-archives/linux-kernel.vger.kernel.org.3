Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C3A4B234E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349039AbiBKKfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:35:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349009AbiBKKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:35:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2ECEB6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c5-20020a25f305000000b0061dd6123f18so17886874ybs.17
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R0Dvzg9O7l0PtwThblOaU7REzb8t/7BNSvgMr4EaVqc=;
        b=KoCSShQIYgFOjacok9goWTjMd1qBAjpQUsnX6E/1F88ONNdP294ova5aZpsd615yXw
         e9/1Unmo4KsOEjtA1NmkLfYR+4E/0CtjMNc3prqmvMp+9D+bBXfO10nmXlNkumKPet0v
         QMRsbREBRhULCkhrMVHu1oDd681AuCzoGrVYgs8grKW6QtXInYA2JQ9rDsae17AwumJ8
         JNy2hqD+tRhz/gO/icCV5ykmkIJamX82pMkj0B2LMKOyADAvA7SzKNrdmaHuacoTAlnp
         QrxYllarhfHeApSmgiAs/UrjvIrRP0Rj2PDDA65MPqgz0rEY/poTOPGZH0CkIVEqUlGD
         /DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R0Dvzg9O7l0PtwThblOaU7REzb8t/7BNSvgMr4EaVqc=;
        b=Po+HD4fNwwPTCGVrdg5YugwMPEv2DNeCu9c7EumkqYV8HoVaDfE8g9f8ed0hpF0JkQ
         /CHxJRZcSppYcacX6/hxRbANt0OzlQFa1M5dd5qzWfiAFtSMB2tm8c+eqzxBgS5lqd2t
         Ze50ioSE1GXQqCaRoXBtX88vLe+YufQK2pVuOp1zqm611pVQjsYepk6CEUbJ2K4lNUnG
         kl0azv1lg4YSlEFSoI85t1/5lbPZtzKponJW5EjHOeNYXuYJohUaJ4owd4JZRKn1V1SQ
         ZhKWnT5dUMSCsV+R90ZWKVps70yngKbv/ZeNqHXIPqEprIPvj5pSWOJDGDsS2vi+zljP
         8bIg==
X-Gm-Message-State: AOAM533otvwZ+/zf0z/OYYpR2cCZdU3J28ugcp/atqG0DEGH291HqoLV
        EWp1cS/vvcVBs1IC6C76x5A2BHJps2sX
X-Google-Smtp-Source: ABdhPJwZPREtk69S2uJng/+p/EnTJUYTxGrBBc8C3Ov3BA1WlWObPnq9xK3yKtf5pJDUi/fSzClIBg9ysOdc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a25:c70e:: with SMTP id
 w14mr759216ybe.220.1644575687998; Fri, 11 Feb 2022 02:34:47 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:04 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-12-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 11/22] perf map: Move map list node into symbol
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a perf map as a list node is only done in symbol. Move the
list_node struct into symbol as a single pointer to the map. This
makes reference count behavior more obvious and easy to check.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.h    |  5 +--
 tools/perf/util/symbol.c | 89 ++++++++++++++++++++++++++--------------
 2 files changed, 60 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 3dcfe06db6b3..2879cae05ee0 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -16,10 +16,7 @@ struct maps;
 struct machine;
 
 struct map {
-	union {
-		struct rb_node	rb_node;
-		struct list_head node;
-	};
+	struct rb_node		rb_node;
 	u64			start;
 	u64			end;
 	bool			erange_warned:1;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a504346feb05..99accae7d3b8 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -48,6 +48,11 @@ static bool symbol__is_idle(const char *name);
 int vmlinux_path__nr_entries;
 char **vmlinux_path;
 
+struct map_list_node {
+	struct list_head node;
+	struct map *map;
+};
+
 struct symbol_conf symbol_conf = {
 	.nanosecs		= false,
 	.use_modules		= true,
@@ -1193,16 +1198,22 @@ struct kcore_mapfn_data {
 static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 {
 	struct kcore_mapfn_data *md = data;
-	struct map *map;
+	struct map_list_node *list_node;
 
-	map = map__new2(start, md->dso);
-	if (map == NULL)
+	list_node = malloc(sizeof(*list_node));
+	if (list_node == NULL)
 		return -ENOMEM;
 
-	map->end = map->start + len;
-	map->pgoff = pgoff;
+	list_node->map = map__new2(start, md->dso);
+	if (list_node->map == NULL) {
+		free(list_node);
+		return -ENOMEM;
+	}
+
+	list_node->map->end = list_node->map->start + len;
+	list_node->map->pgoff = pgoff;
 
-	list_add(&map->node, &md->maps);
+	list_add(&list_node->node, &md->maps);
 
 	return 0;
 }
@@ -1238,12 +1249,19 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 				 * |new.............| -> |new..|       |new..|
 				 *       |old....|    ->       |old....|
 				 */
-				struct map *m = map__clone(new_map);
+				struct map_list_node *m;
 
+				m = malloc(sizeof(*m));
 				if (!m)
 					return -ENOMEM;
 
-				m->end = old_map->start;
+				m->map = map__clone(new_map);
+				if (!m->map) {
+					free(m);
+					return -ENOMEM;
+				}
+
+				m->map->end = old_map->start;
 				list_add_tail(&m->node, &merged);
 				new_map->pgoff += old_map->end - new_map->start;
 				new_map->start = old_map->end;
@@ -1273,10 +1291,13 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 	}
 
 	while (!list_empty(&merged)) {
-		old_map = list_entry(merged.next, struct map, node);
-		list_del_init(&old_map->node);
-		maps__insert(kmaps, old_map);
-		map__put(old_map);
+		struct map_list_node *old_node;
+
+		old_node = list_entry(merged.next, struct map_list_node, node);
+		list_del_init(&old_node->node);
+		maps__insert(kmaps, old_node->map);
+		map__put(old_node->map);
+		free(old_node);
 	}
 
 	if (new_map) {
@@ -1291,7 +1312,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 {
 	struct maps *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
-	struct map *old_map, *new_map, *replacement_map = NULL, *next;
+	struct map *old_map, *replacement_map = NULL, *next;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
@@ -1351,42 +1372,47 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 	/* Find the kernel map using the '_stext' symbol */
 	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
-		list_for_each_entry(new_map, &md.maps, node) {
-			if (stext >= new_map->start && stext < new_map->end) {
-				replacement_map = new_map;
+		struct map_list_node *new_node;
+
+		list_for_each_entry(new_node, &md.maps, node) {
+			if (stext >= new_node->map->start && stext < new_node->map->end) {
+				replacement_map = new_node->map;
 				break;
 			}
 		}
 	}
 
 	if (!replacement_map)
-		replacement_map = list_entry(md.maps.next, struct map, node);
+		replacement_map = list_entry(md.maps.next, struct map_list_node, node)->map;
 
 	/* Add new maps */
 	while (!list_empty(&md.maps)) {
-		new_map = list_entry(md.maps.next, struct map, node);
-		list_del_init(&new_map->node);
-		if (new_map == replacement_map) {
-			map->start	= new_map->start;
-			map->end	= new_map->end;
-			map->pgoff	= new_map->pgoff;
-			map->map_ip	= new_map->map_ip;
-			map->unmap_ip	= new_map->unmap_ip;
+		struct map_list_node *new_node;
+
+		new_node = list_entry(md.maps.next, struct map_list_node, node);
+		list_del_init(&new_node->node);
+		if (new_node->map == replacement_map) {
+			map->start	= new_node->map->start;
+			map->end	= new_node->map->end;
+			map->pgoff	= new_node->map->pgoff;
+			map->map_ip	= new_node->map->map_ip;
+			map->unmap_ip	= new_node->map->unmap_ip;
 			/* Ensure maps are correctly ordered */
 			map__get(map);
 			maps__remove(kmaps, map);
 			maps__insert(kmaps, map);
 			map__put(map);
-			map__put(new_map);
+			map__put(new_node->map);
 		} else {
 			/*
 			 * Merge kcore map into existing maps,
 			 * and ensure that current maps (eBPF)
 			 * stay intact.
 			 */
-			if (maps__merge_in(kmaps, new_map))
+			if (maps__merge_in(kmaps, new_node->map))
 				goto out_err;
 		}
+		free(new_node);
 	}
 
 	if (machine__is(machine, "x86_64")) {
@@ -1423,9 +1449,12 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 out_err:
 	while (!list_empty(&md.maps)) {
-		map = list_entry(md.maps.next, struct map, node);
-		list_del_init(&map->node);
-		map__put(map);
+		struct map_list_node *list_node;
+
+		list_node = list_entry(md.maps.next, struct map_list_node, node);
+		list_del_init(&list_node->node);
+		map__put(list_node->map);
+		free(list_node);
 	}
 	close(fd);
 	return -EINVAL;
-- 
2.35.1.265.g69c8d7142f-goog

