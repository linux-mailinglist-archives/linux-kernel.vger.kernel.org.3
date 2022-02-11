Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5494B2346
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbiBKKe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:34:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348970AbiBKKek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80213EB5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g205-20020a2552d6000000b0061e1843b8edso16800310ybb.18
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C+DOP43E99Vgp1ROj45FPpHXIORfM/ghJ3TzgVy+YNU=;
        b=NLJbtd5YhVa7x/yeTNEjfREFwLmEaOsF4D0AVDKgQdH59TXGtiioclRIC3xmPq2QpF
         9474cJJlZEhnjplBaeCQd0En4hEPGeWJbYJh7nTS4soJbzzqXZumTfxSdtKkUVAcU2rj
         2+h4glwZrPFB6YwF7f2/OgGlt93moxMoyRR/bfYmYT+CskCpuQpO6FZV6/19d7C5GZ3B
         OoB7aNU8HueLULQew+tI26evSNTQuRaiKLauae3pYOdGaNZQtsANUXosbAllxa4FVAUR
         Kwrrp+IBMrKbpSFawC/oyJRM+9IX4ue7MlbfleqIXXV65rDZLtG9WKXwJBy1A4Eh4v4W
         nNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C+DOP43E99Vgp1ROj45FPpHXIORfM/ghJ3TzgVy+YNU=;
        b=YAPwU4rLlNXnC8/VicWhOrhgC7duqdbItVvmrwxhsPA7Ta9ssgXxroWiktV3wd7WVR
         UbsydAiNMSxjPdsfAaFE00aw4ih26wbKNH6aUO8h/Vskxfbu5dBYOdosy/WDCmIv7CPe
         49Lf8Pn14lDvAnp3K2pwApk8mqFwKAJeRoTSUWV2nsa6vxNvDd9V4ghbA+I+ESBEZOGY
         MtHTOK3g3Hecq2IvheGpjIdP7+Lx/fbtwuaKknnz01eVtagbfiUgg73UT+EMQfuqQ1FV
         /wezMVRUHTE6glwzwztbqUtV60qOWy/2YswoBLUXIMr0QpXxpkxvmLh9rjawMVZKLR7y
         1jdQ==
X-Gm-Message-State: AOAM530oEXBvaE2kQPuP48p8sIJJIYsD6TEhxvsfsAerIZoEBfbIu+Ps
        p1tqgxOHerUffehmDFQJCy2Pk+age5GY
X-Google-Smtp-Source: ABdhPJx37ZV+DBqNto4kqpR7iMyd0RvvVxnoSEdbFJq8X88sRQjetmdRWiYHo8vRcCRMURbz07A1BGEshAli
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a25:2107:: with SMTP id
 h7mr650095ybh.513.1644575677752; Fri, 11 Feb 2022 02:34:37 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:00 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-8-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 07/22] perf maps: Reduce scope of init and exit
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

Now purely accessed through new and delete, so reduce to file scope.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.c  | 4 ++--
 tools/perf/util/maps.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index ae99b52502d5..4d1de363c19a 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -527,7 +527,7 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 	return ip + map->reloc;
 }
 
-void maps__init(struct maps *maps, struct machine *machine)
+static void maps__init(struct maps *maps, struct machine *machine)
 {
 	maps->entries = RB_ROOT;
 	init_rwsem(&maps->lock);
@@ -616,7 +616,7 @@ static void __maps__purge(struct maps *maps)
 	}
 }
 
-void maps__exit(struct maps *maps)
+static void maps__exit(struct maps *maps)
 {
 	down_write(&maps->lock);
 	__maps__purge(maps);
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 3dd000ddf925..7e729ff42749 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -60,8 +60,6 @@ static inline struct maps *maps__get(struct maps *maps)
 }
 
 void maps__put(struct maps *maps);
-void maps__init(struct maps *maps, struct machine *machine);
-void maps__exit(struct maps *maps);
 int maps__clone(struct thread *thread, struct maps *parent);
 size_t maps__fprintf(struct maps *maps, FILE *fp);
 
-- 
2.35.1.265.g69c8d7142f-goog

