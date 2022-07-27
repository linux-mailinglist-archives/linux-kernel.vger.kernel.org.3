Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7B4582551
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiG0LUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiG0LUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:20:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DD439BA5;
        Wed, 27 Jul 2022 04:20:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b9so15834296pfp.10;
        Wed, 27 Jul 2022 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TFRw2Psf8IIwI4NlDngbfw4/F+e4HTy1kmVWPjRbvz0=;
        b=X2CU22COBugDbztya7hf6NgZo6H7lma/+gz4ZCO1zT3LwfBwKo0XbUaruodJEer/Wp
         wo5BIZQBCVAVxvR5GcJDcU+hiTKilyMQZuVWXK05zNRqIHmtoF0tHI2tjS131c8VFA1s
         YctJSPFt0PDIhSwy9KBoIJnV9CCmm/PuQ9uqyB0334fCPLmB0IP/fzEIE91sVrzW0OTO
         T5AwRNxTBwNE8MClReyopDBlditxr49HufaxWqE/40PJb/xjifcZGL/vML7iKcmY8Z1g
         PMRi55g1TH6BG2jjdqv6NFKQ6IM9cIjuH45fjWrb/O75QTHrrIDMSiZ6fRPzHsFixtcC
         0w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TFRw2Psf8IIwI4NlDngbfw4/F+e4HTy1kmVWPjRbvz0=;
        b=5DrBl7bKamEK1gm8EzrWKDxcHbvqjQ1OU/iUbjyvdJuNmtQVflwAb+Vk5p/vL3g9ev
         lKR2MAelv3qAllQcgizlJHuat/IYr8ZQhm52jOVNrNC1TzlzJSfAvZ/hydeZQje8fd9d
         qivqlffzL619XevfoIAIt4Tf03oUek1wYuDyXy5vwIASw3jRhDCzr7eaTuWJRnYdBh0Y
         SfwiR38XmRjYdf9ULp+taxVnT9l4zxEa0rtix//vEABywirFnygtw2iXjesjStRDEZ8j
         MIoAwPYAx++vXU3E9+3wgu5bQL+vNmK5e2itHoAidSyFh9cV2AC3aJZOON8AhpfKk8lZ
         Xb+A==
X-Gm-Message-State: AJIora+AOLGxD9/gT7xY4thz38deJTGM6x/vbzDe9931Sq4Ys5NXWaW0
        KoOrTbsei80qIssCCailqi8TO9fZ5ODYQV7S
X-Google-Smtp-Source: AGRyM1u0qsZ49pMFcTLHxq0QGMqY70u4xr5NPaS2dmn1IsUPYd8o7s6/Eo/7gqN+EvEBBhhEYeemFg==
X-Received: by 2002:a63:4c0d:0:b0:41a:77fe:2bc8 with SMTP id z13-20020a634c0d000000b0041a77fe2bc8mr18140787pga.82.1658920831644;
        Wed, 27 Jul 2022 04:20:31 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:e014:b9a7:c341:50d6:ad89:e8ac])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b0016c433f7c12sm13640212plg.271.2022.07.27.04.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 04:20:31 -0700 (PDT)
From:   gpavithrasha@gmail.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc:     gpavithrasha@gmail.com
Subject: [PATCH v1 2/4] perf mutex with nsinfo: Updated pthread_mutex_t usage
Date:   Wed, 27 Jul 2022 16:49:52 +0530
Message-Id: <20220727111954.105118-2-gpavithrasha@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727111954.105118-1-gpavithrasha@gmail.com>
References: <20220727111954.105118-1-gpavithrasha@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pavithra <gpavithrasha@gmail.com>

Updated usage of pthread_mutex_t with nsinfo
with the new wrapped lock(struct) in mutex.h
(remove data races).

Signed-off-by: pavithra <gpavithrasha@gmail.com>
---
 tools/perf/builtin-inject.c   | 6 +++---
 tools/perf/util/map.c         | 2 ++
 tools/perf/util/probe-event.c | 6 +++++-
 tools/perf/util/symbol.c      | 2 +-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 372ecb3e2c06..81eaed8da207 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -388,10 +388,10 @@ static int perf_event__repipe_id_index(struct perf_session *session,
 static int dso__read_build_id(struct dso *dso)
 {
 	if (dso->has_build_id)
-		return 0;
-
+		return 0;	
+		
 	if (filename__read_build_id(dso->long_name, dso->build_id,
-				    sizeof(dso->build_id)) > 0) {
+	                           sizeof(dso->build_id)) > 0) {
 		dso->has_build_id = true;
 		return 0;
 	}
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 5b83ed1ebbd6..2ef5fe0cc53c 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -214,8 +214,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			if (!(prot & PROT_EXEC))
 				dso__set_loaded(dso);
 		}
+		mutex_lock(&dso->lock);
 		dso->nsinfo = nsi;
 		dso__put(dso);
+		mutex_unlock(&dso->lock);
 	}
 	return map;
 out_delete:
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 91cab5f669d2..e527f2612ba4 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -38,6 +38,7 @@
 #include "session.h"
 #include "string2.h"
 #include "strbuf.h"
+#include "mutex.h"
 
 #include <subcmd/pager.h>
 #include <linux/ctype.h>
@@ -171,8 +172,11 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
 		struct map *map;
 
 		map = dso__new_map(target);
-		if (map && map->dso)
+		if (map && map->dso) {
+			mutex_lock(&map->dso->lock);
 			map->dso->nsinfo = nsinfo__get(nsi);
+			mutex_unlock(&map->dso->lock);
+		}	
 		return map;
 	} else {
 		return kernel_get_module_map(target);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 342be12cfa1e..4b711b13f915 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1619,7 +1619,7 @@ int dso__load(struct dso *dso, struct map *map)
 	struct nscookie nsc;
 	char newmapname[PATH_MAX];
 	const char *map_path = dso->long_name;
-
+	mutex_lock(&dso->lock);
 	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0;
 	if (perfmap) {
 		if (dso->nsinfo && (dso__find_perf_map(newmapname,
-- 
2.25.1

