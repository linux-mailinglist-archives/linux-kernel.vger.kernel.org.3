Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF225481A32
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhL3HVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbhL3HVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:07 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C42C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v189-20020a2561c6000000b0060b5814a17eso26923307ybb.22
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dtLecDqeKsVhu8ABFSrCuZx030SIijpylbO9HpLxlsg=;
        b=KHZfZvYAwA/IYaOjhai7vtInLxNNN3S9V+/p7Pw5a+z9RAtEqsehux4DGdLx4VhvRT
         lx08Ihah9sKF6KPqndO2v13LhgiYbjOp/PtAAtuDRbE0I+yZqFAiFrx/1D4l50Btm+aH
         LaCAyv/7neOqqe/MCaSjbUdtzBPt0K7nbvug6vvmC8wLAscdtQFykMXf00q3lot1pmU6
         TaXILKlaHmZam33/JQ/lQbw2o/zeoSbEbkxC2+aIAxdpyxBZIoTXNqxyVavb/yTrDvEE
         lQaEDyiKyuf1gh92/eBurKqm58eZmc5lEtVefKTfeVth+PzIxpgDqa9pze1+U3Y1t76l
         TDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dtLecDqeKsVhu8ABFSrCuZx030SIijpylbO9HpLxlsg=;
        b=w5YRDx0qadXbqrjBvGfqkHiHB67ubX5P72Y0pxLwP6r1Pn8DsdSTMjfmlAKCGhHJuG
         BqFpDhOq2Orhk4FG0NMQj2/aK4Z9lnH/eI6WoutHdDo4rf8+Aa6kI+VYrcf7UsX9rx19
         l1XDCbNsqaguvufx17NmFltnQa8nrLv7FxIZ+wPndhF4Z1YhI0WOlyrovVHu7rZQBkWp
         JB3UDpz8lT8i7JU7xMvdJC5zJdqYhYsmb06TPZe/Vh5aC1xSU34oz6F3pvGEYwOE79HW
         K3QbNKhpZ+z6iR2EPao6Wb7ciMQrFa5HNbERt2fTJXlhZZx0DZDv3ZPJTsPCHoVHVPfj
         l/Aw==
X-Gm-Message-State: AOAM532SGDwEtFy4aPu4vrM9/YZeJsx8NAXV3e/NxzIBc8YElOsrMN5K
        MhElPHyu01f7YwZ1wsnNlc9o07bbeQuz
X-Google-Smtp-Source: ABdhPJzwyaiVjQKhyBRyvuUBgewdamGno0nty6HvW40cYTOPvP67uzaLSId11G5eVh0iGsfdFuOgj+Xy95mP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:6d06:: with SMTP id
 i6mr7244528ybc.444.1640848866418; Wed, 29 Dec 2021 23:21:06 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:53 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-13-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 11/48] perf cpumap: Add comments to aggr_cpu_id
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

This code is already tested in topology.c.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index f0121dd4fdcb..edd93e1db36a 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -7,11 +7,20 @@
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
+/** Identify where counts are aggregated, -1 implies not to aggregate. */
 struct aggr_cpu_id {
+	/** A value in the range 0 to number of threads. */
 	int thread;
+	/** The numa node X as read from /sys/devices/system/node/nodeX. */
 	int node;
+	/**
+	 * The socket number as read from
+	 * /sys/devices/system/cpu/cpuX/topology/physical_package_id.
+	 */
 	int socket;
+	/** The die id as read from /sys/devices/system/cpu/cpuX/topology/die_id. */
 	int die;
+	/** The core id as read from /sys/devices/system/cpu/cpuX/topology/core_id. */
 	int core;
 };
 
-- 
2.34.1.448.ga2b2bfdf31-goog

