Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB54474B19
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbhLNSm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:42:56 -0500
Received: from foss.arm.com ([217.140.110.172]:35080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231756AbhLNSmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:42:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BA226D;
        Tue, 14 Dec 2021 10:42:54 -0800 (PST)
Received: from e124483.arm.com (unknown [10.57.33.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C57113F5A1;
        Tue, 14 Dec 2021 10:42:50 -0800 (PST)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/1] topdown with metrics
Date:   Tue, 14 Dec 2021 18:42:39 +0000
Message-Id: <20211214184240.24215-1-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

> BTW, I was looking at adding perf tool --topdown support for arm64. This will require L1 metricgroup support per core - see what I did here for our hisilicon platform already:
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> 
> I would like to add support for more cores. Generally the arm common events match up to the definitions here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-stat.txt#n400
> 
> Apart from frontend_bound - would you have an equivalent metric expression for this for these Neoverse cores?
> 
> [0] Note that I think that the divisor in the metric expressions is max uops that the core can deal with. 

Thanks for this, we’ve been working on how to support perf --topdown.
We’re still considering the right events/calculations on our CPUs.

To introduce the calculations in metrics jsons we would like this patch
to alter the --topdown option on arm64.

How does this fit with your solution?

Andrew


Andrew Kilroy (1):
  perf arm64: Implement --topdown with metrics

 tools/perf/arch/arm64/util/Build     |  1 +
 tools/perf/arch/arm64/util/topdown.c |  8 ++++++++
 tools/perf/builtin-stat.c            | 13 +++++++++++++
 tools/perf/util/metricgroup.c        | 12 ++++++++++++
 tools/perf/util/metricgroup.h        |  7 +++++++
 tools/perf/util/topdown.c            |  6 ++++++
 tools/perf/util/topdown.h            |  1 +
 7 files changed, 48 insertions(+)
 create mode 100644 tools/perf/arch/arm64/util/topdown.c

-- 
2.17.1

