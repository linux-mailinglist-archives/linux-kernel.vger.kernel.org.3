Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550AA484E24
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbiAEGP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbiAEGOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:55 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30564C061377
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u130-20020a254788000000b0060a9645f781so58767912yba.19
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1/7nME/op8w7Xw8Ct+c++XCwH/8x/MyevrC1VX7Tajk=;
        b=RJrLSnxc5JxUa6ZYoNewWHV+2aK8Z/muSepTRwKPqYKfEc+gAy7TukBfscpP1lIlA+
         lnKcMr1SS9sOindg9cEfikme79arHm0IKkB7dHoONl+A978BodnC66P8kBH4zCb0/WTo
         o62W+ZkcMBYkyFCMM8ETa/FO0P3XdA/YVC2n/VjMdnETl7atU98EmBeeB8YU5TJl/AFG
         /sJOL3tSF6P5SCcbsU4IfgGoTUX68u6hPSwMFhO0vhswgSClGbYdehxtbCEdejwK3Ocb
         EfCrj/BmcvF48idrFSKPQOGEBGD+XYTjHKzRMi7tMOw6sYJ5L4kkRuO5DUu3WNmW15m6
         PF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1/7nME/op8w7Xw8Ct+c++XCwH/8x/MyevrC1VX7Tajk=;
        b=W1gCmdrfO1pIz+ucQE1KiT0klkZhvo573U8JGE19MpOopEVYQXPdOM9SRHtiGvgkRr
         bmFkUM6dDJefJsaYMvzo4j6uIjWyqpag3aF/jclHm/UVICdIb/DsuhrSP1AldA9AZejf
         ByQkeZEUH/pwL0dXjGxLAYUrJOHhWkE4rQd48O4SVYC9e1vvpGXt30ga8rU2u5ObyWRq
         uyAX/A8pseOxrk6owIEBUFcrZaGjQ7wJBLelLnjqF3eHdKjr/rQHLdfOPq8WVlS9sajH
         YNJ0UjAYCguUOfGPWuu5Shbs76brmu9JQR5YwinKGcsalffS9hfeY7SYhhXTQjdzN8/t
         FYRA==
X-Gm-Message-State: AOAM533N/IzFEG7F6EA5kUQhcm/E9CLxuEuRw2JpXAVYAVPQ4uEu4qVJ
        hhHHQu1j/Xe6iySMRU4FhLDDIKYF7Cdl
X-Google-Smtp-Source: ABdhPJwsZz3Z7YaXUyXAOxmUXrnu/jXT+I7MJ/5bK9KlVVcutDnnM8+3CEoIwkwuNqXjluLZaWPbs0Z6igD3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:86c4:: with SMTP id
 y4mr51236247ybm.440.1641363292381; Tue, 04 Jan 2022 22:14:52 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:25 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-23-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 22/48] perf cpumap: Trim the cpu_aggr_map
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_aggr_map__new removes duplicates, when this happens shrink the
array.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index f1d76a8e92e8..2779474f39db 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -185,7 +185,15 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 			c->nr++;
 		}
 	}
-
+	/* Trim. */
+	if (c->nr != cpus->nr) {
+		struct cpu_aggr_map *trimmed_c =
+			realloc(c,
+				sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
+
+		if (trimmed_c)
+			c = trimmed_c;
+	}
 	/* ensure we process id in increasing order */
 	qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
 
-- 
2.34.1.448.ga2b2bfdf31-goog

