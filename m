Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72E14B234C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348917AbiBKKfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:35:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349002AbiBKKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5446EEB0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h6-20020a253a06000000b0061de83305f2so17835365yba.19
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S56WfI2GmhqdGh7gnwplme1j2hJlUSzhW1pk4BgzSzk=;
        b=mBkM8iq3Hm5tOajbE77+PviE5ArQ7pZGE+5Ugb0NOHm0qOpTY+9CzOUeDRPjsBJZa2
         XJAyZiH/DGLk/fw3OkYbhHRo3Nx0liPl4cSn3x0QdlwM0c0KpMjrtdDGyGa1EMkpIqME
         9Jx1vrj11uenDjxwXLm/INJHnwFHZ5Ia4t5dTqw5hgpfyeERydmin5IUyHNvdxqbhAeK
         hXvaHL/HrL+JzFLtcVIcGrfojqASbRU9DWQ3sQd3f8jWVZddxTXnYlKGD1w/4b6xqbPS
         tHkgYuRdz76CtqpUZ3Gn+T3ujyG6QqmtyezxT5mZc4up9glakdspspm5XNcUt3pzDfPL
         VKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S56WfI2GmhqdGh7gnwplme1j2hJlUSzhW1pk4BgzSzk=;
        b=DFiglBt0VpNU9DQAmQz3xlvY6WM+U54zONhgGpV7DoOepDQlbLY8PWdTgp9R/eU2lb
         /ZiGyxiIqexcZM7QR941L3jKRVjosXgZuU7BsNC7F6TEfe2MGoSOpEF13dvcD6GI/jVf
         rXMIrcwMy/xJ+4tVwMBQOQbVwJuuG+ggMX0nECcPFCQtQ3ioXWGy5nx+CPVGc4zpsyII
         ppHLSzxmHaLozRhW24KMIH52fNtYpVxvZU3SmTVDx+nVTdcbo9YpI0dqlLW8Sy6a5AcG
         iAQ/jCovHs4nqhtQatckIdpqUVl/SVTagWgmeQBC7Lk/4TYTBOxy7hTiHewTRP80Filv
         vdbw==
X-Gm-Message-State: AOAM532zbsUm3IVnu9kg9KboMofrC+4iJro43wvuJ8Deae5Gy79xdvIL
        3402/6WSzuBvVrnFVbT/+NUYiU2t8LVA
X-Google-Smtp-Source: ABdhPJwprkLTWbcxJ/B2s7VtdaP+tgOQI2HcM/4+/pcP3Xw9gTr6wdo4zZnOZa29xxTuN1Ogb2EvP4dhCDHL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a05:6902:49:: with SMTP id
 m9mr660615ybh.104.1644575685585; Fri, 11 Feb 2022 02:34:45 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:03 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-11-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 10/22] perf map: Make map__contains_symbol args const
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now unmap_ip is const, make contains symbol const.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.c | 2 +-
 tools/perf/util/map.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index b98fb000eb5c..8bbf9246a3cf 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -516,7 +516,7 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 	return ip + map->reloc;
 }
 
-bool map__contains_symbol(struct map *map, struct symbol *sym)
+bool map__contains_symbol(const struct map *map, const struct symbol *sym)
 {
 	u64 ip = map->unmap_ip(map, sym->start);
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 212a9468d5e1..3dcfe06db6b3 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -152,7 +152,7 @@ static inline bool __map__is_kmodule(const struct map *map)
 
 bool map__has_symbols(const struct map *map);
 
-bool map__contains_symbol(struct map *map, struct symbol *sym);
+bool map__contains_symbol(const struct map *map, const struct symbol *sym);
 
 #define ENTRY_TRAMPOLINE_NAME "__entry_SYSCALL_64_trampoline"
 
-- 
2.35.1.265.g69c8d7142f-goog

